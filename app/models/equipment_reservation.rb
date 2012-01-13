class EquipmentReservation
  include Mongoid::Document
  field :name, type: String
  field :from, type: DateTime
  field :to, type: DateTime
  field :user, type: String
  field :reservations, type: Array, default: []

  attr_reader :uuids

  def self.in(from, to)
    if from.present? && to.present?
      (where(:from.gte => from, :from.lt => to) + where(:to.gte => from, :to.lt => to)).uniq
    elsif from.present?
      (where(:from.gte => from) + where(:to.gte => from)).uniq
    elsif to.present?
      (where(:from.lt => to) + where(:to.lt => to)).uniq
    else
      all
    end
  end

  def element_uuids= uuids
    @uuids = uuids
    self[:reservations] ||= []
    self[:reservations] << sanititzed_uuids
    self[:reservations].flatten!
  end

  private

  def sanititzed_uuids
    remove_zeros!
    map_devices!
    generate_reservations
  end

  def remove_zeros!
    @uuids.reject!{ |uuid, count| count == '0' }
  end

  def map_devices!
    @uuids = @uuids.map{|uuid, count| [Device.find(uuid), count.to_i] }
  end

  def generate_reservations
    @uuids.map{ |device, count| {kind: device.kind, company: device.company, model: device.model, count: count} }
  end

end
