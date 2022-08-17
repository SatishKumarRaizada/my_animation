import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({Key? key}) : super(key: key);
  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  final _tripTile = <Widget>[];
  final _listKey = GlobalKey<AnimatedListState>();
  final _offset = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  final _searchCtrl = TextEditingController();
  List<String> lists = [
    'Item One',
    'Item Two',
    'Item Three',
    'Item Four',
    'Item Five',
    'Item Six',
    'Item Seven'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addItemToList();
    });
  }

  void _addItemToList() async {
    final query = _searchCtrl.text.trim().toLowerCase();
    lists.where((element) => element.toLowerCase().contains(query));
    for (var element in lists) {
      await Future.delayed(const Duration(milliseconds: 100));
      _tripTile.add(_displayName(element));
      _listKey.currentState!.insertItem(_tripTile.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Animated List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                controller: _searchCtrl,
                decoration: const InputDecoration(
                  hintText: 'Search text',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (String str) {
                  setState(() {});
                },
              ),
              SizedBox(height: height * 0.02),
              AnimatedList(
                key: _listKey,
                initialItemCount: _tripTile.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(_offset),
                    child: _tripTile[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayName(String name) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(name),
        ),
      ),
    );
  }
}
