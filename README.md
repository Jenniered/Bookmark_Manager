# Bookmark Manager

## User stories

  ### User story 1
As a user, I want to see a list of bookmarks, 
so that I can quickly and easily access frequently visited sites.

<img src="domain-model.png">

  ### User story 2
As a time-pressed user,
I would like to add the site's address and title to bookmark manager
so that I can save a website.



## Database set up
1) Connect to psql
2) Create the database using the psql command CREATE DATABASE bookmark_manager;
3) Connect to the database using the pqsl command \c bookmark_manager;
4) Run the query we have saved in the file 01_create_bookmarks_table.sql

Using the PG gem to connect ruby application to the Postgres SQL database
Setting up a testing environment separate from the dev environment
Repeat steps above and create database "bookmark_manager_test"



