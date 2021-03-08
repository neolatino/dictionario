import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionary/bloc/dictionary_bloc.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Cercare...",
                    ),
                    onSubmitted: (query) => BlocProvider.of<DictionaryBloc>(context).add(DictionaryEvent.search(query)),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
