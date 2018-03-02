import 'dart:async';
import 'dart:io';

class CompletedProcess extends Process {
  final ProcessResult processResult;

  CompletedProcess(this.processResult);

  @override
  bool kill([ProcessSignal signal = ProcessSignal.SIGTERM]) => true;

  @override
  int get pid => processResult.pid;

  // TODO: Get a stdin
  @override
  IOSink get stdin => null;

  @override
  Stream<List<int>> get stderr => processResult.stderr;

  @override
  Stream<List<int>> get stdout => processResult.stdout;

  @override
  Future<int> get exitCode async => processResult.exitCode;
}