package com.iot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.iot.model.Dht;
import com.iot.services.DhtService;

@RestController
@CrossOrigin
public class DhtController {

	@Autowired
	DhtService service;
	
	@PostMapping("/dht/add")
	public ResponseEntity<Dht> addUsers(@RequestBody Dht dht) {
		Dht p = null;
		
		 p = this.service.addNewDhtData(dht);
		 if(p!=null) {
			 return ResponseEntity.status(HttpStatus.CREATED).body(p);
		 }else {
			 return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		 }
	}
	
	@GetMapping("/dht/get")
	public ResponseEntity<Dht> name() {
		Dht p = null;
		p = this.service.getDhtData();
		System.out.println(p);
		if(p!=null) {
			 return ResponseEntity.status(HttpStatus.OK).body(p);
		 }else {
			 System.out.println("Already exist");
			 return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		 }
	}
	
	
	
}
