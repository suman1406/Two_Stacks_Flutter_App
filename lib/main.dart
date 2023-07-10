import 'package:flutter/material.dart';

class TwoStacksScreen extends StatefulWidget {
  const TwoStacksScreen({Key? key}) : super(key: key);

  @override
  _TwoStacksScreenState createState() => _TwoStacksScreenState();
}

void main() {
  runApp(const MaterialApp(
    home: TwoStacksScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class _TwoStacksScreenState extends State<TwoStacksScreen> {
  late List<int> stackArray1;
  late List<int> stackArray2;
  late int top1;
  late int top2;
  late TextEditingController inputController;
  late int topElement1;
  late int topElement2;

  @override
  void initState() {
    super.initState();
    stackArray1 =
        List<int>.filled(10, 0); // Initialize with size 10, filled with 0
    stackArray2 =
        List<int>.filled(10, 0); // Initialize with size 10, filled with 0
    top1 = -1;
    top2 = -1;
    inputController = TextEditingController();
    topElement1 = -1;
    topElement2 = -1;
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void updateTopElements() {
    setState(() {
      topElement1 = top1 >= 0 ? stackArray1[top1] : -1;
      topElement2 = top2 >= 0 ? stackArray2[top2] : -1;
    });
  }

  void updateUI() {
    setState(() {
      // Update the UI after popping from the stack
      // You can perform any necessary UI updates here
    });
  }

  void pushToStack1(int value) {
    setState(() {
      if (top1 == stackArray1.length - 1) {
        // Stack is full
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Stack is Full'),
              content: const Text('Cannot push to Stack 1. Stack is full.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Exit the method
      }

      stackArray1[top1 + 1] = value;
      top1++;
      updateTopElements();
    });
  }

  void pushToStack2(int value) {
    setState(() {
      if (top2 == stackArray2.length - 1) {
        // Stack is full
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Stack is Full'),
              content: const Text('Cannot push to Stack 2. Stack is full.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Exit the method
      }

      stackArray2[top2 + 1] = value;
      top2++;
      updateTopElements();
    });
  }

  void showPoppedElement(int poppedElement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popped Element'),
          content: Text('The popped element is: $poppedElement'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void popFromStack1() {
    if (top1 == -1) {
      // Stack underflow
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Stack Underflow'),
            content: const Text('Cannot pop from Stack 1. Stack is empty.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the method
    }

    int poppedElement = stackArray1[top1];
    setState(() {
      stackArray1[top1] = 0; // Replace the popped element with 0
      top1--;
      updateTopElements();
      updateUI();
    });

    showPoppedElement(poppedElement);
  }

  void popFromStack2() {
    if (top2 == -1) {
      // Stack underflow
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Stack Underflow'),
            content: const Text('Cannot pop from Stack 2. Stack is empty.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the method
    }

    int poppedElement = stackArray2[top2];
    setState(() {
      stackArray2[top2] = 0; // Replace the popped element with 0
      top2--;
      updateTopElements();
      updateUI();
    });

    showPoppedElement(poppedElement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two Stacks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        stackArray1 =
                            List<int>.filled(int.tryParse(value) ?? 0, 0);
                        top1 = -1;
                        topElement1 = -1;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stack 1 Size (Default size is 10)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        stackArray2 =
                            List<int>.filled(int.tryParse(value) ?? 0, 0);
                        top2 = -1;
                        topElement2 = -1;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stack 2 Size (Default size is 10)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final int value = int.tryParse(inputController.text) ?? 0;
                      pushToStack1(value);
                      inputController.clear();
                    },
                    child: const Text('Push to Stack 1'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final int value = int.tryParse(inputController.text) ?? 0;
                      pushToStack2(value);
                      inputController.clear();
                    },
                    child: const Text('Push to Stack 2'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      popFromStack1();
                    },
                    child: const Text('Pop from Stack 1'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      popFromStack2();
                    },
                    child: const Text('Pop from Stack 2'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Input Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Stack 1: ${stackArray1.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Stack 2: ${stackArray2.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Top Element Stack 1: $topElement1',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Top Element Stack 2: $topElement2',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
