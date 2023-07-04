Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 932567466E5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 03:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGUvi-0001OI-8M; Mon, 03 Jul 2023 21:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGUvf-0001Ns-P8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 21:34:07 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGUvc-0006DM-QU
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 21:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688434444; x=1719970444;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L2Isc/lkuyfZ6o/gdtfHwe68MpUyJQ6AdoettwwhEU4=;
 b=nD8aCpkvOK65TTEjmy8DDXthW+KYSRH1LhSbSxSxHXZp6AKunweJNhst
 N7rF1+jH0ZKbNhQASDTK/nerM/FCnOFubeheriYDPEpBRuJvNmwqYZfxN
 GCGTy2clCCme8m1kL8mTrslDsCU8JwcC4+QoTA2Ah+GBWU1lVcF0Vqbj/
 PKPk5z/483fz72Sk+yKCUM7P2mBl+NvWnKIRn66ytCYnQfJMuPEBKjKG2
 E8VpHIWC9LxE+01Sus97LGlGrRcq0d44jfbSOdkNmjDmBLwjLePplxjaL
 hsZVGHub8XA9HHTYQzWh199fQN1vjxrkO2SGNKtwJJvpKJ8WrslZ8QGbl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426689441"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="426689441"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 18:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753895720"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="753895720"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 18:34:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 18:34:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 18:33:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 18:33:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 18:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7kO1Da3YW8jaVUuHNiQJAnxb5C3hvUDYJ2kFn4xM9NTBtS7WrkCS1q3xtVCRnPzi8XFgk47LodxueNyPHLo5BjKa9hfaeqgND0xVkcGLldrLD+dTHQYoxx4cSzPIduPYgdaS8rv6ehurIDWuoRARid0jMj9+5OyADQdq53q6oxiEGmKui2M0r0jJA8VwTnYcpHaJSuIc6KH8iOxvT2WfLsBjKBXXROPbKBp25UG/L5ktSMs0QC0sn1hFxnZPPmBSRsBv2AUseUK1G403F2SZ7/dozZ+JNDkwcWBJ5aP04uGbHKDZsmT33fwC3N60HkuNlZQubgYQ9+iciZIKD9hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVPviX8QBipLCico1tfpH72Jby7Xz4ycIG9MR9PhDSY=;
 b=boByaPQGXrVfWWHDQRysTq9wa6mfrTYAhTvmswOeJztNYjacp4Bgc7qdyDXkOBtDwVnFIXc+5EVJPzpJgmXABjXD400I/1z8JmpT3BPlpoqfyh+7OwyzRIuJCf32BPbyaiyvav4I5toIDA13gDyMlBFpE5sB67WPohTUUG/xug55H7d7vHnHtjpz1Ng90H+qGdbRVGBpscyTiI6Mja1XYIuLa3DOdW3Tc+8/39Mg8l5rVuHKCeoX7vd5NAeFBg26l07pSxduu/D1QfYDbHNrZfSgSYEKSE4EtD7CTZ9Hk6mF96jn1eVnbw5/xf1SYnHXZddElj4bS+CndpGQDmOg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:33:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:33:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Thread-Topic: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Thread-Index: AQHZrX/zicQvDye0nUCHuONYtTXCNq+o0xVQ
