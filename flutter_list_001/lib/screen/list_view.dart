import 'package:flutter/material.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ListViewState();
}

class _ListViewState extends State<ItemListView> {
  // List.generate(길이, cb)
  // 길이 수 만큼 cb 함수를 실행하고 return 되는 결과를
  // List 로 만들어주는 함수
  final itemList = List.generate(1000, (index) => "Item $index");
  List viewList = [];

  // State 클래스 내의 초기화 함수
  // 여러가지 변수 등을 초기화 하는 코드를 포함할 수 있다.
  @override
  void initState() {
    viewList.addAll(itemList);
    super.initState();
  }

  void _setFilterList(String search) {
    viewList.clear();
    if (search.isEmpty) {
      viewList.addAll(itemList);
    } else {
      viewList.clear();
      for (String item in itemList) {
        if (item.contains(search)) {
          viewList.add(item);
          setState(() {});
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View"),
      ),
      // ListView 배열에 담긴 데이터를 보여주는 builder
      body: Column(
        children: [
          _searchInputBox(),
          _listViewBody(),
        ],
      ),
    );
  }

/*
 * Flutter 모듈 분리에서 method 로 분리하기
 * 현재 아래의 모듈 함수에서 viewList state 배열을 공유하고 있다
 * 이럴 때는 모듈을 widget 으로 분리하는 것보다는 method로 분리하는 것이 편함
 * 또한 함수는 외부로부터 은닉을 하기위해 UnderBar(_)로 함수 이름을 시작
 * 현재 searchInputBox(), searchInputField(), _istViewBody() _listViewCard()
 */
  Padding _searchInputBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _searchInputField(),
    );
  }

  TextField _searchInputField() {
    return TextField(
      onChanged: (value) {
        _setFilterList(value);
      },
      decoration: const InputDecoration(
        labelText: "검색",
        hintText: "검색",
        prefixIcon: Icon(Icons.search_sharp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
    );
  }

  Expanded _listViewBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: viewList.length,
        itemBuilder: (context, index) {
          return _listViewCard(index);
        },
      ),
    );
  }

  Card _listViewCard(int index) {
    return Card(
      elevation: 2,
      child: ListTile(
        // 앞쪽에 붙는 아이콘
        leading: const Icon(Icons.search_sharp),
        // 뒤쪽에 붙는 아이콘
        trailing: const Icon(Icons.more_vert_sharp),
        title: Text(
          viewList[index],
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text("${index + 1} 번째 Item"),
      ),
    );
  }
}
