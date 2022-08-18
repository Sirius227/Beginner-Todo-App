import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _timeString = "";
  String _dateString = "";

  @override
  void initState() {
    initializeDateFormatting('tr');
    _timeString = DateFormat.jm('tr').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());

    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat.jm('tr').format(now);
    final formattedDate = DateFormat.MMMMd('tr').format(now);
    setState(() {
      _timeString = formattedDateTime;
      _dateString = formattedDate;
    });
  }

  static List<bool> isChecked = [false, false, false, false];
  static List<bool> selected = [false, false, false, false];
  final _fontFamily = "Montserrat";
  final _itemCount = 3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedCount = 0;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final width = screen.size.width;

    final now = DateTime.now();

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 50,
              ),
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        "https://is3-ssl.mzstatic.com/image/thumb/L64-7TeY1hejFePvG6tP9Q/1200x675mf.jpg",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "Deadpool",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: _fontFamily,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      "info@deadpool.com",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: _fontFamily,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Uygulama Ayarları",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: _fontFamily,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  "Bildirim Ayarları",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: _fontFamily,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.alarm,
                  color: Colors.white,
                ),
                title: Text(
                  "Alarm Ayarları",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: _fontFamily,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: Text(
                  "Yardım",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: _fontFamily,
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 35.0, right: 20.0, left: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: width / 12,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  myWhiteText(_dateString, width / 23.0),
                  myWhiteText(
                    _timeString,
                    width / 23.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListTile(
                textColor: Colors.white,
                title: Text(
                  "Bugün",
                  style: TextStyle(
                      fontSize: width / 17.6, fontFamily: _fontFamily),
                ),
                subtitle: Text(
                  "$_itemCount görev",
                  style: TextStyle(fontFamily: _fontFamily),
                ),
                trailing: SizedBox(
                  width: width / 3.5,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Yeni Görev Ekle",
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontFamily: _fontFamily,
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              content: Builder(
                                builder: (context) {
                                  return SizedBox(
                                    width: width - 90,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextField(
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontFamily: _fontFamily,
                                        ),
                                        maxLength: 25,
                                        decoration: InputDecoration(
                                          labelText: "Görev",
                                          labelStyle: TextStyle(
                                            color: Colors.deepPurple,
                                            fontFamily: _fontFamily,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Colors.deepPurple,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              actionsPadding: const EdgeInsets.only(right: 8),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  child: Text(
                                    "Ekle",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: _fontFamily,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  child: Text(
                                    "İptal",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: _fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                    ),
                    child: Text(
                      "Yeni Başlık",
                      style: TextStyle(fontFamily: _fontFamily),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, right: 40, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  myWhiteText(
                                    DateFormat.d('tr').format(now),
                                    23,
                                  ),
                                  myWhiteText(
                                    DateFormat.MMM('tr').format(now),
                                    14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            "Toplam 6 saat",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: _itemCount * 82,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _itemCount,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 1.0, top: 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selected[i] ? Colors.deepPurple : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  selected[i] = selected[i] ? false : true;
                                  if (selected[i]) {
                                    setState(() {
                                      selectedCount += 1;
                                    });
                                  } else {
                                    setState(() {
                                      selectedCount -= 1;
                                    });
                                  }
                                },
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: selected[i]
                                          ? Colors.white
                                          : Colors.deepPurple,
                                      width: 2.3,
                                    ),
                                  ),
                                  width: 30,
                                  height: 30,
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: selected[i]
                                            ? Colors.deepPurple
                                            : Colors.white),
                                    child: Checkbox(
                                      checkColor: selected[i]
                                          ? Colors.white
                                          : Colors.deepPurple,
                                      activeColor: selected[i]
                                          ? Colors.deepPurple
                                          : Colors.white,
                                      value: isChecked[i],
                                      tristate: true,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked[i] =
                                              isChecked[i] ? false : true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Kahvaltı",
                                  style: TextStyle(
                                      color: selected[i] ? Colors.white : null,
                                      fontFamily: "Montserrat"),
                                ),
                                subtitle: Text(
                                  "08:00 - 09:00",
                                  style: TextStyle(
                                    color: selected[i]
                                        ? Colors.white60
                                        : Colors.grey,
                                    fontFamily: _fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple,
      floatingActionButton: selectedCount == 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Seçilenler silindi",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepPurple,
                    action: SnackBarAction(
                      label: "Geri al",
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                );
              },
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              child: const Icon(CupertinoIcons.trash),
            ),
    );
  }

  Widget myWhiteText(String content, double? fontSize) {
    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontFamily: _fontFamily,
      ),
    );
  }
}
