Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3867AE36D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkx91-0007DH-Sy; Mon, 25 Sep 2023 21:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx8y-0007D1-SQ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:45:44 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx8w-0004TV-Vx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695692742; x=1727228742;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tauEdynH7PJsWxePq+Zhx8TW9bPjjokttVA9tPg0ybs=;
 b=fasm1/uyZj4CRAN/oqbEXns+AuwdU65OcNNsbW8mbcs3OjFoq0nMmdfQ
 CK0epJ6UN0Qly9rS88zY1NyAL7VebbAch9JJD41iVIUjC7+UBmOVxvdkJ
 y766HL8CHEgH+wQNHCANjXqNEI8n2gB2kIp4l8wRh3++FqXOfYHFtpJe2
 SxkpzfvzPaKZhugdJp09ugX9QbkGAaRgaKx+LCqMiLOI0iboK0f5OtMUu
 2OGHOn3vAgCIw9pbvxB9SN7y6S6ChstTK5SYBsSV3sXTr0maLE92hKRBG
 jYKBOlGu4vFSnkVVzdxX7u/PAZuqP+09TAQ+PgO5Nu0fCT+wMCWkAK6gG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="9694584"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; 
   d="scan'208";a="9694584"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 10:45:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZC86WnL6TKP+3+zUvO4QUEvK/1g/1YYI0+7BDJTQnb6WSKNY7szCPZYiCXXcYuwLw+upw+luUPZar/LGV/NNQsW1TScZucbtBGiUNu5Ghc4GHDdY2VmvEi+iJh3vBXh3lFNCyRkMCMQiteyKgl6frLq1V9bmG9he6fgPThGBur9a4O6aPwHITN02GqfE1ONqrfhj+jmx5ifUlfuG1E6ZSMIoKW2Bzg1xYtPPmqmu7v8h6E0O3QqUVXB5Su+04dFX4x9OUkQYkhwgeENFci022OiwnJ7kQyGqVflzWVEFSOVeBQ6ZCnomWM4TVOvWbHKAY+A5P5aYl6m5b8fSBaH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tauEdynH7PJsWxePq+Zhx8TW9bPjjokttVA9tPg0ybs=;
 b=CfcgfohNNYVpuER01fm9xzZ6bpGg7gZKRLaMchXccIWFSQ4W/2Pn2uxEbOwwVRUfAPuWGbomSpr0bSaJ7yeZwES4iS7Dezp1i5wWnZR6r8PjSZXXr4WKoSruAv78rdo+dZrbMaThRU+xcnxVrLbVlxtzulCqA+JQjE3ilowpl252ug1Gb4JfwdAqOX0pej0TI3aUGjY+Yzf2J0SrKSWfQEWoQVuBetyMDiJ/LC6VzXbxn+nQdLcz0UjSSSX76eksSorWnJQEMKbJ3yLaavGiNbLM9LuXGDha91UDAhGSNYJoGqCSP7ntugwBJ+H8+vwTOH3SnPLwDmERhW196HHhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYVPR01MB10831.jpnprd01.prod.outlook.com (2603:1096:400:2aa::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:45:35 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:45:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 36/52] migration/rdma: Convert
 qemu_rdma_exchange_get_response() to Error
Thread-Topic: [PATCH 36/52] migration/rdma: Convert
 qemu_rdma_exchange_get_response() to Error
