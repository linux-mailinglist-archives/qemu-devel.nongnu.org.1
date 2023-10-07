Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAA7BC4D2
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 07:37:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qozzI-0000QG-Ps; Sat, 07 Oct 2023 01:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qozzE-0000IE-5I
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 01:36:24 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qozz9-0005Ux-Pd
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 01:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696656979; x=1728192979;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Zz3kc/w+zAMBx/knG6hPWJpAGHsqKMWEk88QYbBhvTI=;
 b=Bq/E39e8+7d14CFX6Qvz7CsizBZG3JlR1rdkjUPdysplB8A5CdFNuKWe
 fQqUx7wPVFA16EglvuWebfJN595ACb1tJzhtJYPDthXyYY8vzt1OSFWjX
 cSVOjggMJv995znua2qNyUQA95I1435dzkEip/6VILAWKXAzfN7wHPmrm
 1IUv+xVG5taqfQ7OZu656CtrqWik76V1Bl/o7xP0Iq3+Hd7sp7txp7V0L
 dRPOsBx4ghNpGirGxzQel3b2zQI+7qI/z+QrUdMW11n13EA/tXBe53fk2
 xEZauKC4MaDxkvNnwhK+FlvE+yhCl4JP5IJTGxMaxXy7JPHlBpjiHyN9M A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="101463898"
X-IronPort-AV: E=Sophos;i="6.03,205,1694703600"; d="scan'208";a="101463898"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 14:36:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfdh9pxSWbZ9wLhXoDlCWerPCJQWaDuUur4jr7cVfeXOYKC33Yq/eH/lhrRXE0LDjk+TF/5tZP18zDbR0k7L+ztZvX31sDXLeRRjd8BtryO4wH/hmnw91ia0vtqN+2FoLr5uPsKpn9VAARVEIEsHBjSBvK+5o1EZdFDN1rF68hc/MM+nM0guh0THcj1Eus6KRRYC+USG5JFrHCzoWDRlfTSoI60Q9gaP4Hyw+r/1td7I9nhn3AaDtTfXVKuQQS1CVEVRvyNrozqaXmMHAjbfLawT+xKOhD855fUizZlMPd0kDDUhXUZIgnTYpZXUXKi+y6W7j2X/QKLW0l0OEit/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz3kc/w+zAMBx/knG6hPWJpAGHsqKMWEk88QYbBhvTI=;
 b=eNQDOFJtRJpg6FVCO732RknAPkDN+zP9sAzlzyUmOJN34sLzMckh8Zyfqm7GoY4xmhxrwwZMmWyzah8jp78AN9/g6ycMGAP4CTMTAfkT6KHDP/B6MpkUbMmJradr69AAZfSGU7DV6pZgax1xlK/2U3UUW+OsYSvxjodSSl1oaVuQTebAA9Ou8GUaCyPfgYC/YfqdtSyyThAykeHgzaHCvXcl+qENVt4z3d2JjvTdnZrggoSIhemfa3tbIimdWSKx8oPadW8X/gaup+8V+nL06A/XWbiJGTP3m+GgQKqZc9RQpIlUjFT25b/q/NtYE4rqPHJCaA2dAp6P/9X6kMPbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10355.jpnprd01.prod.outlook.com (2603:1096:400:253::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 05:36:12 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 05:36:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 22/53] migration/rdma: Drop dead qemu_rdma_data_init()
 code for !@host_port
Thread-Topic: [PATCH v2 22/53] migration/rdma: Drop dead qemu_rdma_data_init()
 code for !@host_port
