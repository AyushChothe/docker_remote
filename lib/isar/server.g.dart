// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServerCollection on Isar {
  IsarCollection<Server> get servers => this.collection();
}

const ServerSchema = CollectionSchema(
  name: r'Server',
  id: -6947657830638655508,
  properties: {
    r'caCert': PropertySchema(
      id: 0,
      name: r'caCert',
      type: IsarType.longList,
    ),
    r'clientCert': PropertySchema(
      id: 1,
      name: r'clientCert',
      type: IsarType.longList,
    ),
    r'host': PropertySchema(
      id: 2,
      name: r'host',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'port': PropertySchema(
      id: 4,
      name: r'port',
      type: IsarType.string,
    ),
    r'privateKey': PropertySchema(
      id: 5,
      name: r'privateKey',
      type: IsarType.longList,
    ),
    r'sshPassword': PropertySchema(
      id: 6,
      name: r'sshPassword',
      type: IsarType.string,
    ),
    r'sshPort': PropertySchema(
      id: 7,
      name: r'sshPort',
      type: IsarType.string,
    ),
    r'sshUsername': PropertySchema(
      id: 8,
      name: r'sshUsername',
      type: IsarType.string,
    )
  },
  estimateSize: _serverEstimateSize,
  serialize: _serverSerialize,
  deserialize: _serverDeserialize,
  deserializeProp: _serverDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'host': IndexSchema(
      id: -7602099240340412494,
      name: r'host',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'host',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'port': IndexSchema(
      id: 3657739355832949656,
      name: r'port',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'port',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'sshUsername': IndexSchema(
      id: 2656186661577807604,
      name: r'sshUsername',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sshUsername',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'sshPassword': IndexSchema(
      id: 1302134463429490852,
      name: r'sshPassword',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sshPassword',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'sshPort': IndexSchema(
      id: 1018524913158316217,
      name: r'sshPort',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sshPort',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _serverGetId,
  getLinks: _serverGetLinks,
  attach: _serverAttach,
  version: '3.1.0+1',
);

int _serverEstimateSize(
  Server object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.caCert.length * 8;
  bytesCount += 3 + object.clientCert.length * 8;
  {
    final value = object.host;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.port;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.privateKey.length * 8;
  {
    final value = object.sshPassword;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sshPort;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sshUsername;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _serverSerialize(
  Server object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.caCert);
  writer.writeLongList(offsets[1], object.clientCert);
  writer.writeString(offsets[2], object.host);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.port);
  writer.writeLongList(offsets[5], object.privateKey);
  writer.writeString(offsets[6], object.sshPassword);
  writer.writeString(offsets[7], object.sshPort);
  writer.writeString(offsets[8], object.sshUsername);
}

Server _serverDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Server();
  object.caCert = reader.readLongList(offsets[0]) ?? [];
  object.clientCert = reader.readLongList(offsets[1]) ?? [];
  object.host = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[3]);
  object.port = reader.readStringOrNull(offsets[4]);
  object.privateKey = reader.readLongList(offsets[5]) ?? [];
  object.sshPassword = reader.readStringOrNull(offsets[6]);
  object.sshPort = reader.readStringOrNull(offsets[7]);
  object.sshUsername = reader.readStringOrNull(offsets[8]);
  return object;
}

P _serverDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _serverGetId(Server object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serverGetLinks(Server object) {
  return [];
}

void _serverAttach(IsarCollection<dynamic> col, Id id, Server object) {
  object.id = id;
}

extension ServerQueryWhereSort on QueryBuilder<Server, Server, QWhere> {
  QueryBuilder<Server, Server, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anyHost() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'host'),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anyPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'port'),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anySshUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sshUsername'),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anySshPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sshPassword'),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhere> anySshPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sshPort'),
      );
    });
  }
}

