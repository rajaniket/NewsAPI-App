import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/UI/pages/web_view_page.dart';
import 'package:news_app/constants/app_colours.dart';
import 'package:news_app/constants/months_data.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatelessWidget {
  final String imageUrl, title, description, source, url;
  final DateTime publshedAt;
  const NewsPage(
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
    String formattedDate = DateFormat.jm().format(publshedAt);
    print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColour.kappBarColour,
        elevation: 0,
        toolbarHeight: 60.h,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.black12, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source,
                    style: TextStyle(
                        color: AppColour.kHeadlineColour,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Text(
                    '${publshedAt.day} ${months[publshedAt.month - 1]} ${publshedAt.year} $formattedDate',
                    style: TextStyle(
                      color: AppColour.kHeadlineColour,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColour.kHeadlineColour,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    webUrl: url,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          'See full story ',
                          style: TextStyle(
                            color: AppColour.kHeadlineColour,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15.r,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
