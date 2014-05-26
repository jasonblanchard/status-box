class ExternalServices::Transloadit

  def self.status
    response = HTTParty.get('http://api2.transloadit.com/')
    status = JSON.parse(response)
    status = status['ok'] == "SERVER_ROOT"
    ServiceStatus.new({:name => name, :up => status})
  end

  def self.name
    "Transloadit"
  end

end
