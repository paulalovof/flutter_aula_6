import 'package:asp/asp.dart';

import '../../../domain/entity/pet.dart';
import '../../state/pet_state.dart';

abstract class PetDetailStore {
// atom
  static final petEditingAtom = Atom<bool>(false);
  static final petLoadingAtom = Atom<bool>(false);
  static final petUpdatedAtom = Atom<PetState>(InitialState());
  static final petByIdAtom = Atom<PetState>(InitialState());

// actions
  static final togglePetEditingAction = Atom<bool?>(null);
  static final updatePet = Atom<Pet?>(null);
  static final fetchPetById = Atom<int>(0);
}
