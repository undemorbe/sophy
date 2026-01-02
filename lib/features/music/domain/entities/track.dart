class Track {
  final String id;
  final String name;
  final String artist;
  final String imageUrl;
  final String songUrl;
  final String? userId;
  final String? category;
  final DateTime createdAt;

  const Track({
    required this.id,
    required this.name,
    required this.artist,
    required this.imageUrl,
    required this.songUrl,
    this.userId,
    this.category,
    required this.createdAt,
  });
}
