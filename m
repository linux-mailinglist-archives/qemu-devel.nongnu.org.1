Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7757AE378
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkxEk-0008Om-5C; Mon, 25 Sep 2023 21:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkxEZ-0008OS-O6
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:51:31 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkxEW-000645-In
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695693089; x=1727229089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=H/6xnhha0CWpJpUdtFJgU3g5UBPSFuFhnn0UAQ5lqv0=;
 b=YkJk2fccivT5nXLeCguNdykG1mKO9H2QBEOoWJZJpydGKW0XKhX2QEfD
 J0pIFtrSnvXQZZ/0Ppupt1mi8p8r4w6VsIeoiW4oE9bZPgQ6s1fu6AV5p
 SWv0Maiw4wbCW66BYfwyFXrX1DETZFKT72kKT3aDji7cWwyxBoEMeFw9y
 j/Sxa8wl8jo1+YC7u8fbShRJNteNhAw9LPQTgqaJyFO+lLHesQhfOEQyv
 ubdywX6mB5Z4y9RnDGG8wvPPrIk8ocXzusGBeUo6tqRhyusKvLRYXnx8I
 4AsshBTfPqc9JFTmIYy35GFXpbJgkA4N6Z7ZLvWfkrhuqKLFqludDAkO5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96209967"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; d="scan'208";a="96209967"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 10:51:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caBH55dttxjcAgvz6MwOU2b0eu/OEXevstqafLKlFQYl95WQ8eO02oWA/aU83rUSdgxPz8pdoTiZ/iTWU7KhrGiAsA9DkBNNrDCT4XnZFe10gDzFzcg8/aNKpBUlz2AWfBZpw2f0d2o+HQzPa5QsIBc1bcvSq3iikKJ/PrRZLXsdsDF+UTIFqHQKbo7F/Ut2ZSjonqGQOKStEUR9knoIyMZvkdr1MOqTqC/2jHQTewum1O8r9kPoPMFWMYIfR7sd3GQhmgayaMDlOb6KHZcjJMXAyS530B+SAuxW6zdVRQpTKa7AtNLuFx0QJus/38X0YI+wI6YciCjaOJOIb4wqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/6xnhha0CWpJpUdtFJgU3g5UBPSFuFhnn0UAQ5lqv0=;
 b=MRC40KrDSD1pa7PYp2ebZvVCuU7l8w4raulekXB0660eT7iWmPhI90PPOcMqXD/rn3gK7PM8J9GPLIlvLwlzfRgZIX9YbzrBYj4DG+Lk71+ohmIf3x7HR+JGCvAkHJ+YvOYiMMJYYuFC7QBgPDPhJT7q0pLeZU97JfKW4cZ5Dxo6v8TmcgAqhPdzZCdcqLzghaP06yVbk18OsixcD/gNnrhArcdflExoVFREpDd9FqefxtXFKgmWUTXt3zCxa2xkHI5UqaBo9nJ5Fc9luk7T5oN4tMcUS3PK8/l0I4Ln+spKACmnsQkgppTJPuCnhq+fY+Gv59uhaSMYyGozzXUKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB10729.jpnprd01.prod.outlook.com (2603:1096:400:295::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Tue, 26 Sep
 2023 01:51:21 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:51:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 37/52] migration/rdma: Convert
 qemu_rdma_reg_whole_ram_blocks() to Error
Thread-Topic: [PATCH 37/52] migration/rdma: Convert
 qemu_rdma_reg_whole_ram_blocks() to Error
