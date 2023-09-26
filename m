Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA48C7AE50E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0dV-0007IK-Q4; Tue, 26 Sep 2023 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0dT-0007Hx-Qv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:29:27 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0dS-0002zC-0R
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695706167; x=1727242167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gdnGG/3jTPYaRgZe50MIDVi59Eg5y3znU3+2jyNIrto=;
 b=n2sh2rmtFo+mLBur5b4ETL7jaADBnebtDUb1jgtNhuBFIuH2SVenhwc1
 otciQArL3vNBtMRaX9Y/B/7sARODoXADJDttofJepgEVRzMoHOCooogyZ
 DYCXpO0yqNOece8sIyVu2Be8ui+o+OlkiMDxuTkBmCpCCqiM8t0T2Krla
 seBVdhO+Go7Ehcvyr8r5bGt0WNLTnbMgHQWEyzoybkntKEpsL2VOnw1QX
 AsWCOo0hbo7WsopVeGfAD/T+tuTHmiARMxxu3ePT9VMJKdj7LPl9wq8NV
 5HyacaQ9iDtQcvn6p4yxfB4y+N2FDofCONFbdomKobfluhTwiG/9Ni5kA w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96351296"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96351296"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:29:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE85yPRp2lKmNTbGvlTMQzilhL3imB4MyXlWYsZZ4FHv2jbjTL7CCb9zGydCPMp6FYTxmPv9p2AnaPqTAywt/DgFaEnoM6f/e/PqJekJPRYP6CNi7CO8aBP6s+NBpka+rWBvcliubqo3YdRr0+Y01tym8iZA6S6Ah580Y+iQ/Y3aLHNQlFV2CYgWoBE0iPyRH/oq2XPr7uy799keJ5cZ++sdspdz5kNiii6JUhEw7QtGMD1E31QogeD6ECTAW5yEzwmx/EYMn4M7i9KRr7W3aoXb8W3/51WGLL/3pnoaW7kUWzL0Mf8QQdf+p29SEJAKWgt5lJeoROH0WoNGrcMZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdnGG/3jTPYaRgZe50MIDVi59Eg5y3znU3+2jyNIrto=;
 b=SaPKVEa5PJm2gdzjPem9db0VT6crKm2l4UdicfgqV1m+d77V3L3cp13PO0/lfh9eQmpBuLPQqKjXos1gOsua3vPqIImnt7nAIpIn58s5K8s4pqwnDoEiCPdpGJypAQvpoC45kMVpIX2JPJBN00y5eMs04BzEPWJ2GhfXPjTLFuwgrq8WTf6pz8dtojnHxlFZAg3GgljZoR5mKVgHGPiCoD6oUdyXsAYVNrM8wsfmhSYxyelfTVZ5blzNPX59Exw7v7qk/5mFC3OS2ktqhZ8W1rrw4tQgDDW/ihb8vte0NE/p0uJV/6Khd2XcNFUvwxIfXGzp+88lUAORxQYnPQhJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB11860.jpnprd01.prod.outlook.com (2603:1096:400:3fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:29:18 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:29:18 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 41/52] migration/rdma: Convert
 qemu_rdma_post_send_control() to Error
Thread-Topic: [PATCH 41/52] migration/rdma: Convert
 qemu_rdma_post_send_control() to Error
