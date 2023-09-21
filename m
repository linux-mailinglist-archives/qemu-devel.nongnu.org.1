Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB47A9292
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:28:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjF2G-0001zy-E7; Thu, 21 Sep 2023 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjF2A-0001zU-VN
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:27:40 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjF25-0007vN-I4
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695284853; x=1726820853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cxswWGeGJQLaleFFU5H9ZcIIHEC5g6Eu8CvtdvdWDAY=;
 b=hhVseMkdcg/XF4NiAEbTMHlhFA+l2O5qNUkuNh7tneqd3ECSRZmVfiMe
 qqJc+WzC1TBPfTrf06DAyJlTyj0yWtC8zGFjWOnFWahnGLk9u08DkzfVh
 miWbF//YxT4zAVO80gKnCEB21wwiq+Uq8+a+Lzt1cuGHX6u+ZPJJTZNeK
 VvXpgAmlXE+352FZin56PfNLsf+TdAyzhIqNoMFW+3YsyJufkXn0fnXrZ
 KYLyS3k6TydKWauRKIooj365UTMsJ18nG21IvRkPwmYFR/ey1M8Ucb6U4
 30AOe8zjc/J6ijEMLdFMyNaX11adRkdHtWf8SQTuCyA81fZxzSZo+Cpzy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="7124525"
