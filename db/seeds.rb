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

unless User.where(:email => "alice@example.com").any?
  admin = User.new :email => "alice@example.com",
                  :name => "Alice",
                  :password => "boobooboo",
                  :role => 'user'
  admin.save!
end

unless User.where(:email => "bob@example.com").any?
  admin = User.new :email => "bob@example.com",
                  :name => "Bob",
                  :password => "boobooboo",
                  :role => 'user'
  admin.save!
end

unless User.where(:email => "charlie@example.com").any?
  admin = User.new :email => "charlie@example.com",
                  :name => "Charlie",
                  :password => "boobooboo",
                  :role => 'user'
  admin.save!
end