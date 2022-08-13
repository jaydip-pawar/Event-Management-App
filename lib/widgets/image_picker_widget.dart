import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gdsc_assessment/provider/event_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  final key = GlobalKey();

  File _image = File("");
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final eventProvider = Provider.of<EventProvider>(context);

    Future<String> uploadFile() async {

      File file = File(_image.path);
      String imageName = 'eventImages/${DateTime.now().microsecondsSinceEpoch}';
      String downloadUrl = "";
      try {
        await FirebaseStorage.instance.ref(imageName).putFile(file);
        downloadUrl = await FirebaseStorage.instance.ref(imageName).getDownloadURL();
        if(downloadUrl != "") {
          setState(() {
            _image = File("");
            eventProvider.getImages(downloadUrl);
          });
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code),
          )
        );
      }
      return downloadUrl;
    }

    return Dialog(
      backgroundColor: const Color(0xff102733),
      child: Column(
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: const Color(0xff102733),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Upload images',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    if(_image.path != "")
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _image = File("");
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        child: _image.path == ""
                            ? const Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.white60,
                              )
                            : Image.file(_image),
                      ),
                      // color: Colors.white60,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if(eventProvider.eventImages.isNotEmpty)
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xff29404E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventProvider.eventImages.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Image.network(eventProvider.eventImages[index]),
                              const SizedBox(width: 10)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                if(_image.path != "")
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        style: const NeumorphicStyle(
                          color: Colors.white,
                          lightSource: LightSource.bottomRight,
                          shadowLightColor: Color(0xff46657e),
                        ),
                        onPressed: (){
                          EasyLoading.show(status: "Uploading...");
                          setState(() {
                            uploadFile().then((url) {
                              if(url != "") {
                                EasyLoading.showSuccess("Upload Successful!");
                              } else {
                                EasyLoading.showError("Upload failed!");
                              }
                            });
                          });
                        },
                        child: const Text(
                          'Save',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: NeumorphicButton(
                        style: const NeumorphicStyle(
                          color: Colors.red,
                          lightSource: LightSource.bottomRight,
                          shadowLightColor: Color(0xff46657e),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        onPressed: getImage,
                        style: const NeumorphicStyle(
                          color: Color(0xffFCCD00),
                          lightSource: LightSource.bottomRight,
                          shadowLightColor: Color(0xff46657e),
                        ),
                        child: Text(
                          eventProvider.eventImages.isNotEmpty ? "Upload more images" : "Upload image",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(eventProvider.eventImages.length.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
