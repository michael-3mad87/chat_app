import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:chat_app/rooms/view/widgets/category_drop_down_button.dart';
import 'package:chat_app/rooms/view_model/cubit/room_cubit.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/custom_button.dart';
import 'package:chat_app/shared/ui_utils.dart';
import 'package:chat_app/shared/show_message.dart';
import 'package:chat_app/shared/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/createRoom';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedCategoryId;
  final _formKey = GlobalKey<FormState>();
  final roomCubit = RoomCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => roomCubit,
      child: Scaffold(
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
                    height: MediaQuery.of(context).size.height * .7,
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
                            controller: nameController,
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
                            onCategorySelected: (categoryId) =>
                                selectedCategoryId = categoryId,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: descriptionController,
                            hintText: 'Enter Room Description',
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return "Room Description can't be Less than 5 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 36),
                          BlocListener<RoomCubit, RoomState>(
                            listener: (context, state) {
                              if (state is CreateRoomLoading) {
                                UIUtils.show(context);
                              } else if (state is CreateRoomSuccess) {
                                UIUtils.hide(context);
                                showToastMessage('Room Created Successfully');
                                Navigator.pop(context , true);
                              } else if (state is CreateRoomError) {
                                UIUtils.hide(context);
                                showToastMessage(state.message);
                              }
                            },
                            child: CustomButton(
                              label: 'Create',
                              oppressed: createRoom,
                              width: MediaQuery.of(context).size.height * .27,
                            ),
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
      ),
    );
  }

  void createRoom() {
    if (_formKey.currentState!.validate() == true) {
      roomCubit.createRooms(
        RoomModel(
          name: nameController.text,
          description: descriptionController.text,
          categoryId: selectedCategoryId!,
        ),
      );
    }
  }
}
