ARG RAILS_ENV=production

FROM ruby:3.1.0-alpine AS root

WORKDIR /app

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}
ENV RAILS_LOG_TO_STDOUT=1

RUN bundle config set frozen true \
        && addgroup -S kalmiya \
        && adduser -S -G kalmiya kalmiya

FROM root AS base-production

RUN bundle config set without development test

FROM root AS base-test

RUN bundle config set without development

FROM base-${RAILS_ENV} AS base

FROM base AS bundler

RUN apk add --no-cache \
        build-base \
        git \
        libpq-dev

COPY --chown=kalmiya:kalmiya Gemfile Gemfile.lock ./

RUN bundle install

FROM base AS yarn

RUN apk add --no-cache \
        nodejs \
        yarn

COPY --chown=kalmiya:kalmiya package.json yarn.lock ./

RUN yarn install --frozen-lockfile

FROM base AS app

RUN apk add --no-cache \
        libpq \
        libsodium \
        tzdata

COPY --from=bundler /usr/local/bundle /usr/local/bundle/
COPY --chown=kalmiya:kalmiya . ./

FROM yarn AS assets

COPY --from=app /usr /usr/
COPY --chown=kalmiya:kalmiya --from=app /app ./

RUN --mount=type=secret,id=masterkey,target=/app/config/master.key \
        bin/rails assets:precompile

FROM app

COPY --chown=kalmiya:kalmiya --from=assets /app/public/assets ./public/assets/

USER kalmiya:kalmiya

CMD ["bin/rails", "server"]
