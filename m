Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BE7A92D8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:53:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFQi-0003dz-P3; Thu, 21 Sep 2023 04:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFQg-0003ac-1A
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:52:58 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFQd-0004gQ-Cx
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695286375; x=1726822375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YM1zONgEuqBvroQz07fdl0XzmPl5sScQn/8UA+ikvjY=;
 b=FtzoBe+oRcez9MwAgPQbB/kIMVh5sI1eFZHmQf2JiADabSQBz2sXpV8i
 PeMIX8ir+SjqqiBgdifc3+aOjx+jkGYfucj67qxF0KrQFRfFqlUwfXZAv
 sl4Gb5uHceZPwjOIIn+0O+ncujOXV4BQHMM11/V1LlQf9vAAEP0kEfsil
 YZast+vo9+WmMfNli67f5y6oGtKaSk6Zl1zxSCf3vu1j/71KqF91+XOty
 WZbvzveK1w7aqxoDjnZIMPo+9Fbshd9ARucwMKuN1rDWogMRhMCUeq+xj
 Fntq6PYxQgVfr9dKJGuiGO3TJEGJPE3TfimzoYW71AHsUAm7oGslDPtuU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="96056307"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="96056307"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:52:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKf4Rr6JVSj6LalnYAulfCIxWtQBUMp4VNJJCOlff08ISMrACx6MMBIormugoVWskuTMY7MNPADUFEjRSzupNbsvPvGIxuj+JwvXFGlZCBAZwt6lTmKgh6u0SlEIN50D17kMl3CdtmwvXdExCEAgwjLmht8kV6ptlbRB9B5sdoi9r1/1owLRaaKWJkq4+uVO0VNOSwvC8oWH5CTmg9prHbp91o8Xbtjy0RzlZd4yL2hZsAKct5yrmSfn+XlDoIr+dMhODH+47dzd4/oFFw5hEpxqmO115tC+/O2vvFjhZwIx0nFDFQaPh8V0rTCV33JyUggJrTbu7uXlU672BgMvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM1zONgEuqBvroQz07fdl0XzmPl5sScQn/8UA+ikvjY=;
 b=erHK7UHb0928h9BmsewO1fxgjxT7kUqlFEU/J5Mln4zGE1gzvSXAZ8uuB5FrFvNOXuksqPujSPBbkyLsvnfMkSkdDTVlDjftnQxkaSOT4yHa1AhDLW3VMjw66HyfgrIQh0RIjE287tv5JZF/kxqhcx2JYSjHt5YFPOFZFO5F+sLiGXnyU6tWHbquoBnfXYU3JYzn5BOAOqcLDf77I51P9IfF2b/L4MUJgKjXO36EIgUQ3j0gVun9S8t942BFBCNR4lqPF7x/Z2XKKWa7HLvGIrt4Xuw+eo9VJGJ5dRNVHUay7vHLXi/V+06NOjj44kF4vhOMR2ubCeQu1kwvd0PPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10580.jpnprd01.prod.outlook.com (2603:1096:400:315::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:52:48 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:52:48 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 02/52] migration/rdma: Clean up qemu_rdma_data_init()'s
 return type
Thread-Topic: [PATCH 02/52] migration/rdma: Clean up qemu_rdma_data_init()'s
 return type
