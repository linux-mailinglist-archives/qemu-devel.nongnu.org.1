Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C396B7AE361
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:38:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkx0m-0003Ab-G2; Mon, 25 Sep 2023 21:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx0k-0003AG-1m
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:37:14 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx0h-0002GD-JY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695692232; x=1727228232;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WZrPaSSvsnTSnyPBcU/PvXSWZRZYbOWqnaRhAXVG6jM=;
 b=uPu946MfEVtt5lpnGHBIBMIklAlVijkrcg+Nx3hqcR5SJ/9nbsxUDnSN
 4TpitWaciqu8Cyavgs00g6+lZjuIMW6a8bjQx5XqT7K78krpR6YDGTv1w
 6pcSZ4ggZZr5u8kD53IkB7QLdLx2sd+17SHuX56UAKksssBKwZbY27w1o
 c3QUnKeU8/8yVfu4LJ2XdX9vdXxh9jGQ29QSypkD2wohJbJIB9Q6iCBiy
 gWFLN8zssD6mtCmAJikHIUZ6NmvNWbqBuIUq24Oot2BSXIwKwrRbDHqRI
 7CEONhcscKzq/Drmd5a2YZApxzXNui/3z8EflpBPejBP5bA2hg62GUa+A g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96849510"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; d="scan'208";a="96849510"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 10:37:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FycP76Eu3Y3gLQ+JZdXXyfnPtLemgaPQvLzfiO5+1yhNaCZO+GATas2uafLIh7GWdwD1fJC2Q6bAjL3mzqYFzG7HEMT3UmqnLs063LO5gdaQAkuUhbS6J8Q+yDD6eXb6j8G/CPfwXA+trJywD4Hz7xphI3FETXP1laOXMxLyT5Mpub16EkCFrPBfV37JZaMRWw2ElSXwJMWAnm1cy9dvxDxJWj53GAothA3qnMM58/9+U7oC0SnOj8a5MKrwFLfqrCpqFVPN2d+isMlkRszDntMSLNz+LIgcj6YGmYaOQ573ci2xd6jcy8Zm3c49LDFMXch4QXDUsqvNKsrQlL81JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZrPaSSvsnTSnyPBcU/PvXSWZRZYbOWqnaRhAXVG6jM=;
 b=N5Ou9yOfHgh6QM3v+KFcT8l8RpAGIaOjVrpu35Sf5QRCXkYQ3l/JzHMVIMNXsTCeLWkMiyD5WwqySEBUaAEPQi1NPhbtFJyOcpDjt1DZjDhz0lbvAj+WSOxlzXzrvPEjlRv6TsJ9swlXaJMayQ4DjM1ZIEyNMBl6qogB4H6QbsqEqaYJZMOnmakvLtJuJji/VwqgrH3igNaO4FiVCsAVbI6PUvA/nO7nOeJVMfRtYIv3lqir2AZp0bNkF3AuFvrhKjCRYMqqklOAWjGvGae9O4KafcCiYlJCP9ven9VGJhKFhOFMzLQNCY0d1uSIszOR4+mHWdrlWiKvQSi4Xo6yAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB9359.jpnprd01.prod.outlook.com (2603:1096:400:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:37:04 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:37:04 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 34/52] migration/rdma: Convert qemu_rdma_exchange_recv()
 to Error
Thread-Topic: [PATCH 34/52] migration/rdma: Convert qemu_rdma_exchange_recv()
 to Error
