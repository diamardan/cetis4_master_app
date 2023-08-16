import 'dart:io';

import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<List<int>> compressAndRotateImage(
      File imageFile, int quality) async {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;

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