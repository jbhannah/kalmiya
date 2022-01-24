FROM ruby:3.1.0-alpine AS bundler

WORKDIR /app

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=1

RUN bundle config set --local frozen true \
        && bundle config set --local without development test

FROM bundler AS build

RUN apk add --no-cache \
        build-base \
        git \
        libpq-dev

COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM bundler AS app

RUN apk add --no-cache \
        libpq \
        libsodium \
        tzdata

RUN addgroup -S kalmiya \
        && adduser -S -G kalmiya kalmiya

COPY --chown=kalmiya:kalmiya . ./
COPY --chown=kalmiya:kalmiya --from=build /usr/local/bundle /usr/local/bundle/

FROM app AS assets

RUN apk add --no-cache \
        nodejs \
        yarn

RUN --mount=type=secret,id=masterkey,target=/app/config/master.key \
        bin/rails assets:precompile

FROM app

COPY --chown=kalmiya:kalmiya --from=assets /app/public/assets ./public/assets/

USER kalmiya:kalmiya

CMD ["bin/rails", "server"]
