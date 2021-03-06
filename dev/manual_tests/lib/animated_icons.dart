// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedIconsTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animated Icons Test',
      home: Scaffold(
        body: IconsList(),
      ),
    );
  }
}

class IconsList extends StatelessWidget {
  const IconsList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: samples.map<IconSampleRow>((IconSample s) => IconSampleRow(s)).toList(),
    );
  }
}

class IconSampleRow extends StatefulWidget {
  const IconSampleRow(this.sample);

  final IconSample sample;

  @override
  State createState() => IconSampleRowState();
}

class IconSampleRowState extends State<IconSampleRow> with SingleTickerProviderStateMixin {
  AnimationController progress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: () { progress.forward(from: 0.0); },
        child: AnimatedIcon(
          icon: widget.sample.icon,
          progress: progress,
          color: Colors.lightBlue,
        ),
      ),
      title: Text(widget.sample.description),
      subtitle: Slider(
        value: progress.value,
        onChanged: (double v) { progress.animateTo(v, duration: Duration.zero); },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    progress = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    progress.addListener(_handleChange);
  }

  @override
  void dispose() {
    progress.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
  }
}

const List<IconSample> samples = <IconSample> [
  IconSample(AnimatedIcons.arrow_menu, 'arrow_menu'),
  IconSample(AnimatedIcons.menu_arrow, 'menu_arrow'),

  IconSample(AnimatedIcons.close_menu, 'close_menu'),
  IconSample(AnimatedIcons.menu_close, 'menu_close'),

  IconSample(AnimatedIcons.home_menu, 'home_menu'),
  IconSample(AnimatedIcons.menu_home, 'menu_home'),

  IconSample(AnimatedIcons.play_pause, 'play_pause'),
  IconSample(AnimatedIcons.pause_play, 'pause_play'),

  IconSample(AnimatedIcons.list_view, 'list_view'),
  IconSample(AnimatedIcons.view_list, 'view_list'),

  IconSample(AnimatedIcons.add_event, 'add_event'),
  IconSample(AnimatedIcons.event_add, 'event_add'),

  IconSample(AnimatedIcons.ellipsis_search, 'ellipsis_search'),
  IconSample(AnimatedIcons.search_ellipsis, 'search_ellipsis'),
];

class IconSample {
  const IconSample(this.icon, this.description);
  final AnimatedIconData icon;
  final String description;
}

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
// TODO(gspencergoog): Remove once TargetPlatform includes all desktop platforms.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(AnimatedIconsTestApp());
}
