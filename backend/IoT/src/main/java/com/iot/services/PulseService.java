package com.iot.services;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot.model.Dht;
import com.iot.model.Pulse;

@Service
public class PulseService {


	ArrayList<Pulse> pulseList = new ArrayList<>();

	public Pulse addNewPulseData(Pulse pulse) {
		pulseList.add(pulse);
		System.out.println(pulse);
		return pulse;
	}
	
	public Pulse getPulseData() {
		if(pulseList.size()!=0) {
		return pulseList.get((pulseList.size())-1);
		}else {
			return null;
		}
	}
}
