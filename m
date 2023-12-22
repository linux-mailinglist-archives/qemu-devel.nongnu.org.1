Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 994EB81C329
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 03:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGVUF-0002mx-Sw; Thu, 21 Dec 2023 21:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGVUD-0002mS-Rw
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:42:05 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGVTz-0006dK-RX
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703212911; x=1734748911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X6F2fT0TqHe14Yb/CfpYHcyDbu/7lTurHX9JA0pkHz4=;
 b=SueZJF5wO1pPjWhGLnJLzD+xnpxKhfGp12XVY18UhuJQ2Awc9O04OJX3
 bTQ/NyG7b9XtntGzacy4EeYbHbi17lKHdO8ZeyPx+U3W08sEu3gZXG9/e
 BC6tgbLi6eJxgordtVuumkhuIpeo4pUhtBwyukimQlMJU+nI1nbiFGroF
 GxMD4Wp34slW7a9QQF/Hp2Q5rwPelpRbjfwQWNf7DoX5R2tLncm4d7LkR
 ZrttozOXJ/gDF0QAsTS9ya15GTLrtZJLrO4/As1MdjgBmH7RE/B+JBQq4
 335OP9DEzdpZwTXemmsVYaJrukZ+S2BQgRcUnR8MJ408M869W17CqkHzU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482246930"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="482246930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 18:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="753139218"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="753139218"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Dec 2023 18:41:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 18:41:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 18:41:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 18:41:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Earhtzj+bnTrfFJ2H7JsDPWB/KZV/wbt2+q9DnfPoK7M5BXOE1fh2ncjwrgDwNIMDKtWOS+rn+64mE9Gp9klCRvmS+qbi4EgcZfMhfbUHTAAtu3mTEWOJ0m6Mlz86Q5PN/aXCC2DQrXUVof+qniKJ9wVXIctUiPQdB17Ay9t+l6KBlSTTb1ADqu7ANVgWewq+7PYw1L+JBF+Dr1OO1WwYCgoUDsAcqndVT8EKJ+nqJn1WPOrkwui7exxzsReSOctSkkexBuMaaggUGBg9JyM5tp6EKGDb8vUJfkO3s72pQuDIL8fx5IFlSrE/W15cogYpip5TC4z5UY4K0VaPTyFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6F2fT0TqHe14Yb/CfpYHcyDbu/7lTurHX9JA0pkHz4=;
 b=jZ4Uwt+OhI692t2yGZ+pogY63Cho5AAy1CY0mo32G3Y9DC50Vzo2jXBHbDGbIIL06ZyrkcaLdYwxFvl7jc/HVaiCt35MweW545gmHohL+ED/p0Uncaw/IrdFkDqlF7EPR/Pwi/Cwr0xL+Cy64hnorCfhMc9XMUvLrdI6/64qJUekH5rFPKRvXUIrKk3GfYruEAXspGuOh5J+fqJq9/Q0i9NCqXgfxTAt5Blkp5cgl7CjW/YcsJZAYtogJwBE28uxlRthsJ2gD+KSV9/px2E4d2GRDA45qqI1fSI0yGBAD93bHmq17P++mVVySvfNEfbzcdZRtDtWt58BlH5ZciTFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Fri, 22 Dec
 2023 02:41:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7091.034; Fri, 22 Dec 2023
 02:41:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin
 Chen <nicolinc@nvidia.com>
Subject: RE: [PULL 20/47] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PULL 20/47] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaMq1svHVXtv5zdUmMVUk6DEcRv7Cz6FAAgACyIAA=
Date: Fri, 22 Dec 2023 02:41:40 +0000
Message-ID: <SJ0PR11MB6744EC7CF793F96535C7DEDC9294A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231219185643.725448-1-clg@redhat.com>
 <20231219185643.725448-21-clg@redhat.com>
 <c6daa302-8da3-4931-812d-88dbb156a17a@redhat.com>
