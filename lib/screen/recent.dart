import 'package:amharic_ocr/const.dart';
import 'package:amharic_ocr/screen/recent_detail.dart';
import 'package:amharic_ocr/services/hive.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  List _recentData = [];
  @override
  void initState() {
    _recentData = LocalDatabase().getRecentScans();
    super.initState();
  }

  bool _isDelete = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: _recentData.isEmpty
          ? const Center(
              child: Text(
              "Recent Scans Will Be Shown Here",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ))
          : Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.03),
              child: ListView.builder(
                  itemCount: _recentData.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RecentDetailScreen(text: _recentData[index]))),
                      child: Card(
                        margin:
                            const EdgeInsets.only(top: 16, left: 10, right: 10),
                        child: Stack(children: [
                          SizedBox(
                            height: 80,
                            width: screenSize.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  _recentData[index],
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "Nokia"),
                                ),
                              ),
                            ),
                          ),
                          _isDelete
                              ? Positioned(
                                  bottom: 25,
                                  right: 5,
                                  child: GestureDetector(
                                      onTap: () {
                                        LocalDatabase()
                                            .deleteRecentScans(index);
                                        _recentData =
                                            LocalDatabase().getRecentScans();
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 22,
                                      )),
                                )
                              : const Positioned(
                                  right: 8,
                                  bottom: 27,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 19,
                                    color: AppColor.secondayColorCustom,
                                  ))
                        ]),
                      ),
                    );
                  }),
            ),
      floatingActionButton: _recentData.isEmpty
          ? Container()
          : FloatingActionButton(
              backgroundColor: AppColor.secondayColorCustom,
              child: _isDelete
                  ? const Icon(Icons.arrow_forward_ios)
                  : const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _isDelete = !_isDelete;
                });
              },
            ),
    );
  }
}
