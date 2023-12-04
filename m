Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09861802E76
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 10:24:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA5BX-00020D-5p; Mon, 04 Dec 2023 04:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA5BU-000205-OL
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:24:12 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rA5BS-0005Ka-Ad
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701681850; x=1733217850;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0IRcfaMeAy1ug7sBFZnCpNtaNPrrIwwqEpzoc5qBelA=;
 b=Mo5iKZ52vbKREglVXxStfMfM/L0JYjKPfq7G/+coFWqBXFJ50dXakasf
 7FP+1I7pLyfSTrivIgKF/k4GJO8JR5JGn3ZTWttjuOeM4K/KzOyKwNJPA
 AXSFKgU8Ol03IeSjxxIT2jGUtscqmdRcRWMs/T8uWVAHzeTPnOZm19WG7
 7pIJF9WCA1GmqaQbt2QxD5DRvdGQKj5i9lngTXHcGur/zKAzup/sU9Xhb
 3QyH4Rs3XfDe8LYWjKWYpGffFe47dT+LPVPeViPEi4HRln60AmsLWzfHm
 /dByZIwHlCuTnzEUxnf0qH0Ie+6y/2ezAvhwQ3VY5kL5D8yzkpCiy5M3d w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="557827"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="557827"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 01:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="914359137"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="914359137"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Dec 2023 01:24:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 01:24:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 01:24:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 01:24:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIh1UMfaTXdWTLdiEYT3zPk8UES2J3WQ2h1X2aw5njow7LMWnrXDhRWMhBw5ulLxHxoii+2ctuO2oE1UwT63kdH0kfAZaQh1qw+CJ2pZe5N0vZuPFi//9zm2EOv34Hru26KFlrt9QR7XAyKxm3pkm7Ufud4QbLTdun2HmeN+eNsu5sYkFsQw+0IS+5p06SxcI0/GylI4tntP2K3IRIOUYzjfZy1iNUJIGIty+r6RxxwihZw/zUC9W4Z1LE4q2u7q5ISCFjJsLfn1Xu+9WTfGeWydnXlmahRt7PH87eVnp7EHws5r4mNmuxpB3pPtjfo+0p9E8yvaI/eMDv04ot5vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3Ld5EuElxO0Mu5La9NNQXQUQ1ECbvAEFcme9loVXiE=;
 b=MPN4vgXsZLrCFNC1/61ZB9QzSc+AsbefczeIQ++2AUN6zVI+iiNFyDR3wbckc/Tt9xg5o2JjBymIrR56sc5jxTUIrsYgSRKFHEsHiCUsl3apDvCdpDvAAmMg41vR0L+zq2DXDbnZbU8i8HkmOw6/fslUhbuw7kkO6OcXNKENiXbLFAuHzhA4lziuXTTTsS9fb+eddvTLXb0fVYO1gvt9Txpck+H8mwmokh6/ZdpO2cO7IYdTm10iZ0JnVtzZfhD+AZ9ruS1COWBSOFyttm73Qo+jsa6fA9Pe7lUblrdqr8boGL7HxlABr++jSTlj5qTY12qD2OC89m4DtV3h22bxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:24:02 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::1a92:8068:1ee6:59fb%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:24:02 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v2 2/4] multifd: Implement multifd compression accelerator
Thread-Topic: [PATCH v2 2/4] multifd: Implement multifd compression accelerator
Thread-Index: AQHaE6gtVL7lGZiJP0mGbA32I0Qg8bCU2XSAgAQlb4A=
Date: Mon, 4 Dec 2023 09:24:01 +0000
Message-ID: <BY5PR11MB4388F8D96B1166DB495083D3A386A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
 <20231109154638.488213-3-yuan1.liu@intel.com> <87a5qtby4w.fsf@suse.de>
