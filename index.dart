import 'dart:convert' as convert;
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

// void main() {
//   print("hello  world");
//   var a = 1;
//   print("a=" + a.toString());

//   int myNum = 2;

//   String myString = "Hello";
//   print(myString + " world");

//   // var list = <String>[1, 2, 3, "23"];
//   List.filled(2, "");
// }

// import 'dart:convert' as convert;

// import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
    'q': '{http}',
  });

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
