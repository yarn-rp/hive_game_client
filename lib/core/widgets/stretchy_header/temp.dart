// import 'package:flutter/material.dart';

// class EventAppBarDelegate implements SliverPersistentHeaderDelegate {
//   final double minExtent;
//   final double maxExtent;
//   final List<AtentionTag> atentionTagList;
//   final String category;
//   final ImageProvider profileImage;
//   final ScrollController _scrollController;
//   final String mainText;
//   final bool amIInterested;
//   final bool isFirstPage;
//   final Event event;
//   final Function(bool interest) onTapInterest;
//   String mainTextAtBar;
//   final List<String> imageList;

//   double gradientColor;
//   double gradientStopsValue;
//   double orangeColorAccent;
//   double centerWidgetPosition;
//   double profileImageSize;
//   double secondaryTextSize;
//   double secondaryTextOpacity;
//   int currentImage = 0;
//   EventAppBarDelegate(
//     this._scrollController, {
//     @required this.imageList,
//     @required this.atentionTagList,
//     @required this.category,
//     @required this.mainText,
//     @required this.minExtent,
//     @required this.profileImage,
//     @required this.maxExtent,
//     @required this.amIInterested,
//     @required this.onTapInterest,
//     @required this.event,
//     this.isFirstPage,
//   }) {
//     this.mainTextAtBar = '';
//     List<String> textSeparated = mainText.split(' ');
//     if (textSeparated[0].length >= 15)
//       this.mainTextAtBar = textSeparated[0].substring(0, 11) + '...';
//     else {
//       for (var index = 0, i = 0;
//           index < textSeparated.length;
//           i += textSeparated[index].length + 1, index++) {
//         print(
//             'index :${index}, i : ${i}, el texto hasta ahora es :${this.mainTextAtBar}');
//         if (i >= 11) {
//           this.mainTextAtBar += '...';
//           break;
//         }
//         this.mainTextAtBar += textSeparated[index] + ' ';
//       }
//     }
//   }
//   static const String Report = 'Reportar';
//   static const String GetProfileImage = 'Ver foto de perfil';
//   static const String Follow = 'Seguir';
//   static const String Block = 'Bloquear';
//   static const List<String> optionsChoices = <String>[
//     Follow,
//     GetProfileImage,
//     Report,
//     Block,
//   ];
//   void settingsChoiceHandler(String choice) {
//     print('choice');
//   }

//   void expandImages(
//       BuildContext context, String multimediaToExpand, String title) {
//     /* Navigator.pushNamed(
//       context,
//       '/multimediaExpanded',
//       arguments: {
//         'firstItem': imageList.indexOf(multimediaToExpand),
//         'items': imageList.map((element) {
          
//           return Center(
//             child: PhotoView(
//               loadFailedChild: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/logos/facebook.png"),
//                   ),
//                 ),
//               ),
//               errorBuilder:
//                   (BuildContext context, Object obj, StackTrace trace) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           "assets/logo.png"),
//                     ),
//                   ),
//                 );
//               },
//               loadingBuilder: (context, imageChunkEvent) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           "assets/logo.png"),
//                     ),
//                   ),
//                 );
//               },
//               imageProvider: NetworkImage(
//                 element,
//               ),
//               backgroundDecoration: BoxDecoration(color: Colors.transparent),
//               gaplessPlayback: false,
//               customSize: MediaQuery.of(context).size,
//               minScale: PhotoViewComputedScale.contained,
//               maxScale: PhotoViewComputedScale.contained * 1.5,
//               initialScale: PhotoViewComputedScale.contained,
//               basePosition: Alignment.center,
//             ),
//           );
//         }).toList(),
//         'title': title,
//       },
      
