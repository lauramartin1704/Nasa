import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasa/ApiService/ApiService.dart';
import 'package:nasa/bottomNavagation.dart';
import 'package:nasa/detailList.dart';
import 'package:nasa/model/apod.dart';

class ListApod extends StatefulWidget {
  const ListApod({Key? key}) : super(key: key);

  @override
  listApodState createState() => listApodState();
}

class listApodState extends State<ListApod> {
  late Future<List<Apod>> futurePost;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futurePost = apiService.getList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<List<Apod>>(
          future: futurePost,
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
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].title}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("${snapshot.data![index]}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
