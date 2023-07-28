Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1F7667B5
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIXc-0002Er-M3; Fri, 28 Jul 2023 04:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qPIXV-0002Bo-T1
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:09:35 -0400
Received: from [192.55.52.43] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qPIXQ-0007Zk-Nt
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690531769; x=1722067769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zyhYJ4eMWEzcS7d9g8DGbGa+AG6aBewKeTs1aeOE+iY=;
 b=R5hfxGpdrEDSiqd6JALUMjrLP/NwpXOmQE06Y+dIVE7YPgcXlf4nX+Q2
 lyMn3Q/RM+FjGX+51pGCBBwZAcdUTDS1BoEXVeO1v6yyTyZkvcglnqHV9
 2yxYaS5T9jIPcPZ61Y8P2wXiaGQFmbip9ay7wz26KkSw0VmYeqZJtnN2h
 +bYuT2BKvwz1xyVpp9MNYn2MfalZFTrfcwgz60iFh6xrLrUKR+IwklSSi
 kYzSjqcjemW+AKYgZkGDTMpEvaZbq3nXUZe0bPPldodT39f6oU0iWpsZT
 kxO7oW0VMR+4pWq1s2m9HPrB0WDIuqT2HCm/TsB6bCYVnm8dbnaiO1jGy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454898850"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="454898850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2023 01:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704430919"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="704430919"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga006.jf.intel.com with ESMTP; 28 Jul 2023 01:09:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 01:09:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 01:09:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 01:09:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 01:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0JuYnQX2GrGqSu3YhNq4dCP4YyaFlkoYAA/JzExfOtNoqo369KfgaENGBIkTewgIOEWiiS7R/zOfyP9OgJ7a8D/7rkoVRnxSFHXwrTiHOsCJrrnJJGcmTepJbGXk+FMuCaIrRlF/XAeLZkwXh8RH/vaPIQNizaCB3TqD0Q57fXrQqIbAuzbckocCUgvfH0nTSmsw/n9ZW0ON/qAAJEJPx6av05L1yglxmyRyVv2UHKwG9Y3ZFoZK7Hst6jyZ9WF73uHuYIyvhdgjJFJWf0PIuzRIGTSuzZkv9buISZmLNft7uL9gQDZJrLoO9PaPZXTf2gNIGyzFGqYJgz9L3gW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3kP4rXMX2/ig2zizHOPn3u//vHbt9Gfju30sShTH6g=;
 b=Rl++fbedDZ061PkEksSqRSp/AtjgSZEksqbzZzcj9AWxDp7ASInbFOQWUog+C210rmrb3BBg/RajTjOj8c8K7Fi9JCNz1nK8cTa4vcUTZl9kACqMStTDU6W8Iznj4MO5WgqMX3QCKd0bGq+kS1o+cwa22QmuuJKX27zv2ISRkcvj7LlMGIYQgSOywqXjo/pPqgTcDGPJuUIrqD/9ynmWQhW7WdkBupxST6143XsH6mGjTKXxGNtBhD2Yfbxgc1gar87A8fsxPY2jysnNEECSLvAEUWbeIi065rz/DRUD7XvrdyjW+TxmYpwDuuGWfw0YaI6wl0z5IsZSgzDV14AiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:09:03 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:09:03 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZwFtnD/lhplXI/0is72NhiwHcDa/N3dCAgADSDjA=
