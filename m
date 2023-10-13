Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61757C7F88
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDAr-00061O-AI; Fri, 13 Oct 2023 04:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDAk-0005Vw-8m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:05:26 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDAi-0000gx-97
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184324; x=1728720324;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AHcbOJnHzSxwP53czuiLM7QEs3u61haSAHjAIr0Gyyo=;
 b=L78AfEbh3AJn+YBeQbX3CvwuAysevQTgVBMD5WQsVCc5DhRQF0VFPorr
 47eESirLH5oQbtx0Q8uqrhPrl098iHh3EFLmZLHGXblgo66kzzF0BL6qp
 5meQrPi1FLGGN+YRnJ6vj3f4QMl8l7KMis0kJEIUU6erRGvdfOwsGC1Xd
 rY4yjt8aJaxdak6Myyc69wl2fjbY/VviACLS69w1gynEZYA96AGmrfTII
 DJnZsdemvx7f3eK3M1bDh1s13z9rqgpNgERAYA58m6/+qMCfK0Y4PDmZY
 TEsnXbcoW5mXZxoskyB4JG9WokXkR5izlI6C90o1X9qcueACSo6pfh8nC w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="98748798"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="98748798"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:05:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R321ce7GeusE1b7QsXOkwZSwgXSHFa+ObswIVK1kC3RwjblLDWBoAD3Q4Ah+IJdCs6VsQRlHrcwaHgMKzHl9Ovx065vajqIaUipKLlzeTUNZg/667C65tswVJGG1EOd7qcwukNb5U7bYMIe3J7ju1J2ccML+hkBf7vPSVkBragoUKYOIwIsmFzo7wPPrM39xDDYykU6/4Za1pBu9EnVN7ozyzMk8qhc2yFtTKrN9f7rjHWyVSUadYTSTqs8yXQlGwOcjMzT09RKM0B/Ql8PhN0vzq1oYQXN746ZVSY+4D2hymkLuZfWc9Ylv2VKL20lgV60rDlGWZCdXfcEUuoHeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHcbOJnHzSxwP53czuiLM7QEs3u61haSAHjAIr0Gyyo=;
 b=AtjUOqJ9z/+QO+2xMLyoLDvwuTWyCUGWljeHPDe84cXRbVE9roPMjjSObs1S+/Uljkc1feQcRufJWdugsQzugEdSOdPqCi7fi/qlxa/nKgL+5S/hcM3QPOyZsXPSEgZ0tC09Lb1t0WeOn4L2/I35dbVIlirucxn84gdTCMutPhNSQ1D+EIwPc4GDfdFo/juH56e5brap2e0Bg8UTxUmHBgy6xaoMINtoqRjBij+C9++qGQMcpjaZRjmXrAUr4WAwDOX/dpEt7Kkd2+jv3bVBy5TvTNJNEbSHKDnEtPkYpo5uXVMYzv6lP3FteI1dLayw1mpzQodyu4bub/GZYWQaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY3PR01MB9857.jpnprd01.prod.outlook.com (2603:1096:400:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:05:17 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:05:17 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 06/13] migration/rdma: Create rdma_control_save_page()
