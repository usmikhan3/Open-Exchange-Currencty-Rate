import 'package:currency_rate/services/api_services.dart';
import 'package:flutter/material.dart';




class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnyToAny({Key? key, this.rates,required this.currencies}) : super(key: key);

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {

  TextEditingController amountController = TextEditingController();
  String dropDownValue1 = 'AUD';
  String dropDownValue2 = 'AUD';
  String answer = 'Converted Currency will be shown here: ';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Convert any Currency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),

            const SizedBox(height: 20,),

            TextFormField(
              key:const ValueKey('amount'),
              controller: amountController,
              decoration:const InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
            ),


            const SizedBox(height: 10,),

            Row(
              children: [
                Expanded(child: DropdownButton<String>(
                  value: dropDownValue1,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade400,
                  ),
                  onChanged: (String? newValue){
                    setState(() {
                            dropDownValue1 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      child:Text(value),value: value,);
                  }).toList(),
                ),),

                const SizedBox(width: 10,),


                const Text("To"),

                const SizedBox(width: 10,),
                Expanded(child: DropdownButton<String>(
                  value: dropDownValue2,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade400,
                  ),
                  onChanged: (String? newValue){
                    setState(() {
                      dropDownValue2 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      child:Text(value),value: value,);
                  }).toList(),
                ),),


                const SizedBox(width: 10,),
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        answer = amountController.text + ' ' +

                            dropDownValue1 + ' ' +

                            APIServices.convertToAny(widget.rates, amountController.text,
                                dropDownValue1, dropDownValue2) + ' ' + dropDownValue2;
                      });
                    },
                    child: const Text("Convert",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                    style:ElevatedButton.styleFrom(
                      primary: Color(0xFFECE115),
                    ),




                  ),
                ),

                const SizedBox(width: 10,),
              ],
            ),

            const SizedBox(height: 10,),

            Container(
              child: Text(answer),
            ),

          ],
        ),
      ),
    );
  }
}
