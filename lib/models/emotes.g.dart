// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmoteTwitch _$EmoteTwitchFromJson(Map<String, dynamic> json) => EmoteTwitch(
      json['id'] as String,
      json['name'] as String,
      json['emote_type'] as String?,
      json['owner_id'] as String?,
    );

EmoteBTTV _$EmoteBTTVFromJson(Map<String, dynamic> json) => EmoteBTTV(
      json['id'] as String,
      json['code'] as String,
    );

EmoteBTTVChannel _$EmoteBTTVChannelFromJson(Map<String, dynamic> json) =>
    EmoteBTTVChannel(
      (json['channelEmotes'] as List<dynamic>)
          .map((e) => EmoteBTTV.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sharedEmotes'] as List<dynamic>)
          .map((e) => EmoteBTTV.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

RoomFFZ _$RoomFFZFromJson(Map<String, dynamic> json) => RoomFFZ(
      json['set'] as int,
      json['vip_badge'] == null
          ? null
          : ImagesFFZ.fromJson(json['vip_badge'] as Map<String, dynamic>),
      json['mod_urls'] == null
          ? null
          : ImagesFFZ.fromJson(json['mod_urls'] as Map<String, dynamic>),
    );

ImagesFFZ _$ImagesFFZFromJson(Map<String, dynamic> json) => ImagesFFZ(
      json['1'] as String,
      json['2'] as String?,
      json['4'] as String?,
    );

EmoteFFZ _$EmoteFFZFromJson(Map<String, dynamic> json) => EmoteFFZ(
      json['name'] as String,
      json['height'] as int,
      json['width'] as int,
      ImagesFFZ.fromJson(json['urls'] as Map<String, dynamic>),
    );

Emote7TV _$Emote7TVFromJson(Map<String, dynamic> json) => Emote7TV(
      json['id'] as String,
      json['flags'] as int,
      json['name'] as String,
      Emote7TVData.fromJson(json['data'] as Map<String, dynamic>),
    );

Emote7TVData _$Emote7TVDataFromJson(Map<String, dynamic> json) => Emote7TVData(
      json['id'] as String,
      json['name'] as String,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Emote7TVHost.fromJson(json['host'] as Map<String, dynamic>),
    );

Emote7TVHost _$Emote7TVHostFromJson(Map<String, dynamic> json) => Emote7TVHost(
      json['url'] as String,
      (json['files'] as List<dynamic>)
          .map((e) => Emote7TVFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Emote7TVFile _$Emote7TVFileFromJson(Map<String, dynamic> json) => Emote7TVFile(
      json['name'] as String,
      json['width'] as int,
      json['height'] as int,
      json['format'] as String,
    );

Emote _$EmoteFromJson(Map<String, dynamic> json) => Emote(
      name: json['name'] as String,
      realName: json['realName'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      zeroWidth: json['zeroWidth'] as bool,
      url: json['url'] as String,
      type: $enumDecode(_$EmoteTypeEnumMap, json['type']),
      ownerId: json['ownerId'] as String?,
    );

Map<String, dynamic> _$EmoteToJson(Emote instance) => <String, dynamic>{
      'name': instance.name,
      'realName': instance.realName,
      'width': instance.width,
      'height': instance.height,
      'zeroWidth': instance.zeroWidth,
      'url': instance.url,
      'type': _$EmoteTypeEnumMap[instance.type]!,
      'ownerId': instance.ownerId,
    };

const _$EmoteTypeEnumMap = {
  EmoteType.twitchBits: 'twitchBits',
  EmoteType.twitchFollower: 'twitchFollower',
  EmoteType.twitchSub: 'twitchSub',
  EmoteType.twitchGlobal: 'twitchGlobal',
  EmoteType.twitchUnlocked: 'twitchUnlocked',
  EmoteType.twitchChannel: 'twitchChannel',
  EmoteType.ffzGlobal: 'ffzGlobal',
  EmoteType.ffzChannel: 'ffzChannel',
  EmoteType.bttvGlobal: 'bttvGlobal',
  EmoteType.bttvChannel: 'bttvChannel',
  EmoteType.bttvShared: 'bttvShared',
  EmoteType.sevenTVGlobal: 'sevenTVGlobal',
  EmoteType.sevenTVChannel: 'sevenTVChannel',
};