Thread-Index: AQHZ6j9ayJMUrn0BYkS3zjOd/4qVtrAsYceA
Date: Tue, 26 Sep 2023 01:45:35 +0000
Message-ID: <65d2ed8e-1dec-530c-131c-90bae8626e01@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-37-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-37-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYVPR01MB10831:EE_
x-ms-office365-filtering-correlation-id: 922946dd-339e-4f20-3057-08dbbe3246fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJoGpqXqlusquNH71uIbf0sDSAV2MQ7XOhDNgYDIgpQ1bkuND1wLrlmP2l+HkDzjsZj2nhNsjedvlhT2htTuc27KEFxQVfXt60SrVar7x6nxuPHpvykIsgcCevL3vAhKrTy215cst7+Pg5OKgsxMHWZ3hvC76oMfhTlc9/6AuCkcs5NY1Bkar/YCo+9N8A5TAet554LzYPtt/WeyNRxK67/OGo+b+PWGDjxG/00vtQH93osH5BNfN9Y0+SRAhxmoWbkbm+fXDqVYRSV92uuYxtSPVz+a6WayNWSshLmKQYrdvSlJwkCMkj6l2jDaaSzwPJDWwAEunEQY0dMzl4fQzJF6PP8Vtbj04D79XEGW7GQBA4bDEF558xjKyduBrbFgb9tkBthOjbuJ1YXNO5kLXvShk5PW9/nQ7F3kvnTWR62gP9XpXCITojMDwnxbrM3JghrAoZxOWa7VGIo93MlZcKz9NHuMr7gj/m6U9jyWM4M5cEOTXIa1bmCwUIk1v9dq2tWBcBcZJRsT0gk/Wz/MJvQzLdPOUEIl0428CxXc4J79A1w+UyNWPeNWfx0IDidNp4IaxhSyce9uM2Kl/iZKevcvzL9FfToKjFZKaIkjaXqZhgw5r1xkEgYQnWZnGcHjL+Mm2ioJqv/xgYeYo2l8VnPCUkIFwKVwfb2yr52ZGvyhXemnRvSP4VWKzUAkM8/YDP70r3PzK0RECHtNRPIHEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(1590799021)(186009)(316002)(41300700001)(1580799018)(2616005)(71200400001)(6512007)(26005)(53546011)(478600001)(85182001)(6506007)(36756003)(6486002)(38070700005)(86362001)(82960400001)(38100700002)(122000001)(31696002)(66446008)(64756008)(66556008)(91956017)(110136005)(66476007)(54906003)(66946007)(76116006)(2906002)(4744005)(31686004)(8676002)(8936002)(5660300002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9Rak5QMFdZMno4VU5PMWRlWXdvdDhJa0xHL3RXNm1xUjlrMzIyWnJsM2pp?=
 =?utf-8?B?bm9scGZFMGxjSHNTZ1ZwRWNJeExhWlFOeFJNTkRJRnJST0JHTE1qT21zSkpq?=
 =?utf-8?B?UklnUFVsbmdhcnNoSzU5MXFQMnVoQlQyM0dsVVcxVGlWV0dqbStGVWkyZGZK?=
 =?utf-8?B?WllYWlVabVdNQzNlbE5EdlBMYTZuMVNsUGpENzJQQVVyeWJBSGpXcVFSWG1Q?=
 =?utf-8?B?SFZWS2pHK0J6WWZvcFlKWU96S0FCVWMrZW5LN0dCV3JEU0VsejJHaVU1eDh5?=
 =?utf-8?B?c1lsOGl2ZmRIU2ErSVNxVkxuT0I1RnJqTVNoRURkc0hsY1BFMjVGaVNtWWtS?=
 =?utf-8?B?SmwvbGcvTUkrMHZDeGg3T1Y5dkNtMFJGSFhobW1mMmpSdHVkOWpLRUozM004?=
 =?utf-8?B?ZEtsakN1aUhpNCtENk0rVTFvL2FyeGVkUXJTZnlSeHFuNFBZQjR0aUgrM2JV?=
 =?utf-8?B?empORjRqYUF3MU8zQ3B5aXpSS3crVEFNcmlyQWl2UnBNeS9xaXMxdTZZY2dr?=
 =?utf-8?B?aWc2Y1VIRWdhVTFCS2hXWDIwa0NtY1pFaGF3SDhzZHVnWm9yRy81ZWlmQTFl?=
 =?utf-8?B?V0ExdXhKVUFzcXI4Sm1tQmRxbHF5WFIzM2d5cW9lWWl0OXNzQ1drMndyQ1Aw?=
 =?utf-8?B?bER6SG1IWW4zMDFxQzV6cEF6VWlCN2FtRE41Q3hNQU5oQTlZeE85N1h4enhx?=
 =?utf-8?B?RzhLTEMxaldOSkt4dVhqY3VBOTlSWDFGNVZJSVNQZm1GYVlYL0xKaDJEREpx?=
 =?utf-8?B?ZHJEeGNjeWJGZm9zbjVISlNnNlpWVXEyVjdzTGd0bmQrbStWeWEvSVBIKzZs?=
 =?utf-8?B?TEtDdUNnbUFvZUkxMWFvaW0yZFNvMFE0YnBxRjVlTytxaWpEWDA2akJMYkZ0?=
 =?utf-8?B?TnczMmg3U0daSW5FMGQzRVdvNk04T3hJVjM0N0xRdExLUUNPWnZxczFUUkZJ?=
 =?utf-8?B?ZFhVKzRHTEZ6LzJRaGxlWjBiMWQ5Nk9UV2pwak95bWRndUtSVGgvdzZRb1Y4?=
 =?utf-8?B?TGRYbFJ4OHM2Y29PQlMxa2Z5ZHk1VmdTNDhoTlFMdVVmV0xnVkY0K3p5U2ox?=
 =?utf-8?B?Z3ZZdFRweG1rL2s1Qy9WZ2lQMGJkdGpuQ094SjVUbXJaY2lxWml0UTYvVmZi?=
 =?utf-8?B?UHhGQ3pUM09PTU9tUzcyeFNmdkhOajA0cEFYTGQ5OTJvbkkyV1lzTmM0d0FT?=
 =?utf-8?B?eDZvV1FWTVlZam1MMEY2NENxM3J6Tnk1UGphV0VIT3NwMGZqY3d6RlN2U2Ey?=
 =?utf-8?B?UU5SNmw0UUVaOG9wbjhmWFd5MElob3drSjFROGpQTFNOT3BvMkZVc056VTM3?=
 =?utf-8?B?MTlCT1BNUGgyVE5LL3FIOHlKbCtiKzN2dVhJZCtkTUpRSnZMWFVwZlEyUCtB?=
 =?utf-8?B?L0RFbVJ4blFFeTJHYis3bGYvU3BxNXY4bklTeHBRRDBJVGkvZjRZZThIK3JJ?=
 =?utf-8?B?SEZFNXdRN05ZVTJ2THRUUnc2Z2ZmYnR5aWJUM2FGWDgrK1pJWDhKdmpkTEhv?=
 =?utf-8?B?YXBxbUxzTGxrMC8wYnUvLzRSMWQ0eVUxRnFudlB2Q0NVa3FwbUF2UW8vczlR?=
 =?utf-8?B?S3NhWjVTRXBVUEptK21KcFRIblM4TmNXUGQ4WUFtZWI4LzMwR2dNRkdSb3Nh?=
 =?utf-8?B?MGpIWC81RjJidzZ2cGRiNU1HV1lKZFlpQUJLVzhPaUEwWEpiazZiWHIvbkUy?=
 =?utf-8?B?ajh5d3dPQ0JqK2hWMUpOWnRuT3pGajdrTGIvZDBWZDlYNkx6NGVkb0xabFRn?=
 =?utf-8?B?ZHlhMW5FMGpDZnM2R2MyY2lXclYxYlhtdGFsVGxUZERld1BnbmZqbXI4NEU4?=
 =?utf-8?B?M3c0Si9aUG9GR3F3S2U5WURsdHJDNVJJa1oxYmFzWERpNEJBQU01dmVYWkMy?=
 =?utf-8?B?Y0ZBSXRnSGJPTUh2ejRva29KdUNncUxRTCsxVHE1YXUwUWFFek1zRFJQWUJz?=
 =?utf-8?B?dEpGTHJsbGZ2Q3VEWWtnYTJST0c4UWllNW5zUE5GVllnV2h0T1djMEhycVB6?=
 =?utf-8?B?c3E4UFpFZ3Nsck1PbTNiVk1qa1BJZ2huR3REQ0hPK1Q5a3V6ajd3MU0xOERP?=
 =?utf-8?B?RllKTThJci9oK2xkRUg4S0RrZUQ1b0tWZUJ6V1RNWFFKYjIxRld0U2VqdTFS?=
 =?utf-8?B?WkFXZlhLK0l6SStTYnFRVjE3UUdoVzlJdzE1N1AyVHZwS1p2TUhLWko4SkZh?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD5E3C329705BE478D547F399EC59201@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +5OHoGK8uP6N7Qg5n3uFWlqiShQZRAu60LzN+hmlN2xC2Fk8NVA6/+516FAn2f3/IB0Ac010+luNg8Hw5h+URiqcWVfFZZIrhnsN92WiKzvVZERtz47QjHgrZiTTJkq0TN35K5/V3cqIgF8A6oBM3+xjWdwlpHy4WlE0F3mTcpF5dgL9chyOAENHnUejunuB2VSgvwQzHTWWKwzchh3VcWGxb5sHkDmmuEiWOhdb6JSLqLL67pPlwrCIF3LPGKjqPh9Knnb/PnQaZtR62MBukzGXQm5HtbBZUCmAHo2I9ZhHgu0VH6PHQ/wQ1cyD5cQrCDjCAuxKe+9uMei9XoZwFQkHSe/RQoVsMNvXnhKrLfoEFUFXWXLEcMXyr7xjm9J9t7ZsbjRxz2r9Wb+aeL5E8rVxjmsTCVCE0owTPmnzMU3UsmuoiFQwZfLMSG3lt0BFd8T/GcUXDS5CsfxX2ZH4hTK7gABjyzjW3wEoXDxN/+wndWwV5e3NPEplAWMj0ivLCn96Ui3VciWKpJAxHIuHNl19fSUBkK9R8o8tJ8ow68BU98WycZQ8udnE8qEROtZdmzXLzXJf/30ztZFrBPTbpDvJ1oUakdbEc99/Mc7tx/sJzyaqceul5XagQ9CvYjXAGirj4Lpda2jNgjo7JmZPmZu1nQ4XAg9p4h21lq3S53Cmr1zFbOMgsRfU0KqxWDBSSvABDjVsfMMunOeTBQJhT+rgXVzFc3T6A5Qkvvzv9AG6NaMUlwAnpLm5O3LPrTOhErGehSItgvSVG27fP2BmYxtG+waMo4L0b/EndIpXLUo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922946dd-339e-4f20-3057-08dbbe3246fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:45:35.1443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEXHP2uLy5C02EnSLA0TF8l9CbsGMLo+lbJ2IDFXwd3e/DiGms7o6gZOWdj/rQmrBmE+F2acFVnjpgVbsaKXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10831
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfZXhjaGFuZ2Vfc2Vu
ZCgpIGFuZCBxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdigpIHZpb2xhdGUgdGhpcw0KPiBwcmluY2lw
bGU6IHRoZXkgY2FsbCBlcnJvcl9yZXBvcnQoKSB2aWENCj4gcWVtdV9yZG1hX2V4Y2hhbmdlX2dl
dF9yZXNwb25zZSgpLiAgSSBlbGVjdGVkIG5vdCB0byBpbnZlc3RpZ2F0ZSBob3cNCj4gY2FsbGVy
cyBoYW5kbGUgdGhlIGVycm9yLCBpLmUuIHByZWNpc2UgaW1wYWN0IGlzIG5vdCBrbm93bi4NCj4g
DQo+IENsZWFuIHRoaXMgdXAgYnkgY29udmVydGluZyBxZW11X3JkbWFfZXhjaGFuZ2VfZ2V0X3Jl
c3BvbnNlKCkgdG8NCj4gRXJyb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1
c3Rlcjxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4=

