class Device
  def cast_to_model
    Model.new(model, company, kind)
  end
end

class Model
  attr_accessor :model, :company, :kind, :users, :available_devices, :total_devices

  def initialize(model='', company='', kind='')
    @model = model
    @company = company
    @kind = kind
    @total_devices = 0
    @available_devices = 0
    @users = []
  end

  def self.all
    from_devices(Device.all)
  end

  def self.from_devices devices
    {}.tap do |models|
      devices.each do |device|
        key = "#{device.kind}_#{device.company}_#{device.model}"
        models[key] ||= device.cast_to_model
        models[key].total_devices += 1
        models[key].available_devices += 1
      end
    end.values.flatten
  end

  def available_devices
    @available_devices < 0 ? 0 : @available_devices
  end

  # # how many devices are available
  # (
  #   # reservations where start is inside
  #   EquipmentReservation.where(:from.gte => from, :from.lt => to) +
  #   # or end is inside
  #   EquipmentReservation.where(:to.gte => from, :to.lt => to)
  # ).uniq.each do |reservation|
  #   reservation.reservations.each do |r|
  #     key = "#{r['kind']}_#{r['company']}_#{r['model']}"
  #     device_count[key][:available] -= r['count'].to_i
  #     device_count[key][:users] << reservation.user
  #   end
  # end


  # models = {}
  # # uniq by model and return attributes only
  # devices.each do |d|
  #   key = "#{d.kind}_#{d.company}_#{d.model}"
  #   next if models[key].present?
  #   if (available = device_count[key][:available]) < 0
  #     available = 0
  #   end
  #   models[key] = {
  #     total: device_count[key][:total], available: available,
  #     model: d.model, company: d.company, kind: d.kind, uuid: d._id.to_s,
  #     users: device_count[key][:users]
  #   }
  # end

  # grouping
  # models = models.values
  # fubar = {}
  # kinds = models.uniq{|e| e[:kind]}.map{|e| e[:kind]}.sort
  # kinds.each do |kind|
  #   fubar[kind] = {}
  #   companies = models.select{ |e| e[:kind] == kind }
  #     .uniq{|e| e[:company]}.map{|e| e[:company]}.sort
  #   companies.each do |company|
  #     fubar[kind][company] = models
  #       .select{ |e| e[:kind] == kind && e[:company] == company }
  #   end
  # end
  # fubar
  def self.in from, to
    Model.all.tap do |models|
      EquipmentReservation.in(from, to).each do |reservation|
        reservation.reservations.each do |r|
          models
            .find{|model| model.equal_to_reservation(r) }
            .tap do |model|
              model.apply_reservation(r, reservation.user)
          end
        end
      end
    end
  end

  def ==(other)
    return false unless other.is_a?(self.class)
    self.model == other.model && self.company == other.company && self.kind == other.kind
  end

  def apply_reservation(reservation, user)
    @available_devices -= reservation['count']
    users << user
  end

  def equal_to_reservation(reservation)
    return false unless reservation.is_a?(Hash)
    kind == reservation['kind'] && company == reservation['company'] && model == reservation['model']
  end

end
