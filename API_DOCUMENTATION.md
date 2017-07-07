# API Documentation
This documentation is currently a work in progress. While most of it is complete, there are still some aspect that are being added or updated.

If you notice something incorrect, please open up an issue with the suggested change :)

## Models

#### User
Note that *password* and *password_confirmation* will combine to create an encrypted *password_digest* in the database.
```
{
  id: number,
  first_name: string, // req; min-length: 2
  last_name: string, // req; min-length: 2
  email: string, // req; valid; max-length: 255
  password: string, // req; min-length: 6
  password_confirmation: string, // req; min-length: 6; matches password
  admin: boolean, // default false
  created_at: string,
  updated_at: string
}
```

#### Contact
```
{
  id: number,
  first_name: string, // req; min-length: 2
  last_name: string, // req; min-length: 2
  email: string, // req; valid; unique
  phone: number, // length: 10
  phone_alt: number, // length: 10
  business_name: string,
  street_address: string,
  city: string,
  state: string,
  zip: number, // length: 2
  website: string, // valid
  facebook: string, // valid
  instagram: string, // valid
  partner: boolean, // default = false
  created_at: string,
  updated_at: string
}
```

#### Group
```
{
  id: number,
  name: string, // req; min-length: 3
  description: string, // req; min-length: 15
  created_at: string,
  updated_at: string
}
```

#### Note
```
{
  id: number,
  content: string, // req; min-length: 10
  created_at: string,
  updated_at: string,
  user_id: number,
  group_id: number
}
```

#### Link
```
{
  id: number,
  title: string, // req; min-length: 3;
  destination: string, // req; max-length: 255
  created_at: string,
  updated_at: string,
  group_id: number
}
```

## Routes
All routes are protected via authentications. Certain routes may have authorizations, which will be listed when applicable. Please note that route patterns follow the standard REST architecture.

#### Quick Note on Request Headers
All requests to the server must come with a request header with an Authorization key, which holds the JWT token of the authenticated user. The only route that doesn’t require this header is a `POST` action to the `/login` path, which returns an authenticated user’s JWT token for later use.

**Example request header:**
``` JSON
{
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer myRandomJwtTokenIHaveAlready”
}
```

#### /users
`GET /users`: Returns an array of entire user objects, except: password_digest, created_at and updated_at

**Expected response:**
``` JSON
[
  {
    "id": 1,
    "first_name": "Tony",
    "last_name": "Stark",
    "email": "tony@starkindustries.io",
    "admin": true
  },
  {
    "id": 3,
    "first_name": "Jessica",
    "last_name": "Jones",
    "email": "jjones@aliasinvestigations.org",
    "admin": false
  },
]
```

`POST /users`: Admins Only. Takes a user object and returns new user object upon successful creation. The admin property on a user cannot be set upon creation and is again only an action an Admin can make.

**Example request body:**
``` JSON
{
  "first_name": "Bruce",
  "last_name": "Banner",
  "email": "hulk@smash.me"
}
```

**Expected response:**
``` JSON
{
  "id": 4,
  "first_name": "Bruce",
  "last_name": "Banner",
  "email": "hulk@smash.me",
  "admin": false
}
```

`GET /users/:id`: Returns entire user object with the matching id, except: password_digest, created_at and updated_at

**Expected response:**
``` JSON
{
  "id": 1,
  "first_name": "Tony",
  "last_name": "Stark",
  "email": "tony@starkindustries.io",
  "admin": true
}
```

`PUT/PATCH /users/:id`: Returns the entire updated user object of the matching id

**Example request body:**
``` JSON
{
  "id": 4,
  "first_name": "Hulk",
  "last_name": "Banner",
  "email": "hulk@smash.me",
  "admin": false
}
```

**Expected response:**
``` JSON
{
  "id": 4,
  "first_name": "Hulk",
  "last_name": "Banner",
  "email": "hulk@smash.me",
  "admin": false
}
```

`DELETE /users/:id`: Simply returns a 201 (success) status code

#### /login
`POST /login`: Returns a JWT token if the provided credentials match a user’s credentials. In production, the JWT token will expire after 8 hours.

**Example request body:**
``` JSON
{
  "email": "hulk@smash.me",
  "password": "#HulkSm@$h"
}
```

**Expected response:**
``` JSON
{
  "jwt": "someSeeminglyRandomJwtTokenValue"
}
```

