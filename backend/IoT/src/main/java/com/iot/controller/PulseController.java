package com.iot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.iot.model.Dht;
import com.iot.model.Pulse;
import com.iot.services.PulseService;

@RestController
@CrossOrigin
public class PulseController {

	@Autowired
	PulseService service;
	
	@PostMapping("/pulse/add")
	public ResponseEntity<Pulse> addUsers(@RequestBody Pulse pulse) {
		Pulse p = null;
		
		 p = this.service.addNewPulseData(pulse);
		 if(p!=null) {
			 return ResponseEntity.status(HttpStatus.CREATED).body(p);
		 }else {
			 return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		 }
	}
	
	@GetMapping("/pulse/get")
	public ResponseEntity<Pulse> name() {
		Pulse p = null;
		p = this.service.getPulseData();
		System.out.println(p);
		if(p!=null) {
			 return ResponseEntity.status(HttpStatus.OK).body(p);
		 }else {
			 System.out.println("Already exist");
			 return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		 }
	}
	
}
