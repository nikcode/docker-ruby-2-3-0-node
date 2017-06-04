FROM ruby:2.3.0

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get install -y nodejs

HEALTHCHECK --interval=1s --timeout=5s --retries=60 \
    CMD curl --fail http://localhost:3000/ || exit 1

EXPOSE 3000

CMD bundle install --without production --path vendor/bundle \
    && rake db:migrate \
    && rake db:seed \
    && npm install --allow-root \
    && ls -la public/assets/stylesheets \
    && RAILS_ENV=development rake assets:precompile --trace\
    && bundle exec rails server  -b 0.0.0.0 -p 3000 -e development