Thread-Topic: [PATCH v3 06/13] migration/rdma: Create rdma_control_save_page()
Thread-Index: AQHZ/IKFH2ty2DX0wEm0bHcUU+6zPbBHXvoA
Date: Fri, 13 Oct 2023 08:05:17 +0000
Message-ID: <74ab36f5-78f5-15df-c17a-95d57b298fe6@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-7-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-7-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY3PR01MB9857:EE_
x-ms-office365-filtering-correlation-id: da5fdae7-2ae1-41ad-0380-08dbcbc32391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNPzSTNEisNO++CAIMae0lH3hXAqw/jzbk2yCnAIsmFGYVTZN6qZQSp3jEjo0rT0eXWqBi8iVkHDVEgWezFqa3ANKNK6dnVpWCYZxVcc2WLQDYXcqrBxV4Bpx/GvHVrCnybT7VCZhc/KKN/tlKpxhoCWg20TUZvlueH5p+j3wB4VUJ2gTezMP2eao2cmx17wdUKkLR2c8JMpUsxjdDdagoTQtgAP2J31M9ORfLoj+WgLQmpIJA3RQipMFpCz77SHt9ahDrrG7+gbV8secu8h2r0iEu9lCXLNR68kucy3ixfU/Y7+Q0ge857QT183ariY2Erg/qX+wb5pHjoiTo+9GzYRIz0rnXCzvpgRxI4cX7biKnTs0Y0QCfCwwE296Is3GkdHXV6rELM1DKfhUvVdpCORtGd/lKIzqcj1reSPb3T8x8ijDy02X98Drtk7qkDFRan/EqIEj7jcqdsUosw8Dh/92iKBKRo3tAzDMNHcvkgVdJ5QBjIJ5ozowqMCZp9zPfRATj4jKhOtSXiSAQls3rSgFqinIti6JZW2IY6pQvBDmIeVzMu8F0E6FTu0KqdC+R1r4fhEBmjbnJ7TOFEBrRIX2fHfulTVUX9kLjNy/Y7eTSjh2OtY00n0/2Jh7QIIMvTVPm9mwrTwqoKxmeY8y1LAzcWSvyL26FfpaHKGIY+TDHQ+AgdsaDG1SsqPWV5cGjil/aBUO+eSwiq26M/nKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(1590799021)(451199024)(85182001)(36756003)(86362001)(31696002)(31686004)(1580799018)(91956017)(110136005)(66476007)(64756008)(54906003)(316002)(76116006)(66446008)(38070700005)(82960400001)(38100700002)(66946007)(122000001)(66556008)(53546011)(71200400001)(83380400001)(26005)(2616005)(41300700001)(5660300002)(6512007)(6506007)(8676002)(478600001)(8936002)(6486002)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDQxaCtsRSs0MlN2SzFDc2htUi9ZdC9DZ0tEU2l5RjNmR3drK3RTRlBOU1ZY?=
 =?utf-8?B?aTJZTlArUG5YZithS2hZSWVQR0FUWjR5bFoyc1pUTWlYa3lpbjJRc2RQMnFk?=
 =?utf-8?B?cU1MT3piNjlUZnBLMzQ5Y0hpaG1UNUFxakZ2Ky9mRkJpdDdzOXNPa2Rpd084?=
 =?utf-8?B?UzBtbE4wOEVhWUtlOE1Ldnk5c1F2Z21tWnFwdEpLNnhIVVVUSXZoRld5R0Rl?=
 =?utf-8?B?c2lGZS9FKy9XK3cyR0ZhZzFMVm54YWhpOEhybjRJMm1GZTZhT3d5MzcxQ3l0?=
 =?utf-8?B?UVI5d1dibTArT1dVY2RLVVRJODJ2aldYbDZTaWYrK2p0QWs0cmxRdFdIMzQ5?=
 =?utf-8?B?YzRPRGI4UFVZMU10VGxqdU8rYVRVamtwbWZjQ3ZObUllNHV0U3p3dytJa2N4?=
 =?utf-8?B?Z3ovSGNEdzNrL0UvaDlJc2tzL1hoTjhRSlBKU0t1RFZDZm0yTUROTk84aXhr?=
 =?utf-8?B?THBFL2M1MXM4MXFscTZ2QnV0QnVUVmRPZDl0dUlXaWJVakFNc3NtMkxSaW8x?=
 =?utf-8?B?QVVhdXJkeDBGK3p4a0hzTDRZemF5VXpoclB4SUxZOE1FQnROT3JrYXRRd21L?=
 =?utf-8?B?dWZ2c3VTcFphK3NyTjJOa2gyYXczaXBQenBKdmFZVTBvemQ3YmM0TVVKL1Vy?=
 =?utf-8?B?cGdlUEkzVDFzbjhaZFJnZlZTaUV4cjFvMEltODhSMTFZNzVadFBsZXNvSlZt?=
 =?utf-8?B?dlVWeDU3Q2poNmRiUVh1UjhwZlNxcktYMjdoaTdMZ3hLTjBYblJmaU01UStC?=
 =?utf-8?B?b004Q21CWHlIVit5U3RFMWZIUktJclNHN1FhNWtlRG9ZeThxUTQycnB2c2p6?=
 =?utf-8?B?ZlVWU0RlL0FiRXZ4TytWRC9sQU8yTFR3N2NRVFQ0VFcrMzhDbTUyRzM3ZlVa?=
 =?utf-8?B?ZGNwMEI3QTdHMGx1a2ZUTzNxMFRiS0NYWXlzS2lIVlNMaHFtQTdIdDFGSm1m?=
 =?utf-8?B?TU5uUnV0OExpUXVhOERUV3R4YWZuc2M3eHFJSnZ3ZzVpWi9NR0tPVGc4WjRU?=
 =?utf-8?B?VUo3SlpRcUtHTm45bXVKeFV1U3Nnbi8zcU1nY0dBVUdtNUwrVlh1VUU0R1Rk?=
 =?utf-8?B?R2VFWVdFLzRURmpUR0plTlJxa2UxcmdpaTBCYitpRlY0ZVlLSlgrRVMveGwy?=
 =?utf-8?B?aXdPN0RIME95YmlkWTFrNy9raC9MOWhnODlnU2JTUHlacnMwczV6QzhLRm9Y?=
 =?utf-8?B?RGlPOU50R3hoVWVHMGI0SXp0ZGxGbDl3eTMyVEZuQUZXSUZIY1pZR3ZaYzJh?=
 =?utf-8?B?bW44b1BZdkExWjEyTEFHVzFHZzNqU2JOVG9OVzFCZnlZMUZ3Yk5UaWF2OGdX?=
 =?utf-8?B?amQ4K3R1M0dhclF4NW5ZRmxVT2RiOE9nUDVPeWtyWHoyMWlPUEN6a1dlTWNl?=
 =?utf-8?B?RUt0Wi9leVQvR0s1RFhPNlpYaDlJZlpPTTFPOWpKUVowWTRheU1yY2ZaSUtz?=
 =?utf-8?B?VURpY2dpSUhFYVZBRjZUdVV2c3RjSUNVRUQ5NkVqczA0a2NLbzA0U0QyRjZT?=
 =?utf-8?B?TVA4RkVTNWNDQXBsbFlqY3YwRHU3dGFudElrYUlYWEVHbVdEZGFWdlZBWTQ5?=
 =?utf-8?B?VGVWb05xb2VPellXUUNSQnYwM0VLMnhFbEdIZ3lWK1FKVFMyM1RFNU9OSExT?=
 =?utf-8?B?MlNSUUdIRjFWYWFwcDBFTmJjUWhGVUNXVU85ZVpFUWNKRlM5eExEU1BaNVBS?=
 =?utf-8?B?amM1VU5ORGhKOU9KSjJSYmZ4NGloTmF1UnVkeklZYlRuMWtRWERnNnl3cFVL?=
 =?utf-8?B?UzhZdC9objh1WWI1QjBoemFOYWNjY3VER1JXSEdoMUh3d2JaWGRhN2tkbkhF?=
 =?utf-8?B?ZE9ETlpxWkt5a2c0aHJIOGFUZWtJSEh5bmIvUUlnbzkrUjA1aUxNZTFYNnZB?=
 =?utf-8?B?ZWNaUWNPWE0zSjUzY3ZEczlhdFNCYlB2ckEvQmdoUGJGN1JzMitUSldCR01K?=
 =?utf-8?B?dzFKazZpT2FIdWN2NFg1U1ZoMGJBeHdiQmpFY2I3TzQ5bEZ4QW1udFNKS3Nk?=
 =?utf-8?B?MVhLL0Qwd01HNjIvUDE4NTVRUWRFczlwQ3F4bjRBMkU3YTMyaFZCUzNaK2NO?=
 =?utf-8?B?K3gzWTBkaVVYaUNQTkxMSlc3c2FxOFh0TVVCTzI3NDlRS0ZWT25CQ1NOM2ox?=
 =?utf-8?B?WU1JMHFwYk9nYTNBQ2ErcXdlME92bmtFK2M1NnBKRE95YmF2R0JCQ1FaczVM?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8592EDD9E5223244B6C634C031422440@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3ojoLH5ZPt9wry48DMFAGRTcvSjpg7DconX4gAdypYaatybA/7sF/P+lyHNNBMdUP9k17E0YlW1eP7TlfqZvhN+7vL8pTumFfvNqTJbP9q8wwtQNqFvKklTRIFB3JZtfJF+4psvCRuKq2VOfCx//xGSnlcOOxoeiaRHgxURMHCeHkc5BJFf7ZM9AgWlG+HErEf9hLvIIDmNWb7ehqQ79sfXGitWff220oZ+IV5zZ2SzUzbeXxrqT3XmDV7iq++aCaN4yIjvr4WN4QHrrXtRGImiaFiljJr3wDZHTC4cC/OuBIbohMHf6vaqMobUrvBHV+t3xH6JF/QW3t6WSEhBrSiaYqlJ+BVnKMRzxgMdayfo9sLrCDCGeWScEODNqwhWeX4oAA6lNkhU/qDQUSE0MTaFZRFxhAmyx9AkTky3aY8YJARyXsgHlojolXYJgp5LqoBzXw+wOFKu35oFL2ILB8wXlfzwaqkMNK3bphsYH/JqLJdjNAnUVz4OKaJKvnM3ohCFP2aT4x/p5Gsu+2IUPYD0H5iJ88Dlb3O7HskEaKk2OSlut1IAKK6b2XR+hgW0deKZg9K5QE4veJg8FAg6YEIyfhhZYAdTE6Eb+RaNOj8HuoxFlZ+J9yBhZMZ8zI7i9tRv9tRMBWgbmkrIdzVdSIGEeNBpPV6AWzOMhpAFQtmFsbO8RSPzMRVWMd6uZJ8lCdWeVlUVYM0g2bx9JS3AqXlTR2QoWTpuv8RFtiDikPT1YNPcnMxyO96uwSZeko6YRuGnDCQSSey2pUdoa1DU+cR/BroXvc20Wh3dUzxU2P1b8JFY+nnc6IwbeUVP3dUB7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5fdae7-2ae1-41ad-0380-08dbcbc32391
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:05:17.8279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lb5qoYwFFNPDG0Df+a7eK3a/N+K01D2wmXrdqeomZb74/s6iQ2kTx7twXt8FvSd5ifKWE8xgpqGcRKIPxOcn2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9857
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IFRoZSBvbmx5
IHVzZXIgb2YgcmFtX2NvbnRyb2xfc2F2ZV9wYWdlKCkgYW5kIHNhdmVfcGFnZSgpIGhvb2sgd2Fz
DQo+IHJkbWEuIEp1c3QgbW92ZSB0aGUgZnVuY3Rpb24gdG8gcmRtYS5jLCByZW5hbWUgaXQgdG8N
Cj4gcmRtYV9jb250cm9sX3NhdmVfcGFnZSgpLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldGVyIFh1
IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSnVhbiBRdWludGVsYSA8cXVp
bnRlbGFAcmVkaGF0LmNvbT4NCg0KWy4uLl0NCg0KPiAgIA0KPiAraW50IHJkbWFfY29udHJvbF9z
YXZlX3BhZ2UoUUVNVUZpbGUgKmYsIHJhbV9hZGRyX3QgYmxvY2tfb2Zmc2V0LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBvZmZzZXQsIHNpemVfdCBzaXplKQ0KPiAr
ew0KPiArICAgIGlmICghbWlncmF0ZV9yZG1hKCkpIHsNCj4gKyAgICAgICAgcmV0dXJuIFJBTV9T
QVZFX0NPTlRST0xfTk9UX1NVUFA7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaW50IHJldCA9IHFl
bXVfcmRtYV9zYXZlX3BhZ2UoZiwgYmxvY2tfb2Zmc2V0LCBvZmZzZXQsIHNpemUpOw0KPiArDQo+
ICsgICAgaWYgKHJldCAhPSBSQU1fU0FWRV9DT05UUk9MX0RFTEFZRUQgJiYNCj4gKyAgICAgICAg
cmV0ICE9IFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFApIHsNCj4gKyAgICAgICAgaWYgKHJldCA8
IDApIHsNCj4gKyAgICAgICAgICAgIHFlbXVfZmlsZV9zZXRfZXJyb3IoZiwgcmV0KTsNCj4gKyAg
ICAgICAgfQ0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICsNCg0K
UmVkdW5kYW50IG5ldyBsaW5l77yfDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQoNCg0KPiAgIHN0YXRpYyB2b2lkIHJkbWFfYWNjZXB0X2luY29taW5n
X21pZ3JhdGlvbih2b2lkICpvcGFxdWUpOw0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHJkbWFfY21f
cG9sbF9oYW5kbGVyKHZvaWQgKm9wYXF1ZSkNCj4gQEAgLTM5ODksNyArNDAwOCw2IEBAIHN0YXRp
YyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfcmVhZF9ob29rcyA9IHsNCj4gICB9Ow0KPiAgIA0K
PiAgIHN0YXRpYyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfd3JpdGVfaG9va3MgPSB7DQo+IC0g
ICAgLnNhdmVfcGFnZSAgICAgICAgICA9IHFlbXVfcmRtYV9zYXZlX3BhZ2UsDQo+ICAgfTsNCj4g
ICANCj4gICA=

