import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_mvvm_template/ui/home/view_model/home_viewmodel.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('appName').tr(),
            actions: [
              Checkbox(
                  value: viewModel.isDarkMode,
                  onChanged: (value) => viewModel.changeTheme(context))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('counterText').tr(args: ['${viewModel.countNumber}']),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: viewModel.increment,
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: viewModel.decrement,
                      tooltip: 'Decrement',
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
