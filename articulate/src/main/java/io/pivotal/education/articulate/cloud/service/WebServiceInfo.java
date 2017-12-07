package io.pivotal.education.articulate.cloud.service;

import org.springframework.cloud.service.UriBasedServiceInfo;

public class WebServiceInfo extends UriBasedServiceInfo {

  public WebServiceInfo(String id, String url) {
    super(id, url);
  }
}