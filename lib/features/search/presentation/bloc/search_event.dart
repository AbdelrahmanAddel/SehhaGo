import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class GetAllDoctorsEvent extends SearchEvent {
  const GetAllDoctorsEvent();
}

class SearchDoctorsEvent extends SearchEvent {
  final String query;

  const SearchDoctorsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterDoctorsEvent extends SearchEvent {
  final String? category;
  final TimeOfDay? time;

  const FilterDoctorsEvent({this.category, this.time});

  @override
  List<Object?> get props => [category, time];
}

class ClearFilterEvent extends SearchEvent {
  const ClearFilterEvent();
}
