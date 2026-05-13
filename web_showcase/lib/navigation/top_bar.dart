import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.onLogoTap,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback? onLogoTap;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Material(
      color: c.surface,
      elevation: 0,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: c.border)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: KeenaiSpacing.space24,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: onLogoTap,
              borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KeenaiSpacing.space8,
                  vertical: KeenaiSpacing.space6,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: KeenaiColorsText.green,
                        borderRadius:
                            BorderRadius.circular(KeenaiRadius.radius8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'k',
                        style: KeenaiTypographyBody.body16Semibold
                            .copyWith(color: KeenaiColorsSurface.white),
                      ),
                    ),
                    const SizedBox(width: KeenaiSpacing.space12),
                    Text(
                      'keenai_ds',
                      style: KeenaiTypographyBody.body16Semibold
                          .copyWith(color: c.text),
                    ),
                    const SizedBox(width: KeenaiSpacing.space8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KeenaiSpacing.space8,
                        vertical: KeenaiSpacing.space2,
                      ),
                      decoration: BoxDecoration(
                        color: c.card,
                        borderRadius:
                            BorderRadius.circular(KeenaiRadius.radius1000),
                        border: Border.all(color: c.border),
                      ),
                      child: Text(
                        'showcase',
                        style: KeenaiTypographyBody.body10Regular
                            .copyWith(color: c.muted),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              tooltip: isDark ? 'Switch to light' : 'Switch to dark',
              onPressed: onToggleTheme,
              icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: c.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
