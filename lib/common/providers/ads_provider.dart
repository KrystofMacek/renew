// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// final adsProvider = StateNotifierProvider<AdsProvider>((ref) => AdsProvider());

// class AdsProvider extends StateNotifier<MobileAds> {
//   AdsProvider() : super(MobileAds.instance);

//   String getBannerId(int id) {
//     // switch (id) {
//     //   case 1:
//     //     return 'ca-app-pub-8939171793440266/6143467212';
//     //   case 2:
//     //     return 'ca-app-pub-8939171793440266/4533026168';
//     //   case 3:
//     //     return 'ca-app-pub-8939171793440266/5654536145';
//     //   case 4:
//     //     return 'ca-app-pub-8939171793440266/4341454475';
//     //   case 5:
//     //     return 'ca-app-pub-8939171793440266/2683568503';
//     //   default:
//     //     return 'ca-app-pub-8939171793440266/8089127794';
//     // }
//     return 'ca-app-pub-3940256099942544/6300978111';
//   }

//   Future<Container> getBanner(int id) async {
//     final BannerAd myBanner = BannerAd(
//       adUnitId: getBannerId(id),
//       size: AdSize.banner,
//       request: AdRequest(),
//       listener: AdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (Ad ad) => print('Ad loaded.'),
//         // Called when an ad request failed.
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           ad.dispose();
//           print('Ad failed to load: $error');
//         },
//         // Called when an ad opens an overlay that covers the screen.
//         onAdOpened: (Ad ad) => print('Ad opened.'),
//         // Called when an ad removes an overlay that covers the screen.
//         onAdClosed: (Ad ad) => print('Ad closed.'),
//         // Called when an ad is in the process of leaving the application.
//         onApplicationExit: (Ad ad) => print('Left application.'),
//       ),
//     );
//     await myBanner.load();
//     return Container(
//       alignment: Alignment.center,
//       child: AdWidget(ad: myBanner),
//       width: myBanner.size.width.toDouble(),
//       height: myBanner.size.height.toDouble(),
//     );
//   }
// }

// final adBannerFutureProvider = FutureProvider.autoDispose
//     .family<Container, int>((ref, id) => ref.read(adsProvider).getBanner(id));

// class AdState {
//   AdState({required this.initialization});
//   Future<InitializationStatus> initialization;

//   String getBannerAdUintId() => 'ca-app-pub-3940256099942544/6300978111';

//   AdListener get adListener => _adListener;
//   AdListener _adListener = AdListener(
//     // Called when an ad is successfully received.
//     onAdLoaded: (Ad ad) => print('Ad loaded.'),
//     // Called when an ad request failed.
//     onAdFailedToLoad: (Ad ad, LoadAdError error) {
//       ad.dispose();
//       print('Ad failed to load: $error');
//     },
//     // Called when an ad opens an overlay that covers the screen.
//     onAdOpened: (Ad ad) => print('Ad opened.'),
//     // Called when an ad removes an overlay that covers the screen.
//     onAdClosed: (Ad ad) => print('Ad closed.'),
//     // Called when an ad is in the process of leaving the application.
//     onApplicationExit: (Ad ad) => print('Left application.'),
//   );
// }
