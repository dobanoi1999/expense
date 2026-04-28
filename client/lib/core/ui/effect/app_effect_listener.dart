import 'dart:async';

import 'package:client/core/services/snackbar_service.dart';
import 'package:flutter/material.dart';

abstract class UiEffect {}

class ShowSnackbarEffect extends UiEffect {
  final String message;
  final SnackBarType type;
  final Duration duration;
  ShowSnackbarEffect({
    required this.message,
    this.type = SnackBarType.info,
    this.duration = const Duration(seconds: 4),
  });
}

class EffectBus {
  static final _controller = StreamController<UiEffect>.broadcast();

  static Stream<UiEffect> get stream => _controller.stream;

  static void emit(UiEffect effect) {
    _controller.add(effect);
  }
}

class AppEffectListener extends StatefulWidget {
  final Widget child;

  const AppEffectListener({super.key, required this.child});

  @override
  State<AppEffectListener> createState() => _AppEffectListenerState();
}

class _AppEffectListenerState extends State<AppEffectListener> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    _sub = EffectBus.stream.listen((effect) {
      if (effect is ShowSnackbarEffect) {
        SnackBarService.show(
          message: effect.message,
          type: effect.type,
          duration: effect.duration,
        );
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
