part of 'image_cubit.dart';

class ImageState {
  const ImageState();
}

class ImageInitial extends ImageState {

}

class LoadingImage extends ImageState {
  const LoadingImage();
}

class ImageLoaded extends ImageState {
  const ImageLoaded(this.image);

  final ImageModel image;
}

class LoadImageError extends ImageState {
  const LoadImageError(this.message, this.errorCode);

  final String message;
  final int errorCode;
}
