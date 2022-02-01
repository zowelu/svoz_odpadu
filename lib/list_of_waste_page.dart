import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/components/utils.dart';
import 'package:intl/intl.dart';

class ListOfWastePage extends StatefulWidget {
  const ListOfWastePage({Key? key}) : super(key: key);
  static const id = '/listOfWastePage';

  @override
  _ListOfWastePageState createState() => _ListOfWastePageState();
}

class _ListOfWastePageState extends State<ListOfWastePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kDMyAppBarHeight),
        child: MyAppBar(),
      ),
      backgroundColor: kDBackgroundColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: kDBackgroundColorCalendar,
                  width: double.infinity,
                  height: kDMyAppBarHeight,
                  child: const Center(
                    child: TextHeader(
                      text: 'Přehled',
                      color: kDBackgroundColor,
                    ),
                  ),
                ),
                SizedBox(height: kDMargin,),
                Container(
                  decoration: const BoxDecoration(
                      color: kDBackgroundColorCalendar,
                      borderRadius: kDRadiusLarge),
                  padding: const EdgeInsets.all(2.0),
                  margin:
                      const EdgeInsets.only(left: kDMargin, right: kDMargin),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: allWasteEvents.length,
                    itemBuilder: (context, int index) {
                      Color? color;
                      DateTime date =
                          allWasteEvents.keys.elementAt(index);

                      DateFormat formatter = DateFormat('dd. MM. yyyy');
                      String dateFormatted = formatter.format(date);

                      String dayOfWeek = date.weekday.toString();

                      String name =
                          allWasteEvents.values.elementAt(index).toString();
                      String nameOfWaste = name.substring(1, name.length - 1);
                      if (nameOfWaste == 'plast') {
                        nameOfWaste = 'Plast a nápojový karton\nDrobné kovy';
                        color = kDColorWastePlastic;
                      } else if (nameOfWaste == 'směsný' ||
                          nameOfWaste == ('směsný odpad')) {
                        nameOfWaste = 'Směsný odpad';
                        color = kDColorWasteMixed;
                      } else if (nameOfWaste == 'papír') {
                        nameOfWaste = 'Papírový odpad';
                        color = kDColorWastePaper;
                      } else if (nameOfWaste == 'bio') {
                        nameOfWaste = 'Bio odpad';
                        color = kDColorWasteBio;
                      }

                      return ListTileOfWaste(
                          text: nameOfWaste,
                          color: color,
                          date: dateFormatted,
                          dayOfWeek: dayOfWeek);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
