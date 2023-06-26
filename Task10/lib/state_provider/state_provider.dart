import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateProvider=StateProvider<int>(
  (ref) => 0,
  );


class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterApp'),
      ),
      body: Consumer(//now Consumer widget 
      //has become the listener of the 
      //counterStateProvider states
      //which means that whenever the value of
      //counterStateProvider changes,Consumer widget will rebuild
        builder:(context,ref,child){
       int count= ref.watch(counterStateProvider);
       return Center(
         child: Text(count.toString(),
         style: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF880E4F)
         ),
        ),
       );
      } ,
    ),
       floatingActionButton: FloatingActionButton(onPressed: (){

       
        ref.read(counterStateProvider.notifier).state++;

       },
       child: Icon(Icons.add),
       ),
    );
  }
}