import 'package:agribazaar/Provider/HomeProvider.dart';
import 'package:agribazaar/Utility/Routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isSortedZToAOrder = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News Feeds'),
        actions: [
          PopupMenuButton<String>(
            offset: Offset(0, 55),
            onSelected: (value) {
              if (value == '1') {
                isSortedZToAOrder = false;
                provider.articleList.sort((item1, item2) => item1.source.name
                    .toLowerCase()
                    .compareTo(item2.source.name.toLowerCase()));
                setState(() {});
              } else {
                isSortedZToAOrder = true;
                provider.articleList.sort((item1, item2) => item2.source.name
                    .toLowerCase()
                    .compareTo(item1.source.name.toLowerCase()));
                setState(() {});
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: '1',
                child: Row(
                  children: [
                    Icon(
                      !isSortedZToAOrder ? Icons.check : null,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Sort A-Z'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: '2',
                child: Row(
                  children: [
                    Icon(
                      isSortedZToAOrder ? Icons.check : null,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Sort Z-A'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: FutureBuilder(
          future:
              provider.articleList.isEmpty ? provider.getAllNewsFeeds() : null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.deepOrange,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: provider.articleList.length,
                itemBuilder: (BuildContext context, int index) {
                  var selectedItem = provider.articleList[index];
                  return ListTile(
                    onTap: () {
                      provider.setSelectedModelItem(index);
                      Navigator.pushNamed(
                        context,
                        Routes.detailPage,
                      );
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: selectedItem.urlToImage == null
                            ? Image.asset('images/user.jpg')
                            : Image.network(
                                selectedItem.urlToImage,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    title: Text(
                      selectedItem.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(selectedItem.description == null
                            ? 'No Description Available'
                            : selectedItem.description),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'News Source: ${selectedItem.source.name == null ? 'No News Source Available' : selectedItem.source.name}',
                          style: TextStyle(
                              color: selectedItem.source.name == ''
                                  ? Colors.deepOrange
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0.5,
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
