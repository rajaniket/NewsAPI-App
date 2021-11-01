import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/UI/widgets/news_card.dart';
import 'package:news_app/constants/app_colours.dart';
import 'package:news_app/provider/search_provider.dart';
import 'package:news_app/provider/top_headline_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0.r, 15.0.r, 15.0.r, 0),
        child: Column(
          children: [
            _searchBar(context),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: Consumer<SearchDataProvider>(
                  builder: (context, dataProvider, child) {
                return Container(
                    child: dataProvider.loading
                        ? const Center(child: CircularProgressIndicator())
                        : dataProvider.articles.isEmpty
                            ? Center(
                                child: Text(
                                'No result found!',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColour.kHeadlineColour),
                              ))
                            : ListView.builder(
                                itemCount: dataProvider.articles.length,
                                itemBuilder: (context, index) {
                                  return NewCard(
                                    imageUrl:
                                        dataProvider.articles[index].urlToImage,
                                    title: dataProvider.articles[index].title,
                                    description: dataProvider
                                        .articles[index].description,
                                    source: dataProvider.articles[index].source,
                                    url:
                                        dataProvider.articles[index].articleUrl,
                                    publshedAt:
                                        dataProvider.articles[index].publshedAt,
                                  );
                                },
                              ));
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    String? inputData;
    var provider = Provider.of<SearchDataProvider>(context, listen: false);
    return TextField(
      onChanged: (val) {
        inputData = val;
      },
      onSubmitted: (val) {
        inputData = val;
        provider.onSearch(inputData!);
      },
      autofocus: true,
      decoration: InputDecoration(
        fillColor: const Color(0xffE6ECF2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.r),
            borderSide: BorderSide.none),
        filled: true,
        hintText: 'Search for news, topics...',
        hintStyle: const TextStyle(color: Color(0xff8B96A9)),
        suffixIcon: GestureDetector(
          onTap: () {
            if (inputData != null) {
              provider.onSearch(inputData!);
            }
          },
          child: Icon(
            Icons.search_rounded,
            size: 35.r,
          ),
        ),
      ),
    );
  }
}
