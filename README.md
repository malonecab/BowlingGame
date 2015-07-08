# Bowling Game

Bowling Game is a demo page

### Contact Details

J.A. Riquelme

E-Mail: <jariquelme@gmail.com><br />


## Synopsis


### Technologies

* **Language:** Ruby 2.0.0
* **Framework:** Ruby on Rails 4.2.1
* **Databases**: MongoDB
* **ODM:** Mongoid
* **Testing:** RSpec, Capybara
* **Server automation:** Puppet
* **Version Control:** Git
* **Gem versioning:** RVM

Please run `bundle show` for detailed versions of the RubyGems used in the project.


## Getting Started

The follwing guide is intended to be a living document. *It has to be adjusted in case anything changes.* Should you discover any problems please edit this file to reflect the correct setup process after you figured out a solution. Please bear in mind to *update this file should you change anything in the setup process*, so others don't have to waste their time figuring out what changed.

### Clone
    git clone git://github.com/malonecab/bowlingGame

### Installing dependencies
    Set up the config/mongoid.yml with your mongodb server parameters 
    bundle install

### Using the application

You should now be able to open the application in your browser: [http://localhost:3000](http://localhost:3000)

## Development Environment


The project has model and integration tests written in RSpec


Running the RSpec tests:

    bundle exec rspec spec/

Continues testing with Guard

    guard -p

## Deployment

The is no deploy script.

### Production

There is no production environment.

### Staging

There is no staging environment.
