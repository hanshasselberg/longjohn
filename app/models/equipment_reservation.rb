class EquipmentReservation
  include Mongoid::Document
  field :name, type: String
  field :from, type: DateTime
  field :to, type: DateTime
  field :user, type: String
  field :reservations, type: Array, default: []

  def element_uuids= uuids
    self[:reservations] << uuids
      .map{ |uuid, count| [Device.find(uuid), count.to_i] }
      .map{ |device, count|
        {kind: device.kind, company: device.company, model: device.model, count: count}
      }
    self[:reservations]
  end

end
