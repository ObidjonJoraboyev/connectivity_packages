import 'package:connectivity_packages/blocs/currency_bloc.dart';
import 'package:connectivity_packages/blocs/currency_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CurrencyBloc()..add(GetCurrenciesFromDatabase()))
      ],
      child: const App(),
    ),
  );
}
