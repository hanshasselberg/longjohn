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

end
