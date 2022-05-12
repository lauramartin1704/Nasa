import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiService/ApiService.dart';
import 'bottomNavagation.dart';
import 'mainApod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService apiService = ApiService();

  var _user = TextEditingController();
  var _pass = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _user.text = "cf20laura.martin";
    _pass.text = "123456";
    return MaterialApp(
      title: 'titol',
      initialRoute: "/",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[800],
        accentColor: Colors.cyan[300],
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 5, right: 0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[Colors.cyan, Colors.red],
              )),
              child: Image.asset("assets/imatges/planet.png"),
              height: 300,
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 300),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Usuari"),
                        controller: _user,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Contrasenya"),
                        controller: _pass,
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () async {
                            bool isLogin =
                                await apiService.login(_user.text, _pass.text);
                            if (isLogin) {
                              getId() async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final String? id = prefs.getString('id');
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyStatefulWidget()));
                            }
                          },
                          child: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  }
}
*/