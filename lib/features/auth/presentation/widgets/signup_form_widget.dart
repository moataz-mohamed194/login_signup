import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../ domain/entities/login.dart';
import '../../ domain/validation/validator.dart';
import '../../../../core/widgets/ButtonWidget.dart';
import '../../../../core/widgets/TextFormFieldWidgets.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../eyesBloc/CheckerCubit.dart';

class SignUpFormWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidgets(
            hintText: 'Name',
            keyboardType: TextInputType.text,
            controler: _nameController,
            validatorTextField: (val) => Validator().validatorName(val),
          ),
          TextFormFieldWidgets(
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controler: _emailController,
            validatorTextField: (val) => Validator().validatorEmail(val),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: IntlPhoneField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black26, width: 0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black26, width: 0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _phoneNumberController.clear();
                    },
                  ),
                ),
                initialCountryCode: 'SA',
                disableLengthCheck: true,
                validator: (val) =>
                    Validator().validatorPhoneNumber(val!.number.toString(), val.countryCode.toString()),
                controller: _phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction),
          ),
          BlocBuilder<CheckerCubit, bool>(
            builder: (context, state) {
              return TextFormFieldWidgets(
                hintText: 'password',
                keyboardType: TextInputType.text,
                rightWidget: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    context.read<CheckerCubit>().changeCheck();
                  },
                ),
                obscureText: state,
                controler: _passwordController,
                validatorTextField: (val) => Validator().validatorPassword(val),
              );
            },
          ),
          ButtonWidget(
              text: 'Sign Up',
              action: () {
                validateFormThenUpdateOrAddPost(context);
              })
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final login = Login(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
          name: _nameController.text.toString(),
          phoneNumber: _phoneNumberController.text.toString());
      print(login);
      BlocProvider.of<LoginBloc>(context).add(AddUserEvent(login: login));
    }
  }
}
