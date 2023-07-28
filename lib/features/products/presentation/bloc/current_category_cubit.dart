import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/domain/entities.dart';

class CurrentCategoryCubit extends Cubit<Categories> {
  CurrentCategoryCubit() : super(Categories.all);

  void setCategory(Categories categories) => emit(categories);
}
