import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final double width;
  final List<String> codesItem;
  final bool? showSearchBox;
  final String? hintText, selectedCode;
  final void Function(String?)? onChanged;

  const MyDropdownMenu({
    super.key,
    required this.width,
    required this.codesItem,
    this.selectedCode,
    this.onChanged,
    this.hintText,
    this.showSearchBox,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 8,
            ),
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                // showSearchBox: true,
                showSelectedItems: true,
                emptyBuilder: (context, searchEntry) {
                  return Text('لا يوجد $searchEntry في قواعد البيانات');
                },
                showSearchBox: showSearchBox ?? false,
                searchDelay: Duration.zero,
              ),
              items: codesItem,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText ?? selectedCode,
                ),
              ),
              onChanged: onChanged,
              selectedItem: selectedCode,
            ),
          ),
        ),
      ),
    );
  }
}
