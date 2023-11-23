# Symfony PHP GraphQL Server Example Project

This project acts as an example for setting up a GraphQL server via the 
[overblog/graphql-bundle Composer PHP package](https://github.com/overblog/GraphQLBundle). This is based on the PHP 
programming language and the Symfony full-stack framework.

## Related to YouTube Video Tutorial
You can watch my YouTube video tutorial, which explains how Overblog GraphQL bundle can be used and how your own GraphQL server 
implementations can be approached.

YouTube video URL: https://youtu.be/q9A7lVw-CKM

## Project Setup

### Get the Project Up and Running by Makefile Commands
Makefile commands are supported by Bash and ZSH out-of-the-box. This project leverages Docker for having all
dependencies (like correct PHP version) in place. 

#### Preparations
Make sure you have installed 
[Docker desktop](https://www.docker.com/products/docker-desktop/) upfront. Also a very first `composer install` on your
host machine is necessary. Therefor you must have PHP and Composer installed on your host machine. There are lots of
tutorials online about having a basic local PHP and Composer setup. Google is your friend here.

#### Setup
1. You must install all Composer packages initially via `composer install` on your host machine. Simply go to the 
`symfony` folder in your terminal and execute `composer install`.
2. Afterwards you'll be able to run the setup by executing `make container_run`
3. If everything worked as expected, Symfony greets you via your webbrowser on the following url: `http://localhost:8081`
4. You can query your GraphQL component endpoints via your preferrable GraphQL client. I do recommend the 
[Altair GraphQL client](https://altairgraphql.dev/).
5. An example GraphQL query against the projects example GraphQL component is the following:
```
query Example {
  example {
    text
  }
}
```
Exceute this query against the following endpoint: `http://localhost:8081/graphql/`

_Notice:_ GraphQL does not only support queries. It also supports mutations (e.g. inserting data). Check examples 
in Overblog GraphQL package documentation:
* [Mutation example](https://github.com/overblog/GraphQLBundle/blob/master/docs/definitions/mutation.md)
