// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      imageUrl: json['image_url'] as String,
      songUrl: json['song_url'] as String,
      userId: json['user_id'] as String?,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artist': instance.artist,
      'image_url': instance.imageUrl,
      'song_url': instance.songUrl,
      'user_id': instance.userId,
      'category': instance.category,
      'created_at': instance.createdAt.toIso8601String(),
    };
