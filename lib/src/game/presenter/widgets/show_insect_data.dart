import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:hive_game_client/core/widgets/bottom_sheets/action_sheets/indicator_upper_bottom_sheet.dart';
import 'package:hive_game_client/src/game/models/models.dart';

Future<void> showInsectData(BuildContext context, Insect insect) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(maxWidth: 360),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IndicatorUpperBottomSheet(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  color: Theme.of(context).dividerColor,
                ),
                HexagonWidget(
                  width: 100,
                  type: HexagonType.FLAT,
                  padding: 4.0,
                  cornerRadius: 8.0,
                  elevation: 8,
                  color: Theme.of(context).dividerColor,
                  child: Center(
                    child: IgnorePointer(
                      child: Image.asset(
                        'assets/images/${insect.type}.png',
                        height: 60,
                        // color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  insect.type,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  var _text = '';
                  switch (insect.type) {
                    case 'queen_bee':
                      _text =
                          'Puede mover solo un espacio por turno. Pese a que sus movimientos son ciertamente restringidos, moverla en el momento adecuado puede dar un giro importante a la partida.';
                      break;
                    case 'beetle':
                      _text =
                          'Al igual que la abeja reina, el escarabajo solo puede mover un espacio por turno, con la ventaja de poder colocarse encima de cualquier otra pieza que tenga adyacente, ya sea blanca o negra. La pieza que quede debajo del escarabajo no podr?? moverse, por lo que quedar?? bloqueada. La ??nica forma de bloquear a un escarabajo que se encuentra encima de un insecto de la colmena es colocando otro escarabajo sobre ??l; en algunas partidas podr?? darse el caso de que queden los cuatro escarabajos apilados.';
                      break;
                    case 'grasshopper':
                      _text =
                          'El saltamontes no se mueve de forma convencional, sino que da saltos en l??nea recta saltando cualquier n??mero de piezas interconectadas hasta alcanzar un espacio desocupado. No puede saltar por encima de espacios vac??os.';
                      break;
                    case 'spider':
                      _text =
                          'La ara??a mueve tres espacios cada turno y siempre tocando piezas que se encuentren en su trayectoria. Durante los tres pasos de su movimiento, deber?? permanecer siempre en contacto con la colmena.';
                      break;
                    case 'soldier_ant':
                      _text =
                          'La hormiga tiene enorme libertad de movimiento, pudiendo moverse desde su lugar hacia cualquier otro, siempre rodeando la colmena y sin importar el n??mero de espacios que avance. No puede saltar a espacios vac??os como sucede con el saltamontes.';
                      break;
                    case 'lady_bug':
                      _text =
                          '''Al entrar por primera vez en juego se coloca igual que el resto de las piezas. Una vez en la partida, la
Mariquita se mueve tres espacios, dos por encima de la Colmena y uno para bajar de ella. Debe
moverse exactamente dos espacios por encima de las piezas de la Colmena y acabar su movimiento
bajando. No se puede mover por el per??metro de la Colmena, ni tampoco puede acabar su movimiento
encima de ninguna pieza, como sucede con el Escarabajo. Su principal ventaja es que puede moverse desde
y hacia espacios bloqueados.''';
                      break;
                    case 'mosquito':
                      _text =
                          '''Al introducir el mosquito en la partida se debe hacer al igual que el resto de las piezas. Una vez en juego, adopta los movimientos de cualquier pieza con la que est?? en contacto en el momento en el que se disponga a mover (incluidas las piezas del adversario), cambiando as?? sus caracter??sticas de movimiento a lo largo de toda la partida. A tener en cuenta:
??? Si un Mosquito adopta los movimientos del Escarabajo y se sube encima de la Colmena, continuar?? movi??ndose como un Escarabajo hasta que baje de la Colmena. Si estando a nivel del suelo est?? al lado de un Escarabajo apilado sobre otra ficha, se mover?? como el Escarabajo y no como la pieza que est?? debajo del mismo.
??? Si un Mosquito solo est?? en contacto con otro Mosquito, no podr?? moverse.
''';
                      break;
                    default:
                      _text =
                          '''La tambi??n conocida como Pillbug es una pieza cuyos movimientos son id??nticos a los de la Abeja Reina, es decir, uno solo por turno y a un lugar contiguo. La peculiaridad de esta expansi??n reside en que puede hacer mover a cualquier ficha que est?? en contacto con ella (propia o del adversario) dos espacios: el primero sobre el bicho bola y el segundo a cualquier espacio vac??o adyacente. Esta poderosa habilidad tiene algunas excepciones importantes:
??? El bicho bola no podr?? mover la ??ltima pieza que haya movido el adversario.
??? No podr?? mover una pieza apilada.
??? No podr?? mover una pieza a trav??s de un hueco con piezas apiladas.
??? No podr?? mover una pieza si tras hacerlo la Colmena se rompe.
??? La pieza movida por el bicho bola no podr?? moverse ni ser movida durante el siguiente turno.
??? Los mosquitos tambi??n pueden usar la habilidad del bicho bola si est??n en contacto con ??l.''';
                  }
                  return Text(
                    _text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.headline6,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