//     );
//      */
//     List images = imageList.map((element) {
//       return Center(
//         child: PhotoView.customChild(
//           backgroundDecoration: BoxDecoration(color: Colors.transparent),
//           childSize: Size(
//             MediaQuery.of(context).size.width,
//             MediaQuery.of(context).size.width,
//           ),
//           child: CachedNetworkImage(
//             fit: BoxFit.cover,
//             imageUrl: element,
//             placeholder: (context, url) => Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     "assets/logo.png",
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(2.0),
//                   topRight: Radius.circular(2.0),
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Container(),
//           ),
//           customSize: MediaQuery.of(context).size,
//           minScale: PhotoViewComputedScale.contained,
//           maxScale: PhotoViewComputedScale.contained * 1.5,
//           initialScale: PhotoViewComputedScale.contained,
//           basePosition: Alignment.center,
//         ),
//       );
//     }).toList();
//     showModalBottomSheet(
//       elevation: 100,
//       barrierColor: Colors.black.withOpacity(0.75),
//       backgroundColor: Theme.of(context).brightness == Brightness.dark
//           ? Color(0XFF0C1A24)
//           : Colors.white,
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return Carousel(
//           firstImage: imageList.indexOf(multimediaToExpand),
//           dotVerticalPadding: 8,
//           dotSize: 6.0,
//           dotIncreaseSize: 1.75,
//           dotColor: Theme.of(context).brightness == Brightness.dark
//               ? Colors.white
//               : Colors.grey[700],
//           dotIncreasedColor: Theme.of(context).brightness == Brightness.dark
//               ? Colors.white
//               : Colors.grey[700],
//           dotBgColor: Colors.transparent,
//           autoplay: false,
//           indicatorBgPadding: 16.0,
//           images: images,
//         );
//       },
//     );
//   }

//   String adjustSizeText(
//     String text, {
//     int maxLenght: 14,
//   }) {
//     List<String> textSeparated = text.split(' ');
//     if (textSeparated[0].length >= 14)
//       return textSeparated[0].substring(0, 11) + '...';
//   }

//   double offsetToOneToZeroScaleComplex(double shrinkOffset) {
//     return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
//     // return 1.0 - max(0.0, shrinkOffset) / maxExtent;
//   }

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     double offsetToOneToZeroScale = 1.0 - max(0.0, shrinkOffset) / maxExtent;
//     final double translation =
//         maxExtent / 3 * 2.25 * (1 - offsetToOneToZeroScale);
//     return ConstrainedBox(
//       constraints: BoxConstraints.expand(),
//       child: Material(
//         shadowColor: Colors.black,
//         elevation: scaleValuesFromScaleToScale(offsetToOneToZeroScale,
//             initialScale: 0.75,
//             finalScale: 0.25,
//             initialValue: 0,
//             finalValue: 0.5),
//         child: Stack(
//           alignment: AlignmentDirectional.topStart,
//           fit: StackFit.expand,
//           children: [
//             Positioned(
//               bottom: 0 - translation,
//               child: Container(
//                 constraints: BoxConstraints(
//                   maxHeight: maxExtent * 1.5,
//                   minHeight: maxExtent,
//                   minWidth: MediaQuery.of(context).size.width,
//                   maxWidth: MediaQuery.of(context).size.width,
//                 ),
//                 color: Color(0XFF10212e),
//                 child: Carousel(
//                   firstImage: currentImage,
//                   onImageChange: (_, current) {
//                     currentImage = current;
//                   },
//                   onImageTap: (i) {
//                     expandImages(context, imageList[i], mainText);
//                   },
//                   dotSize: 5.0,
//                   dotIncreaseSize: 1.75,
//                   dotColor: Color.fromARGB(
//                       scaleValuesFromScaleToScale(offsetToOneToZeroScale,
//                               initialScale: 1,
//                               finalScale: 0.15,
//                               initialValue: 255,
//                               finalValue: 0)
//                           .toInt(),
//                       255,
//                       255,
//                       255),
//                   dotIncreasedColor: imageList.length > 1
//                       ? Color.fromARGB(
//                           scaleValuesFromScaleToScale(offsetToOneToZeroScale,
//                                   initialScale: 1,
//                                   finalScale: 0.15,
//                                   initialValue: 255,
//                                   finalValue: 0)
//                               .toInt(),
//                           255,
//                           255,
//                           255)
//                       : Colors.transparent,
//                   dotBgColor: Colors.transparent,
//                   autoplay: false,
//                   indicatorBgPadding: 16.0,
//                   images: imageList
//                       .map(
//                         (e) => Container(
//                           child: Stack(
//                             alignment: AlignmentDirectional.center,
//                             fit: StackFit.expand,
//                             children: [
//                               Container(
//                                 child: CachedNetworkImage(
//                                   fit: BoxFit.cover,
//                                   imageUrl: e,
//                                   placeholder: (context, url) => Container(
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/logo.png",
//                                         ),
//                                         fit: BoxFit.contain,
//                                       ),
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(2.0),
//                                         topRight: Radius.circular(2.0),
//                                       ),
//                                     ),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Container(),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.black.withOpacity(
//                                         0.5,
//                                       ),
//                                       Colors.transparent,
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(
//                                         0.75,
//                                       ),
//                                     ],
//                                     stops: [0, 0.25, 0.5, 1],
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     tileMode: TileMode.repeated,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).brightness ==
//                                           Brightness.dark
//                                       ? Color(0XFF0C1A24).withOpacity(
//                                           scaleValuesFromScaleToScale(
//                                               offsetToOneToZeroScale,
//                                               initialScale: 0.75,
//                                               finalScale: 0.25,
//                                               initialValue: 0,
//                                               finalValue: 1))
//                                       : Colors.white.withOpacity(
//                                           scaleValuesFromScaleToScale(
//                                               offsetToOneToZeroScale,
//                                               initialScale: 0.75,
//                                               finalScale: 0.25,
//                                               initialValue: 0,
//                                               finalValue: 1)),
//                                 ),
//                               ),
//                               /*  Container(
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).brightness == Brightness.dark
//                                         ? Color(0XFF10212e).withOpacity(
//                                             scaleValuesFromScaleToScale(
//                                                 offsetToOneToZeroScale,
//                                                 initialScale: 0.33,
//                                                 finalScale: 0.15,
//                                                 initialValue: 0,
//                                                 finalValue: 1))
//                                         : Colors.white.withOpacity(
//                                             scaleValuesFromScaleToScale(
//                                                 offsetToOneToZeroScale,
//                                                 initialScale: 0.33,
//                                                 finalScale: 0.15,
//                                                 initialValue: 0,
//                                                 finalValue: 1)),
//                                   ),
//                                 ), */
//                             ],
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//               // decoration: BoxDecoration(
//               //   image: DecorationImage(
//               //       image: AssetImage(
//               //         eventExpanded.multimediaList()[0].id,
//               //       ),
//               //       fit: BoxFit.cover),
//               // ),
//             ),
//             Positioned(
//               left: 5,
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       if (isFirstPage != null && isFirstPage) {
//                         Navigator.pushReplacementNamed(
//                           context,
//                           '/saturdayApp',
//                         );
//                       } else
//                         Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Theme.of(context).platform == TargetPlatform.android
//                           ? SaturdayIcons.arrow_left
//                           : CupertinoIcons.back,
//                       color: offsetToOneToZeroScale > 0.75
//                           ? Colors.white
//                           : Color.fromARGB(
//                               scaleValuesFromScaleToScale(
//                                       offsetToOneToZeroScale,
//                                       initialScale: 0.75,
//                                       finalScale: 0.25,
//                                       initialValue: 255,
//                                       finalValue: 255)
//                                   .toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                             ),
//                       size: 22,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: AnimatedDefaultTextStyle(
//                       style: offsetToOneToZeroScale < 0.25
//                           ? TextStyle(
//                               fontFamily: 'ProximaNova',
//                               color: Theme.of(context).accentColor,
//                             )
//                           : TextStyle(
//                               fontFamily: 'ProximaNova',
//                               color: Colors.transparent,
//                             ),
//                       duration: Duration(milliseconds: 750),
//                       curve: Curves.fastLinearToSlowEaseIn,
//                       child: GestureDetector(
//                         onTap: () {
//                           if (offsetToOneToZeroScale < 0.25)
//                             _scrollController.animateTo(0,
//                                 duration: Duration(milliseconds: 750),
//                                 curve: Curves.fastLinearToSlowEaseIn);
//                         },
//                         child: Container(
//                           width: 180,
//                           child: Text(
//                             this.mainText,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 12,
//               child: Row(
//                 children: [
//                   IconButton(
//                       icon: Icon(
//                         !amIInterested
//                             ? CupertinoIcons.heart
//                             : CupertinoIcons.heart_fill,
//                         // color: Theme.of(context).accentColor,
//                         color: amIInterested
//                             ? Colors.redAccent
//                             : offsetToOneToZeroScale > 0.75
//                                 ? Colors.white
//                                 : Color.fromARGB(
//                                     scaleValuesFromScaleToScale(
//                                             offsetToOneToZeroScale,
//                                             initialScale: 0.75,
//                                             finalScale: 0.25,
//                                             initialValue: 255,
//                                             finalValue: 255)
//                                         .toInt(),
//                                     scaleValuesFromScaleToScale(
//                                       offsetToOneToZeroScale,
//                                       initialScale: 0.75,
//                                       finalScale: 0.25,
//                                       initialValue: 255,
//                                       finalValue:
//                                           Theme.of(context).brightness ==
//                                                   Brightness.dark
//                                               ? 255
//                                               : 0,
//                                     ).toInt(),
//                                     scaleValuesFromScaleToScale(
//                                       offsetToOneToZeroScale,
//                                       initialScale: 0.75,
//                                       finalScale: 0.25,
//                                       initialValue: 255,
//                                       finalValue:
//                                           Theme.of(context).brightness ==
//                                                   Brightness.dark
//                                               ? 255
//                                               : 0,
//                                     ).toInt(),
//                                     scaleValuesFromScaleToScale(
//                                       offsetToOneToZeroScale,
//                                       initialScale: 0.75,
//                                       finalScale: 0.25,
//                                       initialValue: 255,
//                                       finalValue:
//                                           Theme.of(context).brightness ==
//                                                   Brightness.dark
//                                               ? 255
//                                               : 0,
//                                     ).toInt(),
//                                   ),
//                         size: 24,
//                       ),
//                       onPressed: () => this.onTapInterest(!amIInterested)),
//                   IconButton(
//                     icon: Icon(
//                       SaturdayIcons.share_in_app,
//                       // color: Theme.of(context).accentColor,
//                       color: offsetToOneToZeroScale > 0.75
//                           ? Colors.white
//                           : Color.fromARGB(
//                               scaleValuesFromScaleToScale(
//                                       offsetToOneToZeroScale,
//                                       initialScale: 0.75,
//                                       finalScale: 0.25,
//                                       initialValue: 255,
//                                       finalValue: 255)
//                                   .toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                               scaleValuesFromScaleToScale(
//                                 offsetToOneToZeroScale,
//                                 initialScale: 0.75,
//                                 finalScale: 0.25,
//                                 initialValue: 255,
//                                 finalValue: Theme.of(context).brightness ==
//                                         Brightness.dark
//                                     ? 255
//                                     : 0,
//                               ).toInt(),
//                             ),
//                       size: 20,
//                     ),
//                     onPressed: () async {
//                       showShareBottomSheet(context, this.event);
//                     },
//                   ),

//                   /*   IconButton(
//                       icon: Icon(
//                         CupertinoIcons.line_horizontal_3,
//                         // color: Theme.of(context).accentColor,
//                         color: offsetToOneToZeroScale > 0.33
//                             ? Colors.white
//                             : Color.fromARGB(
//                                 scaleValuesFromScaleToScale(
//                                         offsetToOneToZeroScale,
//                                         initialScale: 0.33,
//                                         finalScale: 0.15,
//                                         initialValue: 255,
//                                         finalValue: 255)
//                                     .toInt(),
//                                 scaleValuesFromScaleToScale(
//                                   offsetToOneToZeroScale,
//                                   initialScale: 0.33,
//                                   finalScale: 0.15,
//                                   initialValue: 255,
//                                   finalValue:
//                                       Theme.of(context).brightness == Brightness.dark
//                                           ? 255
//                                           : 0,
//                                 ).toInt(),
//                                 scaleValuesFromScaleToScale(
//                                   offsetToOneToZeroScale,
//                                   initialScale: 0.33,
//                                   finalScale: 0.15,
//                                   initialValue: 255,
//                                   finalValue:
//                                       Theme.of(context).brightness == Brightness.dark
//                                           ? 255
//                                           : 0,
//                                 ).toInt(),
//                                 scaleValuesFromScaleToScale(
//                                   offsetToOneToZeroScale,
//                                   initialScale: 0.33,
//                                   finalScale: 0.15,
//                                   initialValue: 255,
//                                   finalValue:
//                                       Theme.of(context).brightness == Brightness.dark
//                                           ? 255
//                                           : 0,
//                                 ).toInt(),
//                               ),
//                         size: 28,
//                       ),
//                       onPressed: () async {
//                         String modalBottomSheetResult =
//                             await showDiventActionsModalBottomSheetStrings(
//                                 context, [
//                           ActionItem('Llamar', Icons.call_rounded),
//                           ActionItem('Escribir por WhatsApp', Icons.chat_bubble),
//                           ActionItem('Escribir sms', Icons.chat_rounded),
//                           ActionItem(
//                             'Dejar de seguir',
//                             Icons.person_remove_alt_1_rounded,
//                           ),
//                           ActionItem('Bloquear', Icons.block_rounded),
//                           ActionItem('Reportar', Icons.report_off_rounded),
//                         ]);
//                       }), */
//                 ],
//               ),
//             ),
//             if (offsetToOneToZeroScale > 0.4)
//               Positioned(
//                 bottom:
//                     imageList.length > 1 ? 40 - translation : 12 - translation,
//                 left: 16,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 4.0),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: atentionTagList.map((atentionTag) {
//                             return Chip(
//                               side: BorderSide.none,
//                               labelPadding: EdgeInsets.symmetric(horizontal: 4),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               /* height: 25 * 5 / 6, */
//                               backgroundColor: Color.fromARGB(
//                                   event.atentionTag.color.alpha,
//                                   event.atentionTag.color.red,
//                                   event.atentionTag.color.green,
//                                   event.atentionTag.color.blue),
//                               label: Text(
//                                 event.atentionTag.previewTag.toUpperCase(),
//                                 style: TextStyle(
//                                     fontFamily: "ProximaNova",
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             );
//                           }).toList()),
//                     ),
//                     Text(
//                       category,
//                       style: TextStyle(
//                           color: Theme.of(context).accentColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width - 64,
//                       child: Text(
//                         this.mainText,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void updateContent(double offsetToOneToZeroScale) {
//     gradientColor = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: 255,
//       finalScale: 0.5,
//       finalValue: 0,
//     );
//     gradientStopsValue = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: 1,
//       finalScale: 0.5,
//       finalValue: 0,
//     );
//     orangeColorAccent = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: 255,
//       finalScale: 0.5,
//       finalValue: 153,
//     );
//     centerWidgetPosition = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: maxExtent / 5,
//       finalScale: 0.5,
//       finalValue: minExtent / 5,
//     );
//     profileImageSize = offsetToOneToZeroScale > 0.5 ? 40 : 0;
//     secondaryTextSize = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: 22,
//       finalScale: 0.5,
//       finalValue: 0,
//     );
//     secondaryTextOpacity = scaleValuesFromScaleToScale(
//       offsetToOneToZeroScale,
//       initialValue: 255,
//       finalScale: 0.5,
//       finalValue: 0,
//     );
//   }

