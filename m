Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047DE7AE5B6
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1SE-0007mk-AW; Tue, 26 Sep 2023 02:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1S8-0007mN-Kh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:21:48 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1S5-0004r4-Or
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695709306; x=1727245306;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cKveDYwKkaHYvBBaA74ZFNQ9x28cfPT9QFRTHoGNho8=;
 b=Ez/C9PzhB/8DGO4mNfZTxjbGJExUJ10XElYa8DUTOs1IKiYbYVDE9MGV
 3ukfE5+C3/dUy+7HOFxaEgsm6xVmBI+e0LLNiNR19BFbEvgH8f2/sHOuh
 xUEKmKnDUU5c/y+Du+Bt+ZQTi0ahg6buGsavbgbZdnoTZJI0cvaYIeOkM
 KGHIKJfxtTJJum/xUILve/sytN3QUx7F6GN1TVADF2b9L7fA2L6vooSlu
 qmJ839z5MmQDuMtjE1QDvD0yY9qb/cHjTsbv6p4Y/veUrH6LEkpb/Ytor
 hi2o7vkA+uLQH1VFvrotGGunx1dYMh4WEEPKKRT54E9j1Tm52wJUjx5ff g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96804204"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96804204"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:21:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvWGc/GsiadgS5Er8CLRC49uYPsuhpMyTjg8uCJOXD2M18WGgHUqr+cfwhEIhlNorzgJhLJ65H6fo7y33FPL10kD9eMX/g5NXPMCbE3FwwZUJRg6s+lgRaCrfq8gNXwk5ldN502c8h70AqpUD8FMECA7mGXyNQs1MvN8JpOVH78g4aV0HX2Mtj8C5wrELmisKX2KliScE/lx90Ok8f3Ut06lq/Ba538hgOrhcVA8CMPPKYQr2KsY8SliReoBjN0jawXUDRqAIcNHt3TIle4M/JwkdbkIcpYs0j1V6X2cV8goe9nLi2AHDxBPf9uBnb0J/JQTPrn4o1EBz1ALd0Sbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKveDYwKkaHYvBBaA74ZFNQ9x28cfPT9QFRTHoGNho8=;
 b=MKIy8DacanbnH7JxPOct0dI9BKO2Z1umFfCuH/auz+HY18710YZF6tSAazYxj3VwabOz2tuThPjLW5oG5Lme5+fO34tJ3X09Pa1Zj6FLwTXqD3FJoJjkpm/EGBRJ7HrjHH4OPMrsyYG+FOal2FxKec2U0ZwbVOcbwCn/eGwVJ/Z9YC0QSlJE0mHLdBxw5ISMZIgNG1uuKdVKdgBCM+yAZj3MGmpG2NFaBFPMxRsuOwr7Y7Zz/rDj0zRV2xP19boQYDBZogMHCjjSvyhZnnhgH8WCgn7ODUc7Fe3CcGp04tWvjnCZ/Es8/Aw3AT0vGfoPSXEH1oUUIHmW6YepSVEhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11375.jpnprd01.prod.outlook.com (2603:1096:400:3c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:21:36 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:21:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 49/52] migration/rdma: Silence
 qemu_rdma_register_and_get_keys()
Thread-Topic: [PATCH 49/52] migration/rdma: Silence
 qemu_rdma_register_and_get_keys()
