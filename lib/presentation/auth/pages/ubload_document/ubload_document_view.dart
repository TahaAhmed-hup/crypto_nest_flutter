import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commen/widgets/appbar/app_bar.dart';
import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../core/widgets/app_snackbar.dart'; // ✅ NEW
import '../../cubit/document_verification/document_verification_cubit.dart';
import '../../cubit/document_verification/document_verification_state.dart';
import '../../widgets/upload_card.dart';
import '../../widgets/verification_check_item.dart';
import 'ubload_selfiePhoto_view.dart';

class UbloadDocumentView extends StatelessWidget {
  final String selectedDoc;
  bool get isPassport => selectedDoc == 'passport';

  const UbloadDocumentView({super.key, required this.selectedDoc});

  String get documentName {
    if (selectedDoc == 'id') return 'ID Card';
    if (selectedDoc == 'passport') return 'Passport';
    if (selectedDoc == 'driver') return "Driver's License";
    return selectedDoc;
  }

  void _showPickSheet(
    BuildContext context, {
    required VoidCallback onCamera,
    required VoidCallback onGallery,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.white),
                  title: const Text(
                    'Camera',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.white),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Verify Account')),
      body: SafeArea(
        child: BlocBuilder<DocumentVerificationCubit, DocumentVerificationState>(
          builder: (context, state) {
            final cubit = context.read<DocumentVerificationCubit>();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Image of $documentName',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 22),

                          // Front
                          VerificationUploadCard(
                            label: 'Upload front page',
                            isUploaded: state.frontImage != null,
                            imagePath: state.frontImage,
                            onTap: () {
                              _showPickSheet(
                                context,
                                onCamera: () =>
                                    cubit.pickFront(source: ImageSource.camera),
                                onGallery: () =>
                                    cubit.pickFront(source: ImageSource.gallery),
                              );
                            },
                            onRemove: cubit.removeFront,
                          ),

                          const SizedBox(height: 20),

                          // Back
                          if (!isPassport) ...[
                            const SizedBox(height: 20),
                            VerificationUploadCard(
                              label: 'Upload back page',
                              isUploaded: state.backImage != null,
                              imagePath: state.backImage,
                              onTap: () {
                                _showPickSheet(
                                  context,
                                  onCamera: () => cubit.pickBack(
                                    source: ImageSource.camera,
                                  ),
                                  onGallery: () => cubit.pickBack(
                                    source: ImageSource.gallery,
                                  ),
                                );
                              },
                              onRemove: cubit.removeBack,
                            ),
                          ],

                          const SizedBox(height: 30),

                          const VerificationCheckItem(text: 'Government-issued'),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text: 'Original full-size, unedited document',
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text:
                                'Place documents against a single-coloured background',
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text: 'Readable, well-lit coloured images',
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text: 'No black and white images',
                            valid: false,
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text: 'No edited or expired documents',
                            valid: false,
                          ),

                          const SizedBox(height: 24),

                          

                          
                        ],
                      ),
                    ),
                  ),
                  Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'This information is used for identity verification only, and will be kept secure by CrypCoin',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
const SizedBox(height: 15),
                  BasicAppButton(
                    title: 'Continue',
                    width: double.infinity,
                    onPressed: () {
                      // Passport → Front بس
                      if (isPassport) {
                        if (state.frontImage == null) {
                          AppSnackBar.show(
                            context,
                            message: 'Please upload passport image',
                            isError: true,
                          );
                          return;
                        }
                      }
                      // ID / Driver → Front + Back
                      else {
                        if (state.frontImage == null || state.backImage == null) {
                          AppSnackBar.show(
                            context,
                            message: 'Please upload both front and back images',
                            isError: true,
                          );
                          return;
                        }
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: cubit,
                              child: const UploadSelfiephotoView(),
                            ),
                          ),
                        );
                      });
                    },
                  ),

                  const SizedBox(height: 35),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
