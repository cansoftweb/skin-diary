import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_care_diary/module/beauty/beauty_list.dart';
import 'package:skin_care_diary/screen/beauty_add_screen.dart';
import 'package:skin_care_diary/theme.dart';

class BeautyScreen extends StatelessWidget {
  const BeautyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: HeaderIcon(icon: Icons.arrow_back_ios_new),
        leading: Container(),
        title: const Text(
          '뷰티룸',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                AssetsImg.shopBanner,
                width: double.infinity,
              ),
              _buildAddBtn(context),
              const BeautyList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddBtn(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BeautyAddScreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(100, 30),
            foregroundColor: Theme.of(context).primaryColor,
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Row(
            children: const [
              Text('나의 제품 추가'),
              Icon(
                Icons.add,
                size: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
