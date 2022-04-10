import 'package:flutter/material.dart';

class EntryButton extends StatelessWidget {
  final Widget _icon;
  final Widget _body;
  final VoidCallback? _onPressed;

  const EntryButton({
    Key? key,
    required Widget icon,
    required Widget body,
    VoidCallback? onPressed,
  })  : _icon = icon,
        _body = body,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
        child: ElevatedButton(
          onPressed: _onPressed,
          child: Padding(
            child: Row(
              children: [
                Padding(
                  child: _icon,
                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                ),
                Flexible(
                  child: _body,
                  fit: FlexFit.tight,
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.black),
        ),
      );
}
