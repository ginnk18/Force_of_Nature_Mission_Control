##############USER CATEGORY! DO NOT RESEED UNLESS CRITICAL!!!!########### 
# UserCategory.destroy_all
# UserCategory.create(name:'Guest')
# UserCategory.create(name: 'General Volunteer')
# UserCategory.create(name: 'Team Lead')
# UserCategory.create(name: 'Admin')

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TeamCategory.destroy_all
# TeamCategory.create(name: 'Regional')
# TeamCategory.create(name: 'Operational')
# EventCategory.destroy_all
# EventCategory.create(name: 'Canvas')
# EventCategory.create(name: 'Slideshow')
# EventCategory.create(name: 'Meeting')
# EventCategory.create(name: 'PhoneBank')
# EventCategory.create(name: 'Other')
##########################################################################

User.destroy_all
Team.destroy_all
PASSWORD = 'thissectionclosed'

Team.create(name: 'Recruitment', team_category_id: '2')
Team.create(name: 'Data', team_category_id: '2')
Team.create(name: 'Research', team_category_id: '2')
Team.create(name: 'SlideShow', team_category_id: '2')

5.times.each do
    name = Faker::Cat.name
    Team.create(
        name: name,
        team_category_id: '1'
    )
end
teams = Team.all
super_user = User.create(
    first_name: 'This',
    last_name: 'SectionMcClosed',
    email: 'example@example.ca',
    password: PASSWORD,
    user_category_id: 4
)
user_categories = UserCategory.where.not(id: 4)

10.times.each do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@thissectionclosed.io",
        password: PASSWORD,
        user_category: user_categories.sample
    )
end


event_categories = EventCategory.all
users = User.all
3.times.each do
    name = Faker::Name.name
    start_time = Time.now
    end_time = Time.now + 10.days
    date = Date.today() + 10
    location = Faker::Address.full_address
    Event.create(
        name: name,
        start_time: start_time,
        end_time: end_time,
        date: date,
        event_category: event_categories.sample,
        location: location,
        creator: users.sample,
        lead: users.sample
    )
end
puts "Created #{Event.count} events"

