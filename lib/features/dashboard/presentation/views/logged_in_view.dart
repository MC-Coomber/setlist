import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setlist/features/dashboard/presentation/cubit/dashboard/dashboard_cubit.dart';

class LoggedInView extends StatelessWidget {
  const LoggedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final loggedInState = state as DashboardLoggedIn;

        return Column(
          children: [
            Text(loggedInState.currentMusician.name),
            if (state.bands.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: state.bands.length,
                  itemBuilder: (context, index) {
                    final band = state.bands[index];
                    return Card(
                      child: Text(band.name),
                    );
                  },
                ),
              )
            else
              const Text('No Results'),
          ],
        );
      },
    );
  }
}
