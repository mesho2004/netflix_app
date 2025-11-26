import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customProfile(
                  image: "assets/Rectangle 2.png",
                  name: "mesho",
                ),
                SizedBox(
                  width: 8,
                ),
                customProfile(
                  image: "assets/Rectangle 3.png",
                  name: "ibrahim",
                ),
                SizedBox(
                  width: 8,
                ),
                customProfile(
                  image: "assets/Rectangle 4.png",
                  name: "yousry",
                ),
                SizedBox(
                  width: 8,
                ),
                customProfile(
                  image: "assets/Rectangle 5.png",
                  name: "kids",
                ),
                SizedBox(
                  width: 8,
                ),
                customProfile(
                  image: "assets/Rectangle 5.png",
                  name: "Add",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                "Manage Profiles",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            color: const Color.fromARGB(255, 50, 49, 49),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text("Tell friend about netflix",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("terms & conditions",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Copy Link"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/Group 93.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                onPressed: () {},
              ),
              // VerticalDivider(color: Colors.white,width: 15,thickness: 50,),
              IconButton(
                icon: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/Group 92.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                onPressed: () {},
              ),

              // VerticalDivider(color: Colors.grey),
              IconButton(
                icon: SizedBox(
                  width: 65,
                  height: 65,
                  child: Image(
                    image: AssetImage("assets/Group 94.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                onPressed: () {},
              ),

              // VerticalDivider(color: Colors.grey),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                  Text(
                    'More',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Text("My list",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text("App settings",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              TextButton(
                  onPressed: () {},
                  child: Text("Account",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              TextButton(
                  onPressed: () {},
                  child: Text("Help",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              TextButton(
                  onPressed: () {},
                  child: Text("Sign out",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ],
          ),
        ]),
      ),
    ));
  }
}

class customProfile extends StatelessWidget {
  const customProfile({
    super.key,
    required this.image,
    required this.name,
  });
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(onTap: () {}, child: Image.asset(image)),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
