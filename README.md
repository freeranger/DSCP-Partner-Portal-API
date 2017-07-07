[![Build Status](https://semaphoreci.com/api/v1/commitshappen/dscp-partner-portal-api/branches/master/shields_badge.svg)](https://semaphoreci.com/commitshappen/dscp-partner-portal-api) [![Open Issues](https://img.shields.io/github/issues/st-charles/DSCP-Partner-Portal-API.svg)](https://github.com/st-charles/DSCP-Partner-Portal-API/issues) [![Waffle Board](https://img.shields.io/badge/waffle.io-Board-b3d4fc.svg)](https://waffle.io/st-charles/DSCP-Partner-Portal-API) [![AgileVentures Slack](https://img.shields.io/badge/AgileVentures-%23downtownstcharles-orange.svg)](https://www.agileventures.org/projects/dscp-partner-portal)

# DSCP Partner Portal API
This API will serve the DSCP Partner Portal. This member managment application is being built for the Downtown St. Charles Partnership (DSCP), a non-profit organization focused on the economic viability of downtown St. Charles, IL. 

The purpose of this project is to provide the DSCP with an internal application to manage their contacts and Partners (members). It will also allow them to create groups or committees to which they can add and remove contacts from.

Want to contribute to the project? Check out our [contributing](CONTRIBUTING.md) docs!

## Project Setup
#### Step 1: Clone the project
Before you can get started, you need to have the project files on your local machine. Assuming you have git already installed, simply clone this repo and cd into it using the terminal.
```bash
$ git clone https://github.com/commitshappen/dscp-partner-portal-api.git
$ cd dscp-partner-portal-api
```

#### Step 2: PostgreSQL Setup (if neccessary)
This database uses [postgreSQL](https://www.postgresql.org/). You will therefore need to have it installed and running on your local machine. (The pg gem accesses the postgreSQL database.) AgileVentures has a [solid resource](https://github.com/AgileVentures/WebsiteOne/blob/develop/docs/development_environment_set_up.md#postgreSQL) on how to do just that. 

#### Step 3: Install project dependencies
Download all of the gems to make sure your clone works like it's supposed to.
```bash
$ bundle install
```

#### Step 4: Setup & seed database
Get the database setup and seed it with some contacts and a user.
```bash
$ bundle exec rails db:setup
```

#### Step 5: Running the tests
This project uses rspec for unit/integration tests and cucumber for acceptance tests.
```bash
$ bundle exec rails spec
$ bundle exec rails cucumber
```

#### Step 6: Start the server
It's good practice to get the api going on a different port that the default. That way you can run both the server and client simultaneously without any issues. I arbitrarily chose port 3200, which is the port you will need to use if you're trying to work with the front and back ends simultaneously on your local machine.
```bash
$ bundle exec rails s -p 3200
```

#### Step 7: Making requests (Finally!)
Since all of the routes are authenticated, you'll want to first "login" so you can make subsequent requests for information. This is done by sending a POST request to the login path ('/login') with correct user credentials. A test user has been setup for things like this with an email of: "tony@starkindustries.io" and a password of "ironman". Let's get started.

For details about the (desired) API endpoints, please checkout the [API Documentation](API_DOCUMENTATION.md).