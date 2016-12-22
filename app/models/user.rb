class User < ActiveRecord::Base
  has_secure_password 
  has_many :rides
  has_many :attractions, through: :rides 

  # validates_presence_of :name, :password 

  def mood
    if self.nausea < self.happiness 
      mood = "happy"
    elsif self.happiness < self.nausea
      mood = "sad"
    end 
  end 

end
