import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
    : _imagePicker = imagePicker ?? ImagePicker(),
      _imageCropper = imageCropper ?? ImageCropper();
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 80,
  }) async =>
      await _imagePicker.pickImage(source: source, imageQuality: imageQuality);

  Future<CroppedFile?> cropImage({
    required XFile file,
    CropStyle cropStyle = CropStyle.circle,
  }) async => _imageCropper.cropImage(
    sourcePath: file.path,
    uiSettings: [
      AndroidUiSettings(cropStyle: cropStyle),
      IOSUiSettings(cropStyle: cropStyle),
    ],
  );
}
