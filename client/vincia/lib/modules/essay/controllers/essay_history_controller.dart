import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../models/essay_model.dart';
import '../services/essay_history_service.dart';

part 'essay_history_controller.g.dart';

class EssayHistoryController = _EssayHistoryController with Store;

abstract class _EssayHistoryController with Store {
  final EssayHistoryService _essayHistoryService = Modular.get<EssayHistoryService>();
  final essays = <Essay>[];

  @observable
  ObservableFuture<List<Essay>>? essayHistoryFuture;

  @action
  fetchEssayHistory() {
    essayHistoryFuture = ObservableFuture(_essayHistoryService.getEssayHistory());
  }
}
