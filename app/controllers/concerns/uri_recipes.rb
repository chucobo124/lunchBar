module URIRecipes
  # URI Recipe is going to parse the uri to return the id and other profile in
  # URI which is needed. The return type must be a hash.
  extend ActiveSupport::Concern

  # The goal of this concern to prvide the profile formate the sample is like:
  # {
  #   userName: 'test123',
  #   postId: '098765323456789',
  #   createDate: TimeObject,
  #   otherMessage: <value>
  # }

  # Return message to match the profile formate. Parsing by Nokogiri
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
