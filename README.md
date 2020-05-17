== README

# Tweeet Management System

This is a simple ruby on rails application with user, tweeets and organization.
There are 2 types of users: admin and non-admin.
User's organization will be added at sign up only.
Postman Documentation Link: https://web.postman.co/collections/1370099-075e8624-58a2-4300-9294-bd72f81ad216?version=latest&workspace=6c58fa16-1a01-4fd5-8fe0-c67420fb144b

## Dependencies
            * Ruby Version    : 2.6.3
            * Rails           : 6.0.3
            * RSpec

## Installation
            $ git clone https://github.com/MamtaBobal/tweet_management_system.git
            $ bundle install
            $ rake db:create
            $ rake db:migrate
            $ rake db:seed
            $ rails server

## Tests
            $ rspec
