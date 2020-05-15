import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageUse extends StatefulWidget {
  @override
  _ImageUseState createState() => _ImageUseState();
}

class _ImageUseState extends State<ImageUse> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Image"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.network('http://www.devio.org/img/avatar.png'), // 加载网络图片
          Image.asset(
            'images/type_shop.png',
            height: 26,
            width: 26,
          ), // 加载静态图片
//          Image.file(File('/sdcard/Download/Stack.png')), // 加载本地图片 绝对路径
          FutureBuilder(
            future: _getLocalFile('/sdcard/Download/Stack.png'),
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              return snapshot.data != null
                  ? Image.file(snapshot.data)
                  : Container(
                      child: Text('找不到本地图片'),
                    );
            },
          ), // 加载本地图片 相对路径 使用 path_provider
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: 'http://www.devio.org/img/avatar.png',
          ), // 内存加载图片 transparent_image 加载placeholder
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/250?image=9',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ), // cached_network_image 缓存网络图片, 正确配置本地cocoapods后，在IOS端就可以正确编译了
        ],
      ),
    );
  }

  Future<File> _getLocalFile(String filename) async {
    String dir = (await getExternalStorageDirectory()).path;
    File f = File('$dir/$filename');
    return f;
  }
}
