import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("settings"),
        ),
        body: ListView(
          children: [
            CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text('Mute video'),
              subtitle: const Text('video will be muted by default.'),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text('Autoplay'),
              subtitle: const Text('Video will start playing automatically.'),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: const Text('Enable notifications'),
              subtitle: const Text('this is a subtitle'),
            ),
            CheckboxListTile(
              activeColor: Colors.black,
              value: false,
              onChanged: (value) {},
              title: const Text("Enable notifications"),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                final time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (kDebugMode) {
                  print(time);
                }
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                          appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      )),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
              title: const Text('Log out(IOS)'),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Please don go'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        },
                        isDestructiveAction: true,
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Log out(Android)'),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(
                      FontAwesomeIcons.skull,
                    ),
                    title: const Text('Are you sure?'),
                    content: const Text('Please don go'),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Log out(IOS / Bottom)'),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    message: const Text('please dont go'),
                    title: const Text('Are you sure?'),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Not log out"'),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Yes please"'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile()
          ],
        ));
  }
}
