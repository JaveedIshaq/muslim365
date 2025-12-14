import 'package:flutter/material.dart';
import 'package:mobile/features/banner/presentation/widgets/home_banners_widget.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Banners')),
      body: Center(child: HomeBannersWidget()),
    );
  }
}
