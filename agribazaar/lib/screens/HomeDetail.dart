import 'package:agribazaar/Provider/HomeProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedItem =
        Provider.of<HomeProvider>(context, listen: false).selectedArticle;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feed Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 350,
              child: selectedItem.urlToImage == null
                  ? Image.asset('images/noImageFound.jpg')
                  : Image.network(
                      selectedItem.urlToImage,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Wiki-source',
                        style: TextStyle(color: Colors.deepPurple),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final url = selectedItem.url;
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
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
                    height: 10,
                  ),
                  Text(
                    selectedItem.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    selectedItem.description == null
                        ? 'No data available'
                        : selectedItem.description,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Text(
                    selectedItem.content == null
                        ? 'No data available'
                        : selectedItem.content,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      'News Source: ${selectedItem.source.name == null ? 'No Source available' : selectedItem.source.name}',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Author: ${selectedItem.author == '' ? 'No Author Available' : selectedItem.author}',
                      style: TextStyle(
                          color: selectedItem.author == ''
                              ? Colors.deepOrange
                              : Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
