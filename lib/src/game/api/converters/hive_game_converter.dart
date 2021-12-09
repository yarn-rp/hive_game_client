import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_game_client/core/error/failures.dart';
import 'package:hive_game_client/src/game/models/arena/arena.dart';

class HiveGameConverter {
  static Response<Either<Failure, Arena>> convertResponseArena(Response res) {
    final bodyDecoded = json.decode(res.body) as Map<String, dynamic>;
    log('convertResponseArena got $bodyDecoded');
    if (res.isSuccessful && res.statusCode == 200) {
      try {
        final _arenaJson = res.body['arena'];
        return res.copyWith(body: right(Arena.fromJson(_arenaJson)));
      } catch (e) {
        return res.copyWith(
          body: left(
            UnexpectedFailure(
              message: e.toString(),
            ),
          ),
        );
      }
    } else {
      return res.copyWith(
          body: left(
        ServerFailure(message: bodyDecoded['message'] ?? 'Something wrong'),
      ));
    }
  }
}
