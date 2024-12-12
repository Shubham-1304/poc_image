import 'package:bloc/bloc.dart';
import 'package:poc_image/api/image_detail_api.dart';
import 'package:poc_image/model/image_model.dart';
import 'package:poc_image/utils/api_exception.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  Future<void> getImage({required int i}) async {
    emit(const LoadingImage());
    ImageRemoteDataSourceImplementation datasource=ImageRemoteDataSourceImplementation();
    try{
    final result = await datasource.getImage(i);
     emit(ImageLoaded(result));
    } on APIException catch (apiException){
      emit(LoadImageError(apiException.message, apiException.statusCode));
    }
  }
}
