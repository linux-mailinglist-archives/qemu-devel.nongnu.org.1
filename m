Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927AF7ACF91
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 07:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkeNZ-0007aT-FT; Mon, 25 Sep 2023 01:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkeNW-0007Zf-KH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:43:30 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkeNU-0005Pb-7g
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695620609; x=1727156609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Bc0rP5LfEKeGLbkXC8kstGDz3lvmvhjLHcv/cFivC+E=;
 b=PP5nehpkao1L9ufoAYAFskuSzJKA6bmGJNc2cmj0UGv/O+3dPQmKTVvf
 TgU4sLuD5Yfe6NXJajJXBjxSdkJbCUf887mF3J+1lwcO2CjZeLooEhRqO
 ZNU/hLvxy2qLOIZdq6ePCTlTagkuwLaXUcFm9P/id2Yej6pJrwqG7j3Tr
 Ux07ilcM5v/bXRzjzzBviNdp2YPjZ4Sc0npQILTp/+s4XOZ+gimidEUN8
 hu5ntORmqeV54a/4vcPRLn1D5/5PWwL1jucaetJfGaSboLkn8tu8Bm3Ei
 d1Zk590+CwxeL+zjm0khus/4+MoMR5E2Qs7tuI6hWQKjL/W/dLUAUON6R A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96594661"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96594661"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 14:43:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/D8gGK96BzTTSwlxjQFwKJsn2i1o53CymspbMpC5uxcWZUhinmHH6hLSO1MNqVzY8VkdISJMUGLNOIYgyTnzzkVkld00nE5ZWGsUIlvWcbc7l4OGwIwK9twJlJ+6hUGR0LVQMwAY88yOWnn6+kkhZmJ1jBwfZbEVQJEdPcoSe9OcZ5I37xMl2vlASr0DOJV7lIuSitCrRxyWUxbwuwZfR8eb/wmQwbSvyGQtQIxhLV/RN0TQEzCdWExPKkEGJQ4U9/iwA6qETih1ElosMwOi/U6ZXgyzR9liTBeGj8EH2FR6IgGH/qmrkjtnMfMlVuCQAFyTyJI0TZ16PCYoe2FNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc0rP5LfEKeGLbkXC8kstGDz3lvmvhjLHcv/cFivC+E=;
 b=cCLGKV9sQSgK8UOT3ohE32VJKz9SsEPnxYYwKuIFqRfQJuhkXEDTLL2akKt9LAUYWSAX4h3svs++DmL5cX4BXHUwipz4Ix3DultjcFVlKzacidIuU9BYnvt3ygwMfWANfluKknYrsKE7nRuHoaqoWwACAbTjcGUKbgec9wP8PxvDmUrm39IpVHgGR/uf9XFqdPkvf3BvSr52ntB3tVE3KOvXAHisdgeH2VY9x4hjZZj0cNm9fAZD3Q46i07oKNY8N9gRKHDfAzEUt60GywGHmHRPMUU9As/03vTaBeUywdP6WKlnUdNIRgKxON12p4iK1K+I1W9SSjitDSat0Qpbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYBPR01MB5470.jpnprd01.prod.outlook.com (2603:1096:404:8025::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:43:20 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:43:20 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 23/52] migration/rdma: Clean up
 qemu_rdma_wait_comp_channel()'s error value
Thread-Topic: [PATCH 23/52] migration/rdma: Clean up
 qemu_rdma_wait_comp_channel()'s error value
