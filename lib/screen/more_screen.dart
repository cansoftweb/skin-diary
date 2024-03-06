import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list1 = [
      '화장대',
      '알림 설정',
      '화면 잠금',
    ];
    List<String> list2 = [
      '리뷰 남기기',
      '문의하기',
    ];
    List<String> list3 = [
      '리뷰 남기기',
      '문의하기',
      '보안 안내',
      '이용약관',
      '개인정보 처리방침',
      '버전정보',
    ];
    const textStyle = TextStyle(
      fontSize: 15,
      color: Colors.black,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: HeaderIcon(icon: Icons.arrow_back_ios_new),
        leading: Container(),
        title: const Text(
          '더보기',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(),
              const SizedBox(height: 30),
              Text('기능'),
              ...list1.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      e,
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text('설정'),
              ...list2.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      e,
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ...list3.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      e,
                      style: textStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '엘리바비님 안녕하세요!',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'bobby1004@mail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 25,
          )
        ],
      ),
    );
  }
}
