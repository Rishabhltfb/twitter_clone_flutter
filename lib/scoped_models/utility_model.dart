import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import './connected_scoped_model.dart';

class UtilityModel extends ConnectedModel {
  Future<Null> imageUpload(String id, File image) async {
    isLoading = true;
    notifyListeners();
    print('Inside imageUpload : ');
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest(
        'PATCH', Uri.parse('${uri}api/users/avatar/${id}'));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('avatar', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension
    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.statusCode);
      if (response.statusCode != 200 && response.statusCode != 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
      }
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error in uploading image: ' + error);
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  String parseImage(String imageAddress) {
    String avatar;
    if (imageAddress.contains('\\')) {
      List<String> a = imageAddress.split('\\');
      avatar = a[0] + '/' + a[1];
    } else {
      avatar = imageAddress;
    }
    return avatar;
  }
}
