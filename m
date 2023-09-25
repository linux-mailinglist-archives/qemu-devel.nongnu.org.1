Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C187ACFD6
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkeiR-0002ix-M0; Mon, 25 Sep 2023 02:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkeiP-0002ip-L2
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:05:05 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkeiM-00011X-8L
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695621902; x=1727157902;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VCYsUKLhaY1gZMYWVSxQRz+cm4oCl9tMgguByWY/gdE=;
 b=QQp6LQj1CSvtGfdD/ImzoDv5+zYxBb8uIkQexSYUfuTVTV+r3AqWvpGN
 CpDD+8DK4uq6SzCr2lDYYM5jIVOJjEJvkcIxyZtKAPMgA3Yr/IQS2DmbE
 wwhWIPovzQvTJr9sBDE8h6Vlung8PqmAv+LLhhq5kjJgaeC8k5nnJLzQX
 0CIW/bo/nApOifo8VEyzJi/0d/TV3ZdbOqDvSxfeF14RMrH3N6TzJFMTv
 1LZ1v2gj4RGV1WsQrPX5+cbvw3jrHQ+Xy6NekfFYAFERyDr2fesSeB5xk
 t5KqMlylrTcWed/o9H/lRL2aroe8dfzeVHuqInkhUZPOgIqRZJOnMKdAV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381080672"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="381080672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 23:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="724873014"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="724873014"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2023 23:04:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:04:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:04:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdOcItnMiTtICwFpg7bBnjuQUQZEnVGmD4Lny/e1eZSS7Y/jFizHvRojlmWClQuBynx33bFM+F3dJoVKf+UK2DEabeYes2nEsFhXyFcLaFkpeF7TsMiHP2gSDBA+4dKb0jzAwKTSFDPgQreWdLPOTlM0YZdaNrfTuF85OQjB+sdzbrafqFU7j0BRt+VbaF2TlWVSGqAzYz4bpON40nia4T6P5AwmD2y4p5LkPQqAWvVqSs0xkjo5/q6O2V/sM06ZPiltRBQ8GLAI0o1vH/GQFGhJbFJCc+NQ+jDLWanUtxqD51fZkR/JKmLS36PkZOJglFnQrEzLmux6qoeEFRDmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3nGpCqHls9Thnb/jIpkr/BnGCODelBalIr3wXwDy0g=;
 b=UMr1bBodfapWwRdUHxH6zbUupoNIBDJKmVVxP1wpmMxwedff8ScGaIPdXCJonO7ymyW50whRxswi4gVBq9YelLgz32WDOmX2Kw3Ubg1K9IONn1UvgqoDOv38uPFVcGTDmkECPnEl+CVkF5NDPTu1QSIbNofrhfe55DD3m0LrBpueFAYtjJJHWxu3XcSpxaQmr+5Ia4IJiWjccI6IZGFHjUrXXkuft4G8o+A8lFEKMd8wuGRlv97eKjRrnTgGM/r+0MHDNcwhNiG8bbEJnxlvwa9bSH5bPe2c/FQylijlPCpyzXn15dyS5Ji5eX8tP2XYDALBn262s5SYuCUtTEpq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:04:55 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d%4]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 06:04:54 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v2 2/4] vfio/pci: enable vector on dynamic MSI-X allocation
Thread-Topic: [PATCH v2 2/4] vfio/pci: enable vector on dynamic MSI-X
 allocation
Thread-Index: AQHZ6hTientLUVrNuk6DgJ1EnFz5RbAnWeQAgAO8SEA=
Date: Mon, 25 Sep 2023 06:04:54 +0000
Message-ID: <DS0PR11MB8114669CF7F11A8DA9445169A9FCA@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230918094507.409050-3-jing2.liu@intel.com>
 <20230922145450.22e5b08f.alex.williamson@redhat.com>