Date: Tue, 4 Jul 2023 01:33:56 +0000
Message-ID: <SJ0PR11MB67445C289A697D758D2ABB85922EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-4-zhenzhong.duan@intel.com>
In-Reply-To: <20230703071510.160712-4-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6415:EE_
x-ms-office365-filtering-correlation-id: 54ef3efc-d7cd-4cd5-cfaa-08db7c2ebc22
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Jiy5V/AUDQElN6Dmy26croGfeqlw7u6X0Lnm09OlvyI16nKwtaN4s9BWzZ72ycljRqeMYaM5n85xnYR9dS6JPzwGFxVeLXuRhdI+G6GsRBYPHM+CBwQz2IKtw3MM3eiFBkQzmxqCSVL6cv7RkzFsZUkkz5ChcG6Tq8pRvrbrHnF5gKQKtxgszUIJbTADghp+5cWGH/WaP3v0m/Ve3T4k7jLfBLP7F0kXedlYNfKoeg/CBjmSBObHkKcyfHTPtHN2180IRwSwR2YmBRrQGBtkkUaImYurR3/ERsAtVRa4XlEEp/JudEDyWIrMAmq7Ao72iWtzJMHLz96XF6shoR0a8la4Izc6gd9SRpyI/k+6ShTIkrPYujTFnf2s/4NkFiZ8v4U0mwGW+dm1rl70m/OXECpiV0TE+fmkvyXZN9fGtsUiXsx0tBOW2IYn52kCSfZ33pw0QQ9RoQJCIL48U3PFjQ0pFJJEHgOFxAzq3DNWcY/pvrS4T1ORk1pG8lBT7nege4gn1IQWaI4c498r5DUd6ZGW8hXEmBh6Uqx0iHGMoH6EOb/904bXOyFWWcEmFWETesI70f+hsOpUAk5rgdP88UVPzmRo1x3/DJIEyEtFqwA/8gGgqwz70wNmJgp+qN1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(4326008)(316002)(66556008)(66476007)(64756008)(6916009)(66446008)(66946007)(9686003)(76116006)(6506007)(26005)(86362001)(186003)(107886003)(83380400001)(82960400001)(122000001)(2906002)(7696005)(38100700002)(33656002)(71200400001)(52536014)(5660300002)(478600001)(38070700005)(8676002)(54906003)(8936002)(41300700001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RLylkZmz6zxO0jbo6txw754bMJ4PqFEEOIOjJ6WrbZj4koSu1Ddoq+PXrYyu?=
 =?us-ascii?Q?KNa4KwNbiITQvfvBWpu+QBtKbk9gtOAEBuWsgT9oQnVU5V3xKqpD3WYmK+sk?=
 =?us-ascii?Q?FCTZdB0w4SHOy8c2JeLEuYYpMQk2Fzmu1E3rgyVGuQCPGnaffEqMBACDzK4A?=
 =?us-ascii?Q?tgZ5toIMCtmgdAqpvy2A5tReO6pbZmKshjiPXkekluZWudT1MeiVjtJJsxed?=
 =?us-ascii?Q?hCc9JTTKNSqzjQ1ikno+TDe5rCP/wC8LtEHLGf/eyt22KYvlBkAt9DccdeF5?=
 =?us-ascii?Q?5qEWHx+NnfqCYxUo8C21JxtXTHTJs6Cdp3e2x6aQmF8jPg5UElBOF5lWZQ1c?=
 =?us-ascii?Q?YR2fItI0LkxPu9IRCOC61PV8oXNhikiOIbO0fE/NlKv/Y1nh8d8SNi1fOqiJ?=
 =?us-ascii?Q?7m/gfYr8pW0pV5CyFkoUqAHW9p4juxAc91fTiu8dq+DXD05ogj+0AF0j+EnD?=
 =?us-ascii?Q?49iCTqCpOjrN00NmYgtlKxg0SX+JzkaoutHMG8CD7ecDiEVaotZ6mBkogHG1?=
 =?us-ascii?Q?uZGaSzHhBa1gInEBVnUnDT60OYZaySNtOGt3BER8wFVS4stdGa/KAZwavsSt?=
 =?us-ascii?Q?sBjqD/DpAigsNgyOWSG3Orbr9xSWrmEbUeFvjQvgXebtQBH94N14fvaPio13?=
 =?us-ascii?Q?9KFQZbZijrQvsbGyWXlLzV0hDsKsTpiBqzdFTSqhKOn4zAMklb0iKQz+IvEh?=
 =?us-ascii?Q?2mwVMJ2959DyC3UMwnbqQNzAsgV9ueT3GBd3Z/g1Yrx1O4ZOATGHWs+PI5V9?=
 =?us-ascii?Q?XuB56ux0u6wC+uxHpBplq4mR5qUwIrk/LnPRGZv9v/jUd5R4vrohmI8zxTFh?=
 =?us-ascii?Q?q+/Ry6vfAYweBN9ZF+Qfam5NilbOW1Jd4HKSV/pBSbUd3dSRkliB9LI2uMUj?=
 =?us-ascii?Q?5ouiORqB6zQS8W2PDwBiBm6HFplHVijR9Kxs/VUSIPwFiwgnLAd24gFmUOeS?=
 =?us-ascii?Q?fL29V8zjHv3kyRG+jXgFa+GGoDIhpDp6BkveSQnQ8w7CtPbw579O5f3R+uBH?=
 =?us-ascii?Q?CuuH/82IH0ZDN8ek7Tc0HtSeplWueD9hgLcL1VHR6eBrn/H18wJl6KmrAZ2I?=
 =?us-ascii?Q?diWlbTIeHi+Ia22fQbxwj9s1IcIOqZchAvkYUgk+z1HgbOeTxe0uOe5TQFQr?=
 =?us-ascii?Q?NI5a+lF/QTUSHbzM8/2khMBAt7DjkddubQSKvIays512ugodr0k48v8UTo3O?=
 =?us-ascii?Q?xMqCqiKai+5uHKPv2Q/igT2a02j5UooBv3EaL1qBDJa9n0UUAY6ckPRId0aY?=
 =?us-ascii?Q?s0Es/2QPA4eQw/NidyVbNn/pwCHdqAwwp1BWVnf8CaCviqwxdl1i1QG0wvoY?=
 =?us-ascii?Q?zoooOiL+Y8M2AK/4LvYfGWsxamTFCfHssNMwBX26pNsYHGLnnEu/DSL43AfF?=
 =?us-ascii?Q?BRIw1vSEiKoF5Yei3zBvdVepwCWJGWIv2a0N27zzDJa2Dfv/ouAk6TwCbGcr?=
 =?us-ascii?Q?USLMi+FwtO668d28tAHf2Fo+ZMK0xb7oxVPcMVCwVo/yqug5zxFgWgf1rni0?=
 =?us-ascii?Q?VasuWCd6EvxKfb2nyH5rHIXuKbgAdqQsM5yCXjUEJhGx30bWxSEpulsYFV71?=
 =?us-ascii?Q?8Spt3IxGkATLYGumPP4JkZAK53QpXqE9pTOOTo3s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ef3efc-d7cd-4cd5-cfaa-08db7c2ebc22
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 01:33:56.9574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsIGAhiZFTS0P9Khj1W5Xv5LY09zXY99lUCKHP/lJdf71IyrX23+jrMvjPEWvDNAPlOyJVfhWkOhqxdi0Mu2TXDkMvo0cGI71axYbx4zQZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mga06.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Sent: Monday, July 3, 2023 3:15 PM
>To: qemu-devel@nongnu.org
>Cc: alex.williamson@redhat.com; clg@redhat.com; Martins, Joao
><joao.m.martins@oracle.com>; avihaih@nvidia.com; Peng, Chao P
><chao.p.peng@intel.com>
>Subject: [PATCH v6 5/7] vfio/migration: Free resources when
>vfio_migration_realize fails
>
>When vfio_realize() succeeds, hot unplug will call vfio_exitfn() to free
>resources allocated in vfio_realize(); when vfio_realize() fails, vfio_exi=
tfn() is
>never called and we need to free resources in vfio_realize().
>
>In the case that vfio_migration_realize() fails,
>e.g: with -only-migratable & enable-migration=3Doff, we see below:
>
>(qemu) device_add vfio-pci,host=3D81:11.1,id=3Dvfio1,bus=3Droot1,enable-
>migration=3Doff
>0000:81:11.1: Migration disabled
>Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1=
:
>Migration is disabled for VFIO device
>
>If we hotplug again we should see same log as above, but we see:
>(qemu) device_add vfio-pci,host=3D81:11.1,id=3Dvfio1,bus=3Droot1,enable-
>migration=3Doff
>Error: vfio 0000:81:11.1: device is already attached
>
>That's because some references to VFIO device isn't released.
>For resources allocated in vfio_migration_realize(), free them by jumping =
to
>out_deinit path with calling a new function vfio_migration_deinit(). For
>resources allocated in vfio_realize(), free them by jumping to de-register=
 path
>in vfio_realize().
>

Forgot fixes tag:

Fixes: a22651053b59 ("vfio: Make vfio-pci device migration capable")

Thanks
Zhenzhong

>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>---
> hw/vfio/migration.c | 33 +++++++++++++++++++++++----------
> hw/vfio/pci.c       |  1 +
> 2 files changed, 24 insertions(+), 10 deletions(-)
>
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c index
>e6e5e85f7580..e3954570c853 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -802,6 +802,17 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>     return 0;
> }
>
>+static void vfio_migration_deinit(VFIODevice *vbasedev) {
>+    VFIOMigration *migration =3D vbasedev->migration;
>+
>+    remove_migration_state_change_notifier(&migration->migration_state);
>+    qemu_del_vm_change_state_handler(migration->vm_state);
>+    unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>+    vfio_migration_free(vbasedev);
>+    vfio_unblock_multiple_devices_migration();
>+}
>+
> static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error
>**errp)  {
>     int ret;
>@@ -866,7 +877,7 @@ int vfio_migration_realize(VFIODevice *vbasedev,
>Error **errp)
>             error_setg(&err,
>                        "%s: VFIO device doesn't support device dirty trac=
king",
>                        vbasedev->name);
>-            return vfio_block_migration(vbasedev, err, errp);
>+            goto add_blocker;
>         }
>
>         warn_report("%s: VFIO device doesn't support device dirty trackin=
g",
>@@ -875,29 +886,31 @@ int vfio_migration_realize(VFIODevice *vbasedev,
>Error **errp)
>
>     ret =3D vfio_block_multiple_devices_migration(vbasedev, errp);
>     if (ret) {
>-        return ret;
>+        goto out_deinit;
>     }
>
>     if (vfio_viommu_preset(vbasedev)) {
>         error_setg(&err, "%s: Migration is currently not supported "
>                    "with vIOMMU enabled", vbasedev->name);
>-        return vfio_block_migration(vbasedev, err, errp);
>+        goto add_blocker;
>     }
>
>     trace_vfio_migration_realize(vbasedev->name);
>     return 0;
>+
>+add_blocker:
>+    ret =3D vfio_block_migration(vbasedev, err, errp);
>+out_deinit:
>+    if (ret) {
>+        vfio_migration_deinit(vbasedev);
>+    }
>+    return ret;
> }
>
> void vfio_migration_exit(VFIODevice *vbasedev)  {
>     if (vbasedev->migration) {
>-        VFIOMigration *migration =3D vbasedev->migration;
>-
>-        remove_migration_state_change_notifier(&migration->migration_stat=
e);
>-        qemu_del_vm_change_state_handler(migration->vm_state);
>-        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>-        vfio_migration_free(vbasedev);
>-        vfio_unblock_multiple_devices_migration();
>+        vfio_migration_deinit(vbasedev);
>     }
>
>     if (vbasedev->migration_blocker) {
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index c2cf7454ece6..9154dd929d0=
7
>100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error
>**errp)
>         ret =3D vfio_migration_realize(vbasedev, errp);
>         if (ret) {
>             error_report("%s: Migration disabled", vbasedev->name);
>+            goto out_deregister;
>         }
>     }
>
>--
>2.34.1