In-Reply-To: <87a5qtby4w.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|SJ0PR11MB4816:EE_
x-ms-office365-filtering-correlation-id: 4d4b306e-414e-4e92-9032-08dbf4aac0cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfdErfeDWLJ4NhBBx0HCVgBZidm6h8BvXR5tP7/L05H7c4XkhNk6hWfB1V9k3MVpLsWQRcpDpbuF+LH08x+yRHiMcrW8Ec9AUEIoGWG3xXY42rOZeIz5laZExnQW0rkAnoJUnFBIJls+6xR4YcpjMaI7HILZSQMMgN/DkrFr5Ez+0tAoyE6TE/kuyp3nW58/f7vNIbuaCx8L2Gim9/qd0gsLQczHxcae0ejdh9sTPeTNeChi5csyMkTvdc0+XierRuEp7JppDEUyKSEW85s2EcnXKmr01wWK9Nng4WCqVrVlihKLRtLpYTpqLVYi4gMxSXqgGjUVp2VCxmXl9E1mXPAtlm8Ez/lE6zdVcObuQXsO9xjqvDcEppuE8h1vMEqbTqXBzSm/7EXfXfr/wTm+8AGBEwk9TLwneTa2NnqJ9n96qbBy+1kP8ygreCRrRjRWSZXPxQoieHdBBkjyjbawDXf0X5xGCB68eBeB5zw/e57cnaCQy1ILxGYPc4EP8aOMss+KNQDM6ptVjYWernE1lwcZqC0DLlv9fbcO1h/JezyO6CBI/epXICRcYpC6Od6dRNl/6DkOKEZ5xPbihJBPoR/U071wxH4vzLo+34eCXFzwIT7UOKL74/3+CCtBB9JZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(82960400001)(38100700002)(122000001)(41300700001)(26005)(66556008)(66476007)(66946007)(76116006)(64756008)(5660300002)(66446008)(8936002)(8676002)(52536014)(4326008)(316002)(54906003)(107886003)(110136005)(9686003)(53546011)(6506007)(71200400001)(478600001)(2906002)(7696005)(86362001)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oV9P4o4+7+BaOinJ0mGekLFnRpIbBB/c0hqXIL9Z33Ai7sUk3sPIksZQxcO6?=
 =?us-ascii?Q?5Fx9oaRrzdcGVRMzZOt8KB6yCr3krocEIyEb+aT/bvHOIrGzIknypngZxnNo?=
 =?us-ascii?Q?1kUC3mzNxz1i31QlKLQkoAEzsfvr5K2ojQzFYAnjTri056vITnD2Ta2jGpiN?=
 =?us-ascii?Q?gub6/VtGZYKUmoiWziu+fd6KDPBAd6ZTePeP/OKMCtH9B5BDK0P3eTxxm5zW?=
 =?us-ascii?Q?UXVqWptUpcgZPKSCrUKZ6IeZ6z5DnHZds8CATT62FCwhTqfOEzBmtQc++whz?=
 =?us-ascii?Q?yGUElHd6fA28zcHBdMF5198q/6OmqNGQrKlrVgukjy0y/LuTugOF2IKEf9TS?=
 =?us-ascii?Q?qH2yZePM/3ZzqDYPqSOpbRG6wyuqqWCfCrFX4M6dahx5hS0m6ZMc0IlYbCE6?=
 =?us-ascii?Q?wJUZZdtl1by3a5BSIsdic9VOpSgkkquohAjNpv2GIVfCd7g+N2fcad8QpLxQ?=
 =?us-ascii?Q?J29NvJhqcwxj6EfpC7Q8hVlV7r7gHtyTwwvKankq/YYaCdEzdwHNq0EoL9Xs?=
 =?us-ascii?Q?uUM+AbT9x93kEeh5K0jc+KYTCLegyCB9qTr/DshrbBqVB4yv4HO8XBOH2xBl?=
 =?us-ascii?Q?uMfxCFyjp1MPcB+WeG8AsMviN9BfA4M99doU2RmsvuyBaQ60EuD8tgpJV187?=
 =?us-ascii?Q?qptrUxDiIXeTaLt5W8V947QfEhzMfkiz5TE6hdQCr0uzAfxT7JZvnzlUUub1?=
 =?us-ascii?Q?WDOh4dm5KQ88mIzOmLiKkuC67G7snVbeXUBYluXtAjwylWthBGClZ243mh0D?=
 =?us-ascii?Q?7PyolryzSJ01D7YOyFVH5Ihgu0qUrFV4ywDpSnOui6JOjYxW067BwWMCDxdO?=
 =?us-ascii?Q?e67HX20itqjsTBT2clJCFuJfaJnXTHB9MOsjCySM6DRTWk0kl7/9VXejFVdC?=
 =?us-ascii?Q?juMv53TmiBD81lmJ5Hs4oXQ9sxIK5jP+HqaYHd3HmJcqNtko8cm0u0ge7Zsb?=
 =?us-ascii?Q?25yJZ5lEd2MkafwGqZuU9FVPlJRVMlv5FLSbM8H4lMHqaqGJqjQyv/VzpQlA?=
 =?us-ascii?Q?2jD4DTlfaUCCfyEMVCrJj8i7uzwJD7rKd5tgVbNDCNZcwm5pQ3jofP95IEqY?=
 =?us-ascii?Q?EbPATDCHPDk8cVyXf47EQamz+bIKB9jqdwgBEyW/3TqWmt6s/JDHm05d7T3d?=
 =?us-ascii?Q?9JqQ3evgzyN9dvNUvzSTzmhpa02Tv7JERl1A2yJaCBRlVHZNRt09NAdhiGbU?=
 =?us-ascii?Q?9j0u5Z6Mk+jdE666lh2IGcbSfpq+OxMlVdPWi9zAb6aXJL9ne9nKYxbPs7Ph?=
 =?us-ascii?Q?RfSJ5tYgqs9Y4WsvLahZN0zwRrJ6JX5vJgYXZAXA9kel52vz1EKgM7C2gZcy?=
 =?us-ascii?Q?hvPVroDKcWIloG9X7BRDG6WNbaproCPLjRs1IgYUzPbrcGBU3hakWeIFrNz/?=
 =?us-ascii?Q?QjInfcVbLnRah3E9Cl+GAWa23WNqalE6QUPiGivwVxXryBvylO3i93t1Bv9E?=
 =?us-ascii?Q?2qB0NtGyoriEp8VWa1dwhLhH/YlRLuix2QTfR2tfUvCFyxsVZafoKurtI6Tk?=
 =?us-ascii?Q?hD8IbIpIvE6LZAHnFrRcnqgBWfpLh9Bqb8DI/vUyxar26ocP6xCngEpFEKfu?=
 =?us-ascii?Q?CzI50XAqDLvPHRyBWPeAdk9hc0XqQaBZzM2eawzl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4b306e-414e-4e92-9032-08dbf4aac0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:24:01.9132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqCXN4M2ln/EQfIH2cAc0w+VMEdHmTEHvZlgfW28fYJYYKZhWnsKCykWIiZra3LW2gs7/27ivq/NB/pYtfVtWw==
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
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Saturday, December 2, 2023 2:01 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; quintela@redhat.com;
> peterx@redhat.com; leobras@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v2 2/4] multifd: Implement multifd compression
> accelerator
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > when starting multifd live migration, if the compression method is
> > enabled, compression method can be accelerated using accelerators.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  migration/multifd.h |  8 ++++++++
> >  2 files changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c index
> > 1fe53d3b98..7149e67867 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -165,6 +165,34 @@ static MultiFDMethods multifd_nocomp_ops =3D {
> > static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] =3D {
> >      [MULTIFD_COMPRESSION_NONE] =3D &multifd_nocomp_ops,  };
> > +static MultiFDAccelMethods
> > +*accel_multifd_ops[MULTIFD_COMPRESSION_ACCEL__MAX];
> > +
> > +static MultiFDMethods *get_multifd_ops(void) {
> > +    MultiFDCompression comp =3D migrate_multifd_compression();
> > +    MultiFDCompressionAccel accel =3D
> > +migrate_multifd_compression_accel();
> > +
> > +    if (comp =3D=3D MULTIFD_COMPRESSION_NONE ||
> > +        accel =3D=3D MULTIFD_COMPRESSION_ACCEL_NONE) {
> > +        return multifd_ops[comp];
> > +    }
> > +    if (accel =3D=3D MULTIFD_COMPRESSION_ACCEL_AUTO) {
> > +        for (int i =3D 0; i < MULTIFD_COMPRESSION_ACCEL__MAX; i++) {
> > +            if (accel_multifd_ops[i] &&
> > +                accel_multifd_ops[i]->is_supported(comp)) {
> > +                return accel_multifd_ops[i]->get_multifd_methods();
> > +            }
> > +        }
> > +        return multifd_ops[comp];
> > +    }
> > +
> > +    /* Check if a specified accelerator is available */
> > +    if (accel_multifd_ops[accel] &&
>=20
> The CI is complaining that we might reach here with accel=3D2
> when !CONFIG_QPL. It seems the assert at migrate_multifd_compression_acce=
l
> is not enough.
I will add assert to check both comp and accel next version in the get_mult=
ifd_ops function.

