import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commen/widgets/appbar/app_bar.dart';
import '../../../../commen/widgets/button/basic_app_button.dart';
import '../../../../commen/widgets/text/custom_country_dropDown.dart';
import '../../../../commen/widgets/text/custom_document_card.dart';
import '../../../../core/widgets/app_snackbar.dart'; 
import '../../cubit/verify_account/verify_account_cubit.dart';
import '../../cubit/verify_account/verify_account_state.dart';
import '../ubload_document/ubload_document_page.dart';

class VerifyAccountView extends StatelessWidget {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyAccountCubit>();

    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Verify Account'),
        hideBack: true,
      ),
      body: SafeArea(
        child: BlocConsumer<VerifyAccountCubit, VerifyAccountState>(
          listenWhen: (prev, curr) =>
              curr is VerifyAccountError || curr is VerifyAccountSuccess,
          listener: (context, state) {
            if (state is VerifyAccountError) {
              AppSnackBar.show(context, message: state.message, isError: true);
            }

            if (state is VerifyAccountSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UploadDocumentPage(
                      selectedDoc: state.document,
                    ),
                  ),
                );
              });
            }
          },
          builder: (context, state) {
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
                          const SizedBox(height: 20),

                          const Text(
                            'Select Country of Resident',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 22),

                          CustomCountryDropdown(
                            onChanged: (country) {
                              cubit.selectCountry(country.name);
                            },
                          ),

                          const SizedBox(height: 35),

                          const Text(
                            'Select a valid Government-issued document',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 22),

                          CustomDocumentCard(
                            title: 'Identity Card',
                            icon: Icons.badge,
                            isSelected: cubit.selectedDocument == 'id',
                            onTap: () => cubit.selectDocument('id'),
                          ),
                          const SizedBox(height: 16),

                          CustomDocumentCard(
                            title: 'Passport',
                            icon: Icons.travel_explore,
                            isSelected: cubit.selectedDocument == 'passport',
                            onTap: () => cubit.selectDocument('passport'),
                          ),
                          const SizedBox(height: 16),

                          CustomDocumentCard(
                            title: "Driver's License",
                            icon: Icons.drive_eta,
                            isSelected: cubit.selectedDocument == 'driver',
                            onTap: () => cubit.selectDocument('driver'),
                          ),

                          const SizedBox(height: 24),

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

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  BasicAppButton(
                    title: 'Continue',
                    onPressed: cubit.submit,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
