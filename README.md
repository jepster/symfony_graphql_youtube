# Symfony GraphQL Example Project

This project acts as an example for using GraphQL via the overblog/graphql-bundle Composer PHP package.

## Related to YouTube Video Tutorial
You can watch my YouTube video tutorial, which explains how GraphQL bundle can be used and how your own GraphQL
implementations can be approached.

## Project Setup

### Get the Project Up and Running by Makefile Commands
Makefile commands are supported by Bash and ZSH out-of-the-box. This project leverages Docker for having all
dependencies (like correct PHP version) in place.

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
