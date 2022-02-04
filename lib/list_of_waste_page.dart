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
  Map<int, String> daysOfWeek = {
    1: 'Pondělí',
    2: 'Úterý',
    3: 'Středa',
    4: 'Čtvrtek',
    5: 'Pátek',
    6: 'Sobota',
    7: 'Neděle',
  };

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
                SizedBox(
                  height: kDMargin,
                ),
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
                    itemCount: allWasteEventsOverviewListFromNow.length,
                    itemBuilder: (context, int index) {
                      Color? color;
                      String? asset;
                      DateTime date = allWasteEventsOverviewListFromNow.keys
                          .elementAt(index);

                      DateFormat formatter = DateFormat('dd. MM. yyyy');
                      String dateFormatted = formatter.format(date);

                      String dayOfWeek = daysOfWeek[date.weekday]!;

                      String name = allWasteEventsOverviewListFromNow.values
                          .elementAt(index)
                          .toString();
                      String nameOfWaste = name.substring(1, name.length - 1);
                      if (nameOfWaste == 'plast') {
                        nameOfWaste = 'Plast a nápojový karton,\nDrobné kovy';
                        color = kDColorWastePlastic;
                        asset = 'assets/images/icons/plastic.png';
                      } else if (nameOfWaste == 'směsný' ||
                          nameOfWaste == ('směsný odpad')) {
                        nameOfWaste = 'Směsný odpad';
                        color = kDColorWasteMixed;
                        asset = 'assets/images/icons/mixed.png';
                      } else if (nameOfWaste == 'papír') {
                        nameOfWaste = 'Papírový odpad';
                        asset = 'assets/images/icons/paper.png';
                        color = kDColorWastePaper;
                      } else if (nameOfWaste == 'bio' ||
                          nameOfWaste == 'bioodpad') {
                        nameOfWaste = 'Bioodpad';
                        color = kDColorWasteBio;
                        asset = 'assets/images/icons/bio.png';
                      }

                      return ListTileOfWaste(
                        text: nameOfWaste,
                        color: color,
                        date: dateFormatted,
                        dayOfWeek: dayOfWeek,
                        asset: asset,
                      );
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
