# Rails Messenger
  Sample messenger application, created with Ruby on Rails

## Database Schema
  ![schema](doc/schema.png)

# Installation

## Prerequisites
- [Ruby](https://rvm.io/)
- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/#debian-stable)
- [PostgreSQL](https://www.postgresql.org/download/)


## Installation

- Install GEM dependencies:

  ```bash
  bundle install
  ```

- Install asset dependencies:

  ```bash
  yarn install
  ```

- Create database, migrate tables and run the seed data:

  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```

- If you are setting up again, when you already have previous databases:

  ```bash
  rails db:reset
  ```
- For dropping database
  ```bash
  rails db:drop
  ```

- Create environment variables for omniauth providers, Create a file named "config/application.yml" and fill its contents as follows
  
  ```yml
  OA_GOOGLE_CLIENT_ID: 'XXX'
  OA_GOOGLE_SECRET_KEY: 'XXX'
  OA_GITHUB_CLIENT_ID: 'XXX'
  OA_GITHUB_SECRET_KEY: 'XXX'
  ```
