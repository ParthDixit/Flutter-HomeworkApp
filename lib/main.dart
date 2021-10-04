// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert' ;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:loading_animations/loading_animations.dart';


Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/database.json');
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      color: Colors.white,
      //title: 'Welcome to Flutter',
      home: DataPage()
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool btnState = false;
  Color btnClr = Colors.grey;
  Color? uiColor = Colors.purple[900];
  final saved = <String>{};
  late String database ;
  bool isFetched = true;
  late List<dynamic> standards ;

  @override
  void initState() {
    super.initState();

    loadAsset().then((data) {
      setState(() {
        database = data;
        isFetched = false;
      });
    });
  }

  void _reset(BuildContext ctx) {

    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (BuildContext context) => super.widget));
  }


  void _pushedSaved() {
    Navigator.of(context).push(
      CupertinoPageRoute <void>(
        builder: (BuildContext context) {

          final tiles = saved.map(
                  (String txt) {
                    return

                         Padding(
                             padding: const EdgeInsets.all(6),
                              child:Container(
                                //color: Colors.white10,
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child:
                                  Row(
                                  children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.all(6), //top: 5.0, left: 8
                                      child:
                                  Container(
                                    //color: Colors.deepPurple,
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.all(3.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                    color: uiColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(7.0))),

                                      child:
                                      Align(
                                        alignment: Alignment.center,
                                        child:Text(
                                          txt.split(",").first,
                                          style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13
                                              ),

                                              ),
                                          )
                                      )
                                    ),

                                    Text(
                                    txt.split(",").last,
                                    style: TextStyle(
                                        color: uiColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                            ),
                                              ),

                                    const Padding(padding: EdgeInsets.only(bottom: 75))
                                  ]
                      )
                    // )
                    )
                         );

                  },
                );
                final divided = tiles.isNotEmpty
                    ? tiles.toList()//ListTile.divideTiles(tiles: tiles, context: context).toList()
                    : <Widget>[];

                return Scaffold(
                    backgroundColor: Colors.white,
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: SizedBox(
                        height: 68,
                        width: MediaQuery.of(context).size.width - 20,
                        child: SizedBox(
                            child: FloatingActionButton.extended(

                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(10.0))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              elevation: 20,
                              label: const Text('Thank You'),

                              backgroundColor: btnClr,

                            )
                        )
                    ),

                    body: CustomScrollView( // ListView.builder(
                      //shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        //itemBuilder: (BuildContext context, int index){
                          slivers: <Widget>[
                           SliverAppBar(
                            //title: Text('Sliver App Bar'),
                            leading: IconButton(onPressed: () { Navigator.pop(context);},
                                        icon: Icon(Icons.arrow_back_ios_new,  color: uiColor)),
                             expandedHeight: 40.0,
                            backgroundColor: Colors.white,
                          ),

                          SliverToBoxAdapter(
                              child: Column(
                                // width: 100,
                                // height: 40,
                                  children:
                                   <Widget>[
                                     ListTile(title: Text(
                                      'Teacher Profile', style: TextStyle(
                                        color: uiColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                    ),
                                      subtitle: Text(
                                        'You teach these \n class & subjects',
                                        style: TextStyle(
                                            color: uiColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23
                                        ),
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(4)),

                                      SizedBox(

                                          child:Column(
                                          children:divided
                                      )
                                      )
                                  ]
                                 )
                                ),
                            const SliverPadding(padding: EdgeInsets.only(bottom: 78))
                        ]
                    )
                );
                //
              }
      ),
    );
  }

  @override
  Widget build(BuildContext context)  {

    if(isFetched)
    {
      //print('waiting');
      return
        Container(

          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
             Align(
              alignment: Alignment.center,
              child: Icon(Icons.favorite,color: uiColor,size: 40),
            )
      //       LoadingBouncingGrid.square(   //LoadingFlipping.circle(
      //       borderColor: Colors.deepPurple,
      //       borderSize: 3.0,
      //       size: 30.0,
      //       backgroundColor: Colors.white,
      //       //duration: const Duration(milliseconds: 500),
      //     // )
       )
      ;
    }

    //print(str);
    Map<String, dynamic> classSub = jsonDecode(database);
    //print(classSub);
    standards = classSub['classes'];


    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: 68,
           width: MediaQuery.of(context).size.width-20,
           child: SizedBox(
                child:FloatingActionButton.extended(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: (){
                  if(btnState) {
                    _pushedSaved();
                  }
                }, elevation: 20,
                label: const Text('Continue'),

                backgroundColor:btnClr,

            )
           )
       ),
       body:CustomScrollView( // ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //itemBuilder: (BuildContext context, int index){
           slivers: <Widget>[
                     SliverAppBar(
                          //title: Text('Sliver App Bar'),
                          leading: //BackButton( color: Colors.deepPurple,),
                          IconButton( onPressed: btnState ? (){_reset(context);}: null,
                              disabledColor: Colors.white,
                              icon: const Icon(Icons.arrow_back_ios_new ),
                              ),
                              iconTheme: IconThemeData(
                              color: uiColor
                              ),
                          expandedHeight: 40.0,
                              actions:  <Widget>[Icon(Icons.circle,size: 11, color: btnState ? Colors.grey:uiColor),
                                const Padding(padding: EdgeInsets.all(5)),
                                Icon(Icons.circle,size: 11, color: btnState ? uiColor:Colors.grey),
                                const Padding(padding: EdgeInsets.only(right: 20)
                                )
                              ],
                          backgroundColor: Colors.white,
                  ),

            SliverToBoxAdapter(
                child: Column(
              // width: 100,
              // height: 40,
                  children:
                   <Widget>[
                   ListTile(title: Text('Teacher Profile', style: TextStyle(
                        color: uiColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                      ),
                     subtitle: Text('Which grade & \n subjects you teach', style: TextStyle(
                          color: uiColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23
                          ),
                          ),
                   ),
                 const Padding(padding: EdgeInsets.all(4))
                ]
            )),
       // itemBuilder: (BuildContext context, int index){
            SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {

           return
             Padding(
                 padding: const EdgeInsets.all(8),
                  child:Container(
               //color: Colors.blue,
                      decoration: BoxDecoration(
                      color: Colors.lime[50],
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      height: 340,
                      width: MediaQuery.of(context).size.width,
                  child:
                   Column(
                   children: <Widget>[
                      Row(
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        //   child:
                                Container(
                                  //color: Colors.deepPurple,
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        color: uiColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(7.0))),
                                  //decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))), color: Colors.deepPurple),
                                  //BoxDecoration(border: Border.all()
                                  //
                                  child:
                                  Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                      standards[index]['standard'],
                                      //classes[index],
                                      style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13
                                        ),

                                    ),
                                )
                                )
                        //)

                      ],
                      ),
                    Expanded(
                              child: _colBuilder(index),

                    ),

              ]
              )
             ));
            }, childCount:standards.length )),//classes.length
             const SliverPadding(padding: EdgeInsets.only(bottom: 75)),

          ],

          // padding: const EdgeInsets.only(bottom: 75,top: 20), //itemCount: classes.length,
          //separatorBuilder: (BuildContext context, int index, ) => const Divider(),
       ),
    );
  }

  Widget _colBuilder(int colIdx){

    return
              ListView.separated(
             // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){

                  return SizedBox(
                      //height: 320,
                      width: 220,
                      child: _rowBuilder(colIdx,index)
                  );

              },
            //padding: const EdgeInsets.all(2),
                itemCount: standards[colIdx]['subjects'].length, //subjects.length,
            separatorBuilder: (BuildContext context, int index) =>  const Divider(),

        );

  }

  Widget _rowBuilder(int colIdx,int rowIdx) {
    //String str = classes[col_idx]+" "+subjects[row_idx];

    String str = standards[colIdx]['standard'] +","+ standards[colIdx]['subjects'][rowIdx]['subject_name'];
    bool alreadySaved = saved.contains(str);


    // return Padding(
    //   padding:EdgeInsets.all(8) ,
    //   child:
      return
      Align(
       // height: 250,
        alignment: Alignment.center,
        child:
          Card(
              semanticContainer: true,
              elevation: 12,
              color: Colors.deepOrange[50],
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: InkWell(
                  onTap: ()
                    {setState(() {
                      if(alreadySaved){
                        saved.remove(str);
                      }
                      else{
                        saved.add(str);
                      }

                      if(saved.isEmpty) {
                        btnState = false;
                        btnClr = Colors.grey;
                      }
                      else {
                        btnState = true;
                        btnClr = uiColor!;
                      }
                  }
                  );
                    },
                child:
              Column(
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[

                    // Container(color: Colors.pink,
                    //   height: 200,
                    //   width: 190,
                    //   child:
                    FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png', // Before image load '
                    image: standards[colIdx]['subjects'][rowIdx]['subject_image'], // After image load
                    height: 200,
                    imageErrorBuilder: (context, url, error) => Image.asset('assets/placeholder.png'),
                   // )
                         //width: 300,
                  ),
                //Image.network(standards[col_idx]['subjects'][row_idx]['subject_image'],cacheHeight: 180,),//images[row_idx]

                CheckboxListTile(
                  title: Text(standards[colIdx]['subjects'][rowIdx]['subject_name'], textAlign: TextAlign.justify,),//subjects[row_idx]
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.only(left:7),
                  value: saved.contains(str),//isChecked,
                  tileColor: Colors.white,
                  checkColor: Colors.white,
                  activeColor: uiColor,
                  shape: const RoundedRectangleBorder(borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                  onChanged: (bool? value)
                    {
                    setState(() {
                      //isChecked = value!;
                      if(alreadySaved){
                        saved.remove(str);
                      }
                      else{
                        saved.add(str);
                      }
                      if(saved.isEmpty) {
                        btnState = false;
                        btnClr = Colors.grey;
                      }
                      else {
                        btnState = true;
                        btnClr = uiColor!;
                      }
                       });
                    },
                ),
            ],
          )
              )
           )
          );
  }

}
