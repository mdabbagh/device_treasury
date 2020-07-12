# Device Treasury

## License

MIT License.

## Features

* Admin and non-admin users
* Add/edit/delete users
* Add/edit/delete devices
* Ability to checkin and checkout a device
* History tracking for checkin/checkout actions on a per device and per user basis

## Getting started

For running and updating code locally or on a server you own, read the Docker/Local sections. For deploying to Heroku, skip to the Deployment section.

### Docker

1. Install Docker
2. Create local .env file in the top project directory
3. Run docker-compose up
4. Run docker-compose exec app bundle exec rails db:setup db:migrate

### Local

Setup PostgreSQL:

* brew install postgresql
* createuser -P -d dtreasury # to create role with createdb permissions

To get started with the app, clone the repo and then install the needed gems:

```bash
bundle install --without production
```

Next, create databases:

```bash
rails db:create
```

Next, migrate the database:

```bash
rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```bash
rails t
```

If the test suite passes, you'll be ready to run the app in a local server:

```bash
rails s
```

### Details

When you run in development mode, the seeds file populates the database with some sample devices and users. Reference the file for the emails and passwords.

When run in any mode other than development, only the admin user will be created.

# Deployment

**IMPORTANT** If you deploy this to a publicly available site, ensure you change the email/password for the admin user in the seeds.rb file.

## Heroku

Clone the repository locally, then:

```bash
heroku login
heroku create <name of app you want to create>
git push -u heroku master
heroku run rails db:migrate
heroku run rails db:seed
```

Then, go to your deployed Heroku site and sign in with the admin user you had setup in your seeds.rb file. You're now ready to add users and devices as you please!

# Troubleshooting

For PG::ConnectionBad - Could not connect to server error: pg_ctl -D /usr/local/var/postgres start
