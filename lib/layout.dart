import 'package:flutter/cupertino.dart';

class CenterAbout extends StatelessWidget {
  final Offset position;
  final Widget child;

  CenterAbout({Key key, this.position, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: position.dy,
      left: position.dx,
      child: new FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}

class OverlayBuilder extends StatefulWidget {
  final bool showOverlay;
  final Widget Function(BuildContext context) overlayBuilder;
  final Widget child;

  OverlayBuilder({this.showOverlay, this.overlayBuilder, this.child});

  @override
  _OverlayBuilderState createState() => new _OverlayBuilderState();
}

class _OverlayBuilderState extends State<OverlayBuilder> {
  OverlayEntry overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.showOverlay) {
      showOverlay();
    }
  }

  @override
  void didUpdateWidget(OverlayBuilder oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    syncWidgetAndOverlay();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    syncWidgetAndOverlay();
  }

  @override
  void dispose() {
    if (isShowingOverlay()) {
      hideOverlay();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void showOverlay() {
    overlayEntry = new OverlayEntry(
      builder: widget.overlayBuilder,
    );

    addToOverlay(overlayEntry);
  }

  void syncWidgetAndOverlay() {
    if (isShowingOverlay() && !widget.showOverlay) {
      hideOverlay();
    } else if (!isShowingOverlay() && widget.showOverlay) {
      showOverlay();
    }
  }

  bool isShowingOverlay() => overlayEntry != null;

  void hideOverlay() {
    overlayEntry.remove();
    overlayEntry = null;
  }

  void addToOverlay(OverlayEntry overlayEntry) async {
    Overlay.of(context).insert(overlayEntry);
  }
}

class AnchoredOverlay extends StatelessWidget {
  final bool showOverlay;
  final Widget child;
  final Widget Function(BuildContext context, Offset anchor) builder;

  AnchoredOverlay({this.showOverlay, this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        return new OverlayBuilder(
          showOverlay: showOverlay,
          overlayBuilder: (BuildContext overlayContext) {
            Offset center = _getCenterAnchor(context);
            print("center - $center");
            return builder(overlayContext, center);
          },
          child: child,
        );
      },
    );
  }

  Offset _getCenterAnchor(BuildContext context) {
    var box = context.findRenderObject() as RenderBox;
    return box.size.center(box.localToGlobal(new Offset(0.0, 0.0)));
  }
}
