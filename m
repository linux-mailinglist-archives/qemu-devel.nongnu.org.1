Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9B7AE54C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql12X-0006NG-Qj; Tue, 26 Sep 2023 01:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql12V-0006MX-MO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:55:19 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql12T-0008NO-PW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695707717; x=1727243717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1QxTcTwamQT5BRCUszx9ClypPzV01PWAV0iggC9daTc=;
 b=uchnIeZMrUEeoJ8vnlmIelJJyRos+gti23UBprv3edEspUzNEMRxz2E1
 7oX5cc5sRgGZvevug948JmETK4nR6y7Ttig1/lZKgZZOQuyylqq80hIoU
 rU8R1xGRRZA74lhojEDSySmbipZo9DD4aaRTJMLXI/Od74a+GFKmGKa5A
 z3UB35kuTr/d9BvQhTcrvRFPlZRIrhuEXXqzRD7xi7ofMTwJ4F5X5RW7q
 GZtCMLS1+Dok2mHs7SSnMJTnrUh3bwcyzQ+/aerNSJwq3ziL5fLGG2ZB8
 GauDYVF+medcDkFWieZ+IQ6MDNv3WZF8OfSYgzQAde7lQIiB7tEYbiQrW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96801130"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96801130"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:55:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRCF0zxhdhNcW2G92ADO3mhYRfC/X/kPFQn+jR38YrdgGfG1EBOJuxd3ueNZKXUw9UQcKkyDryPwWRAtqPTr1jBZpZ44kZYDIWNFPiaTwy37wHspkciIZNbbOYSpq5MsazpypXhYKNrIJFvhKwlnd6mgT3PD4PNoqbkm7zSbP4U/w53LnuuYHMJy5VM8PmFgfNkazMZ82pvhABt1iUE7Govu4/VJtUjFEaYs1yPXFMC5t7KmePYY0c3HoXZl/9jPT3XTI32tMZITAdqmctGNEJO7SXXRzy745vUAjFGDoih/BCuBmxGyhgyteXZ5eLOb4GopP3zbxoTy3XX619Qppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QxTcTwamQT5BRCUszx9ClypPzV01PWAV0iggC9daTc=;
 b=Pf/Q9nla9rLQraBsSnqk00zabcV2ateDbgkPra66Gn1qsCi7z05yWaMOSDzEaNNgO34EEEXVB5B+NFGueg8JgpqYrfGknLyIS0uyanOk4PSKE38mhqTARQkNkEcnOMW7H+cqpPfAAWvra4DStRAP1aFu6WVWH9Nyq3saGcTN/aj7z7OkZRKH36u37xWBKpm/E86Z0RgiDkbtzgXAnJDPIB2yFLv19Zn1NpaDvBuMffgreqiDNH4vb7P41k2Sgb2eFTEpFaQMv8BtegoDgwwLq++CMgOYvKmYdT8b4sIfY/X2nsIWB40pqq1C75hgdn/96bTz2yeYYQZ6fCP9GlW9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS0PR01MB5891.jpnprd01.prod.outlook.com (2603:1096:604:ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:55:10 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:55:10 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Topic: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Index: AQHZ6j9fgex1HQn4skmnwwB9vRYjH7AspjSAgAABUIA=
Date: Tue, 26 Sep 2023 05:55:10 +0000
Message-ID: <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
In-Reply-To: <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS0PR01MB5891:EE_
x-ms-office365-filtering-correlation-id: 1fb95697-a781-4925-07b3-08dbbe552521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hatyyIMy4s7XcHXSEsoH4onzJylbY846plI5yEFtOUSOknAx1gEwcpdOrtCJTq9TDHHpqRYhRXLenv20H6tzAShQeflczpIrMThvknSnEvUfciLDMbtHBr0KH+JAd5SZL8QbvB6qTXtQgZy3lwYfB6hEb0d/siea0KvTynrpDHnsFR+9K6gY6i9oD8F4xXMWXmGdhl5U2DiwQEazYacucqHU8HDYbUfhjL3nuLsGSRtlQdBFt7pH9pXu56fbmi9a3T2gn7I3gIY7YFZdBqECpdKZhDCYjF42QA/HU6Ra5xEavuFItGTHvuB8C9bZpLcQ5UktIL7auX8rvSZLbdo28gLVi4Xn5pipWVn7XrcAbLE/b99EQsmp0sA7X12rKsA5ejMZM7iuyHhuqXj+xIyHB305/A73YnURKs/reSsBqCoNkzAAHlB4b+tbQjLCnNnYenc0R46x6bWah4GQuphEmyM8qVRSeF18PmFU5gaR+ROxa0VU9LiQ48PA+ebR4W6HLfUGTGrKsZHFh1vZomkMjGLR8M1eyIa34z2GMtr6EWySWwa0+aioTSOgEERuj/GnJ+V5QxfsOh/gIvSwK3gwcYY/l+yzce7kfOWbe1HoO4Rn6+DUGjlokmuMTyAdOoXqVHOHoBTu/Trv8A+q0R1wlzgY9zKJVOVPmwYjwruMNubtUhqfVkNgIAo1EerKrtBnKuhJx1D6wTsuyqCmAfreJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1590799021)(1800799009)(83380400001)(4326008)(5660300002)(1580799018)(6512007)(6506007)(31696002)(86362001)(85182001)(53546011)(6486002)(64756008)(2616005)(26005)(66556008)(66946007)(76116006)(66476007)(110136005)(36756003)(66446008)(91956017)(316002)(71200400001)(478600001)(54906003)(122000001)(82960400001)(38100700002)(38070700005)(8936002)(8676002)(41300700001)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVltNmFHNE1icGlxdmlqSCt6SEZFK1M4RkEyTzFnS3F3L3J6TE1qb3AzZGpU?=
 =?utf-8?B?cUtjbnAzTXFxV3pienpUWTVuaU9Zd2owb0FQMTdMbWplZUpoZFBvdHA3WmhO?=
 =?utf-8?B?RzJmYjNKYXFhNHVhOEVoTzUvL0RPellOOEtmQ0lHdHBMTVhCMmdCaUxtUzZa?=
 =?utf-8?B?cEc4bndsdmc2VHNBMm5QakUxTGZmSnoyYlg5T2ZWRHJuRVlFRzh4eGhDdUdw?=
 =?utf-8?B?OXo1VldJeVp0ZnE3OU04Mk9PQzBrUHo3L1hwS3IrVjMveW1BRTdhZjFXVGdt?=
 =?utf-8?B?b2tVcGI1U3R3S0xrS3dlZU84cXNkM2VDK3NzQkFBMDVDMWV0T081TmdqNzZO?=
 =?utf-8?B?YTJ5U25BeU9xMHJJYnlmenl0clRJcXNVMTZWTURITGM0VVl6ZitkdG1XZllO?=
 =?utf-8?B?NlIzOUpIN3hxRm9jNlh6K0JJYU9mSEZtb1hLaVE0VzhYWTMxcmpGOEtrNE51?=
 =?utf-8?B?bTd6RjVZZUV3R3g2eEtMVFU2Szkzd1JhSHl5UStEdUFIZVFtdDMwYWtFd1ZT?=
 =?utf-8?B?d1gxcjBGb2pTbmJWa2wyRVpnVHhTVzdaWUJFWDk3bUNhelpiWEpBTjJQRytF?=
 =?utf-8?B?aU8zb1dqNW1aQ0FHbGczQWdXb2hxWHBYQ05PUHM3aG8rQjZCS0hDRUhjazBF?=
 =?utf-8?B?S0RDR3pNVVNtWTc5ZHUrUTM5a2djcjdzTzVNbXFXQ3ZoY0VYYTZubTdWMXJK?=
 =?utf-8?B?bHNTUXpUcTZrcjRHcC9nK0xqSjljK2pCZHZHR25HSWExM0lHdnMreHhPTnpE?=
 =?utf-8?B?ZzBrOFhvbWgwZms2NU1IbmhtRHk1NElSUFpsWVZaUW91N25IMVBNb1FET0hm?=
 =?utf-8?B?WU5tSHp1R2FmbmdhOEw4VVhJdGRFcko2dzh1eml1Z3ZRVE1lRGsrV2J4VDZk?=
 =?utf-8?B?TFEyazIzZ0JpRnpsWEVmblYwTEphb1Y2WDNZRVFMQ1lZVjZtc3g0Wk1JZkg0?=
 =?utf-8?B?alZTcEVZdGNMQjE3N2VjeDNibXRMQ3MzZ2phUERkTFBBdTI4V3VyREt1VEQx?=
 =?utf-8?B?UWJ1U0pYV2tOZUtITENDMEYrUTlheU84dlFpSEtweStxL3ZWTjN2bGprSDBW?=
 =?utf-8?B?c3JGd0daQlhDTDkyV3hYdC91YlpXUlZZQytHWDI0RVg2bWVCWERpWjF5N2pl?=
 =?utf-8?B?L3QrcTFoTkJIYXZvRVB5Z2NWZytNcXdtUjg3UlE1Mm5FQWhqd2RZUzlQZUNT?=
 =?utf-8?B?RFVQQkxFT2NQRDF4NkRXa0tOSVA3TUFVb3ZDdmV6Tlg0dzhidCtaNDZ2V3Q2?=
 =?utf-8?B?ajgwOGJMUHlNcy8vM2kwK2N6Q3hnY1FXTW5rMExXczJhOUVuQzkvZzRjcVEy?=
 =?utf-8?B?bDNLdngzNzJoQTlURmQwbnJGdEdhRGc5OVpxci83TmhWaUsydUZmUzVaUmhV?=
 =?utf-8?B?TVgzK20wTWt5RDFLOGl2UUxrNU1nTG5kYUZZcnZYcjZOMDI5OVJkSmt1aGhi?=
 =?utf-8?B?YWtKSHlCS1dEU1N5Z2EyaWhuUUlKRUhCc2tVSDBhdU96emtuL2xWdkdFcWdO?=
 =?utf-8?B?a2ZQcTAxVGhaL3ZpR1d4UW41NnZXR2llQWhPRUtnWjFiem5TcU4yamJOVXl3?=
 =?utf-8?B?TU5weUNDZ1l0am1vWHYyWEpmaEloWHdGQStCMkFuU2VmUE5hdkdTMGp1U1lV?=
 =?utf-8?B?eGhENCt5T0JsVEFsYWVEQzVMSzNVaVhIVWxYSG9HQ1BvVHF5WE44STlJbTFn?=
 =?utf-8?B?Zm5TaC9xVkdvZlg5Si95NUh4dDNkL0pjSGp3aHJUWmFFRERnbldReHZrYjdr?=
 =?utf-8?B?clp3NFVEUURtdkdSRGF2VWwxNmpxeThiZ2ZqTzBMbGlHSVlMN3htRCtvUk91?=
 =?utf-8?B?a09pVW8yYVZIaEU2K3BEMGFwU1o1MWg1S3R0V2RIaDBGbm1oSDMvNUNjNUQ3?=
 =?utf-8?B?ak1JUFNjR2J3SDlscEZCNi9LOG90RXNyNGkrR0JxYW9veThxd1NlNVVzUTNs?=
 =?utf-8?B?NWQxUkJNeVpOQklybzJ5NUpiaU1FRjBxUmlJVWx4dXZKRzRGVUk1ZDlxZmQy?=
 =?utf-8?B?dzNJZFVZK29GWCtLTnN4Y1ZGbzFZckNUNjZWdFpzNTNjVm91cTNtWCs1TFFB?=
 =?utf-8?B?OVVFQlVuNzE2akRIVkdkSmxBRHNJL3VjOGplZkpIUlpTSm94VFFRQWVla0dV?=
 =?utf-8?B?RStiNGFLTjFicGViVmVJbGpFdlgvMkNNdVJEY05hMTFxUmpmVVMyU0lhTWVQ?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794B34400A38544586677B6E7EAC4BA6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aTMTxyF/TmfTChpmt3RaUHQXaJgT0H0CJxl+lgOWlrhwmbcYGIKzA2R9H2Ho4EoXhOHdLipzlpkDx8CHPSYqV50Ph9eSzdC8QWf6inO3TOHqzQTYKYCdD5T7iR2S32pHcHxg+4dJRYsOyZa/jUuUWIbXK3Y2UcEfHu+vdTYOuvB9tNtBSgK8pwi5SHkoQeo04/Folh8lY1499PM0/ZXs52DS0kB5jSbuA5Co2bMdp08qqqqwEiGNQdwCUigoKu89Xhp9liHB/ipmkDA8DCs4PwEM2NyCmi/6Gj8iXU0IzYjNTh7N6QWTPgY1nKl2kEVo7Chkwq1TvB2zzG/SzxaIaE77JjfvZ8JLsY654Qi37v9J3gtSijQv+HOu/cIMUFJ10SOIIVIizTADijlC6PJPfkBpTmbvZzyA2IqbpD6SiZ+v/P7rrOEr7UzBWdf0XkoW1SnqFYYLgqQ4BzJIAdwPH1mnVl6JthA6dtP4uFTVNSix1OKxP41WOJ97L3lOBqu1eRfod3QOHD0s/mzgtpwZKGxhuZHjigEb+5fMeZw1tFgvnFbsHGJ6Aq8GkIVJamiqEratTJuMAQPevrtcFoFDQN9fM/BGz06VHi+r/88NK2EWg4tFQfYgEH87hlv1wRycyDqeCA0qO2uWA91yiK2DyUB5oTuEWkh+KT5/IcR+QB0GlQBt7YY+h5/LJQkkxi7Tluv3Bkk5PxTB4sF1bA0VPM4YLuP+qNC1UBa/sG48hXBWrXL8EPvNOO2c3TZVzoKuiFnxJkmKniiyvevHv+5suqlNjOcf34lEQ0WMa+wR13M=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb95697-a781-4925-07b3-08dbbe552521
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:55:10.7057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfDrIkADyatUZtm8MoBDvp4xf8y9RHoYIEL0dQUKUXYg58WOsH8DzgbCS0YeyHzE0mpphFqfI/kOhpny5Vnybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5891
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI2LzA5LzIwMjMgMTM6NTAsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiANCj4gT24g
MTgvMDkvMjAyMyAyMjo0MSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+PiBGdW5jdGlvbnMg
dGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3JzIHNob3Vs
ZA0KPj4gbm90IGFsc28gcmVwb3J0IHRoZW0gdG8gdGhlIHVzZXIsIGJlY2F1c2UgcmVwb3J0aW5n
IGlzIHRoZSBjYWxsZXIncw0KPj4gam9iLsKgIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUgZXJy
b3IgaXMgcmVwb3J0ZWQgdHdpY2UuwqAgV2hlbiBpdA0KPj4gZG9lc24ndCAoYmVjYXVzZSBpdCBy
ZWNvdmVyZWQgZnJvbSB0aGUgZXJyb3IpLCB0aGVyZSBpcyBubyBlcnJvciB0bw0KPj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+Pg0KPj4gcWVtdV9yZG1hX3dyaXRlX2ZsdXNo
KCkgdmlvbGF0ZXMgdGhpcyBwcmluY2lwbGU6IGl0IGNhbGxzDQo+PiBlcnJvcl9yZXBvcnQoKSB2
aWEgcWVtdV9yZG1hX3dyaXRlX29uZSgpLsKgIEkgZWxlY3RlZCBub3QgdG8NCj4+IGludmVzdGln
YXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0aGUgZXJyb3IsIGkuZS4gcHJlY2lzZSBpbXBhY3QgaXMg
bm90DQo+PiBrbm93bi4NCj4+DQo+PiBDbGVhbiB0aGlzIHVwIGJ5IGNvbnZlcnRpbmcgcWVtdV9y
ZG1hX3dyaXRlX29uZSgpIHRvIEVycm9yLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBB
cm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiDCoCBtaWdyYXRpb24vcmRt
YS5jIHwgMjUgKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9t
aWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPj4gaW5kZXggYzNjMzNmZTI0Mi4u
OWI4Y2JhZGZjZCAxMDA2NDQNCj4+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4+ICsrKyBiL21p
Z3JhdGlvbi9yZG1hLmMNCj4+IEBAIC0yMDE5LDkgKzIwMTksOCBAQCBzdGF0aWMgaW50IHFlbXVf
cmRtYV9leGNoYW5nZV9yZWN2KFJETUFDb250ZXh0ICpyZG1hLCBSRE1BQ29udHJvbEhlYWRlciAq
aGVhZCwNCj4+IMKgwqAgKi8NCj4+IMKgIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3dyaXRlX29uZShR
RU1VRmlsZSAqZiwgUkRNQUNvbnRleHQgKnJkbWEsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBjdXJyZW50X2lu
ZGV4LCB1aW50NjRfdCBjdXJyZW50X2FkZHIsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGxlbmd0aCkNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDY0X3QgbGVuZ3RoLCBFcnJvciAqKmVycnApDQo+PiDCoCB7DQo+PiAtwqDCoMKg
IEVycm9yICplcnIgPSBOVUxMOw0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaWJ2X3NnZSBzZ2U7DQo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBpYnZfc2VuZF93ciBzZW5kX3dyID0geyAwIH07DQo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBpYnZfc2VuZF93ciAqYmFkX3dyOw0KPiANCj4gWy4uLl0NCj4gDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gQEAgLTIyMTksNyArMjIxNiw3IEBAIHJldHJ5Og0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcmV0cnk7DQo+PiDCoMKgwqDCoMKgIH0gZWxzZSBpZiAo
cmV0ID4gMCkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIHBlcnJvcigicmRtYSBtaWdyYXRpb246IHBv
c3QgcmRtYSB3cml0ZSBmYWlsZWQiKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVy
cnAsICJyZG1hIG1pZ3JhdGlvbjogcG9zdCByZG1hIHdyaXRlIGZhaWxlZCIpOw0KPiANCj4gSXQg
cmVtaW5kcyB0aGF0IGRvIHlvdSBtaXNzIHRvIHVzZSBlcnJvcl9zZXRnX2Vycm5vKCkgaW5zdGVh
ZC4NCj4gDQoNCkFuc3dlciBpdCBteXNlbGY6DQppYnZfcG9zdF9zZW5kKDMpIHNheXM6DQoNClJF
VFVSTiBWQUxVRQ0KICAgICAgICBpYnZfcG9zdF9zZW5kKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3Ms
IG9yIHRoZSB2YWx1ZSBvZiBlcnJubyBvbiBmYWlsdXJlICh3aGljaCBpbmRpY2F0ZXMgdGhlIGZh
aWx1cmUgcmVhc29uKS4NCg0KDQp0aGUgZ2xvYmFsIGVycm9yIGlzIG5vdCBkZWZpbmVkIGhlcmUu
DQoNCg0KDQo+IA0KPiANCj4gDQo+IA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtMTsN
Cj4+IMKgwqDCoMKgwqAgfQ==

