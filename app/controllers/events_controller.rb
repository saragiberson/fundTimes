class EventsController < ApplicationController
   helper_method :user_admin?

  def index
    @events = current_user.events.all
  end

  def new
    @event = Event.new 
  end

  def create 
   @event = Event.create(event_params)
   @event.users << current_user
   @event.admin_id = current_user.id
   @event.save
    redirect_to event_path(@event)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def join
    @event = Event.find(params[:id])
    if (@event.admin_id == current_user.id) 
      redirect_to event_path(@event)
      flash[:notice] = "Sorry, Admins cannot join events as guests."
      elsif 
        (@event.total_guests.count +1) < @event.max_users
        @event.users << current_user
        @event.save 
        redirect_to event_path(@event)
        flash[:notice] = "You're going to this event!!!"
      else
      redirect_to event_path(@event)
      flash[:notice] = "Sorry, but this event has fulfilled its maximum guest amount." 
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :date_of_event, :image, :description, :min_users, :max_users, :external_link, :total_price)
  end

  def user_admin?(event)
   !!(event.admin_id == current_user.id)
  end

end

