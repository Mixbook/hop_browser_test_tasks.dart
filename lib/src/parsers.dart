part of hop_browser_test_tasks;

typedef void OutputParser(ProcessResult result, TaskContext context);

final OutputParser standard = (ProcessResult result, TaskContext context) {
  var failures = new RegExp(r"FAIL:([\s\S]+?)CONSOLE").allMatches(result.stdout);
  failures.forEach((failure) {
    context.getSubContext("FAIL").severe(failure.group(1));
  });

  var errors = new RegExp(r"ERROR:([\s\S]+?)CONSOLE").allMatches(result.stdout);
  errors.forEach((error) {
    context.getSubContext("ERROR").severe(error.group(1));
  });

  var summary = new RegExp(r"All \d+ tests passed.");
  var hasSummary = summary.hasMatch(result.stdout);
  if (hasSummary) {
    context.info(summary.firstMatch(result.stdout).group(0));
  }

  if (errors.isNotEmpty || failures.isNotEmpty) {
    context.fail("Tests failed.");
  } else if (!hasSummary) {
    context.severe(result.stdout);
    context.fail("Tests unable to complete. Maybe because of a syntax error.");
  }
};