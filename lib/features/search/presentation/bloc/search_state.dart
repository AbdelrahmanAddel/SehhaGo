import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import '../../../auth/domain/entities/user_entity.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = Initial;
  const factory SearchState.loading() = Loading;
  const factory SearchState.loaded({
    required List<UserEntity> doctors,
    required List<UserEntity> filteredDoctors,
    String? category,
    TimeOfDay? time,
    String? query,
  }) = Loaded;
  const factory SearchState.error(String message) = Error;
}
