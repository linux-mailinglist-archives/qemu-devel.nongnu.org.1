Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945857ACF71
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 07:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qke2w-0004PE-Af; Mon, 25 Sep 2023 01:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qke2n-0004P6-Mx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:22:05 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qke2h-0000QT-Ta
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695619320; x=1727155320;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WLneNPMvziAFLNZ/FhFoFgESUfHPIapSFP//4+da6mg=;
 b=V9H7EhsxACOudEXWVMnuuObaEBotfwK4YSlxK2qGVQABKAEq4hpdeA86
 aMkJD2FVb1alWzQSxCTVch0nG8YpoSqMg6CR0/GHF86wGVp+KsoIrkkfP
 oP9oM3/i4pnN56Ns5DrEfikTgiIsB5UFfuouaJv/maIE2jIuegAalqzY/
 79NjdMtr7/fNiCYInhP81YZe+y4E4h+59B1be8TdGRuch2WzJekx8b9pM
 sBIyv8ytcqT2zk5IGjR1U2hVJCyePurBrZzuYAILmSeYx5RVnn2uMxS2j
 IgCbGhQB0ZBAIlMkvHZYlJvm+NVsc7aw7FlnkAkTzW6dJaWF2pLAT9dhI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96468441"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96468441"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 14:21:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwYYz4FJ8IXyfrqIe9jxKZP8TR59UKb7v8SkNK37uHrVLvHSRDnCeNJZYNBhDWG+tcHGOGO2Wa6dgUB055h4NAKFf8o4fxWMjX17r1aI4FPGkIFPfpgjDBMkuhIYEg2HtKzSCp/Y5r61um7TMNfK1TXV14xmv5HHnJBC/60F+8S/DxBqdfFr1BzeXgrYUUqONpmvNoVHn4MY0iPJER99pQExg/g1QXvSIAY0ryDL2Kq/u0pp96YOM3QV2C5w3YD65g7g23DFLAYM7CDY0viCv9weS+a0tisgBFaj4vp+EyPCnq90WxM9vUmPBPvyecDLjEJ0Yp1HpHo4D/0BBIcwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLneNPMvziAFLNZ/FhFoFgESUfHPIapSFP//4+da6mg=;
 b=nJCE9S3PHrP0wlRI66iDBGXrncXAtWpEVvrbQLrGPvtdhTSHvQm6EgGYdOT4Ip5SuV4ZB63sVIy8K1D7Dv1FuKbKU/BU+sbDIgLfrs4iPTiBCpz17eA6kN+tTdEEUkOwBTs2qXD2cDTCST2hftMeIWV4axkVxuv7J2NjSgOG2B8v7XnNCKZLPKzBfFI3r+nSFr4kokU4ECuakUnxu3fqeeuSkPulBDcHsGF/0HHclIrYcgBvHmzrZMkGbhUh4k7FwpMeZQ9libD678eMW5jGxXJbCyzO6SRt/9CkGYUs6JhifbsfitkomII9EWiMK79KdqP1Bd2NrVQbAi52+f/yaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB8037.jpnprd01.prod.outlook.com (2603:1096:400:11c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:21:51 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:21:51 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 22/52] migration/rdma: Fix rdma_getaddrinfo() error
 checking
Thread-Topic: [PATCH 22/52] migration/rdma: Fix rdma_getaddrinfo() error
 checking
