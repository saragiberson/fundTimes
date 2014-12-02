class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new 
  end

  def create 
    @event = Event.create(event_params)
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :date_of_event, :image, :description)
  end

end
