class Services::Tokbox

  def self.status
    doc = Nokogiri::HTML(open('http://status.opentok.com/'))
    status = doc.css('#systemStatus h3').text == "Running"

    OpenStruct.new(:name => name, :up => status)
  end

  def self.name
    "Tokbox"
  end
end
