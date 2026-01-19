import 'package:crypto_nest/presentation/auth/cubit/document_verification/document_verification_cubit.dart';
import 'package:crypto_nest/presentation/auth/pages/ubload_document/ubload_document_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadDocumentPage extends StatelessWidget {
  final String selectedDoc;

  const UploadDocumentPage({super.key, required this.selectedDoc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return DocumentVerificationCubit();
      },
      child: UbloadDocumentView(selectedDoc: selectedDoc),
    );
  }
}
