import 'package:flutter/material.dart';

var myAppBar = AppBar(
  toolbarHeight: 44,
  backgroundColor: Colors.white54,
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search, size: 30, color: Colors.black),
    ),
  ],
);

var myBag = const Padding(
  padding: EdgeInsets.all(10),
  child: Text(
    "My Bag",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
  ),
);