Thread-Index: AQHZ6j59Iu245vnhPk2ZD/J4aUOvTrAk/X+A
Date: Thu, 21 Sep 2023 08:52:48 +0000
Message-ID: <7cef3a1f-584a-3a3d-9727-f8234b8a9a52@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-3-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-3-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10580:EE_
x-ms-office365-filtering-correlation-id: b0f3e8f2-b06f-49e0-53aa-08dbba80215d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clJ0dRdYdk7LLH0Jwd4ijBLB2i1ISQf6CIHwOhHcA2zlODBomhNYXammjb+83TS0pUPn1Rp3JAb00/eVyaD1RlLLHq40Efx5YtkxB4PtPtO1mg1v5j0SdMuqocm/tto7K1go2kUsVPuNWmQBiHYeb7XHiYXkzZCqB3zyzp84qUVxksif8kWyC/0nXb/4vR+pqafBCZv9Lnpj1Ce0s0aGEfhcldP2sZI5kyI98qaVg5XF2IWoo37j1eWPDnZq9uCxLPuVwJw7btWqQV1q1n8enlTne/BDT1qOJ4uz+6yXPcD1UMDM6Okr7k376n5ppxJT6BA8QsQ4zfx/cLubCMytAwaZQCxB9VPQBKOV6rdkSklgshi3Y6H7ksOSA0Cb6JorMOiKTYRaZG9Lp9qBN3pozFOUPgfVqVU2PW4U0Ekt7mRwm3ldBDOmEMZqvssP+gG/ov3QwQM5RIduUOzBVHFWcLXMtbbQeGGUG3m4UDd29jJs0Jw1S2WNIffc/QDs+pJp4iutbY7WPk7mhqkgPZOOg1M4hPFYPK+6ambXxj/i7cYnilxvB61E34qltgk2vGsrJza2IDP7c1587YhhNyLiGd8L8eruAAv6F7RC+S/0DDpe15yCH+HOFYAUT/alR6+vV6AZf2YLRXo5eZuEuNZil3M5xkmP8K3A62pcBLXdIWwB3TZ/XWHDI9i7Remzs6f1ZAZ9yTynNxRgKxAn2TGzZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(1800799009)(1590799021)(186009)(451199024)(1580799018)(76116006)(316002)(41300700001)(66946007)(66446008)(26005)(64756008)(66556008)(4326008)(8676002)(54906003)(8936002)(122000001)(6486002)(53546011)(478600001)(6512007)(6506007)(71200400001)(91956017)(110136005)(2616005)(31696002)(2906002)(558084003)(82960400001)(38070700005)(5660300002)(86362001)(38100700002)(36756003)(85182001)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0RoNHNyS2VzdmtOZFBZTmRtUkl2b2VlRmkxa0djNGRhYy94MjVqajhPSzVn?=
 =?utf-8?B?VU1qckhQQlB2TkdwZzBqOFRrbEM2aVJHT3hjK1ZmK0xpZGhmbGpwb3pZM1Av?=
 =?utf-8?B?MUhhcGdFRWJKN0lzdnRjbTBBNGRmTFdpNXRUTWI4RUw5ODhjeFp6S0E0TDJF?=
 =?utf-8?B?dG11S0dMQ3BZallrODkydDNkaEFpbXhka2Q5d0MvNktKeDVCc0xGamFVYmhO?=
 =?utf-8?B?Yi8zblI2cmtTMDd2cnRhL1VOL1BYYWs3bTZobGxTK0FpdmQyV2dxNUF0SG4v?=
 =?utf-8?B?QUkwR2hQeTIycnpCTVZXUkEyNVlCb1FOaFcrT0ZWWUIzVWFLbWd2Y3hUUm1R?=
 =?utf-8?B?a1pOZ2hyWHR0RXdmTCtPeGY1eXA5bnY4MlZYZUdMVTkwa2lJNGhtUjY0bnh4?=
 =?utf-8?B?UllHL1NUUzNyVlBFTkphTUw5TVFhUkVKb1lXSzlLV1JKbmplRDZxWGptUWhn?=
 =?utf-8?B?VEJGRnUvRmJVMlJMUm42V2JxRlppMllFUHFRR3RoeTFlSmxkQmRSRXAzN2di?=
 =?utf-8?B?dzhwdkVKMjd5MlVibFJGMitMeSsraXFhYm84NFZybmdHbXQvVTZUUHJMQjJT?=
 =?utf-8?B?bEVrQXBoMmdUeFd5NEJFaW1Rdk5pUmx0ZStjNjRxandackJhUC9MNGh2Ynl0?=
 =?utf-8?B?LytIMi83Q1drVElLQ0FhK2VPS1RPd2FTQVp6Q3NNU1ZWNWhEUHpnVDA1MFRj?=
 =?utf-8?B?cHBxYlc1cjB6T3NNTS8vZk8yUzdjRGlJNTR6VWlaTHkycDh4aFZnbCtubjFD?=
 =?utf-8?B?VjVmUVVxZENVUzlWejhKakRuaGNiREJkNU1sb2Jzd0ZRQ0Q1WmkzZDlTcUtr?=
 =?utf-8?B?UTkxUkVmRXp5TUJMSlk2c20zOFhhN3dqLzI3S2xaMDNLb1ErNkx2ZjhnWVZv?=
 =?utf-8?B?ZFdRTXhrSGNEcE9HcTRFdWpES2JwSDNtTzZLdDJCdkowQmxkcW9VVUtSTEZk?=
 =?utf-8?B?YlBqU0dFQkQ3Q3dFSGNiaXhVTWtoZEtUMFV4TWI5eW1qTngyRFlNVUJUUUFx?=
 =?utf-8?B?UEJUOURBbG9ydklKTkkySmp2bE42RS9WTFNWaW5DSWRFcmUrcFprMndQVU5w?=
 =?utf-8?B?WDdaaVJwUUkrY2NHc2NONWwwcHl6bGRidlgrUmNsSXN1dGNjM0N2ZU5OZUoz?=
 =?utf-8?B?Q0JmdUFtanozNWgxdzE0UGJvcFU5Um1nVm51dlQvU1FzeVRXcUJxL1dFSVp2?=
 =?utf-8?B?cHFwYUROWXVCbnFPRUE0VFdSMWlmVFpRQzFBVEpyR2FOa1hOWWMwOUE5QU0y?=
 =?utf-8?B?dm4rQk80bEpPK3ZDMnQ0WVd4U2sra3B3VkkxcDBUMEFOMllIUE15R1Fmc2V1?=
 =?utf-8?B?eVd4QXJYcFF1cE9YZHNoeENwUGJTdHY1ejVlYVE3b24wYkZBb1M1aEN4VFZi?=
 =?utf-8?B?SkFSUFVzZEoweXlnMm9SSE5HSmFEbHR4MUZlWHU5cy9PVGNPekxxaUQvbEky?=
 =?utf-8?B?Lys1SldnVnAzdmJ0eUJDczZNaTlQUHRQRkNueGRKNW14MnY4ZWo0TmJCOGli?=
 =?utf-8?B?Vm5GNWZjYUcrR0wzRGVFbGl3WmdubmQ3Rm0zNnNCeEVXK1lmVTJKT252SVBu?=
 =?utf-8?B?Mnc1blk1Z3JMVzZCdWl3amhERXpkN0ZoMjVPQkNMWlJ2OSt6U040K1AyRlNC?=
 =?utf-8?B?ditoVG5Ma0EwMzZDOHlqZVhUcUtaTGRUcHhxNDkwWDhVSWxHR2EvczRTTDRK?=
 =?utf-8?B?S043WExvY1ZBWi80eStWOWlJR3dENk1ybHFTQnA0Z0FsbmNmTzM0ejBEa0xF?=
 =?utf-8?B?SksrNGJXTEg3OHZ0TThkM1Rtb3c5bkZ6cUdvY0NOSXJhTUJmWXIvKzBCZXBW?=
 =?utf-8?B?c3FoK1laTnpBR2dzdmtha2dtTklWa1BZUlNtVjhEd2h1NHUwNGFqUE5VREcw?=
 =?utf-8?B?SXpjbE9rUXVFNk51UWVaeEFiK05jTnpvYUNiZkUwSERyZFYvNU1tczhwRkhY?=
 =?utf-8?B?dzdObzByTUYrbHVNbTNjRzYxdVVscTh5by9zS1NhL1F0a2pLQlNIdS9WeFdG?=
 =?utf-8?B?YjZaSXJZSHZqQ043a0UwMStmRFFjTFdGQjF0bVA1cU91L0VhMDE5Z3FhcW5I?=
 =?utf-8?B?SC9iYnRpWFp3cGpTQTRDUndoL3VDY1FaNFVoNVFMOXBNUlVKY0xETTRJenlC?=
 =?utf-8?B?Z3dCUnpKdHlGcHZ3R1lZTDBqTGFMQ1ZFRVg2SGNoZDVKRXA5Z2svd3llVUQx?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA023E623641C04AB6D9FBB365013532@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2uwyJMk+bq4ieuyLiboniAmwzYw6sq5S+QAE5o6a/qCPMv0RKRnXKmAuPh005EUXNJA0O+kWQRKRY/tLRKsBSaVroIAVuq89f00jx9e5rhRpulx6B9rhCJLBI1XS891aUGy5myoYZPsPs33C2e/7zzsOWvRru/87e7A9dSyoA4bMzukOS/X5uAyqg9PQjEeSI79E2QQTIqV1R5Ri7iVmmC8MTvpA1++4Eb2YI7lEgLcBpl6T4f7e1FjKn27qEKkw0GF8knBofBlGjKnujb/xgcap5Ih7P8KeiNqlnyx4IrSjzgVFxUKVZEr5y6zfs0b80BPKTGd9SD3piNnh/i9bD352FumBp0YSVSuywrkkBQqDHKJMSdnAcxMaLn+HnE08+HmQH8i9IG3Z5A+HJq7uxWirZkawzH898c4Z8IJ0G5RJsFgjZeCUirUkEXa0k5zsBYPvS1Qxh4AYsnsHYUwdXKs3j7g8nr4bgoyTyIkYJQ/uR3W1KT/Pxnt7VpruRgInealyzJHBDBMc+A6mVnoA9xypeyCsDwXCskosffGcaPPTiN8Oo67XmMZ+OJ1UckTM0t9z+//ESBtSVybJ7a/9KfW9IDTNYc98MBaqtg+HBmtOdao5rEKZYLVv52pwIp8ozFi0LrjfExF5gr8CVaR1JK5WeFT3VDLN5dao2lXlVYV+8+PQcqDpKj1jl1EFNPqc+jHE+NACOh5oHE45XCsbnku5sG7UcQ0FzDRZE4eq9OWjPIiORPbdFXVjTWFAsfNc2UXhL58lsgfP1rvGx/FSYE6YyxHFzXYhNJQc+ToP15c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f3e8f2-b06f-49e0-53aa-08dbba80215d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:52:48.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRGAsqJ1DEP/jzL8JUN+nRvbQX+ya1Gb9MH9IZkzLSNKw5sk7tN6hovPDQ5NXWrj0+AnXYYEY7Ry0y9WjihL4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10580
Received-SPF: pass client-ip=68.232.159.83; envelope-from=lizhijian@fujitsu.com;
 helo=esa6.fujitsucc.c3s2.iphmx.com
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
X3JkbWFfZGF0YV9pbml0KCkgcmV0dXJuIHR5cGUgaXMgdm9pZCAqLiAgSXQgYWN0dWFsbHkgcmV0
dXJucw0KPiBSRE1BQ29udGV4dCAqLCBhbmQgYWxsIGl0cyBjYWxsZXJzIGFzc2lnbiB0aGUgdmFs
dWUgdG8gYW4NCj4gUkRNQUNvbnRleHQgKi4gIFVuY2xlYW4uDQo+IA0KPiBSZXR1cm4gUkRNQUNv
bnRleHQgKiBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXI8
YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+

