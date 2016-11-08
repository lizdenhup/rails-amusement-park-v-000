class RidesController < ApplicationController

  def new
    @ride = Ride.new(
      :user_id => params[:user_id],
      :attraction_id => params[:attraction_id]
      )
    @ride.save 
  end

end
