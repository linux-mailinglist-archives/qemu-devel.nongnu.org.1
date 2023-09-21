Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB87A7A92E9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFYD-0001ZA-Lf; Thu, 21 Sep 2023 05:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFY4-0001TP-Ei
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:00:39 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFXw-0006cG-Lm
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695286829; x=1726822829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E22Xp9+0heb8XaTuQsu1TXVi24zNOUUbfZZAlk61RNo=;
 b=r6tULAjI9bJ3SZrkw8b+od4A6u0AQJaAMRiOGkP/LAtmO6UzIPs13DlT
 euMPU3pCewU3rGTtnanYXQd1OkNQSLfkyYUxnJVR83YXLIhaSGDDCo61S
 uoF65KknoY3d1X3FdnQXkCriDlQIzAh2kwUxlZ3Ay7mdTE1JLv+1e7FIG
 lE2xyMbKzDq8AoVRdN2oF9yuLBYpMP34/5KLwRkPyMLEhW0Ra04aZKnih
 8aL0OVa5VTI/wsnKD+snk7Ix92LtonjWomF9qBE835Kl3+7NsXJ2FZuNX
 UCpANdEwHaqZlxDi82GVAeTP54RRTDH8qg2v+Q8QkjNE/bupmSaGRlWpy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="95981088"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="95981088"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 18:00:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkpNuZ1bhP0uBLKa0sFjofmoXK/wgwMMzu/02FPstegp2uo8RW1DzaFV6VAVQFxSUav8EwSMqk2NJZzuVAGsO52T9w/t7aSIJtLsnLUfe8xLsyFergOv53SZfFSHA6j5txXlhHLOiprg3uioT/8zwA5t7wQblmxMIL4qDLtqXaR5GRDMkAecV7sxYxIselQtc7Mj756pf6BTt3BOz1O0/RLd9NVnqI4ty4AXtXm1dBABJzuHS+SmlFNz9rmZrFHx8i8UNd2uPJzuyTYnfM/rf6cLVHhoygQx3iw787bd/A/jWYYY7WY0njSaYofIKxsIOp2Gg0qq+bw25Du2oCFukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E22Xp9+0heb8XaTuQsu1TXVi24zNOUUbfZZAlk61RNo=;
 b=A/TxH/oOXFEt6LCy+CqefkAP15zBy4Q2BmHyFk1Iv2WhqDrdN1o49RA1HsLVZEzffA9DmrOy8/1mS7PyBm8Pzg/vxq9Sx5krNiwRd9CmbR/77GcL6uj8BnPlDc/e/A6fFg+m70On1GZrgY3MsTOaibgq6H8HUWiI1gMyByvLuxOVWJQ8KQuKvt+zOzlXfsjElLszwxyk/pHfhG2WsOdXqHmvP8ICieMYcKYyA9i8k8lGiw0aWkSUo7VlV5fMOnkBW8U67WGOCrwIUVM6VJSs8LOkAZmNbs/XtDB4fTBowvUUBplZ4Kld9a5jw9L5C6yhRcmfOvTGN9dpmxE8+/fLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8864.jpnprd01.prod.outlook.com (2603:1096:604:15d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 09:00:21 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:00:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 07/52] migration/rdma: Give qio_channel_rdma_source_funcs
 internal linkage
Thread-Topic: [PATCH 07/52] migration/rdma: Give qio_channel_rdma_source_funcs
 internal linkage
