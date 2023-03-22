import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const CustomTextField({Key? key, required this.text, this.textEditingController, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: text,
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 8,
          child: SizedBox(
            height: 39,
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 242, 242, 242),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: textEditingController,
              focusNode: focusNode,
            ),
          ),
        ),
      ],
    );
  }
}
