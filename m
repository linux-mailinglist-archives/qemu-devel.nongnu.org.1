Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26176AA3E
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 09:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQk5K-0004Hp-Ek; Tue, 01 Aug 2023 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQk55-0004GI-B1
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 03:46:15 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQk50-0000wy-FS
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 03:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690875966; x=1722411966;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vp/920SqWoy4sVo0YMBWUH6iozKNgt7f8W+5dPW9Ozw=;
 b=dRkpKpPn8HVjh22IlFH8HvLduhVsGH8q8QSQUJIqApClhoxESKtum0SB
 L5vrjMioA12xhwbY+b1zKPg+mqADPVivXl5Yvkz9We37xpYzFME9UQUTL
 Ob4on83HPJhH1lMiIjKwstMuZJY72LXOLw6ELxZVHHuucvFcc4Q2JjDrl
 eLja2zqOD4hjZHM6tCJqhLhPqIcb3oy4e/THJo0xDx1TJxTBSLUNfaCQy
 /qaI53icypqgUEGxc9xFYBNSJRJXGPrLXOgqx5TmB2IxtON/cYIPx1O18
 GHpnz5bT1m9tbTg7ggYXu6s7V2Ea05WK6UJeHU0Iec1eQEYYdwgnmtzee Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354160636"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="354160636"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 00:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902472404"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="902472404"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 00:45:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:45:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:45:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 00:45:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 00:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRmjnqawbpg7bWoMfn1AM0ScOGL0j3Uq03I1nOw9e84tgR1VMlXvzVWvCZPgPllEeYFxkexlTr355VIqnL+2MLXxQHqEupWPTNHl4f3N5blWSWwnPLNL8n0LZZ/Ec6bjlAzcioeeDbiv6jXXF2tVAborkdcgWfm4QcBL9ln83uifpx3JrdHUISU39SOhgNskbtdslarNhD5q5Q/IKUNG9qvW8E7EE0sAb8V5jo8J2Aq+dhyx4+xV/z34Tejm9V/xXhtZcXho/psgGcDNjiRQk1pIKypJ5HTQ8RjHFU4IVvmSvoGiNEaMXBgG4kZVcuvp3ri6R5mveklhzsKq+K7D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FylWwIjOCs/jiSZINioe2j2F0TOmnzgRdGWrVk2DxBg=;
 b=V3ftlP3I+xpHDzE9eMdy0voURvMvElPCRBPNnaR6gQeu4pURLR93AoV/HVN5E5iefga+qVv0VMt9uthTgOIi2p2nWoAzNh2seBIP5IRfkWTIz8Dd+AmGDPD6jsFhoJduulHFDPwVINX0QJCENvn471NdKeQ5cmooJRWGuTLQSai3mZSteyT95Bik9SWzThh7/phOCNqYJ1yrmjJfbFW0QJ8nMs8s8RLGIUBBaTg7DVEb1GOCuQG22gvM/NKsMWWbwKevImoHzD2FBCxnGCryhvX0RMZ+otqUQCvasSBiD6zURjBszXkJ+HC8KpHnCHSm6zW7y6YnKOtjZZFd75qCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 07:45:27 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 07:45:27 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 3/3] vfio/pci: dynamic MSI-X allocation in
 interrupt restoring
Thread-Topic: [PATCH RFC v1 3/3] vfio/pci: dynamic MSI-X allocation in
 interrupt restoring
Thread-Index: AQHZwFtrUu2LeYdRs0SXiuThVPh3e6/N3cSAgAcGFFA=
Date: Tue, 1 Aug 2023 07:45:26 +0000
Message-ID: <DS0PR11MB811453C2F5ACDA863932AB6EA90AA@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-4-jing2.liu@intel.com>
 <20230727112447.4f9e5bc8.alex.williamson@redhat.com>
