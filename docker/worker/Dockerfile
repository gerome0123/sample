FROM ruby:2.3.1

ENV APP_HOME /var/www

RUN apt-get update -qq && apt-get install -y build-essential nodejs npm

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=3 \
  BUNDLE_PATH=/bundle

RUN gem install bundler
RUN npm install -g bower
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN echo '{ "allow_root": true }' > /root/.bowerrc
