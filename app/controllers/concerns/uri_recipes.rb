module URIRecipes
  # URI Recipe is going to parse the uri to return the profile message
  # The profile format are like etc:
  # {
  #   userName: 'test123',
  #   postId: '098765323456789',
  #   createDate: TimeObject,
  #   redirect_path: https://www.example.com
  #   otherMessage: <value>
  # }
  extend ActiveSupport::Concern
  # Retrun pixnet user profile by pixnet path
  #
  # @param [String] uri The user blog path
  # @return [Hash] profile message
  def pixnet_parser(uri)
    profile_message = {}
    return if uri.blank?
    uri = URI(uri)
    pixnet_article = Nokogiri::HTML(Net::HTTP.get(uri).html_safe)
    profile_message[:userName] = uri.hostname.split('.')[0]
    profile_message[:postId] = uri.path.split('/').last
    profile_message[:createDate] =
      DateTime.parse(pixnet_article.css('ul.article-head li.publish').text)
    profile_message
  end
end
