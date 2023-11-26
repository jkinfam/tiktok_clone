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
  final Duration _scrollDuration = const Duration(milliseconds: 150);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;

      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 40,
      edgeOffset: 10,
      color: Theme.of(context).primaryColor,
      child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageChanged,
          itemCount: _itemCount,
          itemBuilder: (context, index) =>
              VideoPost(onVideoFinished: _onVideoFinished, index: index)),
    );
  }
}
