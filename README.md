# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Commands

* create a model, migration table and test files for user models : ```ruby bin/rails g model Users names:string email:string:uniq password:string```.
* create a migration table: ```ruby bin/rails g migration CreateUsers names:string email:string:uniq password:string``` pay attention to the name *"CreateUsers"* it determines what kind of table you prefer