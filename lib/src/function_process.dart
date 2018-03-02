import 'dart:async';
import 'dart:io';

class FunctionProcess extends Process {
  bool _killed = false;
  final int pid;
  final Future<int> Function(List<String>, MockStdin, IOSink, IOSink) main;

  FunctionProcess(this.pid, this.main);

  @override
  bool kill([ProcessSignal signal = ProcessSignal.SIGTERM]) {
    return _killed = true;
  }

  @override
  Future<int> get exitCode {
    return main();
  }

  @override
  Stream<List<int>> get stderr {
    
  }
}