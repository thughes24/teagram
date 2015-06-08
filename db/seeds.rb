# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(username: 'admin', password: 'password', email: 'admin@example.com')
demo = User.create(username: 'demo', password: 'password', email: 'demo@example.com')
example_user = User.create(username: 'example_user', password: 'password', email: 'example_user@example.com')

follows1 = Follow.create(follower: admin, followee: demo)
follows2 = Follow.create(follower: admin, followee: example_user)
follows3 = Follow.create(follower: example_user, followee: admin)