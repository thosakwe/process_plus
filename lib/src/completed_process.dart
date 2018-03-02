import 'dart:async';
import 'dart:io';

/// A [Process] implementation that simply outputs the result of a [CompletedProcess].
class CompletedProcess extends Process {
  final ProcessResult processResult;

  CompletedProcess(this.processResult);

  @override
  bool kill([ProcessSignal signal = ProcessSignal.SIGTERM]) => true;

  @override
  int get pid => processResult.pid;

  @override
  IOSink get stdin => throw new UnsupportedError('A CompletedProcess has no stdin.');

  @override
  Stream<List<int>> get stderr => processResult.stderr;

  @override
  Stream<List<int>> get stdout => processResult.stdout;

  @override
  Future<int> get exitCode async => processResult.exitCode;
}