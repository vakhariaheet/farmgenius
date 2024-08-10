import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:demo/services/ApiService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';

class ReportInfo extends StatefulWidget {
  const ReportInfo({super.key});

  @override
  State<ReportInfo> createState() => _ReportInfoState();
}

class _ReportInfoState extends State<ReportInfo> {
  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  final report = {};

  Future pickImageFromGallery(source) async {
    pickedImage = await picker.pickImage(source: source);
    setState(() {
      file = File(pickedImage!.path);
      isLoading = true;
    });
    final fileExtension =
        pickedImage!.name.split('.')[pickedImage!.name.split('.').length - 1];
   
    FormData formData = new FormData.fromMap({
      "report": await MultipartFile.fromFile(pickedImage!.path,
          filename: "soil_report.jpg",
          contentType: DioMediaType('image', fileExtension)),
    });
    try {
      final resp = await ApiService().post('ai/report', formData, false,
          Options(headers: {"Content-Type": "multipart/form-data"}));
          print(resp.data.data);
      setState(() {
        report.addAll(resp.data.data);
      });
      print(report);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Farm Genius'),
        actions: [
          PopupMenuButton(
            icon: const Icon(CupertinoIcons.add),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: const Text('From File'),
                  onTap: () {
                    pickImageFromGallery(ImageSource.gallery);
                  },
                ),
                PopupMenuItem(
                  value: 2,
                  child: const Text('From Camera'),
                  onTap: () {
                    pickImageFromGallery(ImageSource.camera);
                  },
                ),
              ];
            },
            onSelected: (value) {
              // Handle menu item selection
              print('Selected option: $value');
            },
          ),
        ],
      ),
      body: Column(children: [
        pickedImage == null
            ? Container(
                child: Center(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('./lib/assets/upload.png')),
                      const Text(
                        'Upload Soil Report Image',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                pickImageFromGallery(ImageSource.gallery);
                              },
                              child: const Text('From File')),
                          ElevatedButton(
                              onPressed: () {
                                pickImageFromGallery(ImageSource.camera);
                              },
                              child: const Text('From Camera')),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : isLoading
                ? Center(
                    child: Lottie.asset('./lib/assets/loading.json'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Analysis',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 199, 199, 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                              const Image(
                                    image: AssetImage(
                                        './lib/assets/critical.png')),
                                Column(
                                  
                                  children: [

                                    const Align(
                                     alignment: Alignment.centerRight,
                                      child:Text(

                                        'Critical',
                                        style: TextStyle(

                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            
                                            ),
                                           
                                      ),
                                    ),
                                    Text(
                                      report?.['report_summary']?.['critical_issues'][0] ?? '',
                                      style:const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
      ]),
    );
  }
}
