class FetchServices

  def self.current
    statuses = []
    with_each_service do |klass|
      status = ServiceStatus.new(JSON.parse(Rails.cache.read(klass.name))) if Rails.cache.read(klass.name)
      statuses << status
    end
    statuses
  end

  def self.fetch
    statuses = []
    with_each_service do |klass|
      previous_status = JSON.parse(Rails.cache.read(klass.name)) if Rails.cache.read(klass.name)
      status = klass.status
      statuses << status
      Rails.cache.write(status.name, status.to_json)

      if previous_status && previous_status['up'] != status.up
        puts "STATUS CHANGED!"
        # Send emails
        # Add log entry
      end
    end
    statuses
  end

  private

  def self.with_each_service
    Dir.entries(Rails.root.to_s + "/app/models/external_services").keep_if { |file| /.rb$/.match(file) }.each do |file|
      klass = ("ExternalServices::" + /([a-zA-Z]+).rb/.match(file)[1].classify).constantize
      yield klass
    end
  end

end
