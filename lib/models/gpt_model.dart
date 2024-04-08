// Message와 chatCompletionModel 2개 모델 개발

// Message 모델 - 개별 메시지 정보을 담고 있는 모델
class Messages {
  late final String role; // 메시지를 보낸 주체의 역할
  late final String content; // 메시지의 실제 내용

  Messages({required this.role, required this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["role"] = role;
    data["content"] = content;
    return data;
  }

  Map<String, String> toMap() {
    return {"role": role, "content": content};
  }

  Messages copyWith({String? role, String? content}) {
    return Messages(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}


// ChatCompletion 모델: chat GPT를 호출할때 사용할 모델
// 채팅세션 또는 채팅 완성에 대한 정보를 나타냄
class ChatCompletionModel {
  late final String model; // 채팅완성을 생성하는데 사용된 모델의 식별자 또는 이름
  late final List<Messages> messages; // 객체의 리스트로 채팅 세션에서 교환된 메시지글을 나타냄
  late final bool stream; // 채팅 데이터가 연속적인 스트림의 일부인지 여부를 나타내는 블리언 값, 실시간 채팅 구현시 유용함

  ChatCompletionModel({
    required this.model,
    required this.messages,
    required this.stream,
  });

  ChatCompletionModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    messages =
        List.from(json["messages"]).map((e) => Messages.fromJson(e)).toList();
    stream = json[stream];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['model'] = model;
    data['messages'] = messages.map((e) => e.toJson()).toList();
    data['stream'] = stream;
    return data;
  }
}
