///
//  Generated code. Do not modify.
//  source: users.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'users.pb.dart' as $0;
export 'users.pb.dart';

class UserManagementClient extends $grpc.Client {
  static final _$createNewUser = $grpc.ClientMethod<$0.NewUser, $0.User>(
      '/user.UserManagement/CreateNewUser',
      ($0.NewUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  UserManagementClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> createNewUser($0.NewUser request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createNewUser, request, options: options);
  }
}

abstract class UserManagementServiceBase extends $grpc.Service {
  $core.String get $name => 'user.UserManagement';

  UserManagementServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NewUser, $0.User>(
        'CreateNewUser',
        createNewUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NewUser.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> createNewUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.NewUser> request) async {
    return createNewUser(call, await request);
  }

  $async.Future<$0.User> createNewUser(
      $grpc.ServiceCall call, $0.NewUser request);
}
