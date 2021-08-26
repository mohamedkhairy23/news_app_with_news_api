import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app_layout/cubit/news_cubit.dart';
import 'package:news_app/news_app_layout/cubit/news_states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty)
                    {
                      return "Search must not be empty";
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  label: "Search",
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
