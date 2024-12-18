import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/preferences/preferences.dart';
import 'package:intl/intl.dart';

enum InputType { filled, outlined, underlined, cupertino }

class BaseInput extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final bool isCupertino;
  final bool isPasswordInput;
  final IconData? iconPrefix;
  final bool disabled;
  final ValueChanged<String>? onChanged;

  const BaseInput._({
    Key? key,
    required this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.isCupertino = false,
    this.isPasswordInput = false,
    this.iconPrefix,
    this.disabled = false,
    this.onChanged,
  });

  factory BaseInput.currency({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    bool disabled = false,
    ValueChanged<String>? onChanged,
  }) {
    return BaseInput._(
      key: key,
      labelText: labelText,
      controller: controller,
      keyboardType: TextInputType.number,
      disabled: disabled,
      onChanged: (value) {
        if (value.isEmpty) {
          controller?.text = '';
          if (onChanged != null) onChanged('');
          return;
        }

        // Remove all non-digit characters
        String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

        // Format the number with Indonesian currency format
        final formatter = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp',
          decimalDigits: 0,
        );

        // Keep original numeric value in controller
        controller?.text = numericValue;

        // Display formatted value
        if (onChanged != null) onChanged(numericValue);

        // Update the display value with formatting
        controller?.value = TextEditingValue(
          text: formatter.format(int.parse(numericValue)),
          selection: TextSelection.collapsed(
            offset: formatter.format(int.parse(numericValue)).length,
          ),
        );
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Dimensions.dp14),
        labelText: labelText,
        border: const UnderlineInputBorder(),
      ),
    );
  }

  factory BaseInput.filled({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPasswordInput = false,
    IconData? iconPrefix,
    bool disabled = false,
    ValueChanged<String>? onChanged,
  }) {
    return BaseInput._(
      key: key,
      labelText: labelText,
      controller: controller,
      keyboardType: keyboardType,
      isPasswordInput: isPasswordInput,
      iconPrefix: iconPrefix,
      disabled: disabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Dimensions.dp14),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  factory BaseInput.outlined({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPasswordInput = false,
    IconData? iconPrefix,
    bool disabled = false,
    ValueChanged<String>? onChanged,
  }) {
    return BaseInput._(
      key: key,
      labelText: labelText,
      controller: controller,
      keyboardType: keyboardType,
      isPasswordInput: isPasswordInput,
      iconPrefix: iconPrefix,
      disabled: disabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Dimensions.dp14),
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  factory BaseInput.underlined({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPasswordInput = false,
    IconData? iconPrefix,
    bool disabled = false,
    ValueChanged<String>? onChanged,
  }) {
    return BaseInput._(
      key: key,
      labelText: labelText,
      controller: controller,
      keyboardType: keyboardType,
      isPasswordInput: isPasswordInput,
      iconPrefix: iconPrefix,
      disabled: disabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Dimensions.dp14),
        labelText: labelText,
        border: const UnderlineInputBorder(),
      ),
    );
  }

  factory BaseInput.cupertino({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPasswordInput = false,
    IconData? iconPrefix,
    bool disabled = false,
    ValueChanged<String>? onChanged,
  }) {
    return BaseInput._(
      key: key,
      labelText: labelText,
      controller: controller,
      keyboardType: keyboardType,
      isCupertino: true,
      isPasswordInput: isPasswordInput,
      iconPrefix: iconPrefix,
      disabled: disabled,
      onChanged: onChanged,
    );
  }

  @override
  _BaseInputState createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPasswordInput;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCupertino) {
      return CupertinoTextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        placeholder: widget.labelText,
        obscureText: _isObscured,
        enabled: !widget.disabled,
        suffix: widget.isPasswordInput
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child:
                    Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
              )
            : null,
        prefix: widget.iconPrefix != null ? Icon(widget.iconPrefix) : null,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.inactiveGray,
              width: 0.5,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      );
    } else {
      return TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isObscured,
        enabled: !widget.disabled,
        onChanged: widget.onChanged,
        decoration: widget.decoration?.copyWith(
          suffixIcon: widget.isPasswordInput
              ? IconButton(
                  icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
          prefixIcon:
              widget.iconPrefix != null ? Icon(widget.iconPrefix) : null,
        ),
      );
    }
  }
}
