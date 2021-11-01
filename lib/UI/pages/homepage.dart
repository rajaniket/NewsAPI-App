import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/UI/pages/search_page.dart';
import 'package:news_app/UI/widgets/news_card.dart';
import 'package:news_app/constants/app_colours.dart';
import 'package:news_app/model/location.dart';
import 'package:news_app/provider/top_headline_provider.dart';
import 'package:news_app/constants/sort_data.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Provider.of<TopHeadlineDataProvider>(context, listen: false).onInitialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      floatingActionButton: _buildFilterButton(),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            _searchBar(),
            SizedBox(
              height: 10.h,
            ),
            _buildHeadlineRow(),
            Expanded(
              child: Consumer<TopHeadlineDataProvider>(
                  builder: (context, dataProvider, child) {
                return Container(
                    // color: Colors.blue,
                    child: dataProvider.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: dataProvider.articles.length,
                            itemBuilder: (context, index) {
                              return NewCard(
                                imageUrl:
                                    dataProvider.articles[index].urlToImage,
                                title: dataProvider.articles[index].title,
                                description:
                                    dataProvider.articles[index].description,
                                source: dataProvider.articles[index].source,
                                url: dataProvider.articles[index].articleUrl,
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

  _buildBottomSheet() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0.r),
        )),
        builder: (context) => Padding(
              padding: EdgeInsets.fromLTRB(25.w, 2.h, 25.w, 25.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.drag_handle_outlined,
                      size: 42.r,
                      color: Colors.black12,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Choose your location',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColour.kHeadlineColour),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 0,
                  ),
                  _buildRadioButtons(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: SizedBox(
                    width: 100.0.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ))
                ],
              ),
            ));
  }

  Widget _buildRadioButtons() {
    // var provider = Provider.of<DataProvider>(context, listen: true);
    //  var providerListen= Provider.of<DataProvider>(context, listen: true);
    return Consumer<TopHeadlineDataProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          ListTile(
            title: const Text("India"),
            trailing: Radio<String>(
              value: CurrentLocation.india,
              groupValue:
                  Provider.of<TopHeadlineDataProvider>(context, listen: true)
                      .currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.india);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
          ListTile(
            title: const Text("USA"),
            trailing: Radio<String>(
              value: CurrentLocation.usa,
              groupValue: provider.currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.usa);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
          ListTile(
            title: const Text("Netherlands"),
            trailing: Radio<String>(
              value: CurrentLocation.netherlands,
              groupValue: provider.currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.netherlands);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
          ListTile(
            title: const Text("Norway"),
            trailing: Radio<String>(
              value: CurrentLocation.norway,
              groupValue: provider.currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.norway);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
          ListTile(
            title: const Text("France"),
            trailing: Radio<String>(
              value: CurrentLocation.france,
              groupValue: provider.currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.france);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
          ListTile(
            title: const Text("Mexico"),
            trailing: Radio<String>(
              value: CurrentLocation.mexico,
              groupValue: provider.currentLocation,
              onChanged: (value) {
                provider.currentLocation = value!;
                provider.onLocationChange(CurrentLocation.mexico);
              },
              activeColor: AppColour.kHeadlineColour,
            ),
          ),
        ],
      );
    });
  }

  Row _buildHeadlineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Top Headline',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColour.kHeadlineColour),
        ),
        const _BuildDropDown(),
        //BlogTile(),
      ],
    );
  }

  Widget _searchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage()));
      },
      child: TextField(
        decoration: InputDecoration(
          fillColor: const Color(0xffE6ECF2),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide.none),
          filled: true,
          hintText: 'Search for news, topics...',
          hintStyle: const TextStyle(color: Color(0xff8B96A9)),
          suffixIcon: Icon(
            Icons.search_rounded,
            size: 35.r,
          ),
          enabled: false,
        ),
      ),
    );
  }

  FloatingActionButton _buildFilterButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.filter_alt),
      backgroundColor: AppColour.kappBarColour,
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColour.kappBarColour,
      elevation: 0,
      toolbarHeight: 60.h,
      title: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MyNEWS',
              style: TextStyle(fontSize: 16.0.sp),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOCATION',
                  style: TextStyle(fontSize: 10.0.sp),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                GestureDetector(
                  onTap: () {
                    _buildBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18.0.r,
                      ),
                      Text(
                        Provider.of<TopHeadlineDataProvider>(context,
                                listen: true)
                            .currentLocation,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BuildDropDown extends StatelessWidget {
  const _BuildDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: Provider.of<TopHeadlineDataProvider>(context, listen: true)
          .currentSort,
      underline: const SizedBox(),
      items: items
          .map((String items) => DropdownMenuItem(
                child: Text(items),
                value: items,
              ))
          .toList(),
      onChanged: (String? val) {
        Provider.of<TopHeadlineDataProvider>(context, listen: false)
            .onSortByChange(val!);
      },
    );
  }
}
