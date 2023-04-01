import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedUi extends StatefulWidget {
  const AdvancedUi({Key? key}) : super(key: key);

  @override
  State<AdvancedUi> createState() => _AdvancedUiState();
}

class _AdvancedUiState extends State<AdvancedUi> {
  bool textColor = false;

  List<Widget> _buildList(int count) {
    List<Widget> listItems = [];
    for (int i = 0; i < count; i++) {
      listItems.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              textColor = true;
            });
          },
          onLongPress: (){
            setState(() {
              textColor = false;
            });
          },
          child: SizedBox(
            height: 100.0,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Card ${i.toString()}\n Tap to change the color\nLong press to retrieve color',
                  style: GoogleFonts.armata(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: textColor==true?Colors.deepPurple:Colors.blue.shade300,
                      letterSpacing: 2),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/sliver.png',
                  fit: BoxFit.cover,
                ),
                stretchModes: const [StretchMode.zoomBackground],
              ),
              leading: Column(
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.blue.shade300,
                          ))),
                ],
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(_buildList(10))),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.blue.shade300),
                );
              }, childCount: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1),
            )
          ],
        ),
      ),
    );
  }
}
