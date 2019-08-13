import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:process/process.dart';

/// A simple [ProcessManager] that delegates to another one.
class ForwardingProcessManager implements ProcessManager {
  final ProcessManager delegate;

  const ForwardingProcessManager(this.delegate);

  @override
  Future<Process> start(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment = true,
      bool runInShell = false,
      ProcessStartMode mode = ProcessStartMode.normal}) {
    return delegate.start(command,
        workingDirectory: workingDirectory,
        environment: environment,
        includeParentEnvironment: includeParentEnvironment,
        runInShell: runInShell,
        mode: mode);
  }

  @override
  Future<ProcessResult> run(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment = true,
      bool runInShell = false,
      Encoding stdoutEncoding = systemEncoding,
      Encoding stderrEncoding = systemEncoding}) {
    return delegate.run(command,
        workingDirectory: workingDirectory,
        environment: environment,
        includeParentEnvironment: includeParentEnvironment,
        runInShell: runInShell,
        stdoutEncoding: stdoutEncoding,
        stderrEncoding: stderrEncoding);
  }

  @override
  ProcessResult runSync(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment = true,
      bool runInShell = false,
      Encoding stdoutEncoding = systemEncoding,
      Encoding stderrEncoding = systemEncoding}) {
    return delegate.runSync(command,
        workingDirectory: workingDirectory,
        environment: environment,
        runInShell: runInShell,
        stdoutEncoding: stdoutEncoding,
        stderrEncoding: stderrEncoding);
  }

  @override
  bool canRun(dynamic executable, {String workingDirectory}) {
    return delegate.canRun(executable, workingDirectory: workingDirectory);
  }

  @override
  bool killPid(int pid, [ProcessSignal signal = ProcessSignal.sigterm]) {
    return delegate.killPid(pid, signal);
  }
}
