
# Articulate

A sample application built with [Spring Boot](http://projects.spring.io/spring-boot/) that demonstrates capabilities of Cloud Foundry.


## To run the application locally

```
$ ./mvnw spring-boot:run
```

Then go to the http://localhost:8080 in your browser.  The application uses an embedded H2 database when running in this mode.

## To run on Cloud Foundry

```
$ ./mvnw package
$ cf push
```

When a MySQL database is bound to this application, the application will use the MySQL database instead of the embedded H2 database.

## Credits and contributions

This is all based on work from the following:
* Andrew Ripka's [cf-workshop-spring-boot github repo](https://github.com/pivotal-cf-workshop/cf-workshop-spring-boot)
* Marcelo Borges [pcf-ers-demo](https://github.com/Pivotal-Field-Engineering/pcf-ers-demo)
