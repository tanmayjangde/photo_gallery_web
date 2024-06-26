import 'package:flutter/material.dart';
import 'package:photo_gallery/helpers/responsive.dart';
import 'package:photo_gallery/helpers/theme_provider.dart';
import 'package:photo_gallery/models/image_model.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatefulWidget {
  final List<ImageModel> images;
  final int currentIndex;
  const ImageDialog(
      {super.key, required this.currentIndex, required this.images});
  @override
  State<StatefulWidget> createState() => ImageDialogState();
}

class ImageDialogState extends State<ImageDialog> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      index = widget.currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height * 0.5
                : MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.grey[900]
                    : Colors.white),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.images[index].url,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                  )),
            ),
          ),
          Positioned(
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.navigate_before,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    index = (index - 1 + widget.images.length) %
                        widget.images.length;
                  });
                },
              )),
          Positioned(
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.navigate_next,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    index = (index - 1) % widget.images.length;
                  });
                },
              )),
          Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
