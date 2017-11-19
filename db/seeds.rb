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
User.destroy_all
PASSWORD = 'thissectionclosed'

super_user = User.create(
    first_name: 'This',
    last_name: 'SectionMcClosed',
    email: 'example@example.ca',
    password: PASSWORD,
    user_category_id: 4
)
user_categories = UserCategory.where.not(id: 4)
p user_categories
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
