import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poc_image/cubit/image_cubit.dart';
import 'package:poc_image/image_screen.dart';
import 'package:poc_image/model/image_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImaeList extends StatefulWidget {
  const ImaeList({super.key});

  @override
  State<ImaeList> createState() => _ImaeListState();
}

class _ImaeListState extends State<ImaeList> {
  late http.Client _client;
  List<ImageModel> _imageList = [];
  int _imageCount = 10;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    _loadImages();
  }

  void _loadImages() async {
    // for (var i = 1; i <= _imageCount; i++) {
    //   final data =
    //       await _client.get(Uri.https('www.xkcd.com', '/$i/info.0.json'));
    //   final Map<String, dynamic> body = jsonDecode(data.body);
    //   ImageModel image = ImageModel(image: body['img'], title: body['title']);
    //   _imageList.add(image);
    // }
    // print(_imageList);
    // setState(() {});
    for (var i = 1; i <= _imageCount; i++) {
      await context.read<ImageCubit>().getImage(i: i);
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ImageCubit, ImageState>(
        listener: (context, state) async {
          if (state is ImageInitial){
            _loadImages();
          }
          else if (state is ImageLoaded) {
            _imageList.add(state.image);
          } else if (state is LoadImageError) {
            print("Something Went Wrong");
          }
        },
        builder: (context, state) {
          return _imageList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _imageList.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ImageScreen.routeName,
                          arguments: ScreenArguments(
                              _imageList[index].title, _imageList[index].image),
                        ),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  _imageList[index].image,
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(_imageList[index].title)
                    ],
                  ),
                );
        },
      ),
    );
  }
}