//   double scalePositions(
//     double offsetToOneToZeroScale, {
//     @required List<double> scalesOneToZero,
//     @required List<double> values,
//   }) {
//     assert(scalesOneToZero.length == values.length);
//     assert(scalesOneToZero[0] == 1.0 &&
//         scalesOneToZero[scalesOneToZero.length - 1] == 0.0);

//     for (var i = 1; i < scalesOneToZero.length; i++) {
//       if (scalesOneToZero[i] < offsetToOneToZeroScale) {
//         print('''el offset esta en $offsetToOneToZeroScale , voy a escalar desde
//         ${scalesOneToZero[i - 1]} hasta ${scalesOneToZero[i]} con los valores ${values[i - 1]} : ${values[i]}  ''');
//         double toReturn = scaleFromTo(
//           offsetToOneToZeroScale,
//           scalesOneToZero[i - 1],
//           scalesOneToZero[i],
//           values[i - 1],
//           values[i],
//         );
//         print('el valor a retornar es $toReturn');
//         return toReturn;
//       }
//     }
//   }

//   double scaleValuesFromScaleToScale(
//     double offsetToOneToZeroScale, {
//     double initialScale = 1.0,
//     double finalScale = 0.0,
//     @required double initialValue,
//     @required double finalValue,
//   }) {
//     assert(initialScale <= 1.0 && initialScale >= 0);
//     assert(finalScale <= 1.0 && finalScale >= 0);
//     if (offsetToOneToZeroScale < initialScale) {
//       if (offsetToOneToZeroScale > finalScale) {
//         return scaleFromTo(offsetToOneToZeroScale, initialScale, finalScale,
//             initialValue, finalValue);
//       } else
//         return finalValue;
//     }
//     return initialValue;
//   }

