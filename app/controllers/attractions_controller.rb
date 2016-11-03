class AttractionsController < ApplicationController

  def create
    @attraction = Attraction.new(attraction_params)
    @attraction.save
    redirect_to attraction_path(@attraction)
  end

  private

    def attraction_params
      require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
    end

end
