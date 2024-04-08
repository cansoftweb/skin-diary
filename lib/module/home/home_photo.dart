import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/screen/camera_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skin_care_diary/store/get_calendar.dart';

class HomePhoto extends StatefulWidget {
  const HomePhoto({super.key});

  @override
  State<HomePhoto> createState() => _HomePhotoState();
}

class _HomePhotoState extends State<HomePhoto> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadFirstImage(); // 페이지가 생성될 때 첫 번째 이미지를 로드합니다.
  }

  Future<void> _loadFirstImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    var filter = files.whereType<File>().toList();

    if (filter.isNotEmpty) {
      // 디렉토리에 파일이 존재하는 경우, 첫 번째 파일을 불러옵니다.
      _imageFile = File(filter.first.path);
      setState(() {}); // UI를 갱신하여 이미지를 표시합니다.

      Get.find<PerCentController>().updateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(
                      onReturn: () {
                        _loadFirstImage();
                      },
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    )),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black45,
                        ),
                        SizedBox(height: 10),
                        Text('이미지를 촬영해주세요'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          if (_imageFile != null)
            Expanded(
              child: Container(
                width: double.infinity,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
