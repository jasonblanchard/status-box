class UpdateServicesWorker
  #include SuckerPunch::Job

  def later(sec)
    after(sec) do
      puts "Pinging services"
      puts FetchServices.fetch
      UpdateServicesWorker.new.async.later(sec)
    end
  end
end
