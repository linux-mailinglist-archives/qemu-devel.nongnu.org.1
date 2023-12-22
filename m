Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7981C685
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 09:26:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGaqC-0006Jz-RL; Fri, 22 Dec 2023 03:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGaq9-0006Ji-5N
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:25:05 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGaq5-0007Wd-K0
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 03:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703233502; x=1734769502;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aKPyh24VcxrlktGMVe8BPXgqRoR4AA0Ocj5Ts2xtX8c=;
 b=JLf0UGa59gH9+auTL+HaXG/iGsDzud28rY1+2lo8+HFBsSkbpGLA/OzX
 L44xEtfGsdpNhq5i0HN3URd1rUCIod1okvV1ydCq5nid8Op0Nd9Vq46L1
 gKUmO7EnO7q0Qkfya/0UbILaUfYzAxH9tmlFC/D9l+Wm+f3ynU8irwLrM
 LJYpmTl+LSaX9K3dN91m8y23XnCNNaXuzxYXpNvgI5sBXXHSSwzXvIwJW
 A+gyIz1njHpNL4ojyNMkDfQ9gcR4t/ZNbc8fM7GlOA5DZ/qhRSwIKN5MG
 GYmrdx1ZZPGLPWF7OMROnt1rtMQoUDCX/TKu2OlFEerPVYAtvbPxhPlRP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="395826155"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="395826155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 00:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726716418"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="726716418"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Dec 2023 00:24:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 00:24:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 00:24:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 00:24:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 00:24:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfPgpHQjKdxi1hFDenspT4w4Xow8VpDg8NBQ/TnBQEEO9Rj2dS/VlTky170kPOOoC1whbkchMnc5VccrEDoBUSX5AkIyhU28vFcoxgusAsXg4yZVqYEa4cJet8N66RvVThk80M4WDj6Ef7Ap3htocaq4ztCAf7HhO2brDq4phJgqVbAcmTMXqPO0GIIWFjAde97fxz7zKVHU7BXqgIgX43mBWKIikj9eI4qMyw2dYBwXQqqKfBCi9kIwjPoqgqL9xNQpl9kPPYXezA11owfWGRcnghKji7pjWiNWCIO4lhVEvw7vJ847waCFZJJNe4a/V7sgLyeH2O/Vl+j+meNJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaDOP2Zg9OsiDqITXz2qFxD58lZDaXdEKDD6PyF4dDc=;
 b=gr6stGkUvkYkgAgmLR6/KBzERI72mh9T8OYiaiYBegOzZOgv/BmCLHkBPEbL1ew+DwWCPsbyfe2l803FiyqyY6UIQGBEC0RYwpZD6VwH1LyqxCpeOXT4qi/drw7sf8bxoNbnpYhjxg6a1B9ayDgr8HrIxtw4IvSh58BFDDYzVQjmfudQItHd11VSs1W5wNo+tTkxAl/hnEhhdS5/mq4UIn3JsSXiJodxiiW4plIM3KIz+CaprFhtsPTZPD7xq83eHrId3NQv9WRpHomHQSU4AnXKYbW4oogSPM65ZOQNKM3wnX2Y1qcyEjuA4tGpoenhqNwNVqiY4zTlKsq8hSos4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6737.namprd11.prod.outlook.com (2603:10b6:303:20d::15)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 08:24:53 +0000
Received: from MW4PR11MB6737.namprd11.prod.outlook.com
 ([fe80::2252:14d:8e00:3b34]) by MW4PR11MB6737.namprd11.prod.outlook.com
 ([fe80::2252:14d:8e00:3b34%3]) with mapi id 15.20.7091.034; Fri, 22 Dec 2023
 08:24:53 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Liu, Zhao1" <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "seanjc@google.com"
 <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Yang, Weijiang"
 <weijiang.yang@intel.com>, "Wu, Dan1" <dan1.wu@intel.com>
Subject: RE: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
 enumeration
Thread-Topic: [PATCH v3A 1/6] target/i386: add support for FRED in CPUID
 enumeration
