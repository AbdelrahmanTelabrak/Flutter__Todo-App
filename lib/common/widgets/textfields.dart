import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Widget basicFormField(
    {required String hint,
    String? initialValue,
    int? minLines,
    FormFieldValidator? validator,
    Function(String)? onChanged}) {
  return TextFormField(
    maxLines: null,
    minLines: minLines,
    initialValue: initialValue,
    validator: validator,
    onChanged: onChanged,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xffADA4A5),
      ),
      filled: true,
      fillColor: const Color(0xffF7F8F8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      errorStyle: const TextStyle(height: 0),
    ),
  );
}

Widget datePickerFormField(
    {required BuildContext context,
    FormFieldValidator? validator,
    required TextEditingController controller,
    Function(String)? onChanged,
    required Function() onUpdate}) {
  return TextFormField(
    maxLines: 1,
    validator: validator,
    onChanged: onChanged,
    controller: controller,
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
      showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 300, // Adjust width as needed
              height: 400, // Adjust height as needed
              child: SfDateRangePicker(
                backgroundColor: Colors.white,
                view: DateRangePickerView.month,
                showTodayButton: true,
                initialSelectedDate: DateTime.now(),
                showActionButtons: true,
                onSubmit: (value) {
                  String formattedDate = DateFormat('MMMM dd, yyyy')
                      .format(DateTime.parse(value.toString()));
                  controller.text = formattedDate;
                  onChanged!(controller.text);
                  onUpdate();
                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      );
    },
    readOnly: true,
    decoration: InputDecoration(
      suffixIcon: const Icon(
        Icons.calendar_today_rounded,
        color: Color(0xff4A3780),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      hintText: 'Task Date',
      hintStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xffADA4A5),
      ),
      filled: true,
      fillColor: const Color(0xffF7F8F8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      errorStyle: const TextStyle(height: 0),
    ),
  );
}
