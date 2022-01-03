import 'package:flutter/material.dart';

class ScrollViewNotificationIndex extends StatefulWidget {
  final Widget child;
  final int itemCount;

  final double dragExtentPercentage;

  ScrollViewNotificationIndex({
    required this.child,
    required this.itemCount,
    this.dragExtentPercentage = 0.2,
  });

  @override
  _ScrollViewNotificationIndexState createState() =>
      _ScrollViewNotificationIndexState();
}

class _ScrollViewNotificationIndexState
    extends State<ScrollViewNotificationIndex> {
  double _dragOffset = 0;

  // late IndexCalculator indexCalculator;

  @override
  void initState() {
    // indexCalculator = IndexCalculator(count: widget.itemCount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleGlowNotification,
        child: widget.child,
      ),
    );
  }

  // -----
  // Handle notifications
  // -----

  bool _handleScrollNotification(ScrollNotification notification) {
    final progress = _calculateScrollProgress(notification);
    final index = indexCalculator.getIndexForScrollPercent(progress);

    return false;
  }

  double _calculateScrollProgress(ScrollNotification notification) {
    final containerExtent = notification.metrics.viewportDimension;

    if (notification is ScrollUpdateNotification) {
      print(notification.scrollDelta);
      _dragOffset -= notification.scrollDelta!;
    }

    if (notification is OverscrollNotification) {
      _dragOffset -= notification.overscroll;
    }

    final percent =
        _dragOffset / (containerExtent * widget.dragExtentPercentage);

    return percent.clamp(0.0, 1.0);
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) return false;

    notification.disallowIndicator();
    return false;
  }
}