Thread-Index: AQHZ6j8/WVxMCE/YBUe5z0FiKWMOrLArC+AA
Date: Mon, 25 Sep 2023 05:21:51 +0000
Message-ID: <2e7a1475-e8bc-b813-f27e-3c1aa098245e@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-23-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-23-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB8037:EE_
x-ms-office365-filtering-correlation-id: 6f6ce5d9-df2e-4708-1b0e-08dbbd8752f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DQW4xWTpzFxTQQeGyzm4eRe2v8ew4AIVDQ2FZ0CNbz6MXG7cJQ01j0gAsdW3cj9BLkgni7R31GSK0tjwqiLV2mKv1D2eEnJ7YTg11qaZMxVsu5yjsqTNmJGHd/8E9UVOJWn5DGDNnokKZbzN3+3eafFGG/zMOXpQFWUlKOKomCR449cDsvpL9CuWpBC0b6nfzheoZkakLbQmweYnNjP+ObYbJqztqsvssEMkuhkYKFTOn9jKr9jQ9j3/A2ZupSK0CrldsIKMJC7sH5tj+nFdMaWkwVYz8V3czBcUsuxdO0QaK7CwbyvdWo/iAUdchRMPByuIuF8fV/63pj/bSUCjurOM3eQJ0HlyptdDbeQTMjRWFfMy8KEn09hIRPMDsYF/HLc75MVUdVie1DMhq5mUk8wIqgunXdd2Rw5Bw0ch0ybY4v4nHy/HTm09Fg+Vtir3d3bvY0vSzmbrcHYYbKLExwoG0a6N0q1wpfFTXeZUS2aRMkc2GGAbRfKDMtce4z+F3zWx9SDu7QcsyrSUi2HpU1Rp7GhQRc2/dalj+L0/68bNLUtDtwGtwRRRe20qbCSUUb19cDSr3q/jWqOyTQBjw8E9VVoMCxFpuCse3gr1yCo9blgUORg8yvcZgMS9YMZulbRJHfTD5vw1XDWheIbjueZegQDSSprLY+YGr9B6h7er/kF2dNz57I7yzRmZyP5W7TjuEwyNz9oRgnR5BJHgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(1590799021)(1800799009)(186009)(451199024)(36756003)(122000001)(38100700002)(38070700005)(82960400001)(31696002)(85182001)(86362001)(31686004)(1580799018)(53546011)(5660300002)(6512007)(2906002)(2616005)(478600001)(66476007)(41300700001)(76116006)(316002)(66556008)(54906003)(64756008)(66446008)(91956017)(110136005)(66946007)(71200400001)(6506007)(6486002)(83380400001)(4326008)(8676002)(8936002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0V5Uzg0SFYzVkJpYS9jVEdYd1RwbGZRb2J1eC8wVExtbk1WdGU3SGFWT0RI?=
 =?utf-8?B?VDdwMXo3MjZFV3oxZ2c0OHNQRkVnSHJjS2ZaU0hObjRkdmJoTlY3Mk5LNmRi?=
 =?utf-8?B?SkViNHNBOFJHNDhFZjJ5R0lKYVpUVTMvZ0taUHplekdOKy81UjI0U0RJWUFC?=
 =?utf-8?B?cnBiZVVhNDJRTEhRb0NtTWlrUkxIZ2hNMytWYzBaejNNem44Ymk4SU5uS2xT?=
 =?utf-8?B?VGFrVllBR2dEbEY4UUpIcW5uRHpKd0M5WndZY2NTTGg2NmJ0UWU5VnBKVzBW?=
 =?utf-8?B?UGxubFp1L1A1VGJ6b1hVYTRBbFkyTmlnU2w3OU9qb0pLdG80Z3VIb2tmZmhq?=
 =?utf-8?B?WnB0NlFMbG5QRkRwU2JENmpqUENDWURCblE3WWVaVE41QVBGOWw3RHIvczdl?=
 =?utf-8?B?Q2N6KzhyU1lFTXFUNGZYM2lxeW53ZHYvZ0FHNzZPWUlZNmhMUXE1cVRWZi9n?=
 =?utf-8?B?K2tTZTQvTTBBRERWL0RXOWI2SmMvNFk5Rk81YVNDWmx2RHZsQlp4MDVvRUlq?=
 =?utf-8?B?TEV3MFZOSzVVd3hCMWFCZ0NSUlByTnNvcjBCVy9Sd3B5QmROYU5Zd2FwN09P?=
 =?utf-8?B?TkV2SEVNeU9PNURTT3krelVyWkNzZ05TQXArL2gxRktta0psOGNCZDFML3pH?=
 =?utf-8?B?NFh6em5sc0VrdEhmRmxhZUQ1MzhQN052eE9KVzlYc1p2dG1hU3ljTGZTUUlK?=
 =?utf-8?B?YTIvZERkckVjMk5DdGNYc0lxL2dTUVQyTW8zYVF4K3pwUnllTDNjSlB6dTNi?=
 =?utf-8?B?N0J3VUl3WDJ5N0lQWGowb2oyM2hqejQzQ0NtbUF1MTQ3Snp2TWVKTjMybHlB?=
 =?utf-8?B?VHovNEkxTytxVnAvUSs0Z1J2eFZMemZFTHBvOHZtQUdVSnpiNlFQeFIvUXVo?=
 =?utf-8?B?NDR4OFVwQnZyUzl1N1laeGRheDZYcDdXNHlURmR5L0VvaTRZS0lrbkFud3Rn?=
 =?utf-8?B?STBDRlZRYmVBUWFmQXU3NG53blovc1k5ZDIwS3pLNEY2NXYzSTZidnJtRk85?=
 =?utf-8?B?NnRUQlNXaEFmd0NlZlc5UkFvQXNhQkNQTklEQUZHM2RIVHI2L3FpZ1A3dmRM?=
 =?utf-8?B?RnNadFlwUTcvQzFnRFR6YTJ2UzF0V09WeUMwYUJpcFlTNElpMU5tZjJQNngy?=
 =?utf-8?B?ZVBJdUQ5UVk2NDNZWXQyV1B0QndHbUlCREF4OGhJWjRhUzdVYkVvb2o0Y3di?=
 =?utf-8?B?NjJSZGNUVWF3NmlyTjl5bzdyQjkyc0gzbDJ5KzFXYVN3QW5RbHQrUE9BN2Fn?=
 =?utf-8?B?eGhQWnFvWTVvdWsyLy8vOFFHanp5UmI4ZVgxR0I4cUJJbXVFbXZBRXY2M3ha?=
 =?utf-8?B?TWYwY2t4T3krZHpLY1BoUVdmM2E2VWkwVTVJMmt3VmZDMk1SdExGaml0ejZj?=
 =?utf-8?B?Z2Q5RjhVaXVpOGxkTFV6dVFZUXBDNUFPaDJjS2ZONER5OElqMGxqNDJLVkxa?=
 =?utf-8?B?NzZQdVhFaFpzVzFnQVA4OU9qUlVNZG12VnNaUnpqV09qcFNUdmM4NjdkWjBY?=
 =?utf-8?B?NFRlQ05tRnR6YTRIRUF3b0UreDU1WlhsODNnWTFJNWR5a2VvREpoNEx5aXNF?=
 =?utf-8?B?ZlRRamwyR3BYdEV2N1Z1SGJ3ZE8zQ3Y3VkxNa3ppNFBBY1g2Vk9zcGprM1RR?=
 =?utf-8?B?SWRoL3Rqblo0bUkwbTM0eTB6T1RwREVSWG90SmtVUWw4aHNvOVBPY2lEaVZC?=
 =?utf-8?B?VmtaWmRyenJTd0tqZjYrcHJJb0F3a1loZkwxTnoxZGFzaFlkRVNpVE03ZURo?=
 =?utf-8?B?cGlvU2lydmhEcXE2ZzNMZ2RVSjE1UjFDUXVSRmRuWkhMZHNUMzYyQ1dCanpV?=
 =?utf-8?B?QWZmUzIxdUVxeDFaRkdyR29WdWZTRUk5YVZDYVM4N1Erd1phWmxvUUNOM3BM?=
 =?utf-8?B?RWZFZGw4MXJ4eWVYdktkcnM4em1XamtNbUR5UGFXR1E3RlEyZk1OdTJNUW82?=
 =?utf-8?B?ZUQrTGZLRzM2YU5yRTZ4UzFsaVpQaHhXVWZyYTc0ZU1qbko3ak1LckpLY2lk?=
 =?utf-8?B?WFpsQUVPOGY2dkxocysxZjU2a0hNSEs4eWVuVWtnaldXM3lmdWkvNnY4SEFX?=
 =?utf-8?B?a1VvZEI4KzU1V0dQc1ZzZERTZ2I5cXpIZ1F2cmVqMmJUdGFBZmppbm1tTnlw?=
 =?utf-8?B?VkVwK1pKVitBdEpwak9ZaGR5bzR2bTZuZXNCb3pKKzhMQjFCZWlEcnB5Zk1t?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDFEF00D7EE73F49A7599C0925A1AC64@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5gwZGNAU+c0SkLnC60DfsZ2x10KZ+//6pVgS/710/MTUtnqqfNH3tEoGtif7XEARx0epVC3cxn1uC1LKeMbqdL0qez+XvdXtXKoeT85bK+xE4SRcVcZE/98rc25kBpijxeBn/9p77PImABQVXA42YCbPKxpJEQ/9JZQNsEE+W1dndZKWUM7csRtsQyXd6obCArCxLw5QCvl0iy7QuMkA5BHsDkYF96RGrk254HmnTkHq90hUO5aX3U0eDVsUdQtCORt/xbtzc4bKy+AYaEhbXAyGKw3NZ5LxahnJXxuevfb0zhn3gtnzIRVJlClzwQfatI+y8jv+g5wYXcLsRzymEAykMJhzF+9g07O8eVyFk1tiG99Sr41DaQVLgeCScfyq1eqVJ9hQyBRiWWwiNNQ/Pw86tAJM8BzVMiaEWeBNrP11GMRUzHBI/xBYbyx8HRelytzFAwGgkZEqteZY+gLK7dI5LhKgx1d82mRq3Jj26pzUuuR3BWr433gC3yS5ndxyQm72IOw5gzKcGCbZc+ulO989/F2z3nQ76HeLWAhiDfotHDQyT8EMCmN0TkQUYz2ZpPIKZGMDZobyKpxyjyqizmjAqs1mQ3kgBplwcWPPfvz3GGGRuyd/tyoC/PXWIEFdpMDdXAXRfZWzvuHt1Dev1gPX0D2HV+RVTUx4VxV9fNc1iAjPhH3HOTtXZyORuEGb3y16aqw9Az5lD44mauT1ZvocIAlKdN68RuKzAF3RXRZbtu/d8sdoDc+pNxhL6bT1fja+fQ4ks3JJxT5y2xr09QtZ4KacAu0Mqw0dpO/0Rls=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6ce5d9-df2e-4708-1b0e-08dbbd8752f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:21:51.2900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CCb1Kn9niqLx1WpBqHMxUHzGWAy/2Yyt9WENZ3vcTCC136JaacS+5JVLTooyqxnKQU7rLPioqmLJp7DTReopQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8037
Received-SPF: pass client-ip=216.71.158.33; envelope-from=lizhijian@fujitsu.com;
 helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiByZG1h
X2dldGFkZHJpbmZvKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3MuICBPbiBlcnJvciwgaXQgcmV0dXJu
cyBvbmUgb2YNCj4gdGhlIEVBSV8gZXJyb3IgY29kZXMgbGlrZSBnZXRhZGRyaW5mbygpIGRvZXMs
DQoNCg0KR29vZCBjYXRjaCwgSXQgdXNlZCB0byBiZSAtMSBvbiBlcnJvciwgcmRtYV9nZXRhZGRy
aW5mbygzKSB1cGRhdGVkIGl0IDIwMjEuDQoNCg0KDQogIG9yIC0xIHdpdGggZXJybm8gc2V0Lg0K
PiBUaGlzIGlzIGJyb2tlbiBieSBkZXNpZ246IFBPU0lYIGltcGxpY2l0bHkgc3BlY2lmaWVzIHRo
ZSBFQUlfIGVycm9yDQo+IGNvZGVzIHRvIGJlIG5vbi16ZXJvLCBubyBtb3JlLiAgVGhleSBjb3Vs
ZCBjbGFzaCB3aXRoIC0xLiAgTm90aGluZyB3ZQ0KPiBjYW4gZG8gYWJvdXQgdGhpcyBkZXNpZ24g
Zmxhdy4NCj4gDQo+IEJvdGggY2FsbGVycyBvZiByZG1hX2dldGFkZHJpbmZvKCkgb25seSByZWNv
Z25pemUgbmVnYXRpdmUgdmFsdWVzIGFzDQo+IGVycm9yLiAgV29ya3Mgb25seSBiZWNhdXNlIHN5
c3RlbXMgZWxlY3QgdG8gbWFrZSB0aGUgRUFJXyBlcnJvciBjb2Rlcw0KPiBuZWdhdGl2ZS4NCj4g
DQo+IEJlc3Qgbm90IHRvIHJlbHkgb24gdGhhdDogY2hhbmdlIHRoZSBjYWxsZXJzIHRvIHRyZWF0
IGFueSBub24temVybw0KPiB2YWx1ZSBhcyBmYWlsdXJlLiAgQWxzbyBjaGFuZ2UgdGhlbSB0byBy
ZXR1cm4gLTEgaW5zdGVhZCBvZiB0aGUgdmFsdWUNCj4gcmVjZWl2ZWQgZnJvbSBnZXRhZGRyaW5m
bygpIG9uIGZhaWx1cmUsIHRvIGF2b2lkIHBvc2l0aXZlIGVycm9yDQo+IHZhbHVlcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0K
DQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4g
LS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCA0NmI1ODU5
MjY4Li4zNDIxYWUwNzk2IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBi
L21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAgLTkzNSwxNCArOTM1LDE0IEBAIHN0YXRpYyBpbnQgcWVt
dV9yZG1hX3Jlc29sdmVfaG9zdChSRE1BQ29udGV4dCAqcmRtYSwgRXJyb3IgKiplcnJwKQ0KPiAg
IA0KPiAgICAgICBpZiAocmRtYS0+aG9zdCA9PSBOVUxMIHx8ICFzdHJjbXAocmRtYS0+aG9zdCwg
IiIpKSB7DQo+ICAgICAgICAgICBFUlJPUihlcnJwLCAiUkRNQSBob3N0bmFtZSBoYXMgbm90IGJl
ZW4gc2V0Iik7DQo+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgICByZXR1cm4g
LTE7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgLyogY3JlYXRlIENNIGNoYW5uZWwgKi8NCj4g
ICAgICAgcmRtYS0+Y2hhbm5lbCA9IHJkbWFfY3JlYXRlX2V2ZW50X2NoYW5uZWwoKTsNCj4gICAg
ICAgaWYgKCFyZG1hLT5jaGFubmVsKSB7DQo+ICAgICAgICAgICBFUlJPUihlcnJwLCAiY291bGQg
bm90IGNyZWF0ZSBDTSBjaGFubmVsIik7DQo+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAr
ICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgLyogY3JlYXRlIENN
IGlkICovDQo+IEBAIC05NTYsNyArOTU2LDcgQEAgc3RhdGljIGludCBxZW11X3JkbWFfcmVzb2x2
ZV9ob3N0KFJETUFDb250ZXh0ICpyZG1hLCBFcnJvciAqKmVycnApDQo+ICAgICAgIHBvcnRfc3Ry
WzE1XSA9ICdcMCc7DQo+ICAgDQo+ICAgICAgIHJldCA9IHJkbWFfZ2V0YWRkcmluZm8ocmRtYS0+
aG9zdCwgcG9ydF9zdHIsIE5VTEwsICZyZXMpOw0KPiAtICAgIGlmIChyZXQgPCAwKSB7DQo+ICsg
ICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgRVJST1IoZXJycCwgImNvdWxkIG5vdCByZG1hX2dl
dGFkZHJpbmZvIGFkZHJlc3MgJXMiLCByZG1hLT5ob3N0KTsNCj4gICAgICAgICAgIGdvdG8gZXJy
X3Jlc29sdmVfZ2V0X2FkZHI7DQo+ICAgICAgIH0NCj4gQEAgLTk5OCw3ICs5OTgsNiBAQCByb3V0
ZToNCj4gICAgICAgICAgICAgICAgICAgcmRtYV9ldmVudF9zdHIoY21fZXZlbnQtPmV2ZW50KSk7
DQo+ICAgICAgICAgICBlcnJvcl9yZXBvcnQoInJkbWFfcmVzb2x2ZV9hZGRyIik7DQo+ICAgICAg
ICAgICByZG1hX2Fja19jbV9ldmVudChjbV9ldmVudCk7DQo+IC0gICAgICAgIHJldCA9IC1FSU5W
QUw7DQo+ICAgICAgICAgICBnb3RvIGVycl9yZXNvbHZlX2dldF9hZGRyOw0KPiAgICAgICB9DQo+
ICAgICAgIHJkbWFfYWNrX2NtX2V2ZW50KGNtX2V2ZW50KTsNCj4gQEAgLTEwMTksNyArMTAxOCw2
IEBAIHJvdXRlOg0KPiAgICAgICAgICAgRVJST1IoZXJycCwgInJlc3VsdCBub3QgZXF1YWwgdG8g
ZXZlbnRfcm91dGVfcmVzb2x2ZWQ6ICVzIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZG1hX2V2ZW50X3N0cihjbV9ldmVudC0+ZXZlbnQpKTsNCj4gICAgICAgICAgIHJkbWFfYWNrX2Nt
X2V2ZW50KGNtX2V2ZW50KTsNCj4gLSAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gICAgICAgICAg
IGdvdG8gZXJyX3Jlc29sdmVfZ2V0X2FkZHI7DQo+ICAgICAgIH0NCj4gICAgICAgcmRtYV9hY2tf
Y21fZXZlbnQoY21fZXZlbnQpOw0KPiBAQCAtMTAzNCw3ICsxMDMyLDcgQEAgZXJyX3Jlc29sdmVf
Z2V0X2FkZHI6DQo+ICAgZXJyX3Jlc29sdmVfY3JlYXRlX2lkOg0KPiAgICAgICByZG1hX2Rlc3Ry
b3lfZXZlbnRfY2hhbm5lbChyZG1hLT5jaGFubmVsKTsNCj4gICAgICAgcmRtYS0+Y2hhbm5lbCA9
IE5VTEw7DQo+IC0gICAgcmV0dXJuIHJldDsNCj4gKyAgICByZXR1cm4gLTE7DQo+ICAgfQ0KPiAg
IA0KPiAgIC8qDQo+IEBAIC0yNjQ0LDcgKzI2NDIsNyBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9k
ZXN0X2luaXQoUkRNQUNvbnRleHQgKnJkbWEsIEVycm9yICoqZXJycCkNCj4gICAgICAgcG9ydF9z
dHJbMTVdID0gJ1wwJzsNCj4gICANCj4gICAgICAgcmV0ID0gcmRtYV9nZXRhZGRyaW5mbyhyZG1h
LT5ob3N0LCBwb3J0X3N0ciwgTlVMTCwgJnJlcyk7DQo+IC0gICAgaWYgKHJldCA8IDApIHsNCj4g
KyAgICBpZiAocmV0KSB7DQo+ICAgICAgICAgICBFUlJPUihlcnJwLCAiY291bGQgbm90IHJkbWFf
Z2V0YWRkcmluZm8gYWRkcmVzcyAlcyIsIHJkbWEtPmhvc3QpOw0KPiAgICAgICAgICAgZ290byBl
cnJfZGVzdF9pbml0X2JpbmRfYWRkcjsNCj4gICAgICAgfQ0KPiBAQCAtMjY4OCw3ICsyNjg2LDcg
QEAgZXJyX2Rlc3RfaW5pdF9jcmVhdGVfbGlzdGVuX2lkOg0KPiAgICAgICByZG1hX2Rlc3Ryb3lf
ZXZlbnRfY2hhbm5lbChyZG1hLT5jaGFubmVsKTsNCj4gICAgICAgcmRtYS0+Y2hhbm5lbCA9IE5V
TEw7DQo+ICAgICAgIHJkbWEtPmVycm9yX3N0YXRlID0gcmV0Ow0KPiAtICAgIHJldHVybiByZXQ7
DQo+ICsgICAgcmV0dXJuIC0xOw0KPiAgIA0KPiAgIH0NCj4gICA=

