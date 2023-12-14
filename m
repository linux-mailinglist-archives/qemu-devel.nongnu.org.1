Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C48126FD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 06:36:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDeMq-0007ut-NY; Thu, 14 Dec 2023 00:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rDeMo-0007u7-CJ; Thu, 14 Dec 2023 00:34:38 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rDeMl-0008Um-Vh; Thu, 14 Dec 2023 00:34:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxgW6iJ1xgEJ44vs76W+oH4jNyXecycv57pJvjEg4GUOdPHyUZ1dIGsc1R+eP61hDN7O3ZK04zBTIVvJw5PhfJtwq+zehcf3F6KN1uan8ByfC1h26JeiDhBxTtqm3OkK3V8p7s0oUL+yXbFS7l9aSDLlUnojMFPtecx5bjH1MGTpxH55WMQoY61PmFZ1wJxJFrx0xdJg8gmw+7VZK/lIoFwDX7AL9dOVEwq8ATOL+qaVWtfua/TARqXMkl/iDYnjnUR2dMxScsvwNo8ADIi1dt3PeRQUC1QZOMAfvPapiqY5lOStb+njA6b0a1PWDDaaT0/o0HLWrv9uso9pp+mxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27AHVVbuvzxUyzw9x7WpFqtN5hg+6bOLcJX5/JcReYc=;
 b=QW3VEiP4LobIYrIODm6F8COhajb4j2R8/JDQ0QgDYvjunWniXALRuZgVsnq2DERRNbyqKJrKKmBQaDd2csKGNClJBPZ6YCiZliiNjQcVquO9QIjmy4BNJ+EwiYPOW7qNkk1KLJcQkeikqw2BNSF9HcEsEMCO4p0Mq9btwOfJXMTw3mxq88+jNOpJJwN32sWlbbmzhTR1Lcw3ktjPednQQdvgfVhObRmIx36ITR9xLhgKyLUvoFCLVVdJ0jMg/Zw9vP2YngvMyPv2UhEdGVno0cTzLwpLpJVJoBgYYP63IinLJxL41jaTX242gdY9eTtL5UK8lnCOOdKgy0uU0Kg1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27AHVVbuvzxUyzw9x7WpFqtN5hg+6bOLcJX5/JcReYc=;
 b=GQNJw2nklFz+2Hl1iTtbRkTcTuY1ubd4Y3Zzowr5TZ+BSEX73XXkUirzLteJ0qwx1pu2r/i5YTcDMKWtL8tzFdIpIe4BxFFk6WJb2yHRfj7+Bk33q7PcLBNQSeGyrbNMvqlzwBVBJe+Ps7uTTdL32MOydCbH4R4Kg6iZLgROt+I=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.38; Thu, 14 Dec 2023 05:34:28 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::dce:2e09:aabf:3480]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::dce:2e09:aabf:3480%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 05:34:28 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias
 <frasse.iglesias@gmail.com>, "saipavanboddu@gmail.com"
 <saipavanboddu@gmail.com>
Subject: RE: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Thread-Topic: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Thread-Index: AQHaLRovSk/ZpfCb/0OuUBG7WfHYdbCoQ+KA
Date: Thu, 14 Dec 2023 05:34:26 +0000
Message-ID: <DS7PR12MB57416A1D65C29AEDC712D2A9B68CA@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231205100802.2705561-1-sai.pavan.boddu@amd.com>
 <20231205100802.2705561-2-sai.pavan.boddu@amd.com>
 <CAFEAcA_gyAEs5PmTy6Edfep5HrwG6Prgij18MT1PeysV++=3Tw@mail.gmail.com>
