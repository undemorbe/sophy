import 'package:json_annotation/json_annotation.dart';
import 'package:sophy/features/music/domain/entities/track.dart';

part 'track_model.g.dart';

@JsonSerializable()
class TrackModel extends Track {
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'artist')
  final String artist;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'song_url')
  final String songUrl;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'category')
  final String? category;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const TrackModel({
    required String id,
    required this.name,
    required this.artist,
    required this.imageUrl,
    required this.songUrl,
    this.userId,
    this.category,
    required this.createdAt,
  }) : super(
          id: id,
          name: name,
          artist: artist,
          imageUrl: imageUrl,
          songUrl: songUrl,
          userId: userId,
          category: category,
          createdAt: createdAt,
        );

  factory TrackModel.fromJson(Map<String, dynamic> json) =>
      _$TrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);
}
