class EventsController < ApplicationController
   helper_method :user_admin?

  def index
    @events = UserEvent.all

    # displays all events for which current user is not admin
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
  flash[:notice] = "Successfully created!"
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
    flash[:notice] = "Successfully updated!"
  end

  def join
    @event = Event.find(params[:id])
    if @event.users.count < @event.max_users 
      @event.users << current_user
      @event.save
      redirect_to event_path(@event)
      flash[:notice] = "You're going to this event!!!"
    end
  end

  def pay
  # creates custom action only available to admin of event, to trigger the venmo fund transfer process,
  # once the guests have all accepted their invites (i.e. event reaches goal of max_users)
    @event = Event.find(params[:id])
    @event.make_payment
    redirect_to event_path(@event)
    flash[:notice] = "Success! We are charging the guests now."
  end

  def my_events
    @events = current_user.events.all
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
    flash[:notice] = "Event has been successfully deleted."
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :date_of_event, :image, :description, :min_users, :max_users, :external_link, :total_price)
  end

  def user_admin?(event)
   !!(event.admin_id == current_user.id)
  end

end
