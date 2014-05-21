class StatusesController < ApplicationController

  def index
    @statuses = FetchServices.current
  end

  def update
    @statuses = FetchServices.fetch
    redirect_to :root
  end

end
