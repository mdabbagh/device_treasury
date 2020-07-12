FROM ruby:2.5.1
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client-12 rubygems

RUN gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x db/structure.sql
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3007

#CMD ["rails", "s", "0.0.0.0"]