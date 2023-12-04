Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6D802BC8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 07:58:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA2tq-0007Rb-Iy; Mon, 04 Dec 2023 01:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA2tn-0007RO-J1
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 01:57:47 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA2th-0008Lg-Fn
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 01:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701673062; x=1733209062;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QWTXZQm2RtwCGKNR04McLC9TWdWyKoIF0SC0uUmAzFQ=;
 b=kyVevDXbPeWdm1PyQSMYfkueF7bFRYJYBOrItsvpjGEgW6DQAXFmtG4n
 c+CUKnLadW9YXwEbW4Wkod27UFNLJemt7jM2m5A/Fc17IDsOelPHV23hi
 ML4X/eJMcy0/NQwWmkibl6MPc7Rb5cU0yR8vUja81oWr1izKGe+VC/iqu
 ZYQnhteLsIdETqBao2bQiWr0hbfEltq59Aiwwqb6m7J6GVS9DoZ8o3qJO
 RCkFhCbp7Nx/Gk75YgeS+/Hr3F0OlfP6HyzRzZBVRNMoJlXn3OoeTItVb
 Xo148bQ86GpehxoksREI+xOstQIOvxmeXIRume0ZzbDP2MaeKeaBZkvaD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="6978645"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="6978645"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 22:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="943785361"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="943785361"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Dec 2023 22:57:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Dec 2023 22:57:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 22:57:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 22:57:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV3uKGO4bisJEj9pD5aOuRFOsfh17/iQhNVZt6LIWSi7+JpveGzUr4vfg+99dJx90dZzQQSQ9JA7dew5oq1XpcmnS0SSXKmeJPkw6F1SVIicDWBUlTgVF2sRCI2VbtekYPF38Aam78eV4hx1zqZ35Ih6vm9LEaoKnAKx+4bb1NFkIFXZw2xUWL2g/+B+M0g9fLrvZwd+OK2cOi4+pJ0gw5CLZJt0TkHzVANyHGy73GeJJAtTuRRjqowNqiKn3EHJ9sfBNNcpSvFq7O/NAE3X1rUwVgaeLhEbyCthRFdlANPedTuVetvyoXKBr/weKSVW0nweX1dtkuVauvvzm8MwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O68eANXpmzKw4Za3lUuDqYhurbcObK8GoRmdWVAhMU=;
 b=ff32Rb7upLr0LYombXb7ewIco2ALlRrjcNAl/uxGqa+yXGslGh4jlqfIjMPH88XSn5YwmwM+Pn47eI3Qi+3JUmgqWmxCXlYuLjgYsr2pNBqU6IYuwXcf55GZkOIkXOmz/zpOBoftwfvz4TVG4K5ueCOblJcwzQMOdQr2QQFRVmTKs7BvyTlriNIzz4liijjvqXoTvRx2yJkVkXoOsHgcaZh//beCrpU6V+KBA78eUeY4b/8INkQ3STxeqoocpCEmmQ1Sr3XI/NVYD+iiKZ5tVF0CvYOQfUi766FOR78PBr2hBVTlf2B+QWm20ezmY+vQxtDIhMF4eu/cLHSueJMJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:57:34 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 06:57:34 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v2 3/4] configure: add qpl option
