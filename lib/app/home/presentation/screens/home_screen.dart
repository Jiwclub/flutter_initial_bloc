import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initial_bloc/app/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
// with extensions
    context.read<HomeBloc>().add(GetNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
            if (state is NewsSuccess) {
              return ListView.builder(
                itemCount: state.products?.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = state.products?[index];
                  return Column(
                    children: [
                      Text("${item?.title}"),
                      Image.network('${item?.thumbnail}'),
                      Text("${item?.brand}"),
                    ],
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
