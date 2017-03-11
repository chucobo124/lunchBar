require 'test_helper'
require 'active_support/concern'

class ConcernTest < ActiveSupport::TestCase
  include URIRecipes

  # Test Pixnet parser

  test 'should return pixnet message with URI' do
    post_id = Faker::Number.number(10)
    user_name = Faker::Internet.user_name(nil, %w(_))
    url = "http://#{user_name}.pixnet.net/blog/post/#{post_id}"
    createDate = Faker::Date.between(10.days.ago, Date.today)
    mock_body = "<ul class=\"article-head\">
                  <li class=\"publish\">
                      <span class=\"month\">#{createDate.strftime('%b')}</span>
                      <span class=\"date\">#{createDate.strftime('%d')} </span>
                      <span class=\"day\">#{createDate.strftime('%a')} </span>
                      <span class=\"year\">#{createDate.strftime('%Y')} </span>
                      <span class=\"time\">#{createDate.strftime('%R')}</span>
                  </li>
                 </ul>".html_safe
    stub_request(:get, url)
      .with(headers: { 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: mock_body, headers: {})
    @expected_data = {
      userName: user_name,
      postId: post_id,
      createDate: createDate
    }
    assert_equal(pixnet_parser(url), @expected_data, 'The parser should returns hash data')
  end
end
