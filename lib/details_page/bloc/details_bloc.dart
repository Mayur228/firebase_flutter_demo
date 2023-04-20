import 'package:bloc/bloc.dart';
import 'package:firebase_demo_flutter/details_page/bloc/bloc.dart';
import 'package:firebase_demo_flutter/repository/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final FirebaseRepository repository;
  DetailsBloc(this.repository): 
        super(NoDataSate()) {
    on<SingOut>((event, emit) {
      repository.signOut();
      emit(RedirectToLogin());
    } 
    );
  }

  singOut() {
    add(SingOut());
  }
}