X-IronPort-AV: E=Sophos;i="6.03,164,1694703600"; 
   d="scan'208";a="7124525"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:27:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYznetcp4C4fKziYqW9+PuOV9Hw+dQbww8VND6GnhHVPCg2Pnbo7WmXLI5q9WneuADS1HmsR2LFDUYWiVWayBXahVXu3j/QJtOdPKkHwpAKmusr6mDCdwlKrmXTANKFlS/QLVeD5J8sl+ZHLu4638I0DNiJrEIRF5V/TPCMTdvd8IX6jXUmEcJ2m55R6XxCutcnynXkcAPtyKjYjH8+OU/iWHPacjWzDWnDteRUxi2srZnkOD+jZ5lXiXTHuMIjDlSmYWVD25vjCaFLYA+53Ay54cwHqVcEgkWeLL3l4uuRB9u4Da3JUR9VFYiugsvxecWw9U5x37tQ4b7daznFsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxswWGeGJQLaleFFU5H9ZcIIHEC5g6Eu8CvtdvdWDAY=;
 b=VJpkL8V8SXpvvC6aMpsCdcvWf/9vtHAbwUnJmifBkL/ft1YUPEbyysnGaHV2O+/ZkPYtqz7OmfAwMjlu1OCj8xlJFyDmioCivcsvaU71er6JoyIpfyNxfwx8LP1Fg1gB0f4jAhs26NMyCAwPlZvlGvUU2QAUEdl9EBMTsBbXVVPuTgCdk3aRbLJ2cLsrUdrqOx0uZapoXJ+UzM33YWzcDYcK4ONhpqhvlOU3sIqg9GjgrDzKFckJkwe5nisUh9F7K3H7rzksgOKtgVHDaYD8EDmaQkXewlVK28C7RARBWkfiMsGB0bgSGd01685RMsC6D86BhoDnT34bjOlx5YmlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB10309.jpnprd01.prod.outlook.com (2603:1096:400:1eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:27:24 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:27:24 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Thread-Topic: [PATCH 00/52] migration/rdma: Error handling fixes
Thread-Index: AQHZ6j6LFBwwrEIGtUePddDiST4w/rAiXhoAgAKYSwA=
Date: Thu, 21 Sep 2023 08:27:24 +0000
Message-ID: <9224534e-2f95-4c7f-a082-725dd5eb9cab@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
In-Reply-To: <ZQnRKjo0M50BRbZh@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB10309:EE_
x-ms-office365-filtering-correlation-id: eaf3abd2-ee83-48a1-df47-08dbba7c9511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDub8JDivASd4aJslE16Wmwy0HCMRcOwv80vkZ+lqxPFzhdtRgY4sryyrKcHbtJhOIKFce3IfQk2yprN3jwXt8jiWp8A3gGueWf2/br/t9lkAWWnXoGYxXjo7N8I6mzwlky13XjVsmcKDZGEP36WFM7dNd/XVLiowYp+liEBqqsA4OogLtasC/mezsY7tCGp20TjtCTe+gJoicmLnvFhSM9THaGDKP+KMKlPKTMOrkv4xnpN0YQtsMi5rp7KBCRWT5+AIWue9rxZJD5LmsSoIr87/FU5ofHVHRNuTFj9dQ/1zUtA0HOpo0JzwNO7+UunM1b8BYvI9MN257n2gPksu2+LzEQHQQ6/GOYYWEJZJgh6oXg1K5XaFoFEYS31j3lerY6RTgmsZXAn1XP5z9rf8p021RXP+IcGhYGWU1HCH6J1uVd6mRP0KQFjWhSpo9wKDAVmmRMysN2O/+IiKi9TLPOCJnyB5y0XQTPlZMLbc0S1//3bYFJ09EoKWnh938oTpp1f/z81TBWtIKYfVWq01gLK8d7t1MVrboiPd3Db4Ij9S5EACxpN8C0oQQKUV/Fq+KV2JiAY62Z18FvTvVHTsSfHo57UXZqnh8H8fXAed/QsavIzS6E5oB9KSRbih7yvWiDq1KCnugrAuSnBgJ+hBJIhR8hzFz+Zhs5oEDOAabgRSpGYfV/GyPYw3r1Ilf9PxVrDTbuqYJWEdUseh1UFLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(1800799009)(1590799021)(186009)(451199024)(6512007)(1580799018)(53546011)(6486002)(6506007)(71200400001)(82960400001)(83380400001)(38070700005)(38100700002)(31696002)(86362001)(122000001)(2616005)(36756003)(85182001)(26005)(110136005)(91956017)(76116006)(66446008)(66476007)(54906003)(66556008)(316002)(64756008)(66946007)(41300700001)(2906002)(5660300002)(8676002)(8936002)(4326008)(31686004)(478600001)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3EvMVIyREJkcTgyQ1lETVdneHZ5djgvOFhTZ3dMb0U2UFdsTTVSRlM1L0lw?=
 =?utf-8?B?NUorTzhWck5qNFMzZ2x1N0ZBM3BQRkl0K1cvTzBOdmVMaFdDSFQ2WHA3YTZr?=
 =?utf-8?B?azhYcUFvT0cwbXUyNURpcWQxQ0IveUZNT0JUdERxY3c1b0drNXBXc0Rka1lu?=
 =?utf-8?B?U0hoOVYvM3dBRmhtbm8zUHRzcFZoTnNMbG50V1lJZDBUdGkxM254alN2TkM2?=
 =?utf-8?B?cmNsOW9GUXNDMTRrUkxlVyt5NjJKVWFrMDNmNXJpbGxmUUdTSWZTZ3ZsQ25t?=
 =?utf-8?B?WFExOURHVmJCUDlhS0M5RG1QZzZSR3ZrM2ZySkZ1Z0d2QVFVdDBMQVY4TCtW?=
 =?utf-8?B?bXRRWjJ4cWFhMFJQcFFzQzNoVFoyekR1c0d1WmNhYlZaV2dLMnlxQkpsQmp1?=
 =?utf-8?B?MFZqY2Y4cnN5azZUN1NrK2VUWUYxRHYzcDcreXJ6VFdQYmdLcThQTlZVamE2?=
 =?utf-8?B?d2xpcExMdENVL0NUV0plQi80UzdDMkxXdnVKcStLQTJmODVHSWxXSHlrWHcv?=
 =?utf-8?B?K1hoTU5WeDZSNXJrNmxEYkxsTTFlQnEvcGc1OEdqTlVEeG5od0NoWC9oVkhp?=
 =?utf-8?B?L1R1clI0elE1YmVQSms1NlBTVGlSOTk1dFdvK0w5bEZuVmtYZ3lVbkFNVHhC?=
 =?utf-8?B?RzJpS0NIUkJZZVhMem5ESEh6RnUzbWRCTVN6dm1UL1QwdTZsR0VrTGNyajNM?=
 =?utf-8?B?UDl2eFZiOVdRb2ZVRWQrcWh2N3JZbmV0RzNTTXdEc20reXhXRVdJK01MRkh3?=
 =?utf-8?B?TDVxVlEyY01sU0JvNitMWlJJWnRaYXlZZDJiSS9rWlBxY05QeUh2bnc2ZWxR?=
 =?utf-8?B?NVlBblRTc3VlWVUxcVlmWXprRnMrVGRDS1lIQ21Sb2ppQTZrZHdqazIwbVhq?=
 =?utf-8?B?eGc1d0c4MzFDOVprY1ZheWZMZ0RiTkU5ZERVdHRLODMvZVdVYkNRNnhSb1A5?=
 =?utf-8?B?eTBBKyt1ZEpFK2dvWVJhUzBJZUhGVmZRZEl1N1FKbmdIRlEzV1NtNDBBdlRN?=
 =?utf-8?B?QXF2RlRiT3lSWU82STRNanpqMTNqbC9ObVVjRkVmVHhVbklUMGcwbmZjRUJh?=
 =?utf-8?B?ZUltd2ZwSkU1L1JhOEFtZzlMb1pjc2llYUVWMzQyOVVhTS9neHB1WmxIM1ln?=
 =?utf-8?B?NHRacTY3SDlEaXo5VEllWW9PL0pzak4zdU9WSWt5bW85eUpFdUUxWmdzc2RF?=
 =?utf-8?B?ZkJ2MmIya0tzQ0QzUDg0V1lrajN0cmpJZVhaTHQ3T1I5Y0lWODB6aENuY29V?=
 =?utf-8?B?bHBsdHMzK0JaWHhiNU1ZYWhhSEFpUlRmU0FzQytpa0xmU2prNVU2UmJZbzlS?=
 =?utf-8?B?Q3c3YnBvSmpLTkVDaThwUDNhV01SREdJNDk2bDNEL0JPdnUyWndTK0d6Y0Iy?=
 =?utf-8?B?WnNhN0p6K2U3ZVFjR054REVOYU1LRU5LQ2M0ejVVL2FoVHkzTXYvWWhGNXp0?=
 =?utf-8?B?L05aczl1clpLK0lHK1BzNEpNUEVubGxrVnhUV1RhN2lLQTU3VkhKUW5BcDJV?=
 =?utf-8?B?aDVTWTJVRUk3ZXBReHNKL1hiMHdxUXJXYTVlbDl2ZkZCMDdoVkxuSWZhVkEy?=
 =?utf-8?B?bnBIWDh4aGhOWDJvMzZ2ajdsdzJxc2pqamJhdDV5S0k5VEhXdnRtZlVnMWJa?=
 =?utf-8?B?blJ0WllYc3lNdkd3Q0Q2cTZLN0Z4YVltSHRLTmN5WVlPdGJnSXd5TytMVDhE?=
 =?utf-8?B?TnNGYUNjWU4wNk1KaVlYbmthaGVRdmtIdWVQbXFmd2d5cFhZSnV5QnQ4WW44?=
 =?utf-8?B?Z2tJUWRQNUFNUG9OQ0VlT1Zpa05zeTFEdENUT0dLNFNxaXl2SnY2NENrZVZa?=
 =?utf-8?B?eWN0TmFSd3hBbkFEVEROeGkvdkVuYlZLQ0lmMGcxYzdZQkNaQjVnSWo5aVdk?=
 =?utf-8?B?Z2FrejRLOGtBZkliL3FwSGNUeUpwRUhSRDZiRVpkVEFYdGoyN0d5ZGZnNE5V?=
 =?utf-8?B?c3cweE1CNlYrUDI2bVhFQkVqY09USFd3RE85aGRmMWZoZzFudk54Z25HSnVB?=
 =?utf-8?B?bnNKZGlqZzZDZE5pMmlpbG9TK3FQY2hKMFpmSVp1eFJWTE1QRVAzazRwYnAv?=
 =?utf-8?B?TnhtK1dlTWxWUW5JckppQXdNRlBiWFI5TE1GMXlVNVNmQXZ1SWxXMkU4QXNy?=
 =?utf-8?B?NUlFNkJqakR4Rm5OajNlakZVYnJ2QzZyY3dpeit1eFdsQmNwcFFXYzF1OTdN?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207832817F459A4C8BA58937FC561DD7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E/8uxibb8KK15eOMGyi/2C3+Gw8p/BxghRoY/cC/XIJlm8QM6WvhCXvjs09hni/X+Ki1lcfn9QYqWF5ua4jA4ML7LTZDoof3MzhYDA0bnu69raHul2Ztw/vWSnYhEi06Ns2KpLlBYu+JQJ6h7kJER1OjE+LjjtjaLsZqRV+A0tTYx750pe1ODQ2UDSgaUJ8EXx1rOmBM5/rAyS6NlA/mNv5IyEmj/5PTqqVVMCOcKhK1m3F8p3tSltMmQp5dBKEKN/nf/UIO+u2lFSXAG5SPwqO0eAwbfbOhSxaSYG9STSGT+jgnGKyGNXU32KaDQMcQwPZ7DSuf+tT9uEbHAbgWAwjhQhk1WdfKvZG6pyW7nheYyF5fcMIlM+DkWBnw5e8Yp5SNz0B5cdAXSBLDWFu7CzNV7MWAt9oKvmVxTmA1F1kHpkD/QbNR41IH4vzYUKcpDalJPRxTLYURyGKm0vHv4B3KxYpN9G7v3byJJA/DDJpFPXd8ujBXiMGC40s1/USMPucx2geabf6aflIDdjtUVFRWJpilgLQDNlvgH92wEABIP5CihsxB2Ayb8EKdTWqXztX6CtFWs7/miG11GqtA4r35AdnY8DbWCKaAhYiuJ8mHQV2mCzd59jhXSem+yAqWFMyEHGXng6sjKERoG/KIpJtmKN2n/VXTwO6575E7rdGQTymHDWnnANuInEYQB8eEjBCN/pqUjz/o85NSQz1TL5/1YnxDdxh6dXnu8aims5VmVB34Hy0Xy6rVFfrnQmZt7d2UwKJjAfB30zemochp7Oog+2PPnf+eQLWiC1I9Cd8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf3abd2-ee83-48a1-df47-08dbba7c9511
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:27:24.2409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YvnL0mAmNzwaNNwP2YDzO7KzMjihv6qZzOCm9wsADFtUO4TTiZhC1x4cyj1c80Fb5iwjllhdvtauW0hAeD2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10309
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
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

UGVydGVyLA0KDQoNCk9uIDIwLzA5LzIwMjMgMDA6NDksIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBN
b24sIFNlcCAxOCwgMjAyMyBhdCAwNDo0MToxNFBNICswMjAwLCBNYXJrdXMgQXJtYnJ1c3RlciB3
cm90ZToNCj4+IE9oIGRlYXIsIHdoZXJlIHRvIHN0YXJ0LiAgVGhlcmUncyBzbyBtdWNoIHdyb25n
LCBhbmQgaW4gcHJldHR5IG9idmlvdXMNCj4+IHdheXMuICBUaGlzIGNvZGUgc2hvdWxkIG5ldmVy
IGhhdmUgcGFzc2VkIHJldmlldy4gIEknbSByZWZyYWluaW5nIGZyb20NCj4+IHNheWluZyBtb3Jl
OyBzZWUgdGhlIGNvbW1pdCBtZXNzYWdlcyBpbnN0ZWFkLg0KPj4NCj4+IElzc3VlcyByZW1haW5p
bmcgYWZ0ZXIgdGhpcyBzZXJpZXMgaW5jbHVkZToNCj4+DQo+PiAqIFRlcnJpYmxlIGVycm9yIG1l
c3NhZ2VzDQo+Pg0KPj4gKiBTb21lIGVycm9yIG1lc3NhZ2UgY2FzY2FkZXMgcmVtYWluDQo+Pg0K
Pj4gKiBUaGVyZSBpcyBubyB3cml0dGVuIGNvbnRyYWN0IGZvciBRRU1VRmlsZUhvb2tzLCBhbmQg
dGhlDQo+PiAgICByZXNwb25zaWJpbGl0eSBmb3IgcmVwb3J0aW5nIGVycm9ycyBpcyB1bmNsZWFy
DQo+IA0KPiBFdmVuIGJlaW5nIHJlbW92ZWQuLiBiZWNhdXNlIG5vIG9uZSBpcyByZWFsbHkgZXh0
ZW5kaW5nIHRoYXQuLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNTA5
MTIwNzAwLjc4MzU5LTEtcXVpbnRlbGFAcmVkaGF0LmNvbS8jdA0KPiANCj4+DQo+PiAqIFRoZXJl
IHNlZW0gdG8gYmUgbm8gdGVzdHMgd2hhdHNvZXZlcg0KPiANCj4gSSBhbHdheXMgc2VlIHJkbWEg
YXMgIm9kZCBmaXhlcyIgc3RhZ2UuLiBmb3IgYSBsb25nIHRpbWUuICBCdXQgbWF5YmUgSSB3YXMN
Cj4gd3JvbmcuDQo+IA0KPiBDb3B5aW5nIFpoaWppYW4gZm9yIHN0YXR1cyBvZiByZG1hOyANCg0K
VGhhbmtzLA0KDQpZZWFoLCBzb21ldGltZXMgSSB3aWxsIHBheSBhdHRlbnRpb24gdG8gbWlncmF0
aW9uLCBlc3BlY2lhbGx5IHBhdGNoZXMgcmVsYXRlZA0KdG8gUkRNQSBhbmQgQ09MTy4gSSBqdXN0
IGtuZXcgaSBoYXZlIG1pc3NlZCBzbyBtdWNoIHBhdGNoZXMgdG8gUkRNQSwgbW9zdCBvZg0KdGhl
bSBoYWQgZ290IFJWQiwgYnV0IGRyb3BwZWQgYXQgUFVMTCBwaGFzZSBhdCBsYXN0LiBXaGF0IGEg
cGl0eS4NCg0KDQpaaGlqaWFuLCBJIHNhdyB0aGF0IHlvdSBqdXN0IHJlcGxpZWQgdG8NCj4gdGhl
IGh3cG9pc29uIGlzc3VlLiAgTWF5YmUgd2Ugc2hvdWxkIGhhdmUgb25lIGVudHJ5IGZvciByZG1h
IHRvbywganVzdCBsaWtlDQo+IGNvbG8/DQoNCkknbSB3b3JyaWVkIHRoYXQgSSBtYXkgbm90IGhh
dmUgZW5vdWdoIHRpbWUsIGFiaWxpdHksIG9yIGVudmlyb25tZW50IHRvIHJldmlldy90ZXN0DQp0
aGUgUkRNQSBwYXRjaGVzLiBidXQgZm9yIHRoaXMgcGF0Y2ggc2V0LCBpIHdpbGwgdGFrZSBhIGxv
b2sgbGF0ZXIuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gPiBUaGFua3MsDQo+IA==

