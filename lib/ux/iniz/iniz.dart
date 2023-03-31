import 'package:trackrec_studio/ux/components/appbar/bottomAppBar.dart';
import 'package:flutter/material.dart';

class Iniz extends StatefulWidget {
  const Iniz({ Key? key }) : super(key: key);

   @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<Iniz> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('TrackRec-Studio',
          style: const TextStyle(
            fontWeight: FontWeight.w900, 
            fontSize: 30,
            fontStyle: FontStyle.normal,
            color: Colors.black
          ),
          ),
        ),
        bottomNavigationBar: BottomAppBar( 
          color: Colors.blue,
        child: Container(
          color: Colors.blue,
          height: 50,
          //padding: EdgeInsets.all(1),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalDivider(
                color: Colors.transparent,
              ),
              BottomNavigationMenu(
                label: 'HOME',
                isSelected: _selectedIndex == 0,
                icon: Icons.home, 
                onTap: () {
                  //_onItemTapped(0);
                  Navigator.pushNamed(context, '/iniz');
                },
              ),
              VerticalDivider(
                color: Colors.black,
              ),
              BottomNavigationMenu(
                label: 'CREATE',
                isSelected: _selectedIndex == 1,
                icon: Icons.record_voice_over,
                onTap: () {
                   Navigator.pushNamed(context, '/recordPanel');
                },
              ),
              VerticalDivider(
                color: Colors.black,
              ),
              BottomNavigationMenu(
                label: 'DONE',
                isSelected: _selectedIndex == 2,
                icon: Icons.fact_check_sharp,
                onTap: () {
                  Navigator.pushNamed(context, '/listrack');
                },
              ),
              VerticalDivider(
                color: Colors.transparent,
              ),
            ],
          ),
        )
      ),
      
        
          body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.indigo,
                Colors.purple,
                Colors.red,
                Colors.purple,
                Colors.indigo,
                Colors.blue
              ],
            )
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(), 
            child: IconButton(
              icon: Image.asset('assets/images/inizback.png'),
              onPressed: () {
                // fuction to make some animation?
              },
           ),
          ),
        ),
      )
    );
  }
}

