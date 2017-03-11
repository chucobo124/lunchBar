module URIRecipes

  # URI Recipe is going to parse the uri to return the id and other profile in
  # URI which is needed. The return type must be a hash.
  extend ActiveSupport::Concern
  def pixnet_parser(uri)
    true
  end
end
