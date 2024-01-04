Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95964823A65
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 02:56:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLCxN-0006hm-DP; Wed, 03 Jan 2024 20:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rLCxL-0006he-Jg
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:55:35 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rLCxJ-0001jW-C1
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704333333; x=1735869333;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l/+NjgLMP8sEVSexsnvyqCrgz21kmPKgvvWdAgKw9BU=;
 b=MoZp0sby9kT+iceBy94z1Q2ycP5LD2dkQ7waiv0aMVexZNgFVFFSNJqN
 iysFrtH3AXRppBuMedgA9urmbBLqeNNUJpzRMuRpROoFZ6lCYjkxZYNWO
 wBXy/XvDSzrQ2J2pleTaiajsZNsuJH7Tq5/jAFFzZvBcPMcn/OizxC37n
 UGkeCxQkCYrcg6DzT23giJS9zB+rKmY5oisIHbA4YvsW9gRf3UIBWv8jT
 grEDYaohAexS8TnJb5gKtKnBu2QlhiJrtJs8HXyHLQVwk6LYfZpEq70vQ
 g62cjjot0ClkowCWFklfQZWtjur2Npu+6BA0MF29m8g3qPTRo9yeyIYqY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10683767"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="10683767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 17:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="850595243"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="850595243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jan 2024 17:55:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:55:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:55:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 17:55:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 17:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9QK0WzcaY16SEikqBINPNqLk9iyXE78YWA/QsVDzn1ITeRTDQ8ZhxC30Rv9i1AN2q/WH2HGwF1Yj1HIaYTrCSnq5hz09lCUDpK6rTPtV7Jm3lrAjbV2EdUi4vheGKXKGAcYec6oqejWIEk7xhHE/0qe++0nhhJihtO+TLHqUOIleoalY0R65VJ/rR03RyabrSKqEKzzvATXZRWNGI0aWab9ojHI23XQ1fYHAa9bFAUcutSZdJawjfsC7oBpLCwvAss6UlRUIrS/qq8+bRnBVwKI1m/iTz/iHedKSNsAFCuSGsuYfYLXIGu4NiNgQJPYFndNDGdpC//T8sk2cQps1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/+NjgLMP8sEVSexsnvyqCrgz21kmPKgvvWdAgKw9BU=;
 b=HUB4NcSYoY2QiFoc9IqXOWOKlnuAr3xht6bG+RAMpdZzLZDXF1+mN3TnIL3PmKCYP1au1RGXfwzd+xngxt5ygRsL3sSJSFMoukoFNzO+bgXiIuTWFciicpLl42ylWMbExbm1+coCOE+oA1997zeBBUcolgbYxXxicmuzJ9E4WM4F2vMdVmaSeNorzhU9nx3aIQ0tVTj/Wda9Eo+jJ1g7BZh9K44A77mC94hdI8epG7Un+ooLBcZOEze5YeO2qPRw9xgGdiuT4gFv4GNDV2jKlrx0D3vCvyzv+bUQ8QOSP9Fo44CthgpqgzqL7t1NZyYluiH790PNYvb6/Slrc3dSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Thu, 4 Jan
 2024 01:55:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%4]) with mapi id 15.20.7135.026; Thu, 4 Jan 2024
 01:55:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH 0/2] backends/iommufd: Remove mutex
