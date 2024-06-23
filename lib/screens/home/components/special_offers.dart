import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:chatbot_u/screens/products/products_screen.dart';
import 'section_title.dart';
import 'package:chatbot_u/models/Video.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late List<Video> videos = [];

  @override
  void initState() {
    super.initState();
    // Llama al método para obtener los videos al iniciar el widget
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.10:3001/api/videosAll'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Video> dataVideos =
          responseData.map((data) => Video.fromJson(data)).toList();

      final List<Video> filteredVideos =
          dataVideos.where((video) => video.estado == '1').toList();
      setState(() {
        videos = filteredVideos;
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Videos de ayuda",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: videos.map((video) {
              return SpecialOfferCard(
                video: video,
                press: () {
                  // Navigator.pushNamed(context, ProductsScreen.routeName);
                  launch(video.url);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.video,
    required this.press,
  }) : super(key: key);

  final Video video;
  final GestureTapCallback press;

  String obtenerCodigoVideo(String url) {
    if (url.contains('v=')) {
      List<String> partes = url.split('v=');
      if (partes.length >= 2) {
        String codigo = partes[1];
        if (codigo.contains('&')) {
          return codigo.split('&')[0];
        } else {
          return codigo;
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 135,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  'https://img.youtube.com/vi/${obtenerCodigoVideo(video.url)}/0.jpg',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "${video.titulo}\n",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
