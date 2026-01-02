// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicStore on _MusicStore, Store {
  Computed<List<Track>>? _$filteredTracksComputed;

  @override
  List<Track> get filteredTracks => (_$filteredTracksComputed ??=
          Computed<List<Track>>(() => super.filteredTracks,
              name: '_MusicStore.filteredTracks'))
      .value;
  Computed<List<Track>>? _$recommendationsComputed;

  @override
  List<Track> get recommendations => (_$recommendationsComputed ??=
          Computed<List<Track>>(() => super.recommendations,
              name: '_MusicStore.recommendations'))
      .value;

  late final _$tracksAtom = Atom(name: '_MusicStore.tracks', context: context);

  @override
  ObservableList<Track> get tracks {
    _$tracksAtom.reportRead();
    return super.tracks;
  }

  @override
  set tracks(ObservableList<Track> value) {
    _$tracksAtom.reportWrite(value, super.tracks, () {
      super.tracks = value;
    });
  }

  late final _$favoritesAtom =
      Atom(name: '_MusicStore.favorites', context: context);

  @override
  ObservableList<Track> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<Track> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MusicStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isUploadingAtom =
      Atom(name: '_MusicStore.isUploading', context: context);

  @override
  bool get isUploading {
    _$isUploadingAtom.reportRead();
    return super.isUploading;
  }

  @override
  set isUploading(bool value) {
    _$isUploadingAtom.reportWrite(value, super.isUploading, () {
      super.isUploading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MusicStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_MusicStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_MusicStore.selectedCategory', context: context);

  @override
  String? get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String? value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$fetchTracksAsyncAction =
      AsyncAction('_MusicStore.fetchTracks', context: context);

  @override
  Future<void> fetchTracks() {
    return _$fetchTracksAsyncAction.run(() => super.fetchTracks());
  }

  late final _$uploadTrackAsyncAction =
      AsyncAction('_MusicStore.uploadTrack', context: context);

  @override
  Future<void> uploadTrack(
      {required String name,
      required String artist,
      required File imageFile,
      required File songFile,
      required String? category}) {
    return _$uploadTrackAsyncAction.run(() => super.uploadTrack(
        name: name,
        artist: artist,
        imageFile: imageFile,
        songFile: songFile,
        category: category));
  }

  late final _$_MusicStoreActionController =
      ActionController(name: '_MusicStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_MusicStoreActionController.startAction(
        name: '_MusicStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_MusicStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String? category) {
    final _$actionInfo = _$_MusicStoreActionController.startAction(
        name: '_MusicStore.setCategory');
    try {
      return super.setCategory(category);
    } finally {
      _$_MusicStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFavorite(Track track) {
    final _$actionInfo = _$_MusicStoreActionController.startAction(
        name: '_MusicStore.toggleFavorite');
    try {
      return super.toggleFavorite(track);
    } finally {
      _$_MusicStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tracks: ${tracks},
favorites: ${favorites},
isLoading: ${isLoading},
isUploading: ${isUploading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
selectedCategory: ${selectedCategory},
filteredTracks: ${filteredTracks},
recommendations: ${recommendations}
    ''';
  }
}