Thread-Topic: [PATCH 0/2] backends/iommufd: Remove mutex
Thread-Index: AQHaPXe/kwphXHq90k6VkzZdUc50nbDI5tsg
Date: Thu, 4 Jan 2024 01:55:28 +0000
Message-ID: <SJ0PR11MB6744473872E8E3E26934C1409267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240102123210.1184293-1-clg@redhat.com>
In-Reply-To: <20240102123210.1184293-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: 89d37b54-e004-48dc-8aa1-08dc0cc83a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLuRtRDcLin64HDxF1xSropMOVF2LuB3AtilOfyYMcg279Qoqw/oQIIWhCUgV/EJtBs9zxCQI/Rbb6QSuxMTeR2zHkkFoMZQMzGKPrchH9and3RBAyisZMnZJXqD1HQLCIhOk94MVcAhx8HTwb6NkENnK1EQEjRG4lCL1lO50XUsv+dMKdkP4AFpjaQp90P6YszT9fYFguLq2+mUNQUxRGYsF2VtT5Kd0rQiR4pSJLXRBZF0M631BK0zN+NfLlSQuHMic4r3oLj5FhmFuSM/dkA5y7N4JwEjUpsyjVnlu6pToJUWczrjNEyWV/F8CgDgYHPM+ABFfbADrb5HCBZsPMvaTIft9xEHR1XfHN9hGym3Jdnh9IFuwBdnYOsz8qllvVbMnS6zqZ+xb1Ai27IJn5bHyuMVjDC9Yq1zaQBshQPOjmqfhyRwIjpO3knb8wD/4dAlZp3Box9qboPlliwGo0Cd6zGMJAZ4RbQvuQhqUyRoaWGcg+W7HqHW3whsRjVNcIxn2uCkspbRMx6O5gN+OmhBd8s2WZMEHDmcFKwxK6qXgDC5R49X1DnkGkJ45ZxKsUCl42T3cJN0k3qhCtHJkWU4yeEVbCn2ldzON2l1CtZNwEum96eJ6PNxm/glzdiK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66446008)(71200400001)(66556008)(64756008)(66476007)(9686003)(6506007)(7696005)(110136005)(66946007)(76116006)(316002)(478600001)(54906003)(8676002)(8936002)(38070700009)(5660300002)(4326008)(52536014)(86362001)(83380400001)(122000001)(55016003)(66574015)(38100700002)(26005)(4744005)(2906002)(82960400001)(33656002)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVhNlFXeEJ2U3hVZThSM0x2b014REhqOVpRWWorUzJEeHNKK1cwTjQxdUxT?=
 =?utf-8?B?UzZwbUVsaGpXUXM5REZtb2MxeHRXeGNmTDFVZy9PdnU2SlVyem5JWHlGQmgx?=
 =?utf-8?B?NWhNQ2xKamRaYzJTK3A4d3ZML3YySjkwZDZPeVdOR1NPOERDUWN6eFFlalFK?=
 =?utf-8?B?ZlRadHBOb0RVZ3J3ZS9KSTh5a2VPb0Zrdklyb2ZFdlBiZkNoWUhvWXJnSmlX?=
 =?utf-8?B?bElSK0hTa3VsRklCSUJJOEgyWWRFNFJncC9OTmkycUlxS29PRkZQdHV6SytE?=
 =?utf-8?B?eklJVS9DMmh6SVZOZTJLSGc1SjRiazlGM2gramgvT3ZUeDJoSHZiWFY5eWI5?=
 =?utf-8?B?UkIySFFtWHdIN2NpSUE5WDRhU2JPQW9ISzlmYlhndWVXb1JZOTF0NzFwWEt6?=
 =?utf-8?B?UFpSanAySE1OZDBVWnhjb0VsNHhYZS8xR214RXVlUDBhdG1vVWl2Y3ZiMktP?=
 =?utf-8?B?a1IrbTNYdmkvTUhVTk5tOHpFSDRMNDI5NFdBcEQ5OG52OHZtVjJrdWdnRkFX?=
 =?utf-8?B?OGxqM1FKTnZ4aURGK2JDY2JTRWVObWJZRWE1TldkU29IK0haRjNka2N4WjRI?=
 =?utf-8?B?akRXVmRVd1J2eUJaZTZtRDFDNjdzY1hJSU1odmlmcGh0SnBpVkdiVkYwREEv?=
 =?utf-8?B?UEYvSk5UbmFleWUxOU50cEVSQjRBSUNzTWx5bm9zcEdzT2d6K1h4dmc0YTZt?=
 =?utf-8?B?T3JMdFp2OUlQeHovUkhNRE1OWC9TZndoMHh3NDl3ZUUxTkdzVUpZcnEvalJW?=
 =?utf-8?B?dlZiQnRkcyt6a01NMUlETUYycTdJNlFIb2FXejFNQndLSlNSRHVTZGU5QWl5?=
 =?utf-8?B?dHdLM2ZyM3htV2hFemlLbC9pNU9WSnY5eWl2UHJVSk1keXVrc1Q1akxhYmhh?=
 =?utf-8?B?SU4veWZna1cvaVF1TFVmdGtMQWpVMVMvbXVVTjBUZ0lqVGxSdGovb0U5Z2pE?=
 =?utf-8?B?MGxsY1FycXpRTFVlakZXTnpiOW1uM2V6K0lIZC9TUzJLSWJYOThlZmRPN2Fi?=
 =?utf-8?B?ZWNoQ1luZG41Nk4vVW1XaEJpNEJzdVFabldHNFpkcE1LZytDaklzUHhyL2xW?=
 =?utf-8?B?TndKZWZIUGY2S1N1QTU2ZkQyQkhpMGlIcU1NV0FjejZkcE1FSnlVVEVhYlN3?=
 =?utf-8?B?RmUzWjdxRnpWcEVsUTlSZkhQK3d2Q2JjNVEzUzYrSGxOdkYvQ1hKbDUyZzAz?=
 =?utf-8?B?ZVJZbm8ybHgybmREellib1Uxd3NnL2ZaYW0zYndTaXNXR2xSNklIUzg5NmR3?=
 =?utf-8?B?NTVQbTlzWTB1ZXBLa0lvY3FLZHlqbHp4LzdLTUhxZ2lPbU1YdWtPMHdDUnRW?=
 =?utf-8?B?ZEtVd29HbXc5SS9WRHFhcUxzRndPR0E3V2ZVd2kzTkNiQkhYa0lNMVh2VW5W?=
 =?utf-8?B?YXZ2dVpRaVlseWFBL1dhbVV1VG9uaXg0M1d0Wko5ZERob3dVKzFJanI4dnBm?=
 =?utf-8?B?STBkbzl6bHMwazNiRnRhYnFkN2lDenJwWDVzRkZVNndXUldENExVdm90TVVW?=
 =?utf-8?B?cUhkWWo4d2k1ZnBIYzZPLzlEMEM0amtWUzBRaVA2ajdFMHBsak9HeEZOZ1g4?=
 =?utf-8?B?YndCbE5la212aTNaVlhnVEtVRmJ6eFRaeXdjbXluOGo1dExLbVdiNWdzMmFM?=
 =?utf-8?B?WnF1YXFHUnJJUGI2TFNIb3N4dnJYcE8rOGRzYzE0VkVrTHRCRWZIOUdBYzRv?=
 =?utf-8?B?UVdlQzFnR1BlWTJlcm9obnhXWFNCVnd5MEhrYWJLdDZjeDUzUmVQVWhCQnlw?=
 =?utf-8?B?MzR5dXV2bUppa05BUGpDeFFFb3FmTkdHUFJQdUlZVUQxTmFySDJJTHFUMndi?=
 =?utf-8?B?MXo4WDNSQXg1U0tISTYvV21yT0ZwQ1ZTckF2VU00cDdLU1VGZ0I0ZjhxcUtM?=
 =?utf-8?B?NVBxMEVzREFzT3FVTitYWDJ0eDdpT1ZUVlR0Zzc0VVhWK09ONHZJSU1SZFBG?=
 =?utf-8?B?UjFPVnlsUERkM0pGbVF4VEl2NVhKK3VFeHpSM3ZoaW55RCtteHpJdHZ5ZGdZ?=
 =?utf-8?B?NE1WeHdmNUZ2QVZmbFdGZFg4M05TandKQWRpczRUYTBJUGpjR3JXYUhGQWpp?=
 =?utf-8?B?QjNhVG9sekhnQkxNck9jdVhmTkN5TnN6ZFZ4SWhPUnBzZFcrVlVCd1hETWUx?=
 =?utf-8?Q?MdzlzGP3YDahIVYVwabWhc6rN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d37b54-e004-48dc-8aa1-08dc0cc83a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 01:55:28.8967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8qI5b2Ptrsd3W7ed+y/36hss8CFOdJ1aFQGctQfCSxxPSBkwy/EfKMmPszlE8ybHkEMqAnUkzXhv9StjvBvjpZr5vw6Pkjyg0KMAVc/9cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIsIDIwMjQgODozMiBQ
