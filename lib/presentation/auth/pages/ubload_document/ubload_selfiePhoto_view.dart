import 'package:crypto_nest/commen/widgets/appbar/app_bar.dart';
import 'package:crypto_nest/presentation/auth/cubit/document_verification/document_verification_cubit.dart';
import 'package:crypto_nest/presentation/auth/cubit/document_verification/document_verification_state.dart';
import 'package:crypto_nest/presentation/auth/pages/ubload_document/finish_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../core/widgets/app_snackbar.dart'; 

import '../../../rout_page/pages/portfolio/data/portfolio_storage.dart';
import '../../widgets/upload_card.dart';
import '../../widgets/verification_check_item.dart';

class UploadSelfiephotoView extends StatelessWidget {
  const UploadSelfiephotoView({super.key});

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
                          const SizedBox(height: 12),
                          const Text(
                            'Take a Selfie Photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 22),

                          VerificationUploadCard(
                            label: 'Upload Portrait Photo',
                            isUploaded: state.selfieImage != null,
                            imagePath: state.selfieImage,
                            onTap: () {
                              _showPickSheet(
                                context,
                                onCamera: () => cubit.pickSelfie(
                                  source: ImageSource.camera,
                                ),
                                onGallery: () => cubit.pickSelfie(
                                  source: ImageSource.gallery,
                                ),
                              );
                            },
                            onRemove: cubit.removeSelfie,
                          ),
                          const SizedBox(height: 30),

                          const VerificationCheckItem(
                            text:
                                'Take a selfie of yourself with a neutral expression',
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text:
                                'Make sure your whole face is visible, centred, and your eyes are open',
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text: 'Do not crop your ID or screenshots of your ID',
                            valid: false,
                          ),
                          const SizedBox(height: 13),
                          const VerificationCheckItem(
                            text:
                                'Do not hide or alter parts of your face (No hats/ beauty images/ filters/ headgear)',
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
                    onPressed: () async {
                      if (state.selfieImage == null) {
                        AppSnackBar.show(
                          context,
                          message: 'Please upload a selfie photo',
                          isError: true,
                        );
                        return;
                      }

                      await ProfileStorage.saveSelfiePath(state.selfieImage!);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: cubit,
                              child: const FinishVerificationView(),
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
