import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/models/lecture.dart';
import 'package:video_player/video_player.dart';

class LectureItem extends StatefulWidget {
  final Lecture lecture;
  const LectureItem({super.key,required this.lecture});

  @override
  State<LectureItem> createState() => _LectureItemState();
}
  late ExpandableController expandableController;

class _LectureItemState extends State<LectureItem> {
    late VideoPlayerController _controller;

  @override
  void initState() {
    expandableController = ExpandableController();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.lecture.video))
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }
  @override
  void dispose() {
    expandableController.dispose();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(bottom:15.0),
        child: Container(
          //height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.lightgrey,
            borderRadius: BorderRadius.circular(8)
          ),
          child: LayoutBuilder(
            builder:(ctx,constraint)=> Padding(
              padding: const EdgeInsets.all(10.0),
              child:  ExpandablePanel(
                header:RichText(text: TextSpan(children: [TextSpan(text:'Lecture ${widget.lecture.order}: ',style: AppTextStyle.greyTitleTextStyle),TextSpan(text:widget.lecture.title,style:   AppTextStyle.blackTitleTextStyle)])) ,
                                      controller: expandableController,
                                      collapsed: Container(),
                                      expanded:  GestureDetector(
                                        onTap: (){
                                           setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
                                        },
                                        child: Stack(
                                          children:[ AspectRatio(
                                                          aspectRatio: _controller.value.aspectRatio,
                                                          child: VideoPlayer(_controller),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          child: SizedBox(width:constraint.maxWidth, child: VideoProgressIndicator(_controller, allowScrubbing: true)))]
                                        ),
                                      )
               ), 
            ),
          )));
  }
}