Date: Fri, 28 Jul 2023 08:09:03 +0000
Message-ID: <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <20230727112457.1422f285.alex.williamson@redhat.com>
In-Reply-To: <20230727112457.1422f285.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: d9d1e8ec-3d0e-4f0b-4019-08db8f41e805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEfgfZtq3DojcVsS1KZSf+t3lq3sTe5hvvMAHGAmNZqnqq0xiSBOyA6WXzaoIQCK87UKg4kB0JuDv8coQa0cx1tg9+rkQYy1C+7iVepfRKH3pnNN1x+J3JyzillXg6V5JJllezZey63UF7YyWTEP9vI/w7i3SXb6cWCwqMwA0ptTf0ZsdWVQtv9URqSySkdD/7Q86V03WKea5XEy8WEI1nxHLwLD/VIbRofgDCjH1x5obF6uEwm9YoG7KdwbDhQZOZjz5dhTm4AvqGu4U1fCtK1/cYcOuwYDOt0tA0CMLND9GXBmBW3f5QizEp4NrrDxLi3v1p0+BMm5RaOHhUSvQrQuAdLHZlxsi9hO90h3AuCmuoucRbt2+2DK1kaD/FYSbXBVytwr/FPmUUFY+IYv8QeF6enwRz+y+8ld66NyI1X1PhW16208Rze73HDJJ+1dgQF5UkrLYugxfPnaxVB2Wi2MhFK6fNhP6XYPQRSqzUCXBCIr1KF/5WvgiVpWlof5T7FYBRR+6ab0L/756O/zbLwZzHGHJTQa1ob396YAyYt6MJM1UQC80XIMTOwcpy9aFg1pUxSw1VxVsi0yWqnwh0Z4UcKJZMwkvXL9mwM6HT12IqufPfQYKHTrGVFIy7Yl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(55016003)(316002)(7696005)(122000001)(9686003)(54906003)(38100700002)(478600001)(5660300002)(52536014)(82960400001)(41300700001)(66556008)(6916009)(8676002)(66446008)(66476007)(64756008)(71200400001)(66946007)(8936002)(76116006)(4326008)(83380400001)(26005)(6506007)(186003)(107886003)(86362001)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xuKeTbLUlTfQqXH6q0RoSWyd3N3tm1JrrqKvyOq9uSGCOkFU235wFdvhnZYJ?=
 =?us-ascii?Q?sGA46OqwcriK9jYFdRVLPgnZJJ+BDZHwG2CokMI9i03D0swDz5uI3US25UkU?=
 =?us-ascii?Q?P2b+FSaS41HC9B+V/dX92A/BasgS9hgBOYuHwEoZ7hQ6hb0LRqJ/yGENg8Fa?=
 =?us-ascii?Q?4mquh5in88C1bdZf2DPlHS95e8ewz3kyo2/ZwTbt0YCuI3iyObVKSBtSjCol?=
 =?us-ascii?Q?Lqwz7edQjRrrt0JcmTIS+Xbuchit03utU3KzBKictAVvQzDlVw66ny+muOEn?=
 =?us-ascii?Q?BS+rHHGI08TgsY8FIu8zQoPYS4FASgKFlV0HZ+ltZZvXpwzYEa+iEgABjIAl?=
 =?us-ascii?Q?85qs3d/R3i7o60KiaHHFaQU2jjTqh0H2bfSZlX60yN+ghPqlocEiRklpGf6k?=
 =?us-ascii?Q?Nf/wpwf9yyLXgATADHdB9nRqShg7cDTdVmn3B/q8yPVDcl4YK7zbBDdgdqhk?=
 =?us-ascii?Q?7KjFYoTsi0MCK0qZHHmiPoxCdsEsRMjCtelkzQxAMtIROfB++UG8oXUGlw5R?=
 =?us-ascii?Q?Za3PROQGIHyVub0sGZcDPGqa1VYUtPxoSvaq3KFNbgZRqgQEo2Runfwh7gnI?=
 =?us-ascii?Q?eYDS7XyqwbsFyHA5TAAO+I4yJL4rJKEtFtvKGARt6bUhleoLqJ2l2biujQd1?=
 =?us-ascii?Q?GOKepL+vpqkRLPpHvKr2tpZsMjMUNq/bAiDM9OKYFjHg/eGXizvv5NL2sj3V?=
 =?us-ascii?Q?QCoaRUqzQ8VZOfDpQyUZYPFPoH/OLRPBYKjtYD4JTKhHZyK6y/3g+NUQkYyK?=
 =?us-ascii?Q?UNFAJTl48HpTZ1hn1LbpgWQ4TN5G1b1H5+QaDeSk8H3EiB8qP2hL1AK4e5DO?=
 =?us-ascii?Q?GMhiZaN36ZPDta+OwOg1kf2xzf6NQ3XU1YVIsLgcsBvg8LSAVEIvAy/yi5T+?=
 =?us-ascii?Q?RyIF9JZm2KgFvQRZgY4Rdr9Yh6IW1WvEKV6Ll/S9P1oqbhfeWTKt4mwTsj8k?=
 =?us-ascii?Q?AClD4DEER2a7HXy4HG1SGK/ysXx+x/vSiR2a4d4Blgq9e858lUhwOBn6arrS?=
 =?us-ascii?Q?zH+2d929MFQJEZ2Ddkynp27Ev+uTxCJ1yQXfYrh6veV2sKvwA+mckfDSnwaw?=
 =?us-ascii?Q?zoL3ThuWerTGXZvi17MBiM0YF0lKR5jKoQ+9fFxneJtIHPj7CuM3hybj9eTH?=
 =?us-ascii?Q?G1JOATy6Y8Mv6GG2gQfOYBnhgyQ6xZ0UzlweoxtOLswTXs9TtVID8OFIHFuq?=
 =?us-ascii?Q?9DrbxPmN7HSZymedKk2kZjixH/zStU+/jlwppxAQokKJ9EI+8zZbayUBwd8m?=
 =?us-ascii?Q?iTzu83hyK7ro7szpDD5FRFdGDurykiuykenI1w2QmfbfmRdsWB8Ijp7Unn8X?=
 =?us-ascii?Q?9aITmJSr2202mA4avCFDZyOEp7j0OHd97qcQkYPIZBpQKKTfURppK1lKs+WJ?=
 =?us-ascii?Q?AoOiGXNUtWO+/A0COCxR+xTFJquytcI4GdJtCJfBLsI60vzlkIysOERLoabC?=
 =?us-ascii?Q?aMEUjy/AcwPByGPkf2epzo5b3jpCXHYUqvg5aDsPBVzoqIvb2kDWAw7XQ4Xv?=
 =?us-ascii?Q?3TW1zwKLlbbcT9VoYiNFC666aITZ+pq3yVaRtd+gERvdq7cqlgICxqRf51gX?=
 =?us-ascii?Q?Oun1qX16iNmcAcRUUbhdWMDPEDaFwf1Oodxz+SC+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d1e8ec-3d0e-4f0b-4019-08db8f41e805
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:09:03.1133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8fd50sZOIwzZ7krWbxZfjpgEb4uPkjUH86s5lWs5xYaCGIjczhV09xCYeUCPsGaz5rjm35j9nwniZZWJ9CekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.43 (failed)
Received-SPF: pass client-ip=192.55.52.43; envelope-from=jing2.liu@intel.com;
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

