Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5967BC485
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 05:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoyRS-0002yW-Pa; Fri, 06 Oct 2023 23:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyRQ-0002tJ-9e
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:57:24 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyRL-0005vx-0D
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696651039; x=1728187039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SbiKfhiO0UVXu1kBSN4Fy7hS2FzYNboyoZ4HLjIRMwQ=;
 b=QBZB65H4Klc0TlkNF3xrmjQOM1muXSWBAD8sFDUqswlHO9/sYhejMXd8
 wLrcvS97QuAV6WosGW25tQ9XCUJL+zNuEr23AdIYyUEB/1VWIDgomHFa6
 0EqD+X6s8NHL2OqVMgIzjfQSzh6Y1M7YnK7hD4Hxj1QubF8+xkgrGOe65
 lVet6Qz2Igd13s49q7ptrcRrWUZKGFHFAX8TZ3hIbCyxKhiRZ1PmOFWyY
 yynC5fgqXw2CO4TvieyTLffJJ2AtO8jXjvlDqWaIY5dSgyfxso+PiwpYT
 4E96p5F17GdtlX5/HR4uXn3V2sNlrusgUsqmtrLN1TPVX1x5MdGuLLIk5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="97909258"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; d="scan'208";a="97909258"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 12:57:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHsYflgaeYTDgMcixkluDgZWgd6w2x3nzhjDf02Xe5mCz4mhl4qxYfovMIrBfrhwhHQ0l32UVIQ0HpRL1y8MZ+VHs6VsGTDZ1PIbM58IX5wIlMtDSYUqSlGYXvFplBg1DPg/um00Db2ZF1uDRCDFq4+j0BMJDLCE8ywlvPBtw/uYQU1Gq15M+Hk+0hmjYvKgL8bqOdD60L+EjOtbx6WSRcfaqjwteKT8dbXDyAmmfvtO+axQlIksGHqkJzq9IN58rJ5VqLn9CI6jQnBG3bDKS5MWlT2mq+V3q7Zwqhq66HIB1YBkRvufLaUknED4V/BcVl16rV91sdbTDcrvCAhUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbiKfhiO0UVXu1kBSN4Fy7hS2FzYNboyoZ4HLjIRMwQ=;
 b=c7sokBx+/jKsvRivkV4n8LRHR9NEGX09w1qd13J16VgT+LxHibZbr38CiFYe0tZyugSP/HpJZLGlcHA8oklxRSrWYMIZE1bzF2sbbXQeydAycymJPcyOP+Hu8QiTIAMnhS+vADns7cIDYD1gMcQyPtzw1JOTXcFa23RniIAQpKcZqH8f19uzxHJRo458h5GYp5ISYN05YSeZ8HEtD7vR9xMVxmad+YS1caL7S3GAqQGI41lV+ryJMkn0lO6bF/gjFYMLYmxjyeliL9C5PEc+I9TWGBNKMzE7CVz/0MgF0yvhNtZZGYZX/x8DYOSiOH6NvbOjftmqZq3Bltmxcf2WNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB9850.jpnprd01.prod.outlook.com (2603:1096:604:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 03:57:11 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 03:57:11 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 53/53] migration/rdma: Replace flawed device detail
 dump by tracing
Thread-Topic: [PATCH v2 53/53] migration/rdma: Replace flawed device detail
 dump by tracing
