FROM ruby:2.7-alpine

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock parser.rb ./
RUN bundle install

CMD ["./parser.rb"]