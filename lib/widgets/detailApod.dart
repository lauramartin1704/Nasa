import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:nasa/ApiService/ApiService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class detailApod extends StatelessWidget {
  final String title;
  final String url;
  final String date;
  final String copyright;
  final String explanation;

  const detailApod(
      this.title, this.copyright, this.date, this.url, this.explanation,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ApiService apiService = ApiService();

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: size.height,
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 5, right: 0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.cover)),
          ),
          Center(
              child: Card(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 250),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.title,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          Text(
                            this.copyright,
                            style: TextStyle(
                                color: Colors.black, height: 3, fontSize: 17),
                          ),
                          Text(
                            this.date,
                            style: TextStyle(
                                color: Colors.black, height: 1.5, fontSize: 17),
                          ),
                          Text(this.explanation,
                              style: TextStyle(height: 1.5, fontSize: 13)),
                          IconButton(
                            icon: const Icon(Icons.share),
                            color: Colors.black,
                            onPressed: () async {
                              final uri = Uri.parse(url);
                              final response = await http.get(uri);
                              final bytes = response.bodyBytes;

                              Directory temp = await getTemporaryDirectory();
                              final path = '${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);

                              await Share.shareFiles([path],
                                  text: title + "\n" + date);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            color: Colors.black,
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();

                              final String? id = prefs.getString('id');
                              await apiService.getFav(id);
                              await apiService.setFav(
                                  id, title, copyright, date, url, explanation);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.download),
                            color: Colors.black,
                            onPressed: () async {
                              final response = await http.get(Uri.parse(url));
                              final imageName = path.basename(url);
                              // Get the document directory path
                              final appDir = await path_provider
                                  .getApplicationDocumentsDirectory();

                              // This is the saved image path
                              // You can use it to display the saved image later
                              final localPath =
                                  path.join(appDir.path, imageName);

                              // Downloading
                              final imageFile = File(localPath);
                              await imageFile.writeAsBytes(response.bodyBytes);
                            },
                          ),
                        ],
                      ),
                    ),
                  )))
        ]),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
