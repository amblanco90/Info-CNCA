import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:InfoCNCA/utils/consts.dart';
class PasswordForm extends StatefulWidget {
  var controller = TextEditingController();

  PasswordForm({this.controller});
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<PasswordForm> {
  
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
        print(_obscureText);
      });
    }

    return TextFormField(
      controller: widget.controller,
      validator: (value){
        if (value.isEmpty) {
                return 'Complete este campo';
              }
        else if(value.length<8){
           return 'La contraseña debe ser mayor a 8 caracteres';
        }
              return null;
      },
      style: TextStyle(fontFamily: "nunito",
          fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
      obscureText: _obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.grey.shade700,
          ),
          suffixIcon: IconButton(
            onPressed: _toggle,
            icon: _obscureText
                ? Icon(
                    FontAwesomeIcons.eye,
                    color: Colors.grey.shade700,
                  )
                : Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: Colors.grey.shade700,
                  ),
            iconSize: 20,
          ),
          hintText: "Contraseña",
          hintStyle: TextStyle(fontFamily: "nunito",
              fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusColor: Colors.grey.shade700,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          )),
    );
  }
}

class NormalForm extends StatelessWidget {

  
  
  final String hint;
  final  TextEditingController control;

  NormalForm(this.hint, this.control);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: control,
      validator: (value){
        if (value.isEmpty) {
                return 'Complete este campo';
              }
        if(this.hint=="Correo"&&value.contains('@misena.edu.co')==false){

          return 'Asegurese de haber ingresado un correo sena valido';

        }
              return null;
      },
      style:
      TextStyle(fontFamily: "nunito",
          fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
         
          
          hintText: hint,
          hintStyle:  TextStyle(fontFamily: "nunito",
              fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
          contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusColor: Colors.grey.shade700,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          )),
    );
  }



}


class BidInput extends StatelessWidget {
  final control;
  const BidInput({Key key,this.control}) : super(key: key);

  @override
   Widget build(BuildContext context) {

    return Container(
       width: MediaQuery.of(context).size.width,
       color:Colors.grey.shade100,
      height: 200,
      child: TextFormField(
        maxLines: null,
        controller: control,
        validator: (value){
          if (value.isEmpty) {
                  return 'Complete este campo';
                }
         
                return null;
        },
        style:
        TextStyle(fontFamily: "nunito",
            fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            
            
            hintText: 'Escriba aquí...',
            hintStyle:  TextStyle(fontFamily: "nunito",
                fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
            contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusColor: Colors.grey.shade700,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15.0),
            )),
      ),
    );
  }



}