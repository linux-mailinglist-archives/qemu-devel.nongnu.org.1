Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F281AD8E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:35:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9pQ-0001zB-T5; Wed, 20 Dec 2023 22:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG9pB-0001w7-KI
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:34:22 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG9p6-0003eu-W5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703129653; x=1734665653;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QV76Hni5zdzHkrBRPMXrJnnhL0sFh22u5C9Q+llfn10=;
 b=jXELjHRVEbHsYLWmhs0qjpo3qswCKdCzG06ofepqs9xAzubL6PUztk3o
 IG44l3ab7qbZXwhNe+KbRKNXOKnX/e7e6ilbnTX5TBEUAB70bokK+JbTR
 qjCfs3kPBU4eAHIoRafGGCCyQNRcRgQbHaavi3UlpJEYSJ11fT27RLWHY
 XBhCGnbSw+/zwivVX4tSZUmq/CpqCIfmJP3NAhmkW911/6QCxprvruTkl
 GiNUXEMWkpCTG9lZP9+yRFIGacZs6pvGAoK5qVPyxjOusIBYxYKO1u/sw
 ihZqx3qCBjwbGhiO/HQPTcT2Unj78Rdc5GtmzGoXHFf3ZpEThh43QOrsh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482097045"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="482097045"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 19:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="18548089"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Dec 2023 19:33:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 19:33:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 19:33:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 19:33:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 19:33:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIv/LkBZTShKIuUlBl1uxwmNmuybou8M03AEl6wDZjgTUnnjkyX4nMBGEh/IlTJYJ4Cdd1nPaCyrRVcUauyK9DCNEaFU162v0m2Ia2w1MVIIsXGQFPigMpNfakG2Dlgv4Z4bdRh1k0dA+KQZj4UiFHQ2xDLCC7P0yE+CwdihPGkj+nER3uSJ6lFdMFvvUwSLqAbGSC08+Yl2d3KHRZfas+FYIsubQluudIR82GvP6jCiBYJC3XUrni4ISMvBM9g0/eIfS8v/pAU0GTTZOMNFDaOJ9yB3OwzVv9dVXF5UE0DItgp/z0vYes6qOCobTqokPAnd5dtWM6NaCMz+3dw+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV76Hni5zdzHkrBRPMXrJnnhL0sFh22u5C9Q+llfn10=;
 b=MfOe/EVT8AGI7PjjqbdTyvL6kwCL4bpbUNIIzOFsmyKDCDDjizkXY64NhMPeEaPO4ZelOjpNgt37A8liYog31qBs5K6+SDJc122n1+0culk7fDyfI0K/J9JYjRpiMqEA7tfcnvgTSLOSz1Z369wIJ/IZGpluZBKFVcS3g6mNMQ0dwABNsAuSzpDXtZYMZO0wTTRkjIJG3DASL9AkV6nF1XilZL43XKkXab455u4gXy3lksqWpON8jK/k3u5ULVoIZHq2YTz9BpXQhsma0m53zvWSYb+GbWIht7StbBHv0JX0np331AahA+tlpg/+z7DUsmosEENL7jx9xFiKFMGdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.20; Thu, 21 Dec 2023 03:33:47 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 03:33:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joel Granados <j.granados@samsung.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: RE: Questions regarding the still unpublished qemu series
 https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1
Thread-Topic: Questions regarding the still unpublished qemu series
 https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1
Thread-Index: AQHaMz2s5/BOjKkOzkCFrF5/NV5ihbCzEokg
Date: Thu, 21 Dec 2023 03:33:47 +0000
Message-ID: <SJ0PR11MB67446F6273D60FADEFB6F2AA9295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <CGME20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe@eucas1p2.samsung.com>
 <20231220121116.hjfl7zkcm2q74aco@localhost>
