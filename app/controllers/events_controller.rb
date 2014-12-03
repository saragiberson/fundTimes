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

  private

  def event_params
    params.require(:event).permit(:name, :location, :date_of_event, :image, :description)
  end

  def user_admin?(event)
   !!(event.admin_id == current_user.id)
  end

end

  # create_table "events", force: true do |t|
  #   t.string   "name"
  #   t.string   "location"
  #   t.datetime "date_of_event"
  #   t.string   "image"
  #   t.string   "external_link"
  #   t.integer  "total_price"
  #   t.text     "description"
  #   t.integer  "max_users"
  #   t.integer  "min_users"
  #   t.boolean  "paid",          default: false
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  # create_table "user_events", force: true do |t|
  #   t.integer  "user_id"
  #   t.integer  "event_id"
  #   t.string   "role",           default: "user"
  #   t.boolean  "payment_status", default: false
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end
