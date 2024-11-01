import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setlist/features/auth/presentation/cubit/form_status.dart';
import 'package:setlist/features/create_band/usecases/create_band_usecase.dart';

part 'create_band_state.dart';

class CreateBandCubit extends Cubit<CreateBandState> {
  final CreateBandUsecase createBandUsecase;

  CreateBandCubit({
    required this.createBandUsecase,
  }) : super(const CreateBandState(
          name: '',
          status: FormStatus.initial,
        ));

  onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  Future<void> createBand({
    required String userId,
    required String founderName,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await createBandUsecase.call(
        bandName: state.name,
        userId: userId,
        founderName: founderName,
      );
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error));
    }
  }
}
