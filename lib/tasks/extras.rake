namespace :properties do

  desc 'Sync Properties from a XML file'
  task :sync => :environment do |t, args|
    raise ArgumentError unless ENV['XML_PATH']

    xml           = File.read(ENV['XML_PATH'])
    source        = Source.find_by(code: ENV['SOURCE'])
    property_sync = Property::Sync.new(xml, source)

    property_sync.perform
  end

end

