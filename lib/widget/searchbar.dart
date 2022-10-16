import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';

class Searchbar extends StatelessWidget {
  final Function? onSubmit;

  Searchbar({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.black,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: BlocBuilder<DictionaryCubit, DictionaryState>(
                      builder: (BuildContext context, state) {
                        return TextField(
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Cercare...",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                )),
                            onSubmitted: (query) {
                              final queryTrimmed = query.trim();
                              BlocProvider.of<DictionaryCubit>(context)
                                  .query(queryTrimmed);
                              GoRouter.of(context)
                                  .go('/search/' + queryTrimmed);
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
