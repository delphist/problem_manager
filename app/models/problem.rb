class Problem < ActiveRecord::Base
  belongs_to :subject
  belongs_to :status

  validates :subject, :presence => true
  validates :status, :presence => true
  validates :email, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :vk, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :link, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :address, :presence => true, :length => { :in => 2..255 }
  validates :address_latitude, :presence => true
  validates :person, :presence => true, :length => { :in => 2..255 }
  validates :description, :presence => true, :length => { :in => 2..60000 }
  validates :comment, :presence => true, :length => { :in => 2..255 }
  validates :rating, :presence => true, :numericality => true, :inclusion => { :in => 0..10 }

  def distance_car_km
    if distance_car.nil?
      ""
    else
      (distance_car / 1000).round(2)
    end
  end

  def distance_km
    if distance.nil?
      ""
    else
      (distance / 1000).round(2)
    end
  end
end
