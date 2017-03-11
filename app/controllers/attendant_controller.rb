class AttendantsController < ApplicationController
  # - Attendant Controller are going to lead our user to the correct page which
  # website we created.
  #
  # We need to make a reservation before to make Attendant knows where you are.
  # Then after user visit lead path. Attendant will going to lead our user to
  # the correct page.
  include URIRecipe
  before_action do
    @error = {
      reffererInCorrect: 'My apologies! Your URI is not correct.',
      noReservation: 'My apologies! You don\'t have any reservation.'
    }
  end

  def lead
    previous_url = request.env['HTTP_REFERER']
    pixNet_user = URI('http://jimmyts.pixnet.net/blog/post/210309271').hostname
    pixNet_user.split('.')[0]
    pixnet_parser(uri)
    render @error[:reffererInCorrect] if previous_url.blank?
    Reservation.find_by_name(:name)
    if checkIsReserved()
      redirectToCorrectPage()
    else
      render @error[:noReservation]
    end
  end

end
