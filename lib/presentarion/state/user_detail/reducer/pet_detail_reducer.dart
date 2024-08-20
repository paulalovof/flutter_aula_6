import 'package:asp/asp.dart';

import '../../../core/errors/errors_classes.dart';
import '../../../core/errors/errors_messagens.dart';
import '../../../domain/usecase/get_by_id_pet_use_case_impl.dart';
import '../../../domain/usecase/update_pet_use_case_impl.dart';
import '../../../domain/usecase/use_case_contract.dart';
import '../../state/pet_state.dart';
import '../atom/user_detail_atom.dart';

class PetDetailReducer extends Reducer {
  final IUseCase updatePetUseCase;
  final IUseCase getByIdPetUseCase;

  PetDetailReducer({
    required this.updatePetUseCase,
    required this.getByIdPetUseCase,
  }) {
    on(() => [PetDetailStore.togglePetEditingAction], _togglePetEditingAction);
    on(() => [PetDetailStore.updatePet], _updatePet);
    on(() => [PetDetailStore.fetchPetById], _fetchPetById);
  }

  _togglePetEditingAction() async {
    PetDetailStore.petLoadingAtom.setValue(true);
    await Future.delayed(const Duration(seconds: 2));

    PetDetailStore.petEditingAtom.value =
        PetDetailStore.togglePetEditingAction.value ??
            !PetDetailStore.petEditingAtom.value;

    PetDetailStore.petLoadingAtom.setValue(false);
  }

  _updatePet() async {
    PetDetailStore.petLoadingAtom.setValue(true);
    await Future.delayed(const Duration(seconds: 2));

    if (PetDetailStore.updatePet.value == null) {
      PetDetailStore.petUpdatedAtom.value =
          ErrorState(EmptyField(MessagesError.emptyFieldError));
    } else {
      PetDetailStore.petUpdatedAtom.value = await updatePetUseCase
          .call(UpdatePetParams(pet: PetDetailStore.updatePet.value!));
    }
    PetDetailStore.petLoadingAtom.setValue(false);
  }

  _fetchPetById() async {
    PetDetailStore.petLoadingAtom.setValue(true);
    await Future.delayed(const Duration(seconds: 2));
    if (PetDetailStore.fetchPetById.value <= 0) {
      PetDetailStore.petByIdAtom.value =
          ErrorState(EmptyField(MessagesError.idError));
    } else {
      PetDetailStore.petByIdAtom.value = await getByIdPetUseCase
          .call(GetByIdPetParams(idPet: PetDetailStore.fetchPetById.value));
    }
    PetDetailStore.petLoadingAtom.setValue(false);
  }
}
