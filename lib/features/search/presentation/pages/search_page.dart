import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhago/features/search/presentation/widgets/search_page_view.dart';
import 'package:sehhago/init_dependencies.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<SearchBloc>()..add(const GetAllDoctorsEvent()),
      child: const SearchPageView(),
    );
  }
}
