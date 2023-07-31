Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E8768EA2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:25:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNH5-0007Bw-Nt; Mon, 31 Jul 2023 03:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQNH3-0007BR-Cp
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:25:01 -0400
Received: from [134.134.136.65] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQNH0-00084m-Aw
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690788298; x=1722324298;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8HpDp5dHqMC9I6gqySC6yDIh/0sHVw0l7+bDKzNZnqk=;
 b=CEKVNFMJpK0QgNVNOjyzPhHUzYduhDS0rtpd2RmU0hPbazNwpb9JpVxE
 61/S1BMkv0nbXI09JYwhMuuNFyfwVsNJFmsuQ34Tk8JmQAgqFJIWOIs4N
 iHvCP9li2cKOGKejkNttsnMCFGF3kGcYkzas5LBbOy04a9B/spxJQGNeA
 nMvD3YG7Fi9/43kQewfNOXOyzOqVLWO/R6m+cvBMo4KNvzIGhe+qlb9n6
 sm+JtQO8hwXizjRPJmnbqmD8X4TDwiZQyBMR5QR9tR+3zbHsjxE/s5vte
 DZWJ+JQxxaXsXN6+9znqze8hNPzvrn6L5GQ7awHooa6y0TXVhk42alGoc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="372571712"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="372571712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 00:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="793614575"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="793614575"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2023 00:17:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 00:17:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 00:17:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 00:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbUNnSQYGedy/wRWtww9U0TkWUbT2iRE7MVw9b0ljCmOJvMfnN/iBhv3TG9TT5Y7VSHwpSxnDLTRKHcPduuuHHS2BTiaSIt3XzR346qAYYjhIU4ou5fcRbFwv9TyQqtLQcBJKzytMyJ9r9KjbmmkISnzGma1rLPXzGRRMBbqWHCrbYC0Qu4W51zThFhk85kf2gBxMbcYwlcejq7Rv7iy9geD1Udv+TmWPtdmj1nNr8mZQKPg6m10ktgt6ttI5Ws/7ovton83g6WB08OY0OJHbcXDOUqUOF2mwXBAKUtJtEnPvCjfJVpERyK8720y6n4T+REnzfny4RGXg4lUQp8Q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmjRERtMKEg4vX2mv280qBKBXUTtZ81cFMMuRGc9bts=;
 b=LW2CabCKgE2T+YqtOftzHznqW4QdCbDefSH1/oj6WDd+eWnpyHd5/+u85K2M6pf0vNRBW1ygKsSiDht7NylKX7BS2yq4/Sd3r43zPqew8AT9cRWEqDn/ih+ONYCpHO30sKvF5HOwbmCJeiFwiHMRE0ePZcmz7asEQlL/DPgr3nMhsM7PqPmQYvcpJvb/J/zG6ZEvS2sYEFH5ICwzDb3yfw1m+0nn3a/XmmE3Iga9XOtEkJEc4ayDm4U7rgpjxiDYTtYE4Uqa6II5k2gsvEwODytr5L65yL7t1fs9M1jFRLJWaquqbsKl+/Xm9QnSvkyKQ4JAJeLejlZu5tOWPSJqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 07:17:31 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 07:17:31 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 2/3] vfio/pci: enable vector on dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 2/3] vfio/pci: enable vector on dynamic MSI-X
 allocation
Thread-Index: AQHZwFtipVhx7+TaJ06pO5DGzBBhP6/N3deAgAVn56A=
Date: Mon, 31 Jul 2023 07:17:30 +0000
Message-ID: <DS0PR11MB811422B6DEDE5E0C74B59D97A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-3-jing2.liu@intel.com>
 <20230727112503.4160f411.alex.williamson@redhat.com>
