// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AnimatedFlightExample(),
//     );
//   }
// }
//
// class AnimatedFlightExample extends StatefulWidget {
//   @override
//   _AnimatedFlightExampleState createState() => _AnimatedFlightExampleState();
// }
//
// class _AnimatedFlightExampleState extends State<AnimatedFlightExample> {
//   bool _isFlying = false;
//
//   void _animateFlight() {
//     setState(() {
//       _isFlying = !_isFlying;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animated Container'),
//       ),
//       body: Stack(
//         children: [
//           // Flight Icon Animation
//           AnimatedAlign(
//             duration: const Duration(seconds: 2),
//             curve: Curves.fastOutSlowIn,
//             alignment: _isFlying ? Alignment.topCenter : Alignment.bottomCenter,
//             child: AnimatedOpacity(
//               duration: const Duration(milliseconds: 800),
//               opacity: _isFlying ? 0 : 1,
//               child: Icon(
//                 Icons.flight,
//                 color: Colors.blue,
//                 size: 50,
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _animateFlight,
//         child: const Icon(Icons.flight_takeoff),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AnimatedTextFieldScreen(),
//     );
//   }
// }
//
// class AnimatedTextFieldScreen extends StatefulWidget {
//   @override
//   _AnimatedTextFieldScreenState createState() => _AnimatedTextFieldScreenState();
// }
//
// class _AnimatedTextFieldScreenState extends State<AnimatedTextFieldScreen> {
//   bool _isTextVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animated Widgets'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedOpacity(
//               opacity: _isTextVisible ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 500),
//               child: Column(
//                 children: const [
//                   Text(
//                     'Alice',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Divider(
//                     height: 1,
//                     thickness: 2,
//                     color: Colors.blue,
//                     indent: 40,
//                     endIndent: 40,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _isTextVisible = !_isTextVisible;
//           });
//         },
//         child: const Icon(Icons.arrow_forward),
//         backgroundColor: Colors.red,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchLettersAndObjects(),
    );
  }
}

class MatchLettersAndObjects extends StatefulWidget {
  @override
  _MatchLettersAndObjectsState createState() => _MatchLettersAndObjectsState();
}

class _MatchLettersAndObjectsState extends State<MatchLettersAndObjects> {
  final Map<String, String> letterToImage = {
    "P": "https://i.pinimg.com/736x/5b/15/4c/5b154c4d1f4a73bfc77a8217cae3b1e4.jpg",
    "S": "https://i.pinimg.com/736x/1b/ae/69/1bae69e53b680730bc8fda5d1eff689f.jpg",
    "B": "https://w7.pngwing.com/pngs/255/160/png-transparent-tourist-bus-bus-cycling-tourism.png",
    "N": "https://w7.pngwing.com/pngs/233/574/png-transparent-open-notebook-paper-post-it-note-notebook-notebook-miscellaneous-angle-rectangle-thumbnail.png",
  };

  final Map<String, bool> matched = {
    "S": false,
    "N": false,
    "B": false,
    "P": false,
  };

  // Check if all items are matched
  void _checkForWin() {
    if (matched.values.every((isMatched) => isMatched)) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Congratulations!"),
              content: const Text("You matched all items correctly!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame(); // Restart the game
                  },
                  child: const Text("Play Again"),
                ),
              ],
            );
          },
        );
      });
    }
  }

  // Reset the game
  void _resetGame() {
    setState(() {
      matched.updateAll((key, value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Letters and Objects"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Column of images on the left
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: letterToImage.entries.map((entry) {
                  return Draggable<String>(
                    data: entry.key,
                    feedback: Material(
                      color: Colors.transparent,
                      child: Image.network(
                        entry.value,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Image.network(
                        entry.value,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    child: matched[entry.key] == true
                        ? SizedBox(
                      width: 80,
                      height: 80,
                    )
                        : Image.network(
                      entry.value,
                      width: 80,
                      height: 80,
                    ),
                  );
                }).toList(),
              ),
            ),

            // Column of letters on the right
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: letterToImage.keys.map((letter) {
                  return DragTarget<String>(
                    onAcceptWithDetails: (draggedLetter) {
                      if (draggedLetter == letter) {
                        setState(() {
                          matched[letter] = true;
                          _checkForWin(); // Check if the user has won
                        });
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: matched[letter] == true
                              ? Colors.green.shade200
                              : Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