Thread-Index: AQHZ6j876ZO2rLpfIUiZV3p2fAyQb7ArEeAA
Date: Mon, 25 Sep 2023 05:43:19 +0000
Message-ID: <ee5864ff-66d2-b22f-4a47-c6c164329ea9@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-24-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-24-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYBPR01MB5470:EE_
x-ms-office365-filtering-correlation-id: 01376a23-0c7c-498b-64f4-08dbbd8a5316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8x5UMR/5WSXQUoldgvSBxWR/+/dFQKSS1ZSzXuUWOrJbdglrkihKtnGHWYFh3VWpJ+VZ5W88N3p0tw/1h0T6hN5H5F2R6/cHDO0gM6Nxz4+EKxV/mcaR2LpNmamLSAkpGtNZhHbEj9pQl+ePCGeybwu7s024mnwfsQu6X3LB+g7HQhAC/F976UXzcWjs3BmKx0o6tTxBTa/ZjYkKVPZVKtBHbVrFQzzvby1gxCAdo7A1hFz1a3uj/dZr9gDhkB3/cC04EDF9dDvB7qsz18irJlpSKOBBxjMpPvzlIrnDw5Pq3GzdULwbMI92vzLXkL3brvpB2m5ZeQEDXQIK+8iHe4MWHIGZ3nrekKLVrAnVFHg4nb0B2Ug6HaxVoBLGd6DaMs9EUT2IPddz75vsdsX9a9meSefQlWeLkN5b5wL2vG5pFczRi+h9CQUVQJHx5SXeWPV1EeL1LWc5Y1huN9Eimo4VpfsAJ1dlSJSHfFPV/kqADv9L3pSeXjYYhmV4ayG9+VbUB7naZhp5SoFpWB+v6N1IPKa12FgzX3nqZJWC5HbHMdElpPQQcHa1+KSClbrNOuAkj4bt9LamPUAR1SNQ3CO6PbEcVLr2uZ004xqAtFDyGXJW5YW3UfGVGoS+OgP/Vv4Jf4PYRh96+rPgzBCPZ4pLU/8EGWmeJW1M1FSsd7xhr8dbmxV3mmUqKmceE1Pa/IAAfGd1rhY6GqQoYGIpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(1580799018)(83380400001)(26005)(8936002)(8676002)(4326008)(478600001)(66476007)(41300700001)(66446008)(64756008)(54906003)(66946007)(110136005)(91956017)(66556008)(76116006)(316002)(5660300002)(6512007)(53546011)(2616005)(2906002)(6486002)(6506007)(71200400001)(85182001)(31696002)(36756003)(82960400001)(38070700005)(38100700002)(122000001)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGh2Nzc3Z2tWTHRyRXl1MzQrU1hTVVU3MkhEdDFGNmhpNk9uaEV5UUtZTmt3?=
 =?utf-8?B?RjZBb2VlVFdqR0NHY2VsL3czY1dIL2hDcFlmSEQrQi94MVFoay81QzloaGJk?=
 =?utf-8?B?QVpONE9id3ZwakN0MU9lWUhDMG4zdTB2Zzhxb0RRMVBNUTRxUVZpa2dSYUQ5?=
 =?utf-8?B?d0diSW5rdy9ZQU05Mk9iSUduMnBSWGUxS1FzSjZ0MGo4L1cxYzNuYk55OEtz?=
 =?utf-8?B?Qmp1R1FFMS9neGl6VXJ4OEtBaWFVdjVMRURWY2R2a0tlK254ZHlrVlUxbmpl?=
 =?utf-8?B?VS9VdUU3ZExCUmZDR29ERVdZaGRZcityanV5UVlsZ3ZNeVo0bWF1WG1HTjhN?=
 =?utf-8?B?dW0yV0JsWDljZ1RTOTF5VVU3ZS9pNnQ3TVQreTQrS3pCMHdtOGFvM2xZdWtW?=
 =?utf-8?B?a21nQW00SERWUFd3bzViZ1pXM2pVZjlac0RCUWZabGJRYWpBc25NVzh6UXZV?=
 =?utf-8?B?MUhmeVB5V1hOc1BwajRveVdPWklJWmJOcjBMWExOOW8yS2NqZzRkQ0VFbmlJ?=
 =?utf-8?B?M3g4bXZXdXk1NXdrNWw1d0ZOQmFsZHJaTi9xS2djMlZPR0ZBNlh0V3J6RFAz?=
 =?utf-8?B?RHRsb0QrV09vM0FQY04zYVl0Mmk1Y2JTWnROd1RrMVpYV0gvSFN5ZFdjRWRP?=
 =?utf-8?B?UC8xS1ZJR1VrejlZWFE1OGxvZGc3Z2wrN2xKMFUxcW1ZM280Z0EvcTdIbUVj?=
 =?utf-8?B?UVk4aDdiR0NRT1RxemNkODdzL2c5RDJjZm1NT21DV0dmNkZBeU82eUh5QVFo?=
 =?utf-8?B?QWwwb05WKzZaaGZ5R2xsdC9iWFd4UXFlVmJOcHB3TndGeEw5dVNkSlJyR0xN?=
 =?utf-8?B?bXE1Y2JNSFByMU56TzBoQ3VDaUFFb3Q2Z2UxTXc4NXlzVTQxU2VHS3NERzd2?=
 =?utf-8?B?M2c3ZGl2Sk9jQjNKbllMTUxpTlEwNUQvd0VJRXJiUkNXMTZBbUJIRmtNaUJw?=
 =?utf-8?B?WjkyUml1VDBoVXIxQjdpSWNod2Fqa2IrOTNCVTlBa1pnMGJSa1F6ajYwSits?=
 =?utf-8?B?TExkcGRZbEdNZ1pRa2ZsUXJsYSszRW5BUlY4Y1pGYXlhVFFlM3hGK2t5TG9v?=
 =?utf-8?B?WjMxU2lLOG1EcDRqYlNud0tPU3VJL2Y0OHNQamtlMnZDelJiYXd0YklTblpw?=
 =?utf-8?B?YjJ6a3lQcDJVS2ZCRitCR1VMNEM1dWk3eHltNS8yL3IxdDZlYi9RSjZ0eXlE?=
 =?utf-8?B?KzZ0eENoZURqTm9vT3RTZFp4UDNiTGVkZ1Q2dFFhRW9FdElMS1g3Z1RMZVZu?=
 =?utf-8?B?ZXF6bXJaYlFoRTN2NGZ4NnlaT3RyM081VGpOYjJXNk16RnRWM0x3REJzVFJp?=
 =?utf-8?B?ZkZxOStTRVEyWWQ0ZUFHYWJKYzlyZ3M1d3JKYUxTRktneWZjRE43ZGc1Q3BW?=
 =?utf-8?B?eTRYQm9kbWtNdUU5YmQweTd6R21IM0VSVThiZ2xSTW5EbzFJQ3Z2RjdsaXBU?=
 =?utf-8?B?cTBhMis4NEZSTFpzaUJ4SXZJQXlJNHhkZ1d3bXNGdU5tY25hcC92UGlBRzUx?=
 =?utf-8?B?amw3dSt5RUR3MEFaeUR2SGRFa1hYUTNUQWNDVEZBU3pyaUN5OE9NWm1qbkZm?=
 =?utf-8?B?M2V6blhGV2Rua2pGMDBVdUluQVlONkpuRnJvejRYSC8rS0pNL3R3L0JCVG1G?=
 =?utf-8?B?YS92Y0hoVkFMamtQZjFoU2ZKbWVOanlTalgxVjVHT3pDc0JlUXJpTzFTdHUr?=
 =?utf-8?B?eGpUQk94YUVrcExQazJYalJva1NkNXZ3ZFFHWmowOFNMck56QnN1SVI5Wmcv?=
 =?utf-8?B?MmhCM2JqekFlc3A3OGdidjhqdGVmZXpEU2VMVkk5NWpZM3BQUlovM0FWcEVX?=
 =?utf-8?B?OGdJMndVSEpKUGdiUFBpeHM4dHFCbWFmbzM5dlhWT05MeVdtWUNqckxrbWp3?=
 =?utf-8?B?Ti9tRkhEUENLaGJROTRrKzdUY29KTWw3RDV6WE9qSlhzVzV3NDY4cjN4cXdK?=
 =?utf-8?B?NGltZXBvV0RuVkRBSW5rL3ZIL09tYXN0RUZ3SGY1SDJydzJBYWJ4a3k4TERF?=
 =?utf-8?B?bmE2LzZneER5MnQvWlM0Z1pUNlBZbG13eStUOG5sdUl3NGllbHZMNWZBR3Z2?=
 =?utf-8?B?bkJxUGRRVENLTEh4UHJiVnA2SkpoNWY0dnprWmRHeDhYZ0xxQkEvU3ZLcjlD?=
 =?utf-8?B?UHpPRVNBTzVxY3dWSVdmYU1KeEFPN2VUb003czMzRVFPL2dVZmwzM3VIYWZm?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2D0322D045C6E44A4E6AC2C527FF10D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VCe2l2Gh5ndXLXdePBrDtI5tFLvzQzlR+6DohyShwLkMLJr0FNzpte4YEz+z0TpaXhVN3H0IAr1dO/BwDEWDHNAomvNZFf3wf4zP5pPj8UtioSQLw0nRJfagAQqEYyopOeVzZU4LZ60SGoclhGiBxYvqy58IP1PYo0m0d4S7wlvcUSctMr1eTHkyVxP9lq6e5OT1+2AEziCTwWd1PWt3FRyKRJsD9DGUbqfgKr2UTIZq7N0W0hI53e6YSnCdKczkWibkLINUGwqZpu2WhD+z/KMiW+XHhX9fUiHDhZERm7xgt7HeylOpAie7HpkvCag8eWh7QmM/Clio3a7UFRyYKjIDFwQSmsQAtWg1uGPC+ZRfWpLhaC+X6hbMPJwC113wxuNrACP/6TGDOVzeajM1euvOyWRd4vdDH2OwUI+MCUC2T7piGMRbAT6hJy0sLcthw84As5aWZT9pvHBjtZD5OvGV4M/lNf1TZPxgHEekK7SYM+YSJOk/G4A7PknLzxd1MScE9xWFO6+TpIUUgX7KmYAcJSwM4FZrW28CMDvVfEZnkQ3qK/xnpn2daVZHOFQPHQ1Moeleu3sp0r1fAjqiES1CzlaSuoWK+rW+tNDLQW0JIgGXAyOQtrjnhSnUXzngVJ64vX9lsyldJU17x2L2jLmJ8+IrxhMgxqQir4UNflkHL4yGqdy8QJG6mSXaHwD8MWRPkpcU8zbTkFnETw8rVU9HH4kE4gh6Xxgq8tm2ED+xY5z3eAg9k0G45LF3TTGKc3VeCS11ygsJnmclC2Ygtcdqr20M/wESZqo6wohwqoI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01376a23-0c7c-498b-64f4-08dbbd8a5316
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:43:19.9777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XlMJV7xfmSnVL/nOqeOW6MeWQ7ZJjz4AA7qdq1t7WtHoMVfGeE5siOsZ/9+LC/VgArtmtS8AS69jLHrquc60g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5470
Received-SPF: pass client-ip=68.232.159.87; envelope-from=lizhijian@fujitsu.com;
 helo=esa7.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfd2FpdF9jb21wX2NoYW5uZWwoKSByZXR1cm5zIDAgb24gc3VjY2VzcywgYW5kIGVpdGhl
