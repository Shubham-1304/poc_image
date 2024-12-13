import 'package:flutter/material.dart';
import 'package:poc_image/model/image_model.dart';

class ImageDetailProvider extends ChangeNotifier{
  late ImageModel _imageDetail;

  ImageModel get imageDetail => _imageDetail;

  void setImageDetail(String title, String imageUrl){
    _imageDetail=ImageModel(title: title, image: imageUrl);
    notifyListeners();
  }
}