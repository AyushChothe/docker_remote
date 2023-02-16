import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WatchListTile extends SingleChildRenderObjectWidget {
  const WatchListTile({super.key, super.child, this.fixedHeight = 50});

  final double fixedHeight;

  @override
  void updateRenderObject(BuildContext context, RenderWatchTile renderObject) {
    super.updateRenderObject(context, renderObject..fixedHeight = fixedHeight);
  }

  @override
  RenderWatchTile createRenderObject(BuildContext context) =>
      RenderWatchTile(fixedHeight: fixedHeight);
}

class RenderWatchTile extends RenderSliverSingleBoxAdapter {
  RenderWatchTile({super.child, required this.fixedHeight});

  double fixedHeight;

  double width(SliverConstraints con) {
    final position = (((parentData as SliverPhysicalParentData).paintOffset.dy +
            (fixedHeight / 2)) /
        con.viewportMainAxisExtent);

    return (con.crossAxisExtent * (1.0 - (position.clamp(0, 1) - 0.5).abs()))
        .clamp(con.crossAxisExtent * .70, con.crossAxisExtent);
  }

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;

    child!.layout(
        constraints.asBoxConstraints(
          maxExtent: fixedHeight,
          crossAxisExtent: width(constraints),
        ),
        parentUsesSize: true);

    final double childExtent;

    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && geometry!.visible) {
      final SliverConstraints constraints = this.constraints;
      super.paint(
        context,
        Offset(
            (constraints.crossAxisExtent - width(constraints)) / 2, offset.dy),
      );
    }
  }
}
