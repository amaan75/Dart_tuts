import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image/image.dart';

void download(String url, String path, String preview) {
  //get the data and write it to disk
  http.readBytes(url).then((buffer) {
    File f = new File(path);
    RandomAccessFile rf = f.openSync(mode: FileMode.WRITE);
    rf.writeFromSync(buffer);
    rf.flushSync();
    rf.closeSync();

    //Load the image
    Image image = decodeImage(new File(path).readAsBytesSync());

    //Resize the image
    Image thumbnail = copyResize(image, 200);

    //save the thumbnail
    new File(preview).writeAsBytesSync(encodePng(thumbnail));
  });
}

main(List<String> args) {
  String url = 'https://flutter.io/images/intellij/hot-reload.gif';
  String path =
      '/media/amaan/WORKSPACE/Dev/dart/tutorials/dart-resize-image/downlaod/test.gif';
  String preview =
      '/media/amaan/WORKSPACE/Dev/dart/tutorials/dart-resize-image/downlaod/preview.png';
  try {
    download(url, path, preview);
  } catch (e) {
    print(e.toString());
  }
}
