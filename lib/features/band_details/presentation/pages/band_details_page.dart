import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setlist/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:setlist/features/band_details/presentation/cubit/band_details/band_details_cubit.dart';
import 'package:setlist/injection_container.dart';

@RoutePage()
class BandDetailsPage extends StatelessWidget {
  final String bandId;

  const BandDetailsPage({required this.bandId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BandDetailsCubit>(
      create: (context) {
        final userId = context.read<AuthCubit>().user.id;

        return serviceLocator<BandDetailsCubit>(param1: bandId)
          ..init(
            userId: userId,
          );
      },
      child: BlocListener<BandDetailsCubit, BandDetailsState>(
        listener: (context, state) {
          if (state is BandDetailsStateDeleted) {
            context.maybePop(state.bandId);
          }
        },
        child: const AutoRouter(),
      ),
    );
  }
}