In-Reply-To: <c6daa302-8da3-4931-812d-88dbb156a17a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6119:EE_
x-ms-office365-filtering-correlation-id: 5b94e0e3-d863-4d4c-7630-08dc029786fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJV5HPpo8IDZX/QUYD4rRS3nUrpEl14DzErFpxUkIUo0Vsit6APslekmdu3e+2OWBA+iH19VWGDXQQx+wIFVttuNLkLQDjfnTx2pfwaW1LvBS+JyRNZ/lcn9niBGdu6g6ZBWe8wwR4zYyqiCzJsW897IfxGZR/hD7oP6gt9UkxleVE7Y9EgimN1bSb/yAXkhHXLwdilsMa5/ADonWQUz5WEP0YU+oQ8xC7FIsYyraDbHloDJlo8vUgeGpOlM94TCO82a0iU9Pu3JBchVP6r2aV5ZqyUFcdWcTJQUcx5r5clHv46EOrPWcneGE0gBGLN/M+rCKCt4Yl8VKHtebfiZtjXHgYc8OJzW7b9qyln2pPWd89ZGoBtWZdL9KsVLW7kbbEVnfUImoIkEuTOTuY4fgF+gv6e8SNXj1EH734b0Slft/Y+hDMoi0BM7mf4ejPR6Bx7OKJb/5byKpyB7M90CBNP4nmO7quZlClMKNWVKoIjiHfggbT1y0fBs5mkC78YjTyHdudxcjDU08E+z2THyYjL/bxBLo52QOEgYJ3YoDdt5vPnimUHQazFXzE07YnVXlXsnbvav0WJtKHVHCB0GPylotoLoW/ZseM0p61UnmzhiF88B2jE9o7BIq/mZHAha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66446008)(4326008)(52536014)(122000001)(8676002)(8936002)(66946007)(76116006)(66556008)(66476007)(64756008)(316002)(110136005)(54906003)(82960400001)(7416002)(33656002)(2906002)(41300700001)(86362001)(38070700009)(38100700002)(5660300002)(26005)(83380400001)(55016003)(478600001)(9686003)(6506007)(71200400001)(7696005)(66574015);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXc5QjVvejR0dGk1NkhRRUlFSVhxNmMvZVJ2YjBHMjRrakt4SS8xT2RoQ2J0?=
 =?utf-8?B?ZGlwNSszci92eVpWME9NYnBsc3dwVkMzVm1CSmtMM2N0NWsrSW94Mm5pSm82?=
 =?utf-8?B?amp5V1JycStLT2xSUVBzNHhWYlA3RXJrL0dDaGFEMzEydlFwcHo0N3VzNUc4?=
 =?utf-8?B?VW5mVUpIVnl3dUNGSjJpbVA2MUFiWlNWbzFkY2w2NVRwcm5ydk56WWFrYjFD?=
 =?utf-8?B?eENaZkJOYTQ5OFBsTlNKV0lvNW5MV1JmYlk0R0dwRUljSzNjMnR0MmhTd1NG?=
 =?utf-8?B?NGZGL3VTVGcrK05iQ1NzcE5qZkNHd25Udnh2UldPSVZxNEM1T1RmaDV1QWF5?=
 =?utf-8?B?bTRPVHNoY3lOR0Robm9KdTRzWXFxT2lQU29MSGpodDVCYlVNYUtyWTBWVlA5?=
 =?utf-8?B?Q04xd0JpSE1sL0V2Q0kvVTY1Z2JacHhFMjhDNnI1bi9UZEg5RXZhelluYW9Y?=
 =?utf-8?B?aTdzLzVRYnBKcHl6TFNCd1VhbVZjSWxCUjg2VlZkRnAvMmZ0RGppcDZ4YVJj?=
 =?utf-8?B?UzVQOWo0bVVUS1F3OGZGcVp3Sk40YzhHMXpwTHBpRXUzY1dhQVhjQ1RzQUc5?=
 =?utf-8?B?bkN0QjBHRU1ZWGc0cmNTTHVlTmpxL01HZ2x1SUUzaUFTaGFoUUxPTGJBOEwv?=
 =?utf-8?B?c2ZzWUxLOGNDaFdvcHFWRU8rcUtXS1kvVXlSUkp3dTYxUHZ5cHVwSm1UOHNL?=
 =?utf-8?B?QndoQUR6QWdQK0FBekIxa3hjVTVSZUo4QmJtaGVMWDlwOHBBYlhSamV3d2kv?=
 =?utf-8?B?cU0xNDJVYVBYUUM3SThvY2dSWjkxOFkxV3JCbXhTK0ZqWC9Bd0hpNFgrKy9z?=
 =?utf-8?B?RG5JZThBRmd6NWtnOVM2VTkxbG1ydXF4bTY2c3c0ZGFwYkZ1U051cnRDdTJ4?=
 =?utf-8?B?LzNDdGUrNjAzZ3llU0VXTXZEb29MUGNwZkY5U2pYdy82My9vMHlGZ3grdzBG?=
 =?utf-8?B?RWRmQm5YcW93bG9PZy9hWkE5Ui9FRVVySWFieE5XcHMvaTJVZjVCZ1NEVXky?=
 =?utf-8?B?dnZmUm1raWhzdDkxaklUZisxd1V5Z1ZubXU4eDRKRHZWbXZDVUZTT21SSkRR?=
 =?utf-8?B?S2dtd05HL3dINWVHamViellIc2ROUHh5VS9PTWVpWHNvTTE1Rm84YStmTnZY?=
 =?utf-8?B?QlV5QzloWVQ5elpaVGhvTzNzRUU2K0pJNU1SS2V0eWFxWnE5cTZldVdWV0ZN?=
 =?utf-8?B?dXJMNUQ5UEtOdjlBaVhXVWU2dGtBVkQ5eDVwc2hQWERDS0dkT1JydFYvYWpJ?=
 =?utf-8?B?Q0Q0ZkR4cnZ0Q0RVVTRWTURXdEY5Smw4eS9KeGFvbVU1OHh5RnhVOTlpUkZV?=
 =?utf-8?B?USt4UW9KTWkzL3R1WmVhb1dBeTB3enA0Y0xlWnBVdHQyYUhvZ2c2eFZPa0ht?=
 =?utf-8?B?TjVzK25DZHpCSTNValVzQml3L2wvTEw4MUtEcFFTbE96YlJndGdwNnI0OG5H?=
 =?utf-8?B?a1krTWNybUZhdkJsREdJeVJWSW5yd255NFN0UGVkTkorUkp1d3E4WTkvd090?=
 =?utf-8?B?STBOekFxSGsyZEk0WUMyZEovOG5QNys3clpNMXlpZi83cDRvbnlualpBQTBH?=
 =?utf-8?B?anRNTkdHRExUY2h3RGRRQUc0SUhLbk9MdmRKZVdteWVuZlVtV2U2ZnZHYysv?=
 =?utf-8?B?ek9jaHBRbCtHeTJkbVpyZWt5dU1tTEFqNnd4cFJLU3VZaVNRblJVSDNxSmI2?=
 =?utf-8?B?ZFpPUHl6bVZ1WmRFTzU5emVYWkp2Q3M3TzJ3MXZWa1lKS1Urc3VwRmZWTWRx?=
 =?utf-8?B?QUhxMWRxWkFyVjNSQmhFNnFqbWpvcGdkb1VPaUdYM3pXdXFqMU1sV1VZNGI3?=
 =?utf-8?B?c29ORkZUWEwwdVFCOEhXenRCTGFOQ2ZneDJxTmx6WVdNbG5LMTdxZTI4QnhQ?=
 =?utf-8?B?NURhVkNRQk9yc1REZW5XSHk3OUhaeDUyYVlmaGErdEJQazNQdUdhMTJ0dGhK?=
 =?utf-8?B?K1BWQkk4UjRSeVRjaFhSeGZOV3NkWlJ3TUc2UGw0bVRBRmJpVk1WN2lBZnp4?=
 =?utf-8?B?dHRUQjhxUHJCdVlPMnRoZWRtdzJySDhGbkg1MXY1R3ZnYnhVOGpzcW5wMVo0?=
 =?utf-8?B?cnVjUDlMM1RVT21ERGgvV2NuWHR3TzZqaG1yVFRvS1JKRUo0TVAvTGNUbjRl?=
 =?utf-8?Q?VlIoLw2xhHLFJvo46wahqJMN0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b94e0e3-d863-4d4c-7630-08dc029786fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 02:41:40.7663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vD3EgJBQIXFSkypQBM8zxMWw98vmcaY8q1Doq2a7ZKSTZrgHMnmmPokRdex5z9HC9aRpk3xd8x2/x/R+wu0rjjIwGIRKrypekUC/MlAgY6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6119
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMjIs
IDIwMjMgMTI6MDEgQU0NCj5TdWJqZWN0OiBSZTogW1BVTEwgMjAvNDddIGJhY2tlbmRzL2lvbW11
ZmQ6IEludHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj5bIC4uLiBdDQo+DQo+DQo+PiAr
c3RhdGljIHZvaWQgaW9tbXVmZF9iYWNrZW5kX2luaXQoT2JqZWN0ICpvYmopDQo+PiArew0KPj4g
KyAgICBJT01NVUZEQmFja2VuZCAqYmUgPSBJT01NVUZEX0JBQ0tFTkQob2JqKTsNCj4+ICsNCj4+
ICsgICAgYmUtPmZkID0gLTE7DQo+PiArICAgIGJlLT51c2VycyA9IDA7DQo+PiArICAgIGJlLT5v
d25lZCA9IHRydWU7DQo+PiArICAgIHFlbXVfbXV0ZXhfaW5pdCgmYmUtPmxvY2spOz4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgdm9pZCBpb21tdWZkX2JhY2tlbmRfZmluYWxpemUoT2JqZWN0ICpvYmop
DQo+PiArew0KPj4gKyAgICBJT01NVUZEQmFja2VuZCAqYmUgPSBJT01NVUZEX0JBQ0tFTkQob2Jq
KTsNCj4+ICsNCj4+ICsgICAgaWYgKGJlLT5vd25lZCkgew0KPj4gKyAgICAgICAgY2xvc2UoYmUt
PmZkKTsNCj4+ICsgICAgICAgIGJlLT5mZCA9IC0xOw0KPj4gKyAgICB9DQo+PiArfQ0KPj4gKw0K
Pj4gK3N0YXRpYyB2b2lkIGlvbW11ZmRfYmFja2VuZF9zZXRfZmQoT2JqZWN0ICpvYmosIGNvbnN0
IGNoYXIgKnN0ciwgRXJyb3INCj4qKmVycnApDQo+PiArew0KPj4gKyAgICBJT01NVUZEQmFja2Vu
ZCAqYmUgPSBJT01NVUZEX0JBQ0tFTkQob2JqKTsNCj4+ICsgICAgaW50IGZkID0gLTE7DQo+PiAr
DQo+PiArICAgIGZkID0gbW9uaXRvcl9mZF9wYXJhbShtb25pdG9yX2N1cigpLCBzdHIsIGVycnAp
Ow0KPj4gKyAgICBpZiAoZmQgPT0gLTEpIHsNCj4+ICsgICAgICAgIGVycm9yX3ByZXBlbmQoZXJy
cCwgIkNvdWxkIG5vdCBwYXJzZSByZW1vdGUgb2JqZWN0IGZkICVzOiIsIHN0cik7DQo+PiArICAg
ICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsgICAgcWVtdV9tdXRleF9sb2NrKCZiZS0+bG9j
ayk7DQo+PiArICAgIGJlLT5mZCA9IGZkOw0KPj4gKyAgICBiZS0+b3duZWQgPSBmYWxzZTsNCj4+
ICsgICAgcWVtdV9tdXRleF91bmxvY2soJmJlLT5sb2NrKTsNCj4+ICsgICAgdHJhY2VfaW9tbXVf
YmFja2VuZF9zZXRfZmQoYmUtPmZkKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGJvb2wgaW9t
bXVmZF9iYWNrZW5kX2Nhbl9iZV9kZWxldGVkKFVzZXJDcmVhdGFibGUgKnVjKQ0KPj4gK3sNCj4+
ICsgICAgSU9NTVVGREJhY2tlbmQgKmJlID0gSU9NTVVGRF9CQUNLRU5EKHVjKTsNCj4+ICsNCj4+
ICsgICAgcmV0dXJuICFiZS0+dXNlcnM7DQo+DQo+Q292ZXJpdHkgQ0lEIDE1MzE1NDkgcmVwb3J0
cyBhIGNvbmN1cnJlbnQgZGF0YSBhY2Nlc3MgdmlvbGF0aW9uIGJlY2F1c2UNCj5iZS0+dXNlcnMg
aXMgYmVpbmcgYWNjZXNzZWQgd2l0aG91dCBob2xkaW5nIHRoZSBtdXRleC4NCj4NCj5JIHdvbmRl
ciBob3cgdXNlZnVsIGlzIHRoaXMgbXV0ZXggYW55aG93LCBzaW5jZSB0aGUgY29kZSBwYXRocyBz
aG91bGQNCj5iZSBwcm90ZWN0ZWQgYnkgdGhlIEJRTCBsb2NrLiBJZiB5b3UgYWdyZWUsIEkgd2ls
bCBzZW5kIGFuIHVwZGF0ZSB0bw0KPnNpbXBseSBkcm9wIGJlLT5sb2NrIGFuZCBzb2x2ZSB0aGlz
IHJlcG9ydC4NCg0KTWFrZSBzZW5zZSBvbiBteSBzaWRlLCB0aGFua3MgZm9yIGhlbHAgZml4aW5n
Lg0KDQpCUnMuDQpaaGVuemhvbmcNCg==

