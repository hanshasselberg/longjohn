module GenerateModels

  def self.process from, to
    devices = Device.all

    # count how many devices are there per model
    device_count = {}
    devices.each do |d|
      key = "#{d.kind}_#{d.company}_#{d.model}"
      device_count[key] ||= {total: 0, available: 0, users: []}
      device_count[key][:total] += 1
      device_count[key][:available] += 1
    end

    # how many devices are available
    (
      # reservations where start is inside
      EquipmentReservation.where(:from.gte => from, :from.lt => to) +
      # or end is inside
      EquipmentReservation.where(:to.gte => from, :to.lt => to)
    ).uniq.each do |reservation|
      reservation.reservations.each do |r|
        key = "#{r['kind']}_#{r['company']}_#{r['model']}"
        device_count[key][:available] -= r['count'].to_i
        device_count[key][:users] << reservation.user
      end
    end


    models = {}
    # uniq by model and return attributes only
    devices.each do |d|
      key = "#{d.kind}_#{d.company}_#{d.model}"
      next if models[key].present?
      if (available = device_count[key][:available]) < 0
        available = 0
      end
      models[key] = {
        total: device_count[key][:total], available: available,
        model: d.model, company: d.company, kind: d.kind, uuid: d._id.to_s,
        users: d.users.uniq
      }
    end

    models = models.values
    fubar = {}
    kinds = models.uniq{|e| e[:kind]}.map{|e| e[:kind]}.sort
    kinds.each do |kind|
      fubar[kind] = {}
      companies = models.select{ |e| e[:kind] == kind }
        .uniq{|e| e[:company]}.map{|e| e[:company]}.sort
      companies.each do |company|
        fubar[kind][company] = models
          .select{ |e| e[:kind] == kind && e[:company] == company }
      end
    end
    fubar

  end

end
