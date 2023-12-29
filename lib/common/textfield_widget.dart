import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:ommyfitness/utils/colours.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {Key? key,
      required this.texttFieldController,
      required this.hintText,
      this.obscureText = false,
      this.formatPrice = false,
      this.allowBlanks = false,
      this.enabled = true,
      this.onSubmitted,
      this.onChanged,
      this.textInputType = TextInputType.name,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding = 15,
      this.hintSize = 10,
      this.color = whiteTwo,
      this.borderColor = whiteTwo,
      this.fillColor = purpleColor2})
      : super(key: key);

  final TextEditingController texttFieldController;
  final String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  bool? formatPrice;
  Color? color;
  Color? fillColor;
  Color? borderColor;
  double? hintSize;
  bool? allowBlanks;
  Function(String)? onSubmitted;
  Function(String)? onChanged;
  bool? enabled;
  double contentPadding;
  TextInputType? textInputType;

  List<TextInputFormatter>? inputFormatList() {
    if (allowBlanks == false) {
      if (formatPrice == true) {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      } else {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
        ];
      }
    } else if (formatPrice == true) {
      if (allowBlanks == true) {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      } else {
        return [
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: color,
      ),
      keyboardType: textInputType,
      controller: texttFieldController,
      obscureText: obscureText!,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatList(),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        iconColor: color,
        prefixIconColor: color,
        suffixIconColor: color,

        fillColor: fillColor,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white.withOpacity(
                  0.5,
                ),
                width: 0.0),
            borderRadius: BorderRadius.circular(8)),
        hintStyle: TextStyle(
          fontSize: hintSize,
          color: color,
        ),

        filled: true,
        isDense: true,
        enabled: enabled!,
        // focusColor: Colors.transparent,
        contentPadding: EdgeInsets.all(contentPadding),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!, width: 0.0),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
