package io.pivotal.enablement.attendee.repository;

import io.pivotal.enablement.attendee.model.Attendee;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AttendeeRepository extends JpaRepository<Attendee, Long> {
	

}
