// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on _PlayerStore, Store {
  late final _$currentTrackAtom =
      Atom(name: '_PlayerStore.currentTrack', context: context);

  @override
  Track? get currentTrack {
    _$currentTrackAtom.reportRead();
    return super.currentTrack;
  }

  @override
  set currentTrack(Track? value) {
    _$currentTrackAtom.reportWrite(value, super.currentTrack, () {
      super.currentTrack = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: '_PlayerStore.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_PlayerStore.position', context: context);

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAtom =
      Atom(name: '_PlayerStore.duration', context: context);

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PlayerStore.isLoading', context: context);

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

  late final _$playTrackAsyncAction =
      AsyncAction('_PlayerStore.playTrack', context: context);

  @override
  Future<void> playTrack(Track track) {
    return _$playTrackAsyncAction.run(() => super.playTrack(track));
  }

  late final _$pauseAsyncAction =
      AsyncAction('_PlayerStore.pause', context: context);

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$resumeAsyncAction =
      AsyncAction('_PlayerStore.resume', context: context);

  @override
  Future<void> resume() {
    return _$resumeAsyncAction.run(() => super.resume());
  }

  late final _$seekAsyncAction =
      AsyncAction('_PlayerStore.seek', context: context);

  @override
  Future<void> seek(Duration position) {
    return _$seekAsyncAction.run(() => super.seek(position));
  }

  @override
  String toString() {
    return '''
currentTrack: ${currentTrack},
isPlaying: ${isPlaying},
position: ${position},
duration: ${duration},
isLoading: ${isLoading}
    ''';
  }
}
