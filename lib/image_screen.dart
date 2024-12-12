import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {

  static const routeName ="image_screen";
  const ImageScreen({
    super.key,
    this.imageUrl,
    this.title,
  });

  final String? title;
  final String? imageUrl;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    args.imageUrl ?? '',
                  ),
                  fit: BoxFit.fill
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(args.title ?? '')
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