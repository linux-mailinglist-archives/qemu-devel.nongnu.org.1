Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CA708BEF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 00:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzmYC-0000RD-UR; Thu, 18 May 2023 18:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1pzmYA-0000R0-Ua; Thu, 18 May 2023 18:56:46 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1pzmY8-00059I-60; Thu, 18 May 2023 18:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684450604; x=1715986604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P9uKhvAiVEPFjX1P4emL5sVyZp0aM1MxOy87QiUydRs=;
 b=UWwNxDr4j4FCUfBIJEmRUAA32evlSL1RipkQbL2kX8hsehq7LxFWEfOg
 tAHisWZafBrZ4AtxN8DSMa34MuUVOa9Pw9oU6zrg6WBAhuxwVGfluwd13
 jvpKL+KUMCxum9HkDdKnooGY2ZiuKFoues8FMxbM77hSHvDescO/L+xLr
 OVwaEhXzgZ2J8FQPIhoUezFiNhZqNQ0RbUY/6UipzHU8NKwy3ft0AmGYU
 M9RRF4suyTksD7O5d5kD8TuKcm8WtPeh6dCs9DGYXpULW2eiBiMV/yMc9
 8Bk7l2YTLqetPvb/Pw6S6Csw57CFao9r3kBsNi71kKfSDdc76tp1ZyrJM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438566084"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="438566084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 15:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826562352"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="826562352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 18 May 2023 15:56:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 15:56:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 15:56:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 15:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5Ucg65rd2wqP0DHM0YTSSd+Eq6P60kDug5tufuxd8K7oIQiyq1PhpZIIqH/7UtufkP5GnV8+7KyIa/uQmBXUp9lag7QALaCRzWBy7U3fIvcwzBYq+PjCuvqpbEt9D4Lib7Fiyowv1h/XGP1VTkM0gZ49RJwjhIBHqK3kzvqtDyURe0BwHV+vTPo1lvEBtaXgW+oi0LZQBngVaO1vR+0hCM/gdyb3z8gmpgeUF+lnnWn1SKrFJ/vI/xxt3vS9BsJ4TQLOgkgZ4rLGurbv2HHEcN4OKPtcyfU5YZGJ/cHAqdmzw3wAo9drcWJJk7LbVl0ZxZr4H43SxfnLSYIokT6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9uKhvAiVEPFjX1P4emL5sVyZp0aM1MxOy87QiUydRs=;
 b=GpQXBdCDmL8LhR6tu3oou5RGw1jWj5NBMqLvshdnqoDgVAbVcyfYSHDxEMZXX8ZYjirJlNEfSElcxdpVNG33JK3Y9wtI/YIvuxNZwl35HNa3ZKWBXmxuq69BKx5WpJD61KUYVnN4SMmmHxCTC7ia6pvhX+48gakgPSME+bkA049Qxm84ZFjlYKaznf41+GlC861sqaoT2EFpIemHGXAWNwzlZ0YvyOSLg81yZexCGV8+ZZq1hIsR7jB41FFijJEEcIEBzlO3drj8ZhCEDnY8i3RDMOESo0RWZVFSGx+yKdTQDbqiUBfOEdQig2l2+M3iKGfhzNM45coQHrOGxitvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 22:56:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 22:56:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: Multiple vIOMMU instance support in QEMU?
Thread-Topic: Multiple vIOMMU instance support in QEMU?
Thread-Index: AQHZdwaT7ucJgnJtPE2Jt/g20WVebq9fgfwAgABgIACAAFZ+AIAAC0cAgACFDHA=
Date: Thu, 18 May 2023 22:56:24 +0000
Message-ID: <BN9PR11MB5276DF23B7ADC7550822340E8C7F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com> <ZGYzOEhdTA6sWKjP@x1n>
 <ZGY8rj9hRxGLpFdH@nvidia.com>
