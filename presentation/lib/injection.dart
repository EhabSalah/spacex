import 'package:data/injection.dart';

import 'ui/screen/home/home_view_model.dart';
import 'ui/screen/next_launch/next_launch_view_model.dart';

void configurePresentationDependencies() {
  getIt.registerFactory(() => HomeViewModel(getIt()));
  getIt.registerFactory(() => NextLaunchViewModel((getIt())));
}
