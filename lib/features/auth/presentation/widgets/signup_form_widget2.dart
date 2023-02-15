import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/login.dart';
import '../../ domain/validation/validator.dart';
import '../../../../core/widgets/ButtonWidget.dart';
import '../../../../core/widgets/TextFormFieldWidgets.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../eyesBloc/CheckerCubit.dart';

class SignUpFormWidget2 extends StatelessWidget {
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
          TextFormFieldWidgets(
            hintText: 'Phone number',
            keyboardType: TextInputType.phone,
            controler: _phoneNumberController,
            rightWidget: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _phoneNumberController.clear();
            },
          ),
            validatorTextField: (val) => Validator().validatorPhoneNumber(val,'+966'),
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
    if (isValid ) {
      final login = Login(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
          name: _nameController.text.toString(),
          phoneNumber: _phoneNumberController.text.toString());
      BlocProvider.of<LoginBloc>(context).add(AddUserEvent(login: login));
    }
  }
}
