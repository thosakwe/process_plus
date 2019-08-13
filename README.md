# process_plus
[![Pub](https://img.shields.io/pub/v/process_plus.svg)](https://pub.dartlang.org/packages/process_plus)
[![build status](https://travis-ci.org/thosakwe/process_plus.svg)](https://travis-ci.org/thosakwe/process_plus)

Helpers for `package:process`.
Including `ForwardingProcessManager`,
`PooledProcessManager`,
`MockProcessManager`, and `CompletedProcess`.

## ForwardingProcessManager
A simple `ProcessManager` that delegates to another one.
Typically used as a base class to extend functionality.

```dart
var manager = ForwwardingProcessManager(const LocalProcessManager());
```

## PooledProcessManager
A `ProcessManager` that uses a `Pool` to limit to the max amount of concurrently-running processes.

```dart
var manager = PooledProcessManager(const LocalProcessManager(), Platform.numberOfProcessors);
```

## MockProcessManager
A `ProcessManager` that can enqueue results in advance, rather than actually spawning OS processes.

```dart
var manager = MockProcessManager();
manager.enqueue(ProcessResult(0, 1337, stdout, stderr));

var p = await manager.run(['foo', '--bar=baz']);
await p.exitCode; // 1337
```

## CompletedProcess
A `Process` implementation that simply outputs the result of a `CompletedProcess`.

```dart
var p = CompletedProcess(ProcessResult(0, 1337, stdout, stderr));
await p.exitCode; // 1337
```