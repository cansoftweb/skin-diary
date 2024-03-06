import 'package:flutter/material.dart';
import 'package:skin_care_diary/util.dart';
import 'package:skin_care_diary/widget/tab/line_tab.dart';

class BeautyList extends StatefulWidget {
  const BeautyList({super.key});

  @override
  State<BeautyList> createState() => _BeautyListState();
}

class _BeautyListState extends State<BeautyList> {
  int activeIndex = 0;

  List<int> data = [0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LineTab(
          onIndexChanged: (index) {
            // MyTabs 위젯에서 전달한 activeIndex 값을 받아옴
            setState(() {
              activeIndex = index;
            });
          },
          data: [
            '헤어',
            '얼굴',
            '바디',
          ],
        ),
        ...data.map(
          (e) {
            return _buildGoods(
              img:
                  'https://images.unsplash.com/photo-1567433517180-d3e56cf7f81e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvc21ldGljc3xlbnwwfHwwfHx8MA%3D%3D',
              category: '헤어',
              title: '모로칸오일 헤어 트리트먼트 100ml',
              subTitle: '부시시한 부분에 발라주면 차분하고 윤기 부시시한 부분에 발라주면 차분하고 윤기',
              price: 58000,
              openDate: '개봉일 : 2024.02.10',
            );
          },
        ),
        _buildPagination(),
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
            child: Text('XAI 밸런스 체크'),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Wrap(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              foregroundColor: Colors.black54,
            ),
            onPressed: () {},
            child: Icon(Icons.skip_previous),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              foregroundColor: Colors.black54,
            ),
            onPressed: () {},
            child: Icon(Icons.keyboard_arrow_left),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Text('1'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              foregroundColor: Colors.black54,
            ),
            onPressed: () {},
            child: Text('2'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              foregroundColor: Colors.black54,
            ),
            onPressed: () {},
            child: Icon(Icons.keyboard_arrow_right),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(35, 35),
              foregroundColor: Colors.black54,
            ),
            onPressed: () {},
            child: Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }

  Widget _buildGoods({
    String? img,
    String? category,
    String? title,
    String? subTitle,
    int? price,
    String? openDate,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // 원하는 모양 설정 (예: 둥근 모서리)
              child: AspectRatio(
                aspectRatio: 1.0, // 1:1 비율 설정
                child: img != null
                    ? Image.network(
                        img, // 이미지 URL
                        fit: BoxFit.cover, // cover 형태로 설정
                      )
                    : Container(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                category != null
                    ? Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(),
                title != null
                    ? Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )
                    : Container(),
                price != null
                    ? Column(
                        children: [
                          Text(
                            '${priceFormat(price)}원',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 3),
                        ],
                      )
                    : Container(),
                subTitle != null
                    ? Text(
                        subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      )
                    : Container(),
                openDate != null
                    ? Text(
                        openDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
