package com.example.demo.entity;

import lombok.Builder;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "T_EQUIPMENT")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Equipment {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private String equipname;
	private Integer equipmentid;
	
	

}

