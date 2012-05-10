namespace :csv do

  desc 'Import csv'
  task :import => :environment do
    File.open("doc/datenbank-digital-hans_new.csv", "r").lines do |line|
      barcode, model, company, kind = line.split(",")[1,4].map(&:strip)
      next if kind == "Art"
      next if barcode == "NULL"
      Device.create(
        barcode: barcode, model: model, company: company, kind: kind
      )
    end
  end

end
