package com.iot.model;

public class Pulse {

	private int bpm;

	public Pulse() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Pulse(int bpm) {
		super();
		this.bpm = bpm;
	}

	public int getBpm() {
		return bpm;
	}

	public void setBpm(int bpm) {
		this.bpm = bpm;
	}

	@Override
	public String toString() {
		return "Pulse [bpm=" + bpm + "]";
	}
	
	
	
}
