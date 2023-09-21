Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00AC7A92D7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFQ9-0002O5-Vp; Thu, 21 Sep 2023 04:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFQ7-0002N3-20
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:52:23 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFQ4-0004Z1-JY
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695286341; x=1726822341;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+MgLHOWIg8t91y1ch7ktEeV9iPtATWSNnJUG5+l0PoA=;
 b=mgHP8ZXhdXtL1UpDHWngIDXrls82iaqI/29awpMu8uFxCZo81IHOPFW7
 GKHwfdTiWz/HtC21ufhZXIMjbTBnGlu/2Z+QVgUNGp/Dgw9x2YqOelZZ+
 Vx6SjX2NNRNA/nwg5HEIMRGCzOvryBWohMlTTK2rxkQFOJNEwoI+8ejpj
 LVZIB1g4Sw6OdF/g/7luDm5ZEuINeNa4VXt0z0DWN2aMBEK768lidIy9d
 0wM+9MCiqrgN2u8HqFZKoZHTOQiQ0u4YZhAA1GFRk+vmIzc1SNFfgmy7q
 GH57LEfs3Wua0U5AH9mwk1BqGXLXdYHdSYefp8KZsBLdjeVPzigCjK3YH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="95980222"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="95980222"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:52:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7jgzElqRkdAItfcYxWLKi5n/W/GHUsYvwXBLRMiingFUx1E8jVQKcXIVh+CVlR7MNaX3/kdT+yr56858KZvf2L/vGSyi41kblnfB1/aaMJoF5qzjDg7dl0z6Mbj27x1g3Tn4BZcLjcQuzILhrzwKU1AwbCHeYu5wlo6yh6kNPO3XUDHS8TalexG1bYP8LzzQhaPSk41kM5MLTgLXd1oB2J51f9BWbOCu9M62K3qLQ8/SlDK3WgE9d9WWjXse+/DJp8ZPNNmEEKtO/iHXcCJCEyxjF/Di1RswWoIx3dxzJV3SN/ohV227UqrD0Ge09JrjN1woqw/2dha80Vu3Vttfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MgLHOWIg8t91y1ch7ktEeV9iPtATWSNnJUG5+l0PoA=;
 b=HZ2Yse1OCG/zlzqrGQ86W4Y2ph0sphSb+sJjP0W1XwXcxSu/dnXKjH/pBkr3sM0/tphLJTC6++7yPhQob6bc6IreLZhzL/vm0517FgOGNeG2hCxBrZT7z0fIIV2UBJCAJYL43FMXHDnWHogLYl7G4Aawbp41RG6CCTsqun8Bco4BVv0oTXWRyhL36nPJXLF5JfD0lp9zRyeWZK7W7HuKsDw9K+yVBxJ+YZD3qx46TJ8iTmy/La5OzLZHjBpdEQMl4p27V/B1qA+FS6PQWHtKeMNfQ68D55MH7LCOOhNxfrKY0Q+jH2eXHRWLNbvbdilzsggWP2arxVUL7V+SFLk+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB9386.jpnprd01.prod.outlook.com (2603:1096:400:196::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:52:13 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:52:13 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 01/52] migration/rdma: Clean up qemu_rdma_poll()'s return
 type
Thread-Topic: [PATCH 01/52] migration/rdma: Clean up qemu_rdma_poll()'s return
 type
