import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../class_objs/commentController.dart';
import 'home.dart';



class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
    final Comment_Controller commentController = Get.put(Comment_Controller());
  List<String> comments = []; 
ScrollController scrollController = ScrollController(); 
Map<String, List<String>> commentsMap = {};

TextEditingController commenttController = TextEditingController(); 
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('posts');
      bool like=false;

  late Stream<QuerySnapshot> _stream;
  List<Map> items = [];


  @override
  void initState() {
    super.initState();
    _stream = _reference.snapshots();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 197, 145),

      appBar: AppBar(
        title: Text('POSTS',style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),),
                                leading:IconButton(onPressed:(){Get.to(Post());}, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)) ,

    elevation: 0,
    backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
        child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Check error
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            //Check if data arrived
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //Convert the documents to Maps
              items = documents.map((e) => e.data() as Map).toList();

              // Check for deleted images
// Check for deleted images
// Check for deleted images
for (var i = 0; i < items.length; i++) {
  var item = items[i];
  if (item.containsKey('image')) {
    String imageUrl = item['image'];
    FirebaseStorage.instance.refFromURL(imageUrl).getDownloadURL().then((value) {
      // Image is still valid
    }).catchError((error) {
      // Image is not valid, remove it from the list
      items.removeAt(i);
      setState(() {});
    });
  }
}





              return SingleChildScrollView(
  child: Column(
    children: items.map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 4.w),
        child: Column(
          children: [
           
SizedBox(height: 3.h,),
  Container(
          height: 45.h, // Adjust the height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              
              Text(
                '${item['name']}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.5.sp,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.brown,
                    width: 0.25.w,
                  ),
                ),
                width: 90.w,
                height: 30.h,
                child: item.containsKey('image')
                    ? Image.network(
                        '${item['image']}',
                        height: 30.h,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              SizedBox(height: 1.5.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Caption: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${item['caption']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                
             IconButton(
onPressed: () {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      // Get the image URL or ID associated with the comment section
      String imageUrlOrId = item['image'];

      return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: commenttController,
                decoration: InputDecoration(
                  hintText: 'Enter your comment',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Add the comment using CommentController
                    commentController.addComment(imageUrlOrId, commenttController.text);
                    commenttController.clear();
                  });
                  // Scroll to the bottom of the list
                  scrollController.jumpTo(scrollController.position.maxScrollExtent);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(217, 150, 81, 1)),
                ),
                child: Text('Post Comment'),
              ),
              SizedBox(height: 16.0),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: commentController.commentsMap.containsKey(imageUrlOrId)
                      ? commentController.commentsMap[imageUrlOrId]!.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(commentController.commentsMap[imageUrlOrId]![index]),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      );
    },
  );
},

  icon: Image.asset('assets/c.png'),
),

                  ],
                ),
             
            ],
          ),
        ),

          ],
        ),
        
      
      );
    }).toList(),
  ),
);

            }

            //Show loader
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
     
    );
  }
}
