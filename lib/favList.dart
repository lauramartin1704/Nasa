import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa/bottomNavagation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiService/ApiService.dart';
import 'detailList.dart';
import 'model/apod.dart';
import 'widgets/detailWidget.dart';

class FavList extends StatefulWidget {
  const FavList({Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  late Future<List<Apod>> futurePost;
  ApiService apiService = new ApiService();
  String? id;

  getFavApod() async {
    final prefs = await SharedPreferences.getInstance();

    id = prefs.getString('id');

    futurePost = apiService.getFav(id);
  }

  @override
  void initState() {
    super.initState();
    getFavApod();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<List<Apod>>(
          future: apiService.getFav(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  detailList(snapshot.data![index])));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].explanation}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
