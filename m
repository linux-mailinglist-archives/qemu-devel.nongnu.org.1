Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1D796E72
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 03:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe3Xu-0004yN-Ok; Wed, 06 Sep 2023 21:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qe3Xp-0004v0-Fg
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 21:10:53 -0400
Received: from mail-co1nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::606]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qe3Xj-0006PG-Px
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 21:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5i2osMAWQXfRSJKuw3mRu0ZIG0FiZ2acXuqYUtEms5FYWwlZZYU+KZgQmNV2ZbvEa4g/zMGJdd7huwGyyW+dcL7dkBFWrqi7Za/Oivx3warXUU002BQcJmLE/312rSiwQMoOtgiRpFCPZlZJhiu6wH8jLW+M4ZpqJ8yLHkMFpe/Vmh2qd306aA041zFudViVRwfMBifjBPigh1vqRwGAQV2VjF5C8dFO//WjqKGs+g1xMgZjsCGC5dziegAgVXKbBL1WaM21stHl9cYnQiom28QP7TdCVFmrVQah/tqnmdKKXvYGepqVohsgNXr4jl4xvlq4/8D7tijCs9lgV+n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laTAjYt4CenrQQ4BIn94O+9t4eB/BD7pC/RuFltrkS8=;
 b=BOP17MTnkOBSZEM5Cyr0Sg/E7C8WDf9NvPS6Kk5xufAoTkdM7BkOCqI4MDb7ZSLiUG07NUdEYK3sY2dHhc1uCncfv1ZqLomDzAaxbt0rrR6zWsdkO62Y6i37dxbzlrzpRJ7lAqFT6/LPQ+2uwqhhRI7KL5dX6FZBPBcKdN0+zEhQdKxlLuCqZSeWvkWvZuLxycPtKutfVMs5JYiK7g7D5j7H9cZgCLJwXKSyzVwrRXOl6QisugjNqDffyzemOKsgkxjRQF0FfLTrwRpKQb+TeMDajD2x+YqMG+xNVgVzwDgeo46TNZZlDroq6OyMYULvQO4bXCRcCswGtQSqyZmmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laTAjYt4CenrQQ4BIn94O+9t4eB/BD7pC/RuFltrkS8=;
 b=QUr1W5WGWH5Dzryt9yWJng7JmIEWeuqroNaYwLp1FpVt2TG+vZBauqMLtBb62++UhpZol5oDSYwUS04xxIijw6rYkPTeUFTGAE6Jywci8R9fOrysqqPnftuz2gOZetvrkB65fZH34Fo9uhyhdLghzbKQe6vqxqZGf4JVGDMixI8Mc18qZrXnovrcZ6dFti9+mDORrNzZOBkO7KTkEqsMfeDpBB4WYkP/aUt8jvLfrAf7F1MF0XYO60M+9AlEq30H5UAoSyd0Mdbi5xtepaR2cAJcci46FEVqVBVXvhD3G1Ix2LC2V4hrST5JBLWI+p+R2R0KaYAeZbm7/pNmtyu3Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 01:10:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 01:10:41 +0000
