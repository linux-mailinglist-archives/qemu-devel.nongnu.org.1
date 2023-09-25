Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D393F7AD048
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkfCW-000598-E6; Mon, 25 Sep 2023 02:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkfCU-00058i-6O
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:36:10 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkfCQ-00084U-UD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695623767; x=1727159767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rww7y6r6fzZoC9+U++aSyqgKNLLNxUcga7PR4dAH/wc=;
 b=iT6sbb6y6dnEgO+fiTNEo6WqGML5L4uCuTML4G3mlZlMJ5SEavYc3siw
 u3G/XkT7GHYWd1x86NPpihPhhSDN6V5a7feQ0+t+YG2LJtqhgCwycF244
 oTWLlXc1w3331R3vmSTuDBduDsPjFtwmAUvnZjmTYczjYQkszBf4hgiai
 5MqK+R414xGSdUgB2RBDbC1zcoon9lzz4l3Iza1ywbPZgR9kaeLPgbx+N
 O5C4MrUYERJmD8JNf0PwmYNfcOJASHX0eoa6OPGkyilQWv98q4p21EnT3
 a4hxUApPe2hET/f9f8D2/GPAakFP/aGVyzMs173HD+TFFIme8mFVMEv3L w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96101797"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96101797"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 15:36:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyfwAuT4Olkwc7F+w9eJQs3wRStOEEMyvxzolYGiQfSmpzWyl7UvDnhICXEbfVhcIX4K7L+hfTpXhFEHC7p6i0wf6P1sd+UAQTFkBVhtY/Qpdc/i4Q15Y0if7q0uaerHb0RJh+5uKnEIb1RJJoqu3yagHkDbBvggN6XEcmY9A8KRsJrMUNQB/gLPV4Cskjy8CLwvO4WQoDrufbIbSc4irg6n+WqOUsBrgqotsv7Nv1QkX80tmDqUlUgfkSuB45SGwB3hyb30wLOyRLDJc8LJYx43P7YKQA1ALR49EuDHgqXdGvTcfhTABJtrSrs2AK33MZsciu3thbVUhwxRQ8/zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rww7y6r6fzZoC9+U++aSyqgKNLLNxUcga7PR4dAH/wc=;
 b=nCU5yLzZWf/bZR7Ztpa2U/TPVkyBQ6SMj8mtj6+Y6gz/jnuw/2ML2iFaIH6bIAeLckXuTt1EIiMyBmLcpjjz65ndXpZ27kacYqJikGc6zTtOAxb94W+vI8VGC25ZAIypfY/wSq2ElMPC2EgXnCK1KIeXG8Z+J0HaZ6nV91aj/j69KhKEBFWWhWEIE8+ze63CdTR0FGySwzsTBhL+t4O9Dw+ZXMAG7U6BDVE80lBdP7Wb+OCefTlBmo6Ez5/SSTVLQPQ/LlBpZlfJ0dxDUTyeCSmhoDI0l+KT0DnYcinHG0A3jC3T7zmUQgCEOmX/wsR5EFYoYAM1il//nvd65/ZD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB9645.jpnprd01.prod.outlook.com (2603:1096:400:1a4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:35:59 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:35:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 30/52] migration/rdma: Delete inappropriate error_report()
 in macro ERROR()
Thread-Topic: [PATCH 30/52] migration/rdma: Delete inappropriate
 error_report() in macro ERROR()