extension ServerQueryWhere on QueryBuilder<Server, Server, QWhereClause> {
  QueryBuilder<Server, Server, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameNotEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameGreaterThan(
    String? name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameLessThan(
    String? name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameBetween(
    String? lowerName,
    String? upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'host',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'host',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostEqualTo(String? host) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'host',
        value: [host],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostNotEqualTo(String? host) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'host',
              lower: [],
              upper: [host],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'host',
              lower: [host],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'host',
              lower: [host],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'host',
              lower: [],
              upper: [host],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostGreaterThan(
    String? host, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'host',
        lower: [host],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostLessThan(
    String? host, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'host',
        lower: [],
        upper: [host],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostBetween(
    String? lowerHost,
    String? upperHost, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'host',
        lower: [lowerHost],
        includeLower: includeLower,
        upper: [upperHost],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostStartsWith(
      String HostPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'host',
        lower: [HostPrefix],
        upper: ['$HostPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'host',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> hostIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'host',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'host',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'host',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'host',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'port',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'port',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portEqualTo(String? port) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'port',
        value: [port],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portNotEqualTo(String? port) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'port',
              lower: [],
              upper: [port],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'port',
              lower: [port],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'port',
              lower: [port],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'port',
              lower: [],
              upper: [port],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portGreaterThan(
    String? port, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'port',
        lower: [port],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portLessThan(
    String? port, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'port',
        lower: [],
        upper: [port],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portBetween(
    String? lowerPort,
    String? upperPort, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'port',
        lower: [lowerPort],
        includeLower: includeLower,
        upper: [upperPort],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portStartsWith(
      String PortPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'port',
        lower: [PortPrefix],
        upper: ['$PortPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'port',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> portIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'port',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'port',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'port',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'port',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshUsername',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshUsername',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameEqualTo(
      String? sshUsername) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshUsername',
        value: [sshUsername],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameNotEqualTo(
      String? sshUsername) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshUsername',
              lower: [],
              upper: [sshUsername],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshUsername',
              lower: [sshUsername],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshUsername',
              lower: [sshUsername],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshUsername',
              lower: [],
              upper: [sshUsername],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameGreaterThan(
    String? sshUsername, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshUsername',
        lower: [sshUsername],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameLessThan(
    String? sshUsername, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshUsername',
        lower: [],
        upper: [sshUsername],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameBetween(
    String? lowerSshUsername,
    String? upperSshUsername, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshUsername',
        lower: [lowerSshUsername],
        includeLower: includeLower,
        upper: [upperSshUsername],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameStartsWith(
      String SshUsernamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshUsername',
        lower: [SshUsernamePrefix],
        upper: ['$SshUsernamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshUsername',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshUsernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshUsername',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshUsername',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshUsername',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshUsername',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPassword',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPassword',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordEqualTo(
      String? sshPassword) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPassword',
        value: [sshPassword],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordNotEqualTo(
      String? sshPassword) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPassword',
              lower: [],
              upper: [sshPassword],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPassword',
              lower: [sshPassword],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPassword',
              lower: [sshPassword],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPassword',
              lower: [],
              upper: [sshPassword],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordGreaterThan(
    String? sshPassword, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPassword',
        lower: [sshPassword],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordLessThan(
    String? sshPassword, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPassword',
        lower: [],
        upper: [sshPassword],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordBetween(
    String? lowerSshPassword,
    String? upperSshPassword, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPassword',
        lower: [lowerSshPassword],
        includeLower: includeLower,
        upper: [upperSshPassword],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordStartsWith(
      String SshPasswordPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPassword',
        lower: [SshPasswordPrefix],
        upper: ['$SshPasswordPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPassword',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshPassword',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshPassword',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshPassword',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshPassword',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPort',
        value: [null],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPort',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortEqualTo(
      String? sshPort) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPort',
        value: [sshPort],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortNotEqualTo(
      String? sshPort) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPort',
              lower: [],
              upper: [sshPort],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPort',
              lower: [sshPort],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPort',
              lower: [sshPort],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sshPort',
              lower: [],
              upper: [sshPort],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortGreaterThan(
    String? sshPort, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPort',
        lower: [sshPort],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortLessThan(
    String? sshPort, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPort',
        lower: [],
        upper: [sshPort],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortBetween(
    String? lowerSshPort,
    String? upperSshPort, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPort',
        lower: [lowerSshPort],
        includeLower: includeLower,
        upper: [upperSshPort],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortStartsWith(
      String SshPortPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sshPort',
        lower: [SshPortPrefix],
        upper: ['$SshPortPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sshPort',
        value: [''],
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterWhereClause> sshPortIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshPort',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshPort',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'sshPort',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'sshPort',
              upper: [''],
            ));
      }
    });
  }
}

extension ServerQueryFilter on QueryBuilder<Server, Server, QFilterCondition> {
  QueryBuilder<Server, Server, QAfterFilterCondition> caCertElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caCert',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> caCertLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'caCert',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition>
      clientCertElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientCert',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientCert',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition>
      clientCertLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> clientCertLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'clientCert',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'host',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'host',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'host',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'host',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'host',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> hostIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'host',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'port',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'port',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> portIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'port',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'privateKey',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition>
      privateKeyElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'privateKey',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'privateKey',
        value: value,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'privateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition>
      privateKeyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> privateKeyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'privateKey',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sshPassword',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sshPassword',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sshPassword',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sshPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sshPassword',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sshPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sshPort',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sshPort',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sshPort',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sshPort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sshPort',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshPort',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshPortIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sshPort',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sshUsername',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sshUsername',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sshUsername',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sshUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sshUsername',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sshUsername',
        value: '',
      ));
    });
  }

  QueryBuilder<Server, Server, QAfterFilterCondition> sshUsernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sshUsername',
        value: '',
      ));
    });
  }
}

extension ServerQueryObject on QueryBuilder<Server, Server, QFilterCondition> {}

extension ServerQueryLinks on QueryBuilder<Server, Server, QFilterCondition> {}

extension ServerQuerySortBy on QueryBuilder<Server, Server, QSortBy> {
  QueryBuilder<Server, Server, QAfterSortBy> sortByHost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortByHostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPassword', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPassword', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPort', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPort', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshUsername', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> sortBySshUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshUsername', Sort.desc);
    });
  }
}

extension ServerQuerySortThenBy on QueryBuilder<Server, Server, QSortThenBy> {
  QueryBuilder<Server, Server, QAfterSortBy> thenByHost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByHostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPassword', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPassword', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPort', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshPort', Sort.desc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshUsername', Sort.asc);
    });
  }

  QueryBuilder<Server, Server, QAfterSortBy> thenBySshUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sshUsername', Sort.desc);
    });
  }
}

extension ServerQueryWhereDistinct on QueryBuilder<Server, Server, QDistinct> {
  QueryBuilder<Server, Server, QDistinct> distinctByCaCert() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caCert');
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctByClientCert() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientCert');
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctByHost(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'host', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctByPort(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctByPrivateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'privateKey');
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctBySshPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sshPassword', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctBySshPort(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sshPort', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Server, Server, QDistinct> distinctBySshUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sshUsername', caseSensitive: caseSensitive);
    });
  }
}

extension ServerQueryProperty on QueryBuilder<Server, Server, QQueryProperty> {
  QueryBuilder<Server, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Server, List<int>, QQueryOperations> caCertProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caCert');
    });
  }

  QueryBuilder<Server, List<int>, QQueryOperations> clientCertProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientCert');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> hostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'host');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<Server, List<int>, QQueryOperations> privateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'privateKey');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> sshPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sshPassword');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> sshPortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sshPort');
    });
  }

  QueryBuilder<Server, String?, QQueryOperations> sshUsernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sshUsername');
    });
  }
}
