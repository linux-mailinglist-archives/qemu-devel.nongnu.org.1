Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31DE7C7FF3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDOm-0004KR-Km; Fri, 13 Oct 2023 04:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDOj-0004Dw-R0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:19:54 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDOh-0003qa-V7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697185192; x=1728721192;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tcZoiEk1khIkIpyVErjs+iy4sfR6js9TWorvsO9f6Sw=;
 b=O8WTKhPMn+nPmlJfQmiVT1hHQhCRa0r34ya2hPLMfZgnXMMITqzvy0ZW
 u3mVPjgHpBiixmKaUlQS22eXltSlQP4Y74t8uerx/n9nJKeY4KwdI1XGA
 gd3nZiTE1QshYVkJ4dKT9Ib03d1ThaWqe78N1spstndZY/WMhUR3FeD5R
 vEjSnCb0hZ47h9tm7PGsIxwxlY8rQ6tNSjEy00LzPXpi53WDkgInu4zFH
 5OSA4SeJKfznYfuz7g1ZEZv2gHJQm7xkWZIzHMCufMkwBdKuckQr4wa5g
 A/1ipK1ZkkQcT+YSfw4SNHzBUiVGjTi7Xvfq3+t0h/2NH26LL7dZqrGfC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="10155551"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="10155551"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:19:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl/RnLSd0+uhiEmwQM9+DPs285Ckf3GV5D1OSiTd5LnxlgLwStl6mIlAdtL7bsYWRqWxNJ2QEkPtNcvBlVQruLopzBmuaLzlGdAw3ztgYTTbsH+66/J4JsOaVLHVZgl5Wj2QYarg7/a+RY3GaPM70fdEf8K7e8JRvYNYaXnMT9D/wzOZ3bscpTMDxGq85K5X/KzLj/1yVC2AWUc+41C5918VDyGdXO6ZpqFd91nHA/vLZXkUVRE/94zWBdJkWf58ca3xiynw1XolP0PC69VH1YE3So0L4FY776ylfw9bvSb4T0XOvLBUDZcDGyB8pojdddYMG5heNpNSTHOlJ94POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcZoiEk1khIkIpyVErjs+iy4sfR6js9TWorvsO9f6Sw=;
 b=TtziimPJXgUgim8cO/q8MLZWLTyhLfxXrwGH4U9PlzhBmE1E+Kkdf5CKCjx82kBS8o23A3MmS3xfwZzaeOBUFIh/qTXuj3SgguRZOrSmjR+PdjUXI8pQo74evjOBuARvYkIJApRlZ+LWwd1VfnT/GR4UzYd/QE1o+uop8FlKeMBnNirRFtxrpp168/GRrhl+UKV60VtrRyJPGoDpFSmE2Uy1fW2r+Lqaq6EaJnmKAwkxS18+zx3yzxHPdc38oaGl1gI59yAjsopL3Y5aiR5uoWQDBJX694p4TxmD0U167JHPXemoJEELX/bLEWoL7Q/vTD77Q/T7oBrH7XjWjpT7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB9711.jpnprd01.prod.outlook.com (2603:1096:400:225::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:19:45 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:19:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 13/13] migration/rdma: Remove all "ret" variables that
 are used only once
Thread-Topic: [PATCH v3 13/13] migration/rdma: Remove all "ret" variables that
 are used only once
