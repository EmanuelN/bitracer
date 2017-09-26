# BitRacer

# Goals

Enable our users to enjoy the thrill of horse race gambling from the comfort of their own homes without any of the risks!

# Authors:

- Saj Bandaranayake (https://github.com/Sanju3001)
- John Goff (https://github.com/JohnTheScout)
- Emanuel Neves (https://github.com/EmanuelN)

# Requirements

[Phoenix](https://hexdocs.pm/phoenix/installation.html)

[Comeonin](https://github.com/riverrun/comeonin)

# Setup

1. Fork & Clone
2. Install Phoenix and all of its dependencies using `mix deps.get`
3. Compile assets by running `cd assets && npm install`
4. Create a Postgres role called "final" with the password "final" using this command: `CREATE ROLE final WITH PASSWORD 'final' CREATEDB LOGIN;`
5. Use `mix ecto.create` to initialize the app and its databse
6. Use `mix phx.server` to run the Phoenix server; the app will be served at <http://localhost:4000/> in your browser

## Screenshots

!["Screenshot of race"](https://github.com/Sanju3001/bitracer/blob/master/docs/race-1.png)
!["Screenshot of winner"](https://github.com/Sanju3001/bitracer/blob/master/docs/winner.png)
!["Screenshot of store"](https://github.com/Sanju3001/bitracer/blob/master/docs/store.png)
!["Screenshot of login"](https://github.com/Sanju3001/bitracer/blob/master/docs/login.png)


