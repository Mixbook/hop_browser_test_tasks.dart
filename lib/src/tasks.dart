part of hop_browser_test_tasks;

const _COMMAND_OPTION = "content_shell";

Task createBrowserTestTask([OutputParser parser]) {
  var description = "Runs browser tests using content shell. Defaults to running 'test/test.html'";
  parser = parser != null ? parser : standard;
  return new Task((context) => _run(context, parser), description: description, config: _configureArgs);
}

Future _run(TaskContext context, OutputParser parser) {
  var command = context.arguments[_COMMAND_OPTION];
  var file = context.arguments.rest.isNotEmpty ? context.arguments.rest.first : "test/test.html";
  return Process.run(command, ['--dump-render-tree', file])
      .then((result) => parser(result, context));
}

void _configureArgs(ArgParser parser) {
  parser.addOption(_COMMAND_OPTION, help: "The command to execute Content Shell", defaultsTo: "Content Shell");
}
