import 'package:flutter/material.dart';
import 'dart:convert';



//this whole dart file is responsible getting and sending the value to the server in JSON format

class DhtModel {
  final int temperature;
  final int humidity;

  const DhtModel({
    required this.temperature,
    required this.humidity,
  });

  factory DhtModel.fromJson(Map<String, dynamic> json) {
    return DhtModel(
      temperature: json['temperature'],
      humidity: json['humidity'],
    );
  }
}