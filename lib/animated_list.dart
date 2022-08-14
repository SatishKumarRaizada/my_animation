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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addItemToList();
    });
  }

  void _addItemToList() async {
    List<String> lists = [
      'Satish',
      'Krishav',
      'Neha',
      'Papa',
      'Mummy',
      'Bhai',
      'Bhabhi'
    ];
    for (var element in lists) {
      await Future.delayed(const Duration(milliseconds: 100));
      _tripTile.add(_displayName(element));
      _listKey.currentState!.insertItem(_tripTile.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Animated List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedList(
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
