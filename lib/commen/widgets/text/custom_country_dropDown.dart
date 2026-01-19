import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

class CustomCountryDropdown extends StatefulWidget {
  final Function(Country)? onChanged;

  const CustomCountryDropdown({super.key, this.onChanged});

  @override
  State<CustomCountryDropdown> createState() => _CustomCountryDropdownState();
}

class _CustomCountryDropdownState extends State<CustomCountryDropdown> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false, // مهم جدًا: يخفي كود التليفون تمامًا
          favorite: ['EG', 'SA', 'US', 'AE', 'GB'], // دول مفضلة في الأعلى
          countryListTheme: CountryListThemeData(
            backgroundColor: AppColors.secondBackground,
            textStyle: const TextStyle(color: Colors.white),
            searchTextStyle: const TextStyle(color: Colors.white),
            inputDecoration: InputDecoration(
              hintText: 'Search country',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country;
            });
            widget.onChanged?.call(country);
          },
        );
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade700, width: 1),
        ),
        child: Row(
          children: [
            // العلم لو مختار
            if (_selectedCountry != null)
              Text(
                _selectedCountry!.flagEmoji,
                style: const TextStyle(fontSize: 24),
              ),

            const SizedBox(width: 12),

            // اسم الدولة أو placeholder
            Expanded(
              child: Text(
                _selectedCountry?.name ?? 'Select country',
                style: TextStyle(
                  color: _selectedCountry == null ? Colors.grey : Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ),

            // السهم ↓
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}