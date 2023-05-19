Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2D708CFD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzo8h-0004SD-1l; Thu, 18 May 2023 20:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1pzo8f-0004S0-Jg; Thu, 18 May 2023 20:38:33 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1pzo8d-000634-5q; Thu, 18 May 2023 20:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684456711; x=1715992711;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nx4JWB21/8c73ouhwFkBaZDI21dZlxZvXj/iODp9/jw=;
 b=R11LW636gihxJtxqqdGYYN5oY48wkzNd01mdt4QnzwJegIsWLOvSxU4P
 J8iKRFkri7s0TRL0XeoJxchZGM257FI/9c75aFOAVZR62jMq39qBtEBky
 tZpTlNY1wbR5xf7u4H777Z1WDRvbm7XxkwSPltoOaCHD71OQYf+SZjrAm
 Io84NM0W2zlyhueUvhaIX8jmmf5fKXO9k/XjZS9bwINq9JcDjmORbHNNp
 ti+pmM+yz7DJ9vKaQrxNP5ZiGxut8iGH0YNfHI4mgH57uoHHITunuspmB
 374sps+nCiAH/h7Ma+hkZZqZ07REAoYPh+It7e8saeiXFZH/Xk32y5WCh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352252523"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="352252523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 17:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876640410"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="876640410"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 17:38:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:38:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:38:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 17:38:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 17:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7/+oYqt2NRJdv2QyqhzAhs7LVu/cDtq6al2oHtnxK44vuqAvOW+Gw1Vn+YDRXMHJ7EeuhRXB0lTBsOOz4uSbJPEHwTZgNF/tjP+ufnCcEyiy7c2l9pYPV8EIAadOzc9r8YbjvPDfn6KSHZxvZaJadUQo4KIu+UUEdwXXqpZkrpSJQjq0bonHVBCwkbn9Va5EbMLe+rycWldRYDb2NQdrfSVRSh1coG1pf7Q5Bkw4Ki9SX2qbxHC+bTEPDBoiN5zkz0UlFgTLNaxblVwogEDPvsdNK1VjqUx7NO8d1i3/n/dqV1EQATXamkSGEW7nstJVF/81s1NIiAS3UiIMTJAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx4JWB21/8c73ouhwFkBaZDI21dZlxZvXj/iODp9/jw=;
 b=HRCjt2nBs4i2lkENnsjg3fQW21nMxAuI3wHNlD9fu80GUUArYMR531SAkBfftqdqOXaca29IMwZsvpiuYJr0WZuIpH8dFemmFm7rpR2+bAcdRFPS+6xRw+5GhzYWrS5WwzEjD1UQbj1xouwodNdRPJIclPcVZEmlQJb/jiXPdcz56HkUriQRYNHMcHvkbxji0hIJ7RcP3g0NWZ/V7Z0z+299tFBE4Zc1MPUrctJHUf/WWNcIlUVTfmjcPm8t2H9fNUod73RXgfe7TmZKzf2zEaiimZdZxGj8ByGqd+VTcKt+L0U4eAQF03jK21C0LmIHlSsJJHd4s6+J//XOJ6tzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 00:38:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 00:38:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Jason Wang
 <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: Multiple vIOMMU instance support in QEMU?
Thread-Topic: Multiple vIOMMU instance support in QEMU?
Thread-Index: AQHZdwaT7ucJgnJtPE2Jt/g20WVebq9fgfwAgABgIACAAFZ+AIAAC0cAgABQpACAAAl8AIAAR+EA
Date: Fri, 19 May 2023 00:38:24 +0000
Message-ID: <BN9PR11MB52769C4DF00F48EB64E0AE7D8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com> <ZGYzOEhdTA6sWKjP@x1n>
 <ZGY8rj9hRxGLpFdH@nvidia.com> <ZGaAVAI9u4K4vy1/@x1n>
 <ZGaISJUBFdMu+nxo@nvidia.com>
