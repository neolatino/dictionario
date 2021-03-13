import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionario/bloc/dictionary_bloc.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: BlocBuilder<DictionaryBloc, DictionaryState>(
                      builder: (BuildContext context, state) {
                        var search = state is SearchState ? state.search : null;
                        return TextField(
                          enabled: false,
                          // WIP
                          controller: search != null ? (TextEditingController()..text = search) : null,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Cercare...",
                          ),
                          onSubmitted: (query) =>
                              BlocProvider.of<DictionaryBloc>(context).add(DictionaryEvent.search(query)),
                        );
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
