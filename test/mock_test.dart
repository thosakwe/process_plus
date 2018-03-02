import 'dart:io';
import 'package:process_plus/process_plus.dart';
import 'package:test/test.dart';
import 'completed_process_test.dart';

void main() {
  var r = new ProcessResult(0, 0, hello, world);
  MockProcessManager manager;

  setUp(() async {
    manager = new MockProcessManager();
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
    manager.enqeueProcess(new CompletedProcess(r));
    var p = await manager.start(['foo']);
    expect(await p.pid, r.pid);
    expect(await p.exitCode, r.exitCode);
    expect(await p.stdout.first, hello);
    expect(await p.stderr.first, world);
  });

  group('queue process result', () {
    setUp(() async {
      manager..enqeue(r)..enqeue(r);
      expect(manager.runSync(['foo']), r);
      expect(await manager.run(['foo']), r);
    });
  });
}
