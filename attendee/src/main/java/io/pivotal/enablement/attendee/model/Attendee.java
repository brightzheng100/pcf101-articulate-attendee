package io.pivotal.enablement.attendee.model;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Builder
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(exclude = "id")
public class Attendee {

  @Id
  @GeneratedValue
  private Long id;

  @Column(nullable = false)
  private String firstName;
  private String lastName;
  private String address;
  private String city;
  private String state;
  private String zipCode;
  private String phoneNumber;
  private String emailAddress;


}
