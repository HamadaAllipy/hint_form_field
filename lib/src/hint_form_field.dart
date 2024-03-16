part of '../hint_form_field.dart';

class HintFormField extends StatefulWidget {

  final Color? hintColor;
  final Color? textColor;
  final double? fontSize;
  final InputBorder? border;
  final String hintFormat;


  const HintFormField({
    super.key,
    this.hintColor,
    this.textColor,
    this.fontSize,
    this.border,
    required this.hintFormat,
  });

  @override
  State<HintFormField> createState() => _HintFormFieldState();
}

class _HintFormFieldState extends State<HintFormField> {

  late final TextEditingController _controller;
  String _hintText = '';
  String _previousText = '';


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formatterHint();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _formatterHint() {
    _AppFormatter.mask = widget.hintFormat;
    setState(() {
      _hintText = widget.hintFormat.replaceAll('#', '0');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: InputDecorator(
        isEmpty: true,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: widget.hintColor??Colors.grey ,
            fontFeatures: [const FontFeature.tabularFigures()],
            fontSize: widget.fontSize,

          ),
          hintTextDirection: TextDirection.ltr,
          border: widget.border,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0
          ),
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),

          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFeatures: [const FontFeature.tabularFigures()],
            color: widget.textColor,
            fontSize: widget.fontSize,
          ),
          inputFormatters: [
            _AppFormatter.maskFormatter,
          ],
          onChanged: _onChanged,
        ),
      ),
    );
  }

  void _onChanged(String value) {
    final baseOffset = _controller.selection.baseOffset;
    if (value.length < _previousText.length) {
      String result = _hintText;
      List<int> spaceIndices = [];
      int currentIndex = _previousText.indexOf(' ');
      while (currentIndex != -1) {
        spaceIndices.add(currentIndex);
        currentIndex = _previousText.indexOf(' ', currentIndex + 1);
      }
      if (spaceIndices.isEmpty) {
        result = _hintText.replaceRange(baseOffset, baseOffset + 1, '0');
      } else if (spaceIndices.last != baseOffset) {
        result = _hintText.replaceRange(baseOffset, baseOffset + 1, '0');
      } else {
        result = _hintText.replaceRange(baseOffset + 1, baseOffset + 2, '0');
      }
      _hintText = result;
    } else {
      String result = _hintText.replaceRange(
          baseOffset - 1, baseOffset, value.split('').last);
      _hintText = result;
    }
    _previousText = value;
    setState(() {});
  }
}



