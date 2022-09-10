library flutter_theme;

export 'src/input_colors_selector.dart';
export 'src/theme_controller.dart';
export 'src/theme_selector.dart';
export 'src/const/app_color.dart';
export 'src/const/app_data.dart';
export 'src/const/flex_tone.dart';
export 'src/const/store.dart';
export 'src/services/theme_service.dart';
export 'src/services/theme_service_hive.dart';
export 'src/services/theme_service_hive_adapters.dart';
export 'src/services/theme_service_mem.dart';
export 'src/services/theme_service_prefs.dart';
export 'src/theme/code_theme.dart';
export 'src/theme/flex_theme_dark.dart';
export 'src/theme/flex_theme_light.dart';
export 'src/theme/theme_data_dark.dart';
export 'src/theme/theme_data_light.dart';
export 'src/universal/about.dart';
export 'src/universal/animated_switch_hide.dart';
export 'src/universal/header_card.dart';
export 'src/universal/maybe_tooltip.dart';
export 'src/universal/navigation_bar_label_behavior_buttons.dart';
export 'src/universal/navigation_rail_label_type_buttons.dart';
export 'src/universal/page_body.dart';
export 'src/universal/responsive_dialog.dart';
export 'src/universal/responsive_scaffold.dart';
export 'src/universal/stateful_header_card.dart';
export 'src/universal/switch_list_tile_adaptive.dart';
export 'src/universal/syntax_highlighter.dart';
export 'src/universal/theme_mode_switch.dart';
export 'src/universal/theme_showcase.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flutter_theme.dart';

final themeControllerProvider = Provider.family<ThemeController, ThemeService>(
  (ref, themeService) {
    return ThemeController(themeService);
  },
);
