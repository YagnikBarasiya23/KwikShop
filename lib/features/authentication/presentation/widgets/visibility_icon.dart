import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visibility_cubit.dart';

class VisibilityIcon extends StatelessWidget {
  const VisibilityIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilityCubit, bool>(
      builder: (context, state) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Icon(
          state == true ? Icons.visibility : Icons.visibility_off,
          key: ValueKey(state ? 1 : 0),
        ),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}
