FROM ruby:2.3.0

RUN apt-get install telnet

RUN curl -sL https://deb.nodesource.com/setup_0.10 | bash -

RUN apt-get install -y nodejs

CMD cd /app \
    && bundle install --path vendor/bundle \
    && rake db:migrate \
    && rake db:seed \
    && npm install \
    && ./node_modules/.bin/bower install \
    && ./node_modules/.bin/gulp build \
    && ls -la public/assets/stylesheets \
    && bundle exec rails server  -b ruby_nik -p 3000 -e development
