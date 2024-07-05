import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setlist/core/db_consts.dart';
import 'package:setlist/core/firebase_utils.dart';
import 'package:setlist/features/dashboard/data/models/membership_model.dart';
import 'package:setlist/features/dashboard/data/models/role_model.dart';

abstract class MembershipRemoteDataSource {
  Future<String> createMembership({required String musicianId, required String bandId, required RoleModel role});
}

class MembershipRemoteDataSourceImpl extends MembershipRemoteDataSource {
  MembershipRemoteDataSourceImpl({
    FirebaseFirestore? firebaseDatabase,
  }) : _db = firebaseDatabase ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  @override
  Future<String> createMembership({required String musicianId, required String bandId, required RoleModel role}) {
    final collectionRef = _db.collection(kMembershipPath);

    final newMembership = MembershipModel(bandId: bandId, musicianId: musicianId, role: role);

    return firebaseAdd(collectionRef, newMembership.toJson());
  }
}
