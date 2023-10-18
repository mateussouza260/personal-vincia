import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../controllers/essay_history_controller.dart';
import '../models/essay_model.dart';

class EssayHistoryPage extends StatefulWidget {
  @override
  _EssayHistoryPageState createState() => _EssayHistoryPageState();
}

class _EssayHistoryPageState extends State<EssayHistoryPage> {
  final EssayHistoryController _essayHistoryController = Modular.get();

  @observable
  ObservableFuture<List<Essay>>? essayHistoryFuture;

  @override
  void initState() {
    super.initState();

    _essayHistoryController.fetchEssayHistory();

    essayHistoryFuture = _essayHistoryController.essayHistoryFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Essay History'),
      ),
      body: FutureBuilder<List<Essay>>(
        future: essayHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final essays = snapshot.data!;
            return ListView.builder(
              itemCount: essays.length,
              itemBuilder: (context, index) {
                final essay = essays[index];
                return ListTile(
                  title: Text(essay.title),
                  subtitle: Text(essay.createdAt.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
