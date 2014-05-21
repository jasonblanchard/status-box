class FetchServices

  def self.current
    statuses = []
    with_each_service do |klass|
      status = OpenStruct.new(JSON.parse(Rails.cache.read(klass.name)))
      statuses << status
    end
    statuses
  end

  def self.fetch
    statuses = []
    with_each_service do |klass|
      previous_status = JSON.parse(Rails.cache.read(klass.name))
      status = klass.status
      statuses << status
      Rails.cache.write(status.name, status.to_json)

      if previous_status['table']['up'] != status.up
        puts "STATUS CHANGED!"
      end
    end
    statuses
  end

  private

  def self.with_each_service
    Dir.entries(Rails.root.to_s + "/app/models/services").keep_if { |file| /.rb$/.match(file) }.each do |file|
      klass = ("Services::" + /([a-zA-Z]+).rb/.match(file)[1].classify).constantize
      yield klass
    end
  end

end
