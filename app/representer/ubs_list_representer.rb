require 'roar/decorator'
require 'roar/json'

class UbsListRepresenter < Roar::Decorator
  include Roar::JSON

  property :current_page
  property :per_page
  property :total_entries
  
  collection :entries, decorator: UbsRepresenter
end

# {  
#   current_page:1,
#   per_page:1,
#   total_entries:37690,
#   entries:[  
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
#   ]
# }