Thread-Index: AQHZ6j/Gxmf4fW7fHUm59DPMM1cztLAsoEmA
Date: Tue, 26 Sep 2023 05:29:18 +0000
Message-ID: <67e71511-a0cb-49aa-52c0-8bed73f372e9@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-42-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-42-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB11860:EE_
x-ms-office365-filtering-correlation-id: e734a6de-b1a0-4f4b-b2a0-08dbbe518812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzjg+4eFjX+ORT7Fv7PCc/5mAz9B1wSv6NwI7isuJkQK5ldQDqYg5ip/GZ1e6NXQo9RBbav1xS2NgvGXvRIW1hQqFJbeSpvvRhCgec6g4PrqDA8QdYeTfkungzZVA7qiJQNZMgz1FULDLfxpHSbMYb3wAe89mJn7rEMjA4vHjBpAx0QC2s+1V7MLnhSVrKlc9LWQHuSY8bZRLmfOTiSg+KUQjkFCO/72P9/Vde0RrAwBqCNUq1jatz5pbjEzJxlbXXTwcoIjKl/5sA8RLlbuj+Z8cskWo3uD/4ePe0qvzw5evGqVN3e/iieppYCW73Gy+PVv6JAHvUzT1wsBO5NCEVZgtUL+E12dL+7o9Ca3a0beUW/GBuR5H2kC2Bj5s6OwD2NyR3IZFrgsSiwIxAC4NCT0A8HmfDNiAoFKBCpPIvbHrdGVDM5F6deKM1UairXThMRs6olmMQhEgVGtuZKolthk/wQUabCeE0zbxk0FFCFn0Hv2CiFla00FX4Wl4zaROJkysYoe8Xi1wjNszaUWS3aWDtCTCSPYTpTDoYcoWT7F5wPw7Os2wZ0JDXSY/ewSiQht0xmqG+vp53wYyeEXaQkbMawjngoi5TnTy9Jl3Ik9pMV5mvZh+uuMKOGqi7cS6GVHPkDNH7baJBlaj20lQS5We5MdppIwwlAzdys7nScX/chWzFodTbDAdF7zAoAvO2KeQiRtfBOGpSE8o3ifhFETk0/+jLUM0uYq/DlpOCox0U0tW2aQJO+RCqY8Stx4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(85182001)(38100700002)(82960400001)(31696002)(86362001)(31686004)(1580799018)(53546011)(4744005)(66476007)(5660300002)(2906002)(2616005)(478600001)(316002)(41300700001)(66556008)(76116006)(54906003)(64756008)(91956017)(110136005)(66446008)(66946007)(122000001)(6486002)(71200400001)(6506007)(6512007)(4326008)(8936002)(8676002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVppVUpOZUFLQWY4YmhaaFpUUmtMYjJoMDVoZHlkbDZYZUJIY2xPYzFEbEl1?=
 =?utf-8?B?Q2FWNW9zNUhSajNKNkduZmhOZ2xmb2hFV2xtV0o0eTZPNzE0OGlRdzNWOVc1?=
 =?utf-8?B?MVhWMFYyK0l5TU50Mzc3YU9nNUwxME82Y2J6ZkxDZi9iY1VOVWxkZlVzcGE3?=
 =?utf-8?B?WlVjQlY5QjRPd0pVZFlKV2NpQkF2eEhZeUNaVlQ5ejdFS01aSytrUE81NUxS?=
 =?utf-8?B?a3lyektnbVdRT2hyMWFJbjUya05UTjJ5Y3Q1akNJUDRhZTFrU2tSeTNTMEFZ?=
 =?utf-8?B?OGpoYVJjTGg3dGxFOW9YSG1PQkdpcG5nVGRDNTZhT1V6ZGNuRlY4OFByMEJM?=
 =?utf-8?B?TUY0S0hlakJTdGluV09zdnI3OXFpb1hHT3hBRUxJaWNuZzQrdyt5eVBucWJG?=
 =?utf-8?B?THo3bHZxYUxRQ2IrdmRBcEt3bytacWJnTWNlNWZWLzl3MzlhSUNqRXlZMVVX?=
 =?utf-8?B?dWJscE9pZVdlNksraTJWVURVQWUwSzB5WEdMTU9EL05ndzFRdVA0bUhWeTJk?=
 =?utf-8?B?S2ZQVTRqMjh5aWRWTmNyWXVueU9TWXl3Nyt5eHhUR1p4S05XdHVTN2xHT2xK?=
 =?utf-8?B?OXNJTkxJSW1uK3ZsNzRVdzhaRnl4ck80ZTRWZjU2QW9qemRNb2dLczdyZUlo?=
 =?utf-8?B?bXp2WHZlTFpCYWhWRXF5NnNTZ3BpSWkybkNBUzhZcXNHQ3BLRm92d25aSnJO?=
 =?utf-8?B?Smp4bjJVT3l4c3M1WlRsMmpSTTgvc0hZSG9aTlN2TVJVdmMzVkh6TW9xcHd4?=
 =?utf-8?B?amlXM2RRUVM4Y2N1SWsxODAwYURFZkF6aXA5UkhYYkFyQ0hSdmQyNXFjVG1n?=
 =?utf-8?B?c2ZlM2pORERpVGtLRnVTMDAyMmREdmwrMEZML2lRVTdJU3FubXNISGMrdVZk?=
 =?utf-8?B?KzdHVlY3dFJubm5Pa0JZZDRMYXB3dWFSc1lYdHBJLzBOZE1hRmwwdTk5dmpG?=
 =?utf-8?B?RGV5WHkxQWxYWmdzdG1GbmRBU3RIV2trU0JXYjFOR2xtVzRzbkdJRUNLbXly?=
 =?utf-8?B?bk9PZHNjVU4xUnRoSVFldUh4Sy9oSGo0ZWxtdFVWVG9QUkhqRjRyNVJab3Qv?=
 =?utf-8?B?NFBpbS9jaWR4WEs4R2syNG5leTdWRUh5Y2ZHL01mQWh3ZTV1ZUcwcDB2aWZh?=
 =?utf-8?B?STViaElLaldxQWZjYVU5NUEvdUZ0TDBUMk5aMk90ME0wd3BqY2xkVDc5U0lp?=
 =?utf-8?B?SjJnVE5tWVJ0NWxMTnRiY2tsaVJlTDNDYlV5RUdvMUY0NVdFYm5yVEVtb3BB?=
 =?utf-8?B?dGlGbVFQZDJkWDNaRGpNQ0V5aG5nd3E0cjRnTGszK3pUQkJhTHRISUxoRGJq?=
 =?utf-8?B?d1FHd0NZdXFlQW9DYlQ0SXY5Y1J1VEpuYUdXYVJ0KzVtdnRtNzhsMjMxMHdL?=
 =?utf-8?B?S1N0Q2p6bWszbDMvMGtJdUF0QmJhYk4xam9vcWVOdzF6VktCNnBaaVZFODBI?=
 =?utf-8?B?c2x0aWdJRWhLcURLcklmVGYrYlVLMGVFdXIrUUFudkV1US9FZ1RDcjA2R1cy?=
 =?utf-8?B?M2laK293Wnk3NXorU3d3ZkhoUThyQXZtZWM4bnRJK0RacktJYitmOWNZVFhN?=
 =?utf-8?B?cWl4UjJJaStkMnZVVjZnUXNHOXI2bUNZZHdlYWJjbGZ5SGNjQ21aM2lhcTIv?=
 =?utf-8?B?ZmsvdWN1VHlia0V2NGU0TGYwQVlpQ3pXQzFNZkdTVTR6WVRvVjdJSVZ5Zmxu?=
 =?utf-8?B?aUlLQ2trYnNCaEx4SU8zeWZTN3JES1B5N0w1aXQxdGRLYWJFVTdNNmpOM1Bz?=
 =?utf-8?B?M0RXZ1N3Z2tWdnJMdTc3ZW5XcDZzdUF0TFJGdkxXRWVyaXV6Q0czQU00dW9U?=
 =?utf-8?B?ZXFwQUJFUFUxSkNldUMxZ0pOakRPUnQ5MWprTWtITnNpcEhVK2hXb3g4YUdJ?=
 =?utf-8?B?QnVoMEdRYU1lbTRUTUhLcVl4VUc5YUlOeGhldC9nN1BEWWs0czZKYlJhWEYz?=
 =?utf-8?B?MGwxTFNrY3FBclBnUWpqZjBlcmxHV3VleUZ0L3FOU2srNzFtU0N2eFp5WWIz?=
 =?utf-8?B?NDJRWXYxeC91akZlaXV5d0ZSWEhVb0UvZUVLclB1d3BQQS9sT294Q1Y0T1pB?=
 =?utf-8?B?VlFNN1ZWNjVFc2xDN1J6WWs2R2RsZXI5ZnFCTFRkL2IxNmNFYmFwdlhRNkRk?=
 =?utf-8?B?RTNDNFhKTUVjRmFYMTI1K2d5Sk91VnllcU5uaUVGTFhxdzdNeXN2Q3hoR01E?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C62927A8F65072468E26EF45DB28B506@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nZLNjokpC3WOZdd5/4v9+icqrF2K1PLXooA6TtQdeB6fgZ9QCWWk6ebNDpy5G2c6oNgw5XPHPZvRBgd+k/IFwmRPoK9TXnaek3fLTHHNx3Iglzyq+EeZAcVTB3oKyNvzd4gg/0DFWzbca9XwLvZOinAS3KxD/L+sc5Vlj3Pk7L1yIOHrzWkSjs3Blk/UivARudNpY2A9mzhND73WyKRr3vqKFNTXvgN3IWWriH85CnDtN7h9pwgxwjylTAp86T+wJHTB8eQCV1lKnHGZp898zdQ2v/oar7YrW/cuNe7V4g7QjBbhNBMWJ6lpXDC36XWypLltc4/Nif6lzBliEEJiM5WQSCzIhPgpy33sgyoXtqe32n2BDbWIVEzNdzWZJfizQUa4gvE9F/CZpYVv7I8ZnSJEaZHNBUty4opz8FrIyJTalrYP2SFdRwLu9q+s6nWsnkoZe5aXqchekJw0tbTYrFofgzxs/un7l6jBPSDsQAb/p962KbWPf6rSJlaJlajks7ZcJ3Y5x67kbWzCwqutCLnCS6q878uXWaSR6ORpjAF1/4/L63b1PfV/X0IPU+za0HgkXxJ8NaMiVxx2XtpRHNmiGyQOKG8JnPVeALSJZrDYmhWAtBoa/LawPXSRdcjIN3NnSBIfUdKXjd2DrqqOUm0BtQHdlQC2rnIPsUAsx2/7SoiGxTbr7LxrlgUeFaBEkjCYW9BiV/R0RwBL3/bXBTjKubeBSfCRpvGyMGNGRKUj9f1hH5VoLeXRG4CJiP24dQY6Kb4wK7tAw57LsyLmcmrpC9JeFADhshIwUygdOMk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e734a6de-b1a0-4f4b-b2a0-08dbbe518812
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:29:18.7333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKsL9ULpcpWnWdKeesrg6fkyKDBHDB15k29zwGxKNevrnJt/17BtK0vuOZzSMNBpoQ+3RWHR+Oi8iSEx/0dVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11860
Received-SPF: pass client-ip=68.232.156.96; envelope-from=lizhijian@fujitsu.com;
 helo=esa13.fujitsucc.c3s2.iphmx.com
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
aWEgcWVtdV9yZG1hX3Bvc3Rfc2VuZF9jb250cm9sKCkuICBJIGVsZWN0ZWQgbm90IHRvDQo+IGlu
dmVzdGlnYXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0aGUgZXJyb3IsIGkuZS4gcHJlY2lzZSBpbXBh
Y3QgaXMgbm90DQo+IGtub3duLg0KPiANCj4gQ2xlYW4gdGhpcyB1cCBieSBjb252ZXJ0aW5nIHFl
bXVfcmRtYV9wb3N0X3NlbmRfY29udHJvbCgpIHRvIEVycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

