# API Documentation
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
  first_name: string, // *required (min: 2)
  last_name: string, // *required (min: 2)
  email: string, // *required (unique)
  phone: number, // (length: 10)
  phone_alt: number, // (length: 10)
  business_name: string,
  street_address: string,
  city: string,
  state: string,
  zip: string, // (length: 2)
  website: string,
  facebook: string,
  instagram: string,
  partner: boolean, // default false
  created_at: string,
  updated_at: string
}
```

#### Group
```
{
  id: number,
  name: string,
  description: string,
  created_at: string,
  updated_at: string
}
```

#### Note
```
{
  id: number,
  content: string,
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
  title: string,
  destination: string,
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

`POST /contacts`: Returns new contact object on successful creation

`GET /contact/:id`: Returns contact with the matching id

`PUT/PATCH /contact/:id`: Returns the updated contact object of the matching id

`DELETE /contact/:id`: Returns a 201 status code

**Notes**
`GET /contacts/:id/notes`: Return all notes associated with contact

`POST /contacts/:id/notes`: Return new note upon successful note creation

`PUT/PATCH /contacts/:id/notes/:note_id`: Update a note

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

`PUT/PATCH /groups/:id`: Returns the updated group object of the matching id
**Example request:**
```JSON
{
  "id": 1,
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

`POST /groups/:id/notes`: Return new note upon successful note creation

`PUT/PATCH /groups/:id/notes/:note_id`: Update a note

`DELETE /groups/:id/notes/:note_id`: Delete a note

**Links**
`GET /groups/:id/links`: Return all links associated with group

`POST /groups/:id/links`: Return new link upon successful link creation

`DELETE /groups/:id/links/:link_id`: Delete a link

**Members**
`GET /groups/:id/members`: Return all members associated with group

`POST /groups/:id/notes`: Return new member upon successful member addition

`DELETE /groups/:id/member/:member_id`: Delete a member