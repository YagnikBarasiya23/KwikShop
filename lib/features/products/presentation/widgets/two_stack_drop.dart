import 'package:flutter/material.dart';
import 'package:kwikshop/features/cart/presentation/screens/cart_screen.dart';
import '../../../categories/domain/entities.dart';

const double _kFlingVelocity = 2.0;

class TwoStackDrop extends StatefulWidget {
  final Categories currentCategory;
  final Widget productsLayer;
  final Widget categoriesLayer;
  final String storeName;

  const TwoStackDrop({
    required this.storeName,
    required this.currentCategory,
    required this.productsLayer,
    required this.categoriesLayer,
    Key? key,
  }) : super(key: key);

  @override
  State<TwoStackDrop> createState() => _TwoStackDropState();
}

class _TwoStackDropState extends State<TwoStackDrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300), value: 1);
    super.initState();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _animationController.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void didUpdateWidget(TwoStackDrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _animationController.fling(velocity: _kFlingVelocity);
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerTopAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animationController.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.categoriesLayer,
        PositionedTransition(
          rect: layerTopAnimation,
          child: _FrontLayer(
            child: widget.productsLayer,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: colorScheme.surface,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          fontSize: 18,
        ),
        backgroundColor: colorScheme.secondary,
        title: Text(widget.storeName),
        iconTheme: IconThemeData(
          color: colorScheme.onSecondary,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: _toggleBackdropLayerVisibility,
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              semanticLabel: 'cart',
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              CartScreen.routeName,
              arguments: widget.storeName,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
