import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'dart:async';

import 'package:flutter/foundation.dart';

typedef RunServerFunc = void Function(Pointer<Utf8>);
typedef RunServerFuncNative = Void Function(Pointer<Utf8>);

runServerNative(String address) {
  final DynamicLibrary nativeRustyPipeServerLib = Platform.isAndroid
      ? DynamicLibrary.open("librustypipe_server_sync.so")
      : DynamicLibrary.process();
  final addressUTF = Utf8.toUtf8(address);
  final RunServerFunc runServerFunc = nativeRustyPipeServerLib
      .lookup<NativeFunction<RunServerFuncNative>>("run_server")
      .asFunction();

  print("Run on address $addressUTF");
  runServerFunc(addressUTF);
  print("Exited");
  return;
}

void runRustyPipeServer({String address = "0.0.0.0:39567"}) {
  // if (nativeRustyPipeServerLib == null)
  //   return "ERROR: The library is not initialized 🙁";

  // print("- Mylib bindings found 👍");
  // print("  ${nativeRustyPipeServerLib.toString()}"); // Instance info

  // final addressUTF = Utf8.toUtf8(address);
  print("Run on Address $address");
  compute(runServerNative, address).then((val) => print("EXITED"));
}