ciAtMSBvcg0KPiByZG1hLT5lcnJvcl9zdGF0ZSBvbiBmYWlsdXJlLiAgQ2FsbGVycyBhY3R1YWxs
eSBleHBlY3QgYSBuZWdhdGl2ZQ0KPiBlcnJvciB2YWx1ZS4gDQoNCkkgZG9uJ3Qgc2VlIHRoZSBv
bmx5IG9uZSBjYWxsZXJzIGV4cGVjdCBhIG5lZ2F0aXZlIGVycm9yIGNvZGUuDQptaWdyYXRpb24v
cmRtYS5jOjE2NTQ6ICAgICAgICByZXQgPSBxZW11X3JkbWFfd2FpdF9jb21wX2NoYW5uZWwocmRt
YSwgY2gpOw0KbWlncmF0aW9uL3JkbWEuYy0xNjU1LSAgICAgICAgaWYgKHJldCkgew0KbWlncmF0
aW9uL3JkbWEuYy0xNjU2LSAgICAgICAgICAgIGdvdG8gZXJyX2Jsb2NrX2Zvcl93cmlkOw0KDQoN
CiAgSSBiZWxpZXZlIHJkbWEtPmVycm9yX3N0YXRlIGNhbid0IGJlIHBvc2l0aXZlLCBidXQgbGV0
J3MNCj4gbWFrZSB0aGluZ3MgbW9yZSBvYnZpb3VzIGJ5IHNpbXBseSByZXR1cm5pbmcgLTEgb24g
YW55IGZhaWx1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJt
YnJ1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAyICstDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggMzQy
MWFlMDc5Ni4uZWZiYjNjNzc1NCAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiAr
KysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0xNTg4LDcgKzE1ODgsNyBAQCBzdGF0aWMgaW50
IHFlbXVfcmRtYV93YWl0X2NvbXBfY2hhbm5lbChSRE1BQ29udGV4dCAqcmRtYSwNCj4gICAgICAg
aWYgKHJkbWEtPnJlY2VpdmVkX2Vycm9yKSB7DQo+ICAgICAgICAgICByZXR1cm4gLUVQSVBFOw0K
PiAgICAgICB9DQo+IC0gICAgcmV0dXJuIHJkbWEtPmVycm9yX3N0YXRlOw0KPiArICAgIHJldHVy
biAtISFyZG1hLT5lcnJvcl9zdGF0ZTsNCg0KQW5kIGkgcmFyZWx5IHNlZSBzdWNoIHRoaW5ncywg
YmVsb3cgd291bGQgYmUgbW9yZSBjbGVhci4NCg0KcmV0dXJuIHJkbWEtPmVycm9yX3N0YXRlID8g
LTEgOiAwOg0KDQoNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBpYnZfY29tcF9jaGFu
bmVsICp0b19jaGFubmVsKFJETUFDb250ZXh0ICpyZG1hLCB1aW50NjRfdCB3cmlkKQ==

