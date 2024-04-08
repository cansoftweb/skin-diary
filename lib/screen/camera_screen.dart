import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:skin_care_diary/widget/header/header_icon.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.onReturn});

  final VoidCallback onReturn;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  void _toggleCamera() async {
    final cameras = await availableCameras();
    // 현재 카메라의 인덱스 찾기
    final index = cameras
        .indexWhere((camera) => camera.name == _controller.description.name);
    // 다음 카메라의 인덱스 계산
    final nextIndex = (index + 1) % cameras.length;
    // 새로운 카메라로 컨트롤러 업데이트
    setState(() {
      _controller = CameraController(
        cameras[nextIndex],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void initState() {
    super.initState();
    // 카메라 초기화
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first);

    final firstCamera = cameras.first;
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    // 카메라 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: HeaderIcon(
          icon: Icons.close_sharp,
          color: Colors.black87,
          useBack: true,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.flip_camera_android,
              color: Colors.black87,
            ),
            onPressed: () {
              _toggleCamera();
            },
          ),
        ],
        // title: const Text(
        //   '피부 촬영',
        //   style: TextStyle(
        //     fontSize: 20,
        //     color: Colors.black,
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      // 카메라가 초기화될 때까지 기다린 후 카메라 미리보기 표시
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 미리보기가 준비되었을 때 카메라 미리보기 출력
            return Stack(
              children: [
                Positioned.fill(
                  // 카메라 촬영 화면이 보일 CameraPrivew
                  child: CameraPreview(_controller),
                  // child: Container(
                  //   width: double.infinity,
                  //   height: double.infinity,
                  //   color: Colors.amber,
                  // ),
                ),
              ],
            );
          } else {
            // 미리보기 준비 중에는 로딩 표시
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // 촬영 버튼
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            // 촬영
            final image = await _controller.takePicture();

            // 사진 저장
            final directory = await getApplicationDocumentsDirectory();
            final imagePath = '${directory.path}/image_${DateTime.now()}.png';

            // 모든 파일 삭제
            directory.listSync().forEach((entity) {
              if (entity is File) {
                entity.deleteSync();
              }
            });

            await image.saveTo(imagePath);
            // 저장 완료 메시지
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('사진이 저장되었습니다: $imagePath')),
            // );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('사진이 저장되었습니다')),
            );
            Navigator.of(context).pop();
            widget.onReturn();
          } catch (e) {
            print('촬영 실패: $e');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
