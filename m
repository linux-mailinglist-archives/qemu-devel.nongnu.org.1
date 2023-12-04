Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40980333A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 13:42:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA8G7-00085c-SM; Mon, 04 Dec 2023 07:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA8Fx-00083z-I1
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:41:04 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA8Fr-0007RO-Va
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 07:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701693656; x=1733229656;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3s262h/7G6V7slWCQZDXMzZK7Y8qcF7rP10pGsF37ZY=;
 b=ac0acrVKtyNk3g6S/VDtXCevwr7lO7Pbx8k/oyH4W8BxJtrdFQzzKzya
 JtG3VmqdCnGN8y51QbwvU1QPGi23PpD/mIJPAmsEJQYIUWHzbdxufGEhU
 3/7EVTc4dJW4rcfWcuyzW2SmaHG9GUfT41Ni+LkjEJsEwtidwm/PWyg99
 C7Z95xvG7Mhg/atoMbtYZMgOGqqVAz6kd0ZEFyFCQoGITQCBlVNAm+MzP
 tkas2ijexza5WTYBdhI6CSvpLxVuVtAgVJxSKiFWS0/cdrAstVJVXv4ni
 QZ0IuGTKE13al7IYLrWTmwaUOZdbh4a8udppai1RKokUcOfSyV3B0GS3u w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="7016377"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="7016377"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 04:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="893991541"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="893991541"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Dec 2023 04:40:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 04:40:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 04:40:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 04:40:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 04:40:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=She636kRLYmV4ve+xRPQQKnLxvumxtBukF7J/P+n7daBUL5Buj7gf4ophWYgVeAjQZBwUpwJxPnlusc5EFe+tiGuA49e2QEmVvVPYOky3bcfYv+OcbHSv+bBEoqgcsHr5F6L7UA+O1xRHHVefSVV35Yy790Y9iJVkMhuY7iFzn/zxArJyx3Eob24+VmcrudoShLztROe8hZ0cLMsa1EAldfMnrawOg6ihRGJRCFQsQR9nuCl2jqGzC428QQs8PNE5pKQhvJ2xN6OaarcTWBFcZn4NNK30xrvedu3oCDsP1tbcQDEG9j6iotqPeXLrCkATvtZSo00wQ9A8C5FSQpNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zaf7FLLK3xwMHaQAoScdp1sby1IneOAy2wTgyzn76uY=;
 b=h3ZeC7uj5sk/1Mx4uBOuVvJ9ZW06d7DpgpbUCNoANzxAzt/ItNGw6o5RautfnYdGvETT1zJZq5ULWZ9sUhZlpWG7LYbDId0CYXW6I829kgXgjJe2HCHa5BAUrDwPpxhFWtQ88fJxVdhyuSgp5cm2To5HcwYDtYoli6KfPlro8iZeip2BPRYwgfRajXPDmhfoyQh1QiaWnzHc7JHrTupuuNyGPZgZTexVQe5w4EZNub9mdZaM10/+4s6k3iYzNEdOvdQybVBS5Y76PcV2RL6+XwiSOpTpvgX60KOl03BkPOVrhnnZNLI8uU2dAPnHEW+aH2vDVtm87/Se5Og0FgdKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 12:40:45 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:40:44 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v2 3/4] configure: add qpl option
Thread-Topic: [PATCH v2 3/4] configure: add qpl option
Thread-Index: AQHaE6gvflDx6U4wI0WY7ki/Mf3gtLCU1MQAgAP8rqCAAGJngIAAAegw
Date: Mon, 4 Dec 2023 12:40:44 +0000
Message-ID: <BY5PR11MB4388112CC90163BE3EB41830A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-4-yuan1.liu@intel.com> <87cyvpbywv.fsf@suse.de>
 <BY5PR11MB4388B24F2EF2D319325F4673A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
 <87edg2gnge.fsf@suse.de>