Thread-Index: AQHZ6j59hrfynngankWiPu/79rXXg7Ak/VSA
Date: Thu, 21 Sep 2023 08:52:13 +0000
Message-ID: <50db8f96-3462-8d2a-619a-d1408318739f@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-2-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-2-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB9386:EE_
x-ms-office365-filtering-correlation-id: d86f2ca7-4ba1-49d1-f488-08dbba800c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hCrE9sFr/VA9VHJanDK2aM4rt969ZhsSKrDPuo8Rl9mNORiMBhpT8O6CuT1kyX6WWZYQW9WVqvtqcbKBzn0rPyRvqpmiLGy1M54nOGAcKSZTc6wTeUlSK3qttprd0O7S/crpvvQYAaIOrjTL0m5u8DIpl1/PPF47Z8lmD9e3tcWigTFwL6wwR/ZpERHGE75N9Dy1wvwAIf7XfTr8KOh4svgjxv4G+SxXE3ilfbb5adY2yFrzRYRC3TV5vJXS7ESPh4HYSFEcLgVZAMQrUsVvtKyZ/2nvP9kB+JdVI12YawAQXZVYo98YVlO9w5OEGJEDLHlKeBxJ2j7F/QQGO0r6FmLC3450dzRCyKgIb0ufyhgdj7wSFRyFz9qJmKDOAUpQvvplfJcP/71ghLc77GvyoK2hMKqhv8u0liWoBaaYXOEXR0EZtvviMSqoNK5umyK8iT1JE4aUo648XwqHg7wLENLa2FuhaIX5YhD6VGzpKC9Y6xj2ZvmxsoFpY7xzK6d5nTnSA2eOVrkbMURyecyp8QLMaB3mzePHeMrPh2ZSNtlV2R/tBHk177tBYwoBLfHJIuePbZ4Tgu57moVjf4EKF1DA43/SRvv0XaWeiawP99aN5MxsCy7ovK2QjVu+c1KNDxCDTBXKtHJduDryNB2+YNsWoUdoaScad76xavSfUOkWm7WHtW6rrtTr77MBDmK9tiD2FTjZOv0DLG7NlVjsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(186009)(451199024)(1800799009)(1590799021)(71200400001)(1580799018)(53546011)(6486002)(6506007)(6512007)(478600001)(31686004)(31696002)(86362001)(26005)(2616005)(36756003)(85182001)(82960400001)(122000001)(38100700002)(38070700005)(41300700001)(66946007)(64756008)(66446008)(54906003)(66556008)(66476007)(76116006)(4326008)(91956017)(316002)(110136005)(2906002)(4744005)(8676002)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmdIZjlaVkMxb1pudDZxSHljeDgvZHlmSjlONmhseS8yU29vSXZMZDVqeEFP?=
 =?utf-8?B?Wi95TDZDMEFaY3RGZll3OXF1dFpxTkpUQlB4U21qaFMrS3g3WmlneDFtM3Qz?=
 =?utf-8?B?Yk0rUzFTWStZVkxCRW9pbEJIVjQxRGEzd0gwYnY4dnV1amZFcG9ZMTZJSUdQ?=
 =?utf-8?B?RFZnV3cwdUdSQnBOZW1DWnZtK1Q5Rm4zTlpIOG9YeGcrcHpDMGtpekdCYWhU?=
 =?utf-8?B?YVV6SlRpTHBadnNjSjMwTWZYTUtKWUgzZ3hVYzhic1k5a0NGSVRvU0l5Wksz?=
 =?utf-8?B?UVc4Y0lxK1Jjc1dlNUhScElLTlVSNngxZWhaN0RHVUI3ZzYyZWtYMTNmRGdJ?=
 =?utf-8?B?bDBCU3N4SmlXWkZCWFVFdEUybG5RUXYraVA5enQyWWJKUXN0cGF2Q2VidG83?=
 =?utf-8?B?Rng5VHhYUGh3cDVWazZMV2pQZkQ5VS9sOE4wSE84OG1XYTNLSUVnL1AycmFI?=
 =?utf-8?B?b0s1NVRJZnoxRy90ZnNwSWZsODZEUndIaVNVWkZYSzRSNG9ENVJyU2VMQTZ0?=
 =?utf-8?B?K3QycDUwanc5UXAvUFdkTVpBMXhqVVh6d1ZadjVSNll4b2JlNk5EV1NNbkJh?=
 =?utf-8?B?Rm4ySDVob2t0cVIvS1lERHVvenpiQkxYWGNFYzV5OVA4V2cxdXprMGxWZGxq?=
 =?utf-8?B?UmhCWUIxak5ILy9hblNMUzgwMmk4U0hQVVoyOUM0NytCaG9QVGRrNVZEZVBj?=
 =?utf-8?B?U0NLMkg2WmpYM3FESzVGN3lDaldpSWozbzhBSzJNYWdkc3pFRHVHa0FKTGJw?=
 =?utf-8?B?NjJySU5WSlB6SWJva1JOUVNoalNKRWF0aDJxRU94SXBtemdwMWgxdDlvYnkr?=
 =?utf-8?B?ajI1aWp4OWRjWDR4algxbDczU0FSWThXU1NVRlNQdU9QQTRvd005SnBJYTY3?=
 =?utf-8?B?aXFMbXNYbkVoazR4R04rV2VlZFNwNkthY0dKalcyTFBWck8xVzlybC9KVWl3?=
 =?utf-8?B?bzlLWTJVYlcwWkdDK0NCL2JaRFZManRxdmRXdUdPUkhYcG5LdkpOUTdGV09H?=
 =?utf-8?B?MnE0RUgzZnBzdnBrVytpd1IxOHZZQ2g2KzhOcGw1ajNsVExBVm9iMlVra0tO?=
 =?utf-8?B?bXJ2RFYyUVNCbDVkbkhHcm1Hd2Y3ZXNmWjB4a3FDU0x2em5UZWZpMkw2ZFdB?=
 =?utf-8?B?cWFuYk9Sa1hZR21iajREbjV5ZmhqbDI1NlUwNzBzcklBM1FQaXBUdnpSbVli?=
 =?utf-8?B?bVg1SExuNlBvK2JNME9CdVB0cm9DaTB1c3ErTDB1eE0vdTRCRVFYZmxnaXR5?=
 =?utf-8?B?dG9BQWhFc3UvVnhGV2RoNFQwaTg2RGFRdVpOelJaVFpkcnR4bEdWelp4U1JI?=
 =?utf-8?B?VnhwYWVSYjY2VGZmTm1saXc5cVpGOTl0ZGdnd1JDbFBiejY5VHU3MEhkYXVH?=
 =?utf-8?B?Q2NqM1dHL3hSOWhraExkRW9EaU1XbkpXU256UXJzVnVieCtkTVUweWUxM1d1?=
 =?utf-8?B?eER6NzV3c3NtNFM1Q0tVbDJBRzNqcUVYT0hSQmY0eGphcVpMUzRrVDc3T0lt?=
 =?utf-8?B?YktCT3BDN1NkME8xRm8zN3NqOVJjNmhMckttbDVnK29yenVhZWdVNkF5a1lm?=
 =?utf-8?B?Q0VoSDIyeVNKSXJIbyt4ekY3U2dvcE8xUmQycEExUlQvQ0ZxMldtbnRJMnl2?=
 =?utf-8?B?Z004dTFwUDU0Q3FYNEpYMEgxZUFzNWFmaDZOU2Q3QmN2OHFuOFdZL0JyY0FT?=
 =?utf-8?B?L1dYRVpjQ0trWGNFeGcyOUJCeHNSS1dQbWdjcEdZK3NkSnFvaHJmSk11bFJB?=
 =?utf-8?B?RkNRNmhmd1dGZDUvbEh1RWpveU16QzY5cmFINXdCVnZ1YldlY0tnK3J1dlJm?=
 =?utf-8?B?bUhKcm9EZkJlK1lCWXhIVnlVYkZ1cXdzQ3lteHgvRjhDTUF4Rmt0RGZhTUFS?=
 =?utf-8?B?UTY3Vm1Xa1hHZXlNUEg2aS9WMTVPQ2JQb1hrYWxrRzVhZzdkNS9ZMFJINzBp?=
 =?utf-8?B?VVg5OE9KMlFheTJVZys2UkJwaVpMdThmMm03YlR4NHNpekc4b3U1cHRRdC9J?=
 =?utf-8?B?U2tGRldGZ2dHa01KV1lSQ2ZmeXB6VzJoQ0hmbXcwUnRMNzR5azA4Nzk1YmZT?=
 =?utf-8?B?QmtiUUtuc1dOa1NoRHBCZHJhY0pQOHNZWUdkakFaWTRHSnJCQ1ZKUTEvN1Bk?=
 =?utf-8?B?ODgyaitacXlremtEZkdKNW93WW5PeU5Fclo4UDFBTDBUR3QxV28zQkwvZlFw?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A388D2584E2B5949B56458AC3246F47C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BqWZqrPBSwss84XNDBV1h0zThoXzz0LtdfkA0kwlu5UBMs0pDCI75+vUrCsANDUlITpComp/e8yo9e0gqZ0U53sVLIMlDBAvujyvkI5695IIJfpHdOJTZ+mCaGF8EALX8OwZj9lt9YrJvBRrlNLTRWv34br4v2NsiS3jhXtqtBItNt1rIIOsg5zSIHfjqZCp/Ke9Cq6QoVHNliFq+/Duy8k2MV7HEvgvdN2FtSXrOMrwcB9JBCrGkOvdNl5JVXcWUn6oMeA4czMiIOt1BtNzH8GSuFOEIpxwuWxWcGvdWXvTzrSvMuIe0Zvr3qw0qN+pyI8qEUklQ7KRXQIEntFC5fLuGvsxOZau1A3FHLAXA5xSaZB7tL2Lmgx4XS8IZXAMu4ZHY1MSBTYlMAXqI64gN1/wYTf4TqfSav8zQpUokDoaNrpfbtIA1pZxGMiopOTj1P3oDSyNPHAVNIY1evolgKRcZT8sWOpIteGPECLrUpHqtsOAg4ukDu/OKD1qMxnCSxRdX/hwqje2/kj15xt+fnaKRgrUkI1vBsnYZjECBZgnPgxLTaCpt2et5Ow8Dm1nynf0hXMRKWStIkPrKkrhwPf4t0dM5MrrEoaTI03YYud0aB+i8oiMeQ0IGFF6F/Gire2HfqCY7NOhivOWnOfdmx4w95mLachXoPAyy986MnPVLn5FTEhzF1g2dWJbu1w81bo3Fm9ik4z7Vs0Fro9vtsnwupHi+tUW7b5aLfX2fc+epdWFoDWuV0bzxug++H5YTZ//x8vPSe7i7lpaXYqT2nWn8Mtl8trwklwWmM+eSHc=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f2ca7-4ba1-49d1-f488-08dbba800c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:52:13.0892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36YjisR1l5qMszxC9oq5J90en1FgqdflXmrHeumtI5V1i8vfGmOpB9cPGWZuI6776Yaw4s9oBCZ/FqbEYlPFAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9386
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfcG9sbCgpJ3MgcmV0dXJuIHR5cGUgaXMgdWludDY0X3QsIGV2ZW4gdGhvdWdoIGl0IHJl
dHVybnMgMCwNCj4gLTEsIG9yIEByZXQsIHdoaWNoIGlzIGludC4gIEl0cyBjYWxsZXJzIGFzc2ln
biB0aGUgcmV0dXJuIHZhbHVlIHRvIGludA0KPiB2YXJpYWJsZXMsIHRoZW4gY2hlY2sgd2hldGhl
ciBpdCdzIG5lZ2F0aXZlLiAgVW5jbGVhbi4NCj4gDQo+IFJldHVybiBpbnQgaW5zdGVhZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0K
DQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K

