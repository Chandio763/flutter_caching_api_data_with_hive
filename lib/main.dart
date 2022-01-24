// ignore_for_file: avoid_print, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_caching_api_data_with_hive/Constants.dart';
import 'package:flutter_caching_api_data_with_hive/services/api_services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/post.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Constants.SETTINGS_BOX);
  await Hive.openBox(Constants.APIDATA_BOX);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   const MainScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print(Hive.box(Constants.SETTINGS_BOX).get("welcome_shown", defaultValue: false));
//     return ValueListenableBuilder<Box<dynamic>>(
//       valueListenable: Hive.box(Constants.SETTINGS_BOX).listenable(),
//       builder: (context, box, child) => 
//           const HomePage()
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: FutureBuilder<List<UserPost>>(
        future: ApiServices.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data![index].userId.toString()),
                  ),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(
                    snapshot.data![index].body,
                    maxLines: 1,
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }
        },
      ),
    );
  }
}