Thread-Index: AQHaNIfeo6ufFTFV70GQwsSZh+DTBrC06WgAgAALoQCAAAAeoA==
Date: Fri, 22 Dec 2023 08:24:52 +0000
Message-ID: <MW4PR11MB6737937A73F2E0D2752F0835A894A@MW4PR11MB6737.namprd11.prod.outlook.com>
References: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
 <20231222030336.38096-1-xin3.li@intel.com> <ZYU76ipTvj1WIBgm@intel.com>
 <ZYVFrBvu39X7E1Yf@intel.com>
In-Reply-To: <ZYVFrBvu39X7E1Yf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6737:EE_|PH0PR11MB7709:EE_
x-ms-office365-filtering-correlation-id: ba639dc2-251c-4530-537e-08dc02c778ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EboihCou1y2dKyMRHvXEHQr1fdU94l3ScdPAWVcA+5AN21TMRfnkWSphTBTU/Im76KAGLfr2eIWb31jFpw6ys5QnDN/Ws6U30QJAfQ74JsDxGiqqFWWQU8hU5fX3DoFkSLffEFCdYuSaaW4ZMpB9/cF6cvyykLvmSsGgFpB+GtLQhUQl1qq1ZKoCZjWsbOjVj63yx85EnygHOHts52ordq5VFhCwcvjywH4ysU+QWZQ3Sh0AJs3xnvieLVU5h9IaSPARfQh1OXMjd1/okvDAiVv7ab3jXsc1vDU8VMwxf2fkFnB5uFPa6u2zu3k+m0GRUQOZmcVUh7OORywAB4mzeVNNslumFjniewRJIO/BIgnwK0EA0XjDJSQmEhDznPHOsvviMy0y0agAs6qIVObw8kZm+6fDJhkPVfzSCgLn86+o+cFXLPBRQR9/znysvps2yyHIy3q4hp9WR33A3SnYL/r2XW5rkaPwhVDb2bzJfDvbfuFYS/G57EY1NwJYD8SIASjaMyyyWr+yRa+v9oFvG+4TgM7DKj8MgRcGtR1wr3HsAkIVf5eWGSrHN7hqulbagtZLuMFVQK5Al21x+gQLDIAJg4278bhr1YSmwwvpf0g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6737.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(82960400001)(38070700009)(122000001)(41300700001)(55016003)(33656002)(86362001)(107886003)(26005)(71200400001)(9686003)(7696005)(6506007)(478600001)(316002)(66556008)(76116006)(66946007)(6636002)(66476007)(66446008)(64756008)(54906003)(52536014)(8676002)(8936002)(6862004)(4326008)(5660300002)(2906002)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1z/1NoUvoyQiuqPWufePYQfhpWioaRoZxfpk0Cb+t4IpmqpjxI4VETl69hcj?=
 =?us-ascii?Q?Dicu89xvoCHeTFB3RP2G6IEDltwn6hjzG+ZpZK0pc+vXQ5KFHcwPxQ5illye?=
 =?us-ascii?Q?Gb6y/qKIjlI/CJ3aaGNcAzr+sPG+rJXb6Qokhk7WK5t92gZgpALHxdI6lBYY?=
 =?us-ascii?Q?QxtH95nx8OzAXlUJnbh8zOmpUXTCZpUHpHi49PPEAqcJmI9S/v7kLnd7Kpo9?=
 =?us-ascii?Q?ArC3nDm9js9uMrvQRYUS2Ky+CSk9kaeaO25BG4FALhh2DDljoP1AdhfVWQQZ?=
 =?us-ascii?Q?XOH45g6eDXoiPgiuY8GByBoU7slJkLV+wcIO/7TRCBLTRcx7SVtwl9wmDFog?=
 =?us-ascii?Q?DyAsbiHy6QsehQhh9ZMRplC/RRzDjrTehRnTstki3f+TT+nmgfws9OPSDXbk?=
 =?us-ascii?Q?k3PvUg3mIx0A878STe81K46qsFvsEpSABuFnmY01Xv1AinCkT3kGyfFcD9VG?=
 =?us-ascii?Q?8u/YI17cedc5Rb3JB0ZK+xX4ztd3LfTld/wAA5RU+xHAO7QmHNt9Ot0oCjZS?=
 =?us-ascii?Q?NYmq75CEqRnqT6g6ZtdOpyrIlqLs1F5XHLom9wfrbPCILKTEq9kVjwmpgQ2N?=
 =?us-ascii?Q?GZoRSdz1rN3nAm8trlBoQy8Eo+UbvoTysqCgZWT0kW9XgyfWClNyL4Nc8C2t?=
 =?us-ascii?Q?rtb0su63aK2yTl7Mjxg7eUEd/1uVEHDONZiBN1qZFpfjtVs85D+EJm39Szu+?=
 =?us-ascii?Q?MAQ8aY1v2wW0RScN/kmU6Lrn/S6U35fkLDeESFVj6mEq0+OZhWstpUPnAFAp?=
 =?us-ascii?Q?jexd2yGPj6VK6kej7Z/Xx3KFhk8zeHT7AQKpDwGdlBKNgUJN31zXqc7qIhZF?=
 =?us-ascii?Q?TqkYnUQ2DU9t4/jFs0xx2HS3bgvzrKA2qjEHSqDyvU0e+yeM6x0JvCdfEk5f?=
 =?us-ascii?Q?42NC+TD3qkBN7/1sCRTgfIOX++CRBmNFAir8K9RmYo4oyscEZY6QaA0A/vwt?=
 =?us-ascii?Q?/P0L8+v7J6rUM1JlI1Mgi3zWIySmtQ6hQ676Q7dfueiERehjpy7OhmccRjZ5?=
 =?us-ascii?Q?wW6hphdo64y9axHr2ukIBgy0pxxVaLNq1uI6xsjsdDs5fGFwe55pz7iP5GuY?=
 =?us-ascii?Q?vJmRIfbIQs2ePbB30XvLVHIGONwUwS53gjpPepb1k347UlDXSQ65An+qnCgG?=
 =?us-ascii?Q?VexHNdRqerIw+p8makh3wIzqaZWEo1MaYM2SKbTprxcmQILCqcaYR26dhBru?=
 =?us-ascii?Q?wyYi4OjawpWszSKt61rhl8UVIIDLS6dJRN9m0Dv5S83kC86UvEZBWKRWJGPG?=
 =?us-ascii?Q?aE/K89rThuyD/4C11r/iRtCXQEF+ICKOcyK7WSP1o4NydgQ8AlgbPpngzFtC?=
 =?us-ascii?Q?EdXrGSWDI+f7YfmNTJpHTlfDXU20WUaX1PcTK3QGF3zg/GbKyPfshHzHXihX?=
 =?us-ascii?Q?htR/LZ/TrPEtIv3BKmyEYrrUnrlts3VAD5oChrZ0kF2uqe38EUfeZZ7wg1ue?=
 =?us-ascii?Q?j5Kb2oFZRoAIIXCaW1XekxU15cuzTL1YHYt8E41NHifZKIBxICzMx/nfo2NG?=
 =?us-ascii?Q?j57UvrS6YlCoHSvzHI5OaJsi2IF3EkEbtQ9o9rFcU8gAczIB84YFyZkffB2P?=
 =?us-ascii?Q?o2JvMAJ3pMkoQ8MB/is=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6737.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba639dc2-251c-4530-537e-08dc02c778ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 08:24:53.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2UqwOhZi7K+brt3NO+gzsHvobQWOboRMb+8PNu9JEb86Aek1rrv1qcNY1fZ0nGluf8iWKadSf6j9eeHujDK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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


> > >              NULL, NULL, NULL, NULL, @@ -1552,6 +1552,14 @@ static
> > > FeatureDep feature_dependencies[] =3D {
> > >          .from =3D { FEAT_VMX_SECONDARY_CTLS,
> VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
> > >          .to =3D { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG =
},
> > >      },
> > > +    {
> > > +        .from =3D { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
> > > +        .to =3D { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > > +    },
> > > +    {
> > > +        .from =3D { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS =
},
> > > +        .to =3D { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
> > > +    },
>=20
> Oh, sorry, one thing that comes to mind, is this dependency required?
> Since the FRED spec (v3.0) is all about WRMSR as the example, without
> mentioning WRMSRNS, could there be other implementations that depend on
> WRMSR instead of WRMSRNS?

This is a community ask from tglx:
https://lkml.kernel.org/kvm/87y1h81ht4.ffs@tglx/

Boris had the same question:
https://lore.kernel.org/lkml/20231114050201.GAZVL%2FSd%2FyLIdON9la@fat_crat=
e.local/

But it needs to go through a formal approach, which takes time, to reach
the FRED public spec.

Thanks!
    Xin

