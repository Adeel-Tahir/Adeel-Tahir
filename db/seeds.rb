# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
U1 = User.create!(fullname: 'Adeeltahir', status: :user, email: 'muhammad.adeel@devsinc.com', password: '111111')
U2 = User.create!(fullname: 'Musfer', status: :user, email: 'musfer@gmail.com', password: '111111')
U3 = User.create!(fullname: 'adeeltahir', status: :user, email: 'adeeltahir447@gmail.com', password: '111111')
U4 = User.create!(fullname: 'Ali', status: :admin, email: 'ali@gmail.com', password: '123456')

R1 = Resturant.create!(name: 'ALI BURGER')
R1.image.attach(io: File.open(Rails.root.join('app/assets/images/ali.jpeg')),
                filename: 'ali.jpeg')
R2 = Resturant.create!(name: 'MADNI RESTURANT')
R2.image.attach(io: File.open(Rails.root.join('app/assets/images/madni.jpeg')),
                filename: 'madni.jpeg')

I1 = Item.create!(name: 'Biryani', description: 'yummy', price: 200, resturant_id: R2.id)
I1.image.attach(io: File.open(Rails.root.join('app/assets/images/biryani.jpg')),
                filename: 'biryani.jpeg')
I2 = Item.create!(name: 'Daal mash', description: 'tasty', price: 80, resturant_id: R2.id)
I2.image.attach(io: File.open(Rails.root.join('app/assets/images/daal_mash.jpg')),
                filename: 'daal_mash.jpg')
I3 = Item.create!(name: 'Channa', description: 'good', price: 60, resturant_id: R2.id)
I3.image.attach(io: File.open(Rails.root.join('app/assets/images/channa.webp')),
                filename: 'channa.webp')
I4 = Item.create!(name: 'Qorma', description: 'yummy', price: 160, resturant_id: R2.id)
I4.image.attach(io: File.open(Rails.root.join('app/assets/images/qorma.jpeg')),
                filename: 'qorma.jpeg')
I5 = Item.create!(name: 'Zinger burger', description: 'chrispy', price: 230, resturant_id: R1.id)
I5.image.attach(io: File.open(Rails.root.join('app/assets/images/zinger.jpg')),
                filename: 'zinger.jpg')
I6 = Item.create!(name: 'shawarma', description: 'spicy', price: 130, resturant_id: R1.id)
I6.image.attach(io: File.open(Rails.root.join('app/assets/images/shawarma.jpg')),
                filename: 'shawarma.jpg')
I7 = Item.create!(name: 'Sandwich', description: 'super', price: 290, resturant_id: R1.id)
I7.image.attach(io: File.open(Rails.root.join('app/assets/images/sandwich.jpg')),
                filename: 'sandwich.jpg')
I8 = Item.create!(name: 'Pizza', description: 'large', price: 850, resturant_id: R1.id)
I8.image.attach(io: File.open(Rails.root.join('app/assets/images/pizza.jpg')),
                filename: 'pizza.jpg')
I9 = Item.create!(name: 'Nihari', description: 'overrated', price: 550, resturant_id: R2.id)
I9.image.attach(io: File.open(Rails.root.join('app/assets/images/nihari.jpg')),
                filename: 'nihari.jpg')
C1 = Category.create!(name: 'Fast Food')
C1.image.attach(io: File.open(Rails.root.join('app/assets/images/fast_food.jpg')),
                filename: 'fast_food.jpg')
C2 = Category.create!(name: 'Desi')
C2.image.attach(io: File.open(Rails.root.join('app/assets/images/desi.jpg')),
                filename: 'desi.jpg')
C11 = Categorization.create!(item_id: I1.id, category_id: C2.id)
C12 = Categorization.create!(item_id: I2.id, category_id: C2.id)
C13 = Categorization.create!(item_id: I3.id, category_id: C2.id)
C14 = Categorization.create!(item_id: I4.id, category_id: C2.id)
C15 = Categorization.create!(item_id: I5.id, category_id: C1.id)
C16 = Categorization.create!(item_id: I6.id, category_id: C1.id)
C17 = Categorization.create!(item_id: I7.id, category_id: C1.id)
C18 = Categorization.create!(item_id: I8.id, category_id: C1.id)
C19 = Categorization.create!(item_id: I9.id, category_id: C2.id)
