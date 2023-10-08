Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B634B7BCDC1
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 12:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpQuR-0000tC-9z; Sun, 08 Oct 2023 06:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpQuO-0000sq-PX
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 06:21:12 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpQuM-00015k-2J
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 06:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696760470; x=1728296470;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=4446nBHPz7LvdnARqKb/CAsKlpJ49R/vSFDlTQsiacQ=;
 b=GJ2XFIhO0RJ9vIWPfMwqlegPPhPiOZOmtxLPOY5jHY7Qk3eRGKjEWZ0D
 fCL36pUYI2+ITZkQ65QjwptpYOLBh3MS+OhRhEw10pa2IIu9uq7gY4Lfo
 a31lUp5dF7DMgmiUnuEw1L3IVckcvPwGAKvo5UvLCpFm8dRj+gb9vfPOZ
 DJJJA2oEtIQU0m0PysJt1jZUR0N4AYpFKmNYS5DZ/dSEp7g4XlxfKAR94
 aVGtet0AMTx5fyXRmNzjHXdgCW3KrHxA/kXV1LSkaErTRnhfFnnrXd+gq
 MRJpHRAj2j0mM/nHaiUnXcfeuX0Swh5FsJORXFkKb3+mwdQOr8Q5ZyWsl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="369055916"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; d="scan'208";a="369055916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 03:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="702576426"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; d="scan'208";a="702576426"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Oct 2023 03:21:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 03:21:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 03:21:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 03:21:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 03:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdz5GnJ54kh/Jx/T0J5/QjwbUog27qJBnelBA8NNSc3RIekNkIxWrzpBsSaRbhyxmnYGUUSWwryMPm+7aB/r4APVRBDB96D4lWI+9JcEwxxzxSpD6aTk3Ad80i1DNlWiAllhCfgBuFIU7/VJHJewOn/0R7tHj0uiFB+5PFdXoV7i1//bUsvuPwjZCOTKG0uXx7dNz8ukdRmKHeGtdf9ry6Vxjzg3GNOquXZ3UUJf7AVlJ3Oll4m4JR58ISWWMpHPrXb6v6sObTXiyQDTq6EKycWeDRkERKvFkn5SYYLEEEpEvIva1HXhyv47VXutNCjxgd3W54wcjI8aLXM8MzwfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZmU/jH+fJ550Cyc7vhKOVz8raoySYOkRMYSVBByiuI=;
 b=EBkfRSlGERDp7xPT4H23nFTiatWRcHcRreFQRKlhdzF7DXHjBoAZB6JbXIRaLqlDnb079R2W89g0ZZGLU8e2dNVG05vpmooTXw1ScC7vqbMFz7rtU6YWC58KFqsCYc7rRlm+xz7o5GwynmpMFZ+KDpSP8Uvfi/5ZDwksRNNhIRDtwOR562smjRMv5f1aPRQoUaulfVhqxXWpKEW2Qt2BfgIgUiakiJ5/Y9J2QUo2d7nVXzTRejMaTPCRp3X45vCfL2Ay2BoYdNi5h9WkmN/ogH3u7hDmXYuKK/zojxWVeBOz3RiPV15Xi2BzHYUmu9G7cmRFW3AV99T1+5Xb14yvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:21:02 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 10:21:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>