In-Reply-To: <20230727112503.4160f411.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|PH7PR11MB7593:EE_
x-ms-office365-filtering-correlation-id: d11024a7-ddb1-4bd6-30cd-08db91963430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHLE7Zsmtl6c3nN1/Vt7fu1/wK5GdoLSymsgVYefrH7XGyArH34WOgRG7I5kFx3wFMDGGnxX6B+ELDf8p764w2jTuWR3j5uZv5C7MKbj64SQBxTQRnk0OCoFxgPw0Dby1UseDCisVQlM3CsNz2Nl4kavqjyD4BeWRw1cKuPsTG0S979Q7RjZr2kjy/igBEjwoS9vLZqK51i9Mm6gLV2I24D7wtme8a08cCEDSX8ni1I1c7U/94JzRPNSpUB63CLs6sFh9ohoqvUGzejYyyNzd91xr5H9cRq4b8gpYztBClpex8yHLycy6Uc4r0FG9jKmtE7XEQzoSy6R3AdyjbZDFXwl0Mr+1VN8bnZSug1NZ2QKTKBd2wM83+70MlWkcCOzNgei0upsCkEA2SzZ2vakWAJdEX2v5KQOZ48ZS69eeoTKjVnv1T+NB5UvWvTJWOE2k7ExIJvsOkN+PiuGWNuCTBfqcJNTcPZqXmqYs1n0HHizi4tdkB9s5whGCJIZIdVE/b1VJvNM/igzZUKuUOcACCMnOls4y/eLEBW46XYdgp4rq7oAHJQuNhUENqJpugNLTE7Dc1kWy74k0IEeOQNK5w/PTWT3PzzGguUBeXU129H8dKnxOyIxSd0q4/HYgqEI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(26005)(83380400001)(107886003)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(82960400001)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(6916009)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MCWWn/ujk7MRWXRskfpzu1VUYXnROEOLdm2T7IDTZy14Xcoj9s+38A6bnFe2?=
 =?us-ascii?Q?dzrFjFiTYaE9o+PfqV/9LbZcXpYTm6RY/buVAaxPgFqi5dB+C44PIpEboZ3q?=
 =?us-ascii?Q?aFFoWqESsn6efbKf3fBiyrE6Deu/FLP0gXKqUIEUXrCW9pZCO9K6QmAgU7MS?=
 =?us-ascii?Q?c1CeThqVi03WRUzCTfXybnX9v6BiCz9teS3tzcXJDNUSusG+Rv5Aolsl7GRP?=
 =?us-ascii?Q?LQEDaHN6Tdz1RFyAqmQRGWN+8YkioKRBvWQfMtcQZwMfkVWwLNlYriC4rlMm?=
 =?us-ascii?Q?DWgSA0FyHRFSYnkEhWDWJS1m0xDESHUyG2tFHwTTnTsLR0s5fh3GRqO7As2R?=
 =?us-ascii?Q?jtLRoDHXAMG4ZZwouBwNxmj8m/p2tARENLccCDJSJAVrEfNylv+YDR3PShPp?=
 =?us-ascii?Q?0slBY94tVz+bmBok3En/YsrwMx3mQY0+WoeimzV96LH88SS7+xHFlB3pGdyt?=
 =?us-ascii?Q?LEHJDr1JNQ+viE/I+SYhO/B2X1Hv6SnkCywlZ2V8IWrRo/lmc3qNbqTs7obi?=
 =?us-ascii?Q?u8/KceUsyYbwwIHbjwo68OvgYb0yEi6qTZ7BFewy4Wcn8QW9IHwTvQIYlHk2?=
 =?us-ascii?Q?wT8TJLn7cbj0O8DBvlKZ9lyzIWcjA1PCjC+kW3o45FKwtTeN8CIy4i1juI1A?=
 =?us-ascii?Q?zZfLfXkaDlLxiBM9/ruVp4xuIZZZvO0VstD8rwB4fvQ9c7KevtBLz8eFKIZS?=
 =?us-ascii?Q?mAE/llgOVvAyJCjZfhenFeQzki/9e4nzkI4HE4lNLVLcfqSVFb9JsVW6a6WO?=
 =?us-ascii?Q?I6RGnlW7WsP5PHLdCs327TbyEpmdOIQGLeNITNamZUGCLMCwSb/oLyL1M28y?=
 =?us-ascii?Q?BHX+qBf0RjqkzOB6blAuo+XSFm4A900RnTLfYrTXW6p5Pj3I/rnE46sM4A2g?=
 =?us-ascii?Q?YrU++YncQJXTBkKQGytPuRd4QM3Ou0W/aLINm7/zLocCtZDlahNU7c7WLwzU?=
 =?us-ascii?Q?7Biir9tWxg+PzZH2hncmg9W2LjmCqplDfCwcR+yWwxA2Je5x2weJ4Pxa3nhL?=
 =?us-ascii?Q?JOuAvnOkH4CoAlLN136qH1CeTYxx16SWvEBIDW+vDoghAXT3Pl+nsAc7plWm?=
 =?us-ascii?Q?TX1jwdsarre6HtwzDAMeZfUyqesFZ7T/VkLBMZgLaMduOuJw1aAxeHJwDv3W?=
 =?us-ascii?Q?EsXYN9tfCWf6ONS+JsfxyKhdXyxfbL9YmjAHCn8CYCN/t8MsO9NPBN3W+ruW?=
 =?us-ascii?Q?CCsv90z1ACMLRFOj8wd3HtFhXpa/oyQU+vnkZ75ZQBxxZ8cBaUOuNtZIzPWv?=
 =?us-ascii?Q?PAhU6T1Zp9f76eiXVVEq16/SjZXNKhdtbITtYJp5PiqXMTRdux3TIcD6wnFv?=
 =?us-ascii?Q?S0HYJ49XCboPxYwTgjTl60+LVPbbxnGO59LfJAUJqd26nL2YYufjS051wmZ2?=
 =?us-ascii?Q?06C7UxCaN3keixyx0/jEoXK3pu/k9HG7OSbVOtSY+9wDcPJsOk6WF+TmioZQ?=
 =?us-ascii?Q?GYI4pIcVQPNo/IRyx6ejthN8kd48oMPjkMQ6HNTdZZYIcwoaxCcKSoaMF+j+?=
 =?us-ascii?Q?OtFRLEkq/8/I0W4mzqbU6mMXfLbKxBG9yHPJI/RoR5ohMYQrdGManBFtO6sz?=
 =?us-ascii?Q?CKLjTdpXU8mU2U/wLYUpQ+DwFduQalb2b8diuDRI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11024a7-ddb1-4bd6-30cd-08db91963430
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 07:17:30.9711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwF/01Z7LDRFNg7WKjQx4FluRZch7nJdKTVxnbHX15qU4luxDGw/gVWnWQRkE8niXptixd5GVPy3p6Qm26+vQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.65 (failed)
Received-SPF: pass client-ip=134.134.136.65; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alex,

