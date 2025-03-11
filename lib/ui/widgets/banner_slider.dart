import 'package:flutter/material.dart';
import 'package:nike_2/common/utils.dart';
import 'package:nike_2/data/banner.dart';
import 'package:nike_2/ui/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;
  const BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            physics: defaultScrollPhysics,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                  padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
                  child: ImageLoadingService(
                    imageUrl: banner.imageUrl,
                    borderRadius: BorderRadius.circular(12),
                  ));
            },
          ),
          Positioned(
            bottom: 18,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                    dotWidth: 24,
                    dotHeight: 3,
                    spacing: 4,
                    radius: 4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
