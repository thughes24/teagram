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

image1 = Image.create(caption: "I really like this image #picoftheday #great #nature", remote_image_url: "https://c2.staticflickr.com/8/7284/8743105403_113f508b24.jpg",user: admin, created_at: Time.now.to_date)
image2 = Image.create(caption: "This is my first post using teagream, seems great! #great #teagram", remote_image_url: "https://s-media-cache-ak0.pinimg.com/736x/e9/61/99/e961990e658ca6302dea4838eaef0b0b.jpg", user: demo, created_at: 3.days.ago.to_date)
image3 = Image.create(caption: "How's your view going? #jealous #picoftheday", remote_image_url: "https://c1.staticflickr.com/9/8281/7634172646_63c5343aa7.jpg", user: example_user, created_at: 2.years.ago)

tag1 = Tag.create(name: "#picoftheday")
tag2 = Tag.create(name: "#great")
tag3 = Tag.create(name: "#nature")
tag4 = Tag.create(name: "#jealous")
tag5 = Tag.create(name: "#teagram")

comment1 = Comment.create(body: "Great pic admin", user: demo, image: image1)
comment2 = Comment.create(body: "This is silly, I may have to remove this.", user: admin, image: image2)

like1 = Like.create(user: admin,image: image3)
like2 = Like.create(user: demo, image: image3)
like3 = Like.create(user:example_user,image: image1)