Thread-Index: AQHZ6j9GOZzWjTTgYE2VLzwZbVXXuLAk/5iA
Date: Thu, 21 Sep 2023 09:00:21 +0000
Message-ID: <9d45e30d-9e28-aac5-bfb9-79790d8fec83@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-8-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-8-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8864:EE_
x-ms-office365-filtering-correlation-id: 806179b2-0bc2-428b-2fed-08dbba812f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g45KnWrN4PjYh7s+B9DtqpJE6vuAyRjQFuOsIDWsA10QKFDO09QlF70wPnYZ7IWf7CTXf58npnMl8gdGGzL46zJgq4iCUU2NDVAP1Z+WjASZsHfSr7TSaGkeWALGMbbK8zdL9Ot7zf7gY7gRxzlY7KqrUDJEtWXStXnwGeUz0U5DV5DCOeMw2IHjhvURzFz8lxipYjqZwSeRb8ydtQhLFLsSXpXXpPPMHFHv1EyB6/tjympJ0SPG6G79+btbWp4c2Pa7NQlEFe2f7b2lS4SdQzZ84mWv+xf8vad9ab75DqC7WYLXOx6xH0Aswxt7zU8VH2tkf/4zEsmuIXEUmoX10nGaryOt40ISaYtLkVxiIWBQmRzTFPr/G96Pv0c02Jo/R0C1MqFUiox7NENNoA+PWAbZMyzjnGM/o8F5LbyCd8Usso6v2GrtRwgWCj67lQ4U1+mFtqsW1UwnTFX/7akG0OiHjO148VMlugpFrvffXbH12wO2ugVRbaBsjwXYuOZ9uWqdnVUkD+md9XECs0XRmf5Gl4rKPohyCblBVT+zojVv8MqrpJZUh7zovK47xunsdlypQtgQgBeygPkzhIKqJHHX25d/boom005mFBRwKSH1MQBn5gnj7092+niIDmi4eU8QnWyJQ5hjnIKI39adfG0+qy7xIWAAM5hl/d+laU++vN7eWD5kf3Bq1xMfwnIrEKYq3TzOWGsg3qGlbZD9Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(1590799021)(451199024)(186009)(1800799009)(1580799018)(6506007)(6486002)(53546011)(71200400001)(478600001)(26005)(2906002)(66556008)(8676002)(66446008)(66476007)(64756008)(54906003)(76116006)(66946007)(2616005)(316002)(41300700001)(91956017)(8936002)(4326008)(5660300002)(110136005)(85182001)(36756003)(558084003)(38070700005)(38100700002)(86362001)(82960400001)(31696002)(122000001)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UER3bUNEVDI3Y29ZYnVUdTl6OXErYWRsSUZKNnozR1J4RnZwMFRXYW91SDZo?=
 =?utf-8?B?NjhmQ0lMY01tQnN4d1A1UXhNODEzMVpEekczbjRGNzMxckxtVUplajRPNjFV?=
 =?utf-8?B?UFlJbnZsZDBIaVo0ODlMZVpUMVhjWE9WdkVMejFwc2Zjd014cmxRUVR1anVm?=
 =?utf-8?B?eTBDMDArUmljZC85NmRHdDVKWGlXRWIzL2JMRWYvYzlnK0YxWHJuSmdPZ29J?=
 =?utf-8?B?T2ZhTVNjRDYyQW1MV3NiWUhXMVI0b05WelhTMGtBY04rd3NNamlOMmtzTC9N?=
 =?utf-8?B?em5VK0RsYXk1aUgwaGhoNVJxYm9QbFlKWjF2cGF0R1BQOGc4alJ3UlBWTmVC?=
 =?utf-8?B?a01SME0vMHVmUm40WEUyeUtTZGJXOG9IejFIbGIvSHJDSnNETjFSZ2Nra3Y1?=
 =?utf-8?B?Nm5YdFRvYnZYclJHY1dNRjh2RjVsMm8wL3NZbVE1YzhPSzE0VEU3dWg4R201?=
 =?utf-8?B?ODUrWThEN0dXcGREU01Ed2dZWHY5ZkxqVk0rM0ZrVElVaVpjTDk3endpQi9E?=
 =?utf-8?B?ajh0WlVYYUZjQ1lidEVOMGdUTldXUDVEVnR1QTM3NElxVjg3R29KLytMNllS?=
 =?utf-8?B?Sng1TGIwUDJpS1FXWG5YK2RBY1VxUkZ3WkFiNVpTUDB6TDJyVEkzUzNVdWpu?=
 =?utf-8?B?Y0pTdk9WYzhSVFVkTDA5cGVpS0ZvcmEyU1ppM3U2VVNmZFZnWHpKQ2pRSVM1?=
 =?utf-8?B?S1d3dXE5MG4xdGkwMnZZTGVwckhxcy9SZExKVS9EVTBIaHNqaFM1a2NBUXl5?=
 =?utf-8?B?VzFWQVhxeHF1T0JQNXBBdllrelZwbGtLZUhXTytPcFFWTEZvTVZQUUhBQlhh?=
 =?utf-8?B?M3laUVFONUpRTWROelk0cEFBV0lhL1ZaZnRueHhZN1JPMWxMdWxkRmxrYzAr?=
 =?utf-8?B?QzJyYjdlVklsQ1dQRTBpNzV6QnFDUTFIWW41cDk5c1VRekwyZlFyeWkrV3lW?=
 =?utf-8?B?RnpsN3ZmZ3dDRzNWTkxRcG1WcTBKNjYydGZtNW5Vc0pDRkRLdUhXWmtUT0xB?=
 =?utf-8?B?bEZHbTJqK0NJL1FmK0VONVNyVGhOSlFCU3pBYlBBS3VVSUtkMHkxd2J2Wk4z?=
 =?utf-8?B?ek84TlZGWHM5c0tvNi80T1k0dFBaSGpBZEg3eWFhTkp2dTczZkoxc2g5SE4y?=
 =?utf-8?B?S0NsLzNDK2xoQjVxUG0zNnZpOE16ME9RWTUrWGE5UUUvQmJvbTI3SnVFTkpG?=
 =?utf-8?B?OElJcER6cHFwYXhhajJIYjdteGVBVVNlOUlkMTlDVW9HMndSNFIrS0NnRzVp?=
 =?utf-8?B?NlY4a2pMeVNmc0dvRmJPZEp4cXJQSkJTN0pyLzkxclZSdlliUDhPNlJZQncz?=
 =?utf-8?B?NDU5Qm5HUEIwZTZNV0RNV1RmU2FpTks5WUhMR2VFT2FWeFB2UzdkcFQvTnRt?=
 =?utf-8?B?dXNGYUZOVUsvYXJlRmdXOVdMZ3ltYUJTSHdKQk1qTEs0NnArUGdwbFNtcjJp?=
 =?utf-8?B?N1NZRitmQ2FwN3J5eURjK0IzdDJCNkZMN1YxTUlwa250WWVrM1pJRnMwc0da?=
 =?utf-8?B?S3NPZmg4ZUlEcHpKSW04OTRDR1N1ZUNFNERBN09DT0EreW5IV0RIRkF0ak1x?=
 =?utf-8?B?THZralo1cmxvcG45YjNEMHczRHUwWmRmSGVmS2xaMjBHOGxqN3hTYjB5dXNN?=
 =?utf-8?B?OFdXU3BVNlh4bVpuZURtclhzeFJ4ZUErbEEzWURPZHpnMkc5UmJrUkZFdE1V?=
 =?utf-8?B?ZFNGRm81UDlvS0kvVEl3emppV3R0Z3c4bFhORlVQWDFPVHcxWWVocExObFRj?=
 =?utf-8?B?Ti9kd0F0WVdmUHFoWUJsVlA0c2xrMzJvY0RzTEM1QjFadXR3RFN6U2E5OGtz?=
 =?utf-8?B?TThORThxcWI2OEYweDhYajlUL0QyOFZ2T0hKNCt2bnBBZnpscWl2RVIrOG1Q?=
 =?utf-8?B?b3FEb2JnMGdKNzZ4aUdneCtDamduL2J6WVJPQ3FtUkpKTUNROFFCamVEWGQ4?=
 =?utf-8?B?VUxFa0E4WHpPMjgxZG13VXZmcEJZM3lnbTFvd1IwQXpMME9FUTBHRjRZbS91?=
 =?utf-8?B?dFUzeHJHZE9FZjc2bm5KV3BKZm9tSjhuQ2kxcUlmNEgvNTV6ODAreEoyZXpL?=
 =?utf-8?B?K2RnOVV4WHlMTUxFcWZOMjhZMTQrcFErQUZTeS82UmpaQmwvVEVzaFZxWFgv?=
 =?utf-8?B?aFBTbVRLTmFWbGI5cmlMeElPR0E0YkxncGxndWs3Tk5ZTGR6aGNlTFZ0b2xO?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6060502EF44DEA4A94A2E8423A491DED@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 18nS6fgkYKs4MTS6qqjr/UVcnzLz6aCRX+v0OQ+wz3ASqtLZvE9Bzy/0FJfZIfuArZL2AhhJ0VMzSv//EiyTQa8VaBaFewvzaFwtFsddxkFVXgMMmkiHf5QfjGlackuIgGQXNDyZbWR54QWK2xzfdr5GmsEZGZKyMqHauhgsqAJaRm3lqb4Es4/fuT1Z6fTvZm4PhXBCZaJIcNY5xE+NAbm9Woha/rszwAd+LKRQLhBJ4RLczHL8B8BiFTVHm/gebzJcyrBaaSmHPnohEOAmRZKMs/CiYXUivI142Z/4UU3uTDuhXTJpG7Ds8fIRtWXdcEfPCwnETAnwaSIRdQBJcv8firwc6jVfADHGAe0pmYwXb8t4hfXlu/6OJzebJWMApl5x/3DIK/Xjycee+OZbSdr4V+3aycQX3o0doMhrGdOguQmw2/gN+3gJwI4DSsDCirxEC0x0S+tyAOwBz3tnWgM5Fh7ASaxwM2kzJjkdAAxH0Knbf+oYUS6rB/o7kxvrT1RRdYlM4txLVaH/SOQ8eGyLAZYqJUFZJlZ15+QIQ4A215D0nQ8lUfCbI96R/nqiV5brZ6f9suVvnpraF/Mu8uMiwgsip9f2s/KRyu+Sa5O6hmxyCct/hmNJzfo+74Ohbn2ELhMZD670bzipgS7pQygc/pNWC0MTdhO8FU032eQzy8bHkDz7mWnsBVjgZlA+babtXqXtbtfBpdbyHvjuzd892+L9V/UBwjamEP1nJ7GvZoK1qYo24lUXsle6erDEG4rAs/dtfk5QkLmCW826oTXUdnFAGq7wV405EUnp2UU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806179b2-0bc2-428b-2fed-08dbba812f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:00:21.2947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXc9MgsGS6lF5pyoPCzmls9LAqBdv3cIUM2kqlsHbA51lq6TKjYoDpshacOLrmo//PA03JSjmDp/1e9fuASS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8864
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmll
d2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+

