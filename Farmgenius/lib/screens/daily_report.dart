import 'dart:io';

import 'package:demo/services/ApiService.dart';
import 'package:demo/services/Approutes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  List<XFile> _imageFiles = <XFile>[];
  bool isReport = false;
  bool isLoading = false;
  bool isLocationEnabled = false;
  PermissionStatus isLocationPermissionGranted = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  void checkLocationPermission() async {
    final Location location = Location();
    isLocationEnabled = await location.serviceEnabled();
    isLocationPermissionGranted = await location.hasPermission();
    if (!isLocationEnabled) {
      isLocationEnabled = await location.requestService();
    }
    if (isLocationPermissionGranted == PermissionStatus.denied) {
      isLocationPermissionGranted = await location.requestPermission();
    }
  }

  generateReport() async {
    setState(() {
      isLoading = true;
    });
    // Get the location
    final Location location = Location();
    final LocationData locationData = await location.getLocation();
    print(locationData);

    // // Call the API to generate the report
    // FormData formData = FormData.fromMap({
    //   'images':
    //       _imageFiles.map((e) => MultipartFile.fromFileSync(e.path)).toList()
    // });

    // // Use the Dio package to make the API call
    // final resp = await ApiService().post(
    //     'ai/daily-report',
    //     formData,
    //     false,
    //     Options(headers: {
    //       'Content-Type': 'multipart/form-data',
    //     }));
    // print(resp);
    // setState(() {
    //   isLoading = false;
    //   isReport = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('FarmGenius'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.soilReport);
                },
                child: const Text('Get Soil Report'),
              ),
            ],
          ),
          // Before Generate Let user add images in a grid of 3 below Tips How to take best images for high accuracy
          // After Generate Show the report
          body: isReport
              ? ListView(
                  children: [
                    const Text('Report'),
                  ],
                )
              : Column(
                  children: [
                    const Text(
                        'Tips How to take best images for high accuracy'),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: _imageFiles.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        if (index == _imageFiles.length) {
                          return IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Select Image Source',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Camera Tips for better images for high accuracy
                                          const ListTile(
                                            title: const Text('Camera Tips'),
                                            subtitle: const Text(
                                                '1. Take the image in good lighting conditions\n2. Take the image from a distance of 1-2 feet\n3. Take the image from a 90-degree angle'),
                                          ),
                                          // Gallery Tips for better images for high accuracy
                                          const ListTile(
                                            title: const Text('Gallery Tips'),
                                            subtitle: const Text(
                                                '1. Select the image with good lighting conditions\n2. Select the image taken from a distance of 1-2 feet\n3. Select the image taken from a 90-degree angle'),
                                          ),
                                          // Camera and Gallery buttons (ElevatedButton

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                child: const Text('Camera'),
                                                onPressed: () async {
                                                  final XFile? image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                  if (image != null) {
                                                    setState(() {
                                                      _imageFiles.add(image);
                                                    });
                                                  }
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ElevatedButton(
                                                child: const Text('Gallery'),
                                                onPressed: () async {
                                                  final XFile? image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (image != null) {
                                                    setState(() {
                                                      _imageFiles.add(image);
                                                    });
                                                  }
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ));
                            },
                          );
                        }
                        return Image.file(File(_imageFiles[index].path));
                      },
                    ),
                    ElevatedButton(
                      onPressed: generateReport,
                      child: const Text('Generate'),
                    ),
                  ],
                )),
    );
  }
}
