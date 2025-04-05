FROM ruby:3.4.2-alpine

RUN apk add --no-cache \
    build-base \
    nodejs \
    tzdata \
    bash \
    git \
    yaml-dev \
    libpq-dev  

WORKDIR /ror-dev-interview-march-2025

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .