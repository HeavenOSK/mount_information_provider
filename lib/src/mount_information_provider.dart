import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget which provides mount information of child.
///
///
class MountInformationProvider extends SingleChildRenderObjectWidget {
  const MountInformationProvider({
    Key key,

    /// The widget which is wanted to get the mount information.
    Widget child,
    @required this.onRegionChanged,
  })  : assert(onRegionChanged != null),
        super(key: key, child: child);

  /// A callback to notify mount information of child.
  final void Function(
    Offset position,
    Size size,
  ) onRegionChanged;

  @override
  _MountInformationListnableRenderObject createRenderObject(
      BuildContext context) {
    return _MountInformationListnableRenderObject(
      onRegionChanged: onRegionChanged,
    );
  }
}

class _MountInformationListnableRenderObject extends RenderProxyBox {
  _MountInformationListnableRenderObject({
    @required this.onRegionChanged,
  })  : assert(onRegionChanged != null),
        super(null);

  final void Function(
    Offset position,
    Size size,
  ) onRegionChanged;

  Size _currentSize;
  Offset _currentPosition;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    _notifyMountInformation();
  }

  @override
  void performLayout() {
    super.performLayout();
    _notifyMountInformation();
  }

  void _notifyMountInformation() {
    Future(() {
      final pos = this.localToGlobal(Offset.zero);
      final size = this.size;

      if (size != _currentSize || pos != _currentPosition) {
        _currentSize = size;
        _currentPosition = pos;
        onRegionChanged?.call(pos, size);
      }
    });
  }
}
