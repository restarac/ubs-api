FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-client

RUN mkdir -p /rails
WORKDIR /rails

# moving up to cache bundle install
COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --quiet

# Copy the app's code
COPY . /rails

# Configure production environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production

# Expose port 3000 from the container
EXPOSE 3000

# Run puma server by default
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
