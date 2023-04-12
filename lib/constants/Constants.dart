import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

const obgFields = "Campos Obrigatórios";

const invalidCred = "Credenciais inválidas!";

const missSns = "Sns por preencher!"; 

const missCode = "Código de Acesso por preencher!";

const invalidSns = "Número de Sns inválido!";

const invalidSnsOrCode = "Número de SNS ou Código de Acesso inválido(s)!";
