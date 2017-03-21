class AttendantsController < ApplicationController
  # - Attendant Controller are going to lead our user to the correct page which
  # website we created.
  #
  # We need to make a reservation before to make Attendant knows where you are.
  # Then after user visit lead path. Attendant will going to lead our user to
  # the correct page.

  include URIRecipes
  before_action do
    @error = {
      reffererInCorrect: 'My apologies! Your URI is not correct.',
      noReservation: 'My apologies! You don\'t have any reservation.'
    }
  end

  # Lead User by params[:id] and check params[:id]'s reservation. If true lead
  # user to the correct page.
  #
  # @return [302 Redirect] redirect to the correct page
  def lead
    id = params[:id]
    previous_url = request.env['HTTP_REFERER']
    profile_message = pixnet_parser(previous_url)
    if previous_url.blank? || profile_message.blank?
      return render json: { error: @error[:reffererInCorrect] }
    end
    reservation = Reservation.find_by_name(id)
    if reservation.blank?
      return render json: { error:  @error[:noReservation] }
    else
      redirect_path = 'http://'+reservation.domain + '/' +
        profile_message[:createDate].strftime('%m-%d-%Y-%H%M')
      redirect_to redirect_path
    end
  end
end
