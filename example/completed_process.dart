import 'dart:convert';
import 'dart:io';
import 'package:process_plus/process_plus.dart';
import 'package:test/test.dart';

final List<int> hello = utf8.encode('hello'), world = utf8.encode('world');

void main() {
  var r = ProcessResult(0, 0, hello, world);
  Process p;

  setUp(() async {
    p = CompletedProcess(r);
  });

  test('pid', () async => expect(await p.pid, r.pid));

  test('exitCode', () async => expect(await p.exitCode, r.exitCode));

  test('no stdin', () => expect(() => p.stdin, throwsUnsupportedError));

  test('stdout', () async => expect(await p.stdout.first, hello));

  test('stderr', () async => expect(await p.stderr.first, world));
}
