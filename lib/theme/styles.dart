import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'colors.dart';

TextStyle customTitle = GoogleFonts.tiltNeon(fontSize: 20, fontWeight: FontWeight.bold, height: 1.3, color: brown);
TextStyle customParagraph = GoogleFonts.tiltNeon(fontSize: 16, fontWeight: FontWeight.w500, color: brown);
TextStyle customParagraphBackground = GoogleFonts.tiltNeon(fontSize: 16, fontWeight: FontWeight.w500, color: grey);
TextStyle customMiddleParagraph = GoogleFonts.tiltNeon(fontSize: 15, fontWeight: FontWeight.bold, color: white);

final italianDateFormat = DateFormat('dd MMMM yyyy', 'it_IT');