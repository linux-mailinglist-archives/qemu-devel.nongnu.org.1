Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B9802E90
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 10:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA5FE-0002zv-Os; Mon, 04 Dec 2023 04:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA5FC-0002zm-92
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:28:02 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA5FA-0005r2-7F
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701682080; x=1733218080;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RkfO/1OqSPuiO8CAyxMOFXyxMGw/XFXx2to5dB9NXys=;
 b=MIqKX/Ib5Doskw49yHiawz1sQfKVDdnI1dsCN2zLypzVcx1pqKSrF0Cl
 6aaRQtUsxS8/SKzcfFvI4NQDSce1Vg//LC1+Uwl/U+3eQNMgFkFgkH0S0
 hTYvxYw+yc9YZLUthTnZ+Wr3FaEvaJu4hUpXxxRfiPbaM3e37tkuUskBV
 SHdVhce9SrJG1wKb6wnMfT5Khhayt2Kcy9+6bCQjeILl4LNupyCU/u7yl
 DkV8vpYM4Nge5R2l92Thn8JEiYJmoT0g5qc4zVuKbGccIz/arLQ+fKijj
 USiBVanOBtqt4NwE/Fd+DUTC6DosfQISEJNjDoTbeTD5/+C6fV/igvHNc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="558354"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="558354"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 01:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="836527348"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="836527348"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Dec 2023 01:27:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 01:27:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 01:27:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 01:27:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr4wNaw52wob9tM58Yk3drcwvipnQVd5Z3llkBO3X1yP0ooFhoDABZb91qHv3JfaYSqswZiFYxLEbEPRJfeevGWgVf946e7L6e+2dw3syq1r6QXP3cZt3+6bouNP/YY9h1n8jXbFAXIMFLspRaOJPRLL1BslUOfSWLYKVG9BmaSaXNtzvRlyqkxWjxFDL744/AsLGF5fpiqgIXZZpYnSrg/5wiQrYc8WcMYgAry44sqZZM5eP365PhPBHZiJtQxrmAGa6rX2jc80NWynNGM17ysPKwRkD16aOhNtqK+nwrdhzIgl8DzgBNRftF/rvdWJpZXL0NDm5p52PsEqvpUGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=com5yD2d15rCMh55xinH0ip6H7X0FMNSQbvAVbjukkI=;
 b=gTNoXprF6tIuhQx+G7koW5kXpuI9tRKHFVEg3I6/Z3srHuI+j18Dn4TTQso5FPWZiQm83tBzHQ96VbrESgWF/609wXJiQ5xY2WoXykqRJH/q3iEj0wjD0T47rREcyUeATEHmms447ioHtJ1zyKsSfQpQ/7erRUlV6/siQCsYVZ9klI40JqTNpngWn7YnzHLu+/xEUFFh8AzTupir0GfZWrTG/Ec2dr1Xd/aPpyASOH+oSdLlUFtUjXbg3xTfMZSunBPdedw6UGlJ+RUSxy4kBzrx6KQ+5Nc/uT4LDU9V95a56cTO/ICdjxqs8LMJrBPoVOkOgUeQM0Kh9MuQfamM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:27:55 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:27:54 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "leobras@redhat.com" <leobras@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v2 1/4] migration: Introduce multifd-compression-accel
 parameter
Thread-Topic: [PATCH v2 1/4] migration: Introduce multifd-compression-accel
 parameter
