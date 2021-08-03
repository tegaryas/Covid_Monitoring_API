import 'package:covid_monitoring_indo/providers/indo_provider.dart';
import 'package:covid_monitoring_indo/providers/province_provider.dart';
import 'package:covid_monitoring_indo/providers/rumah_sakit_provider.dart';
import 'package:covid_monitoring_indo/screens/rumah_sakit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    Provider.of<IndoProvider>(context, listen: false).getIndoProvider();
    Provider.of<ProvinceProvider>(context, listen: false).getProvinceModel();
    Provider.of<RumahSakitProvider>(context, listen: false)
        .getRumahSakitModel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Color for Android
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
            Brightness.dark, // Dark == white status bar -- for IOS.
      ),
    );
    DateFormat dateFormat = DateFormat.yMMMMEEEEd('id');
    NumberFormat numberFormat = NumberFormat("#,###");
    var size = MediaQuery.of(context).size;

    var indo = Provider.of<IndoProvider>(context).indo;
    var province = Provider.of<ProvinceProvider>(context).province;
    var rumahsakit = Provider.of<RumahSakitProvider>(context).rumahSakit;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
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
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ITA',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'COV',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.purple.shade300,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade400,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 20,
                        child: Text(
                          'Lawan\nCOVID-19',
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        right: -50,
                        child: Image.asset(
                          'assets/images/banner.png',
                          alignment: Alignment.bottomRight,
                          scale: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dropDownLokasi(),
                      if (indo != null)
                        _buildHeaderdanDetail(
                            dateFormat.format(indo?.lastUpdate) ?? ''),
                      if (indo != null)
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 20,
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: -8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BuildInformasiCovid(
                                icon: Icons.add,
                                angka: numberFormat
                                        .format(indo?.confirmed?.value) ??
                                    '',
                                color: Colors.orange,
                                title: 'Kasus Positif',
                              ),
                              BuildInformasiCovid(
                                icon: Icons.favorite_border_outlined,
                                angka: numberFormat
                                        .format(indo?.recovered?.value) ??
                                    '',
                                color: Colors.green,
                                title: 'Sembuh',
                              ),
                              BuildInformasiCovid(
                                icon: Icons.close,
                                angka:
                                    numberFormat.format(indo?.deaths?.value) ??
                                        '',
                                color: Colors.red,
                                title: 'Meninggal',
                              ),
                            ],
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return RumahSakitPage(
                              rumahsakit: rumahsakit,
                            );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
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
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    Image.asset('assets/images/hospital.png'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rumah Sakit Rujukan',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Berisi daftar rumah sakit rujukan disetiap kabupaten',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Update Per-Provinsi',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            if (province?.data != null)
                              ...List.generate(
                                province.data.length - 1,
                                (index) {
                                  var prov = province?.data[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 20,
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: -8,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              prov?.provinsi ?? '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey.shade200,
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BuildProvInfo(
                                              numberFormat: numberFormat,
                                              prov: prov?.kasusPosi ?? '',
                                              color: Colors.orange,
                                              title: 'Kasus Positif',
                                            ),
                                            BuildProvInfo(
                                              numberFormat: numberFormat,
                                              prov: prov?.kasusSemb ?? '',
                                              color: Colors.green,
                                              title: 'Sembuh',
                                            ),
                                            BuildProvInfo(
                                              numberFormat: numberFormat,
                                              prov: prov?.kasusMeni ?? '',
                                              color: Colors.red,
                                              title: 'Meninggal',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeaderdanDetail(update) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Kasus COVID-19',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                update ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.purple.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Lihat Detail',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownLokasi() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(
          50,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.withOpacity(0.2)),
                child: Icon(
                  Icons.location_on,
                  color: Colors.purple,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Seluruh Indonesia',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 25,
          )
        ],
      ),
    );
  }
}

class BuildProvInfo extends StatelessWidget {
  const BuildProvInfo({
    Key key,
    @required this.numberFormat,
    @required this.prov,
    @required this.color,
    this.title,
  }) : super(key: key);

  final NumberFormat numberFormat;
  final int prov;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: color,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            numberFormat.format(prov),
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class BuildInformasiCovid extends StatelessWidget {
  final IconData icon;
  final String angka;
  final Color color;
  final String title;
  const BuildInformasiCovid({
    Key key,
    @required this.icon,
    @required this.angka,
    this.color,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          angka,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        )
      ],
    );
  }
}
