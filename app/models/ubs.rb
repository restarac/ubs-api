class Ubs < ApplicationRecord
  belongs_to :address
  belongs_to :score, dependent: :destroy
  
  validates_presence_of :name, :phone, :score, :address
end
