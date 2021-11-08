# README

Dinner Dash

This Project is an online commerce website for online ordering.Application consist of 3 types of user Admin,authenticated user and guest user.

* Admin can create Restaurants,Items and Categories

* Admin can update Restaurants,Items and Categories

* Admin can delete Restaurants,Items and Categories

* Admin can see all orders

* Admin can update status of order.

* Users can add,update and delete items from cart

* Authenticated user can place order

* Unauthenticated user cannot place order

System Dependencies

* Rails 5.2.6
* ruby 2.7.0
* pg >= 0.18', '< 2.0'

Services

* Action Mailer
* Cloudinary
DB

* DB used: Postgress

Gems used

* gem ‘devise’
* gem ‘bootstrap’, ‘~> 4.2.1’
* gem ‘jquery-rails’
* gem 'pundit'
* gem 'bootsnap', '>= 1.1.0'
* gem 'pg', '>= 0.18', '< 2.0'

How to use

* Clone this repo
* Go to project Directory
* get master key of project and set it as config:set RAILS_MASTER_KEY=‘*******‘
* create following variables and set credetials of cloudinary. cloud_name,api_key,api_secret and CLOUDINARY_URL
* create following varibles and set credetials of gmail for sending mail. MAIL_USERNAME: ‘abc.xyz@gmail.com’ MAIL_PASSWORD: ‘******’
* Do Bundle install
* DO rails db:migrate rails db:setup
* DO db:seed
* start server with rails s
* App is running
