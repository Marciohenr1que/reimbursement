FROM ruby:3.3.1 AS builder

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs


WORKDIR /app


COPY Gemfile Gemfile.lock ./


RUN gem install bundler && bundle install --jobs 4 --retry 3


FROM ruby:3.3.1  


RUN apt-get update -qq && apt-get install -y \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app


COPY --from=builder /usr/local/bundle /usr/local/bundle


COPY . .

RUN mkdir -p tmp/pids && rm -f tmp/pids/server.pid
EXPOSE 3000

