class EquipmentReservation
  include Mongoid::Document
  field :name, type: String
  field :from, type: DateTime
  field :to, type: DateTime
  field :user, type: String
  field :reservations, type: Array, default: []
  field :pickups, type: Array, default: []

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

  def reservation_entries= reservation_entries
    self[:reservations] ||= []
    self[:reservations] << generate_reservations(remove_zeros(reservation_entries))
    self[:reservations].flatten!
  end

  private

  def remove_zeros(reservation_entries)
    reservation_entries.reject{ |entry| [nil, '0'].include?(entry[:count])}
  end

  def generate_reservations(reservation_entries)
    reservation_entries.map do |entry|
      { kind: entry[:kind], company: entry[:company], model: entry[:model], count: entry[:count] }
    end
  end
end
