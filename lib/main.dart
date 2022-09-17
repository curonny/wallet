import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path_provider/path_provider.dart';
import 'package:wallet/screens/homeScreen.dart';
import 'package:wallet/screens/splashScreen.dart';

import 'models/document.dart';

Future<void> main() async {
  await GetStorage.init();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DocumentAdapter());

  final String path = (await getApplicationDocumentsDirectory()).path;
  Directory dir = Directory(path);
  final List<FileSystemEntity> entities = await dir.list().toList();
  for (var element in entities) {
    print(element.path);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DWallet',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
