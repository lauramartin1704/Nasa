import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa/ApiService/ApiService.dart';

import 'package:http/http.dart' as http;

import 'model/apod.dart';
import 'widgets/detailApod.dart';

class mainApod extends StatefulWidget {
  const mainApod({Key? key}) : super(key: key);

  @override
  State<mainApod> createState() => _mainApodState();
}

class _mainApodState extends State<mainApod> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<Apod>(
      future: apiService.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // TODO OK
          return detailApod(
              snapshot.data!.title,
              snapshot.data!.copyright,
              snapshot.data!.date,
              snapshot.data!.url,
              snapshot.data!.explanation);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }
}
