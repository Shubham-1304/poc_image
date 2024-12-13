import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_image/provider/image_detail_provider.dart';

class ImageScreen extends StatefulWidget {

  static const routeName ="image_screen";
  const ImageScreen({
    super.key,
  });


  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Map<String,dynamic>? map;

  @override
  void initState() {
    super.initState();
    map=context.read<ImageDetailProvider>().imageDetail.toMap();
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height/1.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      map?['image'] ?? '',
                    ),
                    fit: BoxFit.fill
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            Text(map?['title'] ?? '',style: const TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String imageUrl;

  ScreenArguments(this.title, this.imageUrl);
}