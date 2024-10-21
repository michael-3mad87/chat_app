import 'package:chat_app/rooms/view/widgets/category_drop_down_button.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/custom_button.dart';
import 'package:chat_app/shared/text_form_field.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/createRoom';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  String? selectedCategory;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( 
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Create New Room',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/room.png',
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: controllerName,
                          hintText: 'Enter Room Name',
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "Room Name can't be less than 3 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CategoryDropDownButton(
                          onCategorySelected: (category) => selectedCategory = category,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: controllerDescription,
                          hintText: 'Enter Room Description',
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return "Room Description can't be Less than 5 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 36),
                        CustomButton(
                          label: 'Create',
                          oppressed: createRoom,
                          width: MediaQuery.of(context).size.height * .27,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createRoom() {
    if (_formKey.currentState!.validate() == true) {
    }
  }
}
