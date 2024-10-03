import 'package:flutter/material.dart';
import 'package:quiz_dimas/presentation/payment/payment_page.dart';

class PemesananPage extends StatefulWidget {
  final String imagePath;
  final String productName;
  final double productPrice;

  const PemesananPage({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productPrice,
  });

  @override
  State<PemesananPage> createState() => _PemesananPageState();
}

class _PemesananPageState extends State<PemesananPage> {
  String _fullname = "";
  String _email = "";
  int _totalroom = 0;
  int _totalnight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemesanan Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(widget.imagePath,
                      width: 300,
                      height: 300), // Gambar di tengah dan diperbesar
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        "Rp.${widget.productPrice}/night",
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Booking Information",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildForm(),
                ),
                const SizedBox(height: 12),
                Center(child: _buildButtonSubmit()), // Button di tengah
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput({
    required String hint,
    required String label,
    required Function(String value) setStateInput,
    int maxLines = 1,
    TextInputType keyboardType =
        TextInputType.text, // Tambahkan untuk mengatur jenis input
  }) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType:
          keyboardType, // Untuk menentukan tipe input, misalnya number
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: setStateInput,
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _formInput(
          hint: "Enter Full Name",
          label: "Full Name *",
          setStateInput: (value) {
            setState(() {
              _fullname = value;
            });
          },
        ),
        const SizedBox(height: 12),
        _formInput(
          hint: "Enter Email",
          label: "Email *",
          setStateInput: (value) {
            setState(() {
              _email = value;
            });
          },
        ),
        const SizedBox(height: 12),
        _formInput(
          hint: "Enter Total Room",
          label: "Total Room *",
          keyboardType: TextInputType.number, // Mengubah input menjadi number
          setStateInput: (value) {
            setState(() {
              _totalroom =
                  int.tryParse(value) ?? 0; // Parsing string menjadi int
            });
          },
        ),
        const SizedBox(height: 12),
        _formInput(
          hint: "Enter Total Night",
          label: "Total Night *",
          keyboardType: TextInputType.number, // Mengubah input menjadi number
          setStateInput: (value) {
            setState(() {
              _totalnight =
                  int.tryParse(value) ?? 0; // Parsing string menjadi int
            });
          },
        ),
      ],
    );
  }

  Widget _buildButtonSubmit() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 24.0), // Memberi jarak dengan batas bawah
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            if (_fullname.isEmpty ||
                _email.isEmpty ||
                _totalroom == 0 ||
                _totalnight == 0) {
              const snackBar =
                  SnackBar(content: Text("All fields are required"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PaymentPage(
                      name: _fullname,
                      email: _email,
                      totalroom: _totalroom,
                      totalnight: _totalnight,
                      productPrice: widget.productPrice,
                    );
                  },
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
