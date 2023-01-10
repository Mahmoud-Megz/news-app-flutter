import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/components/components.dart';

class SportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        builder: (BuildContext context, state) {
          var list =NewsCubit.get(context).sports;
          return buildNewsScreen(list);

        },
        listener: (BuildContext context, state) {}

    );
  }
}