package io.pivotal.education.articulate.cloud.service;

import java.util.Map;

import org.springframework.cloud.cloudfoundry.CloudFoundryServiceInfoCreator;
import org.springframework.cloud.cloudfoundry.Tags;

public class AttendeeWebServiceInfoCreator extends CloudFoundryServiceInfoCreator<WebServiceInfo> {

  public AttendeeWebServiceInfoCreator() {
    super(new Tags(), "http", "https");
  }

  @Override
  public WebServiceInfo createServiceInfo(Map<String, Object> serviceData) {
    String id = (String) serviceData.get("name");

    Map<String, Object> credentials = getCredentials(serviceData);
    String uri = getUriFromCredentials(credentials);

    return new WebServiceInfo(id, uri);
  }


}