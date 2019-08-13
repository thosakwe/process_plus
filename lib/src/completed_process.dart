import 'dart:async';
import 'dart:io';

/// A [Process] implementation that simply outputs the result of a [CompletedProcess].
class CompletedProcess extends Process {
  final ProcessResult processResult;

  CompletedProcess(this.processResult);

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) => true;

  @override
  int get pid => processResult.pid;

  @override
  IOSink get stdin =>
      throw UnsupportedError('A CompletedProcess has no stdin.');

  @override
  Stream<List<int>> get stderr =>
      Stream.fromIterable([processResult.stderr as List<int>]);

  @override
  Stream<List<int>> get stdout =>
      Stream.fromIterable([processResult.stdout as List<int>]);

  @override
  Future<int> get exitCode async => processResult.exitCode;
}
