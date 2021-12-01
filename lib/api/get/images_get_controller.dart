import 'package:api/api/controllars/images_api_controller.dart';
import 'package:api/models/student_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImagesGetxController extends GetxController{


  RxList<StudentImage> images =<StudentImage>[].obs;
  ImageApiController apiController = ImageApiController();
   static ImagesGetxController get to => Get.find();


  @override
  void onInit() {
    read();
    // TODO: implement onInit
    super.onInit();
  }

  Future <bool>delete({required BuildContext context,required int id})async{

    bool deleted =await apiController.deleteImage(context: context, id: id);

    if(deleted){
      images.removeWhere((element) => element.id==id);
    }

    return  deleted;
  }



  Future <void> read() async {
images.value =await apiController.images();
  }
  Future<void> upload({required String filePath ,
    required ImageUploadResponse imageUploadResponse
  })async{
    apiController.uploadImage(filePath: filePath,
        imageUploadResponse:({ required String message,
          required bool states,
          StudentImage?studentImage}) {
      if(states){
        images.add(studentImage!);
      }
      imageUploadResponse(states: states,studentImage:studentImage,message: message);

        },);
  }

  }