In-Reply-To: <20231220121116.hjfl7zkcm2q74aco@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: d95a69f4-342f-4770-162f-08dc01d5a462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1AVjtP3O6vUZsI0M09NBl7pqBmDLVO2utcpNSltV2rTbcn0prMFDF0X8VymigePjEU3yT1v1l3vogP0S7ukQL2F7xbldN0R0pyZK61LzOKwwa2DT9dSTE7gIud61qn6m1tGpWpZ+hJnNzT/jruCNpG/Z5FJztuYNoMnPHnl/iDs9mzPvxVFQI7Id129eIGRYK6G6Fx4a63pW1Uje8N+14wzxV/heyHROfK+GF1tbp6GoremkKwpdv6YaFFLehoGSIzjtst7KozC0TqYhipN4TRs9j5urQWeOoQeveotGhfIX3x8O8kGHlVmLCwZ+6agWmaR7Pc8MHL32tc6XBWLtzm6LgbPuC1Uh2Hj53LqY0WbUvyazIFWl5b2aXoGCojyMzNpmmjbCuQmr6NXa5Cy2guymcHpShMRbxn1eN0di4/Ymd3eLm5hFWcbhpgGar7KEjjQEpb3xW2N9OB8spstVHfu++JDlLVdN5tMiexmYY1Z6m2nA+CFeJ+2lyqz/4vKMRRZIF+1GmD5EDxGVNqvHHAWeSkDHNF+kQ+tSOCppgCyIHsVx818B6onaKQbHuNCOMms6wTZYhUN+OznoiJJBagW9b7lWuTl4DZ9RGw5qVPCgp+2/3xhqKzBIraHs4J0YCGMsqYDxhYRqfe+F68VaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(71200400001)(7696005)(6506007)(86362001)(33656002)(9686003)(82960400001)(478600001)(38070700009)(83380400001)(26005)(38100700002)(122000001)(41300700001)(5660300002)(966005)(110136005)(66556008)(66946007)(76116006)(52536014)(55016003)(8936002)(8676002)(4326008)(66446008)(66476007)(54906003)(64756008)(316002)(6636002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oK6mi0Fg6iNl8B2ihd6Rz3F4uZeOxF86KEI8LFz/tPZLiSi+QqR+y7cKgqTm?=
 =?us-ascii?Q?0xH0ofq5vPrX92i5ov0Ejqn82ottxRU2Zm7XbwmcP8ul8jklQjuP8bvlVR4w?=
 =?us-ascii?Q?VggWp35KvJcNWbvxCydN/LM47Hrm8zCjoUiGK8wsSPVd28IM6Eo5vmDNuJj8?=
 =?us-ascii?Q?lbEQNZANRfIEnS3AYKr7Ee4JXOLC+PqarhShVBrMWhx6Ikghkyl2xfyW/6qG?=
 =?us-ascii?Q?EmITaau05NY3kEl1PmmyOi5iJzcGSFeR624T70xLeaJiaKgyCToEow5pZaMT?=
 =?us-ascii?Q?T/+LjRFXqjt+fdcyW3Oft/dPSV5wa4azr5giCQPT/75JASc7NYoN/xtVweEz?=
 =?us-ascii?Q?ha7I+tu5Aayb5SWyj6gUSUZmmToTv0ZCdPgWG9auXUxnlbaETdxBOm/t0gNI?=
 =?us-ascii?Q?4jfVx6Ov/+Wk2O+LC/hb9pNgcX0UcYUbgGVRBVjVdrIfRVwkCYAMzw38xzQa?=
 =?us-ascii?Q?370cBuCi+NpjUQAbRKH7+LDAuFH7HzjmdG3ipf8hRiq80qqsjbtaUuz/jbX/?=
 =?us-ascii?Q?uakOhahWCUWv4GxRhYe6knjGvPkm5SVYeNH+xIykIJZUkW4ldF5flJStq4BI?=
 =?us-ascii?Q?yfG/F8Zgs1aKNqyqvMF8JemFrjcPy+2xrJG5j4gpS0e1RG2ioK8bvTvWhbBe?=
 =?us-ascii?Q?m7/kuAnUwmDMBLgnJItYN6IrvHEuLUM9CYW7lKveAf2dMPzT83/Ij6Ocofkv?=
 =?us-ascii?Q?wAdUX3iYM3cIgyDuiFsw27GGlRt2RcbkcjRQ8I/+vrFk7rT0rgpzQjf5O6qW?=
 =?us-ascii?Q?yUtUGCyafKijOCQG3oG8SM7E/VnDZ6J8dkLsY//q/1b9Hkzqplg8DJDhkw3t?=
 =?us-ascii?Q?8fkKB9FMzOUWbCz9FQ8Dh0hlGVIr96g6KrRkDunLGzTiALrzpPOw3o6p0Z9m?=
 =?us-ascii?Q?Gb1vPDhUo6mfobEdCf2a5FhAaI3iDgiRnFUcxSvlF27WKGH1xweSxQuYxh4f?=
 =?us-ascii?Q?ZkGE6CH0p1naQqjVp8oU5tvs5fYWng9SNIVupgysZqeF5GOYr31sp0p0+vcp?=
 =?us-ascii?Q?8awGxN7Mwkkf1GllRfbLusKOOfOM3GV33HQUaVmuu90BXJkgJEspwkuwx/6a?=
 =?us-ascii?Q?aAyJO93BOdDq/fFlMyBa4fU6M+Z6OOXhOXekRi8vS92wH8bHE6kZHGQ6Pe2c?=
 =?us-ascii?Q?iM59Zw7YhKddZsR5Yjc0UvYyqTEkmtYj/1wuVVsC+n/uD4V1LKIQew4yrdZg?=
 =?us-ascii?Q?6mZVMwJ9ug5rSZvUZNhgTxaQ9nmkNsRfNxREgLlIkQaVO8CBTPGDNqAayObs?=
 =?us-ascii?Q?sz21rIJmd8YLYwz2E1PihCM3XOU/C4mGAYWveVUk8k7EIqzcP+oSb624dt9L?=
 =?us-ascii?Q?E6No30AXOl0lZ3TXcyOoZrSVb3roaBGs8hZmW0bc9PdRKCYsGxwhJUuShr4R?=
 =?us-ascii?Q?DP1Ci68LUZGfLNKrx2DZk2LlcTqAbmvFBuX61KWGw9ytEtuz7C7tNNaKzzyK?=
 =?us-ascii?Q?H7HSpIkogxo3UE0kROKu9QwPbtGJxp5o7ULDQmek4pgabDSUH+DbWV86j31R?=
 =?us-ascii?Q?75LneA0vtPDPBjSyes/kQ+0m0LZJTV/6mpWD4MEZsVXTbxeyNqazb8HqYBQR?=
 =?us-ascii?Q?dsVpoRZAPgXwf8xRde/XuVq9tnHsHWUK2w+XBhYu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95a69f4-342f-4770-162f-08dc01d5a462
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 03:33:47.6926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFbLb3esAg32PztPg4sUB77Ie7ZTYC7vkV0MePb4BvTb/C8pNLLSkPxGhCQkTSjvjOarEUS8E0vHF0u0qAaRxd6uR9qu4+w+QehOzsdjl6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Hi Joel,

>-----Original Message-----
>From: Joel Granados <j.granados@samsung.com>
>Subject: Questions regarding the still unpublished qemu series
>https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting
>_rfcv1
>
>Hello Everyone
>
>While running
>https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting
>_rfcv1
>I have come across particular code path that seems odd:
>
>I'm hitting an assert in softmmu/memory.c:1994 after calling a
>notification from vtd_flt_page_walk_level. The code in memory.c:1994
>makes sure that when type=3D=3DIOMMU_NOTIFIER_UNMAP, the permissions
>are
>IOMMU_NONE. But the code in vtd_flt_page_walk_level sets the
>permissions to read|write. This is part of the "intel_iommu: piotlb
>invalidation should notify unmap" commit in the iommufd_nesting_rfcv1
>series.
>
>Question is: Why assert on the permissions being NONE if they might be
>read|write?
>
>Hope this makes sense. Don't hesitate to get back to me if you see that
>there is something missing in my explanation.

Thanks for your report, you are right. We had seen the same issue with
vhost device and have it fixed internally. Did you also use a vhost device
or not?

The link you used is a bit old, could you try with https://github.com/yiliu=
1765/qemu/commits/zhenzhong/iommufd_nesting_rfcv1/

Thanks
Zhenzhong

