import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neolatino_dictionario/config.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/page.dart';

class PreLoader extends StatelessWidget {
  final Widget child;
  const PreLoader({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) => state.dictionary.when(
        some: (dict) => child,
        none: () => PageTemplate(
          content: loader(context),
        ),
      ),
    );
  }

  Widget loader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        SizedBox(height: Config.responsiveHeight(context, 100)),
        Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Style.colorAccent,
            size: 64,
          ),
        ),
        SizedBox(height: Config.responsiveHeight(context, 500)),
      ],
    );
  }
}