Thread-Index: AQHZ6j9ldnjPR9GfdkGwwDLeOeeO1rArIJWA
Date: Mon, 25 Sep 2023 06:35:59 +0000
Message-ID: <5580393f-6754-efc1-7da2-c18c4f54376a@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-31-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-31-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB9645:EE_
x-ms-office365-filtering-correlation-id: 50b1f919-5892-41bc-d6b4-08dbbd91ae1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLLUszMqq6jNtqhjETvJgn9UaEKO4uLPOEAg/PqiHaaSI8eQ6mM4KWHkqkojH+/PAqX5HUMeL23CR2Jn5EGj2q6OyOa5XIpwxGSiPOzdDjq607cZHcpjAzGjWhpCMKVHLz4rOFeZux/nW/j0dWujDQRENFTr3xaSWrs9pDF4QwDBXVj2McuGHIS8SqR0++JegYnBXbXR4ZgQFGPyKcIFDW4etxHVMFqIAPLf2ZCN+rZp8CCYM0S2FAPtdOMZK7K7cB8R2yRdPamwtoCYEyoalImBImeMqb+FF8nyito/4w7+LaUMdGvoP3P2ZFHwO/lRCkKiWXOyv1WoinnP3uY0ijgkcmNvCDK4GCQ1P4TldU8F9hsC81X9HjJ/v2gh/5BlwYEdZbGOu9rNaRt3ST5y/64fmSQaU14zcS/n5jcyM35yz/Z+0tFds0/l7bTsVwReyjlGkmo3c00DY8eR+p3TddtTIlNrkvwv8yINex/nkhbizQbNK5A2qLkRhUrH1HT/BHwYM8Ph+5qE4BHEj+lrcT12p0q7F4AR8QkvQuEJanvuQsPy3zaIh9i9Vl5jGiGDG8obP2oikBRxJ99ulgMrZlNmkJNRniD3jMv8sbZ+LgdvrspRZgtycoNBZra99IqU4ohvDzBzt5q42rrFY0cH2VzgT7HNrk1lIOzqz3j1N9Q0hi7OsvORbX4AqigXobNwWXLF9I/ApGxTQxQrXdxtgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(1590799021)(186009)(31686004)(1580799018)(54906003)(83380400001)(2906002)(5660300002)(316002)(41300700001)(8676002)(8936002)(36756003)(4326008)(85182001)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(31696002)(110136005)(91956017)(6486002)(53546011)(6512007)(6506007)(26005)(71200400001)(82960400001)(122000001)(38070700005)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z291ZGFtWGxtMHVhUVp2Q3pIMHEwTWZEaXFZaWc5c011eTlBWEg0ZUhOTHNI?=
 =?utf-8?B?N2dhenp6WlNHMzJVWDh3ZFNSR2dobFdtc1dnTnUrNHlBa1R5aHhSYlVyMytU?=
 =?utf-8?B?WHFHVHdhc2Y5b3huL1ZJTzNCOTBRVW9SWXR0aHdZOUlnUXNnQndMckJzZEMr?=
 =?utf-8?B?N0N0ckFaQmJIQlJNWEFidDBsNmtVY1RsS2hmZEpaM3pJazErcDh1ZWJGRHox?=
 =?utf-8?B?Z2dnYW05dDJLVjc1M0grLy9aUG5TZXVsZ05ITFIrQkZQbjBKWmxXLzNNdXY2?=
 =?utf-8?B?YS84RFBVWEhySXhaSThPSzJaL0haZmtoYlI4TmhEOGh6bUhQRTNKSzJCdU1y?=
 =?utf-8?B?YVlTMGVJelZZeGx5bW9MRWJ3dEVIL3k0MUR6YWdNd1Z4SU16cmpKdG5vZlZj?=
 =?utf-8?B?LzREQm4rMFZsVGZhNzFmVzAzQjNzcDBPc2NPaEg1VkRBUFVROUhtTkZLTHZL?=
 =?utf-8?B?bFdlQ2ExWk4ybGFQOVEyb0xvV2tzWEdxcXlXYklLdWtEcFdKYm1wWGFRMVZW?=
 =?utf-8?B?MzNERGhiYUFkMFRlaThVS01qamxPSUdrRkRlZXVmemZDQWQ5Z1l3YjlJcFVt?=
 =?utf-8?B?K3RlbGUzaGU1NlFObzZPNUtpRHJId2xSL1VMWHFFQWhsTy81K05POExzSUJW?=
 =?utf-8?B?NDhtWUY0Qy9JNEJhbTAvTzc0T3NCWDRsTFpzWXVHazNyOUNCL0p1MWhLZG5r?=
 =?utf-8?B?eExxZ2JCWXBtcFpiZ0VCZVB6ZldHd0dSNk9CTENqT1NHNFh0aVVRMGYzL1Ay?=
 =?utf-8?B?ZjlTK1ZWQjJBbVJLcUEvZVFnQU1tdEp2MXpWM0lPUGFrZXR4Z1AzUVVxRkxE?=
 =?utf-8?B?VUl3MWxlY1UzU2I2QU9mQ0l6TndERmN1NmNjMERTMSt4bWhHTHE2YW5Va3ox?=
 =?utf-8?B?c3B5RjVCeWprbWdQZEh2MTBvbkxZT2N5cC80VU1MbkdFZDhvRW5EdHZXcTZQ?=
 =?utf-8?B?WURFbFl2T3paMlJaQVNlZWZySXFOTEFPNjdvTkdSTmFkaWR1QmFyQ00vcDl3?=
 =?utf-8?B?U0ZZZStqTVhEdTY2VDNtSEVPOS9vRkFla0FqeVhzd2V3anpXWURlODgwU1hj?=
 =?utf-8?B?bVhHaDlFUkd0U29pSFpoYllSM0UxZ0hweHlmVW9vcU1ISGtLRlgwRUNaekIr?=
 =?utf-8?B?eUtQZldlOWN4aW9MSXFYUFBBSkg0cHlvdHJjdHZVOW5qM0Q5N213RUVZYUNY?=
 =?utf-8?B?WXR4aEsrRytuM055R20vK1k2RGNBUUpzOHFZRy85M2d0RlhtbWgwQWN3a1Ru?=
 =?utf-8?B?b0xwemtuKzBjQVQyeklwQ3lVWkxaczRYMGNBUGxtZTdLYTBKM0NoaDVVSHdY?=
 =?utf-8?B?Q25WZ3QvdFFYNVY4T0ZIWHAxQW55c0NNbGZuL2hzeFJQblA1MEExTEZDYUlv?=
 =?utf-8?B?SWlVa2RLaGN4dmVsdkVNbDZBY0RMK2Q2T3RMYWdkRktPUVVxSWphOFpnVzIz?=
 =?utf-8?B?dXNKandrU2RuUjV5K1NEZllvY21pSEx1MkZnbzhyUy9zQTBRYStyS2hseWV3?=
 =?utf-8?B?am8xR09JYW9iajVSc2VjTTRQMHBoSWFTZ2hYQm9OTzVyc1dIVWtZY21XYWxI?=
 =?utf-8?B?bFpZYXBiemIyN1pSOGUyc25aTWtoSDVhQUVvNWhVbWdzRWJuRExKYWZSSFI3?=
 =?utf-8?B?UTJ3Z0Z0c0ljcys5eFV5V3pKaFVhUW9RekN1cGI3UHQra3k1alc5bDVicmpx?=
 =?utf-8?B?NlFnUVg3SjNQK2NYcWk0a0lQbGpHWWlaSE96YjRmWlJITG1XUC8rcU5aYlh6?=
 =?utf-8?B?T1F1V2NCQXkwb3h3dzIyVFZnekZoQU9tL2hIQzA2MldScXl3aG5KU1N6RWds?=
 =?utf-8?B?NU5IbEN6cEtMWWFwQitxMWRuMWdLRGo2OXphMkxhZVIxVy9SbDB2TndEYkM1?=
 =?utf-8?B?OWVIcFQrd0JFOVM3TGw2VTRHQUREQUxxS3FOWFBtRUl5S3RZL253alZaU0s5?=
 =?utf-8?B?dnhOZzBkOHFIdWwwT1g0YS9FS09uNVhSNFFISVRzdjdCY1dkbjRBQ093K1RP?=
 =?utf-8?B?N01oaEd2SjRaaTJ3S29kVzdIcFpQWGFUb05rQ2NBTXMvbDByT3IyWHdON0Zv?=
 =?utf-8?B?clFZRVdKYlAzTjJkMlZ4VDg5L2l2QzRHWnMzdHFxaDV2c3NjYzJTZ3NlUE1a?=
 =?utf-8?B?aENnUnIzeGF3WWlvYmFIbUNpV3JSRE9oVjdqdVZZci9WT2FSdVBuZkZtendR?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DF43C5463E7114FA050A0BEDCF21B88@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HGAPpzm2pQYLIW3P1Rm1qUhNX3tkCD2guDiBiMWKh36CEwiH9Hctpx+Wb8mFVuGQ6QZHPE8gwE3cHjmWTzLxuFxIfUPiL5elGk87p16nPph3Og928BDN19C3Mn5HbR9Ezum6bQfnI03iVJeZJTYFLBmr7LCLtgHP3LHvUaFNvyHFVp3wFB3nfVTF9oAKiZjE4IOLRG++hzptsg1E2yNOUZB7Wr+97oUwv9JYN1ppfnllA4SWWv3V7nMBc5RvkrZz2Fj7u239oON5sOPxWqZOekUHBNbcYthKSFi6j+kzsZ+5gZePzhWaVi8MeOJI4DXQo3Wf0W2SC6T3TrrF4mwXeCETqPz63fQgijDQtUax+ovhA4HQatC/2PfJqWTF80p5uHt1J/khEW10TqMHKahCt/4F/gVH0+1xbPb8TlOjlmdNvanzvwqkGUa2l3bWFbToiECOY138qethqwy4AYLOxO4GUGdH1AiZQ1iAT27j/GBpa04o3QP0pw3J/F/ecfZMSptIwhhULKUaNRNq9AXwx+rtGHuGbA7wukq0mq0JHiH//xugy5egzP3bh2DaWO8bNKtD4V11Uk4ZDH69DJ+rMbhvXsr1i9bD+CrWCJRor9Smfz7Qn1acegCAyO5fyzmo1XPjipuTTkLuw8bJjXHuIx6rX7hMG2E45Q3Z9nRbLYRx701uGMccc+HFKwMK8uS/5nyE9XDR81CYfficerP53Fuhy9GfMBxGj2RIyvE5QVZZ9r8l8yYTEGJL3Kp4j3qoc4COpbi/ZHv6/dqo9rqM1Q8NCi2oWkw+05LRru/bE8c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b1f919-5892-41bc-d6b4-08dbbd91ae1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:35:59.1722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzlIsezH6rM3CUXFPfXd1PtFTWjnSyvkUS04LYsZ/XQNrLd2Wkj4OX0BYS91H30e8exe+MJda+yAAV7slQpYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9645
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBNYWNybyBFUlJPUigpIHZpb2xhdGVz
IHRoaXMgcHJpbmNpcGxlLiAgRGVsZXRlIHRoZSBlcnJvcl9yZXBvcnQoKQ0KPiB0aGVyZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KQW5k
DQoNClRlc3RlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQo+IC0t
LQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCA0IC0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0
aW9uL3JkbWEuYw0KPiBpbmRleCBkNTJkZTg1N2M1Li5iZTMxNjk0ZDRmIDEwMDY0NA0KPiAtLS0g
YS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAgLTQwLDEy
ICs0MCw4IEBADQo+ICAgI2luY2x1ZGUgIm9wdGlvbnMuaCINCj4gICAjaW5jbHVkZSA8cG9sbC5o
Pg0KPiAgIA0KPiAtLyoNCj4gLSAqIFByaW50IGFuZCBlcnJvciBvbiBib3RoIHRoZSBNb25pdG9y
IGFuZCB0aGUgTG9nIGZpbGUuDQo+IC0gKi8NCj4gICAjZGVmaW5lIEVSUk9SKGVycnAsIGZtdCwg
Li4uKSBcDQo+ICAgICAgIGRvIHsgXA0KPiAtICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlJETUEg
RVJST1I6ICIgZm10ICJcbiIsICMjIF9fVkFfQVJHU19fKTsgXA0KPiAgICAgICAgICAgaWYgKGVy
cnAgJiYgKCooZXJycCkgPT0gTlVMTCkpIHsgXA0KPiAgICAgICAgICAgICAgIGVycm9yX3NldGco
ZXJycCwgIlJETUEgRVJST1I6ICIgZm10LCAjIyBfX1ZBX0FSR1NfXyk7IFwNCj4gICAgICAgICAg
IH0gXA==

