require 'test_helper'

class AttendantControllerTest < ActionDispatch::IntegrationTest
  # Test Lead method
  test 'should redirect to the correct page' do
    createDate = Faker::Time.between(DateTime.now - 1000, DateTime.now)
    mock_body = "<ul class=\"article-head\">
                  <li class=\"publish\">
                      <span class=\"month\">#{createDate.strftime('%b')}</span>
                      <span class=\"date\">#{createDate.strftime('%d')} </span>
                      <span class=\"day\">#{createDate.strftime('%a')} </span>
                      <span class=\"year\">#{createDate.strftime('%Y')} </span>
                      <span class=\"time\">#{createDate.strftime('%R')}</span>
                  </li>
                 </ul>".html_safe
    reservation = reservations(:pixnet)
    post_id = Faker::Number.number(10)
    stub_request(:get, "http://#{reservation.name}.pixnet.com/#{post_id}")
      .with(headers: { 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: mock_body, headers: {})
    get attendants_lead_url(reservation.name), headers: {
      'HTTP_REFERER' => "http://#{reservation.name}.pixnet.com/#{post_id}"
    }
    assert_redirected_to 'http://' + reservation.domain + '/' +
                         createDate.strftime('%m-%d-%Y-%H%M')
  end

  test 'should return error message when referer is blank' do
    reservation = reservations(:pixnet)
    expect_path = 'http://abcd.hello.com/2014-03-06'
    get attendants_lead_url(reservation.name)
    subject = JSON.parse(@response.body)
    assert_equal subject['error'], 'My apologies! Your URI is not correct.'
  end
end
