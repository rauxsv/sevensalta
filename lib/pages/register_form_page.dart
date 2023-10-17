import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sevensalta/generated/locale_keys.g.dart';
import '../model/user.dart';
import 'user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isPasswordVisible = false;
  final List<String> _countries = [
    LocaleKeys.russia.tr(),
    LocaleKeys.ukraine.tr(),
    LocaleKeys.germany.tr(),
    LocaleKeys.france.tr()
  ];
  String _selectedCountry = LocaleKeys.russia.tr();
  final User _newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.register_form.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: _buildFormFields(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildNameField(),
      const SizedBox(height: 10),
      _buildPhoneField(),
      const SizedBox(height: 10),
      _buildEmailField(),
      const SizedBox(height: 10),
      _buildCountryDropdown(),
      const SizedBox(height: 20),
      _buildStoryField(),
      const SizedBox(height: 10),
      _buildPasswordField(),
      const SizedBox(height: 10),
      _buildConfirmPasswordField(),
      const SizedBox(height: 15),
      _buildSubmitButton(),
      _buildLocaleButtons()
    ];
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: LocaleKeys.full_name.tr(),
        hintText: LocaleKeys.what_do_people_call_you.tr(),
        prefixIcon: const Icon(Icons.person_outline),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => _nameController.clear(),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: _validateName,
      onSaved: (value) => _newUser.name = value ?? '',
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: LocaleKeys.phone_number.tr(),
        hintText: LocaleKeys.where_can_we_reach_you.tr(),
        prefixIcon: const Icon(Icons.phone),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: _validatePhoneNumber,
      onSaved: (value) => _newUser.phone = value ?? '',
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: LocaleKeys.email_address.tr(),
        hintText: LocaleKeys.enter_email_address.tr(),
        prefixIcon: const Icon(Icons.email_outlined),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
      onSaved: (value) => _newUser.email = value ?? '',
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.country.tr(),
        prefixIcon: const Icon(Icons.map_outlined),
        border: const OutlineInputBorder(),
      ),
      items: _countries.map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCountry = value as String;
        });
      },
      value: _selectedCountry,
      onSaved: (value) => _newUser.country = value ?? '',
    );
  }

  Widget _buildStoryField() {
    return TextFormField(
      controller: _storyController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: LocaleKeys.life_story.tr(),
        hintText: LocaleKeys.tell_us_about_yourself.tr(),
        border: const OutlineInputBorder(),
      ),
      onSaved: (value) => _newUser.story = value ?? '',
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: LocaleKeys.password.tr(),
        hintText: LocaleKeys.enter_password.tr(),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: const OutlineInputBorder(),
      ),
      validator: _validatePassword,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPassController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: LocaleKeys.confirm_password.tr(),
        hintText: LocaleKeys.confirm_password_hint.tr(),
        prefixIcon: const Icon(Icons.lock_outline),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value != _passController.text) {
          return LocaleKeys.password_mismatch.tr();
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      child: Text(LocaleKeys.hello.tr()),
    );
  }

  Widget _buildLocaleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () async {
            await context.setLocale(const Locale('ru'));
          },
          child: const Text('RU'),
        ),
        ElevatedButton(
          onPressed: () async {
            await context.setLocale(const Locale('kk'));
          },
          child: const Text('KZ'),
        ),
        ElevatedButton(
          onPressed: () async {
            await context.setLocale(const Locale('en'));
          },
          child: const Text('EN'),
        ),
      ],
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.name_required.tr();
    } else if (!RegExp(r'^[A-Za-zА-Яа-яЁё ]+$').hasMatch(value)) {
      return LocaleKeys.enter_alphabetical_characters.tr();
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || !RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$').hasMatch(value)) {
      return LocaleKeys.phone_number_format_hint.tr();
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return LocaleKeys.invalid_email.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length != 8) {
      return LocaleKeys.eight_character_required.tr();
    }
    return null;
  }

 void _submitForm() {
    if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        
        // Создаем нового пользователя для передачи на следующую страницу
        User newUser = User(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            country: _selectedCountry, // Убедитесь, что у вас есть такая переменная или адаптируйте этот код
            story: _storyController.text
        );

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserInfoPage(userInfo: newUser)),
        );
    } else {
        // Вместо _showMessage вы можете использовать Flutter Toast или Snackbar для отображения сообщений
        print(LocaleKeys.form_not_valid.tr());
    }
}



  void _showRegistrationDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.registration_successful.tr()),
          content: Text('$name ${LocaleKeys.verified_register_form.tr()}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(userInfo: _newUser),
                  ),
                );
              },
              child: Text(LocaleKeys.verified.tr()),
            ),
          ],
        );
      },
    );
  }
}
