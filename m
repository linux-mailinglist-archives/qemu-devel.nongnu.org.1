Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D37176AD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4F0S-0004Iw-FO; Wed, 31 May 2023 02:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4F0K-0004H0-Ig
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:08:16 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4F0F-00064Q-QP
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685513292; x=1717049292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=y/DUthmNUSh8H5QxBXXA1GLxXExxmDoayoFV/o8+3cA=;
 b=KXgkXP5V7VPBNJ2DggPekvJ7z0md5Hr1K1gNEhGeNfcedNGCw2nh+Uhx
 fn15Sh0iQdXVeSmBD5ZT9MKNfFbBXv9dD5CMKQ3j7uH2z4Kg1tyW3hNyo
 JC+ywv+uXfpE/GXTi5c7Cfm6XBW2bYz4OTfRhLArqs0UpWBMmgNWG4N8+
 MRi4B/Q58T68HYFeh/qYWV1c3cpEt+nB3PRBKqi29ile4SwbjNjuh0TMl
 PowSOCMma8DCSu9Tlxs5YHNZAbMIqCWp1cEij2dYenPxB2K6AchXbXpD0
 ILPVdeFmmaWZoN+jT8U5FtG9L7P2QKUv3GXo9vLsl7Yff6DG3yKC6MdLe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="85917726"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; d="scan'208";a="85917726"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 15:08:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR8Js3sC1ItZecVnqHcGvYDt7j4YssMRGZF5yLw4wN31wk2NhVFFx7ldvd0x38CCsE27FuN2jp4bcKoIYFnXwx0TDaQy089tfSC0uW6xjwJExGt0xcmhYG53yRN8Q2einxk/p4h/yJL1tfhHaKxgbSEV89e1wjYkY0uTo+5zMyyI1Gg1h23cAupbloZRe7YxrKgEV3qDo6AcefM6pEx9w8Gu2dJVBMPR4R5K83Elm6LWAYSCNHoD8FlAJ3yYvAa7D6D92zsfYXDk96r5cfnpIUG8hpxrNvJ9VIR924z31uva33O8fqNIkTn1+WG7S8pi1wwsmzKIqmD7jKzJgGBSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/DUthmNUSh8H5QxBXXA1GLxXExxmDoayoFV/o8+3cA=;
 b=iaobStJ9JjOrbttxjqNU3OpBiKpnJQ/C9G77iBF08N8xakT2MKkiNu+zLRAtN/bg/Zuj+lW+k3h5jru74iPzeEiXQwEzJcugTZ7/r02DYMeaDFpkGKNYa+pKWvkPh/3+kAYyWorNsVfCjNg66hUIdAhJzAiZSlh/gnj+XSY42GFojfJdHOiEqqZM8Xz9Op9IZdJlwf9gWOXJNPKgELlwVYVenoU5x9lRDQuqselShTX5rjmHA40l3x0VTFajUDSxMdx4bBB5+Eh5bSPkAvSCWD84ZjgaZ8BxtX26l4OiZEAS8cqP/LW4fGqA/idok1p5UVcHU9Tae/lpEOxjm3VGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSRPR01MB11773.jpnprd01.prod.outlook.com (2603:1096:604:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 06:08:05 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 06:08:04 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Zhijian
 Li (Fujitsu)" <lizhijian@fujitsu.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hw/cxl: Fix CFMW config memory leak
Thread-Topic: [PATCH v2] hw/cxl: Fix CFMW config memory leak
Thread-Index: AQHZk2h0UaDSzE2l6ky4/zXAv1Mhw69z32eAgAAGTIA=
Date: Wed, 31 May 2023 06:08:04 +0000
Message-ID: <242bbc9e-cb3b-6590-d3ed-c56edf8cb0fb@fujitsu.com>
References: <20230531023433.8732-1-lizhijian@cn.fujitsu.com>
 <7edefdfa-04ca-dbf9-8292-e38f96c28c5b@linaro.org>
In-Reply-To: <7edefdfa-04ca-dbf9-8292-e38f96c28c5b@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSRPR01MB11773:EE_
x-ms-office365-filtering-correlation-id: f97bf9ce-eefc-4f78-dea6-08db619d65d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARU9mDTE1N/TMn1z23mAD/JGzr9mGgR1oasGwulmePaeuyMFhhfymeEDk16kdsFAFa5uyGBsNJoh0b2N15mh6Of7/Rr4PWE4ZL8aS0JHQCB1hmg2FhoRBecx7K5i3niCYP5e550BJUX32ENjtx3ODznX8abQkIdWM1rA88/nAx+TfGlgJgVFI0HEBis+K3sD9afLSy5TLdOkjcVUonobyduXZ00mcxqY/cmpPu9/+B5xNfsIPg/wVdoussiDoovdulDtaXfqAI68zsxjc0M0plx8K2fLBoO08KDXratfIdOVRXpCX5iAQ9uozQ1NJTuq7XyplVpYqb0KkX9SLHvWJK81feLJiTAGIqgz3iutc5/DjBXPGJ5pl6vqvv1J24KcTm4KRTR1RjQw/rfo7tfDDkS56/cHmDxd/AV2EgHotnXpc2L3m7K8bnfhstM8D7bA7E0zgs2ZsXqPTcAktkShWw9fIAOWfV1QdKpCy9lAQjn2+PHD1+Kvs2+sz9ta34oyJTHSJTMDP4a84/gp41EfqOgk1T7v0sOmnAdBCPGIIi131vKA1mY5dHGHYd09KpUbBrSNrJ3oAX/BcZvYY6ike4BzjjTHkxoICwb8NGlPyWTipdl3h3jkWsP0VBivpgcB7RWDmZ/L46nvyHgxTqkZZzzpTqFdk/FlH3tE/GSXjVHG84rdXDblmmAm41JJK4XBf+H5YZwfgLFpob4ABKW/OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(1590799018)(5660300002)(1580799015)(8676002)(38100700002)(82960400001)(122000001)(8936002)(76116006)(85182001)(83380400001)(26005)(6506007)(66556008)(66476007)(66446008)(66946007)(36756003)(64756008)(186003)(71200400001)(31686004)(316002)(41300700001)(4326008)(2616005)(6512007)(86362001)(31696002)(53546011)(6486002)(38070700005)(478600001)(91956017)(2906002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVJoMEYycExpc2c2T3BaVlJzMUlCRXRIUy9MUHh0bWJiYm1NcnlXYitQbUZP?=
 =?utf-8?B?WU1jSGNCTUErTVo3QzZhQ3ZVc3pjSFd4eC9mcTRYOFVubzNCdzVOdVozZE9M?=
 =?utf-8?B?akx4UGR2a0dIZUk4QWRBdFE1UXZJSnhScWNBVEg4czFYV2ZJMzZmd256eElO?=
 =?utf-8?B?b1NaUTJNbDAzeER2WnpWZ1NyVUJEVnZJYlVuSzVTRGNkS0FUY1Q2cGUxS3Ru?=
 =?utf-8?B?Ty9rOENMVWt2V1A5TWtPZTNZaG42REpnTUI4b2V6akF2YjlSWU82WVpsdE9D?=
 =?utf-8?B?dXUyUnNFOUdIZ1NKS0ttZjV3WTB0d05LK05EV0dMcTZPWk82enFMTERVOTYv?=
 =?utf-8?B?ZjFNa24yRHpnMEdjWE5DVVIrYkF2V1RCc1ZqVGFUaGd2WXAybGhHeGtjTDJG?=
 =?utf-8?B?cVN0djd4dDFEeThwY3Y3dnhTQi9nTUoxbzg0TldXVmV2ajhxRzdFemN4MG00?=
 =?utf-8?B?SGtRTWdVWm9IN3F3MWN0NzVjVE5KSWhlQ3p3d2tJanU3Vk04Uk5ybU9DcTcz?=
 =?utf-8?B?S2ZsTGRWdlMrc1JkNDE3L1VZYVBpRmNYWmFJOEdwLzFZbmZUcWtZM0l4dWhn?=
 =?utf-8?B?dzNrOFhScjIzZHBpOHNTc0lDTit4WWhxNk1oR2w1MVRrd1dPTmZPcVMyWUhC?=
 =?utf-8?B?VXJpeEpzWWN3NWhqQ2hkOExGUjVTZnA5Z3BGNUlnWjFISWRXV1hnbXNsOTBn?=
 =?utf-8?B?dFVKcmF5OXkvTU9yVWJhaXh2RlN5R3R0ZEN2Q2hhYnJTczRKSlYzanRYTWZl?=
 =?utf-8?B?WjZMTVhIdDdyT0w1OERXbjRWcWlIYnZKb1hmY0tlTmlxSU95TDVUMEJQWUNp?=
 =?utf-8?B?a3pDRWN3OUJmZWx4WnAzaWJkb2JML2JWQzUrVE82OGpTc3VHUWlYelFHM1Jk?=
 =?utf-8?B?emJBUVJqYk12bXBNM3YvRWtkNVlsUTNINHdGS3BvdDh0VHptZktiR014QkZB?=
 =?utf-8?B?Ulk1SVVuOXdTdC9wMTFtemRhVW1wTEU3V0c2N1IwQkIzTjNxeHBvRjBZaXov?=
 =?utf-8?B?Q2JlaVE3Vk51dHNlNG43RTJRMkhRNTRsUXVud3daRE5hcjQrUjBJUWxCTkdH?=
 =?utf-8?B?RXNnODlpVlhaRllVcG5Pb3dST25DNkJYcmVvN2NDQ25DbWxNZnAzNEZRS2xU?=
 =?utf-8?B?eFU3VE1lOFZBNWxkUmJJVkFsazR6blZxOXRGYkE1a01qM1B3VDlzYVpTZWlB?=
 =?utf-8?B?N1YrT051dHd3RjFaOTFiSDcycC8yWmV4NWJibS9Hb1N0Z0k4aWVtSVU1cXkr?=
 =?utf-8?B?bHdrczNWbXh2OThZSWg4azB6R0FTUFBGanUreDRHWC9vTmtYQ0o3cjAwcUxz?=
 =?utf-8?B?SmpXSGx4TWljajJyZlAzMTA5S2s2Q28zbTQrZW9MbVdnTTdkajFIRmI1SjNn?=
 =?utf-8?B?NGtBT2VOd0xqZGd4SU5tYVVWb2FiWFlocnJJUXBIeDF0Qm93aW1QV1V4ZHBt?=
 =?utf-8?B?VFREK0w1U3dvZVl2a3BTNkVpNHpkUlMvSEZmZEtmbFBKZU1pNUMveTVxSjk2?=
 =?utf-8?B?eGI4MFhOMHRtRitSNEJYV2FQczhJRVNtRzNxWnJZejVlaWwvczQ3SnROMWJz?=
 =?utf-8?B?blVMMVovMXZ5eEhocldmSGk0WHovSFVXOWpNL0taZm1WajdXMkNYWFVCczh5?=
 =?utf-8?B?eWhmdTBVRExSUUVJcmxXNDlJbTRUaVE3OCs3dG9ZdGRQOWFyK052R3puVlZJ?=
 =?utf-8?B?ZXlyUEVPZHAyMzR5cHVONEhsSUV4MTJCV3dRYnZPbG5USHp2SjUxd3IyOWJQ?=
 =?utf-8?B?NENXV01MVGdNY1QwU3hjUlJrM09vVW1TRjFpamVaVWJYWXVwTkJUYXNZZ1d2?=
 =?utf-8?B?VTJBM1ZlNUpWclhCMC9OZU1xc0tTcjBacGJGT08yMDlWTzV2dUNtekNJdy9x?=
 =?utf-8?B?QU12NktJTmlveFVtdGs4UjJLbFZvaDljVU9DK3pkZ1BoQXQxMWhyVm9tc0xp?=
 =?utf-8?B?QkJhYkY4a0VxQW9BSkdrSHJxbkFmY2hhdzE3WXgxRGY0bUdaUkc0ZjlQYTBy?=
 =?utf-8?B?bjI3YnNmZFRQbTZjNGJZNGNEblgzTCtQTFBXeGRzakNHeHNFazcvTDQyZVRH?=
 =?utf-8?B?V0dUbkpzdW5Rb3E0ZzZxeWF2dGltMkFhUWFUNkcwYVErYW1XaFQ1UFllZFpG?=
 =?utf-8?B?cEZ6ajhySE5iSi94SDIvR3NZbUd3aWJPQk43aUZXWUhqUVZuTUs2aktHZ3pm?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E0C22E0844D7F4195C0B73B06B80AE9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m/R/aYb1FViT7T+C3efXuR3KXHI6Jj6wbBhcLj+aw2HuU6ZT/Bc2OPM2R7Pemr4O+VuRQEMKWKqiPEmftO5u6SDInVNhqhb+iFcn9pLznoau0TUWRJ/t9F6RiP+ovj9JYZ5PCsKJPT4vgVwibSzKrY76XBeYrWUIPEpAaRR2V67DeRnRx7BgZM75yVHxHfSFT61NpCd/XROMQrwwxyEkwIh/9ziZJ9sNg3uFP98Akql1NQKsJsCunu+iEcbH640MnDkVxho8xvVzjbCfmFcwZVI7pAAoygBV+13Akc4saT9qdK2XSBNF9DhTXwf4tLBP2fH/6eCCOr6jjXUMdSc/yjxs0g/JToyjgX4n+KKK/sldGE20U+QIn6kef1we+1+ik1Nog7YQ35mJUDzybY0kQfPenSYzdZVwuROoWzPPUSaWMeM+1BbCBo72ash0UGAUnIlfrXio8pYJTfftVxO77IWBlPgBOvxVqEFPWtqwDPYl3Lu4j0abTsixPkXwAJr4A731Hgrbn26h3C4ub/AR+Z5eLxXXs24WSKIr09B1YtJrlAhuNJSuQ6SV/u9Uj48lEnEb+f9zCnzASxxHdo01iJQRSVzDmPbN142EK7gnU+yuSDoueEmTah1RwqpLmpzoFBOR2v9tlXxlbbRTcu2FZ/V7rwlnUT66g+GvatHtbDUKwtPTYdYGB8pS0yPSBDk/rQwWpMqxthrwwcnu2RmaD9GMHlQB0vbyKonylhK5ThiY64tGjyaPBHT8MESjagmq3Mi22zGYF8Dv+jYSLDT3Q1iCxnqENKuGlbTXK0XyjPzQUhIKGgO2ZdiPFBrYm3R+Dbi5DJB4TdkG3SCZhj7pFu1KqoFQAzJLGPMhdDwFGmQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97bf9ce-eefc-4f78-dea6-08db619d65d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 06:08:04.8734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvtCyMPREbJWW/eaP+Kjf77BBoZOjP8TRDTHN/LzQ1Ac4gxDKsYYBPd3CvGuCsjwjiGsKstu3hyKdglQ9eykAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11773
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDMxLzA1LzIwMjMgMTM6NDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiBIaSBMaSwNCj4gDQo+IE9uIDMxLzUvMjMgMDQ6MzQsIExpIFpoaWppYW4gd3JvdGU6DQo+PiBP
bmx5ICdmdycgcG9pbnRlciBpcyBtYXJrZWQgYXMgZ19hdXRvZnJlZSwgc28gd2Ugc2hvdWQgZnJl
ZSBvdGhlcg0KPj4gcmVzb3VyY2UgbWFudWFsbHkgaW4gZXJyb3IgcGF0aC4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+PiAtLS0N
Cj4+IFYyOiBEZWxldGUgdW5uZWNlc2FycnkgY2hlY2sNCj4+IC0tLQ0KPj4gwqAgaHcvY3hsL2N4
bC1ob3N0LmMgfCAxMCArKysrKysrKy0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9jeGwvY3hsLWhv
c3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+PiBpbmRleCAwMzRjNzgwNWIzZS4uNzg3YTJlNzc5
ZDIgMTAwNjQ0DQo+PiAtLS0gYS9ody9jeGwvY3hsLWhvc3QuYw0KPj4gKysrIGIvaHcvY3hsL2N4
bC1ob3N0LmMNCj4+IEBAIC00OCw3ICs0OCw3IEBAIHN0YXRpYyB2b2lkIGN4bF9maXhlZF9tZW1v
cnlfd2luZG93X2NvbmZpZyhDWExTdGF0ZSAqY3hsX3N0YXRlLA0KPj4gwqDCoMKgwqDCoCBpZiAo
b2JqZWN0LT5zaXplICUgKDI1NiAqIE1pQikpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJv
cl9zZXRnKGVycnAsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJTaXplIG9mIGEgQ1hMIGZpeGVkIG1lbW9yeSB3aW5kb3cgbXVzdCBiZSBhIG11bHRpcGxlIG9m
IDI1Nk1pQiIpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+ICvCoMKgwqDCoMKgwqDC
oCBnb3RvIGVycl9mcmVlOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoMKgIGZ3LT5zaXpl
ID0gb2JqZWN0LT5zaXplOw0KPj4gQEAgLTU3LDcgKzU3LDcgQEAgc3RhdGljIHZvaWQgY3hsX2Zp
eGVkX21lbW9yeV93aW5kb3dfY29uZmlnKENYTFN0YXRlICpjeGxfc3RhdGUsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjeGxfaW50ZXJsZWF2ZV9ncmFudWxhcml0eV9lbmMob2JqZWN0
LT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlcnJwKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKmVycnApIHsNCj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gZXJyX2ZyZWU7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoCB9IGVs
c2Ugew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIERlZmF1bHQgdG8gMjU2IGJ5dGUgaW50ZXJs
ZWF2ZSAqLw0KPj4gQEAgLTY4LDYgKzY4LDEyIEBAIHN0YXRpYyB2b2lkIGN4bF9maXhlZF9tZW1v
cnlfd2luZG93X2NvbmZpZyhDWExTdGF0ZSAqY3hsX3N0YXRlLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19zdGVhbF9wb2ludGVyKCZmdykpOw0KPj4gwqDCoMKgwqDC
oCByZXR1cm47DQo+PiArDQo+PiArZXJyX2ZyZWU6DQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBmdy0+bnVtX3RhcmdldHM7IGkrKykgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGdfZnJlZShmdy0+
dGFyZ2V0c1tpXSk7DQo+PiArwqDCoMKgIH0NCj4+ICvCoMKgwqAgZ19mcmVlKGZ3LT50YXJnZXRz
KTsNCj4+IMKgIH0NCj4gDQo+IElJVUMgd2UgZG9uJ3QgbmVlZCB0YXJnZXRzW10gYmVmb3JlIGNo
ZWNraW5nIGVycm9ycy4gV2hhdCBhYm91dCBzaW1wbHkNCj4gYWxsb2NhdGUgd2hlbiB3ZSBjYW4n
dCBmYWlsPw0KDQoNClllYWgsIHlvdSBhcmUgcmlnaHQuDQppIHdpbGwgdXBkYXRlIHRoZSBwYXRj
aCBhcyB5b3Ugc3VnZ2VzdC4NCg0KDQoNCj4gDQo+IC0tID44IC0tDQo+IGRpZmYgLS1naXQgYS9o
dy9jeGwvY3hsLWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+IGluZGV4IDAzNGM3ODA1YjMu
LmYwOTIwZGE5NTYgMTAwNjQ0DQo+IC0tLSBhL2h3L2N4bC9jeGwtaG9zdC5jDQo+ICsrKyBiL2h3
L2N4bC9jeGwtaG9zdC5jDQo+IEBAIC0zOSwxMiArMzksNiBAQCBzdGF0aWMgdm9pZCBjeGxfZml4
ZWRfbWVtb3J5X3dpbmRvd19jb25maWcoQ1hMU3RhdGUgKmN4bF9zdGF0ZSwNCj4gIMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOw0KPiAgwqDCoMKgwqAgfQ0KPiANCj4gLcKgwqDCoCBmdy0+dGFyZ2V0
cyA9IGdfbWFsbG9jMF9uKGZ3LT5udW1fdGFyZ2V0cywgc2l6ZW9mKCpmdy0+dGFyZ2V0cykpOw0K
PiAtwqDCoMKgIGZvciAoaSA9IDAsIHRhcmdldCA9IG9iamVjdC0+dGFyZ2V0czsgdGFyZ2V0OyBp
KyssIHRhcmdldCA9IHRhcmdldC0+bmV4dCkgew0KPiAtwqDCoMKgwqDCoMKgwqAgLyogVGhpcyBs
aW5rIGNhbm5vdCBiZSByZXNvbHZlZCB5ZXQsIHNvIHN0YXNoIHRoZSBuYW1lIGZvciBub3cgKi8N
Cj4gLcKgwqDCoMKgwqDCoMKgIGZ3LT50YXJnZXRzW2ldID0gZ19zdHJkdXAodGFyZ2V0LT52YWx1
ZSk7DQo+IC3CoMKgwqAgfQ0KPiAtDQo+ICDCoMKgwqDCoCBpZiAob2JqZWN0LT5zaXplICUgKDI1
NiAqIE1pQikpIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLA0KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlNpemUgb2YgYSBDWEwgZml4ZWQg
bWVtb3J5IHdpbmRvdyBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgMjU2TWlCIik7DQo+IEBAIC02NCw2
ICs1OCwxMiBAQCBzdGF0aWMgdm9pZCBjeGxfZml4ZWRfbWVtb3J5X3dpbmRvd19jb25maWcoQ1hM
U3RhdGUgKmN4bF9zdGF0ZSwNCj4gIMKgwqDCoMKgwqDCoMKgwqAgZnctPmVuY19pbnRfZ3JhbiA9
IDA7DQo+ICDCoMKgwqDCoCB9DQo+IA0KPiArwqDCoMKgIGZ3LT50YXJnZXRzID0gZ19tYWxsb2Mw
X24oZnctPm51bV90YXJnZXRzLCBzaXplb2YoKmZ3LT50YXJnZXRzKSk7DQo+ICvCoMKgwqAgZm9y
IChpID0gMCwgdGFyZ2V0ID0gb2JqZWN0LT50YXJnZXRzOyB0YXJnZXQ7IGkrKywgdGFyZ2V0ID0g
dGFyZ2V0LT5uZXh0KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCAvKiBUaGlzIGxpbmsgY2Fubm90IGJl
IHJlc29sdmVkIHlldCwgc28gc3Rhc2ggdGhlIG5hbWUgZm9yIG5vdyAqLw0KPiArwqDCoMKgwqDC
oMKgwqAgZnctPnRhcmdldHNbaV0gPSBnX3N0cmR1cCh0YXJnZXQtPnZhbHVlKTsNCj4gK8KgwqDC
oCB9DQo+ICsNCj4gIMKgwqDCoMKgIGN4bF9zdGF0ZS0+Zml4ZWRfd2luZG93cyA9IGdfbGlzdF9h
cHBlbmQoY3hsX3N0YXRlLT5maXhlZF93aW5kb3dzLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdfc3RlYWxfcG9pbnRlcigmZncpKTsNCj4gDQo+IC0tLQ0KPiA=

