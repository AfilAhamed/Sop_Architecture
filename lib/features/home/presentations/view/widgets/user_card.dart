import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/features/home/data/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 1.5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1,
        color: Colors.white,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: Image.network(
              user.image,
              fit: BoxFit.cover,
            ).image,
          ),
          title: Text(
            user.name,
            style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.007,
              ),
              Text(
                'Age: ${user.age}',
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
