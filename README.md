# Welcome to the Dragonsurge Ruby on Rails Technical Assessment (March 2025 Version)!

## Theme: Pokemon Teams! ![pikachu gif](https://emojis.slackmojis.com/emojis/images/1643514555/5541/pikachu.gif?1643514555)


### Requirements
1. Please use the pokemon API to create pokemon teams!
-Inside the .env file, you'll see the base URL that you'll need to use to call the pokemon API. Here's the link to the API's documentation:

```
https://pokeapi.co/
```

2. Make a route for creating Pokemon Teams. You can either take in the user's pokenames, or ids of pokemon, or just randomly assign pokemon, up to you.

3. The teams should be able to be saved to the database somehow. (Don't worry about any kind of Users table for now, just the pokemon stuff)

4. There should be `six` pokemon per team. Assign them slots in the team, "one" through "six". 

5. Updating! Make another route for updating that same team, where you can replace one of the pokemon, in one of the slots

6. Deleting! Make another route for deleting a pokemon from that same team. 

7. Getting! Get a team that's already been made.

8. Figure out a nice way to store the external ids of these pokemon in our local database, so that we can cross reference easily. And a nice way to get easy access to the external_url to that pokemon's SHOW page in the pokeAPI
-Bonus points if you can make this external id storage system abstractable so that if we ever want to switch to using the Digimon API instead, we could, without having things hard-labeled to pokemon

### Another Bonus Points Feature
1. You'll also notice that we have sidekiq installed, which is a worker gem that allows asynchronous processing in rails. We also have sidekiq-scheduler, which is how we can get cronjobs.

2. If you can find a way to update the pokemon that we have in our database on a semi-regular basis with sidekiq/ sidekiq-scheduler (see sidekiq.yml for the scheduler portion), that would be super cool!

3. Also, will you be able to account for having a *huge* database with lots and lots of pokemon? How will you optimize for that?

### Soft Limit:
1. Don't let yourself work longer than three hours on the project. Catch em' all!


![pikachu gif](https://emojis.slackmojis.com/emojis/images/1643514155/1155/pokeball.gif?1643514155)


## Tech Tips for Getting Started

## Setup

Begin by cloning the repository.

## Docker Compose 

docker-compose is here to make things fast and fun. :)

First make sure you have docker and docker compose installed. 

First build:

```
docker compose build
```

Create and migrate the database (There are no migrations yet though! That's for you to have fun with!)

```
docker-compose run web bin/rails db:create db:migrate
```

Start the application and all dependencies:

```
docker-compose up
```

Be sure to rebuild if you make changes to the gemfile. 


#### Manual Setup

Not a fan of things that are easy?

After cloning the repository ensure that you have the correct version of Ruby
(referenced in the .ruby-version file), PostgreSQL and a JS runtime (such as
NodeJS) and then run the following command:

```
bin/setup
```

## Shell Scripts for Entering The Bash Shells for Each Container:
`bash postgres_enter_container_bash.sh`
`bash web_enter_container_bash.sh`
`bash redis-enter-container-bash.sh`
`bash sidekiq-enter-container-bash.s`

# Requirements:

# Make an API interface that can create a new pokemon team!
-6 pokemon per team!

Make a route called


A) Make an API interface that can create a new team
-up to 6 pokemon can be part of the team
B) Then make a second functionality in this API interface that can edit that team to switch out one or all of the pokemon
C) Also the ability to delete a member of a team as well
D) Figure out a nice way to store external ids that allows for us to use different API's as well
E) And also store the external url to get the data for that pokemon
F) Don't worry about associating with user ids for now
G) Figure out a way to store this in the database as well
E) Bonus: Create an interactor to update the pokemon with new data directly from the API in case the original API has changed or been updated
-Maybe they utilize sidekiq scheduler for the updating?








# Helpful Debugging Cases:

### Permissions issues with saving things in your code editor that you generated while in the web docker container?
Run the script to chown all files in current directory (except for postgres, because you'll cause a permissions issue):

`bash ./chown_all_files_except_postgres.sh`

Be sure to chmod it first if necessary:

`sudo chmod +x ./chown_all_files_except_postgres.sh`

If this somehow still changes the permissions of postgres, then go into the postgres container in a different terminal with:
`bash postgres-enter-container-bash.sh`


And directly chown the database from there as the postgres user with:

`chown -R postgres:postgres /var/lib/postgresql/data`

/var/lib/postgresql/data is where all of the database files are stored in the postgres container, as specified in docker-compose.yml, under the db service 

### If you encounter a postgresdb container permissions error in the docker logs:
Make sure that the postgres user within the container is the sole owner, and not anyone else (that includes root):

`sudo docker compose run --rm --user root db chown -R postgres:postgres /var/lib/postgresql/data`

where `db` is the name of the service and `/var/lib/postgresql/data` is the location within the postgres docker container of the database files. (No need to change these, they're grabbed from the docker-compose for you already)
