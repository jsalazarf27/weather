import 'package:flutter/material.dart';

import '../../bloc/base_bloc.dart';
import 'progress_indicator.dart';

class ProgressIndicatorStreamBuilder extends StatelessWidget {
  final BaseBloc baseBloc;

  const ProgressIndicatorStreamBuilder({
    Key? key,
    required this.baseBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: baseBloc.isLoading,
      builder: (context, loadingSnapshot) {
        if (loadingSnapshot.hasData && loadingSnapshot.data!) {
          return const CricleProgressIndicator();
        } else {
          return Container();
        }
      },
    );
  }
}
