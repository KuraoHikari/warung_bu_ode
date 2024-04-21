import 'package:flutter/material.dart';
import 'package:warung_bu_ode/models/menu.dart';
import 'package:warung_bu_ode/routes/detail_screen.dart';
import 'package:intl/intl.dart';

class VCard extends StatefulWidget {
  const VCard({Key? key, required this.menu}) : super(key: key);

  final MenuItem menu;

  @override
  State<VCard> createState() => _VCardState();
}

class _VCardState extends State<VCard> {
  final idrFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailScreen.routeName,
          arguments: MenuItem(
            id: widget.menu.id,
            title: widget.menu.title,
            price: widget.menu.price,
            image: widget.menu.image,
            desc: widget.menu.desc,
          ),
        );
      },
      onLongPress: () {
        setState(() {
          showInfo = true;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          showInfo = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 116, 116, 116).withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: const BoxConstraints(maxWidth: 150, maxHeight: 210),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 310,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image size fill
                    image: AssetImage(widget.menu.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            if (showInfo)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.grey.withOpacity(0.5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 170),
                        child: Text(
                          widget.menu.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.menu.desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            if (!showInfo)
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.grey.withOpacity(0.3),
                          Colors.grey,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 0, top: 20, right: 10),
                            child: Text(
                              widget.menu.title.length > 18
                                  ? '${widget.menu.title.substring(0, 15)}...'
                                  : widget.menu.title,
                              style: const TextStyle(color: Colors.white),
                              maxLines: 5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10, right: 10),
                            child: Text(
                              idrFormat.format(widget.menu.price),
                              style: const TextStyle(color: Colors.white),
                              maxLines: 5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
  }
}
