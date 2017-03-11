require 'test_helper'

class AttendantControllerTest < ActionDispatch::IntegrationTest
  # Test Lead method

  test 'should redirect to the correct page' do
    expect_path = 'http://abcd.hello.com/2014-03-06'
    get attendant_lead_us_url, {}, 'HTTP_REFERER' => 'http://abcd.hello.com'
    assert_redirected_to expect_path
  end

  test 'should return error message when referer is blank' do
    expect_path = 'http://abcd.hello.com/2014-03-06'
    get attendant_lead_us_url
    assert_equal 'My apologies! You don\'t have any reservation.', @response.body
  end
end
