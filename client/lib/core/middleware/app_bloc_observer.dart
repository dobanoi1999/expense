import 'package:client/core/error/bloc_error.dart';
import 'package:client/core/services/snackbar_service.dart';
import 'package:client/core/ui/effect/app_effect_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (error is BlocError) {
      EffectBus.emit(
        ShowSnackbarEffect(message: error.message, type: SnackBarType.error),
      );
    } else {
      EffectBus.emit(
        ShowSnackbarEffect(
          message: 'Unexpected error',
          type: SnackBarType.error,
        ),
      );
    }
  }
}
