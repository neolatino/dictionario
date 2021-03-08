import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionary/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionary/ui/page/dictionary_page.dart';
import 'package:neolatino_dictionary/ui/page/info_page.dart';
import 'package:neolatino_dictionary/ui/styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  final _entries = [
    BottomNavigationEntry("Dictionario", Icons.language, DictionaryPage()),
    BottomNavigationEntry("Informationes", Icons.info_outline, InfoPage()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageSelected(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(_currentPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DictionaryBloc>(
          create: (context) => DictionaryBloc(),
        ),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _entries.map((it) => it.page).toList(),
          onPageChanged: (index) => onPageSelected(index),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPageIndex,
          backgroundColor: AppStyles.colorSecondary,
          selectedItemColor: AppStyles.colorAccent,
          unselectedItemColor: AppStyles.colorPrimary,
          items: _entries
              .map((it) => BottomNavigationBarItem(
                    title: Text(it.title),
                    icon: Icon(it.icon),
                  ))
              .toList(),
          onTap: (index) => onPageSelected(index),
        ),
      ),
    );
  }
}

class BottomNavigationEntry {
  final String title;
  final IconData icon;
  final Widget page;

  BottomNavigationEntry(this.title, this.icon, this.page);
}
