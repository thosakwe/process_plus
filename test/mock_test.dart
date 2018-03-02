import 'package:process_plus/process_plus.dart';
import 'package:test/test.dart';

void main() {
  var manager = new MockProcessManager();

  test('canRun', () {
    manager..enqueueCanRun(true)..enqueueCanRun(false);
    expect(manager.canRun('foo'), true);
    expect(manager.canRun('foo'), false);
  });
}
