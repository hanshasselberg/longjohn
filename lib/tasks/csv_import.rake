namespace :csv do
  desc 'Import csv'
  task :import => :environment do
    File.open("doc/datenbank-digital-hans_new.csv", "r").lines do |line|
      barcode, serial, model, company, kind = line.split(",")[0,5].map(&:strip)
      next if kind == "Art" || kind == ""
      barcode = "%06d" % barcode
      Device.create(
        barcode: barcode, model: model, company: company, kind: kind
      )
    end
  end

  desc "Update csv"
  task :update => :environment do
    updated_devices = []

    # update/create
    File.open("doc/datenbank_update_19_06_2012_inventar.csv", "r").lines do |line|
      barcode, serial, model, company, kind = line.split(",")[0,5].map(&:strip)
      next if kind == "Art" || kind == ""
      barcode = "%06d" % barcode.to_i
      device = Device.where(barcode: barcode).first
      if device
        device.update_attributes(model: model, company: company, kind: kind)
      else
        device = Device.create(
          barcode: barcode, model: model, company: company, kind: kind
        )
      end
      updated_devices << device
    end

    # delete
    (Device.all.entries - updated_devices).map(&:destroy)
  end
end
