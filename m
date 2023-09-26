Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67CC7AE57C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1D1-00021v-Cs; Tue, 26 Sep 2023 02:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1ql1Cy-00021P-1R
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:06:08 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1ql1Cv-00027m-G5
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695708365; x=1727244365;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0831xKbWop+B0lkCFIp+BeKSMYvUBzue1XZsQGFt5Qs=;
 b=FVaMY2qT5jHyVAcNEpj22g9pwRre5TkBNerMkQQeOpDzm2O7iisWinjW
 X/997iGS7Z3oFqIrDW47svfXX9w8bHaXN241LRU8Uf05qVweMjUt7+Xvj
 +FsVyLd35Z+eT6u248mH1lmbeJC8I0Uow2+WfPf7mtWLq8qJ9h2WI+fiz
 J8awVhGeHpok85n1FyRen6Ty4wf8b4m0amwbrv4sO+aKLAPZrS31uxIih
 7NMqoJSX3SepVK4/kifEvHFLPQ7/Adq/Js8ikCMGkmlasJ6z0E2FeKOhF
 zPe52iE4rg7F5Hecii6Gv61dvn9LmzuPwVRdU2fnf3F/e4OddQSypp4Ys A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366553461"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="366553461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 23:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="742240488"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="742240488"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Sep 2023 23:06:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:06:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:05:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:05:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coY0jhC0ouR2RAH4ttazGa87JJZJ4fMNmQYPej9bBBX1bqMvF9U9dhlkH/o7kZ8BA/fFdyXqraqrIo0bg1DPGfKMXbUZ/nhHAUXVS7teHAdUPzsMYHEp+ObPrlcyRC6nhUBPaDToYgGrXrB4Kcn+nJGFhY8qESBIUs7iwIveQOfVVQgYp8Zh/id57EgW5TbFfV5P9Wpl5rMmhBNGp2KY9dK0rwkWLa3/LmxlqjCREnLPfmp3eP4u6DOA3qjWuQkuqLl9OeJnK6Fr9Hjx7cYQ0KkqB3Ljn8fBMcVuxD4/RUI2UB9vG/bJy3ws/W7UYhPGgcD0qyHapcHYNeYOrgrLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys8m3Dw+aHujiEwYm1uW+L+CGxmA+8TnOs+UMgZTKH8=;
 b=QfGH7zb9z/1J9E+q9EdYhN06uinGfXFp3AtXQsEH17EJ0Vb9FfHP8NnD1wlCU41BYI1XOIT68EtzCmRkZ+xEryzFHLOLPnK2kfP3D2bHqeg3x+84vOJQuDT0R0LyMXAntuMciA8jFtMrFlw1RIn5gV+w4MNzANtYZyf9P017Z0rpR2rJdGWUPHq1OCeZP57QOsxjXQT7uFkN4PBX3N9W9/3KMM/FR6B+hl3EHygpxzwtwNM9z1Q9bssXBCSETEkfG4i8ti6kljOfmh1GD12c/0H2uzbBQK/IOXt0Nwasd6dsVW44zcLj8gXDEVCmHC1wtoNClTEmn18jtmpGbFG4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7972.namprd11.prod.outlook.com (2603:10b6:8:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Tue, 26 Sep
 2023 06:05:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 06:05:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: RE: [PATCH v1 15/22] Add iommufd configure option
Thread-Topic: [PATCH v1 15/22] Add iommufd configure option
Thread-Index: AQHZ2zBBp1o1gy3lfUOBiU5RyGM26bAigTGAgACxWACAAJCNAIAACMOAgAADKICAAEz8gIAAAzGAgAAH2QCAAAC5gIAInwCw
Date: Tue, 26 Sep 2023 06:05:57 +0000
Message-ID: <BN9PR11MB5276F44573802C507FD25F2A8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
 <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
 <20230920174919.GF13733@nvidia.com>
 <20230920121724.381716d4.alex.williamson@redhat.com>
 <20230920181959.GI13733@nvidia.com>
In-Reply-To: <20230920181959.GI13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7972:EE_
x-ms-office365-filtering-correlation-id: 5924a6c4-c4d8-42d4-545e-08dbbe56a66d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLFD+zx0drgcESdNKR46D3X4fRTc4zDLULNl7m3tsUoulfv4a7LQdt6b+wTBU/aVDZR83zikXi3gVJw9wLjXzA9i5ir+4U5IGXK4ciMRTIKNWDSGpQ5DPH5r3PVFrKb+DKCJ4halw3KRMDpxvGa4vLfi09AGP1SaAml1sxMTSTVVR8L55g1psPwJ2efer0ebw4z85Vz2e4t/z2TbxkcHiRa7n2HtCpykj1yb75lnEfp/6Tjzy9Uf0KmhoIcbA5KfYPTswwipzvFklJ96gXzVYN2f5b8FCsHiTpbS5N23ruobTmlbnMJDMrol/gw9bR0Q/AZzF1uEXRM3h8NR5HfWWtaGmjFVkxGRkNUskKIGs+K+tlsL9wNp+bBfueFPoYapspVY2qfCwYSzlp0ZVyYV68cThNFgo3Dl6xirzOvAfGtRUNbXtkkO511fgh2lIkdCB4UdTXYZZgV9U+Tr+IC6ifMRo8TphewPWuJSfjnZLhTnR3eDf+hh4EsR41aMW61e3KXLKJE8pjVvUH5f0LJQuvWtDBLI6TXbSQbsk19H5uR9rexoMy0oG+R4negwpK1/NghfU12VMt6tChNz71JaBGKkj23YGOuJT0tQsA6XGYfuqGy+fyzRqQP7y50MVQsF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(9686003)(7696005)(66446008)(26005)(82960400001)(66946007)(76116006)(66476007)(33656002)(86362001)(66556008)(110136005)(71200400001)(478600001)(38070700005)(38100700002)(122000001)(83380400001)(54906003)(64756008)(4744005)(55016003)(2906002)(5660300002)(8676002)(8936002)(4326008)(7416002)(41300700001)(316002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0HdrFE4stW4C2VO2RGCF/R+ozhwt/I+CwOYoLGW67enr/aYa9qOBiv2o1g?=
 =?iso-8859-1?Q?Vt2D5ijjNepB+lwgl8od8u2rL4V2ondfA03ZAEQWi3b/fDYH+/2fTJ7lkO?=
 =?iso-8859-1?Q?XSCStDUSOr5LtxxfP8sB9a36qRYJsHjIQtu7ivEe9DYk0dShSM8L+gScdd?=
 =?iso-8859-1?Q?HbndW8w5e18YJFUQUDJFP6vO924GBwyJW8jio5SanGh3GmmJZPEqykrfzI?=
 =?iso-8859-1?Q?+V3+sT7I5ObNUe24YSf4Scfas8vZEVaLVuqCe3Zmex0vW59H/QJL5i/Y4h?=
 =?iso-8859-1?Q?5l8Mq5QNAeTEkU4gFcVsKjtOnFZFYsLiKFIEANWC3Zo1RpRTJpfyFSFRSK?=
 =?iso-8859-1?Q?WM4kxEaeE9Rp9aXPKMM89jObuzC9dN4HwwoSU+tz5dvE69z0rxGxehdUX0?=
 =?iso-8859-1?Q?cdMnE1FBL2/LIs2ACgOJY+bhz4CnYUdE9Vm0ULbSHpfFD4cUOiNTuOj8Rt?=
 =?iso-8859-1?Q?msTir2QiZFCqkv5pMhySzQQ64UfoCaWi8oVp9/LCHRPteY341BxkPxMkYY?=
 =?iso-8859-1?Q?aSWQROzgX/c7yZo9v3P2rfTm/30R6fkIZZfuVdbD4ypt0XI2E/yAM26q+w?=
 =?iso-8859-1?Q?Nbjgv2A/7oBjhVHje4BSv0jLdiJTzpcCf8wnA6xXHjLybx1zPQQE6GGSUI?=
 =?iso-8859-1?Q?S4rnlxnlsjMlwtmUj4eHFpsFEjKIzw/mo+m6h+0tTRxHLQmQvtgDFm3hl/?=
 =?iso-8859-1?Q?C9vqPQVb647xEwJK8EDABgRsHAV37qBtIuiBRc6BaDCpQcafe4P5/jiIx1?=
 =?iso-8859-1?Q?KWfoYUfJMGvCFV9UDilqr5u16P/KlJANRu6Iu5uxQpvfx6rI0zI5siH4hl?=
 =?iso-8859-1?Q?TecURQ9Ll4MubIVgAqXPKjjNrrmhV0Y3hOPIVFse3cbcHOwKRbcVISZRNr?=
 =?iso-8859-1?Q?x3fBg7Dp8Iy3mZ4zq/40Hi82PJTJlz+/S9nid2RIUFRRhKVxf7VuYnX9gq?=
 =?iso-8859-1?Q?UkbHcm64ilhk4sq/iaQ/J3Rqyrw/omHHbYizXGC3GgwsuYMLXmED8wLpgt?=
 =?iso-8859-1?Q?Q0zupFGsSOFzMWNCNYnAb5mtOWi4u68eQrFryxV9EpXd3X8MWi0L61g/BM?=
 =?iso-8859-1?Q?zahiubEqzgSAkcJBLilol1lEu8PwGRNygK2xA8RthaR9ejZ5+8tYExW6Gw?=
 =?iso-8859-1?Q?R1voODmBGKedRInHwiE3vKQtIKQWKwM3j+SWW+HLezWWntUMv00xA04QQ0?=
 =?iso-8859-1?Q?4u3psUHwVzkfg61r410Q4mZmYngZmm12T5W9CZGFWcaFc12+FPmqwcLwas?=
 =?iso-8859-1?Q?OehLjb7MKH2dvinxc1v/i3BcWXDBw5QhPcfn8vmwTf91HEPy1dIMTiWEhd?=
 =?iso-8859-1?Q?8X5CDjRrs5s95XyJvTHUl73i87Uxo2RfbVG7sRRUdQCmAAVnuIub82O80V?=
 =?iso-8859-1?Q?uZqVgDxXEVinivGVgWkFM3FN3GCOb06KS4cwQ+TMdEZH7sQLlag08RELG7?=
 =?iso-8859-1?Q?o3vjRCahOQ8sqqg8hDdmIFGS0IeZPM5o19ueAEx5VADO28xZU6AjRNUxZV?=
 =?iso-8859-1?Q?tddTLdU+c7zm6HK01/G+/nfuTkFhdzKdnOSWEkHoPa+a5Yq+EKUcwhx8Ct?=
 =?iso-8859-1?Q?mI83vzBt0KegayfOM1aUI7HRgKAij4s5OldvIDIQWYsuN8XVgX96g7pksk?=
 =?iso-8859-1?Q?zYLhq7MnY2sPROFMbjSdzECw1cQ3XqmWM3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5924a6c4-c4d8-42d4-545e-08dbbe56a66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:05:57.1169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJv2sf9Zv107f3HtVCaldT4LXLRkbEmOV7OdRjpEhkRLP64B+50/DZGzJLWw4tE74iyW2vGFJMZG6TZtiQqLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7972
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=kevin.tian@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Sent: Thursday, September 21, 2023 2:20 AM
>=20
> On Wed, Sep 20, 2023 at 12:17:24PM -0600, Alex Williamson wrote:
>=20
> > > The iommufd design requires one open of the /dev/iommu to be shared
> > > across all the vfios.
> >
> > "requires"?  It's certainly of limited value to have multiple iommufd
> > instances rather than create multiple address spaces within a single
> > iommufd, but what exactly precludes an iommufd per device if QEMU, or
> > any other userspace so desired?  Thanks,
>=20
> From the kernel side requires is too strong I suppose
>=20

Agree. But with limited value let's stay with one iommufd per qemu
instance to reduce the maintenance burden.

It is also more future-friendly towards nested translation or the
need of centralized PASID tracking when supporting SIOV/ENQCMD, etc.

Supporting those new features between multiple iommufd's would
incur unnecessary complexities.

