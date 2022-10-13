import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExternalDir {
  String? tempFp;
  List<FileSystemEntity> _folders = [];
  fileRead() async {
    String path;
    Directory? extDir = await getExternalStorageDirectory();
    String dirPath = '${extDir!.path}/VgFp/';
    print("dirPath----$dirPath");
    dirPath =
        dirPath.replaceAll("Android/data/com.example.gulferp/files/", "");
    await Directory(dirPath).create(recursive: true);
    final File file = File('${dirPath}/fpCode.txt');
    print("file...$file");
    String filpath = '$dirPath/fpCode.txt';
    if (await File(filpath).exists()) {
      print("existgfgf");
      tempFp = await file.readAsString();
      print("file exist----$tempFp");
    } else {
      tempFp = "";
    }
    print("file exist----$tempFp");
    return tempFp;
  }

///////////////////////////////////////////////////////////////////////////////////
  fileWrite(String fp) async {
    String path;
    print("fpppp====$fp");
    Directory? extDir = await getExternalStorageDirectory();

    String dirPath = '${extDir!.path}/VgFp';
    dirPath =
        dirPath.replaceAll("Android/data/com.example.gulferp/files/", "");
    await Directory(dirPath).create(recursive: true);

    // Directory? baseDir = Directory('storage/emulated/0/Android/data');
    final File file = File('${dirPath}/fpCode.txt');
    print("file...$file");
    String filpath = '$dirPath/fpCode.txt';

    if (await File(filpath).exists()) {
      print("file exists");
    } else {
      await file.writeAsString(fp);
    }
  }
}
