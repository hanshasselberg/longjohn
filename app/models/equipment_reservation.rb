class EquipmentReservation
  include Mongoid::Document
  field :name, :type => String
  field :from, :type => DateTime
  field :to, :type => DateTime
end