Thread-Index: AQHZ8g6MEekVaGhzVkO6FIbJ/IX6LrA93D6A
Date: Sat, 7 Oct 2023 05:36:12 +0000
Message-ID: <e69e5d2f-d6cd-f769-0de6-d4309d30a913@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-23-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-23-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10355:EE_
x-ms-office365-filtering-correlation-id: 5d3ce08c-0125-4da0-2616-08dbc6f75158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY9kml1E9NjAQc2T/fZV0Ta6j2+B0Ld6MBUh637BV1MJ6GVVs25i8TDLUW0vZTnyHm/VvXDRllbloQm6JcguiRzv9wc2luFCo2DX3HFRiS7dyF6S6OnygSoZptI9UHVfQy0z2StNGPFHeDSyrfG0DTCJjuXcrEMyTLF18RC0M5larHxPoygxwZPY6O70pitLNR+ssY94U1mrr3Mv7lHi96sMiTVotK9ykE/pMkKPhPSHX/R+eGwvUPGitqmGci3CTDqhxfpiLc5z1HCqJHDZaIw9jTkVpfx6yuz7fyLT9TfznLI5nSHD4nIrcv5OKLz8ftBTt1/p7H9onezQxayB49d5rDo5Eu8Yf52qOHhrEZIlQOtCiuPJRINrOT9/GKRHtTDTIh6JedNahO/gujIRll8i4IBV8OWXL1UPpwOyQZOMhtb5w6gXYHQixu8Cjbe9HVhbeJta5GkneNlxnaP8IvjHT3IiPgTYX5UkqCAYoG+6kjYeQTRGe0ARukNl9535+rWzIAHn19bQfCukLmTctVKRRyxm1ZX6ffKV4nHnIPtGZ36D5vg8lvA3tf26WdXKJpOvrfJrbWgcLIWzaehFeZZ9+N3oBsc5KUVdCCPuGVBVPqCDlXp8+e6K2CLCnJmHifab5J0hOUSAh6j1knk55XeiastoE8noXgKmHdECFaAP54Z0r/CFCE15EUqlo/I85yPVkeQ2fqzxRZRa1Bn+nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1590799021)(64100799003)(1800799009)(451199024)(82960400001)(91956017)(110136005)(76116006)(5660300002)(83380400001)(41300700001)(86362001)(38070700005)(38100700002)(64756008)(8936002)(478600001)(4326008)(8676002)(66476007)(66946007)(31696002)(66446008)(66556008)(31686004)(316002)(54906003)(122000001)(26005)(2906002)(6506007)(6486002)(6512007)(53546011)(1580799018)(36756003)(2616005)(85182001)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZHZjJKLzBvcUp6MDJRa1hycTE2Z1FQODJNOXNhbDA1TGMybW0vZU9mTExs?=
 =?utf-8?B?SGdUeWZ0aGFIYWpGZFFQSFBaUytKbkZCczM4bEVWZFM0YVRmQzVib2QyTlFC?=
 =?utf-8?B?aWdqOUsvZklOekFQS09TS1VRMWswK080RDJFdEhOZVZOMmYwKy96ZG1sd2gw?=
 =?utf-8?B?WXVEc21aUHY5enBWRVlwaWd0RnJ2bUJFYlRDdUozS00ra0s4aTluUkgyRlMy?=
 =?utf-8?B?ZnRCaE5JdUxmNlFXZml4STkwSTJSMnY1bnVDMlRWYmlJdW5XbWh2RDJJdllq?=
 =?utf-8?B?TjhNZEU1RnFGcnZwR29Tdk95RUVUNFByQk1FcXpGbi9uMDF3TXBuQTZRSzNR?=
 =?utf-8?B?aithcmNRTWxXN3dXVS9rQ0RqZmhITXA4OXU3UTFOS25HS3YzSVQwU1ZwN3FG?=
 =?utf-8?B?OFVZdzBGbTRESC8xU0hwTG1wV05td0dRZFg2Tjc1a0FNWUhzaHhqcXdpTjk1?=
 =?utf-8?B?Z21tYXNnSTBHR0xScmgvNUM5d2c2ZFBmeHFWai9GVFJoRmkwdEVZZm5YMitX?=
 =?utf-8?B?Y0VYdWVSUERGVFFGWmx5aDAvZHJPZHkycHhvNWlYQXJsWTBPTmpUUWNrd0lR?=
 =?utf-8?B?N3puak0yTHA2cXUySG5sV2hMRDM2Zi9nNGtEcE14MGNOZUFNZktUZEpEbzI5?=
 =?utf-8?B?RkFWd2VFUTQyWXJwU280N1VBbXRzWjZiaGJ2TUI2RGZKRjlZWjFrcm1UNEM2?=
 =?utf-8?B?TGZjdUZmeWlnRHg5Vkk1YUZVckFOT3VlL1R1bjV0Sm1sSVIwSVdmcjZ5MzBP?=
 =?utf-8?B?WXdGZ2VPc1FidmdLQlU0TmRtYVlUZVpHRERCVG1lWHdCZnVCblhOa2ZkNDhQ?=
 =?utf-8?B?Nm5HdklMUktDUEhGWTNQR3hkcFBYb2Y4STRyL2R1Q1k1QVBaUTZ5bEkwTnUx?=
 =?utf-8?B?QXR5bHBmUFcyeE1sb1BNWE84Z3NILzVSOWw3ZzY2bFdIUENvNE9HL3RGNTlS?=
 =?utf-8?B?bHVlSEhnSCs3T2c3Z0tkZkJoZHF3SUpaak9aUzVvZ0hUZWJqTUNYSXIyMHc4?=
 =?utf-8?B?UlBFVnYraCtYdVh1aWM5R0NSVk9SYlFiNkh3b1Y4aXFxM3BhOS85b1FuNndY?=
 =?utf-8?B?VWl3UUQ0THpEQU8wNE1LekRYcDJxbW8vREl3NlN3YkpTeDJMUFVZZkhqM1Nm?=
 =?utf-8?B?NkdER1dZTTg0aGNRQ1ExMi9MSEZpN1BOQVpuOHRScXRodUlqQVNoRkNmc2Zh?=
 =?utf-8?B?QU5wVXhNc2pwY1BMcUgzUy9SOFNWK25MZzdjWmExWWhEMTVsclNTTkl4czBy?=
 =?utf-8?B?cG9oVVEyMXdJQkVERTE2TEtlTUtYaTkzNFEzdVh5b0xRbGxBeVpEMkZ4ZzJk?=
 =?utf-8?B?VkU3N2p2dmFXL2lld3VUaDdlZWwyRzhvbW1odktrZFlqUDJFRzZvd1dYOEM4?=
 =?utf-8?B?RFN0Y0Z0UWhtaU1RNGFkNitGNitWSXovN2dIY0c3Y3NKWDNHRmpVS0g1VWh2?=
 =?utf-8?B?a3IzVi9qMFFhdHdpYTRWdTk0OGJKV0ZkYkpUc0RSSXo1VlI4dlhEdDg4ZzQv?=
 =?utf-8?B?WTFGYjFtTmFmWTVhZnRsS3B6VSsvb1d2ZUxxbVlYbFNUNlE0TExkd21UcnZq?=
 =?utf-8?B?SVNXVXZzNkJUMk9CS1NDcmltWk9DRHpQYnd2YWhIWVlSenBMbkxVYzUyL3hD?=
 =?utf-8?B?ZUpEelFhSDVzWEZRQitpUE0zNzFVOFFXU21yM0xzV2tPN0VDZS9zdHg4am1N?=
 =?utf-8?B?TnVVOUp4OFNxbHMva25lNkduK3k5Q1ZsVWxPNHdOTXhRb3d4RlFKSGRITE9P?=
 =?utf-8?B?UEorenJsd3c5N1lkeW1QRSsvdGNOc1ExaHJtbnNqdWROZ0E0N3hJMDZmS3o2?=
 =?utf-8?B?WDJCUkJBLzlTNHlsemcraFVHdHVRRWl0VkhpUFMzR2FGQnNvWXNZb3pVcEZm?=
 =?utf-8?B?V2Yya2hPeDFSbUxRK25rUzZrMzBObjdxRU01OEhRbGQvNmZ1SDNQRnB2VVBL?=
 =?utf-8?B?ZW5NVjdmR2k4NTFmeUlqdW13VXlsSWdpMS9mUXgxMjltRjM2VkYwQldhbkZp?=
 =?utf-8?B?bk5FWFhicXZpTjgvd1QyaE9hRFM1T2tEQXE0UlJxRkxKQlBMYlBWTnc4U1M5?=
 =?utf-8?B?czl0dTA1WUFNR2dIN2p3NmJUR2V5dU9zRjVHM3B5UHc2SEdoeXZFbGZKd3Fz?=
 =?utf-8?B?VHNzYzRsTXRhMlZFcVVJR0VYTUEwb3ZGbDJwUk5CU0RKZ1dCK0hhRkhqTFJn?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA4886037F3C964CAEFCD5646CEA1316@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WPahamkwwY2xh/9lDiqvRi42532AEsTJxMIVStEh2BmC4wmRdZBH2ZaggjSaiV+ssPIVhHoO3b7TzQtbg3U5PYrujSoHXGHa5av1OcnqFocZ9QyOxbA6z8zb1W9rVCNHtSPxRpjs2JtOY/FfeGrNCBwOoXPP43y0oqmWJudmCE62bwgY2H8bwFKcMuK99gJGGkQkC16n6koHt6j4WRgOzp6xmgKiHCedAC4AFYQIAcKD/3FpQCCt6RPNKgw/c8Lvn20dmx7y+hoZCgcxdtQu6an4i39nUr4buQpEKF2bFjwgpZ0X9Iw+/Lvr2uPvaft3+0Q7ag0TRggSYk/1mN7yFc2BRF7a5uSTj4kU/gi+KUoMebERFkXSEVeut7UNjWjT6OABp27++MSdrnDqlpVxm+IujcUJQ0vWTjNmDrukXoRJj33pm3jjIGJTuhpaSdvuw2KPbMBX1ZrLZpsjBZDZ6EhLWd9yizIXbySuKnnNl0ihH++UebgemzsTwfIe/CJkTSVk34VQ42EbJDkfeGUoeAbd5KCd/EihC51X03bIkVR32Jpl3+COHOpQz8tKZSvImInuG8FsRlmRMAkhE1y/fhGzjA9fhjd31DUzAe7ipDZWpokTr+995c3WcPDMfrCcZ6Jd2VW5J5cRR8qyGSTKZo8ax67Q5fiNR08kjGFLFUIYt9RdL5ARxRVf1/twvC2T8wFWjPu8g4G0AMC/Oes4IPCSVaa3k3TcmEDBc20eKNGDykOVOIQFw+WhxdxsuYKWVfdEBy7hKspGugaNxo9b19aQDOMQyR8j4HSyO/7SWOIkoSeQMrqpKM1KTyt1RAd7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3ce08c-0125-4da0-2616-08dbc6f75158
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 05:36:12.6789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPAX5RwcJcPhXoF9HQgZnyyWeEPTUFy/P+J3nyKOkwHrbSbu5ks8OfXlBOq+awCvcJcuCMptpWDirYXe6FhltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10355
Received-SPF: pass client-ip=216.71.158.38; envelope-from=lizhijian@fujitsu.com;
 helo=esa18.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MTksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfZGF0YV9pbml0KCkgbmVnbGVjdHMgdG8gc2V0IGFuIEVycm9yIHdoZW4gaXQgZmFpbHMg
