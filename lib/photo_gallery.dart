import 'package:flutter/material.dart';
import 'package:photo_gallery/helpers/responsive.dart';
import 'package:photo_gallery/models/image_model.dart';
import 'package:photo_gallery/services/images_services.dart';
import 'package:photo_gallery/widgets/custom_appbar.dart';
import 'package:photo_gallery/widgets/footer.dart';
import 'package:photo_gallery/widgets/image_card.dart';
import 'package:photo_gallery/widgets/image_dialog.dart';
import 'package:photo_gallery/widgets/skeleton_loader.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<StatefulWidget> createState() => PhotoGalleryState();
}

class PhotoGalleryState extends State<PhotoGallery> {
  List<ImageModel> _images = [];
  String query = '';
  int pageIndex = 1;
  final ScrollController _scrollController = ScrollController();

  void showModelImage(int index) {
    showDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        builder: (context) {
          return ImageDialog(currentIndex: index, images: _images);
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        List<ImageModel> imagesNew =
            await ImageServices().fetchImages(query, ++pageIndex);
        setState(() {
          _images.addAll(imagesNew);
        });
      }
    });
  }

  getData() async {
    _images = await ImageServices().fetchImages('', pageIndex);
    setState(() {
      _images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        search: (searchQuery) async {
          _images = await ImageServices().fetchImages(searchQuery, 1);
          setState(() {
            _images;
            query = searchQuery;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isMobile(context)
                          ? 2
                          : Responsive.isTablet(context)
                              ? 3
                              : 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: _images.isEmpty ? 12 : _images.length,
                  itemBuilder: (context, index) {
                    return _images.isEmpty
                        ? const SkeletonLoader()
                        : ImageCard(
                            imageData: _images[index],
                            index: index,
                            onTap: showModelImage);
                  }),
              const SizedBox(
                height: 10,
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
