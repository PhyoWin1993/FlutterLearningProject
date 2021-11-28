// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'dart:convert';

import 'package:bincard/model/json_parsing_map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class JsonparsingSample extends StatefulWidget {
//   const JsonparsingSample({Key? key}) : super(key: key);

//   @override
//   _JsonparsingSampleState createState() => _JsonparsingSampleState();
// }

// class _JsonparsingSampleState extends State<JsonparsingSample> {
//   late Future data;
//   @override
//   void initState() {
//     super.initState();
//     data = Network(url: "https://jsonplaceholder.typicode.com/posts").getData();
//     data.then((value) => debugPrint(value[0]['title']));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Json Parsing"),
//         backgroundColor: Colors.orange,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(
//           child: FutureBuilder(
//             future: data,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 // return Text(snapshot.data[1]['title'].toString());
//                 return createListView(context, snapshot.data);
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget createListView(BuildContext context, List datas) {
//     return Container(
//         child: ListView.builder(
//       itemCount: datas.length,
//       itemBuilder: (context, int index) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Divider(
//               height: 5.0,
//             ),
//             ListTile(
//                 title: Text(datas[index]['title'].toString()),
//                 subtitle: Text(datas[index]['body'].toString()),
//                 leading: Column(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.black26,
//                       radius: 23,
//                       child: Text(datas[index]['userId'].toString()),
//                     )
//                   ],
//                 ))
//           ],
//         );
//       },
//     ));
//   }
// }

class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({Key? key}) : super(key: key);

  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  late Future<PostList> datas;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    datas = Network("https://jsonplaceholder.typicode.com/posts").loadPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Parsing Map"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: datas,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              List<Post> allPost;
              if (snapshot.hasData) {
                allPost = snapshot.data!.posts;
                return createListView(context, allPost);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, List<Post> data) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                const Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text(data[index].title),
                  subtitle: Text(data[index].body),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amberAccent,
                        radius: 23,
                        child: Text(data[index].id.toString()),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);
  Future<PostList> loadPost() async {
    final respone = await http.get(Uri.parse(url));
    if (respone.statusCode == 200) {
      debugPrint("Connection is ok");
      return PostList.fromJson(json.decode(respone.body));
    } else {
      throw Exception("Could not connected.");
    }
  }
}
