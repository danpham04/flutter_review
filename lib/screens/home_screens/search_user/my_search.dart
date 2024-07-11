import 'package:flutter/material.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class MySearch extends StatefulWidget {
  const MySearch({
    super.key,
  });

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  List<UserModel> userdata = [];
  String key = 'id';

  final HomeServices _homeServices = HomeServices();
  late TextEditingController _controllerSearch;
  @override
  void initState() {
    _controllerSearch = TextEditingController();
    super.initState();
  }

  Future<void> searchUser(String value) async {
    try {
      final List<UserModel> temp = await _homeServices.searchData(key, value);
      setState(() {
        userdata = temp;
      });
    } catch (e) {
      setState(() {
        userdata = [];
      });
      // print('Error searching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarShared(
        titleName: 'Search User',
        colors: Colors.black,
        colorBack: const Color.fromARGB(255, 129, 185, 231),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onSubmitted: (value) {
                if (value.isEmpty) {
                  setState(() {
                    userdata = [];
                  });
                } else {
                  searchUser(value);
                }
              },
              controller: _controllerSearch,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _controllerSearch.clear();
                        setState(() {
                          userdata = [];
                        });
                      },
                      icon: const Icon(Icons.clear)),
                  hintText: 'Search.....',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          Expanded(
              child: userdata.isEmpty
                  ? const Center(child: Text('No value.....!'))
                  : ListView.builder(
                      itemCount: userdata.length,
                      itemBuilder: (context, index) {
                        final user = userdata[index];
                        return InforUser(users: user);
                      },
                    ))
        ],
      ),
    );
  }
}
