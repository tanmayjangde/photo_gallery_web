import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_gallery/models/image_model.dart';

class ImageCard extends StatefulWidget {
  final ImageModel imageData;
  final int index;
  final Function(int) onTap;
  const ImageCard(
      {super.key,
      required this.imageData,
      required this.index,
      required this.onTap});

  @override
  State<StatefulWidget> createState() => ImageCardState();
}

class ImageCardState extends State<ImageCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? (Matrix4.identity()
              ..scale(1.03, 1.03)
              ..translate(0, -1))
            : Matrix4.identity(),
        child: GestureDetector(
          onTap: () {
            widget.onTap(widget.index);
          },
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: Image.network(
                    widget.imageData.url,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.label,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(
                            widget.imageData.tags,
                            style: GoogleFonts.titilliumWeb(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(
                            widget.imageData.views.toString(),
                            style: GoogleFonts.titilliumWeb(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(
                            widget.imageData.likes.toString(),
                            style: GoogleFonts.titilliumWeb(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
