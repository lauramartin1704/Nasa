import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa/ApiService/ApiService.dart';

import 'package:http/http.dart' as http;

import 'model/apod.dart';
import 'widgets/detailApod.dart';

class detailList extends StatefulWidget {
  const detailList(this.apod, {Key? key}) : super(key: key);

  final Apod apod;

  @override
  State<detailList> createState() => _detailListState();
}

class _detailListState extends State<detailList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: detailApod(widget.apod.title, widget.apod.copyright,
            widget.apod.date, widget.apod.url, widget.apod.explanation));
  }
}
