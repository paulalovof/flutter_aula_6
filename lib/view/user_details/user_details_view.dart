//import 'package:asp/asp.dart';
import '../../presentarion/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_5/domain/entity/user.dart';
import 'package:go_router/go_router.dart';

import '../../components/input_text_field.dart';
import '../../core/errors/errors_classes.dart';
import '../../core/errors/errors_messagens.dart';
import '../../core/masks/input_mask.dart';
import '../../core/masks/unit_metric_mask.dart';
import '../../core/routes/routes.dart';
import '../../core/validators/date_validator.dart';
import '../../core/validators/max_double_str_validator.dart';
import '../../core/validators/max_lenght_str_validator%20copy.dart';
import '../../core/validators/min_double_str_validator.dart';
import '../../core/validators/min_lenght_str_validator.dart';
import '../../core/validators/text_field_validator.dart';
import '../../domain/entity/user.dart';
import '../../presentarion/user_detail/atom/user_detail_atom.dart';

class UserDetailsView extends StatefulWidget {
  final User user;

  const UserDetailsView({super.key, required this.user});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/4/43/Cute_dog.jpg';
  late bool initView;
  final _formKey = GlobalKey<FormState>();
  final _userNameFieldKey = GlobalKey<FormFieldState>();
  final _userNameFieldFocusNode = FocusNode();
  final _userNameController = TextEditingController();

  final _userDtNascController = TextEditingController();
  final _userDtNascFieldKey = GlobalKey<FormFieldState>();
  final _userDtNascFieldFocusNode = FocusNode();

  final _userPesoController = TextEditingController();
  final _userPesoFieldKey = GlobalKey<FormFieldState>();
  final _userPesoFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _userNameFieldFocusNode.dispose();
    _userDtNascController.dispose();
    _userDtNascFieldFocusNode.dispose();
    _userPesoController.dispose();
    _userPesoFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initView = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => [
        UserDetailStore.userEditingAtom,
        UserDetailStore.userLoadingAtom,
        UserDetailStore.userByIdAtom,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.nome),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                cardPetDetail(context),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Habilitar Edição',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: UserDetailStore.userEditingAtom.value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Switch(
                      value: initView
                          ? false
                          : UserDetailStore.toggleUserEditingAction.value!,
                      onChanged: (value) {
                        UserDetailStore.toggleUserEditingAction.value = value;
                        initView = false;
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    UserDetailStore.fetchUserById.setValue(widget.user.id);
                    if (_formKey.currentState!.validate()) {
                      context.goNamed(RoutesApp.home.name);
                    }
                  },
                  child: !UserDetailStore.userLoadingAtom.value
                      ? UserDetailStore.userEditingAtom.value
                          ? const Text('habilitado')
                          : const Text('Desabilitado')
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                ),
                if (UserDetailStore.userEditingAtom.value && !initView)
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 5, left: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.inversePrimary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.inversePrimary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    )),
                    //color: Theme.of(context).colorScheme.secondary,
                    child: Column(
                      children: <Widget>[
                        InputTextField(
                          textEditingController: _userNameController,
                          label: 'Nome do Usuario',
                          icon: Icons.users,
                          focusNode: _userNameFieldFocusNode,
                          globalKey: _userNameFieldKey,
                          onFieldSubmitted: (value) {
                            if (!_userNameFieldKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .requestFocus(_userNameFieldFocusNode);
                            } else {
                              _userNameFieldFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_userDtNascFieldFocusNode);
                            }
                          },
                          onValidator: (value) {
                            try {
                              var isValid = TextFieldValidator(validators: [
                                MinLengthStrValidator(),
                                MaxLengthStrValidator(),
                              ]).validations(value);

                              if (!isValid) {
                                return MessagesError.defaultError;
                              }
                              return null;
                            } on Failure catch (e) {
                              return e.msg;
                            } catch (e) {
                              return e.toString();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardUserDetail(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.20, 0.7],
              colors: [
                //Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 0,
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.nome,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Identificação (Id): ${widget.user.id}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
