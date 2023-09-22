Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F527AAACA
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjawh-0001Fe-Gc; Fri, 22 Sep 2023 03:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjawf-0001FP-QJ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:51:25 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjawd-0000JP-UX
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695369084; x=1726905084;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OKCGqxJnfCMecUz8GP5tnPXyAmAOlUgV18KYPGzQCes=;
 b=hZSWL8uQeCOF+6ab2MXr3y/1hRbRxrWeU+GoUQeZx4Bkc1RI/UKlNyEr
 N4Jy73a/Oq46EbfHV2AjhzRs/w6LtOxjXJrMFHKdSA41W+ubTBWsTLo0W
 NH/QZmLry/m69OikLyixlHuaKaIYUTDUqhdYn6bQxLx0vyWpJeWp0fhod
 J/nkF3IaqboPn/ayyR+kGauDdQvL9tWTAHvLwGueLh2mPgCdhhPisr3lx
 oj7IcwoflsI4TIKs3RNMml6hMnTCkV/h8vY5FPHDLiKIaQwciHYK//i7E
 N8uaM+mtv5cxqSlj5FQX6gqKT9imUlTjF1KLem9G6vExcGXc2UOjHUj0A w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="95727188"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="95727188"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 16:51:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuUpA4ZCbHDeV4h7CMchI5KRYq7Ez0mAsKDZQbySVcL+iBlxqZOItmSqYymj5G6C5i69a7/nZeGZlO9c7UHhGGcsXmJuliZiGU54BH0c9TiO+unnP9poBteZtry3IuLfPcbn+OA6D0o3HcseaKN/T6WMKRq5EJfi/8Bk/fexUtHMfihmQVzOze0L9Ob3cs/KoINwxjDsH2AFtwWz385Zp1ISFayz6KPxU4GyxyX0n7VvMnlhaWXaerIEurMgBFTOV3v+QAh6Jvf5eeNyHirN7YTxNXIba5yMc6b/LfUgp2T1IotFNFXBICSLlZUCtygmJnF0SHsfjnlZzwVnyhzmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKCGqxJnfCMecUz8GP5tnPXyAmAOlUgV18KYPGzQCes=;
 b=Io1zKOsTW2nDTwNlQpcdefFN7qg1qusoCYpeT2HFI2Cg/Ul8adKnalZfT728Hkf8VCLDc6KKFwE1I53CGDKWuLL6yYtxV3a4ePJgsqZdtQDICE9zLX7JVC8qNwnfSiZRO/NoybM9f9b7EUV+Nhk+FEnnIF74r8HQNgSG2ZKeYqpogsTCbT5Yq2ulvGhU+bwtTXy2E7vHm6hj8yUQsOe8kX2HTOgC9XlVgRd19QVqbkgXKzfq04izD0b4BUUTHGg/SsGRyJFHbltwej6hX50BiYOLF3CjAj1pZaF/KG7Rupe7uScJZohVa7AsuP8e8XA1wHaJbaXMtsq2O2hxZevQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10339.jpnprd01.prod.outlook.com (2603:1096:400:253::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.22; Fri, 22 Sep
 2023 07:51:15 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:51:15 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 13/52] migration/rdma: Make qemu_rdma_buffer_mergable()
 return bool
Thread-Topic: [PATCH 13/52] migration/rdma: Make qemu_rdma_buffer_mergable()
 return bool
