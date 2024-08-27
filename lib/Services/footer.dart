import 'package:flutter/material.dart';


class CustomFooter extends StatelessWidget {

  const CustomFooter({super.key});

//TODO Modifiar el footer con links respectivos para cada seccion;
//Links:
//Perfil: https://portafolio-web-roan.vercel.app/
//Repositorio: https://github.com/Litardo-Jardy/LocalMarket 
//Licensia: https://creativecommons.org/licenses/by-nc/4.0/?ref=chooser-v1 
  @override
  Widget build(BuildContext context){
     return const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'LocalMarket © 2024 by Jardy Litardo is licensed under CC BY-NC 4.0' ,
                  style: TextStyle(color: Color.fromARGB(255, 182, 181, 181)),
                ),
              );  
 
  }

  }
