package io.pivotal.education.articulate.controller;

import io.pivotal.education.articulate.service.EnvironmentHelper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author mborges
 */
@RestController
public class ArticulateRestController {

	private final EnvironmentHelper environmentHelper;

	public ArticulateRestController(EnvironmentHelper environmentHelper) {
		this.environmentHelper = environmentHelper;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/bluegreen-check")
	public String bluegreenRequest() throws Exception {
		return (String) environmentHelper.getVcapApplicationMap().
				getOrDefault("application_name", "no name environment variable");
	}
}
