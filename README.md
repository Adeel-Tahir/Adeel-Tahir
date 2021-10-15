# README

Dinner Dash

This Project is an online commerce website for online ordering.Application consist of 3 types of user Admin,authenticated user and guest user.

* Admin can create Restaurants,Items and Categories

* Admin can update Restaurants,Items and Categories

* Admin can delete Restaurants,Items and Categories

* Users can add,update and delete items from cart

DB

* DB used: Postgress

Gems used

* gem ‘devise’
* gem ‘bootstrap’, ‘~> 4.2.1’
* gem ‘jquery-rails’
* gem 'pundit'
* gem 'bootsnap', '>= 1.1.0'

How to use

* Clone this repo
* Go to project Directory
* create following varibles and set credetials of gmail for sending mail. MAIL_USERNAME: ‘abc.xyz@gmail.com’ MAIL_PASSWORD: ‘******’
* DO rails db:migrate rails db:setup
* DO db:seed
* Do Bundle install
* start server with rails s
* App is running
