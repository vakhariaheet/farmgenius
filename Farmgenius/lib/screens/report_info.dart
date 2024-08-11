import 'package:demo/data/Report.dart';
import 'package:demo/services/Approutes.dart';
import 'package:flutter/widgets.dart';
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
  bool isLoading = true;
  final report = {};
  SoilReport soilReport = SoilReport.fromJson({});

  getCardBgColor(String status) {
    if (status == 'very low') {
      return const Color.fromRGBO(255, 240, 240, 1);
    } else if (status == 'low') {
      return const Color.fromRGBO(255, 218, 199, 1);
    } else if (status == 'optimal') {
      return const Color.fromRGBO(199, 255, 199, 1);
    } else if (status == 'high') {
      return const Color.fromRGBO(199, 255, 255, 1);
    } else if (status == 'very high') {
      return const Color.fromRGBO(199, 218, 255, 1);
    } else {
      return const Color.fromRGBO(199, 218, 255, 1);
    }
  }

  getCardBorderColor(String status) {
    // Very Strong Colors
    if (status == 'very low') {
      return const Color.fromRGBO(228, 55, 55, 1);
    } else if (status == 'low') {
      return const Color.fromRGBO(228, 55, 55, 1);
    } else if (status == 'optimal') {
      return const Color.fromRGBO(55, 228, 55, 1);
    } else if (status == 'high') {
      return const Color.fromRGBO(55, 228, 228, 1);
    } else if (status == 'very high') {
      return const Color.fromRGBO(55, 55, 228, 1);
    } else {
      return const Color.fromRGBO(55, 55, 228, 1);
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  Future pickImageFromGallery(source) async {
    print('Picking image from $source');
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
      
      setState(() {
        soilReport = SoilReport.fromJson(resp.data['data']);
      });

    
    } catch (e) {
      print('Error in API call or parsing: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         extendBody: true,
          extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          
          title: const Text('Farm Genius'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context,AppRoutes.dailyReport);
              },
              child: const Text('Daily Report'),
            ),
      
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            pickedImage == null
                ? Container(
                    child: Center(
                      child: Column(
                        children: [
                          const Image(
                              image: AssetImage('./lib/assets/upload.png')),
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
                        child: Column(
                          children: [
                            Lottie.asset('./lib/assets/loading.json'),
                            const Text(
                              'Analyzing Soil Report',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Please wait it may take a while',
                              style: TextStyle(
                                  fontSize: 16, 
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 199, 199, 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                                  child: Column(
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                              './lib/assets/critical.png')),
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Critical',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: soilReport
                                            .get('report_summary.critical_issues')
                                            .map<Widget>((issue) {
                                          return ListTile(
                                            leading: const Icon(
                                                CupertinoIcons
                                                    .exclamationmark_circle_fill,
                                                color: Color.fromRGBO(
                                                    228, 55, 55, 1)),
                                            title: Text(issue),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Key Indicators',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: soilReport
                                    .get('report_summary.key_indicators')
                                    .keys
                                    ?.map<Widget>((key) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: getCardBgColor(soilReport.get(
                                          'report_summary.key_indicators.$key.status')),
                                      border: Border.all(
                                        color: getCardBorderColor(soilReport.get(
                                            'report_summary.key_indicators.$key.status')),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8, 8.0, 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: const BoxDecoration(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(99999)),
                                              ),
                                              child: const Image(
                                                image: AssetImage(
                                                    './lib/assets/ph.png'),
                                                width: 40,
                                                height: 40,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8.0, 8.0, 0),
                                            child: Text(
                                              capitalize(key),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 8.0, 0.0),
                                            child: Text(
                                              soilReport
                                                  .get(
                                                      'report_summary.key_indicators.$key.current_value')
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: getCardBorderColor(
                                                  soilReport.get(
                                                      'report_summary.key_indicators.$key.status'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 8.0, 0),
                                            child: TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            key,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                            textAlign:
                                                                TextAlign.center,
                                                          ),
                                                          Text(
                                                            'Current Value: ${soilReport.get('report_summary.key_indicators.$key.current_value')}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ideal Range: ${soilReport.get('report_summary.key_indicators.$key.ideal_range.min')} - ${soilReport.get('report_summary.key_indicators.$key.ideal_range.max')}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Status: ${soilReport.get('report_summary.key_indicators.$key.status')}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const Text(
                                                            'Organic Tips for Improvement:',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          Column(
                                                            children: soilReport
                                                                .get(
                                                                    'report_summary.key_indicators.$key.organic_tips_for_improvement')
                                                                ?.map<Widget>(
                                                                    (tip) {
                                                              return ListTile(
                                                                leading:
                                                                    const Icon(
                                                                  CupertinoIcons
                                                                      .arrow_right,
                                                                ),
                                                                title: Text(tip),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Show tips',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: getCardBorderColor(
                                                    soilReport.get(
                                                        'report_summary.key_indicators.$key.status'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Recommendations',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              soilReport.getList(
                                          'organic_recommendations.organic_fertilizers') !=
                                      null
                                  ? Column(
                                      children: soilReport
                                          .getList(
                                              'organic_recommendations.organic_fertilizers')!
                                          .map<Widget>((recommendation) {
                                        return ListTile(
                                          leading: const Icon(CupertinoIcons
                                              .arrow_right_circle_fill),
                                          title: Text(
                                              '${recommendation['name']} - ${recommendation['amount']} ${recommendation['unit']} ${recommendation['frequency']}'),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Organic Practices',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              soilReport.getList(
                                          'organic_recommendations.organic_practices') !=
                                      null
      
        //                               {
            // 	"name": "Cover Cropping",
            // 	"implementation": "Planting non-cash crops to protect and enrich the soil.",
            // 	"benefits": "Improved soil structure, increased organic matter, and reduced erosion"
            // },
                                  ? Column(
                                      children: soilReport
                                          .getList(
                                              'organic_recommendations.organic_practices')!
                                          .map<Widget>((recommendation) {
                                        return ListTile(
                                          leading: const Icon(CupertinoIcons
                                              .arrow_right_circle_fill),
                                          title: Text(
                                              '${recommendation['name']} - ${recommendation['implementation']}'),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
          ]),
        ),
      ),
    );
  }
}