#### /contacts
**General**
`GET /contacts`: Returns all contacts
**Expected response:**
``` JSON
[
  {
    "id": 1,
    "first_name": "Frank",
    "last_name": "Underwood",
    "email": "fu@whitehouse.gov",
    "phone": 1111111111,
    "phone_alt": 1111111112,
    "business_name": "The United States",
    "street_address": "1600 Pennsylvania Ave NW",
    "city": "Washington",
    "state": "DC",
    "zip": 20500,
    "website": "https://whitehouse.gov",
    "facebook": null,
    "instagram": null,
    "partner": true
  },
  {
    "id": 8,
    "first_name": "Santa",
    "last_name": "Claus",
    "email": "santa@thenorthpole.org",
    "phone": null,
    "phone_alt": null,
    "business_name": "Santa's Workshop",
    "street_address": null,
    "city": null,
    "state": null,
    "zip": null,
    "website": "https://thenorthpole.org",
    "facebook": null,
    "instagram": null,
    "partner": false
  },
]
```

`POST /contacts`: Returns new contact object on successful creation
**Example request:**
``` JSON
{
  "first_name": "Frank",
  "last_name": "Castle",
  "email": "revenge@thepunisher.tor",
  "phone": null,
  "phone_alt": null,
  "business_name": null,
  "street_address": null,
  "city": null,
  "state": null,
  "zip": null,
  "website": "https://thepunisher.tor",
  "facebook": null,
  "instagram": null,
  "partner": false
}
```

**Expected request:**
``` JSON
{
  "id": 66,
  "first_name": "Frank",
  "last_name": "Castle",
  "email": "revenge@thepunisher.tor",
  "phone": null,
  "phone_alt": null,
  "business_name": null,
  "street_address": null,
  "city": null,
  "state": null,
  "zip": null,
  "website": "https://thepunisher.tor",
  "facebook": null,
  "instagram": null,
  "partner": false
}
```

`GET /contact/:id`: Returns contact with the matching id
**Expected response:**
``` JSON
{
  "id": 1,
  "first_name": "Frank",
  "last_name": "Underwood",
  "email": "fu@whitehouse.gov",
  "phone": 1111111111,
  "phone_alt": 1111111112,
  "business_name": "The United States",
  "street_address": "1600 Pennsylvania Ave NW",
  "city": "Washington",
  "state": "DC",
  "zip": 20500,
  "website": "https://whitehouse.gov",
  "facebook": null,
  "instagram": null,
  "partner": true
}
```

`PUT/PATCH /contact/:id`: Returns the updated contact object of the matching id
**Example request:**
``` JSON
{
  "id": 1,
  "first_name": "Frank",
  "last_name": "Underwood",
  "email": "fu@underwood.me",
  "phone": 1111111111,
  "phone_alt": 1111111112,
  "business_name": null,
  "street_address": null,
  "city": null,
  "state": null,
  "zip": null,
  "website": "https://underwood.me",
  "facebook": null,
  "instagram": null,
  "partner": true
}
```

**Expected response:**
``` JSON
{
  "id": 1,
  "first_name": "Frank",
  "last_name": "Underwood",
  "email": "fu@underwood.me",
  "phone": 1111111111,
  "phone_alt": 1111111112,
  "business_name": null,
  "street_address": null,
  "city": null,
  "state": null,
  "zip": null,
  "website": "https://underwood.me",
  "facebook": null,
  "instagram": null,
  "partner": true
}
```
`DELETE /contact/:id`: Simply returns a 201 status code

**Notes**
`GET /contacts/:id/notes`: Return all notes associated with contact
**Expected response:**
``` JSON
[
  {
    "id": 12,
    "content": "Some random thought I had in the shower this morning.",
    "contact_id": 3,
    "user_id": 3
  },
  {
    "id": 97,
    "content": "Am I really having to make another fake note?",
    "contact_id": 3,
    "user_id": 1
  },
  {
    "id": 183,
    "content": "Apparently I am. Last one though...",
    "contact_id": 3,
    "user_id": 9
  },
]
```
`POST /contacts/:id/notes`: Return new note upon successful note creation. Note the contact id will be provided in the url.
**Example request:**
``` JSON
{
  "content": "I lied. I did make another note."
}
```

**Expected response:**
``` JSON
{
  "id": 782,
  "content": "I lied. I did make another note.",
  "contact_id": 4,
  "user_id": 9
}
```

`PUT/PATCH /contacts/:id/notes/:note_id`: Update a note. IDs provided in url.
**Example request:**
``` JSON
{
  "content": "Some random thought I had in the bathtub this morning."
}
```

**Expected Response:**
``` JSON
{
  "id": 12,
  "content": "Some random thought I had in the bathtub this morning.",
  "contact_id": 4,
  "user_id": 3
}
```

