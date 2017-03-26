# DSCP Partner Portal API
This API will serve the DSCP Partner Portal, a member managment application for the Downtown St. Charles Partnership, a non-profit focused on the economic viability of downtown St. Charles, IL. 

[![Build Status](https://semaphoreci.com/api/v1/freeranger/dscp-partner-portal-api/branches/master/badge.svg)](https://semaphoreci.com/freeranger/dscp-partner-portal-api)

All routes for this application should be protected via JWT, with no public API access.

## Project Scope
The purpose of this project is to provide the DSCP with an internal application to manage
their contacts and Partners (members). It will also allow them to create groups
or committees to which they can add and remove contacts from.

## Client-Side
The API will be consumed by Angular 2. It's yet to be determined as to whether or not that will be in the browser or using a tool like [Electron](https://electron.atom.io).

## Future Goals
At some point, the DSCP would like to open up this portal to its Partners and/or
those who find value in the organization. They can then manage their own information and payments, freeing up the DSCP to work on additional projects. 

### Added Features
The following are features the DSCP would like to include in future iterations beyond the initial MVP:
* Handling payments for parades and Partnership status, including the ability to do recurring payments
* Managing the contact's own personal information
* Viewing information on sponsorship within the organization

## Contributing
We'd love to have your help! Check out our [Trello](https://trello.com/b/ZOk6fzxd) to see where the project currently sits and what we're looking for help with. Do you have an idea that we maybe haven't thought of? That's cool too! Submit a ticket and we'll take a look :)
