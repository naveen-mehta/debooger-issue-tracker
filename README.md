## Debooger

[Debooger](http://debooger.herokuapp.com/) is a web application designed to help teams record and track bugs in their software. This project was completed in 4 days (Design to Deployment).

![Login](/public/images/login.png)

## Design 

The goal was to build a simple and minimalistic web app with muted colors and a clean user interface.

## Features

The web app provides the following features:
- Create, save, update and delete projects
- Create, save, update and delete bugs/issues for each project

## Views

- Dashboard view: high-level overview of projects and issues to monitor progress 
- Project details view: project summary and all related issues 
- Project list view: all projects in the database with details like owner, creation date, status etc.
- Issue list view: all issues in the database with details like status, assigned to, project id etc.
- Users view: user details like user role, email, user ID etc.  

## Authentication / Demo User

- Used Bcrypt to encrypt passwords for authentication 
- The app provides a Demo User login which bypasses authentication but restricts the user from saving any changes to the database 
- Please get in touch if you need an Admin login 

## Technologies used

- Javascript
- Ruby
- SQL
- Postgres
- HTML
- CSS 
- Sinatra
- Bcrypt

## Upcoming Features / Problems to be fixed

- Make the app responsive 
- Error handling when database returns an empty result and handling certain characters while saving forms


