class Score < ApplicationRecord
  validates_presence_of :size, :adaptation_for_seniors, :medical_equipment, :medicine
end
