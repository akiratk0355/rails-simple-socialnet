# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create admin user
unless User.where(:email => "admin@example.com").any?
  admin = User.new :email => "admin@example.com",
                  :name => "ADMIN",
                  :password => "boobooboo",
                  :role => 'admin'
  admin.save!
end