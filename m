Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763A7AE611
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1fW-0002Nw-HS; Tue, 26 Sep 2023 02:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1fU-0002Nj-Kj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:35:36 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1fS-0007gk-G8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695710135; x=1727246135;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9oZc4mjftIfEDFlKwnCXF1JfMAmuxPNm/a6Eisom2CU=;
 b=sN48pd7CPM6rNrE7vaU/GJXpz2iFwL/bmOIiO7OXyXRT2QNwejJP0h+G
 lICYPRx+qOdgQgPqPudPMgrvx4MQu26O7JQzhLSP5yRDcUmvx9EBDmWL+
 V38sXmeSe7rU3RRgZDU8lkvWTJwEhyhW6Ot7yG7O1dBoQmftRyG+yJPu2
 tTVntXAS7pYt0fRogDlEGZp5NyYxKZYTvJYGMuxYF9A4i0tzkYz75Pb3m
 DDm9Q0kX3DA1pWUivP52ZVM8K1h9uFpUBfzufIOQjdZ5IrU5bb0wfQKlZ
 YMTU0AA2rokhm3uavlrBMHkcsHASP34zpgXA26IVx08D+exA9NvdytMaS A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96410283"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96410283"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:35:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrnd1PDzWsUFyrJbqoA+yY48vyrS/tIzPxMGGKumw2stG/1RF3ZIhPZlcNnb6n5FGl1gIJQ8/7j4+3Wsz7KB8ikFF+Vm9M+0TESHDRhDKosAw6xZ9kl4EslCP979b0rgH5lE3f+dAfHYqdHCWU2xmlGJMZFhw65Gse3Vpwa1dIVMXso3DhJH2YXhW/Y5JbSkECItO950FxkV4yl0QwmYjaj1HM8OtiIMIRQgLED5BmWj4Hy0hcDvPLDMDUgscOD0xKdqf763zb63hgQJ6KRrsfBLyShBw5o40SoKWlxEr8Z0o++rBrHiKAu5tbamxuX8B1DZCJvWf7WgVV3be6bcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oZc4mjftIfEDFlKwnCXF1JfMAmuxPNm/a6Eisom2CU=;
 b=Ik/M7CrfgECJMCoukaxKWp9iAfnbt7bbpofq00m7F7NaxvzN6fxmmj6+TuGm8XlKsJy3grCy6D2GDccvlVOl53Y8rZ3HrnfGsGz6ePHdwtSiricpbwbolaJmrg2QbTqtZ5AaejSOcUnJqUg0uPyQOWVGiRfb3GC1fBzmUbBC0jVt5WTjKHT8BlxRW5qp8fkmtIZaHC6OG9zXer/GjhyfKAMvYfF6hjJgRxtA3x552y/8Bli6N9qero5tzL8iD1HOb5WMjnoPUBImPk/U1Luk4VGm0Z+VULYBNTR9I8CIocp1XBNF6Zyer/xkYDNti7YRMhMruawqlStPzaLiuTudgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB10935.jpnprd01.prod.outlook.com (2603:1096:400:397::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:35:27 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:35:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 51/52] migration/rdma: Use error_report() & friends
 instead of stderr
Thread-Topic: [PATCH 51/52] migration/rdma: Use error_report() & friends
 instead of stderr
