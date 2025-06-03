import 'package:flutter/material.dart';
import 'package:cekgizi_mobile/tema.dart';

class CustomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;

  final double circleSize = 40;
  final double horizontalMargin = 24;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _circleAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateCircle(widget.currentIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateCircle(widget.currentIndex);
    }
  }

  void _animateCircle(int newIndex) {
    double width = MediaQuery.of(context).size.width - (horizontalMargin * 2);
    double itemWidth = width / 3;
    double target = newIndex * itemWidth;

    _circleAnimation = Tween<double>(
      begin: _circleAnimation.value,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double navbarWidth = fullWidth - (horizontalMargin * 2);
    double itemWidth = navbarWidth / 3;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      child: Container(
        width: navbarWidth,
        height: 60 + bottomPadding,
        padding: EdgeInsets.only(bottom: bottomPadding),
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 6),
        decoration: BoxDecoration(
          color: warnaHitam,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _circleAnimation,
                builder: (context, child) {
                  double adjustedLeft =
                      _circleAnimation.value + (itemWidth - circleSize) / 2;
                  return Stack(
                    children: [
                      Positioned(
                        left: adjustedLeft,
                        top: 10,
                        child: Container(
                          width: circleSize,
                          height: circleSize,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Row(
                children: [
                  _buildNavItem(Icons.home, 0, itemWidth),
                  _buildNavItem(Icons.camera_alt, 1, itemWidth),
                  _buildNavItem(Icons.person, 2, itemWidth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, double width) {
    bool isActive = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: SizedBox(
        width: width,
        height: 60,
        child: Center(
          child: Icon(
            icon,
            size: 26,
            color: isActive ? warnaHitam : Colors.white,
          ),
        ),
      ),
    );
  }
}
