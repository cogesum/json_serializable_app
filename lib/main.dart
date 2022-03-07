import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'offices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<OfficesList>? officesList;
  @override
  void initState() {
    officesList = getOfficesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: FutureBuilder<OfficesList>(
          future: officesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.offices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('${snapshot.data?.offices[index].name}'),
                        subtitle:
                            Text('${snapshot.data?.offices[index].address}'),
                        leading: Image.network(
                            '${snapshot.data?.offices[index].image}'),
                        isThreeLine: true,
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
