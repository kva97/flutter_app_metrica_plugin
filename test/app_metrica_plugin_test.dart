import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_metrica_plugin/app_metrica_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('app_metrica_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
