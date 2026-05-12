import 'package:flutter/widgets.dart';
import 'package:keenai_ds/keenai_ds.dart';

/// Holdings overview: header, filter chips, and scrollable positions.
///
/// List rows are built with design tokens only (no change pills). Chips still
/// use [DsChip] from `keenai_ds`.
class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({super.key});

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  static const List<_FilterChip> _filters = [
    _FilterChip(_HoldingKind.all, 'All'),
    _FilterChip(_HoldingKind.stock, 'Stocks'),
    _FilterChip(_HoldingKind.etf, 'ETFs'),
    _FilterChip(_HoldingKind.hedgeFund, 'Hedge Funds'),
    _FilterChip(_HoldingKind.fcn, 'FCNs'),
  ];

  _HoldingKind _selectedKind = _HoldingKind.all;

  static final List<_Holding> _holdings = [
    _Holding(
      title: 'Apple',
      kind: _HoldingKind.stock,
      categoryTag: 'Stock',
      primaryValue: '42,318.40',
      currency: 'USD',
      qtyLine: 'Qty 180',
      changePercent: 1.24,
    ),
    _Holding(
      title: 'Tesla',
      kind: _HoldingKind.stock,
      categoryTag: 'Stock',
      primaryValue: '18,942.00',
      currency: 'USD',
      qtyLine: 'Qty 60',
      changePercent: -2.87,
    ),
    _Holding(
      title: 'Google',
      kind: _HoldingKind.stock,
      categoryTag: 'Stock',
      primaryValue: '31,205.75',
      currency: 'USD',
      qtyLine: 'Qty 140',
      changePercent: 0.42,
    ),
    _Holding(
      title: 'Nifty 50',
      kind: _HoldingKind.etf,
      categoryTag: 'ETF',
      primaryValue: '9,840.00',
      currency: 'USD',
      qtyLine: 'Qty 420',
      changePercent: 0.55,
    ),
    _Holding(
      title: 'S&P 500',
      kind: _HoldingKind.etf,
      categoryTag: 'ETF',
      primaryValue: '22,110.20',
      currency: 'USD',
      qtyLine: 'Qty 95',
      changePercent: -0.31,
    ),
    _Holding(
      title: 'Apex Multi-Strategy',
      kind: _HoldingKind.hedgeFund,
      categoryTag: 'Hedge Fund',
      primaryValue: '250,000.00',
      currency: 'USD',
      qtyLine: 'Units 250',
      changePercent: 0.18,
    ),
    _Holding(
      title: 'USD SGD FCN Dec 26',
      kind: _HoldingKind.fcn,
      categoryTag: 'FCN',
      primaryValue: '75,500.00',
      currency: 'USD',
      qtyLine: 'Notional 1',
      changePercent: -0.09,
    ),
  ];

  Iterable<_Holding> get _visibleHoldings {
    if (_selectedKind == _HoldingKind.all) return _holdings;
    return _holdings.where((h) => h.kind == _selectedKind);
  }

  String get _totalPortfolioLabel {
    var sum = 0.0;
    for (final h in _holdings) {
      sum += h._approxUsdValue;
    }
    final parts = sum.toStringAsFixed(2).split('.');
    return '\$${_commaInt(parts[0])}.${parts[1]}';
  }

  static String _commaInt(String intPart) {
    if (intPart.length <= 3) return intPart;
    final rev = intPart.split('').reversed.join();
    final buf = StringBuffer();
    for (var i = 0; i < rev.length; i++) {
      if (i > 0 && i % 3 == 0) buf.write(',');
      buf.write(rev[i]);
    }
    return buf.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: KeenaiColorsSurface.bg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                KeenaiSpacing.space20,
                KeenaiSpacing.space24,
                KeenaiSpacing.space20,
                KeenaiSpacing.space12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Holdings',
                    style: KeenaiTypographyDisplay.display22Semibold
                        .copyWith(color: KeenaiColorsText.main),
                  ),
                  const SizedBox(height: KeenaiSpacing.space8),
                  Text(
                    _totalPortfolioLabel,
                    style: KeenaiTypographyDisplay.display26Medium
                        .copyWith(color: KeenaiColorsText.main),
                  ),
                  const SizedBox(height: KeenaiSpacing.space4),
                  Text(
                    'Total portfolio value',
                    style: KeenaiTypographyBody.body12Regular
                        .copyWith(color: KeenaiColorsText.muted),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: KeenaiColorsBorder.light,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                KeenaiSpacing.space16,
                KeenaiSpacing.space12,
                KeenaiSpacing.space16,
                KeenaiSpacing.space8,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < _filters.length; i++) ...[
                      if (i > 0) const SizedBox(width: KeenaiSpacing.space8),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(
                          () => _selectedKind = _filters[i].kind,
                        ),
                        child: DsChip(
                          label: _filters[i].label,
                          variant: _filters[i].kind == _selectedKind
                              ? DsChipVariant.selected
                              : DsChipVariant.outlined,
                          showLeadingIcon: false,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: KeenaiColorsSurface.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(KeenaiRadius.radius16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(KeenaiRadius.radius16),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(
                      bottom: KeenaiSpacing.space24,
                    ),
                    children: [
                      for (final h in _visibleHoldings)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: KeenaiSpacing.space16,
                          ),
                          child: _HoldingRow(holding: h),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One holding line: left = title, tag, **qty** (text only); right = value and
/// **change %** (text only, green / red / muted — no pills).
class _HoldingRow extends StatelessWidget {
  const _HoldingRow({required this.holding});

  final _Holding holding;

  @override
  Widget build(BuildContext context) {
    final titleStyle = KeenaiTypographyBody.body14Medium
        .copyWith(color: KeenaiColorsText.main);
    final tagStyle = KeenaiTypographyBody.body12Regular.copyWith(
      color: KeenaiColorsText.muted,
      height: titleStyle.height,
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: KeenaiColorsBorder.light, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KeenaiSpacing.space16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Flexible(
                        child: Text(
                          holding.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: titleStyle,
                        ),
                      ),
                      const SizedBox(width: KeenaiSpacing.space6),
                      Text('\u00B7', style: tagStyle),
                      const SizedBox(width: KeenaiSpacing.space6),
                      Text(holding.categoryTag, style: tagStyle),
                    ],
                  ),
                  const SizedBox(height: KeenaiSpacing.space4),
                  Text(
                    holding.qtyLine,
                    style: KeenaiTypographyBody.body12Regular
                        .copyWith(color: KeenaiColorsText.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: KeenaiSpacing.space32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      holding.primaryValue,
                      style: KeenaiTypographyBody.body14Semibold
                          .copyWith(color: KeenaiColorsText.main),
                    ),
                    const SizedBox(width: KeenaiSpacing.space4),
                    Text(
                      holding.currency,
                      style: KeenaiTypographyBody.body10Semibold
                          .copyWith(color: KeenaiColorsText.muted),
                    ),
                  ],
                ),
                const SizedBox(height: KeenaiSpacing.space4),
                Text(
                  holding.changeLabel,
                  style: KeenaiTypographyBody.body12Medium
                      .copyWith(color: holding.changeColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _HoldingKind { all, stock, etf, hedgeFund, fcn }

class _FilterChip {
  const _FilterChip(this.kind, this.label);
  final _HoldingKind kind;
  final String label;
}

class _Holding {
  const _Holding({
    required this.title,
    required this.kind,
    required this.categoryTag,
    required this.primaryValue,
    required this.currency,
    required this.qtyLine,
    required this.changePercent,
  });

  final String title;
  final _HoldingKind kind;
  final String categoryTag;
  final String primaryValue;
  final String currency;
  final String qtyLine;
  final double changePercent;

  String get changeLabel {
    final sign = changePercent > 0
        ? '+'
        : changePercent < 0
            ? ''
            : '';
    return '$sign${changePercent.toStringAsFixed(2)}%';
  }

  Color get changeColor {
    if (changePercent > 0) return KeenaiColorsText.green;
    if (changePercent < 0) return KeenaiColorsText.red;
    return KeenaiColorsText.muted;
  }

  /// Rough parse of [primaryValue] for header total (mock-friendly).
  double get _approxUsdValue {
    final digits = primaryValue.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(digits) ?? 0;
  }
}
