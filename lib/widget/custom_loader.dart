import 'package:flutter/material.dart';

class CustomLoaderWidget extends StatefulWidget {
  final bool isTrue;
  final Widget child;

  const CustomLoaderWidget(
      {super.key, required this.isTrue, required this.child});

  //  const CustomLoaderWidget(
  //       {Key? key, required this.isTrue, required this.child})
  //       : super(key: key);
  @override
  State<CustomLoaderWidget> createState() => _CustomLoaderWidgetState();
}

class _CustomLoaderWidgetState extends State<CustomLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<Offset>? offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    offset = Tween<Offset>(
            begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.9))
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTrue) {
      print(controller.status);
      if (AnimationStatus.dismissed == controller.status) controller.forward();
    } else {
      print(controller.status);
      if (AnimationStatus.completed == controller.status) controller.reverse();

      return Container(
        child: widget.child,
      );
    }

    return AbsorbPointer(
      absorbing: widget.isTrue,
      child: Stack(
        children: <Widget>[
          Container(child: widget.child),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black
                  // valueColor:
                  //     AlwaysStoppedAnimation<Color>(AppTheme.pageBackgroundColor),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