Thread-Index: AQHZ6j8/3C2LjctU/UGuDAN8h93BwrAmfp+A
Date: Fri, 22 Sep 2023 07:51:15 +0000
Message-ID: <ca79a870-9857-ae51-f572-ca1ec86d5028@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-14-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-14-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10339:EE_
x-ms-office365-filtering-correlation-id: 52a61434-4cab-42f4-deb0-08dbbb40b2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FYPi4acmjB1qzoTyRWIU4x0uV/bXS4MPpBO2qSOMXCnYZ5uN6gUvZkN/pnwrIdz6dToYcIlc5BMWogoscShKQvaklrZIJv8ku2ZtHpuXf0kUkUbvV9vk/1jrwYxFZ6OLjBUwaTBEzLp7m45AVRFitJtHeV2H83HH4QKVyJXtnwsU5ucSodolxHjbY7paiQym56B2sdMv6/lCB8YKuWyYV3Wd0JulRRscfhsBGQtbTUGV0R04wR9rXSmcjkFWM4/lAbgI4cS8/tJO+kbuZe4pnDUkQxEAzPcoHyRBRQFOypZw4loJR+5jH3tjXoj6LgTfv9Hvi1VbaNhOGYIk5l8OaRfl0kqG02V2qLBJuMnO/Gl/IX5mSI7NaRd86lDBS6JfcooHVMuyjEFP8pxWUYYMX7KtUj4YBKKF0BRWxjFc27rx1E1NkhLeW2RDin745Tm4cj3zXTIBGiY9/LY28AnZrq8u4iVw6EvMFO36isdFCdFcNCS8uuteFdprZqt08vbS8tuZia3AyJ4+2tV9YEnNBizi9cmugrU9lp11ELDj6L4ddGs/2aXemoxbVTKBfH/nNyH+XoSSFFou1xT877mQ4BFlt4q3gYV+h/rpTAzhHjMMLTeGzUIVpMKF+VXnNPHltUiGhkFQXW2h7QHlXgHqJ4K4sdjc75XiXWcY0v6ohx9xSNBNyyzcdf+rMADeABlkLC5VYKU/sGCNXHh9Wn/xQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(1800799009)(186009)(1590799021)(31686004)(71200400001)(6512007)(6506007)(53546011)(1580799018)(36756003)(122000001)(82960400001)(85182001)(6486002)(31696002)(558084003)(2616005)(38070700005)(38100700002)(86362001)(2906002)(66446008)(478600001)(26005)(5660300002)(41300700001)(316002)(110136005)(66476007)(8676002)(4326008)(66946007)(91956017)(8936002)(54906003)(76116006)(66556008)(64756008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjVyOXJ5Tk4yZXpzR1lrUGxzSFk0WnZJbXFvMkNjbVNKV25zM3IvMWdBaFcv?=
 =?utf-8?B?UCttV2FtK0kwVDdRUytEUittMEdncmFjLzhlM2s3Vm1jMnZSQTd1eVJBYysz?=
 =?utf-8?B?eUhialBCS3ZTOWJGdnh6NmNYMFJtZ1VPSm9LQ2x5VkZOQUpWRURsZVhkUUdG?=
 =?utf-8?B?MDhKcmt5TWQ4Q1RoZUlyUzMvU3B6clU2WFFYelgrZFVpYWF5SWZOZGhod2JM?=
 =?utf-8?B?a3hSTitETlFSNzRCZjZmYjA2aWJPQW1MVVpXbFNBaHFpV3A0U01RWk5SdmFN?=
 =?utf-8?B?MW4yU2FiNDdJa1h2WXFsanRYTE5mTEphb3AyOElPdjFlTzQ2UFRRSmF5T0Nn?=
 =?utf-8?B?dFo2WWtXUU5tampjem5FNXNvcXd1azdmL1RTS3NPMkhndC9lY0JXRGNUdXdq?=
 =?utf-8?B?c0UrbTF4aFZXOWlMWFFyd1doREo4aVFudnMyOFFzb05uUjJ1TzNJbHBza2oy?=
 =?utf-8?B?dGxaZzY0VFJuTjY2Q1ozV0c0YkNkNlJQU3V1cER1aUlrQTF5c0VCVjlmRFVD?=
 =?utf-8?B?aFhRZkwxanp6Q2MxT080eTd4Q21jVStZVnFHbE50cFJsQnlvMmdIUDBGOWtC?=
 =?utf-8?B?QitRaGplNFA0L0ZCMXdLc2RqNWlyazhPK3Btd2NyS0RkZWxLdEE3ZEloYnFF?=
 =?utf-8?B?MktTUkV5T1RZVURuZ1NFelc5ZEs3VTdZUk0vVngxV2lvTnMvMnpLcU5weE05?=
 =?utf-8?B?QllTWVVyZ2ZTZnVzUlpLK285eDNFSXBzVno4bFFiNjRxWlQ2T3lIUWpFcG5r?=
 =?utf-8?B?NXFYeVlyc2s2SEhDYVFPdWxVYXBhckc5OFlDSXR2RXpqbElyNXpqdXJFQUdv?=
 =?utf-8?B?d0ZRZDBZRFBMaGR5NFpZYnppbDJ1UnV5Sk5pU1llZmdHMzFmd2w3VTVQdXYv?=
 =?utf-8?B?REIzT1JSTXF3ZXQ0dm9wQlMrSTJBMFpQSlF0UmFXSThNWEoxUmpIMFh5Ti9r?=
 =?utf-8?B?Yk5jZnBjNEZvUEdGeHptZlFFOVovU2p2NlZudzBNVlZ1Y1JBRVpDS1dUSFNy?=
 =?utf-8?B?aFhmclRjZWxNUW5HNWxkV1Z3N2xFZHRBbUVmRTJWbzVLWldLSUEvVFZITk9l?=
 =?utf-8?B?dnVyODNKeEtkNTZhQWRpWCswT1VTbU1TRG9BUHc5WWMzZjZnNFozY1FNMis3?=
 =?utf-8?B?eSs1cGFrZCsrRkxZZFVDNnlTZXh5T0lybktqZmNIWEx5M1MzYzVJZTVMZC9r?=
 =?utf-8?B?V21Wb1NFZ0t6ekVxOEE2SSswa2tpQ3U5b3puUXZQb2hTNVVmblRRU052NWtS?=
 =?utf-8?B?Q2Y2MFhONHh0bjRzTFI1RThlUkxoa2Y4MytjRWZJSTBRamVsaTd5Tm5XdGxP?=
 =?utf-8?B?VUxNVnovNW80YU5sTk9uRzhSNWFxUFdHUjcveFJ0SG50eGcwWmQwckpteDhT?=
 =?utf-8?B?V2ZEczR4WDRUTWNsTXFlbzYzdWVTWmxnb3U5aVN6endZTG9tQkZjSHVjbFJB?=
 =?utf-8?B?VDRRdXorWHpYRENJQzBEWHlnN1I4Q1N2d1dvMkFYakp4bjRleTNEV3NEZHYv?=
 =?utf-8?B?MEE3M0plTVVXaUhhbkZZOGszd0tHdVloYzlITXBhS1duUDA1Y0tqQ2VPT2VI?=
 =?utf-8?B?a1NjV2Y5ZUJBaUZ0cHlrQWdiMzhCY01NRThlUVVoS2JNaHh6d2dnZFE0cG9C?=
 =?utf-8?B?MkxIWnVOR1Y1cy9WRndCRUpLTTkyOFNhVy90UHVHMWZlQ2xsdWV4S2NLV2oy?=
 =?utf-8?B?a0xKb2ZtQ29UQWtpSTBaMSt6T0VqT3kvVWF3V3dwZm51aS9rZkVEcTNGRHBY?=
 =?utf-8?B?bDNIdVlTaSsrYXFpdWZKYWVWZko1bXlaeDY4T1YwUjh0REpaUGMxUXdpTndw?=
 =?utf-8?B?YzlhQzBmSTZHaXNYZWNKMlAvamtJTDM0c3RJMmZPOG8xVjgvYTJrZU9aUU85?=
 =?utf-8?B?OVNnc044aFpveWRFVnVoUHJQWml2SFlQS1dHVVgwWWFkWC9LZUJ6b0ZmMHhK?=
 =?utf-8?B?a0loazhRMHBjQzhuQXVlekIwS2RnUEhZSG1YMzlMeEgrZ0xaeS9QcjhCaGRj?=
 =?utf-8?B?Rm9sajF0MTB3ZzgzWHVuL1ZJUW1HRFdGZThzUGdSRnhCbzQxNSt6cDI3Y1Zn?=
 =?utf-8?B?eGxrRXdwa2dUWk9rOWpITjJpVXczOFRhNEdaYmpocU1pdXdmMkFOeDVQV0ho?=
 =?utf-8?B?SGdNRDRGVUpyZHVyWGJLTmpNTU9FK0wwTFZ3ZHFEaEtVTkpxSkcvVkF0cHA1?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71D147429AA71441BCE4BF160D032B23@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wPDJKhcku6pViX9tS9vZaxeGE6V4cOOy9BlNZfE0kQs1312cG2DCm6gcmIm9YjvudpmYMSVk7qhqfy3f/DNhM1tZX9SbCoGh9zNoc4dYqE0P3hSGYv+UzAs1By1+ijWuc+n6dYCjTh1IMG62sXnkaAnmU6m/B3Lxq6V4Hk7yxal2Me4GwPmPOF29Qf41hCLa/hSu4twqqCdQ4Rra0qxDRfO5HJTEKYnuhKgPEAfODqZxjH4Ta84PI99A3FWVryxdsPy5FLqBSaChuRo55o3yJEYv1saOBJAgnK61SaFy4JIfpIBVMEDHE4FLHjF7b9uH3BZN46he8ouBe9IG2f7nYhXIeOoL2px2sskSdquJgy9lNutV8xiV1F+QItjVuyKNfs4/fKxpmvnkz73tzkXFpCcEEMbhNPTGNiZfq/MSC3HOL8q4vW+4XFyP1jjxHq80U+R0E8skBIEJqfVJhejX+fnVe4kH19Tuaay6MBgNoyNBahCaVDYvGY75cctkw8B6rWToVM0yPVXSoq0rYtzsfjrdy4c6b5paheCHXmzuf1KfDkF2ITaa741rMhu7ck+p7DiJz1gebRCbNQJv3mrVE39LVFGRRRZPn6HucJ34LgBkKDg+8jnILOJyL4NcYN5mifD3WqCni7Ah+dCp2wCidoFcEw7B51vFUAtN4T1ae3zp1Pd5yKQLlTjVyvSBacPLV/YiznEQMaDsyTJDDmLmqNE9Qn5shXw2OXBAcLABqZdHzBXvdNLkx/dZ+CT5NKmrAPzHIdLLkjD8iXAeYwOvhw52VYp02V2ahXs+MFIEmDk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a61434-4cab-42f4-deb0-08dbbb40b2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:51:15.4404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knDhH6u1fJvwngKICFHoeuqv85oGYw/5Ml8T4NJdcn0G5tNR3FJp/SYBC8qB3XCSZkA4n6zebi6z43YrpI9+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10339
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfYnVmZmVyX21lcmdhYmxlKCkgaXMgc2VtYW50aWNhbGx5IGEgcHJlZGljYXRlLiAgSXQg
cmV0dXJucw0KPiBpbnQgMCBvciAxLiAgUmV0dXJuIGJvb2wgaW5zdGVhZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg==