Thread-Index: AQHaE6gs7VhgsmOXYUaBbCE/V4euo7CURyWigAS4/9A=
Date: Mon, 4 Dec 2023 09:27:54 +0000
Message-ID: <BY5PR11MB4388065E98C0F50724CFED2AA386A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-2-yuan1.liu@intel.com> <87jzpyz3hm.fsf@pond.sub.org>
In-Reply-To: <87jzpyz3hm.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|SJ0PR11MB4816:EE_
x-ms-office365-filtering-correlation-id: 0c7ad422-dfaa-4477-9c13-08dbf4ab4bae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zHbBP5PpjGMzrosyDZ9M6Z8uZXuKfj3HES6n+Ms9REkZsXsQDoVSufhCGx4z44hZg0+lDGtdQCUKprCIbtKhwzCi0XwmMF+z0pQIJDnfuHkEMFgTQdM+wXYYQdGo5d38zaJJj3Vea//3fCIqahh5j3hPDvqXA5NmZcn/Cg4GLP0XHXQ0zcPPhQPpOEToC81t9nKFN8XXX8amkPD4+7cOOxyTn7mX/sAnitDL6br2U2JjAyXU+e9J7I8T2DC1gsejAo3/Mc19hGRMyXRpA8NyALmGUPrhlt62JJSyR/dput+AQ4ps2DNRqi1WjR0bpF+NLyWkkXMhzaugM0yJ0z68exELTMyUFRUtpWzzFKHGnwRx58EPvL4zgjlnSO1j6nnXnL0Hg5H+FHt4aBTd9sikYBTMnUmqehoGE4Dz9eGfCFwrFtThOm74jJriPz6nIWI9/eQ8hXtg5gFC50L6L2Pd3MhCNkM4EqKr/Uyfnb6WD5pN6Z8DjvVDDY8TQKP3qaa0darq9J3lpXbyccbbuxPUIhbabpUQORdsrAkRHC1NNohQeTtdrUajFfyPNSRNUFH1A4YxvFB3zMonrOqpuFFisnXt573YY36Q04qPk16F2EtpCTs/itg6NTJJ0ypMb+5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(83380400001)(82960400001)(38100700002)(122000001)(41300700001)(26005)(66556008)(66476007)(6916009)(66946007)(76116006)(64756008)(5660300002)(66446008)(8936002)(8676002)(52536014)(4326008)(316002)(54906003)(107886003)(9686003)(53546011)(6506007)(71200400001)(30864003)(478600001)(2906002)(7696005)(86362001)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7MbjfBcFpmeGqPq93rc8s3bgdRZLb6rK7XIhokWZ3qPMvqyZQODsCMsoL6uL?=
 =?us-ascii?Q?/aogGm2Ew/stW0UihqgXMcPlcaFxhhloI9Ko4MJbhD7rjwx1u2uq7jPWTusk?=
 =?us-ascii?Q?KpxucWOlOnZKfqttk1EHoUsDAYnwUWENsrbMM6N0c4CjGsxMKwNNE0+2N7c4?=
 =?us-ascii?Q?KIE7uGiUVNycnfftxFfg4k9eJTS+iTEqL0XWSbdSVUxjkIK7KYEPxEGf2sGo?=
 =?us-ascii?Q?0jLHFukMrx7gIo/niGIkUgY5YgArTLZ2yrzo7ohfaPLrPCaKCQVs92wIayh+?=
 =?us-ascii?Q?tquQ99RyR4hFXi+JPZdT/B2V9913YfwKf3s3sBTQ1/h7ZBe7or4jMUfNgfVO?=
 =?us-ascii?Q?cF15SlB4cCqwVZRQJbRVKjtFeVw2c2KE9FX+xt8lelzN80kRmychIFVTnfy4?=
 =?us-ascii?Q?9At1W6B9tZTnrD6y06NRiEot5V6QXu9wOV7TwNx4OL/N5EX9kO7lLEj5kU0Q?=
 =?us-ascii?Q?P/9XmWsb63lZ5Sq0DhNPGAtgOZpDUMhqFm1hXE72mmVM3xpXeC10LsvVNZxM?=
 =?us-ascii?Q?tLiwTzNXMTZOc+XNC5WTHnW76YEwNsrSobFbuRGgqb4S8g6pf9CyAHbHo/yf?=
 =?us-ascii?Q?XDLeoeyIHzr0L/pugV/k9+VmOvoCyI19+13lYnp2XZdxHQlLec8uQcBCam0X?=
 =?us-ascii?Q?WjG+h9+cLVpj3so+Q+pDYP/sZtNrobcadZ32zcaAJawLpjVANKqj6nVKJkCp?=
 =?us-ascii?Q?HP77FE9Z18X3LruDWNYcZr9vM8y+9cAky0WBEBBKanyQbgAYGtngwW7KDwik?=
 =?us-ascii?Q?VkW0JPh4QKRXdNweBRJ4o7PIx1Lk+tU3OKO2NHK3vYZ3jTghnfd/2vQDBQn4?=
 =?us-ascii?Q?xlIEKH7oe8V4cWKQjmT7299ARMh26LuQ0LSn4B673AwQqQQnfUuAdZrfa66f?=
 =?us-ascii?Q?RYr1MY2wWXxI6EY9YF0ttHUZqMVOqbm4T7yKSaCjYtKetlTzSIEaIVToRoMg?=
 =?us-ascii?Q?mnBKfES7eEEKAXtowRYq0Fq/r6xqaGj40cPM3DVxqSkf+0CwYq3ONqdNjS26?=
 =?us-ascii?Q?fbDu0lt4trSraiJtcsaKMe5XGFQjiOKP1TU1UziwEP9Qvo/7JyHip4ud4vW1?=
 =?us-ascii?Q?yHSFwFsM934zXA5OwZfNEiLM4CANQOwW/eQyStwdeddiA8+7w6/EZG+hx/mT?=
 =?us-ascii?Q?FzztGgaz78wrFPwOGEAUZTBnsLZRPYY5NkIzGakdGxmDoyPKVEMNgNzAohGk?=
 =?us-ascii?Q?Cs2u7OuIpxqXo+D5Im19ZkLiCfwFStqzKP6wjgrY/7YgfKdpyVRZ7yU3fIfj?=
 =?us-ascii?Q?7uaY+zcK5yfpMp7shDmiAlPfBX3LcSv4oCkyUaVezOPNugI1HuPSUOhumMz2?=
 =?us-ascii?Q?9i0N/X9OGMcIo2ydXvO8XwTmc3If1HhoTflFdW2wKdxBXLR0fnikP6FszTMr?=
 =?us-ascii?Q?Q5UFqmzvwtwqJDzWIMvA1X9TEvOxCtfT6zVPU7YkXrbqeQrmhVkVwsJ3ZMFY?=
 =?us-ascii?Q?YAl14RXWt1bNEkJvhbAAdgqM8gAq2oXCGH4RqaDXJsHoKkCEQCHlQ58BjY/p?=
 =?us-ascii?Q?LN45AgYCJSXXiBQ9HMX2c9Ysl7aeWKi6LK9luA0fcXh6yFacbW3/pfNrHWhN?=
 =?us-ascii?Q?NpkmowemSRYvOy9kAjeCipL/MkPVwc09stKWQGcf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ad422-dfaa-4477-9c13-08dbf4ab4bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:27:54.9225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfhmyKb3xbw4a9ws6AI2za1J5aYdPC4jP2HOOi+HHPqdIhgNGaCb/UJh4SrBVSuS+ERweSpWjt0NQaLurDPfIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Friday, December 1, 2023 5:17 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>