Thread-Index: AQHZ6j5/S0nQevNwL0+5Se3Lj9WjFbAsY2cA
Date: Tue, 26 Sep 2023 01:51:21 +0000
Message-ID: <65f149b8-808f-1f1f-cd03-dea3daa06a82@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-38-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-38-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB10729:EE_
x-ms-office365-filtering-correlation-id: b533425e-2841-41c7-e75a-08dbbe331560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9hCmmo1joJOZmfkzMo/MsMoaDU7gJLOrGSQ77pQ4caLMnUOrxLX/V9qr3w7PqSIpcczXrpk1HZYc8x5EQEmD8WUmjoXBd42A9e9Z1RNah9ThXUWLY5jT60jMDBH/4Kd7PhL+7bs9m/+HDbXEJR6IyvOGP2BQL45YE6ACNaz2T/VBOLk/R8nIALzQnypVj+ljgm1cT3ARThACw2tEW+pz+jMxnPj3Fmj+fuxOTJUZ2jurwpqiKSJSq83C6COlsVgMPohXxU4ArzgnuynzXzaCQvw9e+qC/v7uxCYfM3nS9ioUaDH++ockpvmxOdwesZI8Qg60CICbllbgap0aGrVGsPxfl0glKMttRHWz7So6sZ193JLm4E8ANYv/EnlxgTlkF56y48jGokWlHTtlA/ZwyFKPS2zxaQMo5LYaf0C5lAX7oggAyQdO1AaRoKLx29Vjrhh9HDD7w1l7B8DXutU/sp34G2+COw7j3uwOXvLcDxGA4t+YJqsyhiQ6mmzg8P+avF6PhvM9mU25AjvVpbyK/AG4OcknUshJG1cjIdhq5FPPD+dijy3ggvc2dp8zNZEZMaC870i+lPqFyEpidztzWk+sLud0gvXYYr4mQAbpDS7teSgYEO/zkXxl3TTOVyyoZBjt4wrkh8fkcV0KOKtZKZ8BADI6j9mrk3cWlK4KJqrz4W3SZirVwg6O8M9aZZh51FOmMQNgGs4jeJ2+37jLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(4326008)(1580799018)(5660300002)(26005)(83380400001)(8936002)(8676002)(66556008)(316002)(54906003)(41300700001)(64756008)(66946007)(110136005)(91956017)(66446008)(478600001)(76116006)(66476007)(53546011)(2906002)(2616005)(122000001)(6512007)(71200400001)(6506007)(6486002)(4744005)(85182001)(36756003)(38070700005)(82960400001)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlJTjBPLzZ0U1Z1WExnckZ0TkdmakNmUGQxMzJGbzFSY3lJdnJZa0VtRWdK?=
 =?utf-8?B?Y08rY1hGdzMxb3FtVkpiNUlPUVgrUDRBR0dyUWVqdFBXaGU5UkxIN0ZVcUdt?=
 =?utf-8?B?OFRGdFpUOThSc2doajZTMTU5c2Y2YUV5TFdoM2pRaGVjOVMyQ0I4NitMeCtn?=
 =?utf-8?B?VmVFMnp1UVIyYTd0M1hGZzhzSitlRzVDRm94ZHJkRUQydzhEMXNMdDZMdnZu?=
 =?utf-8?B?cURRZ1BDOTI3WmgwZzVsMk0zNTNLNnlqL3BGdkg1WGtYdnVzRkpkandJYWYw?=
 =?utf-8?B?RCtrQ3NEQkI4aW5ERkxRMGlMd1dGU3VLRjEzdk5QQ3dJWTVKQVZ4RndRN0sy?=
 =?utf-8?B?aG45U05PbjhPWlpZK3NyY3UrcTcyOTJjTkMyMkdvSEpXOGtRTnh4YzNzTmlO?=
 =?utf-8?B?dXg4MUp6QURpRmtjYnVQbFRaL3hYVmE2bmNCdTRKY1I3TFliSXhzcS9JcG0v?=
 =?utf-8?B?aVZpYjJpYTU4RjdFSm0wT0w2QXY5MlUrYXg5dWRjZzRGM3YyTUNobFNNM3RK?=
 =?utf-8?B?eW12WitZbXpOd2ZsdlNPdktaeWZzc2laM2JhakMwbGtQK2x5VURhWGJRZ3Bp?=
 =?utf-8?B?SkNFWGpDekpOUzJoa0xJanVFWHMvOW11L0s5dVgwdzNSbitPZnhFTHovVTNO?=
 =?utf-8?B?NFBVd3JXVS9oekxMeDVyTjk1am9wV1RMQ3Z3SDZick8rRUV2VFdqWVlkTm5p?=
 =?utf-8?B?bS84aFh6UGxZRllEQ2hpaEZOYXJJR0l4Q0lhdGcvYi9oNDR0eXJKbEZaazlD?=
 =?utf-8?B?alAxazAyNWZ1MC9rN2FkYW4xY1Q1dXFlU0ZiWlduN3ZsbW1iVXJQL2lVa0tX?=
 =?utf-8?B?YWdRVVFZdEF3Yy9ueDVvQ1g4UTVKZERpM0pqcmsrZHZUa0hvVlV0RlRRcHlP?=
 =?utf-8?B?SE5uK2t4V0dwT1h6cEFRdWs3dksxc1JUM2pZQlY2elRXS3BZYzJ0Q3lGUENV?=
 =?utf-8?B?TEFzMHoyNVNBckttMG1ZU08rcEgreDhtZmdBK01td2FuS3ZjMGFsMjhmaGJn?=
 =?utf-8?B?dDUzL2V2ekM1QWw0VWMzWUIxOUxhbVNIREQ4TXlxT0ZXY0g0dmE1dFhWSXNz?=
 =?utf-8?B?OUp0VUhSWCt4RGJ2Q2pQV1FmYVdXL1hwK0l2cWk4Y1Rtc0grdWZ5RDhCQ3k0?=
 =?utf-8?B?SHdtbHBZeXEyMEdXU2ptdDNGejFocXNGM1gveVdxdGlYSEdVdThQRGpndWNO?=
 =?utf-8?B?cTFUcGYydHBEbFl4YWpNazBoTE45WXJ5ajNPeXM2UnBpOUJXR0tCaXQvUGtj?=
 =?utf-8?B?b1RTYXpHZWVTMVVwSFRQc0syZWNOeDdYVFJjMEJmc1VJNHZOVmc5Z3BaL2E0?=
 =?utf-8?B?clQ1MlRQTFZlM2hFMDRSQTdKeGRlT3pQanhreFEzWi9CNjM5bWY5M2E2bHdP?=
 =?utf-8?B?K3F4cXU4VXVudytCeGNkU05LRzBRdVl3NzVJamtINGJFRXBES2hncndRSXZS?=
 =?utf-8?B?QU1nSGVsZkhFSXlrS0FvWDBuUlJxdEcvMENLb3NXdzZpbXM1bEs3SFkvd09z?=
 =?utf-8?B?WkI5cG9FVW9SV3U3aWxKemwyN2ViTkY1TmZPV1lpcWY0VTZUcExMQ3NYOE0r?=
 =?utf-8?B?NjhKRHpNUmtaWUhYNC90SWl1cHhWOS9nMU1XQnlESWtzOUlmZXBDQ3RPR1Jy?=
 =?utf-8?B?TGRIQUZaK0ZZMlBueUJDTGlrT3pHV2JHcGV3cVNqNjJmNnB5UzRmVmZ6Y0ZX?=
 =?utf-8?B?VDYyQjBvV3dkWGs2UkFNY1Z2NEF3c1o2ZW1Yd2RqTks1anl0UG95V2NGVkZI?=
 =?utf-8?B?dHZWWFNmVEYzdDhZSjBVV1FmczI3QW5EcHVBMHo2c1ZZU2VTbG5FQklCeXkv?=
 =?utf-8?B?Q1RkOUFuYW9hNGtjMXg1N2txOUxkYUE1R1FXMGFRUXdPZk91OW1vMXAwSWlJ?=
 =?utf-8?B?akpxVzRwV1VwRHkyYndUMG5lTm5XeFBXUFY4WHZBZHFncHBmOG40Ui9BNDI0?=
 =?utf-8?B?NURxbkN1MFJRbDlGdDVBZE5ZbEpLYkNvOTF3c1NMK1NWaVlZUG5uckV3bWR3?=
 =?utf-8?B?dWZiUEtVVG8ra081NjBvRGNCZW1yMmpjQmIwRnRZMlZzTDdldVFmd1lPSUM3?=
 =?utf-8?B?M3VRdmpXNXJaYjM0bSs4YmxpdVN4QUtYR09mTzUvL1NONjRKVTlYM2U3Z1dW?=
 =?utf-8?B?Mkg2NDVSaXhwbmtMYjdxSEs1aGI4L3lBM3Nzc0dja0JEeGZMZ1pHNHg3RW9l?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3F618768BB0BA45ADECFDA439F7818C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7vSMW2pEPHdJioOpMmlsdozqR2GJXUoKhHT3Ddc4K3teMMWxcSQEWMWsCyZ6aW4cHRrRqFyysjQH3i8ErwlgLiWCZ1hS5ndjxKR2VbaoFSkMXlC6SnhD/fKBQY+TIaIubvOByb4calica2pIgDSoRgOMPLa0AXQeN+8B+N6f4unhN067sT8bXjyLubNVIXq/fmjH2/Q5IgDQAOPbhNk+L8Hf/Ta4XNfQrYt0dtEQ0H6lMY9FlXkzFPVeBNRjyVK8Pf/j938WLUeu5NMM8HocsgI9mleIsLpb/sF39jojgpM+HKiFLwGvXgRCnuZs+iPSiyaq4Ui0LjQm5kqjUFdI+uhnr31Fw/m9rEp0qawIs3APD5Qtxo1bWSdihMb24eEwh0OBXPOxFBy8xGjRp8txJPMBS4ZttNoSzvNrTd8QW+DRQJyRSgpMQnRD2eWF0JB7aB5qRh+MqkzAM3CIBHIO3Cy4lIRKFRlr6oCYXbsjkxOh6eWKK5mqju+Poy/ZPgIQdxuHOQQT7K2AdPOlFjEmpJRDH6HLvwW8xEd05Iv/+zbyZzXXjwqWUSDWoyByB2auluwpIlnOI6GkxwBNYUwymIERbo1sdGSgstuv4rovWLH4YYDDSz5VQN7OjLb7ItJNekQ3gWR4+9U9suxRVKFkEPP4gQAjGQVtPidVToSurRyN5VaKOFHIV4eMt3vhRJIo6SKLOc2Xs5MR7yhqrokx1TES7Cw5n4yfkPGWo0wrxfo79IX93ALDXVvZqe5XpeYtPTmBNalVZdegWlNSYmuDHdq1+PVJpJsb2yH60IRlRO8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b533425e-2841-41c7-e75a-08dbbe331560
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:51:21.3774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nac2JBe04Yuu6cA0v4tXc7A9r51CUOZia+MmHCNqdPlTSI7tLdyn6PJvWGHTTgzFgprUcH6wyGDwEd1aeYwy3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10729
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfZXhjaGFuZ2Vfc2Vu
ZCgpIHZpb2xhdGVzIHRoaXMgcHJpbmNpcGxlOiBpdCBjYWxscw0KPiBlcnJvcl9yZXBvcnQoKSB2
aWEgY2FsbGJhY2sgcWVtdV9yZG1hX3JlZ193aG9sZV9yYW1fYmxvY2tzKCkuICBJDQo+IGVsZWN0
ZWQgbm90IHRvIGludmVzdGlnYXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0aGUgZXJyb3IsIGkuZS4g
cHJlY2lzZQ0KPiBpbXBhY3QgaXMgbm90IGtub3duLg0KPiANCj4gQ2xlYW4gdGhpcyB1cCBieSBj
b252ZXJ0aW5nIHRoZSBjYWxsYmFjayB0byBFcnJvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBBcm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K