Thread-Index: AQHZ6j84bCQ15Kwi9UiF2DWOmdtParAsssSA
Date: Tue, 26 Sep 2023 06:35:27 +0000
Message-ID: <8ddefe9a-bb2a-7ec5-972a-d2ab567adc54@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-52-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-52-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB10935:EE_
x-ms-office365-filtering-correlation-id: ce0af137-4ced-48b0-2b2c-08dbbe5ac564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERvY/S63mGGfM7KnJXZQLkYkNWyNigW16dNj6TADM7/ISUzjDgh4XbpCiEUEHvWXT3im3iCobcsc9dfGKR1OAdMXMVRCQ3b0hcbZkuhoOnAjXhv3wJ6PLZMwXg4EtbtAKRMGl/5hbap+YHCQphPN1sH3EbDCLMaTWe/DzT/UKTgXaxUVIFK98BhH3yeXDd8QBk0f5OBo3Dq3aoWCEjshKdTnRR1miIbjMinJapdP2mBUxpdOemB9+R5dDLWEv0a2XNDKtTUVvojwr9aHkLceOlcsdPKQ1runWiRZlLDbnl/kOSgLR3b3pFkmqii5rHhHiYYoV71sIc1NN4LQ0zm7HUfRk54/QZ6boMFVXI23ZVBkbyBqWCfFMec1MrKgyVX8SxjUy937vP/i3HGzJ4GzPX3S9AiT/DuNJP184CEEuW6Gsf3vmu4HVPmKfd+IxqCBLAFlWXJuoar66sj/ZZ2S3WJTPX598HuZGHr3a1mAhiysFcRFoXbJIqRN/Y7Zc/t65zRZxrcx8BZbe19brPOaZcABwBIY+ug38Vp9pxULYckRqXvkVgilKNXsgbCTWppc1AjbvKU26/6bxTLQWNJENwFPBPGSGhLfNiRBJkY0xSBlHuw2YMHXHJa6o8yKmh5HV5fYjLYjRu9U68+5Rsg//omep6aHfLrZvXxsAKIzE/hQjPID0jSZnEyHiEEv/RBtQ7ZSw9DSqL4pblH33vbe+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(76116006)(1580799018)(26005)(4326008)(8936002)(8676002)(316002)(66556008)(478600001)(41300700001)(110136005)(91956017)(83380400001)(66946007)(66446008)(64756008)(54906003)(5660300002)(6512007)(53546011)(4744005)(2616005)(2906002)(66476007)(6486002)(6506007)(71200400001)(31696002)(86362001)(85182001)(36756003)(38070700005)(38100700002)(82960400001)(122000001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z05OMy95aDJQZytDeW5iNnZEdU5HWnFlTzBiMldaeFNUcVhBTURMd0NTU1lX?=
 =?utf-8?B?cDlDczkzSGt5UmJiQnhNUmgySHVTSjdWM09GWjJwc01vTmdhME14ejQ2N0RI?=
 =?utf-8?B?UmNGN1ZrQlVYMnBxSTZhc0pxMytZME9rL2Nkcko0MVVGNlk1OFVQTzJ6cWY3?=
 =?utf-8?B?MktvelQ1UGpDZU56alJjdFp6anRCZ21qWm5ldDY3eWJHUUREbWRRZWdBRVFo?=
 =?utf-8?B?TGlhelBqUGFsSEp2VEdQUTFhZG5LSzAvVTh1b0lYdXkvMWVKK3pQOTBFd25T?=
 =?utf-8?B?cndLU0g5S2h6UG1qMEp2aktaUHBjOWdwUHQzSUVnZG9lcHBSczRJNlNIcDJ3?=
 =?utf-8?B?c3BtL2Q1eDQ2L3AwcmZ6QUo0R1hBQzZ4Tm1VQUZ6eU4zRDdwb0crOWtHQnRr?=
 =?utf-8?B?bDNTK2xJVndLSnB5T3pHZlNleHFpazJkMkIyK2hiMHBjRktDUkJwOExzeWQ0?=
 =?utf-8?B?aDlXM3NESDdoS21mQ3pxK3F2Qk1DMU4wK2JySlNNQXRFTHVBamZqUzFFQXVj?=
 =?utf-8?B?WklqQnJkKzVwTldxc29hOWJJUThCVCs2cnRlazhJNnFDUEszM1pGNWFka3dG?=
 =?utf-8?B?QmFEYXlIbjM3TGJVOFphemp1OXlQREt5dHlWWk5NSjJhSXAvOHREWjdJdHN1?=
 =?utf-8?B?eGY2bjhNYlhVNE11RFdWL1VrTStZVmtGQzN0V3VhTFN6OTJkVCtyVW1XQkZ2?=
 =?utf-8?B?bG9DMjZ5SUc0RTRyYUFaZERkNjdFcVJVRjZGdmRaZEU5WFlId2VFaDkvMThk?=
 =?utf-8?B?d2FNbjIveFJCb0I4R2pVM25hU1EwdXViMG13TnRNcDdibS90VEFjd09RV0E0?=
 =?utf-8?B?YXR0MXNkV3VUZ1lDdDR5T2cvOEo3UWttYk5FS05rS0hzWjVMNjRpVFNkNWdw?=
 =?utf-8?B?VTdjZWx5a2tYZXZidjJsZUROYW9lSGRLdHVMTHF6T0pxN1IyVjQzNFdKWVFF?=
 =?utf-8?B?Z3Z4VHlTdmtKdXZESFpLQnIxbDhmd1NJb1lWaUdhWVZFQi92c01pcnpOelBt?=
 =?utf-8?B?U1l5d1NMVmVtTjFhd3RJTmJoOFZsQ1RLM3kxOGRmM0tramx6UFdBVXZYZHJs?=
 =?utf-8?B?Y2FNMjJnOHNsWnBsSGJRUmVkUnRXNlJpZ2tmcU42Slk5N1R6c0todmQreGFp?=
 =?utf-8?B?Uk5oTVpCTTEvSFhTem5jaWt6U1JDRHNENjhNN3dLL1B4R1RtNkIxTFNTdit6?=
 =?utf-8?B?UVdUa3QrTzZ5ZzgyL2JFdGw3YW14OUFQZG81Mk5BdDh3bTgyWU5vMVpleE9m?=
 =?utf-8?B?Qm1nOVBzT2VTeDAvRk5LaEdWcnBHZEdQd0xnMEZSbk1rWW03RjNnZE1WR2NZ?=
 =?utf-8?B?UnJJQ3ZYbTI0eGVBTXdnVnhjdWRYRW54ZGFpdnJHSklNU0U0bmprVlp5QkRX?=
 =?utf-8?B?eWdBd1d1NUdMYkJjZ0xDdVJGaWQ4dkk5dlM3NDgyZHpuQms5NXMrWm5VSy80?=
 =?utf-8?B?dk1JQ1pvNytnVG1vMVVWUFAxT1hFbUxCL3pHTFB2Q0tVcGphb3pHQWFpMElB?=
 =?utf-8?B?d0pJUDBnSjJzRFVHaHRDWG9VUzZpcGZ3UjVJMnppZnJWSC9CdUppR1NybG52?=
 =?utf-8?B?UnR6bU5mUFdxcTZSWDVxWkp4WXJnRXlrYzFkSzQ1Q291Ym1udnVRbDFINWpX?=
 =?utf-8?B?R2JadHhVSkVrVmt1cmRjZmRKMDNLK3krV0ZsbVh0andveUpMdHRZVzJzbDVO?=
 =?utf-8?B?NGV2NTBFUXZ6U3lQU2psbGUzZHZWdjRnTlhWK3lIMkU4WnNwNE5Ha01UQ3o4?=
 =?utf-8?B?alBmMUNCWFhDTXZFcXRXYWo4bTdEbEh3L3lqd3BHa0dwejNOZWRNYTJrWW1F?=
 =?utf-8?B?Z3I3ZzB5MTAySXJ3ZS9aK0N1VW4remNocFFQYnhBcDdsVHh0LzNxbUc0K1B6?=
 =?utf-8?B?dlhmWFBxOEZza0tIM2pwSlpVYUZHUnd3d25aVkpXWlNWWGg3MXBMNXFxWWFp?=
 =?utf-8?B?TGhnbG5FTUYrSVhyWFR0MUFDajBPQXM1OG1EM3R0ZUdlb3h4WTlTTHRHSWph?=
 =?utf-8?B?MjlLYUE4ZlBFWU5WYXZZc1Z4NzJSTk53VTVlZk5OMGdzODlUZ0J2MktyWDZK?=
 =?utf-8?B?b2RRRWNCSzZXSUZQeXFBMHgwSXFUM0QyTEZRaWRpU2ZFTE11T0Q1SmNCQTE3?=
 =?utf-8?B?eUU2emlscGZxSUtBOTgwTVVTMy9DRkVHMVN2Zng4U0phbkRRS2NhTHp5TXVU?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB4934DE3609364089912E3EF4EE4E86@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FTDCSFsN7OESyCthYpDcnncbuPWuCTUNMGlid6zxMucczzt0PoU/bL8bKXsmq+mFmornbjbBsFu/jdu9GggSUglHp1xHgysyR5y+4xfQmaRRaK2eJr0XtFmIhNr28/EZmCvhvXHuVUjzN8uGer9Voi21RSl/9WDMKsQEUWwCwGCHGGHQHC6QyhF2RchLWtOivAfdfzUCCOFWbKBHVMu3743nbEPxBIgT5x11el2YyNBhok2GEhHGFZXAnsWjI0k3jhH7KPvpRUgQ3MD03e1WHjMPtrJELU6vH7xafDn+FfLJ5latEyBEE1EDpwxzdaVXOxLiymeRxgWjdl0bH7CUIw8qFY9MIhKpYb2qyNLIUviNcX9g9u/WBWo8fnYXU55t67+zizZz6kN1RZXxrfx4ZXc1YDqLyieW22DI+dYWCKeftZdOYnvYSZZRo0qYedAFgamiWgmED+3mi5yV6TRpL+faLmikdWFXwo2Kp4HJx9ebPxMzuZNKOUwtio1SRFOUvQgb7B4TmU6/tOvudt+GhsFWfO1lBR+RAvda5y5lV+ayOlL0kCcmesYtBLRTAKZJIhwHxbmiLQvZCBG+WeeNDJtrFQVGn4Zs7kdurk2n3d/thlLUwYGkwYpXNoF3v9o9ltkwsJjIx5jki77nm70NZrFc2dEkOxnR7G4kI5/KY/KhNl0ca8qJdIFr4yvCeXOOTyU6uMV3pQbuaQVHcvPyBwrMEkJ7wRo+OoW5zaglVWf0P6bn5wBgzmdHWzT5dAO/XwgGppp5+N9KSIukuml+Gv5UX6CITgSOQbBtGr21zi4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0af137-4ced-48b0-2b2c-08dbbe5ac564
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:35:27.0779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dl7KIwWVeRAGXWNrtF0XvW42leELDKf+I0y+xDzPfxO2hqp8/bp/dhaO+YWePZV0jDJDpL2swoIhVKrTO5hRIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10935
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAgICAg
ICAgICAgaWYgKGxvY2FsLT5uYl9ibG9ja3MgIT0gbmJfZGVzdF9ibG9ja3MpIHsNCj4gLSAgICAg
ICAgICAgIGZwcmludGYoc3RkZXJyLCAicmFtIGJsb2NrcyBtaXNtYXRjaCAoTnVtYmVyIG9mIGJs
b2NrcyAlZCB2cyAlZCkgIg0KPiAtICAgICAgICAgICAgICAgICAgICAiWW91ciBRRU1VIGNvbW1h
bmQgbGluZSBwYXJhbWV0ZXJzIGFyZSBwcm9iYWJseSAiDQo+IC0gICAgICAgICAgICAgICAgICAg
ICJub3QgaWRlbnRpY2FsIG9uIGJvdGggdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24uIiwNCj4g
LSAgICAgICAgICAgICAgICAgICAgbG9jYWwtPm5iX2Jsb2NrcywgbmJfZGVzdF9ibG9ja3MpOw0K
PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJyYW0gYmxvY2tzIG1pc21hdGNoIChOdW1iZXIg
b2YgYmxvY2tzICVkIHZzICVkKSIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgbG9jYWwt
Pm5iX2Jsb2NrcywgbmJfZGVzdF9ibG9ja3MpOw0KPiArICAgICAgICAgICAgZXJyb3JfcHJpbnRm
KCJZb3VyIFFFTVUgY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMgYXJlIHByb2JhYmx5ICINCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAibm90IGlkZW50aWNhbCBvbiBib3RoIHRoZSBzb3VyY2Ug
YW5kIGRlc3RpbmF0aW9uLiIpOw0KDQoNCldoeSBpcyB0aGlzIG9uZSBoYW5kbGVkIHNwZWNpZmlj
YWxseT8gSXQgc2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBmaW5lIHdpdGggZXJyb3JfcmVwb3J0KCku
DQoNCg0KDQoNCg==

