# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
U1 = User.create(fullname: 'Adeeltahir', status: :user, email: 'adeeltahir447@gmail.com', password: '111111')
U2 = User.create(fullname: 'Musfer', status: :user, email: 'musfer@gmail.com', password: '111111')
U3 = User.create(fullname: 'Ahmed', status: :user, email: 'ahmed@gmail.com', password: '111111')
U4 = User.create(fullname: 'Ali', status: :admin, email: 'ali@gmail.com', password: '123456')

R1 = Resturant.create(name: 'ALI BURGER')
R2 = Resturant.create(name: 'MADNI RESTURANT')

I1 = Item.create(name: 'Biryani', description: 'yummy', price: 200, resturant_id: R2.id)
I2 = Item.create(name: 'Daal mash', description: 'tasty', price: 80, resturant_id: R2.id)
I3 = Item.create(name: 'Channa', description: 'good', price: 60, resturant_id: R2.id)
I4 = Item.create(name: 'Qorma', description: 'yummy', price: 160, resturant_id: R2.id)
I5 = Item.create(name: 'Zinger burger', description: 'chrispy', price: 230, resturant_id: R1.id)
I6 = Item.create(name: 'shawarma', description: 'spicy', price: 130, resturant_id: R1.id)
I7 = Item.create(name: 'Sandwich', description: 'super', price: 290, resturant_id: R1.id)
I8 = Item.create(name: 'Pizza', description: 'large', price: 850, resturant_id: R1.id)
I9 = Item.create(name: 'Nihari', description: 'overrated', price: 550, resturant_id: R2.id)
