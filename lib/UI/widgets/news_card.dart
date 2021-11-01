import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/UI/pages/news_page.dart';

class NewCard extends StatelessWidget {
  final String imageUrl, title, description, source, url;
  final DateTime publshedAt;
  const NewCard(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.source,
      required this.url,
      required this.publshedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsPage(
                        imageUrl: imageUrl,
                        description: description,
                        source: source,
                        title: title,
                        url: url,
                        publshedAt: publshedAt,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        source,
                        style: TextStyle(
                            color: const Color(0xff303F60),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),

                    Text(
                      title,
                      style: const TextStyle(color: Color(0xff303F60)),
                    ),

                    //Text(time),
                  ],
                ),
              ),
              SizedBox(
                width: 25.0.w,
              ),
              SizedBox(
                height: 120.r,
                width: 120.r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
