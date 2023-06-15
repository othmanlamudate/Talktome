import 'package:flutter/material.dart';

class FloatingImageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: constraints.maxWidth *0.5 , // Adjust the image height as desired
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: constraints.maxWidth , // Adjust the image size as desired
                        height: constraints.maxWidth ,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Free '),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('189\$'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Subtitle',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Description',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
