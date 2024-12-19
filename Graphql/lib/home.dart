import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String query = """
    query {
      products {
        items {
          id
          name
          description
          assets {
            source
          }
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade300,
          title: Text(
            ' Products',
            style: TextStyle(fontSize: 23, color: Colors.black),
          )),
      body: Query(
        options: QueryOptions(document: gql(query)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: result.data!['products']['items'].length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          result.data!['products']['items'][index]
                              ['id'.toString()],
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 150,
                          child: Image.network(result.data!['products']['items']
                              [index]['assets'][0]['source']),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      result.data!['products']['items'][index]['name']
                          .toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      result.data!['products']['items'][index]['description']
                          .toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
