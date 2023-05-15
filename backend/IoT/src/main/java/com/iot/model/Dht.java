package com.iot.model;

public class Dht {

	private int temperature;
	private int humidity;
	
	
	public Dht() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Dht(int temperature, int humidity) {
		super();
		this.temperature = temperature;
		this.humidity = humidity;
	}


	public int getTemperature() {
		return temperature;
	}


	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}


	public int getHumidity() {
		return humidity;
	}


	public void setHumidity(int humidity) {
		this.humidity = humidity;
	}


	@Override
	public String toString() {
		return "Dht [temperature=" + temperature + ", humidity=" + humidity + "]";
	}
	
	
	
	
	
}
