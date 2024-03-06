import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skin_care_diary/widget/header/header_icon.dart';

class BeautyAddScreen extends StatefulWidget {
  const BeautyAddScreen({super.key});

  @override
  State<BeautyAddScreen> createState() => _BeautyAddScreenState();
}

class _BeautyAddScreenState extends State<BeautyAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: HeaderIcon(
          icon: Icons.arrow_back_ios_new,
          useBack: true,
        ),
        title: const Text(
          '나의 제품 추가',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // 배경 클릭 시 키보드 내리기
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // form
                _buildSelect(
                  title: '분류',
                ),
                _buildInput(
                  title: '브랜드 이름',
                  placeholder: '사용하시는 브랜드명을 기입해주세요.',
                ),
                _buildInput(
                  title: '제품 이름',
                  placeholder: '브랜드의 제품명을 기입해주세요.',
                ),
                _buildInput(
                  title: '가격',
                  placeholder: '제품의 가격을 기입해주세요.',
                ),
                _buildTextarea(
                  title: '사용 목적',
                  placeholder: '사용 목적을 기입해주세요.',
                ),
                _buildInput(
                  title: '개봉일',
                  placeholder: '개봉일을 기입해주세요.',
                ),

                // 하단 버튼
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text('나의 제품 추가'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextarea({
    required String title,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: 6, // null 또는 원하는 줄 수 설정
          keyboardType: TextInputType.multiline,
          style: TextStyle(
            fontSize: 14, // 원하는 폰트 크기로 설정
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: Colors.black26,
            ),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ), // 활성화 색상 변경
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSelect({
    required String title,
  }) {
    final List<String> items = ['분류 선택', 'Option 2', 'Option 3'];
    String selectedValue = '분류 선택';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      // 선택된 값 업데이트
                      selectedValue = newValue;
                    }
                  },
                  icon: Container(),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_outlined)
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInput({
    required String title,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        // const SizedBox(height: 10),
        TextField(
          style: TextStyle(
            fontSize: 14, // 원하는 폰트 크기로 설정
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: Colors.black26,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ), // 활성화 색상 변경
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
