import 'package:flutter_bloc/flutter_bloc.dart';

import 'verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(VerifyAccountInitial());

  String? selectedCountry;
  String? selectedDocument;

  void selectCountry(String country) {
    selectedCountry = country;
    emit(VerifyAccountChanged());
  }

  void selectDocument(String doc) {
    selectedDocument = doc;
    emit(VerifyAccountChanged());
  }

  void submit() {
    if (selectedCountry == null || selectedDocument == null) {
      emit(VerifyAccountError('Please complete all fields'));
      return;
    }

    emit(VerifyAccountSuccess(
      country: selectedCountry!,
      document: selectedDocument!,
    ));
  }
}
