import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<List<int>> compressAndRotateImage(
      XFile imageFile, int quality) async {
    final fileImage = File((imageFile.path));
    final image = img.decodeImage(fileImage.readAsBytesSync())!;

    // Corregir la rotación utilizando los datos EXIF
    final correctedImage = img.bakeOrientation(image);

    // Comprimir la imagen y convertirla a formato JPG
    final compressedImage = img.encodeJpg(correctedImage, quality: quality);

    return compressedImage;
  }
}

/* 
final imageFile = ... // tu File con la imagen capturada
final compressedImage = await ImageUtils.compressAndRotateImage(imageFile, 80); // Ajusta la calidad según tus necesidades
 */