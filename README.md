# postgres_replication

### Getting Started
First thing first run the docker compose file who will do all the job. It's will create the 2 databases and then setup the master-slave replication
                
```
docker-compose up
```

### Test the replication
To test it you should have postgresql install to connect to the container database.
Connect to the master container database and create a table
                
```
"psql -h localhost -U docker -p 5451 -d postgres": connect with user docker
"\c test": connect to the test database
"CREATE TABLE names(user_id serial PRIMARY KEY,username VARCHAR (50) UNIQUE NOT NULL,email VARCHAR (355) UNIQUE NOT NULL);": create a table
"insert into names (user_id, username, email) values (1, 'audrine', 'audrine@gmail.com');": Make an insert
```

Connect to the second database to see if the replication worked
```
"psql -h localhost -U docker -p 7571 -d postgres": connect with user docker
"\c test": connect to the test database
"select * from names;": It's works!!!
```