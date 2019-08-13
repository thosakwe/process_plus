import 'dart:io';
import 'package:process_plus/process_plus.dart';
import 'package:test/test.dart';
import 'completed_process.dart';

void main() {
  var r = ProcessResult(0, 0, hello, world);
  MockProcessManager manager;

  setUp(() async {
    manager = MockProcessManager();
  });

  test('canRun', () {
    manager..enqueueCanRun(true)..enqueueCanRun(false);
    expect(manager.canRun('foo'), true);
    expect(manager.canRun('foo'), false);
  });

  test('kill', () {
    manager..enqueueKill(true)..enqueueKill(false);
    expect(manager.killPid(0), true);
    expect(manager.killPid(0), false);
  });

  test('queue process', () async {
    manager.enqeueProcess(CompletedProcess(r));
    var p = await manager.start(['foo']);
    expect(await p.pid, r.pid);
    expect(await p.exitCode, r.exitCode);
    expect(await p.stdout.first, hello);
    expect(await p.stderr.first, world);
  });

  group('queue process result', () {
    setUp(() async {
      manager..enqeue(r)..enqeue(r);
    });

    test('runSync', () => expect(manager.runSync(['foo']), r));
    test('run', () async => expect(await manager.run(['foo']), r));
  });
}
