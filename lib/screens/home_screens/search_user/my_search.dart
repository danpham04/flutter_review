import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';
import 'package:provider/provider.dart';

class MySearch extends StatefulWidget {
  const MySearch({
    super.key,
  });

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  late TextEditingController _controllerSearch;
  late String text;
  @override
  void initState() {
    _controllerSearch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHome>(context);
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  provider.clearSearchUser();
                } else {
                  provider.searchUser(value: value);
                }
              },
              controller: _controllerSearch,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controllerSearch.clear();
                      provider.clearSearchUser();
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
            child: Consumer<ProviderHome>(builder: (context, provider, child) {
              if (provider.searchUserData.isEmpty) {
                if (_controllerSearch.text == '') {
                  return Center(
                    child: Text(
                        'Please enter a search term with type ${provider.key}.'),
                  );
                } else if (provider.checkValue == false &&
                    provider.checkSearchUser == false) {
                  return const Center(
                    child: Text('No value!'),
                  );
                } else {
                  return Center(
                    child: Text(provider.messSearch),
                  );
                }
              }
              return ListView.builder(
                itemCount: provider.searchUserData.length,
                itemBuilder: (context, index) {
                  final users = provider.searchUserData[index];
                  return InforUser(users: users);
                },
              );
            }),
          )
        ],
      ),
    );
  }

  void _filterDataUser(BuildContext context) {
    final providerHome = Provider.of<ProviderHome>(context, listen: false);
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
                itemCount: providerHome.listTilte.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      value: providerHome.listTilte[index].toLowerCase(),
                      title: Text(providerHome.listTilte[index]),
                      groupValue: providerHome.key,
                      onChanged: (value) {
                        providerHome.setKey(value as String);
                        providerHome.searchUser(value: _controllerSearch.text);
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
