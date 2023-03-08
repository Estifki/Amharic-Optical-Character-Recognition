import 'dart:io';
import 'package:amharic_ocr/const.dart';
import 'package:amharic_ocr/services/hive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  String _extractedText = "";
  dynamic _pickedImage;
  bool _isScanLoading = false;
  dynamic _pathForTessarect;

  // late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _initBannerAd();
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // bottomNavigationBar: _isAdLoaded
      // ? SizedBox(
      //     height: _bannerAd.size.height.toDouble(),
      //     width: _bannerAd.size.width.toDouble(),
      //     child: AdWidget(
      //       ad: _bannerAd,
      //     ),
      //   )
      // : const SizedBox(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pickedImage == null
                  ? GestureDetector(
                      onTap: () => pickImageFromGallery(),
                      child: Container(
                        height: screenSize.height * 0.36,
                        width: screenSize.width,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image, size: 70),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => pickImageFromGallery(),
                      child: Container(
                        height: screenSize.height * 0.36,
                        width: screenSize.width,
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_pickedImage),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => pickImageFromGallery(),
                    child: Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.secondayColorCustom),
                      child: const Text(
                        "Pick From Gallery",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => pickImageFromCamera(),
                    child: Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.secondayColorCustom),
                      child: const Text(
                        "Pick From Camera",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              _isScanLoading
                  ? SpinKitWave(
                      size: 24,
                      itemCount: 4,
                      color: Colors.blue.shade700,
                      duration: const Duration(milliseconds: 1500),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (_pathForTessarect != null) {
                          setState(() {
                            _isScanLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 1), () async {
                            _extractedText =
                                await FlutterTesseractOcr.extractText(
                              _pathForTessarect,
                              language: "amh",
                              //     args: {
                              //   "psm": "4",
                              //   "preserve_interword_spaces": "1",
                              // }
                            );
                          }).then((_) {
                            LocalDatabase().addToRecentScans(_extractedText);
                            Future.delayed(
                                const Duration(seconds: 2),
                                () => setState(() {
                                      _isScanLoading = false;
                                    }));
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "No Document Picked!",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue.shade700),
                          child: const Text(
                            "Scan Picked Document",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: screenSize.height * 0.04),
              _extractedText.isNotEmpty
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: SelectableText(
                        _extractedText,
                        style: TextStyle(fontSize: 18, fontFamily: "Nokia"),
                      ),
                    ))
                  : const Center(
                      child: Text(
                        "Scanned Document Will Be Shown Here\n long press then copy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // _initBannerAd() {
  //   _bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: "ca-app-pub-3940256099942544/6300978111",
  //       listener: BannerAdListener(onAdLoaded: (_) {
  //         setState(() {
  //           _isAdLoaded = true;
  //         });
  //       }),
  //       request: const AdRequest());
  //   _bannerAd.load();
  // }

  Future<void> pickImageFromGallery() async {
    _extractedText = "";
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (image != null) {
      _pickedImage = File(image.path);
      _pathForTessarect = image.path;
      setState(() {});
    }
  }

  Future<void> pickImageFromCamera() async {
    _extractedText = "";
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 40);
    if (image != null) {
      _pickedImage = File(image.path);
      _pathForTessarect = image.path;
      setState(() {});
    }
  }
}
