class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user 

  def take_ride
    if enough_tickets? && tall_enough?
      begin_ride 
    elsif !tall_enough? && enough_tickets?
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    elsif !enough_tickets? && tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif !enough_tickets? && !tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    end 
  end 

  def begin_ride
      updated_ticket_number = self.user.tickets - self.attraction.tickets 
      updated_nausea = self.user.nausea + self.attraction.nausea_rating
      updated_happiness = self.user.happiness + self.attraction.happiness_rating 
      self.user.update(
        :tickets => updated_ticket_number,
        :nausea => updated_nausea,
        :happiness => updated_happiness
        )
      "Thanks for riding the #{self.attraction.name}!"
  end 

  def enough_tickets?
    self.user.tickets >= self.attraction.tickets
  end 

  def tall_enough?
    self.user.height >= self.attraction.min_height
  end 

end
