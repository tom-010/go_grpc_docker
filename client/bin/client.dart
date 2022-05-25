import 'package:client/src/gen/users.pbgrpc.dart';
import 'package:grpc/grpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel('localhost',
      port: 50051,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
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
    }
  }
  await channel.shutdown();
}
