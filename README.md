# README

Fancy Real Estate Portal

## Getting started

To create the enviroment first add your MySQL credentials on `db/database.yml`
once added run

    bundle install
    bundle exec rake db:migrate:reset
    bundle exec rake db:seeds

## Sync properties from XML file

To sync the list properties run following

    XML_PATH=your/xml/path SOURCE=trovit bundle exec rake properties:sync

## Run test

    bundle exec rspec spec/

