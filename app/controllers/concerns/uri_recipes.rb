module URIRecipes
  # URI Recipe is going to parse the uri to return the profile message
  # The profile format are like etc:
  # {
  #   userName: 'test123',
  #   postId: '098765323456789',
  #   createDate: TimeObject,
  #   otherMessage: <value>
  # }

  extend ActiveSupport::Concern

  # Return message to match the profile format. Parsing by Nokogiri
  #
  # @param [String] uri The user blog path
  # @return [Hash] profile message
  def pixnet_parser(uri)
    profile_message = {}
    uri = URI(uri)
    pixnet_article = Nokogiri::HTML(Net::HTTP.get(uri))
    profile_message[:userName] = uri.hostname.split('.')[0]
    profile_message[:postId] = uri.path.split('/').last
    profile_message[:createDate] =
      Date.parse(pixnet_article.css('ul.article-head li.publish').text)
    profile_message
  end
end
