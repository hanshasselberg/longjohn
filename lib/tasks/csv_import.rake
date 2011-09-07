namespace :csv do

  desc 'Import csv'
  task :import => :environment do
    if ENV.include?("file") && !ENV["file"].blank?
      File.open(ENV["file"], "r") do |infile|
        while (line = infile.gets)
          barcode, model, company, kind = line.split(",")[1,4].map(&:strip)
          Device.create(
            barcode: barcode, model: model, company: company, kind: kind
          )
        end
      end
    end
  end

end
