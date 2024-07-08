import 'package:json_annotation/json_annotation.dart';
import 'package:setlist/features/dashboard/domain/entities/band.dart';

part 'band_model.g.dart';

@JsonSerializable()
class BandModel implements Band {
  @override
  final String id;

  @override
  final String name;

  @override
  final List<String> memberships;

  BandModel({
    required this.id,
    required this.name,
    required this.memberships,
  });

  factory BandModel.fromJson(Map<String, dynamic> json) => _$BandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BandModelToJson(this);
}