Thread-Index: AQHZ6j7IGhLf9wIyeE6Al345Vf1oPrAsX2aA
Date: Tue, 26 Sep 2023 01:37:04 +0000
Message-ID: <6c4534a4-ce54-05db-0f71-6229f0b3e161@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-35-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-35-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB9359:EE_
x-ms-office365-filtering-correlation-id: 48a7250c-ccdd-4687-202b-08dbbe311689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LK9GpoHMHJs4O/9lB0GbjYyvnMKIfLaETNyBg78WJwQVB6oCRy4m8cFdRj80aiZR8y1r5o0I1QqAAUS1FfmZPFYipAaKBhKcaiNiRrBuUz6AuWfBTqCJgCaw9oHPSJECcz8VXnaSDUw0/hk+1F/DA1av3Axfd/nC5shM/WSZq8Rq+nADoQ/bX7A2rk6P1d2kbjm8yEmhwZ5kY+r4zAkFIVATdJc6cFtNUhI9OkjZ4hKcnFO1SX/OqTa/8R4wmAufcsbSh3V2cRBIJyjJMwxOSk5fZ3BTz9C4KO73V3uI4H5y+QcKhmWkbg8P5BDLoT9ncEjmUFesdhk1gLGq1L1xtclk77NLOm/CyAqGcvDOeRpEP8BDWoA84e+iD2OoOf/SNkCj3HdeObXxxBCBga0hTxa8SQ7WWQBACW9jVKxYIHPQy+w9Xj7j4uVu30CBHtNjf/fSd4vSBEVOAUkn+QOzw+pkFW5nw8nz5MGLrmYWepD7WdDnNf+W+5h7K8x28OvvAhuwdz9k3xPgYTInwjIUyL8FbuApHzGDYu+br72qE8c1GfO8wirIBcNROjKOa7qBCuIBNbV+2ZXgh8nE0irDiDU/rkwItT6zvaOR19vZS5O5EpWUJPpVTEwX2Vc7yzYQFqKaSu+Al8XPARaSM4+Il1xeH8YJCQqcQO+GAHr+4jhQA+YHnvrIf69cJb2hre7vqSpcebW1+BxoGNffH/dNYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799009)(1590799021)(186009)(451199024)(1580799018)(6506007)(6512007)(26005)(71200400001)(82960400001)(66946007)(66556008)(66476007)(76116006)(64756008)(66446008)(53546011)(6486002)(31696002)(110136005)(91956017)(478600001)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(54906003)(2906002)(5660300002)(8936002)(8676002)(36756003)(2616005)(4326008)(85182001)(316002)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDY1U2RrbVd2ZnNLZWtJRU52bDZKa1RNMlFndUVFTzdEcndKUGtzZHRVZ00y?=
 =?utf-8?B?MmhMdS9UYkQrakdWU05xQkxlZEFacHdjSG1tUHM3blZzYkl6MzUxWFRSUEIr?=
 =?utf-8?B?d0lPMi96WWI0dGM0RlBrQXowbGp6U0NaSWE1WDV4OU5pcmk2RytkY2hMRk5Z?=
 =?utf-8?B?bVRob3Q4VG4vanJaS2I2Y3VlVUR0bkR2RjdkcmhGcHIveDZaV1c5VWZnL3Vn?=
 =?utf-8?B?VmIzUzVyR0RPZFJGTHM4dXBSekI2cHBJVmtDWDdua2pBUVVxbjBvT0I0RjZF?=
 =?utf-8?B?STdPR0NscU9na1g5VXJ3Y0JLa3hvbUFNRlNHRjNqdDVpR3QxUnhuYVZISmg2?=
 =?utf-8?B?QUpRTGZwdDZETUhFaVJGV1V3NW1laTdidlZjeExvRGZFVHVIaUF2b0JtaHpC?=
 =?utf-8?B?c3RyU1IzbG45YlQrWUVGRkxJY2U1QzJhUnNMMWVNNHg2VVNtelNRMFZzUEVo?=
 =?utf-8?B?VDFNbG5UTG5Bd0VFRDV4SzdoUk5RajBVc1hHYVQ0USt4aWsyVWNPdExiRXJX?=
 =?utf-8?B?NG9nREdEOHE4WW9yZnU0ZG1jQlcxOFFsRGRRZWRHZGVXNTVMNEJUYlNMb3pF?=
 =?utf-8?B?OUJCTFNHYVFkOGxGZU13UnlzTDBkK0p2USs0U3plWmdNTGhBMks4STFDamJC?=
 =?utf-8?B?TjA2NCtVQkZySSt2b3VlTUIwWjEwYUFLajZZeXVldEFKVFdMV1pDa0dJaUNi?=
 =?utf-8?B?d3p3cE1tSzZMeFFmQWhvakF1MTcyNHZ0S05SZk5xdTZlWUdxTzJMU0lxMlcw?=
 =?utf-8?B?QzV2VitiNFc0TDNvY3hTZ2grMHV6Rjh2N3NrK3NLekVPbk9URGs3am42ZUNH?=
 =?utf-8?B?cXVTbWxmZ1VFNUhHYWl2NjFnTXlhOUhhZXBpRUVPNkRZcUQrdXlMZHhRVGdD?=
 =?utf-8?B?ZlJoTWE3US9NNlR5UmxuRXhQam1zbk1aTGxWSi9DZEZQZ3pJNnBnWXpSdWsr?=
 =?utf-8?B?U01NS2d2eUluV1UzNVoxcW5JNEd6ejBKcGxlblpYby8vSUNUbC95SUxzTE5Y?=
 =?utf-8?B?UTlSQi9VZHpMK29WcCtScnFqOFpXZTR6NkxpOWh5bGFSQW96bUFoKzk0eU5m?=
 =?utf-8?B?SUhXOWxDUE9NV3RrU2hpUzIxSlo1ZzZHMTV3Vk00OXNpc3liR0hhalowODJ5?=
 =?utf-8?B?VHdwNnB4QmU4RWRUVHNsdUl6Sm5ZcXlKd0JZTDZyWmgwelFxbmNuRmo1V05o?=
 =?utf-8?B?Vm1JcHdCSzRwR0hxdU9UNjd3Ui9jQk5qeUp6VUFtaEwrOEt5Szd3bXVpczM5?=
 =?utf-8?B?SkF2NjVyVFJydW5XRHNUUzhUekJxSHdVUzRkbStlWmdXRW5NdTBOZTA1MGtJ?=
 =?utf-8?B?Uk4rMy9Fdmt2aGd5T1YyUTdiWmNqcUtKMm1xbHlsa2grSEpmL3p4K1Z4cCta?=
 =?utf-8?B?K0VRUno3THVMMUQyTEVoalRBcFFnRmM0WEV5UEprMHdmVmh1TlNzT2JiRHJL?=
 =?utf-8?B?ajFEVEI1N0Jvbm9HTlN0bjVnTHBneERraFdQaXo1OWZhU2NsN1g1cExMNi9M?=
 =?utf-8?B?ZnVJcXg4OXN5bkpyZGZCWUxiYTdGOVZ4ZHJrNVNvN3F3b3hJdnptaFk3eEwr?=
 =?utf-8?B?ZDZMTEMzQytRMHNFd2FNdDJkTXk5cUJPSnN2N1VOOUtYSmlxNURxOS9UOTVh?=
 =?utf-8?B?Kzl6MWNuNDFtZFh0SDRBd2pKR1ZXSXptWmordktmMFhmSFRiandveXlpQzBw?=
 =?utf-8?B?c2cwNUs0Vi9TOHhDYmdBTzNTMzdhU0ZoU0JBYU8wb2pvWXpuMEdZV2lBZlh5?=
 =?utf-8?B?TDA2Ky9pUU5qMGo0aG41a1BYWFluamVINW1vUE1pME9Jem9lNUJzZmR4VjNu?=
 =?utf-8?B?VC9aRnZ1aUxrUmE1WXR3SXhWYkpvTEVlazNDLzBpWWZlYVRaVG9iUC9hbzRw?=
 =?utf-8?B?Zi91TWVNbmhPQjRLdGlJbGFhQlNNYWMvM09tdmwzTmlBRS9wQTVTOGc0Z2N2?=
 =?utf-8?B?aXRuYXp5WHAvYkFHbkdTamFlakI0cVFkZkhSQ0xCSWZ2WnlnQkJXdGxWejJG?=
 =?utf-8?B?eTVwTFNNOFE4NVN1TnFCVm5tZCtzWFp0R0dob25UcmtKdmtpaGFtMmJqRjlS?=
 =?utf-8?B?NUQ0cFl1M1g3NlNrdk96U1JBbFBYbUtnMEs1Z002UEl2aFRYblVrSW9yMDVR?=
 =?utf-8?B?eHlsTjFYdXF4WlBoNnNOSWkvdWdod3VaVkQrRkIrbDNrRG0rYTltdTJFSGMy?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F65F273A563E2F48B4698251219557AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P5WZ178/MgIFNe8k3VPrxaPNjT21/mAVpDzRLlmfixneBuYsjZJJPm6bb0E9J3uP6qfe9W6mJB1XvH3qCfmlYVFPCGcZuOcdz085oosaOXw9CQPUr6ZhB2EI7HemME8iEjO4b1I4jwMuzhiZSfZZKul/AiPPHhwbsR0tsPe+yLIZ/7l//PK9Tn6K9aFow6dHiYRkZslrwa8PaRiRK+oFBCMb2x57N2f5xvFJj+4YBrZvcvDAo2i+IofPhz7ip0AxQwGkaA4PVSLhRZRrxmw+6EC7w7qd31uhLk/S3suuEO1+558NBh2omyVhP+R8jR6F0WCwn9jqMWbEvJXl6LLxckFUMM4CGKQ+iVN+46u7DYjiddRKo5E9pAGit7QcHqnQ8ZB3npXV3YbY5cG9finSyLFuYnR3PRU9X2BQ2lNC+apJfu0JFlzb31ra4rh3twN0Ijx6giHe+HWDmBO+GjfB3TVZIDTCqcHPda6+lHyIWu+GVfkuNealQjcdH+5p2Gv83J1sdvXqIFX15AwG64L/RPY7jBBVoPl5Uz54Fk2vUV6MIMJwsy+bYAUeNP1t+pTwMnlMW0B2VhZIF8MmfIVoWJSJRjaHzgo2kZQYEZrDyNU80Yb2bLLTfSXpEk9xDIggCCtlhP51StSac7wBSVmRd7pD1WwClx7Oc8igXULRCCorW05zsg3LUo2aGlA/LAJvbtSo6LMmZkIsItN6bUCd5VKSiQiQoU4D6eck+N/IINqdcw7HoOnUqivHhOgQGs9aKr7EMFt6UYTfQ9BbPkD/83dpTtdyXPnH7L/P+DMPm0A=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a7250c-ccdd-4687-202b-08dbbe311689
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:37:04.3448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+tG+Ayc7xTM5AUhlELsnd5Tnmzi8au+P70DHHvwEOnjpZik2kphkdQa7xQypgi7pORynGZ439hAQYDV9xuXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9359
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxaW9fY2hhbm5lbF9yZG1hX3JlYWR2
KCkgdmlvbGF0ZXMgdGhpcyBwcmluY2lwbGU6IGl0IGNhbGxzDQo+IGVycm9yX3JlcG9ydCgpIHZp
YSBxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdigpLiAgSSBlbGVjdGVkIG5vdCB0bw0KPiBpbnZlc3Rp
Z2F0ZSBob3cgY2FsbGVycyBoYW5kbGUgdGhlIGVycm9yLCBpLmUuIHByZWNpc2UgaW1wYWN0IGlz
IG5vdA0KPiBrbm93bi4NCj4gDQo+IENsZWFuIHRoaXMgdXAgYnkgY29udmVydGluZyBxZW11X3Jk
bWFfZXhjaGFuZ2VfcmVjdigpIHRvIEVycm9yLg0KPiANCj4gTmVjZXNzaXRhdGVzIHNldHRpbmcg
YW4gZXJyb3Igd2hlbiBxZW11X3JkbWFfZXhjaGFuZ2VfZ2V0X3Jlc3BvbnNlKCkNCj4gZmFpbGVk
LiAgU2luY2UgdGhpcyBlcnJvciB3aWxsIGdvIGF3YXkgbGF0ZXIgaW4gdGhpcyBzZXJpZXMsIHNp
bXBseQ0KPiB1c2UgIkZJWE1FIHRlbXBvcmFyeSBlcnJvciBtZXNzYWdlIiB0aGVyZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0K
DQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4g
LS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggYzg4Y2Qx
ZjQ2OC4uNTA1NDZiM2EyNyAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiArKysg
Yi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0xOTU3LDcgKzE5NTcsNyBAQCBzdGF0aWMgaW50IHFl
bXVfcmRtYV9leGNoYW5nZV9zZW5kKFJETUFDb250ZXh0ICpyZG1hLCBSRE1BQ29udHJvbEhlYWRl
ciAqaGVhZCwNCj4gICAgKiBjb250cm9sLWNoYW5uZWwgbWVzc2FnZS4NCj4gICAgKi8NCj4gICBz
dGF0aWMgaW50IHFlbXVfcmRtYV9leGNoYW5nZV9yZWN2KFJETUFDb250ZXh0ICpyZG1hLCBSRE1B
Q29udHJvbEhlYWRlciAqaGVhZCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgZXhwZWN0aW5nKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCBleHBlY3RpbmcsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAgIFJE
TUFDb250cm9sSGVhZGVyIHJlYWR5ID0gew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLmxlbiA9IDAsDQo+IEBAIC0xOTcyLDcgKzE5NzIsNyBAQCBzdGF0aWMgaW50IHFlbXVf
cmRtYV9leGNoYW5nZV9yZWN2KFJETUFDb250ZXh0ICpyZG1hLCBSRE1BQ29udHJvbEhlYWRlciAq
aGVhZCwNCj4gICAgICAgcmV0ID0gcWVtdV9yZG1hX3Bvc3Rfc2VuZF9jb250cm9sKHJkbWEsIE5V
TEwsICZyZWFkeSk7DQo+ICAgDQo+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+IC0gICAgICAgIGVy
cm9yX3JlcG9ydCgiRmFpbGVkIHRvIHNlbmQgY29udHJvbCBidWZmZXIhIik7DQo+ICsgICAgICAg
IGVycm9yX3NldGcoZXJycCwgIkZhaWxlZCB0byBzZW5kIGNvbnRyb2wgYnVmZmVyISIpOw0KPiAg
ICAgICAgICAgcmV0dXJuIC0xOw0KPiAgICAgICB9DQo+ICAgDQo+IEBAIC0xOTgzLDYgKzE5ODMs
NyBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9leGNoYW5nZV9yZWN2KFJETUFDb250ZXh0ICpyZG1h
LCBSRE1BQ29udHJvbEhlYWRlciAqaGVhZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBleHBlY3RpbmcsIFJETUFfV1JJRF9SRUFEWSk7DQo+ICAgDQo+ICAg
ICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkZJWE1FIHRl
bXBvcmFyeSBlcnJvciBtZXNzYWdlIik7DQo+ICAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAg
IH0NCj4gICANCj4gQEAgLTE5OTMsNyArMTk5NCw3IEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX2V4
Y2hhbmdlX3JlY3YoUkRNQUNvbnRleHQgKnJkbWEsIFJETUFDb250cm9sSGVhZGVyICpoZWFkLA0K
PiAgICAgICAgKi8NCj4gICAgICAgcmV0ID0gcWVtdV9yZG1hX3Bvc3RfcmVjdl9jb250cm9sKHJk
bWEsIFJETUFfV1JJRF9SRUFEWSk7DQo+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+IC0gICAgICAg
IGVycm9yX3JlcG9ydCgicmRtYSBtaWdyYXRpb246IGVycm9yIHBvc3Rpbmcgc2Vjb25kIGNvbnRy
b2wgcmVjdiEiKTsNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAicmRtYSBtaWdyYXRpb246
IGVycm9yIHBvc3Rpbmcgc2Vjb25kIGNvbnRyb2wgcmVjdiEiKTsNCj4gICAgICAgICAgIHJldHVy
biAtMTsNCj4gICAgICAgfQ0KPiAgIA0KPiBAQCAtMjkwOCwxMSArMjkwOSwxMSBAQCBzdGF0aWMg
c3NpemVfdCBxaW9fY2hhbm5lbF9yZG1hX3JlYWR2KFFJT0NoYW5uZWwgKmlvYywNCj4gICAgICAg
ICAgIC8qIFdlJ3ZlIGdvdCBub3RoaW5nIGF0IGFsbCwgc28gbGV0cyB3YWl0IGZvcg0KPiAgICAg
ICAgICAgICogbW9yZSB0byBhcnJpdmUNCj4gICAgICAgICAgICAqLw0KPiAtICAgICAgICByZXQg
PSBxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdihyZG1hLCAmaGVhZCwgUkRNQV9DT05UUk9MX1FFTVVf
RklMRSk7DQo+ICsgICAgICAgIHJldCA9IHFlbXVfcmRtYV9leGNoYW5nZV9yZWN2KHJkbWEsICZo
ZWFkLCBSRE1BX0NPTlRST0xfUUVNVV9GSUxFLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJwKTsNCj4gICANCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
ICAgICAgICAgICAgICAgcmRtYS0+ZXJyb3JlZCA9IHRydWU7DQo+IC0gICAgICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICJxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdiBmYWlsZWQiKTsNCj4gICAgICAg
ICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgICAgICB9DQo+ICAgDQo+IEBAIC0zNTM2LDYgKzM1
MzcsNyBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25faGFuZGxlKFFFTVVGaWxl
ICpmKQ0KPiAgICAgICBSRE1BQ29udHJvbEhlYWRlciBibG9ja3MgPSB7IC50eXBlID0gUkRNQV9D
T05UUk9MX1JBTV9CTE9DS1NfUkVTVUxULA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC5yZXBlYXQgPSAxIH07DQo+ICAgICAgIFFJT0NoYW5uZWxSRE1BICpyaW9jID0gUUlP
X0NIQU5ORUxfUkRNQShxZW11X2ZpbGVfZ2V0X2lvYyhmKSk7DQo+ICsgICAgRXJyb3IgKmVyciA9
IE5VTEw7DQo+ICAgICAgIFJETUFDb250ZXh0ICpyZG1hOw0KPiAgICAgICBSRE1BTG9jYWxCbG9j
a3MgKmxvY2FsOw0KPiAgICAgICBSRE1BQ29udHJvbEhlYWRlciBoZWFkOw0KPiBAQCAtMzU2NSw5
ICszNTY3LDEwIEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9oYW5kbGUoUUVN
VUZpbGUgKmYpDQo+ICAgICAgIGRvIHsNCj4gICAgICAgICAgIHRyYWNlX3FlbXVfcmRtYV9yZWdp
c3RyYXRpb25faGFuZGxlX3dhaXQoKTsNCj4gICANCj4gLSAgICAgICAgcmV0ID0gcWVtdV9yZG1h
X2V4Y2hhbmdlX3JlY3YocmRtYSwgJmhlYWQsIFJETUFfQ09OVFJPTF9OT05FKTsNCj4gKyAgICAg
ICAgcmV0ID0gcWVtdV9yZG1hX2V4Y2hhbmdlX3JlY3YocmRtYSwgJmhlYWQsIFJETUFfQ09OVFJP
TF9OT05FLCAmZXJyKTsNCj4gICANCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAg
ICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGVycik7DQo+ICAgICAgICAgICAgICAgYnJlYWs7DQo+
ICAgICAgICAgICB9DQo+ICAg

