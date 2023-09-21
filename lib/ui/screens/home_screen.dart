import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pay/core/model/mosque_model.dart';
import 'package:pay/core/services/apis.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/model/town_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size size;
  TextEditingController dropdownController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  List<TownModel> townList = [];
  List<MosqueModel> mosqueList = [];
  TownModel? selectedValue;

  String searchedMosque = '';
  String searchedTown = '';
  String _locationMessage = "";

  bool isTownListLoaded = false;

  getInitialTownList(String text) async {
    final result = await Api().getTownList(context, text);
    print(result);

    setState(() {
      print("Printing controler val ${searchController.text.isEmpty}");

      townList = result;
      isTownListLoaded = true;
    });
  }

  getTownList(String text, StateSetter setState) async {
    final result = await Api().getTownList(context, text);
    print(result);

    setState(() {
      print("Printing controler val ${searchController.text.isEmpty}");

      townList = result;
      isTownListLoaded = true;
    });
  }

  getMosqueList(String text) async {
    final result = await Api().getMosqueList(context, text);
    print(result);

    setState(() {
      mosqueList = result;
      //isTownListLoaded = true;
    });
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  Future<void> _getLocation() async {
    try {
      // Request location permissions (optional, in case the user denies)
      if (!(await Permission.location.isGranted)) {
        await Permission.location.request();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        print(_locationMessage);
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Error: ${e.toString()}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    getInitialTownList('A');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 130.w,
              ),
              Icon(
                Icons.account_circle_rounded,
                color: Color(0xff757575),
                size: 33.w,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _keyboardIsVisible()
                    ? SizedBox(
                        height: 50.h,
                      )
                    : SizedBox(
                        height: 80.h,
                      ),
                Text(_locationMessage,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                  ),

                ),
                SizedBox(
                  height: 50.h,
                ),
                //container with background color deep blue border radius 15.Inside it textfield in center and search icon in rightside with color yellow
                Container(
                  height: 30.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      border: Border.all(color: Colors.blue, width: 1)),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: "Search Town here",
                        hintStyle: TextStyle(
                            color: Color(0xffadadad),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500)),
                    onChanged: (text) {
                      print('printing searched text${text}');

                      if (text == '' || text == null || text.isEmpty) {
                        setState(() {
                          townList = [];
                          searchedTown = text;
                        });
                      } else {
                        getTownList(text, setState);
                      }
                    },
                  ),
                ),



                Text("Search by Mosque"),

                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 30.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      border: Border.all(color: Colors.blue, width: 1)),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: "Search Mosque here",
                        hintStyle: TextStyle(
                            color: Color(0xffadadad),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500)),
                    onChanged: (text) {
                      print('printing searched text${text}');

                      if (text == '' || text == null || text.isEmpty) {
                        setState(() {
                          mosqueList = [];
                          searchedMosque = text;
                        });
                      } else {
                        getMosqueList(text);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                mosqueList.length != 0
                    ? Material(
                        elevation: 6,
                        child: Container(
                          width: 200.w,
                          height: 100.h,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: mosqueList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: Text(mosqueList[index].name!),
                                );
                              }),
                        ),
                      )
                    : SizedBox(
                        height: 20.h,
                      ),
                SizedBox(
                  height: 15.h,
                ),
                Text("Search by Location"),
                SizedBox(
                  height: 10.h,
                ),
                StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return Container(
                      height: 30.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          border: Border.all(color: Colors.blue, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<TownModel>(
                          isExpanded: true,
                          hint: Text(
                            'Select Location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: townList
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.name!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: dropdownController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: dropdownController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onChanged: (text) {
                                  print('printing searched text${text}');

                                  if (text == '' ||
                                      text == null ||
                                      text.isEmpty) {
                                    setState(() {
                                      townList = [];
                                      searchedTown = text;
                                    });
                                  } else {
                                    getTownList(text, setState);
                                  }
                                },
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              //print("On Search Function ${item.value!.name!.toLowerCase().toString()[searchValue.length]}");

                              if (item.value!.name!.length >=
                                  searchValue.length) {
                                if (item.value!.name!.length >=
                                        searchValue.length &&
                                    searchValue.length != 0) {
                                  return item.value!.name!
                                          .toLowerCase()
                                          .substring(0, searchValue.length) ==
                                      (searchValue.toLowerCase());
                                } else {
                                  return true;
                                }
                              } else {
                                return false;
                              }
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              dropdownController.clear();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w),
                  child: Container(
                    width: 200.w,
                    child: MaterialButton(
                      onPressed: () {},
                      height: 35.h,
                      minWidth: 180.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r))),
                      color: Color(0xff1C4ED8),
                      child: Center(
                          child: Text(
                        "Search",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 14.sp),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
