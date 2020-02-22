import 'package:flutter/material.dart';
import 'package:iremember/theme/theme_provider.dart';

class LoadingOverlay extends StatelessWidget {
  static OverlayEntry _loadingIndicator =
      OverlayEntry(maintainState: true, builder: (context) => LoadingOverlay());

  static bool get showingOverlay => _overlayVisible;

  static bool _overlayVisible = false;

  static WillPopCallback get willPop  =>  () async {
    return !_overlayVisible;
  };

  static showLoadingOverlay(BuildContext context) {
    Overlay.of(context).insert(_loadingIndicator);
    _overlayVisible = true;
  }

  static hideOverLay() {
    if (_overlayVisible){ 
      _overlayVisible = false;
      _loadingIndicator.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeProvider.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: themeData.primaryWhite.withOpacity(0.25),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
