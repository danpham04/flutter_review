import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
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
  List<String> listTilte = ['ID', 'Name', 'Address', 'Mail', 'Nationality'];
  final HomeServices _homeServices = HomeServices();
  late TextEditingController _controllerSearch;
  late String text;
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
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
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
            onPressed: () => _filterDataUser(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    userdata = [];
                  });
                } else {
                  setState(() {
                    searchUser(value);
                  });
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
                    icon: IconButton(
                      onPressed: () {
                        text = _controllerSearch.text;
                        if (text.isEmpty) {
                          Navigator.of(context).pushNamed(AppRoutes.homeScress);
                        } else {
                          _controllerSearch.text = '';
                        }
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
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
                  ),
          ),
        ],
      ),
    );
  }

  void _filterDataUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSearch) {
          return AlertDialog(
            title: const Text('You want to search'),
            content: SingleChildScrollView(
                child: SizedBox(
              width: 250,
              height: 280,
              child: ListView.builder(
                itemCount: listTilte.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      value: listTilte[index].toLowerCase(),
                      title: Text(listTilte[index]),
                      groupValue: key,
                      onChanged: (value) {
                        setState(() {
                          key = value!;
                        });
                        searchUser(_controllerSearch.text);
                        Navigator.pop(context);
                      });
                },
              ),
            )),
            actions: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 120, 178, 226))),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
