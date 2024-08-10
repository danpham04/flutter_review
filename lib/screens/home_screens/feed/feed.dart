import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _curr = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  late ProviderHome provider;

  @override
  void initState() {
    provider = Provider.of<ProviderHome>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        Center(
          child: CarouselSlider.builder(

            itemCount: provider.loadUser.length,
            itemBuilder: (context, index, realIndex) {
              // final users = loadUser[index];

              if (provider.loadUser.isNotEmpty) {
                final UserModel users = provider.loadUser[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.showInfor, arguments: users);
                  },
                  child: SizedBox(
                    width: 270,
                    child: Image.network(
                      users.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              return const Center(
                child: Text(
                  "Load Images.......!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
            carouselController: _controller,
            options: CarouselOptions(
              initialPage: 0,
              height: 400,
              onPageChanged: (index, reason) => setState(() {
                _curr = index;
              }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnimatedSmoothIndicator(
            activeIndex: _curr,
            count: provider.loadUser.length,
            effect: const JumpingDotEffect(
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.previousPage();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _controller.nextPage();
              },
              child: const Icon(Icons.arrow_forward),
            )
          ],
        )
      ],
    );
  }
}
