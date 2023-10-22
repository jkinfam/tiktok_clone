import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreddn extends StatefulWidget {
  const VideoTimelineScreddn({super.key});

  @override
  State<VideoTimelineScreddn> createState() => _VideoTimelineScreddnState();
}

class _VideoTimelineScreddnState extends State<VideoTimelineScreddn> {
  int _itemCount = 4;
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 150);
  final _scrollCureve = Curves.linear;
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

  void _onVideoFinished() {}

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) => const VideoPost());
  }
}
