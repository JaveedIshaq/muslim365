import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';
import 'package:mobile/core/error/error.dart';
import 'package:mobile/features/banner/presentation/providers/banner_provider.dart';

class HomeBannersWidget extends ConsumerStatefulWidget {
  const HomeBannersWidget({super.key});

  @override
  ConsumerState<HomeBannersWidget> createState() => _HomeBannersWidgetState();
}

class _HomeBannersWidgetState extends ConsumerState<HomeBannersWidget>
    with TickerProviderStateMixin {
  int _current = 0;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerStream = ref.watch(bannerStreamProvider);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppDimensions.paddingSM),
          bannerStream.when(
            loading: () => _buildLoadingState(),
            error: (error, stack) => _buildErrorState(error, stack),
            data: (banners) {
              if (banners.isEmpty) {
                return _buildEmptyState();
              }
              return _buildBannerCarousel(banners);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Featured',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: BrandColors.buttonProfile,
            ),
          ),
          _buildRefreshButton(),
        ],
      ),
    );
  }

  Widget _buildRefreshButton() {
    return Container(
      decoration: BoxDecoration(
        color: BrandColors.buttonProfile.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        onPressed: _refreshBanners,
        icon: Icon(
          Icons.refresh_rounded,
          color: BrandColors.buttonProfile,
          size: AppDimensions.iconMD,
        ),
        tooltip: 'Refresh banners',
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  void _refreshBanners() {
    HapticFeedback.lightImpact();
    ref.invalidate(bannerStreamProvider);
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(BrandColors.buttonProfile),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, size: 48, color: Colors.grey[500]),
            const SizedBox(height: AppDimensions.paddingMD),
            Text(
              'No banners available',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Check back later for featured content',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error, StackTrace stackTrace) {
    // Extract specific error information for better debugging
    String errorMessage = 'Failed to load banners';
    String errorDetails = 'Please check your connection and try again.';

    if (error is AppError) {
      // Use the clean message from AppError
      errorMessage = error.message;
      // Use userMessage if available, otherwise use the technical message
      errorDetails = error.userMessage ?? error.message;
    } else if (error.toString().contains(
      'relation "public.bannerss" does not exist',
    )) {
      errorMessage = 'Database table error';
      errorDetails =
          'Table "bannerss" does not exist. Check table name in database.';
    } else if (error.toString().contains('PostgrestException')) {
      errorMessage = 'Database connection error';
      errorDetails = error.toString();
    } else {
      errorDetails = error.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          decoration: BoxDecoration(
            color: Colors.red.shade50.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_sharp, size: 48, color: Colors.red.shade700),
              const SizedBox(height: AppDimensions.paddingMD),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade800,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingSM),
              Text(
                errorDetails,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.red.shade700),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppDimensions.paddingMD),
              ElevatedButton.icon(
                onPressed: _refreshBanners,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BrandColors.buttonProfile,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                    vertical: AppDimensions.paddingSM,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(List<dynamic> banners) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: buttonCarouselController,
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSM,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildBannerImage(banners[index]),
              ),
            );
          },
          options: CarouselOptions(
            height: 280,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
              HapticFeedback.selectionClick();
            },
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingMD),
        _buildIndicator(banners.length),
      ],
    );
  }

  Widget _buildBannerImage(dynamic banner) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        // Banner Image
        Image.network(
          banner.img,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[100],
              child: const Center(child: CircularProgressIndicator.adaptive()),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.error_outline, color: Colors.grey),
            ),
          ),
          semanticLabel: 'Banner image',
        ),

        // Gradient Overlay for text readability
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                if (banner.title.isNotEmpty)
                  Text(
                    banner.title,
                    style: textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                // Description
                if (banner.description.isNotEmpty) ...[
                  const SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    banner.description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(itemCount, (index) {
          final isActive = index == _current;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 20 : 8,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isActive
                  ? BrandColors.buttonProfile
                  : Colors.grey.withValues(alpha: 0.4),
            ),
          );
        }),
        const SizedBox(width: AppDimensions.paddingMD),
        Text(
          '${_current + 1}/$itemCount',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
