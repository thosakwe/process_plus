import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:process/process.dart';
import 'completed_process.dart';

/// A [ProcessManager] that can enqueue results in advance, rather than
/// actually spawning OS processes.
class MockProcessManager extends ProcessManager {
  final Queue<ProcessResult> _run = new Queue();
  final Queue<Process> _process = new Queue();
  final Queue<bool> _canRun = new Queue();
  final Queue<bool> _kill = new Queue();

  /// Adds an existing [ProcessResult] to the queue.
  void enqeue(ProcessResult result) {
    _run.add(result);
  }

  /// Adds a live [Process] instance to the queue.
  void enqeueProcess(Process result) {
    _process.add(result);
  }

  /// Enqueues a result for [canRun].
  void enqueueCanRun(bool result) {
    _canRun.add(result);
  }

  /// Enqueues a result for [kill].
  void enqueueKill(bool result) {
    _kill.add(result);
  }

  @override
  Future<ProcessResult> run(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment: true,
      bool runInShell: false,
      Encoding stdoutEncoding: SYSTEM_ENCODING,
      Encoding stderrEncoding: SYSTEM_ENCODING}) async {
    return _run.removeFirst();
  }

  @override
  ProcessResult runSync(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment: true,
      bool runInShell: false,
      Encoding stdoutEncoding: SYSTEM_ENCODING,
      Encoding stderrEncoding: SYSTEM_ENCODING}) {
    return _run.removeFirst();
  }

  @override
  bool canRun(dynamic executable, {String workingDirectory}) {
    return _canRun.isEmpty || _canRun.removeFirst();
  }

  @override
  bool killPid(int pid, [ProcessSignal signal = ProcessSignal.SIGTERM]) {
    return _kill.isEmpty || _kill.removeFirst();
  }

  @override
  Future<Process> start(List<dynamic> command, {String workingDirectory, Map<
      String,
      String> environment, bool includeParentEnvironment: true, bool runInShell: false, ProcessStartMode mode: ProcessStartMode
      .NORMAL}) async {
    if (_process.isNotEmpty)
      return _process.removeFirst();
    return new CompletedProcess(_run.removeFirst());
  }
}
