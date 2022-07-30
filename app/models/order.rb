class Order < ActiveRecord::Base
  belongs_to :user
  has_many :coffees, through: :user
end
