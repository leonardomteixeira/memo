import 'package:flutter_test/flutter_test.dart';
import 'package:memo/data/serializers/collection_serializer.dart';
import 'package:memo/data/serializers/contributor_serializer.dart';
import 'package:memo/domain/models/contributor.dart';

import '../../fixtures/fixtures.dart' as fixtures;

void main() {
  final serializer = ContributorSerializer();
  const testContributor = Contributor(
    name: 'name',
    url: 'url',
    imageUrl: 'imageUrl',
  );

  dynamic contributorFromCollection() => fixtures.collection()[CollectionKeys.contributors].first;

  test('ContributorSerializer should correctly encode/decode a Contributor from a collection', () {
    final dynamic rawContributor = contributorFromCollection();

    final decodedCollection = serializer.from(rawContributor);
    expect(decodedCollection, testContributor);

    final encodedCollection = serializer.to(decodedCollection);
    expect(encodedCollection, rawContributor);
  });

  test('ContributorSerializer should fail to decode without required properties', () {
    expect(() {
      final dynamic rawContributor = contributorFromCollection()..remove(ContributorKeys.name);
      serializer.from(rawContributor);
    }, throwsA(isA<TypeError>()));
    expect(() {
      final dynamic rawContributor = contributorFromCollection()..remove(ContributorKeys.url);
      serializer.from(rawContributor);
    }, throwsA(isA<TypeError>()));
    expect(() {
      final dynamic rawContributor = contributorFromCollection()..remove(ContributorKeys.imageUrl);
      serializer.from(rawContributor);
    }, throwsA(isA<TypeError>()));
  });
}
