//import 'package:asp/asp.dart';
import '../core/routes/routes.dart';
//import '../core/validators/max_lenght_str_validator%20copy.dart';
import '../domain/mappers/user_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../components/inpute_text_field.dart';
import '../core/errors/errors_classes.dart';
import '../core/errors/errors_messagens.dart';
import '../core/validators/min_lenght_str_validator.dart';
import '../core/validators/text_field_validator.dart';
import '../domain/entity/pet.dart';
import '../presentarion/pet_list/atom/pet_list_tom.dart';
import '../presentarion/state/pet_list_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _textSearchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textSearchController.dispose();
  }

  void _searchPets() {
    PetListStore.fetchAll();
  }

  void _alertNoResultDialog() {
    String msgError = 'Sem Resultado para Mostrar';
    if (PetListStore.atomAllPet.value is ErrorStateList) {
      msgError =
          ((PetListStore.atomAllPet.value as ErrorStateList).failure as Failure)
              .msg;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Erro Inesperado'),
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.error,
            size: 80.0,
          ),
          content: Text(msgError, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => [
        PetListStore.loading,
        PetListStore.atomAllPet,
        PetListStore.atomPetByName,
      ],
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (PetListStore.atomAllPet.value is ErrorStateList &&
          !PetListStore.loading.value) {
        _alertNoResultDialog();
      }
    });

    return GestureDetector(
      onTap: (PetListStore.atomAllPet.value is ErrorStateList ||
              PetListStore.loading.value)
          ? null
          : () {
              // print(DateTime.now());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // var f = FocusScope.of(context);

              // if (!f.hasPrimaryFocus) {
              //   f.unfocus();
              // }
            },
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .secondaryContainer), // Change button color
                    ),
                    onPressed: PetListStore.loading.value
                        ? null
                        : () {
                            _textSearchController.clear();
                            _searchPets();
                          },
                    child: PetListStore.loading.value
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Buscar Todos',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                  ),
                  if (PetListStore.atomAllPet.value is SuccessStateList)
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InputTextField(
                              label: 'Digite um nome para busca!!!',
                              textEditingController: _textSearchController,
                              icon: Icons.search,
                              onValidator: (value) {
                                try {
                                  var isValid = TextFieldValidator(validators: [
                                    MinLengthStrValidator(minLength: 1),
                                    MaxLengthStrValidator(),
                                  ]).validations(value);

                                  if (!isValid) {
                                    return MessagesError.defaultError;
                                  }

                                  return null;
                                } on DefaultError catch (e) {
                                  return e.msg;
                                } catch (e) {
                                  return e.toString();
                                }
                              },
                            ),
                          ),
                          //const SizedBox(width: 1),
                          IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // _searchPets();
                                PetListStore.fetchByName
                                    .setValue(_textSearchController.text);
                              }
                            },
                            icon: const Icon(Icons.search),
                            color: Theme.of(context).colorScheme.primary,
                            iconSize: 40,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  switch (PetListStore.atomAllPet.value) {
                    InitialStateList() => const Text('Clique no Botão Buscar'),
                    (SuccessStateList state) =>
                      Expanded(child: ListOfPets(state: state)),
                    ErrorStateList() => Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              size: 70.0,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Teste Novamente',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                  },
                  if (PetListStore.atomPetByName.value is ErrorStateList)
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              size: 70.0,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Sem Resultados!!!',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )),
                  if ((PetListStore.atomPetByName.value is SuccessStateList) &&
                      (PetListStore.atomAllPet.value is SuccessStateList))
                    ListPetsByName(
                      state: (PetListStore.atomPetByName.value
                          as SuccessStateList),
                    )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Limpar'),
          onPressed: () {
            _textSearchController.clear();
            PetListStore.cleanView();
          },
          //tooltip: 'Increment',
          icon: const Icon(Icons.clear),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class ListPetsByName extends StatelessWidget {
  const ListPetsByName({
    super.key,
    required this.state,
  });

  final SuccessStateList state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            const Text(
              'Resultado por nome',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: state.value.length,
                itemBuilder: (_, index) {
                  final pet = state.value[index] as Pet;
                  return CardItem(
                    item: pet,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfPets extends StatelessWidget {
  const ListOfPets({
    super.key,
    required this.state,
  });

  final SuccessStateList state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //controller: scrollCont2,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.value.length,
      itemBuilder: (_, index) {
        final pet = state.value[index] as Pet;
        return CardItem(
          item: pet,
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Pet item;
  const CardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            stops: const [0.45, 0.95],
            colors: [
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.secondary,
              // Color.fromARGB(255, 246, 239, 247),
              // Color.fromARGB(255, 241, 202, 248),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              item.nome[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            '${item.nome} (Id: ${item.id}) ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.raca,
          ),
          trailing: InkWell(
            onTap: () => context.pushNamed(
              RoutesApp.petDetails.name,
              extra: PetMapper.fromEntityToJson(item),
            ),
            child: Icon(
              Icons.read_more,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