Date: Wed, 6 Sep 2023 22:10:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 clg@redhat.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Message-ID: <ZPkjEGZF1D/fLk9w@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-22-zhenzhong.duan@intel.com>
 <ZPjAn1Asi5ZE9yzB@nvidia.com>
 <20230906130926.5c66f9d6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906130926.5c66f9d6.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 14925535-35a8-440d-762f-08dbaf3f40e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNObp7P4K8sobNaXP6I7n+RAJXlMMJEiymriwov4uvJZ/oKFnDDLfpDPNxovnsh22n61sAg1MjUysu4RCsuFVFmmgJB/oVfvVzWEVVufxWOOtbZaN26RvBW59FGlXFTWJKs8hpcvCrL3B30Lpj9nTAI06rihzwu2kNQgJsHzLoL67oHQf6Rf53V8S0YYSrGiiSTaVc/GgkPHZB0PD7x33tu2DErnL/eqJuMKfwxA9zHU1DLzi+cxp1ihbCFD3a8/ekQmzJtiXWlk11RO0CjkHPALTU0xGfR7CFaK3LrKuRFbmzAyIwvNpVSlS1ToiquJOH2ppi/JXbMaG849pC/4mIbUQqo/cSpFwWwxew2xQU2Q3yrDsVrALA4TLDIrb49UF9/ann2zQpg7l2OwqwyM2fw1aw+f9sqn5LGr4sCpT3gGS2hS5TDpqWAPUh7xkHxBSPeveKolqult1PgIZ3l3N3ddyvclStCNBZUkb4jsQ/PFt+XG0L8Tk1kcK5yObqKn00F22PsMci8zD816Xvv0soz72wN9IWLTHQm0plzwPWpd5O7FU1rMnxSxX7ivGdIa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(38100700002)(36756003)(7416002)(86362001)(5660300002)(83380400001)(41300700001)(6506007)(6486002)(66946007)(66556008)(66476007)(26005)(478600001)(316002)(6916009)(8936002)(8676002)(4326008)(2616005)(6512007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlrB7oMVfe7ycvhe54oQ6kbIBpGnBXhhZM/yJOzy+b2YghlXWKHDoVgnXmyS?=
 =?us-ascii?Q?QUAQKmo7+51i2EUPa33ivbB/pP0IlMowyijeh5uS782LcD8Vb/Vtvmn2cvRr?=
 =?us-ascii?Q?1CH7RQlsEGvjIY/rOfnn8KTI/8sVCoX5bU0/OdKiPN7+y3sFkPQvvLa5OjOT?=
 =?us-ascii?Q?dH3geqHvd8rugU6qwx84vgqNsGSAGSBEsrxvkNoqpz4DMBbQJREZbthXNTRS?=
 =?us-ascii?Q?AWL6TslWwyV3/mK8JlCvqyrujYeTSke+nCcQbkmeeDT6ZaCqdWpQxh4pNVJO?=
 =?us-ascii?Q?4pXXNyJ+fO5zjczL9ESc41Kuli6OZQ8yNHD/V3oXzSQvL9epub7S3RKgHXhI?=
 =?us-ascii?Q?/CO4mYTiC0A55l9NLx42hISARc3/6bTuuvEnO/v0+yo5soD0AqA1W3UaMabs?=
 =?us-ascii?Q?SM6hqEOnL2w1jzZXLRiJVl7bVCBOZq97xXVm+lwikfZwQGJcI3wWZY0HyOhc?=
 =?us-ascii?Q?7ZYhWCgwZwUw7DkcxVBkSX2y6ihREQnZAq7jtTC1xfzVW/3YWa1C3pVsBJe1?=
 =?us-ascii?Q?UMU/gqkkSu2fxYwyfNSw4/NdtDsbqu3e1WFOprx+NFKGSSy6KnHGD0orvmu6?=
 =?us-ascii?Q?oxvtqQGScTxb8YfggFKB1S9QK0DoFT0udeopzbSwu9UrSa72mHqY+2L6GD/O?=
 =?us-ascii?Q?Mf4Lq32ntBWuPO307NY+D4itedTYni4rA24dRW6duLPilayoQeEaGuaXXM+a?=
 =?us-ascii?Q?k7EvRlQ0DuG618IqFt6/5q+zaLTccNdPbPK31Rv2IXvNnv88SzblBCO5wq6l?=
 =?us-ascii?Q?EDY+WHt8Tlf9ExrlXC5DQD4UDrpT4ddoY9hpNfmo6QwsD/m+RBmpthKY2Xts?=
 =?us-ascii?Q?Mblu6K5pf/vgZwBQYaxWkcSvFmFcv58oeeizBgq+yIX09NMfaig32GbMdgd7?=
 =?us-ascii?Q?wlTZ/MosI/M2RS+CkG6boMZSfGPHIyL0s1opkZLOczhcdN6ib5pVMYtI/PjZ?=
 =?us-ascii?Q?FTOIufkz3m4lEDuH8dWz7HbazbCoDLLgKNb282eubzXK0Yl3tmeMrO3zd14P?=
 =?us-ascii?Q?DSWvr6Ce113fHudPRao33EciQ/QU3L2ml21AaaKd9yuZM/gmNmqNqLwTOUTM?=
 =?us-ascii?Q?/q9309KCjj/vK/GeB1GcUNRDSiiWefLXG7qbGUfObDRZ1t72g4N10/lGhg/F?=
 =?us-ascii?Q?IlbmNunzaXA7GUVurCXNDrwlgtxQuViMgXXuPp8colL2IMC58MDvOWhX7QoO?=
 =?us-ascii?Q?3Yc30zQLr7C0b0R1Zj+oosvF0C5r3z20pLp+wOOB3GfVfdaUjaXh3zLKaQjh?=
 =?us-ascii?Q?z6/Sv+J8X2xzL2XTR+7w+jRsdXU6n5aDkFRN9Q5NyP1j+IstnsXdx/vPjHDG?=
 =?us-ascii?Q?CJwGxQMEVCoKpd4cnCDMlkBnx+vTWEDkj6vMU1jCjcorbRd1m4lR0XdNzL3h?=
 =?us-ascii?Q?mmptriS9hYcGOlV2ZLqKuGi0fgTd6sTVZJof4ydmaW/HulTOQu1qrqBm5z+i?=
 =?us-ascii?Q?nQOGygAQtEEBGelwWEQsUqQ3g+CZCDa3XS+9BG580rGI1+QV7wrk9Hu1VPlw?=
 =?us-ascii?Q?UJ0vevt8XU3qu7slQuEZdrq+b0VBrz4WmFfTvYYOX/D5XT6D0+jHQT1riTlj?=
 =?us-ascii?Q?wSgT3eDnswecWU5zssDuArLBatcv64eGF2u6EwQG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14925535-35a8-440d-762f-08dbaf3f40e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 01:10:41.0987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU9vYLGdEEV6KYTwUkKpEybpy2nSlByn3kd1IQgVGZctXQnbNT7v/n79x+1GEtUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
Received-SPF: softfail client-ip=2a01:111:f400:7eab::606;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 06, 2023 at 01:09:26PM -0600, Alex Williamson wrote:
> On Wed, 6 Sep 2023 15:10:39 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Aug 30, 2023 at 06:37:53PM +0800, Zhenzhong Duan wrote:
> > > Note the /dev/iommu device may have been pre-opened by a
> > > management tool such as libvirt. This mode is no more considered
> > > for the legacy backend. So let's remove the "TODO" comment.  
> > 
> > Can you show an example of that syntax too?
> 
> Unless you're just looking for something in the commit log, 

Yeah, I was thinking the commit log

> patch 16/ added the following to the qemu help output:
> 
> +#ifdef CONFIG_IOMMUFD
> +    ``-object iommufd,id=id[,fd=fd]``
> +        Creates an iommufd backend which allows control of DMA mapping
> +        through the /dev/iommu device.
> +
> +        The ``id`` parameter is a unique ID which frontends (such as
> +        vfio-pci of vdpa) will use to connect withe the iommufd backend.
> +
> +        The ``fd`` parameter is an optional pre-opened file descriptor
> +        resulting from /dev/iommu opening. Usually the iommufd is shared
> +        accross all subsystems, bringing the benefit of centralized
> +        reference counting.
> +#endif
>  
> > Also, the vfio device should be openable externally as well
> 
> Appears to be added in the very next patch in the series.  Thanks,

Indeed, I got confused because this removed the TODO - that could
reasonably be pushed to the next patch and include a bit more detail
in the commit message

Jason

