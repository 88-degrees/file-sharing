import 'package:file_sharing/app/app.dart';
import 'package:file_sharing/bootstrap.dart';

/// This entry point should be used for staging only
void main() {
  ///You can override your environment variable in bootstrap method here for providers
  bootstrap(() => const App());
}
