import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgk/app/application.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cartBox');
  runApp(const MyApp());
}