Thread-Topic: [PATCH v2 3/4] configure: add qpl option
Thread-Index: AQHaE6gvflDx6U4wI0WY7ki/Mf3gtLCU1MQAgAP8rqA=
Date: Mon, 4 Dec 2023 06:57:32 +0000
Message-ID: <BY5PR11MB4388B24F2EF2D319325F4673A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-4-yuan1.liu@intel.com> <87cyvpbywv.fsf@suse.de>
In-Reply-To: <87cyvpbywv.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|SA3PR11MB7485:EE_
x-ms-office365-filtering-correlation-id: 0e051940-52a7-4701-d644-08dbf4964a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0e6s1cN2I/I0Hns7xasdu0ABkObhmGSltN9198/pVB4+BsllZhtF/F3g3WQCaMkUx8SInCqP8JTuND2syO46cp+yu0Yq1oLVf3rXsXejKo0S/sALZi5/beM/njnxv4Iqot9stXRr0CaK+Hedp92ovsOB0844OzYY+mFcC5lhi3ZdOans07N0EXh6pZP2y5ZmxgSBa3YEHDOpfr25oDRFf11gFz/XF07UknmmWoIDsoD1bgBktKeT7ypIPSC2oyy7TOG5ZMMv6jxnwkfq4bpwbaxE5Jr8peBLBkEeMH5eoI4dpkAoFqKEjUCVeQHz5U1tU+DiGbw5EOoLuOZW8D7EQt2cCZsCLGpNqoxRLNvscmLHRClZ+10BqzTkEquJ5+Ac2bZ1V+3ltK+a9aBxa90r3lUfvhP6he0KAXXUSAMxeI3w8stTetxdvgLGkB7zooO1UdqqSPq+6t+Nfe3i4MdP9UGz9HfovRTzlbghhaYl8/gdg5FoEovoyOjkMw1X0TbWZEMShMcokgVC+Xw21SrG/GlRRq7EwjtLW1IIQUixUSMIfZTb9AODVVGkZKsunzFkeMUbfpaqlR+Sdutqwh7ztSL+dxt3/okGMg7kNyhkMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33656002)(38070700009)(55016003)(2906002)(478600001)(86362001)(7696005)(71200400001)(107886003)(4326008)(54906003)(316002)(8676002)(8936002)(66446008)(52536014)(6506007)(53546011)(9686003)(110136005)(83380400001)(26005)(5660300002)(64756008)(66476007)(66556008)(66946007)(76116006)(38100700002)(82960400001)(122000001)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VKJoDM1K6gO+iPVdO3LEiioN7jogdjZVbYhh6xjKvFMUSIzSUYwkxn+6UGMM?=
 =?us-ascii?Q?IfWoLByf+Ckac4+MFeOU6Za1bYCtMKJkliwhf+0/YzoYkO5rJTXrwsRvCIEh?=
 =?us-ascii?Q?B0ujq2AA/jaoNRxK2DDuVntrhXyRzdRHI/qIF47opnFWzimu1l9R/swXfErd?=
 =?us-ascii?Q?NhDvQ4OMC7zTwqgXcQ4k8Ez3uIWrrJwvZcGLXp4XnXNF7zFq2t2eeOzCpYLQ?=
 =?us-ascii?Q?feBlSL63W6mxqxG6WpabK3Dw3Ue353iCI3o/FQyBsDmPe5vyrgsoahO0RYlB?=
 =?us-ascii?Q?szNYH+h7ExE7w2vbAhJEiDYVQDMWfHIPwM4OOnoTuefELF2kloBdRRlfhFZm?=
 =?us-ascii?Q?mTLblwlXq2BQVHjnGevRsLSQX/RKocF3Zi1R2PVeVjhsA1hdRVuJm1RV0RRy?=
 =?us-ascii?Q?WcQRvU6miJt6OIhOrsSLA/+mHu9FuJrWd05406QxyGgdJL4A88h7pjxqEK/6?=
 =?us-ascii?Q?uYZziUL2cut6eJDyw85gm+6uX3vrymJEHY6vzPgeg4cwBuMkzw8LN1twd4it?=
 =?us-ascii?Q?rxcd/ffbJ0zGuAMAg6AzOBXG68jZ/a4y9/Wd0/vMMn2m10Boo8Iv6jWu5HQN?=
 =?us-ascii?Q?TlEG6I0n2rVo622fECIxHluha2acgSy7ik6azKNRoHKydYIYw+MJAGl4y098?=
 =?us-ascii?Q?+bShvEJukStOI8aP+4NqWkvI+xLncaNx7xzuEhsJRtG9R9fl2Gc5ddrs/ssi?=
 =?us-ascii?Q?kPfxFFnQaQPjY6UEbwt16A13FahAZNr66uNANRfNbhsDMM/X9aBMIBTB5uwU?=
 =?us-ascii?Q?RXFCaq1Mj6OgC26jjlpWS8e+SEtBu8BgRVE1KyaEWctJ7nben7frLNgC9zd8?=
 =?us-ascii?Q?c7HromleQf5j4n5N/jy52MFC3D/WhSizs4LenCZL99Md0QBX8HtuPKtYrqDN?=
 =?us-ascii?Q?1HVByioGGANxtRympiO6lk+IlRrnFIWOHDiQXTrAPZVPPMx7X86maVG2WkES?=
 =?us-ascii?Q?17q84YSGi5iFpJtwHhFnL3Yh39NSFZAPiNx6ctSSC/tmHbOrbfNLdC2n2F/L?=
 =?us-ascii?Q?1ytEqk6KuR8KmWSbHKMr8zdyOcPyQhjlpbjHP9V3krbhtgSRap+u6tAAI7G6?=
 =?us-ascii?Q?l4LaluUbRWfC0e8FNVlxmXwx4Guf/ZOo1W+h8zrWiC7My43e+9A1GXcYOKsS?=
 =?us-ascii?Q?FwW0NPRJcj2D6b/GCJ4horo0kF5gNG0NBWQgkuuabBDd0n2dRyD9kl0Cfwht?=
 =?us-ascii?Q?QP5PnBswJHXBxlIvzjY1W/u4ddc2OGpVIn+19zXhTUJtHaYo0UbW8q4ebIi7?=
 =?us-ascii?Q?Tglzcni/0bT36I3gAOc5h1X/V3sadhHqJ2r5lMdITTLWF/BzAqZwk5kJO/dS?=
 =?us-ascii?Q?Rb/9//lLzpYjsLWjpTdlc4iaRkZEzCglDl4lczFZGkBs8xgZj2Kzz968301I?=
 =?us-ascii?Q?XRrCLN1/RIOBMVHS0fsAZ7rW0Bx2484kvAUeB6OVSQVBjKN1QnT+zIxciUki?=
 =?us-ascii?Q?jhuclkqTvzVark00/AWXKnd0Cet7QHl6iFO28/ch2ZHAuLVepDOAkD2CBVFA?=
 =?us-ascii?Q?yDyxWXfQw4IEJLIV6uUbTOpr861Bk89VKMFXB6PSz/LDLtCiAZ4o596/3Tp+?=
 =?us-ascii?Q?Xe6ncERSQHTU0wTcSTHYaxIsg4YYg/JfAUfVVbWd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e051940-52a7-4701-d644-08dbf4964a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 06:57:32.9102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd8jtIQ4TyhNMNbMJ5dWIEnAk+b3GVgVwE8r7kAIXmLEQwozZmZvLBBgZwn8+QJXEOKIwOQnBPpuNZz4nBsiCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yuan1.liu@intel.com;
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
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Saturday, December 2, 2023 1:45 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; quintela@redhat.com;
> peterx@redhat.com; leobras@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v2 3/4] configure: add qpl option
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > the Query Processing Library (QPL) is an open-source library that
> > supports data compression and decompression features.
> >
> > add --enable-qpl and --disable-qpl options to enable and disable the
> > QPL compression accelerator. The QPL compression accelerator can
> > accelerate the Zlib compression algorithm during the live migration.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  meson.build                   | 7 +++++++
> >  meson_options.txt             | 2 ++
> >  scripts/meson-buildoptions.sh | 3 +++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/meson.build b/meson.build index 259dc5f308..b4ba30b4fa
> > 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1032,6 +1032,11 @@ if not get_option('zstd').auto() or have_block
> >                      required: get_option('zstd'),
> >                      method: 'pkg-config')  endif
> > +qpl =3D not_found
> > +if not get_option('qpl').auto()
> > +    qpl =3D dependency('libqpl', required: get_option('qpl'),
> > +                     method: 'pkg-config') endif
>=20
> Hm.. I'm not having success with pkg-config:
>=20
> ../meson.build:1043:10: ERROR: Dependency "libqpl" not found, tried
> pkgconfig
>=20
> It seems it doesn't find the static library. I had to use this instead:
>=20
> qpl =3D declare_dependency(dependencies: cc.find_library('qpl',
>                          required: get_option('qpl')))
>=20
> What am I missing here?
Sorry about this, the QPL repo(https://github.com/intel/qpl) does not yet s=
upport libqpl pkg-config file, we are in the process of adding this functio=
nality and we hope to resolve libqpl's dependencies through pkg-config file=
.
I will explicitly address this issue and provide relevant documentation in =
the next version.

For the pkg-config test,=20
1. create /usr/lib64/pkgconfig/libqpl.pc
2. add below lines
prefix=3D/usr/local
exec_prefix=3D${prefix}
libdir=3D${exec_prefix}/lib
includedir=3D${prefix}/include

Name: libqpl
Description: Intel Query Processing Library
Version: 1.3.0
Libs: -L${libdir} -lqpl -lpthread -laccel-config -ldl -lstdc++
Cflags: -I${includedir}

3. Install the header files to /usr/local/include/qpl and static library to=
 /usr/local/lib64/libqpl.a

> >  virgl =3D not_found
> >
> >  have_vhost_user_gpu =3D have_tools and targetos =3D=3D 'linux' and
> > pixman.found() @@ -2165,6 +2170,7 @@
> > config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
> > config_host_data.set('CONFIG_STATX', has_statx)
> > config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
> > config_host_data.set('CONFIG_ZSTD', zstd.found())
> > +config_host_data.set('CONFIG_QPL', qpl.found())
> >  config_host_data.set('CONFIG_FUSE', fuse.found())
> > config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
> > config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> > @@ -4325,6 +4331,7 @@ summary_info +=3D {'snappy support':    snappy}
> >  summary_info +=3D {'bzip2 support':     libbzip2}
> >  summary_info +=3D {'lzfse support':     liblzfse}
> >  summary_info +=3D {'zstd support':      zstd}
> > +summary_info +=3D {'Query Processing Library support': qpl}
> >  summary_info +=3D {'NUMA host support': numa}
> >  summary_info +=3D {'capstone':          capstone}
> >  summary_info +=3D {'libpmem support':   libpmem}
> > diff --git a/meson_options.txt b/meson_options.txt index
> > 3c7398f3c6..71cd533985 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -255,6 +255,8 @@ option('xkbcommon', type : 'feature', value :
> 'auto',
> >         description: 'xkbcommon support')  option('zstd', type :
> > 'feature', value : 'auto',
> >         description: 'zstd compression support')
> > +option('qpl', type : 'feature', value : 'auto',
> > +       description: 'Query Processing Library support')
> >  option('fuse', type: 'feature', value: 'auto',
> >         description: 'FUSE block device export')  option('fuse_lseek',
> > type : 'feature', value : 'auto', diff --git
> > a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh index
> > 7ca4b77eae..0909d1d517 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -220,6 +220,7 @@ meson_options_help() {
> >    printf "%s\n" '                  Xen PCI passthrough support'
> >    printf "%s\n" '  xkbcommon       xkbcommon support'
> >    printf "%s\n" '  zstd            zstd compression support'
> > +  printf "%s\n" '  qpl             Query Processing Library support'
> >  }
> >  _meson_option_parse() {
> >    case $1 in
> > @@ -556,6 +557,8 @@ _meson_option_parse() {
> >      --disable-xkbcommon) printf "%s" -Dxkbcommon=3Ddisabled ;;
> >      --enable-zstd) printf "%s" -Dzstd=3Denabled ;;
> >      --disable-zstd) printf "%s" -Dzstd=3Ddisabled ;;
> > +    --enable-qpl) printf "%s" -Dqpl=3Denabled ;;
> > +    --disable-qpl) printf "%s" -Dqpl=3Ddisabled ;;
> >      *) return 1 ;;
> >    esac
> >  }
> > --
> > 2.39.3

