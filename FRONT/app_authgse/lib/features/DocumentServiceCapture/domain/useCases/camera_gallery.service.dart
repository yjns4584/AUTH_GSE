import 'package:image_picker/image_picker.dart';

class CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (photo == null) return null;
    return photo.path;
  }

  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      maxHeight: 2160,
      maxWidth: 3840,
      imageQuality: 100,
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (photo == null) return null;

    return photo.path;
  }
}
