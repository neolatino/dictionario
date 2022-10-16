import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionario/config.dart';
import 'package:neolatino_dictionario/dict/dict.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';
import 'package:neolatino_dictionario/dict/language.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/page.dart';
import 'package:neolatino_dictionario/widget/searchbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) => PageTemplate(
        header: Searchbar(),
        content: state.matches.when(
          some: (matches) => ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              return match(matches[index]);
            },
          ),
          none: () => Container(),
        ),
      ),
    );
  }

  Widget empty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: Config.responsiveHeight(context, 100)),
        Text(
          "NEOLATINO",
          style: GoogleFonts.headlandOne(
            fontSize: Config.responsiveWidth(context, 80),
            color: Style.colorAccent,
          ),
        ),
        Text(
          "DICTIONARIO",
          style: GoogleFonts.headlandOne(
            fontSize: Config.responsiveWidth(context, 25),
            color: Style.colorOnPrimary,
          ).copyWith(letterSpacing: Config.responsiveWidth(context, 32)),
        ),
        Container(),
      ],
    );
  }

  Widget match(SearchMatch match) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: 550,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Style.DarkerPink, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 120, child: Language.NeoLatino.widget()),
                      SizedBox(width: 20),
                      Flexible(
                        child: SelectableText(
                          match.entry.as(Language.NeoLatino).unwrap(),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Style.DarkerPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1,
                      color: Style.DarkerPink,
                    ),
                  ),
                  Column(
                    children: match.entry
                        .langs()
                        .skip(1)
                        .map(
                          (lang) => Row(
                            children: [
                              SizedBox(width: 120, child: lang.widget()),
                              SizedBox(width: 20),
                              Flexible(
                                child: SelectableText(
                                  match.entry.as(lang).unwrap(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Style.DarkerPink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