In-Reply-To: <20230727112447.4f9e5bc8.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|MN6PR11MB8172:EE_
x-ms-office365-filtering-correlation-id: a3fb9a86-fb81-4bc8-86a3-08db9263454e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ErUpZmR9/2H/dMImFtVSil0FP4EgTY3su3/kLwf8HVBbeWrtDQnDRaRatDKsi4dW1BMmt4jjyXxOunMsB7KLR2b4FlEDG6mFPHNmKkqr0Bb/C077NMUFi7BoaUdks43yMS+RSWf+JgrHQSeycWFeX4KU/FNRi2PbJ5trT7S13EQVWcWZRgfPZi3k0eer71oxBJ0vKemNy7a+ey8MjwBThV0jYBsLwBpfkewvwIZKz6TSzvck9m1D93rcYowExHY3KEp6gjJDMrKnoATQFx+a5jGf8YGsKn/jJcc7AQBsSSL3lN41e01I+Lf2y4GuofklfJ8CVi3EVbkyJvaA+ZxoE/8LTeVMy8YWEGj1Lt5213gR/qF7EDBXcZbIiKA7yzE8DFqEjmHCoxWzcVetjBdJTyxsEjH/SV729QeK9muDDiD11Kl4QrgSIabIF5nsvqMcmegQOTU3qKH3vEw9JEiYAWPf2F35CgLzwzFA0avi4kuef9hPlefvZqj3W2EN5WgPpSkmAOn+VFVtDnHg92n9mYnkYoJWnUYrHtgL6o+uggHS0H90b/GlL0h7us5uxnbkc3AQcOVZO/jMzqkIBW9zAx5/9BCoIpJ2hABEorfBDWt2LoSEmwaApuX4xGVOjJO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(6916009)(122000001)(26005)(478600001)(186003)(316002)(4326008)(6506007)(41300700001)(107886003)(55016003)(82960400001)(9686003)(54906003)(7696005)(38070700005)(38100700002)(2906002)(52536014)(83380400001)(71200400001)(5660300002)(86362001)(33656002)(8936002)(8676002)(66446008)(66476007)(66946007)(76116006)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJ3gF0nmwXOgBxV3ftsAz51SZqMv2rn59+g8C4aHsLgWQqgiwMgP7ONrzK7m?=
 =?us-ascii?Q?bTkAhRRuPN3a7J5nT2rwhTgTl8WallpPljpHlhnxyGFSDBk+ZgPXJVVXopC2?=
 =?us-ascii?Q?/6xPNPJWoJNDSWUJ1rg+2abiprM6x3FPQsLkVvW2OWw/zAN/ndhi3zdX1lrx?=
 =?us-ascii?Q?92X/Q4Ws0M4nSHsbCuKsimdqk9AsMqwCf5rLzavdZOP69JTq22ZqTGsMNPob?=
 =?us-ascii?Q?Uo+8Agw6WOIsyrJZgsvXmiRu2T+JeSk8hz1G3jucw8z52EvTzIpQIoriHCRm?=
 =?us-ascii?Q?bdh5cCi4kID0eAJZ70d8Pcx/e5rNz7dNuT4dcCZSUFATCUQvKG5USBfTkokU?=
 =?us-ascii?Q?5emE+p1sX7CTWm459YVNdUCGdRmTQskicBRHvimD+pUNvW/OVRhsSL9UFPf1?=
 =?us-ascii?Q?z5t/8UQLlmFQoEsK5skueGCWAhQNwBFnBs2OhVFEdoEy7IaGcAUCGI2azNKV?=
 =?us-ascii?Q?aSMQNsOeVb500wszqSahbtsw2J9ivwJI66XavRNzzUnbfVuLcYB7BnwQAHAB?=
 =?us-ascii?Q?MXuB9MJIiDuLXvQVHpUR048TkwVHwqjX3o05hEU9vrZjrcy4Z1ZCk3qUSEmM?=
 =?us-ascii?Q?Z5OI/2sBIbCAfqDgEkMQ9A+xynD1NbyL0z8FlT+JAEM0Wc0T3L3jiOQyERR9?=
 =?us-ascii?Q?JcsFnYgjFk4m5AC/ez9flRrP6wZ9Ejm9P+chcwcovcSXZt8Bp4rcRuyTH5Mm?=
 =?us-ascii?Q?LIWWi52jUbrXEkARiiVVi/dEATLLgjz+A37g9QFafZOpN4INh/ysg3H0r+gj?=
 =?us-ascii?Q?xWeQIjZeKi0iU9XsJgWkLKLi0C+UwpA73Q/vH699lWxTzPP7Fi6enKMy0JUN?=
 =?us-ascii?Q?TK8neWfK8KNueqQ4IYl6OVxr+OY1cydHAnyhbTbg5X8z+AUXUecAXh/qYyCm?=
 =?us-ascii?Q?x4kdBan+nKrdIDcb6gmBRpuLw7h4K5q2NZkusDfHTy0P/b0kvSbRtzSq8n8k?=
 =?us-ascii?Q?45bQGiu1VVuhVH6nu9FpuS+os0NhVOpagn6QXv3xs0cQohI2UxgNl1y5nOQp?=
 =?us-ascii?Q?lNwv8Nm2pZEmt1VlS7E3Sz0jMf1YvLD4CzLH+EZlmgRsvJZ3DXHc5Uzz6JKL?=
 =?us-ascii?Q?sFyjDc1kpOv9XVcIZYKEPL98Ycww5lni/8IyXYkwvCFmiTGj8m48v+gug9Yi?=
 =?us-ascii?Q?gKarwCwN4rQqMcpOiTq+V5vsDzNNm0FsVtz53aPM3qtRbsWtB2a8gZc20/sF?=
 =?us-ascii?Q?ZnXaoi4rQSsobkXqlWz9wEu9buF+HiJ1owuzxbJniXZA9qup5hgRcvpyHDcR?=
 =?us-ascii?Q?nez2jLB+38BtuDjBSwbVmPrVsxgyisu8TcB/wD2HzBBDlCr9NI61tn9Zb/Zs?=
 =?us-ascii?Q?RotX36kWw69oqPVBILuwzwzrpSIkqz/wECt7L9P6r+liQopbDQQM2H0RQ52F?=
 =?us-ascii?Q?yqwy34xnSnKwMayVm5rvSlVUQ0Z7wnmX07d4BDoC6X0kAihUp5zpYVKoTdCk?=
 =?us-ascii?Q?NO4Bgi50cyd2EugaEQ35BAhnHr0Fr2X0P23SueLcAwLPh7TDd8jIY28alS6w?=
 =?us-ascii?Q?y3mz+WP0riGRwmNUjUxMzXwCfrmOCZxR0jYsJDduroKc//4p04xO1eiHgcYh?=
 =?us-ascii?Q?Pr+PcaO0DMvVq5g2UIxPeqgU+uhfThYkOFZokLzx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fb9a86-fb81-4bc8-86a3-08db9263454e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 07:45:26.4641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S390gtAblyllNcotg+9E+JeYVNp4WmC9Yzealtp4I6YKfw4F7FEpT9KA/7OU8MSXiFqhK1e0F9cI2hMRFAsLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126; envelope-from=jing2.liu@intel.com;
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

