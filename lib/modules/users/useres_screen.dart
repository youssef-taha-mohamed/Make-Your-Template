import 'package:e_you/models/user/user_model.dart';
import 'package:flutter/material.dart';



class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);

  List<UserModel> user=[
    UserModel(
        id: 1,
        name: "Youssef Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 2,
        name: "Mohammed Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 3,
        name: "AbdElrahmen Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 4,
        name: "Osame Youssef Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 5,
        name: "Wisem Mohammed Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 6,
        name: "Atef AbdElrahmen Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 7,
        name: "Esraa Youssef Tah",
        phone: "01155117828"
    ),
    UserModel(
        id: 8,
        name: "Noor Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 9,
        name: "Amir Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 10,
        name: "Omer Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 11,
        name: "Ahmed Taha",
        phone: "01155117828"
    ),
    UserModel(
        id: 13,
        name: "Ali Taha",
        phone: "01155117828"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(user[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          itemCount: user.length
      ),
    );
  }

  Widget buildUserItem(UserModel userModel ) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            "${userModel.id}",
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userModel.name,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userModel.phone,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
