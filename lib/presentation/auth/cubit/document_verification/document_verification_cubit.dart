import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'document_verification_state.dart';

class DocumentVerificationCubit extends Cubit<DocumentVerificationState> {
  DocumentVerificationCubit() : super(const DocumentVerificationState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickFront({required ImageSource source}) async {
    final x = await _picker.pickImage(source: source, imageQuality: 85);
    if (x != null) emit(state.copyWith(frontImage: x.path));
  }

  Future<void> pickBack({required ImageSource source}) async {
    final x = await _picker.pickImage(source: source, imageQuality: 85);
    if (x != null) emit(state.copyWith(backImage: x.path));
  }

  Future<void> pickSelfie({required ImageSource source}) async {
    final x = await _picker.pickImage(source: source, imageQuality: 85);
    if (x != null) emit(state.copyWith(selfieImage: x.path));
  }

  void removeFront() => emit(state.copyWith(clearFront: true));
  void removeBack() => emit(state.copyWith(clearBack: true));
  void removeSelfie() => emit(state.copyWith(clearSelfie: true));

  void reset() => emit(const DocumentVerificationState());
}