Hi Alex,

> On July 28, 2023 1:25 AM, Alex Williamson <alex.williamson@redhat.com> wr=
ote:
>=20
> On Thu, 27 Jul 2023 03:24:10 -0400
> Jing Liu <jing2.liu@intel.com> wrote:
>=20
> > During migration restoring, vfio_enable_vectors() is called to restore
> > enabling MSI-X interrupts for assigned devices. It sets the range from
> > 0 to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
> > guest. During the MSI-X enabling, all the vectors within the range are
> > allocated according to the ioctl().
> >
> > When dynamic MSI-X allocation is supported, we only want the guest
> > unmasked vectors being allocated and enabled. Therefore, Qemu can
> > first set vector 0 to enable MSI-X and after that, all the vectors can
> > be allocated in need.
> >
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > ---
> >  hw/vfio/pci.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> > 8c485636445c..43ffacd5b36a 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -375,6 +375,38 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev=
,
> bool msix)
> >      int ret =3D 0, i, argsz;
> >      int32_t *fds;
> >
> > +    /*
> > +     * If dynamic MSI-X allocation is supported, the vectors to be all=
ocated
> > +     * and enabled can be scattered. Before kernel enabling MSI-X, set=
ting
> > +     * nr_vectors causes all these vectors being allocated on host.
>=20
> s/being/to be/
Will change.

>=20
> > +     *
> > +     * To keep allocation as needed, first setup vector 0 with an inva=
lid
> > +     * fd to make MSI-X enabled, then enable vectors by setting all so=
 that
> > +     * kernel allocates and enables interrupts only when enabled in gu=
est.
> > +     */
> > +    if (msix && !(vdev->msix->irq_info_flags &
> > + VFIO_IRQ_INFO_NORESIZE)) {
>=20
> !vdev->msix->noresize again seems cleaner.
Sure, will change.
>=20
> > +        argsz =3D sizeof(*irq_set) + sizeof(*fds);
> > +
> > +        irq_set =3D g_malloc0(argsz);
> > +        irq_set->argsz =3D argsz;
> > +        irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> > +                         VFIO_IRQ_SET_ACTION_TRIGGER;
> > +        irq_set->index =3D msix ? VFIO_PCI_MSIX_IRQ_INDEX :
> > +                         VFIO_PCI_MSI_IRQ_INDEX;
>=20
> Why are we testing msix again within a branch that requires msix?
Ah, yes. Will remove the test.

>=20
> > +        irq_set->start =3D 0;
> > +        irq_set->count =3D 1;
> > +        fds =3D (int32_t *)&irq_set->data;
> > +        fds[0] =3D -1;
> > +
> > +        ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS,
> > + irq_set);
> > +
> > +        g_free(irq_set);
> > +
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
>=20
> So your goal here is simply to get the kernel to call vfio_msi_enable() w=
ith nvec
> =3D 1 to get MSI-X enabled on the device, which then allows the kernel to=
 use the
