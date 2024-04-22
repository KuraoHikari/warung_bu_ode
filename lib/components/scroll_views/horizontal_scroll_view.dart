import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:warung_bu_ode/components/cards/vertical_card.dart';
import 'package:warung_bu_ode/models/menu.dart';

class HorizontalScrollView extends StatefulWidget {
  const HorizontalScrollView({super.key, required this.product});

  final String product;

  @override
  State<HorizontalScrollView> createState() => _HorizontalScrollViewState();
}

class _HorizontalScrollViewState extends State<HorizontalScrollView> {
  List foodList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (widget.product == "makanan") {
      foodList = MenuWarung.makanan;
    } else {
      foodList = MenuWarung.minuman;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScrollShadow(
        color: Colors.grey.withOpacity(0.3),
        size: 20,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: foodList
                .map(
                  (food) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: VCard(
                      menu: food,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ]);
  }
}
