require_relative '../../lib/google_calendar_helper'
class WelcomeController < ApplicationController

    def index
        @calendar_helper = GoogleCalendarHelper.new
        @calendar = @calendar_helper.calendar

        # List all calendars that the service account has access to
        page_token = nil
        begin
            result = @calendar.list_calendar_lists(page_token: page_token)
            if result.items.empty?
                puts "No access to any calendar!"
            else
                result.items.each do |c|
                    puts "CAL: #{c.summary}"
                end
                if result.next_page_token != page_token
                    page_token = result.next_page_token
                else
                    page_token = nil
                end
            end
        end while !page_token.nil?

        # Create a new hour-long event that takes place an hour from now
        mprd = 60 * 24
        date_start = DateTime.now + Rational(60, mprd)
        date_end = date_start + Rational(60, mprd)

        event = Google::Apis::CalendarV3::Event.new({
            summary: 'Drinking Time',
            location: 'Pizza',
            description: 'Testing from our own Rails Backend',
            start: {
                date_time: date_start
            },
            end: {
                date_time: date_end
            },
            attendees: [
                {email: 'some_attendee@gmail.com'},
                {email: 'some_student@university.edu'}
            ]
        })

        result = @calendar.insert_event(GoogleCalendarHelper::CALENDAR_ID, event)
        #puts "Event created: #{result.to_yaml}"
        puts "Event-ID #{result.id}"

    end
end