Thread-Index: AQHZ/IKP9r2yR8Ps1ECE6XGO+vRQIbBHYwSA
Date: Fri, 13 Oct 2023 08:19:45 +0000
Message-ID: <9995cdeb-d7f9-f0e9-1707-9c5cd0ab16f1@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-14-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-14-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB9711:EE_
x-ms-office365-filtering-correlation-id: bd1cf79b-7368-4b80-1d3b-08dbcbc52871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsxofcEyTm1qKNA0CyusDFmGInw2a0Trqz5wMYC/lNkS+ZF79QQ6EjL3r8sbQBmG90ECJRaytref3DYw698eUeRT6nl9UBLdKW80Eq+TeutaNGN876NFdCd9yIdvjlQAfq8fF9AXod9BpDUmJ+G/ct7132gsLqPe+ZyjfuJWHWJIIfXIx/rmG4nBoxrlql864osSsT2VjzROJcv0C/jJDfHCP5VXI1PWkc8L2zAtip6xvkCe1fioE+OPv0ftAHV2e3HJQelmxQdaHYVBEPibjfCwn6t+qYqhl9iSbL6H+Bd6iPH/EW6M1+zC7NSKHRLayvKiuMVFd55NRuyyuuzqqkh4o4ZMV8t7bb6ujtKv/NIDVCRd9//GChThm15638Vi9eoITGryneQ+eUXmej2ugv5rviMhZ9mDnAQ8HzxoOxH5EXLrlA5Ym1H5Ofmq5qBSUeJdAwpUAj/AKQ1CtLO/KYWZAXA0ekW93iGv/6wHtsPAJd+qdpRNh8n4h9s8auBTSSq9s016dPZqYa2Ld2JlU86A8HqThPcmazkbKpfcRHjECSlkmQ7e97MNPLIR7pW0yWLbdTXwKcDQjYlatx9E1r0dpqI86RSQRKOr6jtIIUTlMzgqVJxp5nIelrCqaoTHwkH0m5gRXBS/eusBEdUOB75x8bkluxiXGtE53bqLdnB2sskMXyn6qSFiIkluUe6XtU9BBVHXD5ahaCSd+xWWgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(1590799021)(64100799003)(451199024)(31686004)(2906002)(1580799018)(5660300002)(85182001)(8676002)(8936002)(41300700001)(36756003)(4326008)(316002)(110136005)(76116006)(31696002)(2616005)(86362001)(558084003)(478600001)(66556008)(54906003)(64756008)(66446008)(66476007)(6486002)(91956017)(71200400001)(6506007)(53546011)(6512007)(82960400001)(122000001)(26005)(38100700002)(38070700005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVlY3p5OGlxMW94ZEJRYXVOUFByVEZJVlhMaERBZDNEbHpmeTZ4OVdRb1Ev?=
 =?utf-8?B?WlpmUjdJdEpZbldFQk1JRmJBU0pJa05ScG5YYy9FcnV6bUU5NWxZSE1waWJ4?=
 =?utf-8?B?dEpvZURqN3JyMVVtY0xwRUE2N2JyRmVwLy9wNk1nWWk2MENnZTlla2N2SEc3?=
 =?utf-8?B?TEhYS2xoVW05UlB0ZWpBNERnNTFiZmpqQ3RUMGJsOC92MHJkVkpvSERJdDVD?=
 =?utf-8?B?NmsvcDRsQk5nYWV3S0wxajc1U3NGS2U5c2J1eHltVk9BcmsrQ2VlUTFFdEM0?=
 =?utf-8?B?UUdPY1BPK2tnMmhoZ2pyZlZoUnJlZ3d3dnVGZlE0UnMwc3dsMHhGaEJRVHlR?=
 =?utf-8?B?QjFRdDEzQlQ5L0MrbjBiSnJidGtQc09pZVNaUkRSTVpkc2trUHFqY1Vic3lN?=
 =?utf-8?B?a0JyMkFZeXBOZ295NXNpOGwyMnAxK2V5Ymp4dG1lQXhteGUvWlI1cVZKZklE?=
 =?utf-8?B?dW9VdkFkbVNzYjBQMVJQZ2E2YUpSVm1hTXhHMzh5eW5XeGg2SzFHOVd0cjhw?=
 =?utf-8?B?YzRhKzlGQUFHMTB1WXI5UlVYZGloL3dLcklQWVUyVmJjRVgvNUd6MHNTQ0JJ?=
 =?utf-8?B?cjJDZmhEejJUSGY4WkMyZXE0K3QvU3VzVGlrcWJIQ2xGaHpoMTFxMTg5ZFcy?=
 =?utf-8?B?MU1BRE1MekpTZFhUcFdYUmhKS0g1emIvWitrSVUwd1FENE1qVzN2RkVNNzJk?=
 =?utf-8?B?MGdGOEF3QmRoM2lndkdxbndkcnJVejVOY2haWFJiTTNJMEN6aFJUcHRmc3BB?=
 =?utf-8?B?U1RNQ21WTGRURVVSTk8vVU42ZFcydndBd2d5RnZjQ0dCMjRjbXUxYytGa0VP?=
 =?utf-8?B?NEREVTFzU25lZEtzK0tYUU1TeExsV2hzcHMvQkVIaVAzOFdwaDVYWTFoMEZy?=
 =?utf-8?B?T1o1WGJISGtXQzR4MFJEOGxGQTFDblM2VUZCZXc1bi9WT1U5SDgydHdBOTRD?=
 =?utf-8?B?QVdnb3BEUkF5OVQzbUdnOThYMkdGMU4zNzJsT2l3L3diM29qbFpEd3RqN081?=
 =?utf-8?B?NTRiWWhaOTJIWi9BU2NoWGVzdUZUellINkFuUitYTnJIbGJpeFhCaXBFZU11?=
 =?utf-8?B?MjNTWUpoUkovN1ZpTURKdnhmRUJ6cEhVUE05SDM5cFdGNVZCQ2QrZFd0TzZN?=
 =?utf-8?B?Z2x2ZmE1dlUxRGlVWklZR2xRYnVLT0M2cW14aUhnL3dzK1VQbHFZbCtMQ1g3?=
 =?utf-8?B?b0FqRkJjZlJHQ1lUdEdxTDM5SW9TNW50d05QWkNZVFlFU2t5WnVIcFhWMVIx?=
 =?utf-8?B?M1pHMmN6OVlrcksvamY3ZDJRZWR3RGpTcTEvTXZCNVVreU14QjdvSDlQZ3Zs?=
 =?utf-8?B?blNkaG5iRk9nclRyTmhsWHlWZ0J5YllINUVVbFJtMmd5Sy9TR3JMbTZiTHdp?=
 =?utf-8?B?djhlY3VFcElDTER1bllqZ1lEMmhKR3VXbldzS2lQQ3hEaThiWUo0MHZPVGF5?=
 =?utf-8?B?a2doMmJ2Uy9SUFNadmc0NjVWOXc4eThYSC9jc0liOUlVZ2VoVGZuSTI0aXNi?=
 =?utf-8?B?MlRWSkVnT0QxNlVqWmdNRmFQRXM4MzlPNWc2cXpwUHBRenhPSE42NzkxNHll?=
 =?utf-8?B?bTVnaGtiUG1xcmFBQmd4U1N6UjdyMW1VcWxEYXRRWUZadDY3ZzdRbUdkVmVN?=
 =?utf-8?B?RDV0b1ptK0lRbHI3b25rTm9BOW0xcE5vcnQ4SnNiZE1xNlEwU3Y2M2VUcEs0?=
 =?utf-8?B?YWdpeVhvTXN5UmdiSTJMUm5qUElvOTFESExBd1ozVm1Rc1NvR2Q4aTJoUlgr?=
 =?utf-8?B?VTMxMlRFMUVYUTR3bndVQkdoTDFjaThWS2NFSDZmdTM2YWNheURCcTRLN3h4?=
 =?utf-8?B?bUhzc0ZJVjN4ekRWc0tETTFCelZlalZsM2NlZCswNjJTWmdnbHEvbGxBVFJN?=
 =?utf-8?B?bjFnTlcyZy8wZVp4ZW0zdm00c0lDKzJRL1p1Q0Zod0MrV3c5N1ArWjdYbEVG?=
 =?utf-8?B?TkRoYjU1dFlyb2U3dS9uZlpibGpNMm1YWU0vMkUxODROUlpQRnA0bnVsRnJa?=
 =?utf-8?B?R0thMFJGMXdrVjVhcnJkWGpuckFGUlcvTExzbDB5Y0YzdndrMzNwWHE3N3Nz?=
 =?utf-8?B?T3czS2RGanNnOVJVRER1RVh1MnlOd1lKZEhlaFZYTDJBc2pHTXoxZzBIWHNk?=
 =?utf-8?B?eDBiZTB4Nk54dUhLL2JhdmIyZFpDUkw2WitDdnRCNXhtVHdweUVWNUJLRUJX?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BFB87E160DB2B40AEF680A15C2FA86C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r4JYZU9P6iEGOwu8xcFouMoOIaWXb5SHFVmfH2tMaCEbgRBuvwRBtexSAW2EX5BZUKRrVAWXx8oZJz7zcuf5iNjY3kc2fmcZH/a0YAdI2+RAeo04oB4GI3y08Kl8b5IfdsLmA/1a93+evhWQy8HL1ntCmhq5Sm2uyBsfEEC7Kji6IZky7VGV4DPhA5otasvDG8xi1IJszYSQAi6dDJ49V+NfPlMaoKR/VaBCLSG1jfBYkLazc7fBPAJ8T2Cd47agFdvkv6a4ELSfIHTRgmlvisy1pbKb3wyPt6tQci/eU/2Dv98HXMZyMje3zomHJTN1yMHNab2hqU3QFQ3ov0GY4Uz7iFnE4nHG8hntSRDPtySAyiEJfw96iw3t2EojnIp6bg7K7Fnjc/QgkTPKe0OXoHpALdkZJtaaSkpcdvXkSljeUmkQnEugvqQSpNKz1y43rq0f9XKVpmaTHbaHLeN8/xD8URfnK0hVApXGx4iQ7x0kvHljcAej8CjSJKFqhR6lDA2hXK5OTezUcCH3jcWIJvlg0BNkDj9HpD3/rzUSO18ooY6FCGkoVD4MjT511BBz7ss5Q2A6yyZWWm0imqLJB9Pu6ICnGVZCXFr3wDm0w1PqLPzzVv6Sy49FIKjaPDtFKpIj6Do8PovAeWwp9ExxIPLAD9Rezw7My9xNddKdI8MjsXb+wPbbvyRpdmX3qCM4hErQP4KvygzrnlfmH5udS0679oE4tA4PUmkKgwWgkmmw0WlgAmY/LY6HVGTfhKE02cIFbPiTKCQuzKhOKGdy0yp7bDmpRVMk8xuf3hTy/M626mxSQn3fmK7Qc2Lq1Pfz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1cf79b-7368-4b80-1d3b-08dbcbc52871
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:19:45.0228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1lpioTdh838YrLolBe4Qrcc6XL4yfqD/Ea3hxuCHKoqpL08oSCxBZ80e+0Z21wk7Gk+N91DNkuHVDf4fU13Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9711
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IENoYW5nZSBj
b2RlIHRoYXQgaXM6DQo+IA0KPiBpbnQgcmV0Ow0KPiAuLi4NCj4gDQo+IHJldCA9IGZvbygpOw0K
PiBpZiAocmV0WyA8IDBdPykgew0KPiANCj4gdG86DQo+IA0KPiBpZiAoZm9vKClbIDwgMF0pIHsN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+
DQoNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg==

