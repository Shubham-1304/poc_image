import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poc_image/cubit/image_cubit.dart';
import 'package:poc_image/image_screen.dart';
import 'package:poc_image/model/image_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_image/provider/image_detail_provider.dart';

class ImaeList extends StatefulWidget {
  const ImaeList({super.key});

  @override
  State<ImaeList> createState() => _ImaeListState();
}

class _ImaeListState extends State<ImaeList> {
  late http.Client _client;
  List<ImageModel> _imageList = [];
  int _imageCount = 10;
  int _startIndex = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _client = http.Client();
    _loadImages(_startIndex);
    _scrollController.addListener(() { // This listener is used to trigger load images function when the user reaches to the end of the list
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _startIndex += _imageCount;
        _loadImages(_startIndex);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // This function is used to load the images in a finite loop
  void _loadImages(int startIndex) async {
    for (var i = startIndex; i <= startIndex + _imageCount; i++) {
      await context.read<ImageCubit>().getImage(i: i);
      // await Future.delayed(const Duration(milliseconds: 500));  // can use this code if want to add some delay between request calls of 2 images 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ImageCubit, ImageState>(
        listener: (context, state) async {
          if (state is ImageLoaded) {
            _imageList.add(state.image);
          } else if (state is LoadImageError) {
            print("Something Went Wrong");
          }
        },
        builder: (context, state) {
          return state is LoadImageError //Error handling
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Error While Loading Image. Reason: ${state.message}",
                          softWrap: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () => _loadImages(_startIndex),
                        child: Text("Reload Images"),
                      ),
                    )
                  ],
                )
              : _imageList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _imageList.length,
                      itemBuilder: (context, index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ImageDetailProvider>()
                                  .setImageDetail(_imageList[index].title,
                                      _imageList[index].image);
                              Navigator.pushNamed(
                                context,
                                ImageScreen.routeName,
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.height/4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      _imageList[index].image,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          const SizedBox(
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
