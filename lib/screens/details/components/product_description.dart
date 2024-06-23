import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:html/parser.dart' as htmlParser;

// import '../../../constants.dart';
import '../../../models/Blog.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.blog,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Blog blog;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            blog.titulo,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 48,
            // decoration: BoxDecoration(
            //   color: blog.isFavourite
            //       ? const Color(0xFFFFE6E6)
            //       : const Color(0xFFF5F6F9),
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     bottomLeft: Radius.circular(20),
            //   ),
            // ),
            // child: SvgPicture.asset(
            //   "assets/icons/Heart Icon_2.svg",
            //   colorFilter: ColorFilter.mode(
            //       blog.isFavourite
            //           ? const Color(0xFFFF4848)
            //           : const Color(0xFFDBDEE4),
            //       BlendMode.srcIn),
            //   height: 16,
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 64, bottom: 10.0),
          child: Text(
            blog.descripcion,
            maxLines: 3,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 64,
            ),
            child: Html(
              data: blog.contenido,
            )),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 20,
        //     vertical: 12,
        //   ),
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: const Row(
        //       children: [
        //         Text(
        //           "See More Detail",
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600, color: kPrimaryColor),
        //         ),
        //         SizedBox(width: 5),
        //         Icon(
        //           Icons.arrow_forward_ios,
        //           size: 12,
        //           color: kPrimaryColor,
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
