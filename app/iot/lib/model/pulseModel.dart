import 'package:flutter/material.dart';
import 'dart:convert';



//this whole dart file is responsible getting and sending the value to the server in JSON format

class PulseModel {
  final int bpm;

  const PulseModel({
    required this.bpm,
  });

  factory PulseModel.fromJson(Map<String, dynamic> json) {
    return PulseModel(
      bpm: json['bpm'],
    );
  }
}