In-Reply-To: <87edg2gnge.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|PH0PR11MB4917:EE_
x-ms-office365-filtering-correlation-id: 3f117b6d-c3f5-4975-1a59-08dbf4c63bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udNoIKduigJUs0UJTqcD2qgKx1/3FfEo6j60pGlMsoDgVZk670VHEiW/pPJ106kNR59qWRAP0/vEAS8V9F/ViWw9DKjx7J68Czs86lsxN9kX+rj3mLLc8UObv1tmtvoQoVHjJBDddDnjzwTan63wYxcj2f8nbmeKj1PIWT2RkCTQaGXdSKBBBF+eRr4/mxhe6gWykb9IB7UFTjkHKxJa1gXnr9abyrrJgXK32ZTmcBqE89468MGQ7jtXJGifK9Rq7py9hCwVLK+jyQPkP9D3rmXFVXgSqLYttmHn3TXK4JeIDLnWQxwvoTCvrwbbUbkb6J0Ln5MHZHAGdVbMuKSurilI5jG12P3yxzUX0FqC17s7xxmfqhGFOQ0tmtO91hJhbH4rsIwaVH68lfHVIbZ1z387DzKxvFb6p0NezFri2LrpvRWGOPB4DB/KQRAT31B8wc+8iEHAGU7/+FFHqEe4h9FB/CPmhbToYYmI1ZSkvID4AyPdQc7GAtc3l2RSVoDwxunNHGqf8agfFPSzmwtjQ0UoW+j4S4qk3yxvbiVEJPYJ8Ohqi8PemRSwcBQbW/6ej8+nCQ1tAe8rh6g86mCWVaURSajfbe6ZLsq68zpnov4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(107886003)(82960400001)(83380400001)(122000001)(55016003)(38100700002)(86362001)(8676002)(4326008)(8936002)(53546011)(6506007)(7696005)(9686003)(26005)(478600001)(41300700001)(71200400001)(33656002)(76116006)(66946007)(66556008)(316002)(66446008)(66476007)(64756008)(110136005)(54906003)(2906002)(52536014)(38070700009)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IUEU075s1Xq8Nkt6Q79ha2mQPJtOArTdnUwwXF3NG0bCD5VnA6kzXJfFoyec?=
 =?us-ascii?Q?gGXUI3IaE6Pn6aBIMPt5fhah6CjvFmIOiH9q7+dIQ8Nn35XcI3vPoRGInQ6A?=
 =?us-ascii?Q?l0fEtME/DEt6FFoC4l6r8ocSvPyokbtBjo3FA5Hv9ivo2BYwbsCF7KnivkUO?=
 =?us-ascii?Q?LVD1fFHkGvVTUrJtsLHrc7IHrhN1+24jAPNjLQ3/il27AbgEiyG+U7UJ7/cH?=
 =?us-ascii?Q?kBXBCGwUh4/fhoTzbmMDEOMAaHgSdf+9zl1S3alDdcKIxgYcipkam3mV4NK0?=
 =?us-ascii?Q?joRBxjl+mZpbwDw3LtFIVVZsZxhstnCHLpVm76S6ZQ+6EklYYPMO2S0e4BrC?=
 =?us-ascii?Q?1Pln5CmhaXzu7PZQamPPfQB1lz291ErCTB00bz+SlpNsJf1ZqHeR1T5ENhfp?=
 =?us-ascii?Q?nLa8aHavmq7kmgLWfem9sYpAWp6eloj9n+Ngun6sDrJo4Lnqbo2OVqIMirvx?=
 =?us-ascii?Q?HLxAwskuA7OgDvMHH1+zYpZyqx3uAGXbIg5RxXg9hZHEWC4Lp1rXH45dAU48?=
 =?us-ascii?Q?ng+MtsUmG+x9wR+2cjNJjBiFGdWeUuJW93LU2N15SvKKkbG9gEebSq+pASNF?=
 =?us-ascii?Q?bkyISSpqW9ofQ/KyQyoKrvb1/nB9fUE8buBHY/AVM14aVOvygWarX1iEjZTo?=
 =?us-ascii?Q?ZM3ZnLEx+5G8DOULrqI7Ukz3rSR6Sb9aeW2+Q+qbIpgwENMVFwugIXuKET1o?=
 =?us-ascii?Q?bVZOTFKAHRDa9cJ7/MYmfFZg8Pq/bY6EPawxVw3MbOk5ruM+u9LXKuYaJfLR?=
 =?us-ascii?Q?KZg/f2PrX6SfINmMmZvvvgq/sBWpvhhJJeexAJNFGkJ9B1gXvXTBWMwQ+Cxa?=
 =?us-ascii?Q?nMeywY6VBISP8t07/rA70pHgjwbvjlDzgp7EKenMeVfqVvO6FwOlqWfGEqor?=
 =?us-ascii?Q?qr0tjzX1ha1a5fekbWqjGUKaIKiq0GxFHKbV9qbgV4V0yJnSKJdxWKzD8Syi?=
 =?us-ascii?Q?Agk4rORhMDM97PXeU4JWy9PnqsBoofkgeQzl7HfIemDBA7FIIocMXzdycIk9?=
 =?us-ascii?Q?DZvcf2EjyCb9Yu+BphpWDm87mdj2d1GeeukrJuwZa/t5FKxRbRmL4z/4gt5h?=
 =?us-ascii?Q?gDezOt3HSHJHDUFq5ZJTMwbs1gEZ7QkYVNz3T3PmG5PDLYgnvbVuHu6F83Ki?=
 =?us-ascii?Q?BZai5GJasMhF1JT93ZaKy7IgWWwtFMEYAd54nqc2AW1/pLE1u8gAdSwroZo5?=
 =?us-ascii?Q?n6gR9p90WIsLzT+JcMlT/tncEa+S/II2aWGxY9nEMwjoZqzi7QIXv29lu4/D?=
 =?us-ascii?Q?65Px0KGsBo9+7qT6U9dvXiLMCu0VG3YcewWHXgQ/offfwqRqeXBJcEcq3wt1?=
 =?us-ascii?Q?/5XuY3xhua3TLaDnzdx87dJTLcdp9MUnjbqRSNePk8Ih28IRoBQhRQUg/jha?=
 =?us-ascii?Q?iMgLT2WrpV0i1JIytWiDDNJmgUUrVCu3d+NTAEdDzHm/lJKh+DG0uUhHJZcJ?=
 =?us-ascii?Q?7io4QocizRV8JKtz/uuEGdV0Iw1lxw2//ShfxoXBJQsFeD7r25dTKGnyUAT5?=
 =?us-ascii?Q?yHpE5aHJs+mBpaFfJFnWtX76Ix6c85oWhpAVm6Kq3ajZMyPckxa1/NLf1RQn?=
 =?us-ascii?Q?DuZ3rmx83gFca835eiSkQR64qOT7mzKlFiNkNfEn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f117b6d-c3f5-4975-1a59-08dbf4c63bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 12:40:44.5044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK3aQaqTJC8EdBH6x9nYATqyPqEGzY1m1n76vQhjvKZVPMmHDzTt1E4Hgn4liUVcRISs6neYwcQq7dvHD8Ymcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
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
> Sent: Monday, December 4, 2023 8:30 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; quintela@redhat.com;
> peterx@redhat.com; leobras@redhat.com
> Cc: qemu-devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>
> Subject: RE: [PATCH v2 3/4] configure: add qpl option
>=20
> "Liu, Yuan1" <yuan1.liu@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Sent: Saturday, December 2, 2023 1:45 AM
> >> To: Liu, Yuan1 <yuan1.liu@intel.com>; quintela@redhat.com;
> >> peterx@redhat.com; leobras@redhat.com
> >> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou,
> >> Nanhai <nanhai.zou@intel.com>
> >> Subject: Re: [PATCH v2 3/4] configure: add qpl option
> >>
> >> Yuan Liu <yuan1.liu@intel.com> writes:
> >>
> >> > the Query Processing Library (QPL) is an open-source library that
> >> > supports data compression and decompression features.
> >> >
> >> > add --enable-qpl and --disable-qpl options to enable and disable
> >> > the QPL compression accelerator. The QPL compression accelerator
> >> > can accelerate the Zlib compression algorithm during the live
> migration.
> >> >
> >> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> >> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> >> > ---
> >> >  meson.build                   | 7 +++++++
> >> >  meson_options.txt             | 2 ++
> >> >  scripts/meson-buildoptions.sh | 3 +++
> >> >  3 files changed, 12 insertions(+)
> >> >
> >> > diff --git a/meson.build b/meson.build index 259dc5f308..b4ba30b4fa
> >> > 100644
> >> > --- a/meson.build
> >> > +++ b/meson.build
> >> > @@ -1032,6 +1032,11 @@ if not get_option('zstd').auto() or have_bloc=
k
> >> >                      required: get_option('zstd'),
> >> >                      method: 'pkg-config')  endif
> >> > +qpl =3D not_found
> >> > +if not get_option('qpl').auto()
> >> > +    qpl =3D dependency('libqpl', required: get_option('qpl'),
> >> > +                     method: 'pkg-config') endif
> >>
> >> Hm.. I'm not having success with pkg-config:
> >>
> >> ../meson.build:1043:10: ERROR: Dependency "libqpl" not found, tried
> >> pkgconfig
> >>
> >> It seems it doesn't find the static library. I had to use this instead=
:
> >>
> >> qpl =3D declare_dependency(dependencies: cc.find_library('qpl',
> >>                          required: get_option('qpl')))
> >>
> >> What am I missing here?
> > Sorry about this, the QPL repo(https://github.com/intel/qpl) does not
> yet support libqpl pkg-config file, we are in the process of adding this
> functionality and we hope to resolve libqpl's dependencies through pkg-
> config file.
> > I will explicitly address this issue and provide relevant documentation
> in the next version.
>=20
> Ok, just remember to test with a clean setup next time.
Sure

> > For the pkg-config test,
> > 1. create /usr/lib64/pkgconfig/libqpl.pc 2. add below lines
> > prefix=3D/usr/local exec_prefix=3D${prefix} libdir=3D${exec_prefix}/lib
> > includedir=3D${prefix}/include
> >
> > Name: libqpl
> > Description: Intel Query Processing Library
> > Version: 1.3.0
> > Libs: -L${libdir} -lqpl -lpthread -laccel-config -ldl -lstdc++
>=20
> We could probably do this with meson directly instead of requiring a pkg-
> config preliminary setup. My meson-fu is not the best, but something
> like:
>=20
>   qpl =3D declare_dependency(dependencies: [
>        cc.find_library('qpl', required: get_option('qpl')),
>        cc.find_library('accel-config', required: get_option('qpl')),
>        ...
>        ], link_args: ['-lstdc++', ...])

I will fix this, thank you for the sample code

> > Cflags: -I${includedir}
> >
> > 3. Install the header files to /usr/local/include/qpl and static
> > library to /usr/local/lib64/libqpl.a
>=20
> For this part is ok to just point to the official docs.
Yes, good idea


