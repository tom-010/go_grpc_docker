import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:user/gen/users.pb.dart';

import 'gen/users.pbgrpc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<User> users = [];
  bool loading = false;

  void _createUser() async {
    setState(() {
      loading = true;
    });

    final channel = ClientChannel('localhost',
        port: 50051,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry:
              CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
        ));

    final client = UserManagementClient(channel);

    final users = [
      NewUser(name: 'Alice', age: 22),
      NewUser(name: 'Bob', age: 23)
    ];

    for (final user in users) {
      try {
        final response = await client.createNewUser(user);
        print(response);
      } catch (e) {
        print('Cought error: $e');

        setState(() {
          loading = false;
        });
      }
    }
    await channel.shutdown();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              users[index].toString(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loading ? null : _createUser,
        backgroundColor: loading ? Colors.grey : Colors.blueAccent,
        tooltip: 'Create User',
        child:
            loading ? const Icon(Icons.download) : const Icon(Icons.plus_one),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
