
# PCF 101 Series: Articulate + Attendee

![Architecture](misc/architecture.png)

Both `Articulate` and `Attendee` applications are sample applications built with [Spring Boot](http://projects.spring.io/spring-boot/).

The main purposes here are to demonstrate some of Pivotal Cloud Foundry's interesting capacity.
Some scenarios like below will be covered:

1. Lightning fast of application deployment by `cf push`

2. Service mindset by `cf create-service`

3. Blue-green deployment


Meanwhile, I also create the CI / CD pipelines for `articulate` application 
by using [Concourse](http://concourse.io).



## To run the applications locally

```
$ git clone https://github.com/brightzheng100/pcf101-articulate-attendee.git
$ cd pcf101-articulate-attendee

$ ./mvnw spring-boot:run -f articulate/pom.xml
$ ./mvnw spring-boot:run -f attendee/pom.xml
```

Now, the `articulate` webapp is already serving on port `8080`
and the backend app `attendee`, providing RESTful services for `articulate`,
will be serving on port `8181`, which is exactly the default setting in `articulate`.


Go to the http://localhost:8080 in your browser and you should see below screen:

![Landing Page](misc/articulate-landing-page.png)



## To Run on Cloud Foundry

Assuming you have logged into your Cloud Foundry targeting the proper organization and space.

```
$ ./mvnw package

$ cf push -f attendee/manifest.yml
$ cf push -f articulate/manifest.yml
```

Now they're working independently.
Copy the route generated for `attendee` app and it's time to let `articulate` app talks to `attendee` service:

```
$ cf cups pcf101-demo-attendee-service -p uri
    uri> <KEY IN URL OF ATTENDEE APP + "/attendees" AND ENTER, e.g. https://pcf101-demo-attendee.apps.mycompany.com/attendees>
$ cf bind-service pcf101-demo-articulate pcf101-demo-attendee-service
$ cf restage pcf101-demo-articulate
```

You can visit the `articulate` app by visiting the route generated:

![Landing Page on PCF](misc/articulate-landing-page-pcf.png)


> Tips: 
> 1. It's recommended to try it out in [Pivotal Web Services](https://run.pivotal.io)
> 2. To simplify the process, please refer to `start.sh` for how to make all these in one simple command
> 3. Please refer to `articulate/manifest-with-service.yml` for how to add service binding directly
> within the yaml file so that the service binding process can be fully automated.


By default, the `attendee` app uses an embedded H2 database to persistent attendee records.
If you want to use MySQL, it's just some commands away:

```
$ cf create-service <MYSQL SERVICE> <MYSQL PLAN> <MYSQL_SERVICE_INSTANCE_NAME>
$ cf bind-service pcf101-demo-attendee <MYSQL_SERVICE_INSTANCE_NAME>
$ cf restage pcf101-demo-attendee
```



## Blue Green Deployment

As PCF has layered routing mechanism and provides powerful APIs for the routing control, blue-green deployment becomes very straightforward:

```
$ DOMAIN=<YOUR APPS DOMAIN>
$ cf push -f articulate/manifest-v2.yml --no-route
$ cf map-route pcf101-demo-articulate-v2 ${DOMAIN} -n pcf101-demo-articulate

$ cf scale pcf101-demo-articulate -i 1
$ cf scale pcf101-demo-articulate-v2 -i 3

$ cf unmap-route pcf101-demo-articulate ${DOMAIN} -n pcf101-demo-articulate
```

Eventually we can delete the old version of app and rename the new version:

```
$ cf delete pcf101-demo-articulate -f
$ cf rename pcf101-demo-articulate-v2 pcf101-demo-articulate
```

The `articulate` app provides good illustration about the blue-green process.

![Blue-green Deployment](misc/blue-green.png)


> Tips: 
> 1. This process can be significantly simplified if you use `Autopilot` CF plugin, see [here](https://github.com/contraband/autopilot);
> 2. Refer to [bluegreen-autopilot.sh](./bluegreen-autopilot.sh) for how to use `Autopilot` to perform blue-green deployment


## CI/CD By Concourse

There is CI/CD pipeline for [Concourse](http://concourse.ci) built in.
![Concourse CI/CD Pipeline](misc/pipeline.png)

To try it out:

```
$ vi ../_vars.yml
$ fly -t concourse set-pipeline -p pcf101-demo-articulate-attendee -c articulate/ci/pipeline.yml -l ../_vars.yml
```

> Note: Below is the sample `_vars.yml`:
```
app-name: pcf101-demo-articulate
app-host: pcf101-demo-articulate

pcf-api: <PCF API ENDPOINT>
pcf-username: <PCF USER>
pcf-password: <PCF PASSWORD>
pcf-domain: <PCF APP DOMAIN>
pcf-organization: <PCF ORG>
pcf-space: <PCF SPACE>
```



## Clean Up

To clean up the env, simply issue below commands:

```
$ cf delete pcf101-demo-articulate -r
$ cf delete pcf101-demo-attendee -r
$ cf delete-service pcf101-demo-attendee-service
```

# Credits

This project is originated from https://github.com/pivotal-education/pcf-articulate-code