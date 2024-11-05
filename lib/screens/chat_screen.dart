import 'package:chat_app/models/massage_model.dart';
import 'package:chat_app/widgets/app_Text_form_field.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static String id = 'ChatScreen';
  CollectionReference massages =
      FirebaseFirestore.instance.collection('massages');
  TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: massages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MassageModel> massagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massagesList.add(MassageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xff2B475E),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      ' Chat',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => massagesList[index].id ==
                              email
                          ? ChatBubble(
                              massage: massagesList[index],
                            )
                          : ChatBubbleForFriend(massage: massagesList[index]),
                      itemCount: massagesList.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AppTextFormField(
                      onSubmit: (value) {
                        massages.add({
                          'massage': value,
                          'createdAt': DateTime.now(),
                          'id': email
                        });
                        inputController.clear();
                        scrollController.animateTo(
                          0.0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      controller: inputController,
                      inputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.text_fields_outlined),
                      hintText: 'Enter massage',
                      borderColor: const Color(0xff2B475E),
                      hintTextColor: Colors.grey,
                      borderRadius: 50,
                      prefixIconColor: Colors.grey,
                      inputColor: Colors.black,
                      focusBorderColor: Colors.grey,
                      suffixIcon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Loading...');
          }
        });
  }
}
