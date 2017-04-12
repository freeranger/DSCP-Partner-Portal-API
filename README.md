[![Build Status](https://semaphoreci.com/api/v1/commitshappen/dscp-partner-portal-api/branches/master/shields_badge.svg)](https://semaphoreci.com/commitshappen/dscp-partner-portal-api) [![Open Issues](https://img.shields.io/github/issues/st-charles/DSCP-Partner-Portal-API.svg)](https://github.com/st-charles/DSCP-Partner-Portal-API/issues) [![Waffle Board](https://img.shields.io/badge/waffle.io-Board-b3d4fc.svg)](https://waffle.io/st-charles/DSCP-Partner-Portal-API) [![AgileVentures Slack](https://img.shields.io/badge/AgileVentures-%23downtownstcharles-orange.svg)](https://www.agileventures.org/projects/dscp-partner-portal)

# DSCP Partner Portal API
This API will serve the DSCP Partner Portal, a member managment application for the Downtown St. Charles Partnership, a non-profit focused on the economic viability of downtown St. Charles, IL. 

All routes for this application should be protected via JWT, with no public API access.


## Project Scope
The purpose of this project is to provide the DSCP with an internal application to manage
their contacts and Partners (members). It will also allow them to create groups
or committees to which they can add and remove contacts from.


## Client-Side
The API will be consumed by Angular 2. It's yet to be determined as to whether or not that will be in the browser or using a tool like [Electron](https://electron.atom.io).


## Contributing
We'd love to have your help! Check out our [Waffle Board](https://waffle.io/st-charles/DSCP-Partner-Portal-API) to see where the project currently sits and what we're looking for help on. Do you have an idea that we maybe haven't thought of? That's cool too! Submit a ticket and we'll take a look :)

### Project Setup
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

#### Step 5: Run the tests
This project uses rspec for unit tests and cucumber for acceptance tests.
```bash
$ bundle exec rails spec
$ bundle exec rails cucumber
```

#### Step 6: Start the server
It's good practice to get the api going on a different port that the default. That way you can run both the server and client simultaneously without any issues. I arbitrarily chose port 3002.
```bash
$ bundle exec rails s -p 3002
```

#### Step 7: Making requests (Finally!)
The following examples will use curl, as it's easiest to display in a concise format what is happening. You could just as easily use an application like [Postman](https://www.getpostman.com/) to do test API calls.

Since all of the routes are authenticated, you'll want to first "login" so you can make subsequent requests for information. This is done by sending a POST request to the login path ('/login') with correct user credentials. A test user has been setup for things like this with an email of: "tony@starkindustries.io" and a password of "ironman". Let's get started.

With the server running, use curl to get login credententials from the terminal.
```bash
curl -i -X POST -H "Content-Type:application/json" http://localhost:3002/login -d '{"auth":{"email":"tony@starkindustries.io","password":"iamironman"}}'
```

The response will be something along the lines of the following, which is a JSON web token (JWT) holding the now logged-in user's authentication credentials: 
```json
{
  "jwt": "RandomStringOfCharacters"
}
```

Once you have the JWT, you can make requests to application routes like /contacts/:id. This is done by specifying an addition requeast header of "Authorization" with the token value as its value.
```bash
curl -i -X GET -H "Content-Type:application/json" -H "Authorization:JWT RandomStringOfCharacters" http://localhost:3002/contacts/123
```

You should get a single contact that looks something like the following: 
```json
{
  "id": 123,
  "first_name": "Bryce",
  "last_name": "Harber",
  "email": "example-123@example.com",
  "phone": 9876543211,
  "phone_alt": 1234567890,
  "website": "http://example.com",
  "facebook": "http://facebook.com/DowntownStCharlesPartnership",
  "instagram": "http://instagram.com/STC_CitySide",
  "street_address": "79548 Kozey Loop",
  "city": "St. Charles",
  "state": "IL",
  "zip": 60175,
  "business_name": "Shrieking Shack",
  "partner": false
}
```

## Opening Issues
If there's an addition, a potential bug in the code, something that needs updating, or just a question about the project, please feel free to open up a new issue and share it with others. When you do, all we ask is you answer the following questions so that we may best address your issue. Thanks! :)
* Bug, feature request, or proposal?
* What is the expected behavior?
* What is the current behavior?
* What are the steps to reproduce?
* What is the use-case or motivation for changing an existing behavior?
* Is there anything else we should know?