> Cc: quintela@redhat.com; peterx@redhat.com; farosas@suse.de;
> leobras@redhat.com; qemu-devel@nongnu.org; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v2 1/4] migration: Introduce multifd-compression-acce=
l
> parameter
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > Introduce the multifd-compression-accel option to enable or disable
> > live migration data (de)compression accelerator.
> >
> > The default value of multifd-compression-accel is auto, and the
> > enabling and selection of the accelerator are automatically detected.
> > By setting multifd-compression-accel=3Dnone, the acceleration function =
can
> be disabled.
> > Similarly, users can explicitly specify a specific accelerator name,
> > such as multifd-compression-accel=3Dqpl.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  hw/core/qdev-properties-system.c    | 11 +++++++++++
> >  include/hw/qdev-properties-system.h |  4 ++++
> >  migration/migration-hmp-cmds.c      | 10 ++++++++++
> >  migration/options.c                 | 24 ++++++++++++++++++++++++
> >  migration/options.h                 |  1 +
> >  qapi/migration.json                 | 26 +++++++++++++++++++++++++-
> >  6 files changed, 75 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/qdev-properties-system.c
> > b/hw/core/qdev-properties-system.c
> > index 688340610e..ed23035845 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -673,6 +673,17 @@ const PropertyInfo qdev_prop_multifd_compression =
=3D
> {
> >      .set_default_value =3D qdev_propinfo_set_default_value_enum,
> >  };
> >
> > +/* --- MultiFD Compression Accelerator --- */
> > +
> > +const PropertyInfo qdev_prop_multifd_compression_accel =3D {
> > +    .name =3D "MultiFDCompressionAccel",
> > +    .description =3D "MultiFD Compression Accelerator, "
> > +                   "auto/none/qpl",
> > +    .enum_table =3D &MultiFDCompressionAccel_lookup,
> > +    .get =3D qdev_propinfo_get_enum,
> > +    .set =3D qdev_propinfo_set_enum,
> > +    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> > +};
> >  /* --- Reserved Region --- */
> >
> >  /*
> > diff --git a/include/hw/qdev-properties-system.h
> > b/include/hw/qdev-properties-system.h
> > index 0ac327ae60..da086bd836 100644
> > --- a/include/hw/qdev-properties-system.h
> > +++ b/include/hw/qdev-properties-system.h
> > @@ -7,6 +7,7 @@ extern const PropertyInfo qdev_prop_chr;  extern const
> > PropertyInfo qdev_prop_macaddr;  extern const PropertyInfo
> > qdev_prop_reserved_region;  extern const PropertyInfo
> > qdev_prop_multifd_compression;
> > +extern const PropertyInfo qdev_prop_multifd_compression_accel;
> >  extern const PropertyInfo qdev_prop_losttickpolicy;  extern const
> > PropertyInfo qdev_prop_blockdev_on_error;  extern const PropertyInfo
> > qdev_prop_bios_chs_trans; @@ -41,6 +42,9 @@ extern const PropertyInfo
> > qdev_prop_pcie_link_width;  #define
> > DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, =
\
> >                         MultiFDCompression)
> > +#define DEFINE_PROP_MULTIFD_COMPRESSION_ACCEL(_n, _s, _f, _d) \
> > +    DEFINE_PROP_SIGNED(_n, _s, _f, _d,
> qdev_prop_multifd_compression_accel, \
> > +                       MultiFDCompressionAccel)
> >  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
> >                          LostTickPolicy) diff --git
> > a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index a82597f18e..3a278c89d9 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon,
> const QDict *qdict)
> >          monitor_printf(mon, "%s: %s\n",
> >
> MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
> >              MultiFDCompression_str(params->multifd_compression));
> > +        assert(params->has_multifd_compression_accel);
> > +        monitor_printf(mon, "%s: %s\n",
> > +            MigrationParameter_str(
> > +                MIGRATION_PARAMETER_MULTIFD_COMPRESSION_ACCEL),
> > +
> > + MultiFDCompressionAccel_str(params->multifd_compression_accel));
> >          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
> >
> MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
> >              params->xbzrle_cache_size); @@ -610,6 +615,11 @@ void
> > hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> >          visit_type_MultiFDCompression(v, param, &p-
> >multifd_compression,
> >                                        &err);
> >          break;
> > +    case MIGRATION_PARAMETER_MULTIFD_COMPRESSION_ACCEL:
> > +        p->has_multifd_compression_accel =3D true;
> > +        visit_type_MultiFDCompressionAccel(v, param,
> > +                                           &p-
> >multifd_compression_accel, &err);
> > +        break;
> >      case MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL:
> >          p->has_multifd_zlib_level =3D true;
> >          visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
> > diff --git a/migration/options.c b/migration/options.c index
> > 42fb818956..4c567c49e6 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -59,6 +59,8 @@
> >  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)  #define
> > DEFAULT_MIGRATE_MULTIFD_CHANNELS 2  #define
> > DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
> > +/* By default use the accelerator for multifd compression */ #define
> > +DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL
> > +MULTIFD_COMPRESSION_ACCEL_AUTO
>=20
> The comment is inaccurate.  You could add "when available".  I'd simply
> drop the comment.
>=20
> >  /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
> > #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> >  /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
> > @@ -139,6 +141,9 @@ Property migration_properties[] =3D {
> >      DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression",
> MigrationState,
> >                        parameters.multifd_compression,
> >                        DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
> > +    DEFINE_PROP_MULTIFD_COMPRESSION_ACCEL("multifd-compression-accel",
> > +                      MigrationState,
> > + parameters.multifd_compression_accel,
>=20
> Break the line after MigrationState for local consistency, please.
>=20
> > +                      DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL),
> >      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
> >                        parameters.multifd_zlib_level,
> >                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> > @@ -818,6 +823,15 @@ MultiFDCompression
> migrate_multifd_compression(void)
> >      return s->parameters.multifd_compression;
> >  }
> >
> > +MultiFDCompressionAccel migrate_multifd_compression_accel(void)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    assert(s->parameters.multifd_compression_accel <
> > +           MULTIFD_COMPRESSION_ACCEL__MAX);
> > +    return s->parameters.multifd_compression_accel;
> > +}
> > +
> >  int migrate_multifd_zlib_level(void)
> >  {
> >      MigrationState *s =3D migrate_get_current(); @@ -945,6 +959,8 @@
> > MigrationParameters *qmp_query_migrate_parameters(Error **errp)
> >      params->multifd_channels =3D s->parameters.multifd_channels;
> >      params->has_multifd_compression =3D true;
> >      params->multifd_compression =3D s->parameters.multifd_compression;
> > +    params->has_multifd_compression_accel =3D true;
> > +    params->multifd_compression_accel =3D
> > + s->parameters.multifd_compression_accel;
> >      params->has_multifd_zlib_level =3D true;
> >      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
> >      params->has_multifd_zstd_level =3D true; @@ -999,6 +1015,7 @@ void
> > migrate_params_init(MigrationParameters *params)
> >      params->has_block_incremental =3D true;
> >      params->has_multifd_channels =3D true;
> >      params->has_multifd_compression =3D true;
> > +    params->has_multifd_compression_accel =3D true;
> >      params->has_multifd_zlib_level =3D true;
> >      params->has_multifd_zstd_level =3D true;
> >      params->has_xbzrle_cache_size =3D true; @@ -1273,6 +1290,9 @@
> > static void migrate_params_test_apply(MigrateSetParameters *params,
> >      if (params->has_multifd_compression) {
> >          dest->multifd_compression =3D params->multifd_compression;
> >      }
> > +    if (params->has_multifd_compression_accel) {
> > +        dest->multifd_compression_accel =3D params-
> >multifd_compression_accel;
> > +    }
> >      if (params->has_xbzrle_cache_size) {
> >          dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
> >      }
> > @@ -1394,6 +1414,10 @@ static void
> migrate_params_apply(MigrateSetParameters *params, Error **errp)
> >      if (params->has_multifd_compression) {
> >          s->parameters.multifd_compression =3D params-
> >multifd_compression;
> >      }
> > +    if (params->has_multifd_compression_accel) {
> > +        s->parameters.multifd_compression_accel =3D
> > +            params->multifd_compression_accel;
> > +    }
> >      if (params->has_xbzrle_cache_size) {
> >          s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
> >          xbzrle_cache_resize(params->xbzrle_cache_size, errp); diff
> > --git a/migration/options.h b/migration/options.h index
> > 237f2d6b4a..e59bf4b5c1 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -85,6 +85,7 @@ uint64_t migrate_avail_switchover_bandwidth(void);
> >  uint64_t migrate_max_postcopy_bandwidth(void);
> >  int migrate_multifd_channels(void);
> >  MultiFDCompression migrate_multifd_compression(void);
> > +MultiFDCompressionAccel migrate_multifd_compression_accel(void);
> >  int migrate_multifd_zlib_level(void);  int
> > migrate_multifd_zstd_level(void);  uint8_t
> > migrate_throttle_trigger_threshold(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json index
> > db3df12d6c..47239328e4 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -616,6 +616,22 @@
> >              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >
> >  ##
> > +# @MultiFDCompressionAccel:
> > +#
> > +# An enumeration of multifd compression accelerator.
> > +#
> > +# @auto: automatically determined if accelerator is available.
>=20
> Well, it's always automatically determined.  Suggest:
>=20
>    # @auto: if accelerators are available, enable one of them.
>=20
> > +#
> > +# @none: disable compression accelerator.
> > +#
> > +# @qpl: enable qpl compression accelerator.
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'enum': 'MultiFDCompressionAccel',
> > +  'data': [ 'auto', 'none',
> > +            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] } ##
> >  # @BitmapMigrationBitmapAliasTransform:
> >  #
> >  # @persistent: If present, the bitmap will be made persistent or @@
> > -798,6 +814,9 @@  # @multifd-compression: Which compression method to
> > use.  Defaults to
> >  #     none.  (Since 5.0)
> >  #
> > +# @multifd-compression-accel: Which compression accelerator to use.
> Defaults to
> > +#     auto.  (Since 8.2)
>=20
> Long line.  Better:
>=20
>    # @multifd-compression-accel: Which compression accelerator to use.
>    #     Defaults to auto.  (Since 8.2)
>=20
> > +#
> >  # @multifd-zlib-level: Set the compression level to be used in live
> >  #     migration, the compression level is an integer between 0 and 9,
> >  #     where 0 means no compression, 1 means the best compression
> > @@ -853,7 +872,7 @@
> >             'block-incremental',
> >             'multifd-channels',
> >             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> > -           'max-cpu-throttle', 'multifd-compression',
> > +           'max-cpu-throttle', 'multifd-compression',
> > + 'multifd-compression-accel',
>=20
> Long line.  Either
>=20
>               'max-cpu-throttle', 'multifd-compression',
>               'multifd-compression-accel',
>=20
> or, if you want to keep compression together
>=20
>               'max-cpu-throttle',
>               'multifd-compression', 'multifd-compression-accel',
>=20
> or
>=20
>               'max-cpu-throttle',
>               'multifd-compression',
>               'multifd-compression-accel',
>=20
> You choose.
>=20
> >             'multifd-zlib-level', 'multifd-zstd-level',
> >             'block-bitmap-mapping',
> >             { 'name': 'x-vcpu-dirty-limit-period', 'features':
> > ['unstable'] }, @@ -974,6 +993,9 @@  # @multifd-compression: Which
> > compression method to use.  Defaults to
> >  #     none.  (Since 5.0)
> >  #
> > +# @multifd-compression-accel: Which compression acclerator to use.
> Defaults to
> > +#     auto.  (Since 8.2)
> > +#
> >  # @multifd-zlib-level: Set the compression level to be used in live
> >  #     migration, the compression level is an integer between 0 and 9,
> >  #     where 0 means no compression, 1 means the best compression
> > @@ -1046,6 +1068,7 @@
> >              '*max-postcopy-bandwidth': 'size',
> >              '*max-cpu-throttle': 'uint8',
> >              '*multifd-compression': 'MultiFDCompression',
> > +            '*multifd-compression-accel': 'MultiFDCompressionAccel',
> >              '*multifd-zlib-level': 'uint8',
> >              '*multifd-zstd-level': 'uint8',
> >              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> > @@ -1257,6 +1280,7 @@
>=20
> Missing documentation update.  Copy it from MigrateSetParameters, please.
Sure, I will update a document and all the above suggestions in the next ve=
rsion


