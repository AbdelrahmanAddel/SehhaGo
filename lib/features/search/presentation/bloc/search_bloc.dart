import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sehhago/features/search/domain/usecases/filter_doctor_usecase.dart';
import '../../domain/usecases/get_all_doctors_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetAllDoctorsUseCase getAllDoctorsUseCase;
  final FilterDoctorUseCase filterDoctorUseCase;

  SearchBloc({
    required this.getAllDoctorsUseCase,
    required this.filterDoctorUseCase,
  }) : super(const SearchState.initial()) {
    on<GetAllDoctorsEvent>(_onGetAllDoctors);
    on<SearchDoctorsEvent>(
      _onSearchDoctors,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<FilterDoctorsEvent>(_onFilterDoctors);
    on<ClearFilterEvent>(_onClearFilter);
  }

  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _onGetAllDoctors(
    GetAllDoctorsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loading());
    final result = await getAllDoctorsUseCase();

    result.fold(
      (failure) => emit(SearchState.error('Failed to fetch doctors')),
      (doctors) =>
          emit(SearchState.loaded(doctors: doctors, filteredDoctors: doctors)),
    );
  }

  void _onSearchDoctors(SearchDoctorsEvent event, Emitter<SearchState> emit) {
    final currentState = state;
    if (currentState is! Loaded) return;

    if (event.query == (currentState.query ?? '')) return;

    final filtered = filterDoctorUseCase.call(
      doctors: currentState.doctors,
      query: event.query,
      category: currentState.category,
      time: currentState.time,
    );

    emit(
      SearchState.loaded(
        doctors: currentState.doctors,
        filteredDoctors: filtered,
        query: event.query,
        category: currentState.category,
        time: currentState.time,
      ),
    );
  }

  // Filter by category / time
  void _onFilterDoctors(FilterDoctorsEvent event, Emitter<SearchState> emit) {
    final currentState = state;
    if (currentState is! Loaded) return;

    final filtered = filterDoctorUseCase.call(
      doctors: currentState.doctors,
      query: currentState.query ?? '',
      category: event.category ?? currentState.category,
      time: event.time ?? currentState.time,
    );

    emit(
      SearchState.loaded(
        doctors: currentState.doctors,
        filteredDoctors: filtered,
        query: currentState.query,
        category: event.category ?? currentState.category,
        time: event.time ?? currentState.time,
      ),
    );
  }

  // Clear filters
  void _onClearFilter(ClearFilterEvent event, Emitter<SearchState> emit) {
    final currentState = state;
    if (currentState is! Loaded) return;

    emit(
      SearchState.loaded(
        doctors: currentState.doctors,
        filteredDoctors: currentState.doctors,
        query: currentState.query,
        category: null,
        time: null,
      ),
    );
  }
}