Subject: RE: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ9tnw8//L3Tx/I0evXiAMnZMSkrA/ryVQ
Date: Sun, 8 Oct 2023 10:21:01 +0000
Message-ID: <PH7PR11MB67220561760B1AE2DB9277AA92CFA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-11-eric.auger@redhat.com>
In-Reply-To: <20231004154518.334760-11-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: a06290d6-c75f-463f-7aca-08dbc7e84586
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 604bC78a47pEdt97Ae/SiB6auWmuwknLLAdmHn1AzzNYYO0nhUlSa5J/Lte8cUzFvZcGS/gCsWXDO8IeDJ7W7EvFE6EdL23kIKBu1Xf1lFSOSx8Fcvj4Mlb6ZWNWK8M9aDlGCRCFQBHrIkCuvl9wsMtaitqjFCxN094IqNI5xxF+ASFxRv6HE/eA99tpvTCPaifSECOKYTzjwO83pIROBBrmJsn45BZ4O7x/DLi3FVlZBUZj084dmJAKp9LD+4G9ZTKNaK3KFA/apNJXE/XEMHpBcqqNlT/pjYsM0YBksLDrXBfjSHyN+tDb89shqpCO7o7yCOi3mQIgQ4BB86BkbslzZP7l7VBPBK5fqQSaAuqTlCnXJp4trxHSw7nGFmPsG8RtvEMDu8tmsPEXRx1H4eWe5vYVf0D387sK1Kh6SLoQGdNR00s+GESplVF86lcZYK9kRiMuFHXQGN08lGEGduasbQyvM+Q0HHCTAIBMPF+aQSMRo+BhQSO8xcxTDJvUpj6c4iRitRvNDLbBKs6kHxQsZf4hCpdl56Y8xQpVljXyuiXz6H0xku6EKh7NfFSh5Jc9yksfOr15HKA8G40fe47Xezb2Yc213RRmD1IOo0uDXBMFZaptOQ9u4kCFNpMB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(921005)(38100700002)(38070700005)(82960400001)(86362001)(33656002)(55016003)(2906002)(9686003)(478600001)(966005)(41300700001)(52536014)(8936002)(5660300002)(8676002)(7696005)(71200400001)(6506007)(83380400001)(66556008)(66476007)(316002)(64756008)(7416002)(76116006)(66446008)(110136005)(66946007)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJq1er/9HLHXxNPqFLME0P/tsCDEFnNvA8ZYugyMf/pc0odQ+0GZJ8/HvPV2?=
 =?us-ascii?Q?/sr81ArG2ZWKDK0jhFI8hiRGjGcGqL7IZm1SYnKSuQ3XDzHsSexFvOaDaAbP?=
 =?us-ascii?Q?JDCOKKumblJJ42BzJUpNPh4YC6zx6moI/ZnaO0YHGUKOVw6cNppG9wHuQI24?=
 =?us-ascii?Q?xOIV7zRevoFDth4f/UvuYI6VTroCNhE4+E2APrFct7DKcCqnYLeACxlB25j1?=
 =?us-ascii?Q?pVaVM0ztobfxzMjkBKekAWXCKG7yfczZKMufAmcMuEgRlGPc4fSMFENOq+3m?=
 =?us-ascii?Q?93WXM+wlOgKyKER66EbFFvVKiY8Yf57ffiSmCB9d1TNdasBVZnccAPBHCgan?=
 =?us-ascii?Q?HRpgVKQv8GIJsm7nD6l/zIxCk9VRaTH7QWwi7rI2jmzemohacmtSPAFNHNLQ?=
 =?us-ascii?Q?7QHJEfRqtnTMKTzYOCpXyVqKye9wtm9h3AL4UduMpE0xXhxm7X2xjviaxA9G?=
 =?us-ascii?Q?O6cC4CR4oOX7YozdvK6E9i3SaPG2sz2l4jPKRYU0LqLtQqoi/3ylfJuTxHuA?=
 =?us-ascii?Q?BEEYsV0NSF7zbcFy8rpDUhRu3K3SZ6k731Rgggl0guJgzZ/S5+oSnXA7QMJC?=
 =?us-ascii?Q?9gUBPm+7yqldbqZ/Rzf3E1jfVdD8lqtt2TSKcnsI7UN8TtR1jPHKUOtbZvoD?=
 =?us-ascii?Q?yU6HK1nKXnmB/By74V7C+ZZiKu8GU88CTXHeV8GRCFABdCFpeeXWZcQtA48I?=
 =?us-ascii?Q?Zj2iYJGLqvjfV27WpFF+eRExssWD2aBLeAiTiA6hFxnCFM4WNuA4dBfo2o0J?=
 =?us-ascii?Q?jmJLNFzZpVm6ig1Oju5vyerEmbpcnJlwmHVOz9xgghV9Ow3nHtEFbfuDcdzu?=
 =?us-ascii?Q?5lh0vP5+/Gj7OTDUwHKoBvHxATXRWX+3NAZ8aaiaY8RuvBviQ80Ytkp0xfOy?=
 =?us-ascii?Q?CA8CfuexUTx3i0k0/OTCc4A7IfTW8amn244vbXo3QcXIukKDQxJi/mcIsa9O?=
 =?us-ascii?Q?CS/9eKL/q8fbKZjvNd35FBWcCggr8orylnDV5i9y0ue0tEBfZYZN7bOLaI6E?=
 =?us-ascii?Q?gYLxgcsgnk8HNhsaEv2CFXH6uyfQnrQU+zDsFPx555cYOrVABHyEejTfI2e8?=
 =?us-ascii?Q?SpbXD411xUSTG6Ym7i5Thjyr7xOezm1LkbaUYJ6ZLY/xxu3GaY655NwQXoKw?=
 =?us-ascii?Q?tOAD6duf+lJNyIsOiM2zzcv7ewrYYWoNZ3JktL0Im9fd6Z8OAow3Dpgx0kwu?=
 =?us-ascii?Q?9TOQlSBXBH7scAKoMS9Gd2DxljHe93bJzAQuA1J0OQhlHiq2rT582tgp2deR?=
 =?us-ascii?Q?ond6liRg4YWARTUBbIQqme5jYoWV9FygpogBXsQZaZYUg1wJDSqHyxoCSYu3?=
 =?us-ascii?Q?D7MFqZpYJzhuj8TtaXpCb/n9mtj31twVbeZeRHpl/PJG5xiEBIJMrVHUNvYR?=
 =?us-ascii?Q?RTgdQfH2bEPtwHrEQfHA14sAKE4JILG8VMGKyS/b12Spc6yztrHjXg5VYJHW?=
 =?us-ascii?Q?pfJOmJ4wKb/k1k4IUeyOewFA5O6QZ7/D8U3unMY3F7NY+HXiOi/uYSYGQLp8?=
 =?us-ascii?Q?2pXm4ljuuoiUCzXWKPJTf8fv3C1EgRsBlWk64oq6mxfi1BBD0SwHu7glCTOl?=
 =?us-ascii?Q?0NsAs9E5ve/4AOg6Wj5wHItfpPs02az6NaKVOCmN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06290d6-c75f-463f-7aca-08dbc7e84586
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 10:21:01.5502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjxBUtEGpQsmW/AvXVRbjL+I3iszTeR6QlmSS7NUa96YofeQw5IateoYECCfsHPhC72BHoAz3Ne7gp50ypOIMRuQ8EDa407lgNtWvp+9Ok4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Sent: Wednesday, October 4, 2023 11:44 PM
>Subject: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
>
>Let the vfio-ccw device use vfio_attach_device() and
>vfio_detach_device(), hence hiding the details of the used
>IOMMU backend.
>
>Note that the migration reduces the following trace
>"vfio: subchannel %s has already been attached" (featuring
>cssid.ssid.devid) into "device is already attached"
>
>Also now all the devices have been migrated to use the new
>vfio_attach_device/vfio_detach_device API, let's turn the
>legacy functions into static functions, local to container.c.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
>---
>
>v3:
>- simplified vbasedev->dev setting
>
>v2 -> v3:
>- Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>  while keeping into account Matthew's comment
>  https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-
>2b6b31678b53@linux.ibm.com/
>---
> include/hw/vfio/vfio-common.h |   5 --
> hw/vfio/ccw.c                 | 122 +++++++++-------------------------
> hw/vfio/common.c              |  10 +--
> 3 files changed, 37 insertions(+), 100 deletions(-)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>index 12fbfbc37d..c486bdef2a 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -202,7 +202,6 @@ typedef struct {
>     hwaddr pages;
> } VFIOBitmap;
>
>-void vfio_put_base_device(VFIODevice *vbasedev);
> void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
> void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
> void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>@@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
> void vfio_region_exit(VFIORegion *region);
> void vfio_region_finalize(VFIORegion *region);
> void vfio_reset_handler(void *opaque);
>-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>-void vfio_put_group(VFIOGroup *group);
> struct vfio_device_info *vfio_get_device_info(int fd);
>-int vfio_get_device(VFIOGroup *group, const char *name,
>-                    VFIODevice *vbasedev, Error **errp);
> int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                        AddressSpace *as, Error **errp);
> void vfio_detach_device(VFIODevice *vbasedev);
>diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>index 1e2fce83b0..6ec35fedc9 100644
>--- a/hw/vfio/ccw.c
>+++ b/hw/vfio/ccw.c
>@@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice
>*vcdev)
>     g_free(vcdev->io_region);
> }
>
>-static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
>-{
>-    g_free(vcdev->vdev.name);
>-    vfio_put_base_device(&vcdev->vdev);
>-}
>-
>-static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
>-                                Error **errp)
>-{
>-    S390CCWDevice *cdev =3D S390_CCW_DEVICE(vcdev);
>-    char *name =3D g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>-                                 cdev->hostid.ssid,
>-                                 cdev->hostid.devid);
>-    VFIODevice *vbasedev;
>-
>-    QLIST_FOREACH(vbasedev, &group->device_list, next) {
>-        if (strcmp(vbasedev->name, name) =3D=3D 0) {
>-            error_setg(errp, "vfio: subchannel %s has already been attach=
ed",
>-                       name);
>-            goto out_err;
>-        }
>-    }
>-
>-    /*
>-     * All vfio-ccw devices are believed to operate in a way compatible w=
ith
>-     * discarding of memory in RAM blocks, ie. pages pinned in the host a=
re
>-     * in the current working set of the guest driver and therefore never
>-     * overlap e.g., with pages available to the guest balloon driver.  T=
his
>-     * needs to be set before vfio_get_device() for vfio common to handle
>-     * ram_block_discard_disable().
>-     */
>-    vcdev->vdev.ram_block_discard_allowed =3D true;
>-
>-    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
>-        goto out_err;
>-    }
>-
>-    vcdev->vdev.ops =3D &vfio_ccw_ops;
>-    vcdev->vdev.type =3D VFIO_DEVICE_TYPE_CCW;
>-    vcdev->vdev.name =3D name;
>-    vcdev->vdev.dev =3D DEVICE(vcdev);
>-
>-    return;
>-
>-out_err:
>-    g_free(name);
>-}
>-
>-static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>-{
>-    char *tmp, group_path[PATH_MAX];
>-    ssize_t len;
>-    int groupid;
>-
>-    tmp =3D g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_gro=
up",
>-                          cdev->hostid.cssid, cdev->hostid.ssid,
>-                          cdev->hostid.devid, cdev->mdevid);
>-    len =3D readlink(tmp, group_path, sizeof(group_path));
>-    g_free(tmp);
>-
>-    if (len <=3D 0 || len >=3D sizeof(group_path)) {
>-        error_setg(errp, "vfio: no iommu_group found");
>-        return NULL;
>-    }
>-
>-    group_path[len] =3D 0;
>-
>-    if (sscanf(basename(group_path), "%d", &groupid) !=3D 1) {
>-        error_setg(errp, "vfio: failed to read %s", group_path);
>-        return NULL;
>-    }
>-
>-    return vfio_get_group(groupid, &address_space_memory, errp);
>-}
>-
> static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> {
>-    VFIOGroup *group;
>     S390CCWDevice *cdev =3D S390_CCW_DEVICE(dev);
>     VFIOCCWDevice *vcdev =3D VFIO_CCW(cdev);
>     S390CCWDeviceClass *cdc =3D S390_CCW_DEVICE_GET_CLASS(cdev);
>+    VFIODevice *vbasedev =3D &vcdev->vdev;
>     Error *err =3D NULL;
>+    char *name;
>+    int ret;
>
>     /* Call the class init function for subchannel. */
>     if (cdc->realize) {
>@@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error
>**errp)
>         }
>     }
>
>-    group =3D vfio_ccw_get_group(cdev, &err);
>-    if (!group) {
>-        goto out_group_err;
>-    }
>+    name =3D g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
>+                           vcdev->cdev.hostid.ssid,
>+                           vcdev->cdev.hostid.devid);
>+    vbasedev->sysfsdev =3D g_strdup_printf("/sys/bus/css/devices/%s/%s",
>+                                         name,
>+                                         cdev->mdevid);

Hoping not late for you to include this in v5.
I think no need to re-assign sysfsdev as it's a user property, we'd better =
to
keep the original user value. Also looks a memory leak here.

>+    vbasedev->ops =3D &vfio_ccw_ops;
>+    vbasedev->type =3D VFIO_DEVICE_TYPE_CCW;
>+    vbasedev->name =3D name;

There will be a potential failure when a second mdev device under
same cssid.ssid.devid attached. We can use cdev->mdevid as name.

Maybe you can use v2 of this patch, I remember these two issues are already=
 addressed in v2.

Thanks
Zhenzhong



