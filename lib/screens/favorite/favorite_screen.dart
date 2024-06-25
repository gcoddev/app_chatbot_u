import 'package:chatbot_u/models/Document.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatbot_u/components/product_card.dart';
import 'package:chatbot_u/models/Product.dart';

import '../details/details_screen.dart';
import 'package:chatbot_u/env.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Document> documents = [];
  List<Product> demoProducts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        apiUrl + '/api/documentosAll'; // Cambia la URL por la correcta
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Document> dataDocs =
          jsonData.map((data) => Document.fromJson(data)).toList();
      final List<Document> filteredDocs =
          dataDocs.where((doc) => doc.estado == '1').toList();
      setState(() {
        documents = filteredDocs;
      });
    } else {
      throw Exception('Failed to load documents');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Documentos",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: documents.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => ProductCard(
                  document: documents[index],
                  onPress: () => Navigator.pushNamed(
                      context, DetailsScreen.routeName,
                      arguments: null
                      // ProductDetailsArguments(document: documents[index]),
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
