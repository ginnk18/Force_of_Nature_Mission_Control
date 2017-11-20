##############USER CATEGORY! DO NOT RESEED UNLESS CRITICAL!!!!###########
# UserCategory.destroy_all
# TeamCategory.destroy_all
# EventCategory.destroy_all
User.destroy_all
Team.destroy_all
Event.destroy_all
#############################################################################
# UserCategory.create(name:'Guest')
# UserCategory.create(name: 'General Volunteer')
# UserCategory.create(name: 'Team Lead')
# UserCategory.create(name: 'Admin')
# TeamCategory.create(name: 'Regional')
# TeamCategory.create(name: 'Operational')
# EventCategory.create(name: 'Canvas')
# EventCategory.create(name: 'Slideshow')
# EventCategory.create(name: 'Meeting')
# EventCategory.create(name: 'PhoneBank')
# EventCategory.create(name: 'Other')

##########################################################################



PASSWORD = 'missioncontrol'
super_user_category = UserCategory.where(name: "Admin").first

super_user = User.create(
    first_name: 'Addy',
    last_name: 'McAdmin',
    email: 'example@example.ca',
    password: PASSWORD,
    user_category: super_user_category
)
operation_category = TeamCategory.where(name: 'Operational').first
regional_category = TeamCategory.where(name: 'Regional').first

Team.create(name: 'Recruitment', team_category: operation_category)
Team.create(name: 'Data', team_category: operation_category)
Team.create(name: 'Research', team_category: operation_category)
Team.create(name: 'SlideShow', team_category: operation_category)

5.times.each do
    name = Faker::Space.star
    Team.create(
        name: name,
        team_category: regional_category
    )
end
teams = Team.all

user_categories = UserCategory.where.not(name: "Admin")

10.times.each do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    c = user_categories.sample
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@mail.org",
        password: PASSWORD,
        user_category: c
    )
end
users = User.all
event_categories = EventCategory.all

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
        lead: users.sample,
        team: teams.sample
    )
end
20.times.each do
    UserTeam.create(
        user: users.sample,
        team: teams.sample
    )
end
puts "Created #{Team.count} teams"
puts "Created #{User.count} users"
puts "Created #{Event.count} events"
