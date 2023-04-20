// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_demo_flutter/details_page/bloc/details_bloc.dart'
    as _i5;
import 'package:firebase_demo_flutter/login_page/bloc/login_bloc.dart' as _i6;
import 'package:firebase_demo_flutter/repository/firebase_repository.dart'
    as _i3;
import 'package:firebase_demo_flutter/repository/shared_preferences_repository.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FirebaseRepository>(() => _i3.FirebaseRepository());
    gh.factory<_i4.SharedPreferencesRepository>(
        () => _i4.SharedPreferencesRepository());
    gh.factory<_i5.DetailsBloc>(
        () => _i5.DetailsBloc(gh<_i3.FirebaseRepository>()));
    gh.factory<_i6.LoginBloc>(() => _i6.LoginBloc(
          repository: gh<_i3.FirebaseRepository>(),
          preferencesRepository: gh<_i4.SharedPreferencesRepository>(),
        ));
    return this;
  }
}
