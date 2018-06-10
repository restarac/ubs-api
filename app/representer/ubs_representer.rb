require 'roar/decorator'
require 'roar/json'

class UbsRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :address, getter: -> (_) do
    address.street
  end
  property :city, getter: -> (_) do
    address.city
  end

  property :phone
  
  nested :geocode do
    property :latitude, as: :lat
    property :longitude, as: :long
  end

  property :score, as: :scores do
    property :size
    property :adaptation_for_seniors
    property :medical_equipment
    property :medicine
  end
end

#      {  
#         id:39860,
#         name:"UBS REAL PQ PAULO MANGABEIRA ALBERNAZ FILHO",
#         address:"RUA BARAO MELGACO",
#         city:"São Paulo",
#         phone:"1137582329",
#         geocode:{  
#            lat:-23.6099946498864,
#            long:-46.7057347297655
#         },
#         scores:{  
#            size:3,
#            adaptation_for_seniors:3,
#            medical_equipment:1,
#            medicine:3
#         }
#      }
