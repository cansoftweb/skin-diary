import 'package:flutter_bloc/flutter_bloc.dart';

class HomeObserver extends BlocObserver {
  /// {@macro counter_observer}
  const HomeObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }
}
