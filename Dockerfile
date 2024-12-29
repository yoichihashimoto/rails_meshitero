FROM ruby:3.0-alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache gcompat && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git bash && \
    apk add --virtual build-packages --no-cache build-base curl-dev
RUN mkdir /meshitero
WORKDIR /meshitero
ADD Gemfile //Gemfile
ADD Gemfile.lock /meshitero/Gemfile.lock
RUN bundle install
RUN apk del build-packages
ADD . /meshitero
EXPOSE 4000
CMD ["rails", "server", "-b", "0.0.0.0"]