Thanks very much for reviewing the patches.

> On July 28, 2023 1:25 AM, Alex Williamson <alex.williamson@redhat.com> wr=
ote:
>=20
> On Thu, 27 Jul 2023 03:24:08 -0400
> Jing Liu <jing2.liu@intel.com> wrote:
>=20
> > From: Reinette Chatre <reinette.chatre@intel.com>
> >
> > Kernel provides the guidance of dynamic MSI-X allocation support of
> > passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
> > guide user space.
> >
> > Fetch and store the flags from host for later use to determine if
> > specific flags are set.
> >
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > ---
> >  hw/vfio/pci.c        | 12 ++++++++++++
> >  hw/vfio/pci.h        |  1 +
> >  hw/vfio/trace-events |  2 ++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> > a205c6b1130f..0c4ac0873d40 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice
> > *vdev, Error **errp)
> >
> >  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error
> > **errp)  {
> > +    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) };
> >      int ret;
> >      Error *err =3D NULL;
> >
> > @@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, =
int
> pos, Error **errp)
> >          memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> >      }
> >
> > +    irq_info.index =3D VFIO_PCI_MSIX_IRQ_INDEX;
> > +    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_in=
fo);
> > +    if (ret) {
> > +        /* This can fail for an old kernel or legacy PCI dev */
> > +        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));
>=20
> We only call vfio_msix_setup() if the device has an MSI-X capability, so =
the
> "legacy PCI" portion of this comment seems unjustified.
> Otherwise the GET_IRQ_INFO ioctl has always existed, so I'd also question=
 the
> "old kernel" part of this comment. =20

Oh, yes, I just realize that only VFIO_PCI_ERR_IRQ_INDEX and=20
VFIO_PCI_REQ_IRQ_INDEX were added later in include/uapi/linux/vfio.h. Thus,
this ioctl() with MSIX index would not fail by the old-kernel or legacy-PCI=
 reason.
Thanks for pointing out this to me.

We don't currently sanity test the device
> exposed MSI-X info versus that reported by GET_IRQ_INFO, but it seems val=
id to
> do so. =20

Do we want to keep the check of possible failure from kernel (e.g., -EFAULT=
) and report=20
the error code back to caller? Maybe like this,

static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
{
    ....
    msix->entries =3D (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;

    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
    if (ret < 0) {
        error_setg_errno(errp, -ret, "failed to get MSI-X IRQ INFO");
        return;
    } else {
        vdev->msix->noresize =3D !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE=
);
    }
    ...
    trace_vfio_msix_early_setup(vdev->vbasedev.name, pos, msix->table_bar,
                                msix->table_offset, msix->entries, vdev->ms=
ix->noresize);
    ....
}

> I'd expect this to happen in vfio_msix_early_setup() though, especially
> since that's where the remainder of VFIOMSIXInfo is setup.

>=20
> > +    } else {
> > +        vdev->msix->irq_info_flags =3D irq_info.flags;
> > +    }
> > +    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
> > +                                         vdev->msix->irq_info_flags);
> > +
> >      return 0;
> >  }
> >
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h index
> > a2771b9ff3cc..ad34ec56d0ae 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
> >      uint32_t table_offset;
> >      uint32_t pba_offset;
> >      unsigned long *pending;
> > +    uint32_t irq_info_flags;
>=20
> Why not simply pull out a "noresize" bool?  Thanks,
>=20
Will change to a bool type.

Thanks,
Jing

> Alex
>=20
> >  } VFIOMSIXInfo;
> >
> >  #define TYPE_VFIO_PCI "vfio-pci"
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events index
> > ee7509e68e4f..7d4a398f044d 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -28,6 +28,8 @@ vfio_pci_read_config(const char *name, int addr, int
> > len, int val) " (%s, @0x%x,  vfio_pci_write_config(const char *name, in=
t addr, int
> val, int len) " (%s, @0x%x, 0x%x, len=3D0x%x)"
> >  vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
> >  vfio_msix_early_setup(const char *name, int pos, int table_bar, int of=
fset, int
> entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
> > +vfio_msix_setup_get_irq_info_failure(const char *errstr)
> "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> > +vfio_msix_setup_irq_info_flags(const char *name, uint32_t flags) " (%s=
) MSI-X
> irq info flags 0x%x"
> >  vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
> >  vfio_check_pm_reset(const char *name) "%s Supports PM reset"
> >  vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"


