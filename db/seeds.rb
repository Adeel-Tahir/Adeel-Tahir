# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
U1=User.create(fullname:"Adeeltahir",status: :user, email:"adeeltahir447@gmail.com", password:"111111")
U2=User.create(fullname:"Musfer",status: :user, email:"musfer@gmail.com", password:"111111")
U3=User.create(fullname:"Ahmed",status: :user, email:"ahmed@gmail.com", password:"111111")
U4=User.create(fullname:"Ali",status: :admin, email:"ali@gmail.com", password:"123456")

I1=Item.create(name:"Biryani",description: "yummy",price:200)
I2=Item.create(name:"Daal mash",description: "tasty",price:80)
I3=Item.create(name:"Channa",description: "good",price:60)
I4=Item.create(name:"Qorma",description: "yummy",price:160)
I5=Item.create(name:"Zinger burger",description: "chrispy",price:230)
I6=Item.create(name:"shawarma",description: "spicy",price:130)
I7=Item.create(name:"Sandwich",description: "super",price:290)
I8=Item.create(name:"Pizza",description: "large",price:850)


