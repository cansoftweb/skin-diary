import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:skin_care_diary/models/gpt_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:skin_care_diary/widget/header/header_icon.dart';

class GptScreen extends StatefulWidget {
  static String route() => '/chat';
  const GptScreen({super.key});

  @override
  State<GptScreen> createState() => _GptScreenState();
}

class _GptScreenState extends State<GptScreen> with TickerProviderStateMixin {
  // 화면구현에 필요한 인스턴스 선언 - 하단에 문자를 입력받을 텍스트에디트 컨트롤러
  TextEditingController messageTextController = TextEditingController();

  final List<Messages> _historyList = List.empty(growable: true);

  String apiKey = "";
  // 빌링정보 등록 안했음
  String streamText = "";

  // 화면구현에 필요한 인스턴스 선언 - 홈 화면에서 문자가 없을 때 보여줄 문자열, 나만의 비서앱
  static const String _kStrings = " 당신의 피부는 점점 더 빛날 겁니다. ";

  // 나중에 문자가 애니메이션 처리할 예정 - 현재 문자를 가져옴
  String get _currentString => _kStrings;

  ScrollController scrollController = ScrollController();
  late Animation<int> _characterCount;
  late AnimationController animationController;

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
    );
  }

  setupAnimations() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _characterCount = StepTween(begin: 0, end: _currentString.length).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2)).then((value) {
          animationController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => animationController.forward(),
        );
      }
    });

    animationController.forward();
  }

  Future requestChat(String text) async {
    ChatCompletionModel openAiModel = ChatCompletionModel(
      model: "gpt-3.5-turbo-0613",
      messages: [
        Messages(
          role: "system",
          content: "You are a helpful assistant.",
        ),
        ..._historyList,
      ],
      stream: false,
    );
    final url = Uri.https("api.openai.com", "/v1/chat/completions");
    final resp = await http.post(url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode(openAiModel.toJson()));
    print(resp.body);
    if (resp.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
      String role = jsonData["choices"][0]["message"]["role"];
      String content = jsonData["choices"][0]["message"]["content"];
      _historyList.last = _historyList.last.copyWith(
        role: role,
        content: content,
      );
      setState(() {
        _scrollDown();
      });
    }
  }

  Stream requestChatStream(String text) async* {
    ChatCompletionModel openAiModel = ChatCompletionModel(
        model: "gpt-3.5-turbo-0613",
        messages: [
          Messages(
            role: "system",
            content: "You are a helpful assistant.",
          ),
          ..._historyList,
        ],
        stream: true);

    final url = Uri.https("api.openai.com", "/v1/chat/completions");
    final request = http.Request("POST", url)
      ..headers.addAll(
        {
          "Authorization": "Bearer $apiKey",
          "Content-Type": 'application/json; charset=UTF-8',
          "Connection": "keep-alive",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
        },
      );
    request.body = jsonEncode(openAiModel.toJson());

    final resp = await http.Client().send(request);

    final byteStream = resp.stream.asyncExpand(
      (event) => Rx.timer(
        event,
        const Duration(milliseconds: 50),
      ),
    );
    final statusCode = resp.statusCode;

    var respText = "";

    await for (final byte in byteStream) {
      try {
        var decoded = utf8.decode(byte, allowMalformed: false);
        if (decoded.contains('"content":')) {
          final strings = decoded.split("data: ");
          for (final string in strings) {
            final trimmedString = string.trim();
            if (trimmedString.isNotEmpty && !trimmedString.endsWith("[DONE]")) {
              final map = jsonDecode(trimmedString) as Map;
              final choices = map["choices"] as List;
              final delta = choices[0]["delta"] as Map;
              if (delta["content"] != null) {
                final content = delta["content"] as String;
                respText += content;
                setState(() {
                  streamText = respText;
                });
                yield content;
              }
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }

    if (respText.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAnimations();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future clearChat() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("새로운 대화의 시작"),
        content: const Text("신규 대화를 생성하시겠어요?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  messageTextController.clear();
                  _historyList.clear();
                });
              },
              child: const Text("네"))
        ],
      ),
    );
  }

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
          'Dr.AI',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 카드 위젯 - 삭제했음
              // 채팅 창
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _historyList.isEmpty
                      ? Center(
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _characterCount,
                              builder: (BuildContext context, Widget? child) {
                                String text = _currentString.substring(
                                    0, _characterCount.value);

                                // 애니메이션
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.orange[200],
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "$text",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: 1),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.teal[200],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      : GestureDetector(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: _historyList.length,
                            itemBuilder: (context, index) {
                              if (_historyList[index].role == "user") {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.red[100],
                                        radius: 9,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("피부도 아름다운 당신"),
                                            Text(_historyList[index].content),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.teal[200],
                                    radius: 9,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Dr.SkinCare AI"),
                                      Text(_historyList[index].content)
                                    ],
                                  ))
                                ],
                              );
                            },
                          ),
                        ),
                ),
              ),

              Dismissible(
                key: const Key("chat-bar"),
                direction: DismissDirection.startToEnd,
                onDismissed: (d) {
                  if (d == DismissDirection.startToEnd) {
                    // logic
                  }
                },
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("New Chat"),
                  ],
                ),
                confirmDismiss: (d) async {
                  if (d == DismissDirection.startToEnd) {
                    //logic
                    if (_historyList.isEmpty) return;
                    clearChat();
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(),
                        ),
                        child: TextField(
                          controller: messageTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Dr.SkinCare AI에게 물어 보세요.",
                          ),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 42,
                      onPressed: () async {
                        if (messageTextController.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          _historyList.add(
                            Messages(
                                role: "user",
                                content: messageTextController.text.trim()),
                          );
                          _historyList
                              .add(Messages(role: "assistant", content: ""));
                        });
                        // 키보드 내리는 코드
                        FocusScope.of(context).unfocus();
                        try {
                          var text = "";
                          final stream = requestChatStream(
                              messageTextController.text.trim());
                          await for (final textChunk in stream) {
                            text += textChunk;
                            setState(() {
                              _historyList.last =
                                  _historyList.last.copyWith(content: text);
                              _scrollDown();
                            });
                          }
                          // await requestChat(messageTextController.text.trim());
                          messageTextController.clear();
                          streamText = "";
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: const Icon(Icons.arrow_circle_up),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
