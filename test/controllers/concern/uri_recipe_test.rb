require 'test_helper'
require 'active_support/concern'

class ConcernTest < ActiveSupport::TestCase
  include URIRecipes
  test 'should return pixnet message in URI params' do
    assert(pixnet_parser)
  end
end