TQ0KPlRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj5DYzogTGl1LCBZaSBMIDx5aS5sLmxpdUBp
bnRlbC5jb20+OyBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+OyBEdWFuLA0KPlpo
ZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgQ8OpZHJpYyBMZSBHb2F0ZXINCj48
Y2xnQHJlZGhhdC5jb20+DQo+U3ViamVjdDogW1BBVENIIDAvMl0gYmFja2VuZHMvaW9tbXVmZDog
UmVtb3ZlIG11dGV4DQo+DQo+SGVsbG8gIQ0KPg0KPkNvdmVyaXR5IGhhcyBzb21lIHJlcG9ydHMg
cmVnYXJkaW5nIHRoZSBJT01NVUZEQmFja2VuZCBtdXRleC4gU2luY2UNCj50aGUgSU9NTVVGREJh
Y2tlbmQgcm91dGluZXMgYXJlIGNhbGxlZCBmcm9tIHRoZSBRRU1VIG1haW4gdGhyZWFkLCB0aGlz
DQo+c2VyaWVzIHNpbXBseSBzdWdnZXN0cyByZW1vdmluZyB0aGUgbXV0ZXggYW5kIHJlbHkgb24g
dGhlIEJRTCB0bw0KPmhhbmRsZSBjb25jdXJyZW50IGFjY2Vzcy4NCg0KRm9yIHRoZSB3aG9sZSBz
ZXJpZXMsDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPkPD
qWRyaWMgTGUgR29hdGVyICgyKToNCj4gIGJhY2tlbmRzL2lvbW11ZmQ6IFJlbW92ZSBjaGVjayBv
biBudW1iZXIgb2YgYmFja2VuZCB1c2Vycw0KPiAgYmFja2VuZHMvaW9tbXVmZDogUmVtb3ZlIG11
dGV4DQo+DQo+IGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8ICAyIC0tDQo+IGJhY2tlbmRzL2lv
bW11ZmQuYyAgICAgICB8IDEyIC0tLS0tLS0tLS0tLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDE0IGRl
bGV0aW9ucygtKQ0KPg0KPi0tDQo+Mi40My4wDQoNCg==

