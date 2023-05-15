package com.iot.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot.model.Dht;

@Service
public class DhtService {

ArrayList<Dht> dhtList = new ArrayList<>();

	public Dht addNewDhtData(Dht dht) {
		dhtList.add(dht);
		System.out.println(dht);
		return dht;
	}
	
	public Dht getDhtData() {
		if(dhtList.size() !=0) {
		return dhtList.get((dhtList.size())-1);
		}else {
			return null;
		}
	}

}
