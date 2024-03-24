import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_sharing/features/counter/counter.dart';

/// This provider holds CounternNotifier
final counterPod = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
  name: 'counterPod',
);

///This provider used to seup the intial value
///which can be overriden for test
final intialCounterValuePod = Provider((ref) => 0);
