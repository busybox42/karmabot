FROM ruby:2.5-alpine

WORKDIR /usr/src/app

RUN apk add --update alpine-sdk
RUN gem install slack-ruby-client

COPY . .

CMD ["./karmabot.rb"]
