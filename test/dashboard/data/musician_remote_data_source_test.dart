import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setlist/core/errors.dart';
import 'package:setlist/core/data/datasources/musician_remote_data_source.dart';

const musicianId = 'music123';
const musicianName = 'mike';
const membershipId = 'membership123';

void main() {
  late MusicianRemoteDataSourceImpl dataSourceImpl;

  setUp(() async {
    dataSourceImpl = MusicianRemoteDataSourceImpl(firebaseDatabase: FakeFirebaseFirestore());
    await dataSourceImpl.createMusician(name: musicianName, id: musicianId);
  });

  test('Fetch the created musician', () async {
    final musician = await dataSourceImpl.getMusician(id: musicianId);
    expect(musician.id, musicianId);
  });

  test('Should return the musician with getMusicians', () async {
    final musician = await dataSourceImpl.getMusicians(musicianIds: [musicianId]);
    expect(musician.first.id, musicianId);
  });

  test('Should throw a DataNotFound error if no musician exists', () async {
    expect(
      () async => await dataSourceImpl.getMusician(id: 'musician_doesnt_exist'),
      throwsA(
        isA<DataNotFoundError>(),
      ),
    );
  });
}