> On July 28, 2023 1:25 AM,  Alex Williamson <alex.williamson@redhat.com> w=
rote:
>=20
> On Thu, 27 Jul 2023 03:24:09 -0400
> Jing Liu <jing2.liu@intel.com> wrote:
>=20
> > The vector_use callback is used to enable vector that is unmasked in
> > guest. The kernel used to only support static MSI-X allocation. When
> > allocating a new interrupt using "static MSI-X allocation" kernels,
> > Qemu first disables all previously allocated vectors and then
> > re-allocates all including the new one. The nr_vectors of
> > VFIOPCIDevice indicates that all vectors from 0 to nr_vectors are
> > allocated (and may be enabled), which is used to to loop all the
> > possibly used vectors When, e.g., disabling MSI-X interrupts.
> >
> > Extend the vector_use function to support dynamic MSI-X allocation
> > when host supports the capability. Qemu therefore can individually
> > allocate and enable a new interrupt without affecting others or
> > causing interrupts lost during runtime.
> >
> > Utilize nr_vectors to calculate the upper bound of enabled vectors in
> > dynamic MSI-X allocation mode since looping all msix_entries_nr is not
> > efficient and unnecessary.
> >
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> >  hw/vfio/pci.c | 40 +++++++++++++++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> > 0c4ac0873d40..8c485636445c 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -512,12 +512,20 @@ static int vfio_msix_vector_do_use(PCIDevice
> *pdev, unsigned int nr,
> >      }
> >
> >      /*
> > -     * We don't want to have the host allocate all possible MSI vector=
s
> > -     * for a device if they're not in use, so we shutdown and incremen=
tally
> > -     * increase them as needed.
> > +     * When dynamic allocation is not supported, we don't want to have=
 the
> > +     * host allocate all possible MSI vectors for a device if they're =
not
> > +     * in use, so we shutdown and incrementally increase them as neede=
d.
> > +     * And nr_vectors stands for the number of vectors being allocated=
.
>=20
> "nr_vectors represents the total number of vectors allocated."

Will change.

>=20
> > +     *
> > +     * When dynamic allocation is supported, let the host only allocat=
e
> > +     * and enable a vector when it is in use in guest. nr_vectors stan=
ds
> > +     * for the upper bound of vectors being enabled (but not all of th=
e
> > +     * ranges is allocated or enabled).
>=20
> s/stands for/represents/
Will change.
>=20
> >       */
> > -    if (vdev->nr_vectors < nr + 1) {
> > +    if ((vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE) &&
>=20
> Testing vdev->msix->noresize would be cleaner.
>=20
> > +        (vdev->nr_vectors < nr + 1)) {
> >          vdev->nr_vectors =3D nr + 1;
> > +
> >          if (!vdev->defer_kvm_irq_routing) {
> >              vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_I=
NDEX);
> >              ret =3D vfio_enable_vectors(vdev, true); @@ -529,16 +537,2=
2
> > @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
> >          Error *err =3D NULL;
> >          int32_t fd;
> >
> > -        if (vector->virq >=3D 0) {
> > -            fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
> > -        } else {
> > -            fd =3D event_notifier_get_fd(&vector->interrupt);
> > -        }
> > +        if (!vdev->defer_kvm_irq_routing) {
> > +            if (vector->virq >=3D 0) {
> > +                fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
> > +            } else {
> > +                fd =3D event_notifier_get_fd(&vector->interrupt);
> > +            }
> >
> > -        if (vfio_set_irq_signaling(&vdev->vbasedev,
> > -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> > -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, =
&err)) {
> > -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.nam=
e);
> > +            if (vfio_set_irq_signaling(&vdev->vbasedev,
> > +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> > +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd=
, &err)) {
> > +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev=
.name);
> > +            }
> > +        }
> > +        /* Increase for dynamic allocation case. */
> > +        if (vdev->nr_vectors < nr + 1) {
> > +            vdev->nr_vectors =3D nr + 1;
> >          }
>=20
> We now have two branches where the bulk of the code is skipped when
> defer_kvm_irq_routing is enabled and doing effectively the same update to
> nr_vectors otherwise.  This suggests we should move the
> defer_kvm_irq_routing test out and create a common place to update
> nr_vectors.  Thanks,

I make a new logic as follows that moves the defer_kvm_irq_routing test out=
.
Since the vfio_enable_vectors() function need an updated nr_vectors value
so need first update and test the different conditions using old value,
e.g. old_nr_vec.

int old_nr_vec =3D vdev->nr_vectors;
...
...
if (vdev->nr_vectors < nr + 1) {
    vdev->nr_vectors =3D nr + 1;
}
if (!vdev->defer_kvm_irq_routing) {
    if (vdev->msix->noresize && (old_nr_vec < nr + 1)) {
            vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX)=
;
            ret =3D vfio_enable_vectors(vdev, true);  // use updated nr_vec=
tors
            ...
    } else {
            if (vector->virq >=3D 0) {
                fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
            } else {
                fd =3D event_notifier_get_fd(&vector->interrupt);
            }
            if (vfio_set_irq_signaling(&vdev->vbasedev,
                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &er=
r)) {
                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name=
);
            }       =20
    }
}
Thanks,
Jing

>=20
> Alex


