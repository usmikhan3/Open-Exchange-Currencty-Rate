import 'package:currency_rate/services/api_services.dart';
import 'package:flutter/material.dart';




class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({Key? key, this.rates,required this.currencies}) : super(key: key);

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {

  TextEditingController usdController = TextEditingController();
  String dropDownValue = 'AUD';
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
            const Text("USD to any Currency",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),

            const SizedBox(height: 20,),

            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),


            const SizedBox(height: 10,),

            Row(
              children: [
                Expanded(child: DropdownButton<String>(
                  value: dropDownValue,
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
                              dropDownValue = newValue!;
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
                        answer = usdController.text + ' USD = ' +
                        APIServices.convertToUsd(widget.rates, usdController.text,
                        dropDownValue) + ' ' + dropDownValue;
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