In-Reply-To: <ZGaISJUBFdMu+nxo@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB5997:EE_
x-ms-office365-filtering-correlation-id: bcd2958d-f705-4491-2b33-08db58015b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qy2y8avo2t470tCXE9SCHfr5bS+p3NKQoJ48Chm6mPD4F9qMqvmnFfPeBJ3u/s3LccQGjNnoZq0eJzxkvvxrcqaJrs6G9KqT2OkpDWhVwys2JtZorJAEuouOcCIPWt8zMG8zankY33h1Tfzy8mJpVutXil8msJmFQZFF5Z+rrv+7pRuUqQEdJ8KjKsrYSaEypjPPxSjSHL5RR52HiXZE0XfMU5rfzRQR1WK361vpCr3KJAQNIq/MFZbOybHsT1oI5r9qh3F7+Zx1LHapUwT54mRBK/Dr7n+APlT7ua+ZefHg6ijQF97MbMC95T//Bzsn8AYc9sCNu8K6q8YqTbwVzLawkcBdiRVACL90VGC3OLOb0Q20GwwxNk+D/CoQsnKJ2k72gwU2D/LmjhITEntbPQqPpD7gUQwLyZfNcI6HksxvW6im3DlA4Yi3h5Sp3i1ItfSa8Z7jReObudZ2gnl4oroAtdsoT60juLEub+NUGQgP03Y5Wogb/OiNYvhSQBE9dfn52m4IAsGlAJf+0myyLN+bOtDtL98pDP8TO1hhoEaSF1pBYpV0EFq/JLRQBeSJOqe+3bXxsSTuwfptiKXgVtZ7caXQ4JnG7wQ6JKB7IwgjE4mKt7Junz3tUeRhydrx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(64756008)(9686003)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(4326008)(316002)(110136005)(7696005)(478600001)(71200400001)(41300700001)(5660300002)(186003)(26005)(6506007)(8676002)(8936002)(52536014)(55016003)(2906002)(4744005)(83380400001)(38100700002)(82960400001)(122000001)(33656002)(38070700005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3j6j24yHNOhpuxcaebhKhKbJml36Pm/8uRiRZoLfeAB3wNkKAiXk1jXcSRqi?=
 =?us-ascii?Q?rxL2g55YfrWAa/ckbCBmd1IkxsHKt5vUUDeeoVTb6tVYapHO87DO20rUwvPs?=
 =?us-ascii?Q?cdutnepClLfqEF3XbpUJuGAgbdkrIFlBBNQSF+jIi24ZiZjQi5t4yg/HqkoJ?=
 =?us-ascii?Q?x22D7ILT+X5qRt78lCcESyuoclSQrEi2zFYNw+xFmVmzZLqmcPfrOZ2BLPs1?=
 =?us-ascii?Q?Ll1cBXisNuWRkgXD9FVH8MN5ER3x20t21h03vMKsvc2Ht5amBbRo4KoWVi1x?=
 =?us-ascii?Q?6GZ8WktFT0XEB08v715in67amd/BNpLcKXgUt8HiYxVrSAm70xn3EEQ6HzAf?=
 =?us-ascii?Q?B6UiVC6EIEpA8pbyUZwtPuoBW6so5kuYjj1oD7tnDPCeL0TgxDQPPCXs2PbV?=
 =?us-ascii?Q?XGebpwTcQ2D/12RRlLjATMrKFB6C6Nuh+jnORhW34cPGcPAWjQod+0BxJ+Cl?=
 =?us-ascii?Q?8AaaETBh/uSjd4p8RVkTJRmSo4OKDXIBbqh5Lj8YcrldHY9XDsFlH6UZ4K5j?=
 =?us-ascii?Q?Y5P27IKV2IMhn277/oKRqGc/Q5TrimUsY+FRjFzOE/qHyHfv6D++fTi8Vdx6?=
 =?us-ascii?Q?ng/u1uLcdwo0iSZC5+H6ogzhPw8Do2Hh1l9E+44hCh1OHPYHpa8Ps4k6sYYq?=
 =?us-ascii?Q?3doX3SYS8ZLMXjGpz7lMbTMbqQlpoNd7TZP0MPvEl3ehPHcg/X05NF0egcoF?=
 =?us-ascii?Q?WQQwaThGuSSJ985wqsathJEte043ga8pixfhz+lYxNrLX1bRfLYwEFrontdR?=
 =?us-ascii?Q?tAKTCZNNqtNd7VbwKzXV8Ud6xOga+U46pRTMR5C5kHVD9PMxbgeZSanKepCI?=
 =?us-ascii?Q?CfNfzHUXiI41auHnZPyv7I6xb+XhBB3XkguwZ7ZfpxWpXu1YOkU0aB/AQTJe?=
 =?us-ascii?Q?gxxvg6mZjVwGI/rJ+lY66TMTDKH8oNXj7GBeVVLCCdxcaRAQ157Fy7avpUP0?=
 =?us-ascii?Q?qdKX2ng1AptflvYuYPqzGu7ZoD8rFLVQNMfWiqgvGbRePri9IFgeXVzOkvSc?=
 =?us-ascii?Q?Tac0Fmu3h2kjjvo8pLfgZJnIGAGk9E4J/n2MPew6oFPOUEzfpQyGDwIrQD1G?=
 =?us-ascii?Q?UfcMrFUlz5Wd7xsl5XDUNvultSGwBIaXB0e+Uw6QGTjcbsqIXi/fWYZNe2If?=
 =?us-ascii?Q?exNXb8wSn8q5/gMOow+tmLGuAFARIrYVSsaf3URTrfGDHPOnuPy9loZpDc4k?=
 =?us-ascii?Q?dLfuQafMCEjOq0zvuCxMvVKgl0RjzA6SRk4ZlYLpmdEku13wxtQQWiMqnn25?=
 =?us-ascii?Q?gHlLp6evORjDwFMtdUgOMZCobJdn912gbx9w/XWB7q50RbpeGQUbkj+uQHnP?=
 =?us-ascii?Q?wQT/OvtRgIN8CuF3OTuFgB9ho4PEauVCyzZqyKtyrZk01l6yLSboHu+tb7mD?=
 =?us-ascii?Q?ASWNkoc6LjVdtU/b/Y398gBeMI30kzKEriuDlZrrNcvEk0N99kyQ3yZ25We+?=
 =?us-ascii?Q?7Y7oe4/lAw3aqNNQEFQylesnjgwuoDQ/OgxEYI4AG3N914zboTFUggLYEi4M?=
 =?us-ascii?Q?NwjAy9BjByFln+9E3cTB3kstaqJ899T+Ckb12Eyey0uzv76vFPhVfT1r5zMk?=
 =?us-ascii?Q?0+a5cFfm3F+NhHoW8izZIX5fUHUVkiLcOd8vEB/I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd2958d-f705-4491-2b33-08db58015b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 00:38:24.8435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hj/xFZocgKG73vcOd3oofMJb6HV6VFPXSM9MJDaJhNYpn2y64bghWjZc+cQkK+B0mr0gcN3lNeWUltIyJnxPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=kevin.tian@intel.com;
 helo=mga14.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 19, 2023 4:19 AM
>=20
> On Thu, May 18, 2023 at 03:45:24PM -0400, Peter Xu wrote:
>=20
> > I see that Intel is already copied here (at least Yi and Kevin) so I as=
sume
> > there're already some kind of synchronizations on multi-vIOMMU vs recen=
t
> > works on Intel side, which is definitely nice and can avoid work confli=
cts.
>=20
> I actually don't know that.. Intel sees multiple DMAR blocks in SW and
> they have kernel level replication of invalidation.. Intel doesn't
> have a HW fast path yet so they can rely on mediation to fix it. Thus
> I expect there is no HW replication of invalidations here. Kevin?
>=20

No HW fast path so single vIOMMU instance is sufficient on Intel now.

