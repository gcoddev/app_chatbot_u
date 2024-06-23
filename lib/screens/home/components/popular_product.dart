import 'package:chatbot_u/components/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // Importa el paquete http para realizar la solicitud HTTP
import 'dart:convert'; // Importa el paquete convert para trabajar con JSON

// import '../../../components/product_card.dart';
import '../../../models/Blog.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogsAll();
  }

  Future<void> fetchBlogsAll() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.10:3001/api/blogsAll'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Blog> dataBlogs =
          responseData.map((data) => Blog.fromJson(data)).toList();
      setState(() {
        blogs = dataBlogs;
      });
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Blogs",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...blogs.map((blog) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BlogCard(
                    blog: blog,
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments: ProductDetailsArguments(blog: blog),
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
