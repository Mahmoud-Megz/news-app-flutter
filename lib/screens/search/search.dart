import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';




class SearchScreen extends StatelessWidget {

var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {  },
    builder: (BuildContext context, state) {
      var list= NewsCubit.get(context).search;

      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormText(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchData(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'search empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search
              ),
            ),
            Expanded(child: buildNewsScreen(list,isSearch: true)),

          ],
        ),
      );
    });
    }
  }