//   double scaleFromTo(double offsetToOneToZeroScale, double fromScaledZeroToOne,
//       double toScaledZeroToOne, double fromValue, double toValue) {
//     Curve curve = Curves.easeInOutCubic;

//     double mZeroToOneScale = (toScaledZeroToOne - fromScaledZeroToOne);
//     double mFromToValue = (toValue - fromValue);
//     print(
//         '''proportion = {($mZeroToOneScale * $offsetToOneToZeroScale) + $fromScaledZeroToOne}''');
//     double proportion =
//         (offsetToOneToZeroScale - fromScaledZeroToOne) / mZeroToOneScale;
//     proportion = curve.transform(proportion);
//     double result = mFromToValue * proportion + fromValue;
//     print(
//         'la pendiente de la recta de los valores proporcional es $mZeroToOneScale');
//     print('la proporcion es $proportion');

//     // return result;
//     return result;
//   }

//   double scaleShrinkOffsetComplex(
//       double shrinkOffset, double maxValue, double minValue) {
//     return (maxValue - minValue) * offsetToOneToZeroScaleComplex(shrinkOffset) +
//         minValue;
//   }

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }

//   @override
//   FloatingHeaderSnapConfiguration get snapConfiguration => null;
//   @override
//   OverScrollHeaderStretchConfiguration get stretchConfiguration =>
//       OverScrollHeaderStretchConfiguration(
//         stretchTriggerOffset: 20,
//         onStretchTrigger: () {},
//       );

//   @override
//   // TODO: implement showOnScreenConfiguration
//   PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
//       PersistentHeaderShowOnScreenConfiguration(
//           minShowOnScreenExtent: 75, maxShowOnScreenExtent: 500);

//   @override
//   // TODO: implement vsync
//   TickerProvider get vsync => throw UnimplementedError();
// }


