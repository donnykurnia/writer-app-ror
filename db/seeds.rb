# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create default team
Team.create(name: 'Default Team')
#create default users
User.create(username: 'admin', email: 'admin@writer-app.com', password: 'admin123', password_confirmation: 'admin123', role: 'administrator', team_id: 1)
User.create(username: 'manager', email: 'manager@writer-app.com', password: 'manager123', password_confirmation: 'manager123', role: 'project manager', team_id: 1)
User.create(username: 'writer', email: 'writer@writer-app.com', password: 'writer123', password_confirmation: 'writer123', role: 'writer', team_id: 1)