Thread-Index: AQHZ8g/w6rgRrUq5ckCOir2WrgiIdbA9wJEA
Date: Sat, 7 Oct 2023 03:57:11 +0000
Message-ID: <0a8176e7-1ff4-0acf-69d5-ae6a8cc4ecce@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-54-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-54-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB9850:EE_
x-ms-office365-filtering-correlation-id: 3fbc7fd8-5b04-4b25-afe2-08dbc6e97c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncfwAFC1LYmFXCGmw/7tpRbH047m5CZRKcWKVWXqTrs8qqphpN78lTDYeiApVtENkIHsmeQd8rzPuUMAsj26BOAP/LnK2Oqu4Ytp4GCLKc4L33qFEr7OYAweZtmuyKKr/DL+34QxqEHUKqUrdA0AUb040N+W4audiMh0m698AstF2Q8G4qZ60nY3kVr7NSKtDaC8ZC5dcdjIw9A3i8PaD55W8v1PBdlyvbKY3+WibKx37lSghS+KzSKcRC19VQwbT+G7AZTBoL7mQsO0+S/w/xnl9qGugSVb841El8KAyfzz7n1ilVIKpLopGOejBevhMkclFbkU3dbjQmPvNSoXqYp/SB/lehW6/2UZDA3rBLjY6pnaVuLknT6iMjS4z2rGkQfMAkEyCCJWzKs/AxbF+b4L5EDDL6W7HA7d8d54JzK8YYIwINQLicCQoqi7F3kY7W280L/pZx6YmaUes41y56sbFCpEEuXqNebMA6crvOb1eNE8lPpwSV255Q4xzWRXMwF4ue54N65pRPL7NTzMra21mVWxKMDEJpS45Xf4Pi+ClVWvlx4KFsHx9F5WNkQlOUvOpXuZedYdj3KZ0eCQAuzuA9Pun/nH+8D2RM35J4W2wOuxh6Xapv/4BfuhuHSwF9RGR+9j2GJaCt1JX278/USPxmHaByBoATpfShBTzigRGUZuJlF1IyLWsgqE24WEWPM8fYsT15UUVqm41ViJUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(1590799021)(64100799003)(1800799009)(186009)(85182001)(1580799018)(36756003)(82960400001)(6506007)(53546011)(2616005)(122000001)(26005)(6512007)(91956017)(66476007)(54906003)(316002)(76116006)(64756008)(66946007)(66556008)(66446008)(6486002)(71200400001)(38100700002)(38070700005)(110136005)(41300700001)(478600001)(83380400001)(86362001)(31686004)(31696002)(8936002)(2906002)(4326008)(5660300002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1U1bUcrdkg3cFdha1R3NXVzVEF5ZWpaL3FxQzZGMVQ3cDNST25YeWR3UktD?=
 =?utf-8?B?dHFTanZOZmd3c2wyc283VFp0aGVmMUlmaXg1Vlh1UkNWSnAyUFg5NGM3S2Iv?=
 =?utf-8?B?Z1VVM0pJMTh1RVZZOHdRTWYyb1Y1TkFiWlFMUzV3RGtuWStlL1R1ZXJVdVBF?=
 =?utf-8?B?blRIL1NmT0s2RzNVZ2tLajAxVmc3NGJxQjhUUFpIb09iWG1VY0xQcThYdTBr?=
 =?utf-8?B?TDViK1Y5YktQVFNHaEFjUzU5eHlnRWdFYWV1cjVoMjZic1dnRjVKN21hSmto?=
 =?utf-8?B?cEtxU2V2V1NJUkJKOVhkVm5ZL2JvWU9FdWNjUmc3VU5EbVFGNkpaNVQrcmNR?=
 =?utf-8?B?cFRjZ0c3QjkvYmJTSzVZWlA3TzI2MXNtNjBFYk1YYVpBMFlYeVNmZklRZU0x?=
 =?utf-8?B?cmlEUlZ1Z1NRdE5oRmxQb1NESU1Ic2Jtc1I2MnhUam5QamZCNHMwRUl5bVFa?=
 =?utf-8?B?N1owR2N6ZHd6UzJ1Z1ZDam1ydjNRbm9xMVBCK29oNUJ4bFR5TzVoZno1b2RI?=
 =?utf-8?B?L2daZGt2YVFhbmZYaEZQTGNkNVZob0ZCV2FNK3RldEI4R3E3U29HbktEK3lC?=
 =?utf-8?B?Zm5PQmJzMXhjYnR0bjlmMHJXRWdkK2N6RDNUTGN2MFJXalhON2lQRUFpeWtr?=
 =?utf-8?B?TkZvdUpvazZ0aW5INDJ5NGJYeGNsOWtuZzZqTmVOZDNhU1lGcEJTc0doZGIw?=
 =?utf-8?B?Q3hKNmIvcGFUYXlNWE03bFBremdEZ0FYWkhRTjJnK0MyNW9oUFFQcHVFa0VD?=
 =?utf-8?B?TStFZDNXTEk1LytIV2dGVGpZY0N0dFN5ZjY0Sys1dThkeXhYbGdYQUNQYjBY?=
 =?utf-8?B?OHI2SkV0TCt4dWEzSkVVTGt5OUF4dGdUSEVGUThWQnVydnoxN2RNbEZTQlVJ?=
 =?utf-8?B?MFRZaUpsTlplUlZ6Y09CbTduWUE2UUcxOGpjTHgyeEdyZ01VK3FQY2t4UHVN?=
 =?utf-8?B?Vys3V2MxRm9IZElZd3ZERmpZeHViUDk1TEFMeHdma0NUeE13S1F2Z1cwVHF5?=
 =?utf-8?B?L3U5U0Eza043K3FWeDgveFR0TFdZc1IyUGtYd2hVanNtQ0daQ2V6aWlmOHV6?=
 =?utf-8?B?SnU3V0FnNTc1V0gyUGFFNUthamhRRFlaV1JmSWdIckg0ZjNQTlJxcjFZT0x1?=
 =?utf-8?B?Z1dTUWIzOGxpLzlsSUZ1blIyNzlrWjdQOUgvcW1DaWRtNzIwNk5uN0VNQWpu?=
 =?utf-8?B?UEFyMGQxdWk2cnlNR2IxekcrdWtkOW40dTVRZGxWdGF2MjFjNy9veHl3L1ZX?=
 =?utf-8?B?NVBWSlZQTWdtbGdVbnBqOGhkUFZ6WHBZUStvSVNvL2NiRkxQZDBZanJ2WUNu?=
 =?utf-8?B?QmRib2JvWU9ZUFBpdE1vSlZLeUZtZWlHLzRtVWw2NThpNFdnTHBOS1lwdGU1?=
 =?utf-8?B?dFhlQUIvTDMwL0dHTE1aK05idk5xUVlVZGVFY0hxUWFBSmdJU25aSXRxWnpm?=
 =?utf-8?B?cTluVG5aM2RyKzFma1U2aWdhdzZ5WVptdHEwa0ZVTFdtR0lJQlBTTHpOQldW?=
 =?utf-8?B?T2QvZmNMV1NuYkR0eEFISlZhUUNVZ3dyd004K2ZQaHFoSThObXZuM1BJNHds?=
 =?utf-8?B?UjJyWW5ra3ZuemdOWmdXZUhQcHFwUVRYS3J3MkxaSnBjYnJ3clhQVUdzSlBK?=
 =?utf-8?B?RGpDMG84azVLRTRudXE0T25vc2xVWHpPM0dVVndoeEQwWExuelhDY3BCZlA2?=
 =?utf-8?B?Qjc1RTAzTTVtMkRTSGZxbjIyTTVWUTVMUy9kSFZackowYkRVeHZYeld5YmtM?=
 =?utf-8?B?eTVmdmVPZm95emlMRHVVNHovUXRCczFYbkJSNXpuWmpHN2xUaEUzdDZPSlZ6?=
 =?utf-8?B?Z2c4bjd1OVkxRW5BNlNTQUtDUzNBWHBWOXdNMzVmZit5M2F0cE1NZmhUN0Uz?=
 =?utf-8?B?THdwb1dQbkozQU9tcUFxNTZPcHB1dTY4UDJpdVhCUGJwNWYrZkx3SFVoWnZT?=
 =?utf-8?B?RDNueUgrS3Q0VUovS1ljeElNU3JNTkdwUUhrdjNCMm1OWS9rakhIZ0p1RGtu?=
 =?utf-8?B?K09RSStyamxydWg2WlpXUnNtTkdldFhISnRSdEo1dzlTM3BFWWErWUtnSWZy?=
 =?utf-8?B?RC9qYjFxTVNDT2lETExiRHZFSjkwQzE2R3ZDdEttVWdCVldaekdOTWU0OFpE?=
 =?utf-8?B?QncvK25zcm0xUkVKQUNCb0NNNzRnZnErcFRKV0lSOXA4ZlUzaWYvUGdVZlpk?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AC1EB24BD295B4F93E3AE768D56465D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y0zdNWQOo9QjHg+bvCF2+FVi1S0pVTc5noKoMcY7WaLTflsNERBpMCakxibCLKRQxRsauuCiNigPm+iRbBAPIh4xycrmacePbEBtMfyLvV0iC9KrLHlbOp4ODxSqPCg4VQ8mwMt5yKzYq18iTaAGrRwmo4yJQ0bpjVuhby1t+TRccJTHjIcsVi+5YMh3yVilZTFF2cwk8RSxg6CRpd1dovrNEMDnt+P1EwB5rXsicxveaSQRyiqN0rAUeChh9l/JXM80Tj8C0OASXlvIkM+SXS9+IxKUnEdXfBomIefB8zERmWUWz0SUQNqzucp4Hhwq3OSFfvFQDEx9U3zgLrLtZKl5JI4sTX0zZRa7VjF+DrBigiCcFEe74bAmFtv3yAeh/KJKWuFVsAjqZsMJjhZ7iln2csqIhD7GsQtuPoWra2aLQ3wUvCn+pLhszDx79YZMI/DoejHgA5wIzoyTVAb3yjywk91oVh8+2diBJasjVFOqKzykis4Vbr37vXQOqP/wu1rsxjoEWgNLE9N7BuMvyzpjWGGCPuWhHQ4ElOMy8A2xeKsSvZdEUeVEuWU6iacQPlz7v6MuMMvUR2In+j/WEmBpBiAA/RViR3IXdvqwTGrbmqAoPTNNhi5frEskDQuEziRLHbr2pp2zxdw0SaewOyt9umeIQHeIonzI5MpqM2M4+7vVUXxzKUDzt5VDkpW6n1jLuMkOFoRIWbiushX0j+Ah0nMROiw4HnyIiV9EQPqdVapFmVp4rsHXEMbRMNo4mILRkljwzvIeYzWjoTfMRzE1kE2ULZlyvZt3EJdqME/9ax3D8jdVXzBgHSifIc6P
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc7fd8-5b04-4b25-afe2-08dbc6e97c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 03:57:11.7245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3jDsmHF2ozWUnroBOkcGpXgdVJt5X3TDapvMirKV+BiNB1mDmk9K+sO8tal1zbyjiN09DisdMr6AWCj5K0oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9850
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MjAsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfZHVtcF9pZCgpIGR1bXBzIFJETUEgZGV2aWNlIGRldGFpbHMgdG8gc3Rkb3V0Lg0KPiAN
Cj4gcmRtYV9zdGFydF9vdXRnb2luZ19taWdyYXRpb24oKSBjYWxscyBpdCB2aWEgcWVtdV9yZG1h
X3NvdXJjZV9pbml0KCkNCj4gYW5kIHFlbXVfcmRtYV9yZXNvbHZlX2hvc3QoKSB0byBzaG93IHNv
dXJjZSBkZXZpY2UgZGV0YWlscy4NCj4gcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24oKSBh
cnJhbmdlcyBpdHMgY2FsbCB2aWENCj4gcmRtYV9hY2NlcHRfaW5jb21pbmdfbWlncmF0aW9uKCkg
YW5kIHFlbXVfcmRtYV9hY2NlcHQoKSB0byBzaG93DQo+IGRlc3RpbmF0aW9uIGRldmljZSBkZXRh
aWxzLg0KPiANCj4gVHdvIGlzc3VlczoNCj4gDQo+IDEuIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWln
cmF0aW9uKCkgY2FuIHJ1biBpbiBITVAgY29udGV4dC4gIFRoZQ0KPiAgICAgaW5mb3JtYXRpb24g
c2hvdWxkIGFyZ3VhYmx5IGdvIHRoZSBtb25pdG9yLCBub3Qgc3Rkb3V0Lg0KPiANCj4gMi4gaWJ2
X3F1ZXJ5X3BvcnQoKSBmYWlsdXJlIGlzIHJlcG9ydGVkIGFzIGVycm9yLiAgSXRzIGNhbGxlcnMg
cmVtYWluDQo+ICAgICB1bmF3YXJlIG9mIHRoaXMgZmFpbHVyZSAocWVtdV9yZG1hX2R1bXBfaWQo
KSBjYW4ndCBmYWlsKSwgc28NCj4gICAgIHJlcG9ydGluZyB0aGlzIHRvIHRoZSB1c2VyIGFzIGFu
IGVycm9yIGlzIHByb2JsZW1hdGljLg0KPiANCj4gRml4YWJsZSwgYnV0IHRoZSBkZXZpY2UgZGV0
YWlsIGR1bXAgaXMgbm9pc2UsIGV4Y2VwdCB3aGVuDQo+IHRyb3VibGVzaG9vdGluZy4gIFRyYWNp
bmcgaXMgYSBiZXR0ZXIgZml0LiAgU2ltaWxhciBmdW5jdGlvbg0KPiBxZW11X3JkbWFfZHVtcF9p
ZCgpIHdhcyBjb252ZXJ0ZWQgdG8gdHJhY2luZyBpbiBjb21taXQNCj4gNzMzMjUyZGViOGIgKFRy
YWNpZnkgbWlncmF0aW9uL3JkbWEuYykuDQo+IA0KPiBDb252ZXJ0IHFlbXVfcmRtYV9kdW1wX2lk
KCksIHRvby4NCj4gDQo+IFdoaWxlIHRoZXJlLCB0b3VjaCB1cCBxZW11X3JkbWFfZHVtcF9naWQo
KSdzIG91dGRhdGVkIGNvbW1lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1
c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jICAgICAg
IHwgMjMgKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICBtaWdyYXRpb24vdHJhY2UtZXZlbnRz
IHwgIDIgKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24v
cmRtYS5jDQo+IGluZGV4IGRiYTA4MDJmY2EuLjA3YWVmOWEwNzEgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtNzM0LDM4ICs3
MzQsMzEgQEAgc3RhdGljIHZvaWQgcmRtYV9kZWxldGVfYmxvY2soUkRNQUNvbnRleHQgKnJkbWEs
IFJETUFMb2NhbEJsb2NrICpibG9jaykNCj4gICB9DQo+ICAgDQo+ICAgLyoNCj4gLSAqIFB1dCBp
biB0aGUgbG9nIGZpbGUgd2hpY2ggUkRNQSBkZXZpY2Ugd2FzIG9wZW5lZCBhbmQgdGhlIGRldGFp
bHMNCj4gLSAqIGFzc29jaWF0ZWQgd2l0aCB0aGF0IGRldmljZS4NCj4gKyAqIFRyYWNlIFJETUEg
ZGV2aWNlIG9wZW4sIHdpdGggZGV2aWNlIGRldGFpbHMuDQo+ICAgICovDQo+ICAgc3RhdGljIHZv
aWQgcWVtdV9yZG1hX2R1bXBfaWQoY29uc3QgY2hhciAqd2hvLCBzdHJ1Y3QgaWJ2X2NvbnRleHQg
KnZlcmJzKQ0KPiAgIHsNCj4gICAgICAgc3RydWN0IGlidl9wb3J0X2F0dHIgcG9ydDsNCj4gICAN
Cj4gICAgICAgaWYgKGlidl9xdWVyeV9wb3J0KHZlcmJzLCAxLCAmcG9ydCkpIHsNCj4gLSAgICAg
ICAgZXJyb3JfcmVwb3J0KCJGYWlsZWQgdG8gcXVlcnkgcG9ydCBpbmZvcm1hdGlvbiIpOw0KPiAr
ICAgICAgICB0cmFjZV9xZW11X3JkbWFfZHVtcF9pZF9mYWlsZWQod2hvKTsNCj4gICAgICAgICAg
IHJldHVybjsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIHByaW50ZigiJXMgUkRNQSBEZXZpY2Ug
b3BlbmVkOiBrZXJuZWwgbmFtZSAlcyAiDQo+IC0gICAgICAgICAgICJ1dmVyYnMgZGV2aWNlIG5h
bWUgJXMsICINCj4gLSAgICAgICAgICAgImluZmluaWJhbmRfdmVyYnMgY2xhc3MgZGV2aWNlIHBh
dGggJXMsICINCj4gLSAgICAgICAgICAgImluZmluaWJhbmQgY2xhc3MgZGV2aWNlIHBhdGggJXMs
ICINCj4gLSAgICAgICAgICAgInRyYW5zcG9ydDogKCVkKSAlc1xuIiwNCj4gLSAgICAgICAgICAg
ICAgICB3aG8sDQo+ICsgICAgdHJhY2VfcWVtdV9yZG1hX2R1bXBfaWQod2hvLA0KPiAgICAgICAg
ICAgICAgICAgICB2ZXJicy0+ZGV2aWNlLT5uYW1lLA0KPiAgICAgICAgICAgICAgICAgICB2ZXJi
cy0+ZGV2aWNlLT5kZXZfbmFtZSwNCj4gICAgICAgICAgICAgICAgICAgdmVyYnMtPmRldmljZS0+
ZGV2X3BhdGgsDQo+ICAgICAgICAgICAgICAgICAgIHZlcmJzLT5kZXZpY2UtPmliZGV2X3BhdGgs
DQo+ICAgICAgICAgICAgICAgICAgIHBvcnQubGlua19sYXllciwNCj4gLSAgICAgICAgICAgICAg
ICAocG9ydC5saW5rX2xheWVyID09IElCVl9MSU5LX0xBWUVSX0lORklOSUJBTkQpID8gIkluZmlu
aWJhbmQiIDoNCj4gLSAgICAgICAgICAgICAgICAgKChwb3J0LmxpbmtfbGF5ZXIgPT0gSUJWX0xJ
TktfTEFZRVJfRVRIRVJORVQpDQo+IC0gICAgICAgICAgICAgICAgICAgID8gIkV0aGVybmV0IiA6
ICJVbmtub3duIikpOw0KPiArICAgICAgICAgICAgICAgIHBvcnQubGlua19sYXllciA9PSBJQlZf
TElOS19MQVlFUl9JTkZJTklCQU5EID8gIkluZmluaWJhbmQiDQo+ICsgICAgICAgICAgICAgICAg
OiBwb3J0LmxpbmtfbGF5ZXIgPT0gSUJWX0xJTktfTEFZRVJfRVRIRVJORVQgPyAiRXRoZXJuZXQi
DQo+ICsgICAgICAgICAgICAgICAgOiAiVW5rbm93biIpOw0KPiAgIH0NCj4gICANCj4gICAvKg0K
PiAtICogUHV0IGluIHRoZSBsb2cgZmlsZSB0aGUgUkRNQSBnaWQgYWRkcmVzc2luZyBpbmZvcm1h
dGlvbiwNCj4gLSAqIHVzZWZ1bCBmb3IgZm9sa3Mgd2hvIGhhdmUgdHJvdWJsZSB1bmRlcnN0YW5k
aW5nIHRoZQ0KPiAtICogUkRNQSBkZXZpY2UgaGllcmFyY2h5IGluIHRoZSBrZXJuZWwuDQo+ICsg
KiBUcmFjZSBSRE1BIGdpZCBhZGRyZXNzaW5nIGluZm9ybWF0aW9uLg0KPiArICogVXNlZnVsIGZv
ciB1bmRlcnN0YW5kaW5nIHRoZSBSRE1BIGRldmljZSBoaWVyYXJjaHkgaW4gdGhlIGtlcm5lbC4N
Cj4gICAgKi8NCj4gICBzdGF0aWMgdm9pZCBxZW11X3JkbWFfZHVtcF9naWQoY29uc3QgY2hhciAq
d2hvLCBzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQpDQo+ICAgew0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0
aW9uL3RyYWNlLWV2ZW50cyBiL21pZ3JhdGlvbi90cmFjZS1ldmVudHMNCj4gaW5kZXggZDczMzEw
N2VjNi4uNGNlMTZhZTg2NiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3RyYWNlLWV2ZW50cw0K
PiArKysgYi9taWdyYXRpb24vdHJhY2UtZXZlbnRzDQo+IEBAIC0yMTMsNiArMjEzLDggQEAgcWVt
dV9yZG1hX2Nsb3NlKHZvaWQpICIiDQo+ICAgcWVtdV9yZG1hX2Nvbm5lY3RfcGluX2FsbF9yZXF1
ZXN0ZWQodm9pZCkgIiINCj4gICBxZW11X3JkbWFfY29ubmVjdF9waW5fYWxsX291dGNvbWUoYm9v
bCBwaW4pICIlZCINCj4gICBxZW11X3JkbWFfZGVzdF9pbml0X3RyeWluZyhjb25zdCBjaGFyICpo
b3N0LCBjb25zdCBjaGFyICppcCkgIiVzID0+ICVzIg0KPiArcWVtdV9yZG1hX2R1bXBfaWRfZmFp
bGVkKGNvbnN0IGNoYXIgKndobykgIiVzIFJETUEgRGV2aWNlIG9wZW5lZCwgYnV0IGNhbid0IHF1
ZXJ5IHBvcnQgaW5mb3JtYXRpb24iDQo+ICtxZW11X3JkbWFfZHVtcF9pZChjb25zdCBjaGFyICp3
aG8sIGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKmRldl9uYW1lLCBjb25zdCBjaGFyICpk
ZXZfcGF0aCwgY29uc3QgY2hhciAqaWJkZXZfcGF0aCwgaW50IHRyYW5zcG9ydCwgY29uc3QgY2hh
ciAqdHJhbnNwb3J0X25hbWUpICIlcyBSRE1BIERldmljZSBvcGVuZWQ6IGtlcm5lbCBuYW1lICVz
IHV2ZXJicyBkZXZpY2UgbmFtZSAlcywgaW5maW5pYmFuZF92ZXJicyBjbGFzcyBkZXZpY2UgcGF0
aCAlcywgaW5maW5pYmFuZCBjbGFzcyBkZXZpY2UgcGF0aCAlcywgdHJhbnNwb3J0OiAoJWQpICVz
Ig0KPiAgIHFlbXVfcmRtYV9kdW1wX2dpZChjb25zdCBjaGFyICp3aG8sIGNvbnN0IGNoYXIgKnNy
YywgY29uc3QgY2hhciAqZHN0KSAiJXMgU291cmNlIEdJRDogJXMsIERlc3QgR0lEOiAlcyINCj4g
ICBxZW11X3JkbWFfZXhjaGFuZ2VfZ2V0X3Jlc3BvbnNlX3N0YXJ0KGNvbnN0IGNoYXIgKmRlc2Mp
ICJDT05UUk9MOiAlcyByZWNlaXZpbmcuLi4iDQo+ICAgcWVtdV9yZG1hX2V4Y2hhbmdlX2dldF9y
ZXNwb25zZV9ub25lKGNvbnN0IGNoYXIgKmRlc2MsIGludCB0eXBlKSAiU3VycHJpc2U6IGdvdCAl
cyAoJWQpIg==

