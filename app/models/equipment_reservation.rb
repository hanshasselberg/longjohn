class EquipmentReservation
  include Mongoid::Document
  field :name, :type => String
  field :from, :type => Date
  field :to, :type => Date
end
