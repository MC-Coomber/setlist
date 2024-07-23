import 'package:json_annotation/json_annotation.dart';
import 'package:setlist/features/setlist_editor/domain/entities/setlist_event.dart';

part 'setlist_event_model.g.dart';

@JsonSerializable()
class SetlistEventModel implements SetlistEvent {
  @override
  final String name;
  @override
  final int length;
  @override
  final String notes;
  @override
  final String? songId;

  SetlistEventModel({
    required this.name,
    required this.length,
    required this.notes,
    this.songId,
  });

  factory SetlistEventModel.fromEntity(SetlistEvent entity) {
    return SetlistEventModel(
      name: entity.name,
      length: entity.length,
      notes: entity.notes,
      songId: entity.songId,
    );
  }

  factory SetlistEventModel.fromJson(Map<String, dynamic> json) => _$SetlistEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetlistEventModelToJson(this);
}
