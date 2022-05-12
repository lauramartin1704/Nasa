import 'package:flutter/material.dart';
import 'package:nasa/ApiService/ApiService.dart';
import 'package:nasa/model/apod.dart';
import 'package:nasa/widgets/detailWidget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Apod>(
            future: apiService.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DetailWidget(
                    snapshot.data!.title,
                    snapshot.data!.copyright,
                    snapshot.data!.explanation,
                    snapshot.data!.date,
                    snapshot.data!.url);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
