import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pagination extends StatefulWidget {
  const pagination({super.key});

  @override
  State<pagination> createState() => _paginationState();
}

class _paginationState extends State<pagination> {
  final scrollController = ScrollController();
  bool isLoadinMore = false;
  List posts = [];
  int page = 1;
  @override
  void initState() {
    fetchPosts();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          controller: scrollController,
          itemCount: isLoadinMore ? posts.length + 1 : posts.length,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              final post = posts[index];
              final title = post['images'];
              return Container(
                height: 250,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(title[0]),
                )),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> fetchPosts() async {
    final url =
        "https://api.escuelajs.co/api/v1/products?limit=15&offset=$page";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(
        () {
          posts = posts + json;
        },
      );
    } else {}
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      setState(
        () {
          isLoadinMore = true;
        },
      );
      await fetchPosts();
      setState(
        () {
          isLoadinMore = false;
        },
      );
    }
  }
}