YmVjYXVzZQ0KPiBAaG9zdF9wb3J0IGlzIG51bGwuICBGb3J0dW5hdGVseSwgbm8gY2FsbGVyIHBh
c3NlcyBudWxsLCBzbyB0aGlzIGlzDQo+IG1lcmVseSBhIGxhdGVudCBidWcuICBEcm9wIHRoZSBm
bGF3ZWQgY29kZSBoYW5kbGluZyBudWxsIGFyZ3VtZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAgbWlncmF0aW9u
L3JkbWEuYyB8IDI5ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IDFhMGFkNDQ0
MTEuLjFhZTJmODc5MDYgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIv
bWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMjc0NywyNSArMjc0NywyMiBAQCBzdGF0aWMgUkRNQUNv
bnRleHQgKnFlbXVfcmRtYV9kYXRhX2luaXQoY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJvciAq
KmVycnApDQo+ICAgICAgIFJETUFDb250ZXh0ICpyZG1hID0gTlVMTDsNCj4gICAgICAgSW5ldFNv
Y2tldEFkZHJlc3MgKmFkZHI7DQo+ICAgDQo+IC0gICAgaWYgKGhvc3RfcG9ydCkgew0KPiAtICAg
ICAgICByZG1hID0gZ19uZXcwKFJETUFDb250ZXh0LCAxKTsNCj4gLSAgICAgICAgcmRtYS0+Y3Vy
cmVudF9pbmRleCA9IC0xOw0KPiAtICAgICAgICByZG1hLT5jdXJyZW50X2NodW5rID0gLTE7DQo+
ICsgICAgcmRtYSA9IGdfbmV3MChSRE1BQ29udGV4dCwgMSk7DQo+ICsgICAgcmRtYS0+Y3VycmVu
dF9pbmRleCA9IC0xOw0KPiArICAgIHJkbWEtPmN1cnJlbnRfY2h1bmsgPSAtMTsNCj4gICANCj4g
LSAgICAgICAgYWRkciA9IGdfbmV3KEluZXRTb2NrZXRBZGRyZXNzLCAxKTsNCj4gLSAgICAgICAg
aWYgKCFpbmV0X3BhcnNlKGFkZHIsIGhvc3RfcG9ydCwgTlVMTCkpIHsNCj4gLSAgICAgICAgICAg
IHJkbWEtPnBvcnQgPSBhdG9pKGFkZHItPnBvcnQpOw0KPiAtICAgICAgICAgICAgcmRtYS0+aG9z
dCA9IGdfc3RyZHVwKGFkZHItPmhvc3QpOw0KPiAtICAgICAgICAgICAgcmRtYS0+aG9zdF9wb3J0
ID0gZ19zdHJkdXAoaG9zdF9wb3J0KTsNCj4gLSAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAg
ICAgIEVSUk9SKGVycnAsICJiYWQgUkRNQSBtaWdyYXRpb24gYWRkcmVzcyAnJXMnIiwgaG9zdF9w
b3J0KTsNCj4gLSAgICAgICAgICAgIGdfZnJlZShyZG1hKTsNCj4gLSAgICAgICAgICAgIHJkbWEg
PSBOVUxMOw0KPiAtICAgICAgICB9DQo+IC0NCj4gLSAgICAgICAgcWFwaV9mcmVlX0luZXRTb2Nr
ZXRBZGRyZXNzKGFkZHIpOw0KPiArICAgIGFkZHIgPSBnX25ldyhJbmV0U29ja2V0QWRkcmVzcywg
MSk7DQo+ICsgICAgaWYgKCFpbmV0X3BhcnNlKGFkZHIsIGhvc3RfcG9ydCwgTlVMTCkpIHsNCj4g
KyAgICAgICAgcmRtYS0+cG9ydCA9IGF0b2koYWRkci0+cG9ydCk7DQo+ICsgICAgICAgIHJkbWEt
Pmhvc3QgPSBnX3N0cmR1cChhZGRyLT5ob3N0KTsNCj4gKyAgICAgICAgcmRtYS0+aG9zdF9wb3J0
ID0gZ19zdHJkdXAoaG9zdF9wb3J0KTsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAgICBFUlJP
UihlcnJwLCAiYmFkIFJETUEgbWlncmF0aW9uIGFkZHJlc3MgJyVzJyIsIGhvc3RfcG9ydCk7DQo+
ICsgICAgICAgIGdfZnJlZShyZG1hKTsNCj4gKyAgICAgICAgcmRtYSA9IE5VTEw7DQo+ICAgICAg
IH0NCj4gICANCj4gKyAgICBxYXBpX2ZyZWVfSW5ldFNvY2tldEFkZHJlc3MoYWRkcik7DQo+ICAg
ICAgIHJldHVybiByZG1hOw0KPiAgIH0NCj4gICA=

