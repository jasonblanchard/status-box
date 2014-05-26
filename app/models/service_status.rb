class ServiceStatus
  attr_accessor :name, :up

  def initialize(data)
    data.symbolize_keys!
    @name = data[:name]
    @up = data[:up]
  end
end
