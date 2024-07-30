import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setlist/core/domain/entities/band.dart';
import 'package:setlist/features/auth/presentation/cubit/form_status.dart';
import 'package:setlist/features/band_details/domain/entities/song.dart';
import 'package:setlist/features/band_details/domain/usecases/get_songs_usecase.dart';
import 'package:setlist/features/setlist_editor/domain/entities/setlist_event.dart';

part 'setlist_editor_state.dart';

class SetlistEditorCubit extends Cubit<SetlistEditorState> {
  final Band band;
  final GetSongsUsecase getSongsUsecase;

  SetlistEditorCubit({
    required this.band,
    required this.getSongsUsecase,
  }) : super(SetlistEditorState());

  void loadSongs() async {
    try {
      final songs = await getSongsUsecase.call(bandId: band.id);
      emit(state.copyWith(songs: songs));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error));
    }
  }

  void eventNameChanged(String value) {
    emit(state.copyWith(newEventName: value));
  }

  void setlistNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void addSongEvent(Song song) {
    final newEvent = SetlistEvent(
      name: song.name,
      order: state.events.length + 1,
      length: song.duration ?? 0,
      notes: '',
      songId: song.id,
    );

    emit(
      state.copyWith(
        events: [...state.events, newEvent],
      ),
    );
  }

  void addEvent() {
    final newEvent = SetlistEvent(
      name: state.newEventName,
      order: state.events.length + 1,
      length: state.newEventLength ?? 0,
      notes: '',
      songId: null,
    );

    emit(
      state.copyWith(
        events: [...state.events, newEvent],
        newEventName: '',
        newEventLength: null,
      ),
    );
  }

  void reorderEvents(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final events = state.events;
    final event = events.removeAt(oldIndex);
    events.insert(newIndex, event);

    emit(state.copyWith(events: events));
  }
}
