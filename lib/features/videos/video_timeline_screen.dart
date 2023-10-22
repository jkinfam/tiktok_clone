import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTimelineScreddn extends StatefulWidget {
  const VideoTimelineScreddn({super.key});

  @override
  State<VideoTimelineScreddn> createState() => _VideoTimelineScreddnState();
}

class _VideoTimelineScreddnState extends State<VideoTimelineScreddn> {
  int _itemCount = 4;
  final PageController _pageController = PageController();
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(fontSize: 68),
          ),
        ),
      ),
    );
  }
}