In-Reply-To: <ZGY8rj9hRxGLpFdH@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5058:EE_
x-ms-office365-filtering-correlation-id: 6aa2383d-a435-4939-d9e0-08db57f31b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z8X1arS20oek92TVTPR8bea2GZ7eb/WMg70cBQDXcdjPIVFTyGSkux7/5SJpFOSqdR5D0XVXN9ihrSDiR5jrz0PC7iSMNfdmuZsEd8A/bKJOTbwTsbzYzSp/HyAw9XYJchKRB3qe+npth+JP1OYVLZn3Ni1IRBXoWcvqplF1DHtwde1hUSuHlFohit3q5xDtZeJ/KPo4Gmamue5BOdsbxJ6CMNM3hLEbAm6vjVEHj0eucTju/vbmbB2OzK7uodKoCFOqccrFopkqcZdL5bWJScbI6dVNS3EEihAsIvtrHFjr5RPQLd2ejOeGdWImm147Ekt4nnfHHI+AkrNSPl6CNU1hSo2P+iRM4LPzuC9+5cJSaXDs06D1VMH5d3xQzvUtnnzhaK+IrI0QjCYQlaCXgTHRJeKY2qWSx5+p7O0rbTfAuYEsw6TDZJL1PXOTJsQ1z2wm6T68MxS1RN2GIwo2lZNm+hQHbHxUvBe+/zBahmBLITTIn0IzWN4AufI6il5ZtmhWgXgiF+fSotJ5gXjGQZcAFT4zz9n6NKfLWMJAssntMwkARFrN7SFcW3aMj/K5+BszYlKGv5ci7MLD28caCrSeQ939+taLHZTmz6iF0ksj5sxbZaDvGy5bEzn9aoVL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(86362001)(7696005)(83380400001)(33656002)(82960400001)(122000001)(41300700001)(38100700002)(5660300002)(8676002)(52536014)(38070700005)(316002)(66476007)(64756008)(66556008)(66946007)(2906002)(4326008)(55016003)(76116006)(186003)(6506007)(9686003)(26005)(8936002)(107886003)(71200400001)(110136005)(66446008)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zLohUKR/kLxHK7ObovkAu8v5EIvSx79GD39kACGdcTR7aTbBAim/SBHNfrah?=
 =?us-ascii?Q?DtntpxMqCOHy2AuhS3y6VkXFToCt4MJm17s+ci7z1vSwQPU6DPzWiFhefIAC?=
 =?us-ascii?Q?DbWab1plLU3D9siM13YemXQfWhdrq/4cg9uRk2KDXEdp1fV44Banv03SmCrE?=
 =?us-ascii?Q?c6InzsZUUJH3MKJa1C5KPB5zQQkn/U++v0iL6pxwEJcr9YrIKa1/+QQJtXEu?=
 =?us-ascii?Q?t39DTVgd6goonAEnuFKba6kgzmffUyNcIzdaGSJx0w02ma2F3+wEHFv43LxW?=
 =?us-ascii?Q?u6FdWgFybaptylWy4CYq1mxl2o9SDPpoHZdeXAPs55BdTd9HIrKyxSSNrytx?=
 =?us-ascii?Q?NftjLuHtkjm9XhdAStfItRiIxMqRLlUFjP9o3691GB2jeHPSfW7ja2cAfvfF?=
 =?us-ascii?Q?40TObNpI99o7ffRavVFwi4ayqHgRagj0LSJSMzliRgu+6PvrayonjKn0ZjZ+?=
 =?us-ascii?Q?rx7mP0uD9XcyYH3siDcrM5PYFQOhc7AUcTszt9yw/I4uQcIe42EOimBNSA4W?=
 =?us-ascii?Q?nvPa+AAyzO/F2j3dwKm57OpRCStBYmG+I958hfXsVRxUx8EnBoVCWvoi2rYM?=
 =?us-ascii?Q?o37PZe+0lRSPUrzz+PPoPb+Dzk0LYsqQmsCIQIk4zhx3CygXq5AxEo1FK6Zj?=
 =?us-ascii?Q?q/0eaUlwAy0aZTIn2M4kca6WlefBNoxCsQoXit9W6Eo75Xg9/VHU4vu2Yfs4?=
 =?us-ascii?Q?jE3ELFsAcDzjVQjBanYGSYIjOCBKWNaq9+c2HlmY9jlu5tcfoyuVStMQAJDM?=
 =?us-ascii?Q?4Iekew49PtnwfibCEz3kkiXFHbmbwb9iw3M9Jxh6c36ChGEP7rjyAuIlekx8?=
 =?us-ascii?Q?4tqEBkwcD8O9c6/g0KsWWZKTpBYtCLpjIWKJpF6wMzZoQEXCM/45UWI+zFRs?=
 =?us-ascii?Q?C1Y+IoOwPwNepcqzAHI7rvssIk2hbO2JdHcpq1ANG9/CoeAaO6vq1/zSkFPA?=
 =?us-ascii?Q?nqZsO2DtubPAo/4zsyN1qITduJ58IMV8Eca21K2TY+4esICxDz+h4DlM4i9q?=
 =?us-ascii?Q?qmEwL1ptbMqFZ+fdH+aCn2GNo9agtdvvupCWBlOA891SM16umJ4dvdO6yLHj?=
 =?us-ascii?Q?m1X04HXCv6rnSbcBkIo5RdCywoBuev915sQ18cj8YGHvjcZoFm7o59KK2nbL?=
 =?us-ascii?Q?Irt/kDkSyTzLoAphS2p+t/5pHBC9EyigVYaXynfXcVFtb+Olx+oh4ZLA3Rsw?=
 =?us-ascii?Q?q0uAtsWR5NlQuAoRsa9C6VRb67DO9zICStRQq9c60p8R+d87OQI5Nn1Pu9bp?=
 =?us-ascii?Q?MCdJJSx2BfkwzngZAQdXmGeVsthihaa6f3mgTdAG0MLI11ASlFyyvBJtG/7I?=
 =?us-ascii?Q?7zq2jWnaTSkBjUnXxWfq4NFBhv5pStSemLIQr+XdSR5VQgtPiWPCB0M2ckiy?=
 =?us-ascii?Q?3de4k/Mvyap/AjrJmZXfNnejKBCikvapz4aypAGB3KmyQ7Vkcuj0wjR5fIuD?=
 =?us-ascii?Q?N1DYCczMkaqYVm3vAtSynRf0P1L5+xMC3usUoN7uyAuEvM6jZsQ90yZTfHMu?=
 =?us-ascii?Q?84LTzqH29x0WWfztsE1JoUdw0T1dAPpYQ3Sni1AhgjZnIYS16GiYMT1RMSjK?=
 =?us-ascii?Q?FRLQJi1JdNthzCcHAZGYnLaG93za8V+yPq4oYMLF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa2383d-a435-4939-d9e0-08db57f31b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 22:56:24.4435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yE3Jb2RHTem37hg2p3E3ckehKdkIIyD1roIFZwf95FCsyvR3ZE3onCPb4MXqN8YQuTxasyGMV4JGlNuis8Fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=kevin.tian@intel.com;
 helo=mga05.intel.com
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
> Sent: Thursday, May 18, 2023 10:57 PM
>=20
> On Thu, May 18, 2023 at 10:16:24AM -0400, Peter Xu wrote:
>=20
> > What you mentioned above makes sense to me from the POV that 1
> vIOMMU may
> > not suffice, but that's at least totally new area to me because I never
> > used >1 IOMMUs even bare metal (excluding the case where I'm aware
> that
> > e.g. a GPU could have its own IOMMU-like dma translator).
>=20
> Even x86 systems are multi-iommu, one iommu per physical CPU socket.
>=20
> I'm not sure how they model this though - Kevin do you know? Do we get
> multiple iommu instances in Linux or is all the broadcasting of
> invalidates and sharing of tables hidden?
>=20

Yes Linux supports multiple iommu instances on x86 systems.

Each iommu has its own configuration structures/caches and attached
devices. No broadcasting.

An ACPI table is used to describe the topology between IOMMUs and
devices.

If an iommu domain is attached to two devices behind two IOMMUs,
separate iotlb invalidation commands are required when the domain
mapping is changed.

