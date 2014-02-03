library hop_test_tasks.hop_runner;

import 'package:hop/hop.dart';
import 'package:hop_browser_test_tasks/hop_browser_test_tasks.dart';

void main(List<String> args) {
  addTask("test", createBrowserTestTask());
  runHop(args);
}