Thread-Index: AQHZ6j94GJLavM527U+VFURXxWal7rAsruUA
Date: Tue, 26 Sep 2023 06:21:35 +0000
Message-ID: <a82ce7ee-b008-57dc-352d-932ace4b7287@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-50-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-50-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11375:EE_
x-ms-office365-filtering-correlation-id: 4249bcd7-0e1f-47c2-a79b-08dbbe58d5e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tq5EdxmmvjRdBxogR6CnOtWL7I1z8r1YaruGgSc8dtdh2gygrXJ/4NqPiaaX0K9U54i/wbwj08ZKozZgZVOIRtXjrSP60y1/5Q631djNiJ/sGTjfAFfqMQgRRjkmKYvfGu+2WQW3p+QjS2S4quqgzX9EgcVCJ3Y94VEZt+T0c1ms+lgPWoJvEF+ewaejka/TmGpZmQmgPdG4M3RpLxewEoF15mZt8qnmbXoQrsnOsQo1puFZzXXi7XZDU8H6C5kvAPNC6rtkhsVSnlh5dMDx89cClSieliNI5XyW0YriqIdMhYTYvyK0DisRXSrZtums038B3I7nJgZt4HuTWgX5qvNJ1nvrz7J3Y7lTqZKA1N1GLzykzCpTrjP+oJepbK14BmnuqeAtQngAqBjtxmO9TWf652/8EYvU3eg7DBCXoqocBgWlttrJv+6ep9cBo7m2uUeraDWQSLXOfXz7F/b+fOWxuaGRKCyUuGYynLFL5wiHi9HI6mGpizVCTF0mRAyK0D5bIEZcwx0xtx22zQTOjLu8IH+Tl8uQ1+nVLhIRrvkYKZBziqpjqX4WzOPLDPOxnKgiQxx4HhDxdgDydCxvA46JIkiN6e4srCDxjchACerQ9CfwxH0eh0PoJjp/JIcfh85iizY0rj44Qj/N8l5pjBQARyJqbqen2154kHx4E/8fmk4Rb7B8M9nGrV5GJ45+nRdXoa5PcOk39UYxXaZ34g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(1590799021)(1580799018)(83380400001)(5660300002)(26005)(8936002)(8676002)(4326008)(66556008)(316002)(478600001)(41300700001)(66446008)(66946007)(110136005)(91956017)(64756008)(54906003)(76116006)(6486002)(66476007)(53546011)(2906002)(2616005)(71200400001)(6506007)(6512007)(86362001)(31696002)(85182001)(36756003)(82960400001)(38070700005)(38100700002)(122000001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2VYanJzOERNVmhselJsVjlsUTJwNDRqeWNMUmV2dno2MUJFcnNCQkVRWEl1?=
 =?utf-8?B?QUg2SkY3RkZDL21RMTl1Y0dlYW52cjFLM0ZJMGRvZ2ltc2xBUzNVajRISXNt?=
 =?utf-8?B?VzRFeVAwVExTRkkvMTFtVTJUQ2kwV0h6STM0dVd2RUpidERrWFNrSExZbzNs?=
 =?utf-8?B?OTBERTdXeUlINklxVDlxS0ZpZzNvNTk2VGp1U1M5UXVzVW43cFN4andQMGRk?=
 =?utf-8?B?bkpqWHVzb1RPdTREMzRZdnd5MmM3YmgvcHFwOHd4RzgwN0hkMzAyeTdmK0xm?=
 =?utf-8?B?ZGtsb1lYM2UzaGtwbEtSQ2hvdzFXQ2thVFVBanh5ZFhRbWh4a0dPcGVFWSth?=
 =?utf-8?B?VkV2eFBkWERrKzFWNmN4SFVDYzM2WFJPNUhSOFJ6eG90VkE4ZkZvcW1wL3Nk?=
 =?utf-8?B?eWhXUlZLejRqS2sra0NraHkxVW1pTXVHcVhZYURXTEovWTZ3ZDhUcDFCbHhv?=
 =?utf-8?B?MlFCbmp4cE84TC9YL3E4TlVnejI2S3VDVHBxa3p5OW1vUUQ2N2RnSTFhSFI3?=
 =?utf-8?B?NjJGYjVDaXhpSG05cUV5cTYyVExxVk9QNmI2djM5ZmxYamYxUUhWSENxcHc4?=
 =?utf-8?B?UURsSFQvSWltbWxwRm1vYXVCZGp4STVnY3YzUFc1UFg0aDlqd3JNOUdybEs4?=
 =?utf-8?B?L2ZqSFVDVHFMeThIaTgyZ1krUGtIKzA4Z0tOSWgrZExvYVdLVmdwbUFLdEVz?=
 =?utf-8?B?dGRRWWg4RVJFdWdaVklBRGg3emwxZ2ppSEl2MXd1TXFrM212NWtvZCt3UkVU?=
 =?utf-8?B?Tm9ta1R6cTZSTWI1R1FLWThTMFU4SHJBaVEwcmVIRVowQUhGalJBUHo2Z1I4?=
 =?utf-8?B?NHlKaUtZMFltQlRRVzZtUjVUQ2ZnOG5RT2xGUjI3SkdkNGhmbEFwQWJ2SzN0?=
 =?utf-8?B?OGl0V3dOWDhTamZIY2UyT2ZscnFGTlhJRFM1SnhNUTFlcUx0S3J2NjIzZ2sx?=
 =?utf-8?B?bWZyYXhuRE44SzNxaTJhNGRvMm10d2NtTnc2VVFLK05aeG9PMWxkV2s5amZP?=
 =?utf-8?B?VGV0WVZHc2N0TUJSMkpNTDVyVWRqQWUvc3VyNGw2cWpYRkthMUpSbFBlWitB?=
 =?utf-8?B?T2RuY1dWejNrTVpwWlNYSnBDWk5GRkhsQ0xjOGpPOWVZTEMySWF5bm1MTlVz?=
 =?utf-8?B?aHlvZVBTRm1OOFdtemVwVklZNDJXN1phUUtSTFBpVTRRTmJoSmlKUVErZmk2?=
 =?utf-8?B?elZGY0Y4bXcvQnVaaEFTR3E0OXUxbjFabEcyV29HUGNYU29YT1VuVUdPcjl5?=
 =?utf-8?B?V1UzMHhWNjRwYnpVeDl4TlZwV3B4bUc5Ky82akJoa2xORGdGRldoMTgyRWxa?=
 =?utf-8?B?clZWc3VidEpxUW9FSWNhZk8xcUI0WXZvOXkxZWZSRjMxU0NnOEhxQXFudFN5?=
 =?utf-8?B?b2k1SVdjYzBEMFVuYXRhM2NueEZoYURHU0xvb2ZnNUlTUllzdmlMZWdqTWdk?=
 =?utf-8?B?TldmU3FJOGNMQmdQNHFBNDlOMEdTTzQrRG02NFE4MTI3TzhMbFlvUVVKOHZM?=
 =?utf-8?B?WHpCVWovM2pHN3RQeHUxQ1lOMVlOWit3WmMzVE4yWFdqU3FDWTBZV0M4cjJW?=
 =?utf-8?B?dmNnVmQvOGZPVUFzcHJsVTJWb1N4b3FTRzEvbDVmbS9LVnFiT0dQQ2M1RHM4?=
 =?utf-8?B?di9jUS94Z2lvTjhmaDZDQUpsbER2bkc3RGY3TnR2UUFyZDF4akFQaHZSemFZ?=
 =?utf-8?B?Tm91dzBmdnBSNHNMSDNTbS95eFlEd05Hc0pIOGowS0p2YkZKTk1mMlRhTStu?=
 =?utf-8?B?RzdDQmJwTlNZMnJxVEQ0Y0tjVUpuMktHZHp4TmVnWWJPa014bWdWdnlQd0xN?=
 =?utf-8?B?c0o2RXdHZk4vbGtKN3p2UmlWUmtuRlE5ZE1EMm8zVDk1cCtjaFNBbmFJNkdX?=
 =?utf-8?B?UElPYzRyOXBjckJ0bUJCRE9XS05rUEoyWWEwd3NEYlJXczFpa3hRVEpCZUVr?=
 =?utf-8?B?c3A3cFFSV25HTWRrd0RDWjNmVGFUYUJMMjFiZ3RpeENvQzRkWVAzOFk4SXNV?=
 =?utf-8?B?VWpXU1pJRjJTbmQzMGswVWR0SXdZR1lMM291bXJuQ01OczR6NVhKZlpDYUM0?=
 =?utf-8?B?eGpVNDlteXhOSEZPZkk3ejZIa2xQT3ZzNGNweUEwU0orQWZabkppS0NvRzlF?=
 =?utf-8?B?K0ZRZTNLMlljckExaVUwclVhYklXLzJoNFZlQ2lMNytST1ZRN3ZoN0pVZzZC?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBF3BA8B8512174FA6412C81E4F0E472@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VuaakoFpQCqtSEV4B3Kx4TCyytaO5cVXOzPYE7LtsFESAf80X4178x9f6M6yJQ52Y6iS2DmObrbUD53UjH6psyXZ9EF/ewRgww5KqXfnYXQEfMofh68WZTeyt+PPWk9hUb38kznFHn+7r+1wV9GpHawfxOkUZHaVAZVxkHwVhRiMlx+52XddG/aQjIN6tLwI86RGbiXIK9xJHF0xCktAIR3Em6Y64AYn14UCjwEiSE80wPWZP+JkyqL2HWoax1+kQtaYmr61bzng+aD8O5VbA9yccWqdlorCPWtn2aKJ3jGNjrVs130E0XpW3RKuoo6m6x4GiCExjCf0+CLq5uvimvTQxie91zJlu+X/LF6UePC74wblA+n1CqHfH1bNgalzGxjJIlvl3KO3z3P4n8STflxCYI1FFdkLIULCl1NDTvR+GUVV/IoB/YYn511+Ifq8llFiWtpDf8roTvMg/0vtjsS3ZX6CRLkVY719SYfCCpnsSS2YsUuk9TX6ialpZlRFtFsiD54goZ+qRS81mfjw/T8VYX1cArIJQIvX7LLD3MIW72aZxPwHQKSVN72UXTqLqCE2dfVowvqa7Wqocymd88ulI5R1DI4bvYKoh1qDS6S8RhcGtjCUjQJy9SmrWEJrj+i4Ij5MEj3k7NCZSEPzuyH+rkhMsItsCs5CF6lfY8nNQBYrRdfGEdEsylfozVeEiwewBlUEiju6Nakfv8tGGjloXskh6DFogkide6N7xeDzW2jVOZHqnq+XnaDCTQ6bkHcDFUU8Dg1F4MgZcxmTiGtwQqk7WnDe0Ydvtz3rnBc=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4249bcd7-0e1f-47c2-a79b-08dbbe58d5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:21:35.8158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37GCuI2TkDVwfKbD4mjyr4jKGoFvjVHyxz2CE2q2FhzDgsXCdgwLHscOA59dnemk2KnfrgUl36L7yrIEJ9ClEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11375
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfd3JpdGVfb25lKCkg
dmlvbGF0ZXMgdGhpcyBwcmluY2lwbGU6IGl0IHJlcG9ydHMgZXJyb3JzIHRvDQo+IHN0ZGVyciB2
aWEgcWVtdV9yZG1hX3JlZ2lzdGVyX2FuZF9nZXRfa2V5cygpLiAgSSBlbGVjdGVkIG5vdCB0bw0K
PiBpbnZlc3RpZ2F0ZSBob3cgY2FsbGVycyBoYW5kbGUgdGhlIGVycm9yLCBpLmUuIHByZWNpc2Ug
aW1wYWN0IGlzIG5vdA0KPiBrbm93bi4NCj4gDQo+IENsZWFuIHRoaXMgdXA6IHNpbGVuY2UgcWVt
dV9yZG1hX3JlZ2lzdGVyX2FuZF9nZXRfa2V5cygpLiAgSSBiZWxpZXZlDQo+IHRoZSBjYWxsZXIn
cyBlcnJvciByZXBvcnRzIHN1ZmZpY2UuICBJZiB0aGV5IGRvbid0LCB3ZSBuZWVkIHRvIGNvbnZl
cnQNCj4gdG8gRXJyb3IgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1i
cnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8
IDkgLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXgg
OTlkY2NkZWFlNS4uZDlmODBlZjM5MCAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0K
PiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0xMzE0LDE1ICsxMzE0LDYgQEAgc3RhdGlj
IGludCBxZW11X3JkbWFfcmVnaXN0ZXJfYW5kX2dldF9rZXlzKFJETUFDb250ZXh0ICpyZG1hLA0K
PiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+ICAgICAgIGlmICghYmxvY2stPnBtcltjaHVua10p
IHsNCj4gLSAgICAgICAgcGVycm9yKCJGYWlsZWQgdG8gcmVnaXN0ZXIgY2h1bmshIik7DQo+IC0g
ICAgICAgIGZwcmludGYoc3RkZXJyLCAiQ2h1bmsgZGV0YWlsczogYmxvY2s6ICVkIGNodW5rIGlu
ZGV4ICVkIg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgIiBzdGFydCAlIiBQUkl1UFRSICIg
ZW5kICUiIFBSSXVQVFINCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICIgaG9zdCAlIiBQUkl1
UFRSDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAiIGxvY2FsICUiIFBSSXVQVFIgIiByZWdp
c3RyYXRpb25zOiAlZFxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIGJsb2NrLT5pbmRl
eCwgY2h1bmssICh1aW50cHRyX3QpY2h1bmtfc3RhcnQsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAodWludHB0cl90KWNodW5rX2VuZCwgaG9zdF9hZGRyLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgKHVpbnRwdHJfdClibG9jay0+bG9jYWxfaG9zdF9hZGRyLA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgcmRtYS0+dG90YWxfcmVnaXN0cmF0aW9ucyk7DQo+ICAgICAgICAgICBy
ZXR1cm4gLTE7DQo+ICAgICAgIH0NCj4gICAgICAgcmRtYS0+dG90YWxfcmVnaXN0cmF0aW9ucysr
Ow==

