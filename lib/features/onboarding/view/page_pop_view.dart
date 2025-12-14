import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/common/custom_image_view.dart';
import 'package:mobile/features/app_appearance/extensions/widget_animation_extensions.dart';

/// A widget that displays a page of the onboarding process.
///
/// It contains an animation, a title, and a description.
class PagePopup extends StatelessWidget {
  // The data for the page to be displayed.
  final PageViewData onBoardingSlideData;

  // Constructs a PagePopup widget.
  const PagePopup({super.key, required this.onBoardingSlideData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: CustomImageView(
            imagePath: onBoardingSlideData.img,
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width,
          ).animateWidget(),
        ),
        // Display the title and subtitle.
        Expanded(
          flex: 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                onBoardingSlideData.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).animateWidget(),
            ),
          ),
        ),
        // Display the description.
        Expanded(
          flex: 1,
          child: SizedBox(
            width: 250,
            child: Text(
              onBoardingSlideData.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ).animateWidget(),
          ),
        ),
        // Leave some space at the bottom.
      ],
    );
  }
}

class PageViewData {
  final String title;
  final String description;
  final String img;

  PageViewData({
    required this.title,
    required this.description,
    required this.img,
  });
}
