import 'package:covid_monitoring_indo/models/rumah_sakit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RumahSakitPage extends StatefulWidget {
  final List rumahsakit;
  const RumahSakitPage({
    Key key,
    this.rumahsakit,
  }) : super(key: key);

  @override
  _RumahSakitPageState createState() => _RumahSakitPageState();
}

class _RumahSakitPageState extends State<RumahSakitPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Color for Android
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Brightness.dark, // Dark == white status bar -- for IOS.
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Daftar Rumah Sakit Rujukan',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildSearch(text: '', hintText: 'Cari Rumah Sakit'),
            ...List.generate(widget.rumahsakit.length, (index) {
              var rumahSakit = widget.rumahsakit[index];
              if (widget.rumahsakit.length > 0) {
                return buildListRumahSakit(rumahSakit);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
          ],
        ),
      ),
    );
  }

  Widget buildListRumahSakit(RumahSakitModel rumahSakit) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            Colors.purple,
          ],
          stops: [0.1, 0.5],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rumahSakit.name,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            rumahSakit.address,
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '+ ${rumahSakit.phone}',
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BuildSearch extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const BuildSearch({
    Key key,
    @required this.text,
    this.onChanged,
    @required this.hintText,
  }) : super(key: key);

  @override
  BuildSearchState createState() => BuildSearchState();
}

class BuildSearchState extends State<BuildSearch> {
  @override
  void initState() {
    super.initState();
  }

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = GoogleFonts.montserrat(color: Colors.black);
    final styleHint = GoogleFonts.montserrat(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        // onChanged: (text) {
        //   text = text.toLowerCase();
        //   setState(() {
        //               _postDisplay = _post
        //             });
        // },
      ),
    );
  }
}
