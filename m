Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66EA7BC4EE
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 08:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp0Pc-0007B5-Hh; Sat, 07 Oct 2023 02:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qp0Pb-0007As-3U
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 02:03:39 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qp0PV-0000lN-FU
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 02:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696658614; x=1728194614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7la4mvEN0jKypQHzHA/RJMmputoBGe3tk34U26nlhvU=;
 b=gCm0ClpeileLetJ2SedMzf6GtAfvkzyl4BWDxCgzYOxolCPXAjDjUN9M
 T9FG4KfZKeqOXfZ1dlrgkaafLDsKpeIsielLCSx9z3qzzciSA7zcZot5a
 TtfOWuLIltvSC2cBP9xJydrBFY16/6VBuid4QJt4qhwsOyC7FOqakst6y
 bOAHT4P0pm3egjk0ppkgush3v8PW0Ld01+tOHCNxhILT0a9slmffiaIui
 nJ6w9QLAiBYdcOjdj60eI5PpS2JYBDba+SDDB5LbSC0HzMNrq1XlpoaXx
 OF0rpcxXnw/yAX3qDcnzAru8EEZvmgqW0BPS/blZFAeJp3LQ/+20cvXQr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="98227752"
X-IronPort-AV: E=Sophos;i="6.03,205,1694703600"; d="scan'208";a="98227752"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 15:03:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFmiD3kzjlvqUIEwJ8Gl4vZt+367i6B5p0PrMPFM1mdeeosSppqb2oQoqfkSJilewE9hgMcu0/cykKQaS3wkJt/fu4TPTCjt3qm+EgwbNOSvBTb+QVa7wnfS8OLehKlN9gq9RuOt70ZE6TyuwSWIaa48m8Pfidi4/RkRqofc+wTvcGYnzwR1OiyXWgnJmWbSSIqwBJ8K8PCTcMv+qAAzlZ4GtyFhKOXFeFEOKJ77mLktX7FD36sLLhpPL2Tx7oXBp2hLQlSQ7NnpOH3z0cEElo/Kv+D/mouejhr2IoHZ6yfZvS/b0+QGsw9hVXfhXHXDc24eQB/dgKzmd9JrbGCwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7la4mvEN0jKypQHzHA/RJMmputoBGe3tk34U26nlhvU=;
 b=EvZSOYpTpNSm0sj70fXLNOJKHEM0qMsXTMmU1ncMrpKHGdGqJ7N3MtZUbN/BYb4RzY7OjES18lqBvNUpegpmDtP6vwP16RRcnbvX3c09pF4dcTJ6MSfx+DiymPDmwWErDLjLrkjK3qOQ8i4AgmSgv+Z7AZpVwHjfj+zMQHahajohL/wKt7iGASfAUWK6DSLFEMqahZe1KtPSZ0GxFBh8T+J2MD3DDkkRecvaqmBHml8dyXyuemVexROdxbfHg3C/1yf8hpI9t/Bs/V4ly/69zNpKmSMrSHYRd9OjeaEVtH7q7PktkVvGjq+7UV1WxHA0RUC9jScLDeXQfw/IXbRIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB9577.jpnprd01.prod.outlook.com (2603:1096:604:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 06:03:23 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 06:03:23 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "quintela@redhat.com" <quintela@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "leobras@redhat.com"
 <leobras@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
Thread-Topic: [PATCH v2 1/2] migration: Fix rdma migration failed
Thread-Index: AQHZ8GBlg2SkH4VrUEaEJTC4tn6qLLA4disBgAVxCAA=
Date: Sat, 7 Oct 2023 06:03:23 +0000
Message-ID: <ff14aaf6-d855-561b-b955-8098f9d5f29c@fujitsu.com>
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <87edib5ybg.fsf@secure.mitica>
In-Reply-To: <87edib5ybg.fsf@secure.mitica>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB9577:EE_
x-ms-office365-filtering-correlation-id: db64db36-4e46-45ae-b2f8-08dbc6fb1d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bq8WThxigRRBqDnSNt1Kvus/mdhvtGuz9ciYyHJBKqcngt/49qezFvAyhbx0/ba466bkQ8GqCJy51bF+oznKo7AB/nyA+TjamaF/KMQ91yQj3iRbGrTihjvEll8vyHi2gUjgEYgQmmtft9Aao/e3GHwps5dyyzmzB4BgihzhK8zOlZaNtlTFD7HMlH7fttiNFvR560wKXqrXHcw9IwM7iYQrY0DG5o1/8RU2O3EE3THwlfGT1LD3d8ueuHZRkKPYUz7Tu0WUO6RHzYJdDhUD/Y+tqYda3ooJMTwEhBpHT0DNMCDpxu05EBHccg+AMyCrXXtSUMa59vYrTdnIej3JO2xT6koG40yk+K4EEYuzgXAgFErangTMaShNqfeFTBtmOZFdQqQlFFl+fIeXl3U+mM1Ni/oXE87SH0WPl4Hf+NCt2D8i8kU96a9xqcDxLmfyzLhfWlryEVU5Uc8GL7B+9YhO9ozWxXsJ0OmCaXq1xnNmMZTI/FwJ9LupCamVWzl5deS66bR5GbQxxwJbxzzpKNiJMh9nQ99yH65anlfq/MhcHLbC+GqON6oIv+M9J+fFYqi6tyI6Iho4BaOr3sWt49nB/h5MOZ8LwMm7Ac4g8Vzq/PVYwnjdc8f8RNHia/MU24b+2J+4wgUcgnDZKCiCeRDJAQqIKjxaV5ZP5hCwM1Cv7tMDGmGQRU/V0g74kdNvVllYfDTZ9DKXxd/ScahNvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(64100799003)(2616005)(91956017)(76116006)(66946007)(66556008)(66446008)(64756008)(54906003)(6916009)(316002)(66476007)(31686004)(53546011)(6506007)(26005)(478600001)(6486002)(8936002)(41300700001)(8676002)(4326008)(71200400001)(2906002)(4744005)(122000001)(38100700002)(38070700005)(82960400001)(36756003)(85182001)(6512007)(5660300002)(31696002)(86362001)(1580799018)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TS85UW55QnFVclQvMTBNeENCV3hjcklJTjMxVGMreW94cGdtcUg0aXc5RUdU?=
 =?utf-8?B?Sk9wOTVSL01TbmNiTXlDU0tFRHV3cTdJY3FsNi8vaHpkUWozdkVqNng4SVJM?=
 =?utf-8?B?YlJzQU5BNHk2N1VkTEE3REtnVkhZSEtvQnNvTkJXbC9lZWpXc3FaMGUxb2Ev?=
 =?utf-8?B?cDZZVnh6dk1IVmkwSjIvM3hiMzJXV1ZqVTlKenI2dyt2VGZhZFVrVGdEYnUr?=
 =?utf-8?B?Vm9wN3Jvb2VibE9CZURTWUNSQmMwVE85eks3U2hidXJYN3ZtcndaR1VaTk5B?=
 =?utf-8?B?UmluemdibzNhUXo4N1ZRaExmNU14YmZGQVNJbVhvNlNZeVB0d2RONDNDaktz?=
 =?utf-8?B?MFBKenNMMkZvZFYyd2s1d3FVK0J3YmYyNHpqQ3VEYk1OcFp0UG1ydnUrSVhW?=
 =?utf-8?B?YXdTMzVKOTdLSHdPN1RwTVlmVktmb2V1YkRUcklEVXdHRUJTT1VpbGJjbnI5?=
 =?utf-8?B?aTJKZnV4YkxnRysxL2lLZG9YNUZhcnRxZENSVE1nU3BvMDcxcHJyTGtwSER3?=
 =?utf-8?B?UDBUQjlZV05DQ253WFduTXY5N2xNOWRJNWNBKzhITzZGUFEzVUpnNTdINFlo?=
 =?utf-8?B?U2xXdkxXWUR4ejFIQVh1di9NeThJSk5JWGRPa3lpSC9pekFrMTNYUnBZTHZP?=
 =?utf-8?B?VmlzcE1XV2NnK0tPY1ROV1RhRGl6OHNkQkJCSjg2TE4xUmZ0KzNDYVhoQ0Yr?=
 =?utf-8?B?ckZtM1lvZWtXK0pnSDE0YTFmR05QcmxTdHBtODlKMGN6eE5Ec09JS203LzZI?=
 =?utf-8?B?S3I1ekFvajNKMzlZdzF5MFk1cDQvOU1kc25DZHZXMXpXOE02eFBtbnYzempv?=
 =?utf-8?B?WGRpVy9UYzhEZHQvNjNrc3VGSXJZWHZDbFYxNERwOHRMdS92SUdIOVB5NmRT?=
 =?utf-8?B?aHJXdmNLRHgxVyszVVdxWkJnTHVhYzhNSWdNaDlnaG5XdS9NakUvenhNaGJQ?=
 =?utf-8?B?WCsrbCtPaUJOeC8yMUtpaGtJMkRqN2xKRjJpb1A5Z21xK1lJQ3N5QnhtZXRT?=
 =?utf-8?B?ZWplVjB3eWpiQ1VtdkJzWTZrT09uaEdNQW1zUFVMZ0lBM2xxK20wSWdUa2lt?=
 =?utf-8?B?VnN6ZVVWTTNCRTFhN2VQT25NOEhmc1dnYnVtSVRvWEkxd2JldTFJZGZaK0xv?=
 =?utf-8?B?bnJOdnR5R0NzU2tUMTJXaEp1VDJRYmdTWkozSy81ckEyYUF4MGxHRTRsRDhH?=
 =?utf-8?B?VDNCZGtCSnFUY2dCYjJpNmZHZ295NDhQelFJN2w3MWVZY1RSeVRVUE1sdVZZ?=
 =?utf-8?B?T1BqZytDV01CRk00RDA2aFJXZWJiYytVaHdFei9iQVpsR3ZtWFlNSlIzN1J0?=
 =?utf-8?B?MUNlaWZrZWF2cFJGYjE2K2ZGY1M2eGd0amFlWS94b1F0SU5iZzk2dmxHUTBu?=
 =?utf-8?B?MndSQ2xqMXJlelBtUFVTOXZ1QmZ0WDVCZnpGRmJCZmVYdFZoVEd5Z3hob0la?=
 =?utf-8?B?cFdTSUNBZ3ZjWjhKbFEvM1JkeHNBNEZJRG9KL2JDQ1hTZEt4Z09tdHdwQmVm?=
 =?utf-8?B?V3JJTndVUkVOVlRnZ1VEcy82aUJaMG5rTFh6L1d0OGFwUHJJaDBTRTd6bldR?=
 =?utf-8?B?Q2lWUkJGUExxTkZReHBsWDVkZXEwZFVsUGRKZGVZcEo1THprWVBtT3p1dUtP?=
 =?utf-8?B?TEE2c0VjNEJTenFlTDM0Wm8reXE1WkQrVWJ3Sml6KzU0TiszVjBoaUpBOUVn?=
 =?utf-8?B?d2dncmxVTmE5dXNOM2JEVnZseWZYYkdreTdoN3ZTTnR1QzRvTXduNmh1Skoy?=
 =?utf-8?B?SXhPNmtBbVNTanVtZmdZWm5pcWRndnYycjdOb0NTTUNNUDRteVVoR3RrMXU2?=
 =?utf-8?B?NEpDclpLYXhPTnloLzNVYUhHcnI3K2M4SWsvOE1XeVd3eTdOQi9YL2xNcGRx?=
 =?utf-8?B?VVpqR2cvSTVxOE4wRTloNVlqdzdyV1VDK01XRnpEQjVwR21iMk52aGs2ejBF?=
 =?utf-8?B?eFFrUGNaMkQ3ODJvdS9QdWVjR2s0SllGYU1ZdnBBY3lCTHduSUVuT3Z6c2JI?=
 =?utf-8?B?STVVWElOVWljNkpvdU41b0k0ODAvTDlaSVFkSHZSMUhpQnljcnZsK2FtTXUw?=
 =?utf-8?B?bFdYRmJiV0JCZDdDc2hlVzJpbHFaRG5xUGVZb3dFQkhoSXg4dE1taHdHMHZP?=
 =?utf-8?B?QXJ0M05FdzE4dzdSTUZMVW9NUFE4OFlPU0Fsb2ZxNnFrT21XNW5aRGM3aFh2?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1307E8EAC717841B962900EFFB52D4C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WmFXuCRIleXBANDgv0mWTqT3wrED7efdAfkmM4Nxz9pcG1f4flo1jQZmYRX88X6ho5TqL1+DSVp1jZBRXE6Ixyk+78qrei/j2lvIgBZqF8LLhJ2T2Ja3wdK/vw2WQ9ky8TpelIu1MrEAp7Ev5AGTaaBlLqCkrkm691UlfEKliVHp5NR4fZlT+M9vLz7h9Wwjusknyw5lG4hsWvgCBIHvzAZCDBLDCkBtHVzMOgL9DQJ7fv50CnmTyJoVJ881Y5CL0cznPW8TiOqiYDHHP6dBAN9hj5xA5cWZDr6mCjECVDoeKL7Do6Y6l4fliqqyUZbw9so24LzWqhKt76XWoWZb1N5cx54n1PPGEJlZ5fEiD0dNw2cqTQyvsKfb61GJM5Qr/j2+7BWYmVnLCMltRAIA2cetWnbTQyPKYbBGNMQXvmBT2DCSxeupnACK9vnQhor8eV96bjzTYmpcDIiFhqQ9GdnJpOhRthq5oaetQ8OfvwXacSJrjD/7RKEbdto08Fh8ZojBgBMNxOTunVBf7tQRFX1Y4VoQtw6XC2YB4Z6xywTP+jgEuV/s8aZXC4LUNY2J+PxOgR7OXTQIDNBKPTKdeRk2lF1qUc6cLD4wtLumXtYBCOLn1ojTjBHHkI4gypTyjjqIOFTct2EHP89if44fHeo3WUX0l2lKs+JDPQgUko2mQUOBCtgIkfBiU+terQ3bP3l12/KUBbtjdwThaR48NCpaQQ9Yv9siDk7SwOW+twGseS8oyWGBlODP1W7nbwkTCplqqibS0yt1LirnKmNnhsxRkqEPK/H/Z33kLUWV2G7X640v6fYcrANBpONGN6SB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db64db36-4e46-45ae-b2f8-08dbc6fb1d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 06:03:23.3017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Beq+qkMad+PQc/nnvGhiIVmULPtz2AAYU5Px3Hz39Rz+B8khFMxr390Wd1xAZalN7Wy+IeC+XXnwvPVyB9mh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9577
Received-SPF: pass client-ip=68.232.159.87; envelope-from=lizhijian@fujitsu.com;
 helo=esa7.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA0LzEwLzIwMjMgMDI6NTcsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IGNvbW1pdCBj
NjM4ZjY2MTIxY2UzMDA2M2ZiZjY4YzNlYWI0ZDc0MjljZjJiMjA5DQo+IEF1dGhvcjogSnVhbiBR
dWludGVsYTxxdWludGVsYUByZWRoYXQuY29tPg0KPiBEYXRlOiAgIFR1ZSBPY3QgMyAyMDo1Mzoz
OCAyMDIzICswMjAwDQo+IA0KPiAgICAgIG1pZ3JhdGlvbjogTm9uIG11bHRpZmQgbWlncmF0aW9u
IGRvbid0IGNhcmUgYWJvdXQgbXVsdGlmZCBmbHVzaGVzDQo+ICAgICAgDQo+ICAgICAgUkRNQSB3
YXMgaGF2aW5nIHRyb3VibGUgYmVjYXVzZQ0KPiAgICAgIG1pZ3JhdGVfbXVsdGlmZF9mbHVzaF9h
ZnRlcl9lYWNoX3NlY3Rpb24oKSBjYW4gb25seSBiZSB0cnVlIG9yIGZhbHNlLA0KPiAgICAgIGJ1
dCB3ZSBkb24ndCB3YW50IHRvIHNlbmQgYW55IGZsdXNoIHdoZW4gd2UgYXJlIG5vdCBpbiBtdWx0
aWZkDQo+ICAgICAgbWlncmF0aW9uLg0KPiAgICAgIA0KPiAgICAgIENDOiBGYWJpYW5vIFJvc2Fz
IDxmYXJvc2FzQHN1c2UuZGUNCj4gICAgICBSZXBvcnRlZC1ieTogTGkgWmhpamlhbjxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+ICAgICAgU2lnbmVkLW9mZi1ieTogSnVhbiBRdWludGVsYTxxdWlu
dGVsYUByZWRoYXQuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lDQoNClJldmlld2VkLWJ5OiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+

