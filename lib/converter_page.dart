import 'package:flutter/material.dart';

enum Currency { usd, pound }

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});
  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  Currency _selectedCurrency = Currency.usd;
  double _result = 0;
  String? _errorText;
  bool _empty = true;

  Color textColor = Color.fromARGB(96, 230, 140, 163);
  Color buttonColor = Color.fromARGB(95, 245, 48, 97);

  final TextEditingController _controller = TextEditingController();

  // Conversion rates *from BDT*
  static const _rates = {Currency.usd: 0.0082, Currency.pound: 0.0062};

  // Labels for display
  static const _labels = {Currency.usd: 'USD', Currency.pound: 'GBP'};

  void convert() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      _errorText = 'Can\'t be empty';
    } else {
      final value = double.tryParse(text);
      if (value == null) {
        _errorText = 'Enter a valid number';
      } else {
        _errorText = null;
        _result = value * _rates[_selectedCurrency]!;
        _empty = false;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 48, 37, 37),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(40),
    );
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 23,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency Converter",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
        elevation: 5,
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 550,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BDT', style: textStyle),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: textColor),
                      SizedBox(width: 8),
                      Text(_labels[_selectedCurrency]!, style: textStyle),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Radio buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        Currency.values.map((c) {
                          return Row(
                            children: [
                              Radio<Currency>(
                                value: c,
                                groupValue: _selectedCurrency,
                                activeColor: textColor,
                                onChanged: (val) {
                                  _empty = true;
                                  setState(() => _selectedCurrency = val!);
                                },
                              ),
                              Text(_labels[c]!, style: TextStyle(fontSize: 16)),
                            ],
                          );
                        }).toList(),
                  ),

                  SizedBox(height: 24),

                  // Amount input
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: "Amount in Taka",
                      hintText: "Enter amount",
                      errorText: _errorText,
                      prefixIcon: Icon(Icons.monetization_on, color: textColor),
                      focusedBorder: border,
                      enabledBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border,
                    ),
                  ),

                  SizedBox(height: 24),

                  // Convert button
                  TextButton(
                    onPressed: convert,
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Convert", style: TextStyle(fontSize: 18)),
                  ),

                  SizedBox(height: 24),

                  // Result display
                  Text(
                    _errorText == null && _empty == false
                        ? '${_labels[_selectedCurrency]} ${_result.toStringAsFixed(2)}'
                        : '',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
