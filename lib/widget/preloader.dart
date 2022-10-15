import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/Page.dart';

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
            fontSize: 80.0,
            color: Style.colorAccent,
          ),
        ),
        Text(
          "DICTIONARIO",
          style: GoogleFonts.headlandOne(
            fontSize: 25.0,
            color: Style.colorOnPrimary,
          ).copyWith(letterSpacing: 32),
        ),
        SizedBox(height: 100.0),
        Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Style.colorAccent,
            size: 64,
          ),
        ),
        SizedBox(height: 500.0),
      ],
    );
  }
}
