import 'package:flutter/material.dart';

import '../const/app_data.dart';
import '../utils/link_text_span.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({Key? key, this.color}) : super(key: key);

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info, color: color),
      onPressed: () {
        showAppAboutDialog(context);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final TextStyle aboutTextStyle = theme.textTheme.bodyLarge!;
  final TextStyle footerStyle = theme.textTheme.bodySmall!;
  final TextStyle linkStyle =
      theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

  final MediaQueryData media = MediaQuery.of(context);
  final double width = media.size.width;
  final double height = media.size.height;

  // Get the card's ShapeBorder from the themed card shape.
  // This was kind of interesting to do, seem to work, for this case at least.
  final ShapeBorder? shapeBorder = theme.cardTheme.shape;
  double buttonRadius = 4; // Default un-themed value
  if (shapeBorder is RoundedRectangleBorder?) {
    final BorderRadiusGeometry? border = shapeBorder?.borderRadius;
    if (border is BorderRadius?) {
      final Radius? radius = border?.topLeft;
      buttonRadius = radius?.x == radius?.y ? (radius?.x ?? 4.0) : 4.0;
    }
  }

  showAboutDialog(
    context: context,
    applicationName: AppData.title(context),
    applicationVersion: AppData.version,
    applicationIcon: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        FlutterLogo(
          size: 100,
        ),
      ],
    ),
    applicationLegalese:
        '${AppData.copyright}\n${AppData.author}\n${AppData.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'The ${AppData.title(context)} app is '
                    '\n\n'
                    'Made by ',
              ),
              LinkTextSpan(
                style: linkStyle,
                uri: Uri.tryParse("https://mohesu.com") ??
                    Uri.parse("https://www.mohesu.com"),
                text: 'mohesu.com',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.\n\n',
              ),
              TextSpan(
                style: footerStyle,
                text: 'Built with Flutter ${AppData.flutterVersion}\n'
                    'Media size (w:${width.toStringAsFixed(0)}, '
                    'h:${height.toStringAsFixed(0)})\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
