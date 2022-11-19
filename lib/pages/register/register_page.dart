import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/common_widgets/app_button.dart';
import 'package:social_app/common_widgets/custom_dialog.dart';
import 'package:social_app/common_widgets/my_sized_box.dart';
import 'package:social_app/common_widgets/my_text_filed.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/home/home_page.dart';
import 'package:social_app/providers/auth_provider.dart';
import 'package:social_app/providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register-page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  bool _isLoading = false;

  void registerButtonOnPressed(
    AuthProvider auth,
    UserProvider user,
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var currentUser = await auth.registerWithEmailAndPassword(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      UserModel userModel = UserModel(
        uId: currentUser.user!.uid,
        imagePath: 'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
        imageUrl: 'https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
        name: name,
        email: email,
        bio: 'bio..',
        phone: phone,
        //isDarkModeOn: false,
      );
      user.setCurrentUser(givenCurrentUser: userModel);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } catch (error) {
      var index = error.toString().indexOf(']') + 2;
      buildCustomDialog(
          context: context,
          title: 'An Error Occurred',
          subTitle: '${error.toString().substring(index)}');
    } finally {
      setState(() {
        _isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(KAppPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                MyHeightSizedBox(),
                MyTextFiled(
                  controller: nameController,
                  hintText: 'First and second name',
                  labelText: 'Full name',
                  prefixIcon: Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  hPadding: 0.0,
                ),
                MyTextFiled(
                  controller: emailController,
                  hintText: 'example@gmail.com',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_rounded),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hPadding: 0.0,
                ),
                MyTextFiled(
                  controller: phoneController,
                  hintText: '01#-###-###-##',
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone_android),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  hPadding: 0.0,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hintText: 'At least 8 characters',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password_rounded),
                  isPasswordTextFiled: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hPadding: 0.0,
                ),
                MyHeightSizedBox(),
                Consumer<UserProvider>(
                  builder: (context, user, child) => Consumer<AuthProvider>(
                    builder: (context, auth, child) => _isLoading == true
                        ? Center(child: CircularProgressIndicator())
                        : AppButton(
                            text: 'Register',
                            onPressed: () {
                              registerButtonOnPressed(
                                auth,
                                user,
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text,
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class RegisterPage extends StatefulWidget {
//   static const routeName ='/register-page';
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//
//   List<Step> steps =[
//     Step(title: Text('step1'), content: Text('step1')),
//     Step(title: Text('step2'), content: Text('step2')),
//     Step(title: Text('step3'), content: Text('step3')),
//   ];
//
//   int currentStep = 0;
//   bool complete = false;
//
//   void nextStep(){
//     if(currentStep+1 != steps.length){
//       goTo(currentStep+1);
//     }else{
//       setState(() {
//         complete = true;
//       });
//     }
//   }
//   void goTo(int step){
//     setState(() {
//       currentStep = step;
//     });
//   }
//
//   void cancel(){
//     if(currentStep > 0){
//       goTo(currentStep-1);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stepper(
//           //type: StepperType.horizontal,
//           steps: steps,
//           currentStep: currentStep,
//           onStepContinue: nextStep,
//           onStepCancel: cancel,
//           onStepTapped: (step){
//             goTo(step);
//           },
//         ),
//       ),
//     );
//   }
// }
