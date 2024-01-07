import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreddn extends ConsumerStatefulWidget {
  const VideoTimelineScreddn({super.key});

  @override
  VideoTimelineScreddnState createState() => VideoTimelineScreddnState();
}

class VideoTimelineScreddnState extends ConsumerState<VideoTimelineScreddn> {
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
    return ref.watch(timelineProvider).when(
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Center(
              child: Text(
                'Could not load videos: $error',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        data: (videos) => RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 40,
              edgeOffset: 10,
              color: Theme.of(context).primaryColor,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: _onPageChanged,
                  itemCount: videos.length,
                  itemBuilder: (context, index) => VideoPost(
                      onVideoFinished: _onVideoFinished, index: index)),
            ));
  }
}