In-Reply-To: <20230922145450.22e5b08f.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|CH3PR11MB7723:EE_
x-ms-office365-filtering-correlation-id: bf7ad64e-4ab4-4875-9434-08dbbd8d5690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SajrkAa61f8gq8+eSNPYD1wNSGA5sKx7O0f1nqv9STXZNw1c9LhC78U/KfYXLF8GwPmMElJ9o0PdUnmodunpxaSEJvh3WnJDVeh0HF9ziFwVHuOSEtsZSisr8t6GXZLj4y1j517p4bqXtSlcU6xiHOnrz+vCJHkGfjfTZehvsDt+IJaJ6sLFr19QDZPY5Hu/NfNjWmF+yXRzTjcIFvL+ynFVEEo985zBDW7kI/1RlmQ8vR0GQVyBEHC2bKTOdRMIdR91Pnz1As1tPciWbfOpHJUBt5+lg9bURoGGTLX8WgAYRDfUTPsfWZTgiKXi+aa6X7047cvNfGndAOibgSW1E6oFhMrQ76nDPQH/Cg3oZbR0ft/2eBGrgQbCarBQIJ8fz38nL0kSjrdA59i8RYD9E8i76hHlyOdjMNi1KThFRuz5mS0f1PvebEqm9XJBusPPx8EvKW2a7oq93zAJTtM1RNamE7Mu4emKBry+PMUtzxkfRiej7id5ZVOxdcfHYvIQ2gCtt39/kt8JXvPEo2hDVBb3xyeHGWQEUJHTSdqa3sSB+k1y7+Ev+3eKmC54cY1wzyy18oOdxrsaPlddn7mDvaByVtAfuLM2kzwNjBdU9/RoN2rVQMdcSSr+wQDjbP2Rq2OK6IK6Ze7I6Q8j6svjbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(55016003)(2906002)(83380400001)(38070700005)(82960400001)(122000001)(38100700002)(9686003)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(71200400001)(7696005)(6506007)(52536014)(26005)(5660300002)(41300700001)(6916009)(316002)(478600001)(8936002)(8676002)(4326008)(86362001)(33656002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YyVIlMbxmWCM73nYsIrb3uI8LbHcElKXSzyAIPLVr1p5cMxZyps7dgoJZSS3?=
 =?us-ascii?Q?SamBBjCPBRTWHiQ8N5krD9dQMvhhIUMtw0XtIg/Dt9julqfgYhxjqQCVjpmC?=
 =?us-ascii?Q?ZTUdrH57QUL1HzOUetvaLSfgqsIAlH2cYDNqZHp+e5yXoovz/ehIJIu9L1a9?=
 =?us-ascii?Q?L6irw/faMxxsDbmnZuNViXFbOEXK8u5LIwfsjGj8JHH+Y5x0l1vY1DGEM8dH?=
 =?us-ascii?Q?91oLhnUaJxIxGdfOViJ286n/SN8sHkDxcNgpa7w+wMpgr31TupqWvp0DEiCD?=
 =?us-ascii?Q?NFAnuQauJBqEmfWvwv9XEtOXCrgx2jA08ybzYfCypIN+xkM9J8N0P/ECpCbE?=
 =?us-ascii?Q?SxvOJkV3iK27szYWRzJRUOumjzA/E3oPd1ljwztsBc1vzQPpyPrfvoLKwAjS?=
 =?us-ascii?Q?kTAIt3SN6jY8T0sc4JCZWRE5RUGPp68qO3DhbOtOiBewLEecjIYAf85ItILc?=
 =?us-ascii?Q?lOxBib7liNCJZAX+BlDldM3xUwncOaY0sKds7sWPrEAZUwJeUt0VXO5bWdJS?=
 =?us-ascii?Q?mol6LagvRpllXeonkdz3fFJEsyJlYhmesv0NhKGRubmLgyiu6VHCkMAiZ+S9?=
 =?us-ascii?Q?bPt7C54x0uvAg38vL285Nf5wCBiynE2jI2OcO9hfbz20YbgIj81pju1eNpT9?=
 =?us-ascii?Q?mYBxZjnPJxRImhEvMOeowDgYd4OPYPtZ1N628AsGEUdsPeKwXrJ+FejxJFY7?=
 =?us-ascii?Q?g93I7iimICRfL4iCM5RmX9aar7Q49q5eoDp8He+HieAlrLnb6SMAB/71EIf3?=
 =?us-ascii?Q?WQP9hIFtFZlt4U2hD5/DVsit8bAxFpzg3YmUec6mdfeAl64gHFSnotGFK6h8?=
 =?us-ascii?Q?5aBFslwxV+yEk/AQuaeR1e1H9Pb3DD9g7Tx6RN99UdaR/h++ppCUWaA8LcVy?=
 =?us-ascii?Q?vZG4rm0G1ymU16fL6oOREV8rV3DLykqucxYmuSiqSmLe839kBjGwWZPOmRP+?=
 =?us-ascii?Q?KXiRADBAhhUqE70gR0OPEly4Xa/rO0pIRHBHjFCcrky8UbfGW4VhGKoxtZFm?=
 =?us-ascii?Q?YAEj5SO6LDjW6P2psjOdlOLbPPITFjJl27itD3OqKUvILlqn0ytqAzMsCRjK?=
 =?us-ascii?Q?SpVqxbtK8wEo+G+IdYWgIKx7Q7CyW0btnLXCrFFTi+Z6kxlb6tOb3qycZdHj?=
 =?us-ascii?Q?qQEwFf2SB9ssOs5wG3UKmXRWVTGiXswODOYkJR30wC3hY9wywzf4/NV+K3/b?=
 =?us-ascii?Q?bI6xhTvR/S4AAjI1F4JeIKSGWMYvMT7msaZQywD7XBg3BijnZyhtpiZ9fHug?=
 =?us-ascii?Q?Bgfsz96rY4E4z4UDLwfH60uxRQItRpUYRxw5bkLM/ea8YryalhbG6Ji3mY5Z?=
 =?us-ascii?Q?v0xz0Bv0726ct63JPbuHU4IfItvMcMOB5JC8Lv4Cu/IAfIC3ZrNokf0biB8Y?=
 =?us-ascii?Q?WlLejfIKH9jRJY1GodCNJNNxypmJ8Z3oZAu3rm6bBoSUfo6qm0nKhZ7pr1h1?=
 =?us-ascii?Q?x7dTGEMcu7XSYC0UkiDLBmevGhLg0DG63X+KcBSt2mkm/AgPp9J3McX2NqQn?=
 =?us-ascii?Q?czuIn3cbxCJgZ9UupnnGIViTFAsBaKC65QflNuCYIViyV9PDaSVGex2fDBqj?=
 =?us-ascii?Q?0AULeN0rSoKf7Xr2tGvUMCnV4muHfN3ljUEmdVoM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7ad64e-4ab4-4875-9434-08dbbd8d5690
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:04:54.3388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlD/TbFv6ImBTjy/CN4JYZPHOsixNB8rIhW4j1USmEG9n7bRbaWM94Vhcedjf2IhDQCWF7Ol4bu2YIxq+6Pduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7723
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Sat, 9/23/2023 4:55 AM, Alex Williamson <alex.williamson@redhat.com> w=
rote:
> On Mon, 18 Sep 2023 05:45:05 -0400
> Jing Liu <jing2.liu@intel.com> wrote:
>=20
> > The vector_use callback is used to enable vector that is unmasked in
> > guest. The kernel used to only support static MSI-X allocation. When
> > allocating a new interrupt using "static MSI-X allocation" kernels,
> > QEMU first disables all previously allocated vectors and then
> > re-allocates all including the new one. The nr_vectors of
> > VFIOPCIDevice indicates that all vectors from 0 to nr_vectors are
> > allocated (and may be enabled), which is used to to loop all the
> > possibly used vectors
>                              ^^ ^^
>=20
> s/to to/to/

Will change.
>=20
> > When, e.g., disabling MSI-X interrupts.
> >
> > Extend the vector_use function to support dynamic MSI-X allocation
> > when host supports the capability. QEMU therefore can individually
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
> > Changes since v1:
> > - Revise Qemu to QEMU.
> >
> > Changes since RFC v1:
> > - Test vdev->msix->noresize to identify the allocation mode. (Alex)
> > - Move defer_kvm_irq_routing test out and update nr_vectors in a
> >   common place before vfio_enable_vectors(). (Alex)
> > - Revise the comments. (Alex)
> > ---
> >  hw/vfio/pci.c | 44 +++++++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> > 60654ca28ab8..84987e46fd7a 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -470,6 +470,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev,
> unsigned int nr,
> >      VFIOPCIDevice *vdev =3D VFIO_PCI(pdev);
> >      VFIOMSIVector *vector;
> >      int ret;
> > +    int old_nr_vecs =3D vdev->nr_vectors;
>=20
> Minor suggestion, it reads slightly better below if this were something
> like:
>=20
>     bool resizing =3D !!(vdev->nr_vectors < nr + 1);
>=20
> Then use the bool in place of the nr+1 tests below.  Thanks,
>=20
Got it. This change makes it nice to read. Thanks for the advice. Will send=
 v3 later.=20

Thanks,
Jing

> Alex
>=20
> >
> >      trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
> >
> > @@ -512,33 +513,42 @@ static int vfio_msix_vector_do_use(PCIDevice
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
> > +     * nr_vectors represents the total number of vectors allocated.
> > +     *
> > +     * When dynamic allocation is supported, let the host only allocat=
e
> > +     * and enable a vector when it is in use in guest. nr_vectors repr=
esents
> > +     * the upper bound of vectors being enabled (but not all of the ra=
nges
> > +     * is allocated or enabled).
> >       */
> >      if (vdev->nr_vectors < nr + 1) {
> >          vdev->nr_vectors =3D nr + 1;
> > -        if (!vdev->defer_kvm_irq_routing) {
> > +    }
> > +
> > +    if (!vdev->defer_kvm_irq_routing) {
> > +        if (vdev->msix->noresize && (old_nr_vecs < nr + 1)) {
> >              vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_I=
NDEX);
> >              ret =3D vfio_enable_vectors(vdev, true);
> >              if (ret) {
> >                  error_report("vfio: failed to enable vectors, %d", ret=
);
> >              }
> > -        }
> > -    } else {
> > -        Error *err =3D NULL;
> > -        int32_t fd;
> > -
> > -        if (vector->virq >=3D 0) {
> > -            fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
> >          } else {
> > -            fd =3D event_notifier_get_fd(&vector->interrupt);
> > -        }
> > +            Error *err =3D NULL;
> > +            int32_t fd;
> >
> > -        if (vfio_set_irq_signaling(&vdev->vbasedev,
> > -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> > -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, =
&err)) {
> > -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.nam=
e);
> > +            if (vector->virq >=3D 0) {
> > +                fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
> > +            } else {
> > +                fd =3D event_notifier_get_fd(&vector->interrupt);
> > +            }
> > +
> > +            if (vfio_set_irq_signaling(&vdev->vbasedev,
> > +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> > +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd=
, &err)) {
> > +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev=
.name);
> > +            }
> >          }
> >      }
> >


