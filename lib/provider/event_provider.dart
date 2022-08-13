import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gdsc_assessment/screens/home.dart';
import 'package:image_picker/image_picker.dart';

class EventProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> eventImages = [];

  getImages(url) {
    eventImages.add(url);
    notifyListeners();
  }

  clearUrl() {
    eventImages = [];
    notifyListeners();
  }

  List<String> getUrl() {
    return eventImages;
  }

  void addEvent(BuildContext context, String venue, String name, String about, String registerUrl, String date , DateTime dateTime, String additionalInfo) {
    EasyLoading.show(status: "Creating Event...");
    FirebaseFirestore.instance.collection(date).doc().set({
      "venue": venue,
      "name": name,
      "about": about,
      "register_link": registerUrl,
      "time": dateTime,
      "additional_info": additionalInfo,
      "photos": eventImages
    }).then((_) {
      EasyLoading.showSuccess("Event Created Successfully");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }).catchError((error) => EasyLoading.showError("Something went wrong!$error"));
  }

}