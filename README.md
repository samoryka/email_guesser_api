# README

## Run the application: `rails server`

## Run tests: `rails test`

## General principle

- A hash linking domains to formats gets loaded, it's based on what's stored in _known-emails.json_. It's loaded at the first request and gets cached so that we don't load it at each request
- When a user requests an email address, we try to find the format matching to the domain they provided
- If the format exists, it's applied to the full name the user provided, and the resulting email address is returned to
  the user
- Otherwise, an error is raised and handled

## Pitfalls of my implementation:

- Right now email formats are derived from _known-emails.json_. There's a cache so that we don't read the file too often,
  but this doesn't look very scalable. I think we could store domain-format associations in a database and refresh it
  periodically with a job, or maybe even have an event system to update it when necessary
- `EmailFormatDeriver#derive_format` looks ok for now since we only have 2 formats. Once we start having more it may
  start to look messy
- There are cases I did not take into account:
    - Names containing accents (ie: "Éric Meyer" should probably be mapped to "ericmeyer")
    - Names which are 1 letter long: right now it would work, but this won't be the case if we add more formats
    - Names written with alphabets other than the Latin one
    - Collisions: "Gina Doodle" and "George Doodle" could be both turned into "gdoodle" with one of the formats, we'd
      need a more complex system to handle these cases
    - Most likely other things I'm not seeing right now :)
