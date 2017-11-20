require 'googleauth'
require 'google/apis/calendar_v3'

class GoogleCalendarHelper
	
  attr_reader :calendar
  SCOPE = ["https://www.googleapis.com/auth/calendar"]
  CALENDAR_ID = 'thissectionclosedcc@gmail.com'
	
  def initialize
	@calendar = Google::Apis::CalendarV3::CalendarService.new
	# get_application_default forces the use of this environment variable.
	# Set it to the location of your JSON credentials.
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = File.join(Rails.root.join "lib","api-test-key.json")
	@calendar.authorization = Google::Auth.get_application_default(SCOPE)
  end
end

