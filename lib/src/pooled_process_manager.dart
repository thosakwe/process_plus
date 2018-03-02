import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:pool/pool.dart';
import 'package:process/process.dart';
import 'forwarding_process_manager.dart';

/// A [ProcessManager] that uses a [Pool] to limit to the max amount of concurrently-running processes.
class PooledProcessManager extends ForwardingProcessManager {
  final Pool _pool;

  PooledProcessManager(ProcessManager delegate, int maxConcurrentProcesses,
      {Duration timeout})
      : _pool = new Pool(maxConcurrentProcesses, timeout: timeout),
        super(delegate);

  Future close() => _pool.close();

  @override
  Future<Process> start(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment: true,
      bool runInShell: false,
      ProcessStartMode mode: ProcessStartMode.NORMAL}) {
    return _pool.withResource(() {
      return delegate.start(command,
          workingDirectory: workingDirectory,
          environment: environment,
          includeParentEnvironment: includeParentEnvironment,
          runInShell: runInShell,
          mode: mode);
    });
  }

  @override
  Future<ProcessResult> run(List<dynamic> command,
      {String workingDirectory,
      Map<String, String> environment,
      bool includeParentEnvironment: true,
      bool runInShell: false,
      Encoding stdoutEncoding: SYSTEM_ENCODING,
      Encoding stderrEncoding: SYSTEM_ENCODING}) {
    return _pool.withResource(() {
      return delegate.run(command,
          workingDirectory: workingDirectory,
          environment: environment,
          includeParentEnvironment: includeParentEnvironment,
          runInShell: runInShell,
          stdoutEncoding: stdoutEncoding,
          stderrEncoding: stderrEncoding);
    });
  }
}