`DELETE /contacts/:id/notes/:note_id`: Delete a note

#### /groups
**General**
`GET /groups`: Returns all groups
**Expected response:**
```JSON
[
  {
    "id": 1,
    "name": "The Avengers",
    "description": "The world's best superheroes.",
  },
  {
    "id": 7,
    "name": "The Defenders",
    "description": "Yeah, I guess we're, like, heroes.",
  },
]
```

`POST /groups`: Returns new group object on successful creation
**Example request:**
```JSON
{
  "name": "S.H.I.E.L.D",
  "description": "Strategic Homeland Intervention, Enforcement and Logistics Division.",
}
```

**Expected response:**
```JSON
{
  "id": 23,
  "name": "S.H.I.E.L.D",
  "description": "Strategic Homeland Intervention, Enforcement and Logistics Division.",
}
```

`GET /groups/:id`: Returns user with the matching id
**Expected response:**
```JSON
{
  "id": 1,
  "name": "The Avengers",
  "description": "The world's best superheroes.",
}
```

`PUT/PATCH /groups/:id`: Returns the updated group object of the matching id in the url
**Example request:**
```JSON
{
  "name": "The Avengers",
  "description": "The universe's best superheroes.",
}
```

**Expected response:**
```JSON
{
  "id": 1,
  "name": "The Avengers",
  "description": "The universe's best superheroes.",
}
```

`DELETE /groups/:id`: Simply returns a 201 (success) status code

**Notes**
`GET /groups/:id/notes`: Return all notes associated with group
**Expected response:**
``` JSON
[
  {
    "id": 12,
    "content": "Some random thought I had in the shower this morning.",
    "group_id": 3,
    "user_id": 4
  },
  {
    "id": 97,
    "content": "Am I really having to make another fake note?",
    "group_id": 3,
    "user_id": 1
  },
  {
    "id": 183,
    "content": "Apparently I am. Last one though...",
    "group_id": 3,
    "user_id": 6
  },
]
```
`POST /groups/:id/notes`: Return new note upon successful note creation. Note the group id will be provided in the url.
**Example request:**
``` JSON
{
  "content": "I lied. I did make another note."
}
```

**Expected response:**
``` JSON
{
  "id": 782,
  "content": "I lied. I did make another note.",
  "group_id": 3,
  "user_id": 9
}
```

`PUT/PATCH /groups/:id/notes/:note_id`: Update a note. The ids are provided within the request url
**Example request:**
``` JSON
{
  "content": "Some random thought I had in the bathtub this morning."
}
```

**Expected Response:**
``` JSON
{
  "id": 12,
  "content": "Some random thought I had in the bathtub this morning.",
  "group_id": 3,
  "user_id": 3
}
```

`DELETE /groups/:id/notes/:note_id`: Delete a note

**Links**
`GET /groups/:id/links`: Return all links associated with group
**Expected response:**
``` JSON
[
  {
    "id": 12,
    "title": "My special link",
    "destination": "https://dropbox.com/93osalk",
    "group_id": 4
  },
  {
    "id": 73,
    "title": "The second item",
    "destination": "https://docs.google.com/93osalk",
    "group_id": 4
  },
]
```

`POST /groups/:id/links`: Return new link upon successful link creation. The ID of the group is provided in the url. There is no need at this time for links to be associated with users.
**Example request:**
``` JSON
{
  "title": "Event photos",
  "destination": "https://flickr.com/093kf"
}
```

**Expected Response:**
``` JSON
{
  "id": 83,
  "title": "Event photos",
  "destination": "https://flickr.com/093kf",
  "group_id": 4
}
```

`DELETE /groups/:id/links/:link_id`: Delete a link

**Members**
`GET /groups/:id/members`: Return all members associated with group
**Expected Response:**
``` JSON
[
  {
    "id": 12,
    "contact_id": 1,
    "first_name": "Tony",
    "last_name": "Stark",
    "group_id": 4
  },
  {
    "id": 38,
    "contact_id": 2,
    "first_name": "Jessica",
    "last_name": "Jones",
    "group_id": 4
  }
]
```

`POST /groups/:id/notes`: Return new member upon successful member addition. The ID of the group is provided in the url.
**Example request:**
``` JSON
{
  "contact_id": 6
}
```

**Expected response:**
``` JSON
{
  "id": 82,
  "contact_id": 6,
  "first_name": "Bruce",
  "last_name": "Banner",
  "group_id": 4
}
```

`DELETE /groups/:id/member/:member_id`: Delete a member