In-Reply-To: <CAFEAcA_gyAEs5PmTy6Edfep5HrwG6Prgij18MT1PeysV++=3Tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|MN0PR12MB5714:EE_
x-ms-office365-filtering-correlation-id: eafbbe39-51c0-4546-7666-08dbfc665666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4E2ig7i4Cl8t2J+r56oARBALHSFIEZ7kEzbn+/TEvSSPWAex/KEbrqsKeNzZ342THzN2hrGNgIGOtnN5JqmedXqwdIRppEoM/EnzrkwFa2E+T+MdCrKwQRpFwL1v9uU8UjCu2IWfClXySN49lQOpx0TBlYdq7oobRzweXA3tjCiqLVKrJLvb2TCcoAlxqmK3oar2Wby0ycH4YbiRfbZ1Qjs7XgvUxy0SzB/7bkGmeW57TCgQR8ajxCvNqKMhz9M8cRTessl/xdoOhNtz3IT+cCjlqFaRm+CoMPzmBBqIaORL+LVlZExip45ADBHc3DfNtXFQnrgSCrwxJa2Hwj5HCtbqcNpOTk4PTfWR1h6u2OMXmmLtk7Y4p98at6LaUTKKEI2/WsMjFsPgqiUkowv9+IehpfJojXm0kqmBtU2IsMtrCLF9izhKmecbN/1tidv7UYIt0xw7B4/v/Hy7rDByTvuv6A9esxg+ehf5W4Eyk6n23eR5S7RyM3lr2gBaLY7OU72lScsoDHz+r28PQ7FNI2wIki9w8QlpBFkmXKP51yy/PJl+EcAEH75/+bFA/BLdpqKV5kpUTvOUUK8mztRskhYyKWMd5NxJ2iyas551FDN5O9mSiqZd6BYnwUGEwv0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(52536014)(122000001)(2906002)(38100700002)(55016003)(41300700001)(478600001)(86362001)(38070700009)(26005)(33656002)(6506007)(7696005)(71200400001)(9686003)(8936002)(8676002)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(76116006)(6916009)(4326008)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnFSVHFGTlZBTGtvMXAvU1VFUVYyNmpGQUxqUVpvaVNWR2F3MGRVVEpqN0FC?=
 =?utf-8?B?L25KR1E3R2hVZHNZV2pjS2tCVlBJNDhjV3JOOGRCbGZCTzBFUEs5d0tJVDlx?=
 =?utf-8?B?aWpGMWRvTXpoNlpvYmJBU1Yzc0JWb1QyUDkwTEF6N0VrMENpcXg3aUd4Q0tz?=
 =?utf-8?B?RzJKM2tpVlYvclAxRFRMb3FDYmlkVGVJZmlzMlVKVStUTHBDZWtFdURjZlJm?=
 =?utf-8?B?NmN0emdveXJIY3lodGZzdmxNVUlnVEpOMGo1dkgrTFdlV1l2WXJlR3d6T0E1?=
 =?utf-8?B?ZnVJVVJxeXFJU2NRalZ5NmNsLzFWV2g4cVdOeGlhR3NHMktlOXVYZVA0dHUv?=
 =?utf-8?B?NHNOQk5SL2lwSjlkK1hGcDZSTHZyQlNrdlN2L1oremJBYzNRSEJ5WWYzSklq?=
 =?utf-8?B?NGtJZnpXMkNOcGFrTEVIZ0krSU9CMHFNK1RhQkxVSXBNUEpNZXRJTi8xc2Vq?=
 =?utf-8?B?OGtHOE1XWDlYMlhMQWE3ZHh2YlVSdnozUXR1bWhXRXBOb0xRRXdqNzNwU1pZ?=
 =?utf-8?B?TXRvVW9lRTl4QmFkV3dZZnZmSWl3T2p5WWxsMDIyR2tJNkJjVWpRUDhvdEJq?=
 =?utf-8?B?UURSN1VhT3dBbHFPa1JLVzdZSWhsTUR0b2NlYTBKMzRZKysrMk1UaWtKb2JI?=
 =?utf-8?B?aElxQjZySDVyZ0ZCTGxUcGpadG4xV2JHV1Y5YVcvSW4rUEtxckdYL0pDVjFN?=
 =?utf-8?B?QzlCR3dlcW8vTXF6bFJyNnMxc09tUXNPY0duYnUvRExJcktib0RHYlFJNmN1?=
 =?utf-8?B?RnZLV3BiN1FTbVJlZXR4cXRKZE9UaU11WS9XN292eTJpNzA5TUZkOFIvUUZW?=
 =?utf-8?B?ZXJYZEZuNzRjbkZJUHR1cDU4ZHd3TVlNUXVXUFJGNHFZMW5zRUtlNTNoZW9M?=
 =?utf-8?B?MVlpTHozUFJDM2J0QStraGUwb2pIZnhWUmVvWDlSWGNjY3JuVzJtWW9wM0Rl?=
 =?utf-8?B?UHM4bFlkeGJsMEN4eWNiYXNmd2todzBJV2pQaWQyTk9LMnEyZ0dtYm5KTnFs?=
 =?utf-8?B?bzVnTzFZUVh2KzRxNG53MFB1NGlKRkFFejJTZXFJVnd5bUo2QlBoNDdzaDlz?=
 =?utf-8?B?SXBYNVVjcU13SU9ML3ExcTVQT3pYZ1VXQS9qZ3RsVnQwbEdtamxSdk1VWUlR?=
 =?utf-8?B?YjVvMmtqeXlvZGx5TTBTSUZKem1mSWsrL3laU0Y3OUJJWEJPVm1mL2V6MGVz?=
 =?utf-8?B?QkR1ekxLY0d2Yk1nUGNGZWptd3JrK2JrYVozNSsyMkdIdnVkUDZ5d2xCQ1VI?=
 =?utf-8?B?dmdVcVF3aHdMcGRZdStMUTdFaDJjTFUrMVdLcjhvR1RYekNmRTFXQ1V2L1pn?=
 =?utf-8?B?OVJSRXBvWm9RckN3WGtuZmlVR0t4aThCSndYVi9leDdEcERVbFo0N2lmQUd3?=
 =?utf-8?B?SktmNUVvVlk3em4wakJRUTRmVi9kU1NZVnRJYWNyNVNyL2JLQ3BEQW0xVG8x?=
 =?utf-8?B?Y2gvTWtjd05PcVFyTjAyRjNEY3h4U01VVzVnZVVxL2JVVUxXclJ1ZzZYMnBP?=
 =?utf-8?B?WFFoZWdNQmFZV3E0ODMwSFRzcDFJWWRtQ1h6ZlNDV3BRTXE0K2V6UDh1K1E2?=
 =?utf-8?B?eEg2Y1Fqa3RoMkxuL3RKb1J1QUFpM2JieUU5NVZpMnVtK3M3MzNvQ25WMGo5?=
 =?utf-8?B?SGJ5eW5CWUJzMGZHaHRHcVJBUDZqNlRPRlJJYjE3MEFGWTQyNTZiYmZZS0dU?=
 =?utf-8?B?dHdOOUtvNDJPSCtYUkMzYlY1MDlRYldyNWNrK3NwY09xQUlOb1FpaGZBNjlx?=
 =?utf-8?B?cGxQdDMzdm5sUzcyUVd4VnYxaXMwTFhIL3R3eGp4cFFPUTNtOHFmY3BETENh?=
 =?utf-8?B?RHZIZ3VUR0pzaGVpNm04WktLdFpVZTNZOUJFY01FanVwQlRuK3d3SlFTV2RS?=
 =?utf-8?B?ejB4RHQvT3NpaWRzRFE5K2ZRL2tJeUg3clhEZ2tGV1QwaVRHdEIwSXdlWkI0?=
 =?utf-8?B?Y3I5NzN0dXlQT1J3bGxtN0poa01TZHR6NXRnOFVXTnpBcU5UVHc0SGhvM3dU?=
 =?utf-8?B?MHQ1RU9HeHJXSlBxTWl0Sjl6a2UyYkhxOVNqSEg2QUpRbXNkc0UrNUZsUXBn?=
 =?utf-8?B?aTdLVFY1eWhEVFEvQlMxOERrRVYwUXhDMUlWZ3ZnZ3UybmlFZ1VRWnRBQ3Rw?=
 =?utf-8?Q?CstI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafbbe39-51c0-4546-7666-08dbfc665666
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 05:34:26.8960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTmTn/94P9qPe5zQywXFutMbo8tFMsWBnhH4XYhIYwp7nHCYqepQYkMxfUqc9KLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgUGV0ZXIsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBEZWNlbWJl
ciAxMiwgMjAyMyAxMDoxMiBQTQ0KPlRvOiBCb2RkdSwgU2FpIFBhdmFuIDxzYWkucGF2YW4uYm9k
ZHVAYW1kLmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LQ0KPmJsb2NrQG5vbmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
QGFsaXN0YWlyMjMubWU+OyBFZGdhciBFLiBJZ2xlc2lhcw0KPjxlZGdhci5pZ2xlc2lhc0BnbWFp
bC5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgRnJhbmNpc2NvDQo+SWdsZXNp
YXMgPGZyYXNzZS5pZ2xlc2lhc0BnbWFpbC5jb20+OyBzYWlwYXZhbmJvZGR1QGdtYWlsLmNvbQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSB4bG54LXZlcnNhbC1vc3BpOiBkaXNhYmxlIHJlZW50
cmFuY3kgZGV0ZWN0aW9uIGZvcg0KPmlvbWVtX2RhYw0KPg0KPk9uIFR1ZSwgNSBEZWMgMjAyMyBh
dCAxMDowOCwgU2FpIFBhdmFuIEJvZGR1IDxzYWkucGF2YW4uYm9kZHVAYW1kLmNvbT4NCj53cm90
ZToNCj4+DQo+PiBUaGUgT1NQSSBETUEgcmVhZHMgZmxhc2ggZGF0YSB0aHJvdWdoIHRoZSBPU1BJ
IGxpbmVhciBhZGRyZXNzIHNwYWNlDQo+PiAodGhlIGlvbWVtX2RhYyByZWdpb24pLCBiZWNhdXNl
IG9mIHRoaXMgdGhlIHJlZW50cmFuY3kgZ3VhcmQNCj4+IGludHJvZHVjZWQgaW4gY29tbWl0IGEy
ZTE3NTNiICgibWVtb3J5OiBwcmV2ZW50IGRtYS1yZWVudHJhY3kgaXNzdWVzIikNCj4+IGlzIGRp
c2FibGVkIGZvciB0aGUgbWVtb3J5IHJlZ2lvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTYWkg
UGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgaHcvc3Np
L3hsbngtdmVyc2FsLW9zcGkuYyB8IDEgKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9zc2kveGxueC12ZXJzYWwtb3NwaS5jIGIvaHcv
c3NpL3hsbngtdmVyc2FsLW9zcGkuYw0KPj4gaW5kZXggMWE2MTY3OWMyZi4uNTEyM2U3ZGRlNyAx
MDA2NDQNCj4+IC0tLSBhL2h3L3NzaS94bG54LXZlcnNhbC1vc3BpLmMNCj4+ICsrKyBiL2h3L3Nz
aS94bG54LXZlcnNhbC1vc3BpLmMNCj4+IEBAIC0xNzcyLDYgKzE3NzIsNyBAQCBzdGF0aWMgdm9p
ZCB4bG54X3ZlcnNhbF9vc3BpX2luaXQoT2JqZWN0ICpvYmopDQo+PiAgICAgIG1lbW9yeV9yZWdp
b25faW5pdF9pbygmcy0+aW9tZW1fZGFjLCBvYmosICZvc3BpX2RhY19vcHMsIHMsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1hJTElOWF9WRVJTQUxfT1NQSSAiLWRhYyIsIDB4
MjAwMDAwMDApOw0KPj4gICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtX2RhYyk7
DQo+PiArICAgIHMtPmlvbWVtX2RhYy5kaXNhYmxlX3JlZW50cmFuY3lfZ3VhcmQgPSB0cnVlOw0K
Pg0KPldoZXJlIHdlIHNldCB0aGlzIGZsYWcgd2Ugc2hvdWxkIGhhdmUgYSBjb21tZW50IGV4cGxh
aW5pbmcgd2h5IHdlIG5lZWQgdG8NCj5kbyBpdCwgcGxlYXNlLg0KW0JvZGR1LCBTYWkgUGF2YW5d
IFN1cmUsIEkgd2lsbCBzZW5kIGEgVjIgb24gdGhpcy4NCg0KUmVnYXJkcywNClNhaSBwYXZhbg0K
Pg0KPlBTOiBmb3IgYSBzaW5nbGUgcGF0Y2ggeW91IGRvbid0IG5lZWQgdG8gdXNlIGEgc2VwYXJh
dGUgY292ZXIgbGV0dGVyOyBjb3ZlciBsZXR0ZXJzDQo+YXJlIG9ubHkgbmVlZGVkIGZvciBtdWx0
aS1wYXRjaCBzZXJpZXMuDQo+DQo+dGhhbmtzDQo+LS0gUE1NDQo=

