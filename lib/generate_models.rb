module GenerateModels

  def self.process devices

    # count how many devices are there per model
    device_count = Hash.new(0)
    devices.each { |d| device_count[d.model] += 1 }

    models = {}
    # uniq by model and return attributes only
    devices.each do |d|
      next if models[d.model].present?
      models[d.model] = {
        total: device_count[d.model], model: d.model,
        company: d.company, kind: d.kind, uuid: d._id
      }
    end

    models.values

  end

end
