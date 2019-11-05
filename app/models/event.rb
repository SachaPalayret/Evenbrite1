class Event < ApplicationRecord
    require 'date'

    validates :start_date, presence: true
    validate :start_date_is_past
    validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
    validate :divisible_by_five
    validates :title, presence: true, length: { in: 5..140 }
    validates :description, presence: true, length: { in: 20..1000}
    validates :price, presence: true
    validates_inclusion_of :price, :in => 1..1000
    validates :location, presence: true


    belongs_to :user
    has_many :attendances
    has_many :participants, through: :attendance


#######
private
#######

def start_date_is_past
  return if start_date.blank?

  if start_date < Date.today
    errors.add(:end_date, "cannot be in the past") 
  end 
end

def divisible_by_five
    if (self.duration % 5) != 0
      self.errors[:base] << "Number must be divisible by 5!"
    end
end

    
  

end