> dynamic expansion when we call SET_IRQS again with a potentially sparse s=
et of
> eventfds to vector mappings. =20

Yes, that's what I can think out to get MSI-X enabled first. The only quest=
ion is that,
when getting kernel to call vfio_msi_enable() with nvec=3D1, kernel will al=
locate one
interrupt along with enabling MSI-X, which cannot avoid.=20

Therefore, if we set vector 0 for example, irq for vec 0 will be allocated =
in kernel.
And later if vector 0 is unmasked in guest, then enable it as normal; but i=
f vector 0
is always masked in guest, then we leave an allocated irq there (unenabled =
though)
until MSI-X disable.
I'm not sure if this is okay, but cannot think out other cleaner way.
And I also wonder if it is possible, or vector 0 is always being enabled?


This seems very similar to the nr_vectors =3D=3D 0
> branch of vfio_msix_enable() where it uses a do_use and release call to
> accomplish getting MSI-X enabled. =20

They are similar. Use a do_use to setup userspace triggering also makes ker=
nel
one allocated irq there. And my understanding is that, the following releas=
e function
actually won't release if it is a userspace trigger.

static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
{
    /*
     * There are still old guests that mask and unmask vectors on every
     * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all o=
f
     * the KVM setup in place, simply switch VFIO to use the non-bypass
     * eventfd.  We'll then fire the interrupt through QEMU and the MSI-X
     * core will mask the interrupt and set pending bits, allowing it to
     * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
     */
    ...
}

=20
We should consolidate, probably by pulling
> this out into a function since it seems cleaner to use the fd =3D -1 tric=
k than to
> setup userspace triggering and immediately release.  Thanks,

Oh, yes, agree that uses fd=3D-1 trick is cleaner and we don't need depend =
on the maskable
bit in qemu. According to your suggestion, I will create a function e.g.,=20
vfio_enable_msix_no_vec(vdev), which only sets vector 0 with fd=3D-1 to ker=
nel, and=20
returns the result back.

Thanks,
Jing
>=20
> Alex
>=20
> > +
> >      argsz =3D sizeof(*irq_set) + (vdev->nr_vectors * sizeof(*fds));
> >
> >      irq_set =3D g_malloc0(argsz);


