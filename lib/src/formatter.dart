part of '../hint_form_field.dart';

class _AppFormatter {
  static String mask = '';
  static TextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: mask,
    type: MaskAutoCompletionType.lazy,
  );
}
