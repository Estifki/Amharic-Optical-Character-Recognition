import 'package:amharic_ocr/const.dart';
import 'package:flutter/material.dart';

class RecentDetailScreen extends StatelessWidget {
  final String text;

  const RecentDetailScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios,
                color: AppColor.secondayColorCustom, size: 24)),
        elevation: 0.0,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SelectableText(
          text,
          style: TextStyle(fontSize: 18, fontFamily: "Nokia"),
        ),
      )),
    );
  }
}
