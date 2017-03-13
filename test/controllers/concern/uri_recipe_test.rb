require 'test_helper'
require 'active_support/concern'

class ConcernTest < ActiveSupport::TestCase
  include URIRecipes

  # Test Pixnet parser

  test 'should return pixnet message with URI' do
    post_id = Faker::Number.number(10)
    user_name = Faker::Internet.user_name(nil, %w(_))
    url = "http://#{user_name}.pixnet.net/blog/post/#{post_id}"
    createDate = Faker::Time.between(DateTime.now - 1000, DateTime.now)
                            .beginning_of_minute
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
    expected_data = {
      userName: user_name,
      postId: post_id,
      createDate: createDate
    }
    assert_equal(expected_data[:userName],
                 pixnet_parser(url)[:userName],
                 'The parser should returns hash data')
    assert_equal(expected_data[:postId],
                 pixnet_parser(url)[:postId],
                 'The parser should returns hash data')
    assert_equal(DateTime.parse(expected_data[:createDate].to_s),
                 pixnet_parser(url)[:createDate],
                 'The parser should returns hash data')
  end
end
