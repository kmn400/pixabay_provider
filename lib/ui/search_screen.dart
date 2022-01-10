import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_provider/data/pixabay_api.dart';
import 'package:pixabay_provider/model/picture_result.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Picture> _pictures = [];

  final _textEditingController = TextEditingController();

  @override
  void initTstate() {
    super.initState();
    Future.microtask(() {
      _showResult('iphone');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    final api = context.read<PixabayApi>();
    List<Picture> pictures = await api.fetchPhotos(query);
    setState(() {
      _pictures = pictures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _showResult(_textEditingController.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children:
                  _pictures.map((e) => Image.network(e.previewURL)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
