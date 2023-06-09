Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F399728CC6
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 03:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7QUk-0000Le-1E; Thu, 08 Jun 2023 21:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7QUg-0000LV-HK
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 21:00:46 -0400
Received: from mail-co1nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7QUc-0004RL-3G
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 21:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKoO2e1Zb2EVzfqGOA2oIFRlsrcWcSgFkKQ4O5Lbws1ePb0r8eZmtgGfwlZ3sMR/UA1e9XPfEDllay/UBCZajkb2vODJGtH5BMc/MiTm2gZQhz9SA4R4P1FmAR3AujA0EP2NQRgGGVyrKnIhxa5rWSVajQSLxCGQ1Hh/IFgxcOx/83WsPdlrB0xw/Zf449eP7/LUHKYMnYpjJ1+SMU6FMFS34C3/apaYehtvccKNuI+Br1Dr+l9ttxEAhkdStUOsozWqtaUhqKLKJ4+ciCCzgPOAPtbJee2ehk88I6ANBtzU5QZXeaMInyL2X3WVX3kX2w+lWuINEJYjzXek2zJ6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88v2M5VSMjRNLxJewWeTiQQjVCE2SF2oPXPZE5KqW1w=;
 b=fenpr4jT/8GmyCDo//UW7IZ3/KrGVP6mkOgXuJDDNZwcNojwMzuFeeYKLxIXdDSC3WrlbmlO4OVHyTFV/Hxa6JZuxgkirxdcEXJ03+8ShulWuMxhvHFrM65pNfXGiTNw6DLKj/SnWPLVKD+dTeQzcYOeXWhjaQvrkLFP8Aa62K14lfXT8LL28pirMO2P3iG0eM0Opqd/UpnYNKiCtE94IwsZbtO9MzYr6bMYIxDGpu1iPXNaFcxoCoOpeN5URdIKAxRoAG5y3OzAthF9UjWK35IPW3TiyFBB2n6PwOoBn7KgGxjAmAvC40/oDI+tTOlzy0WVbDqsJoeK6M6atHIrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88v2M5VSMjRNLxJewWeTiQQjVCE2SF2oPXPZE5KqW1w=;
 b=iFCzKoioqqUKJIKtKoYApxuDzcxLYHwtELwXoq2otiXXgS70iBdZ/HX0Ezfs7icqc4Kjt2XONyVcSAtIc0oSKoIxyDjmFriLADMs7hO1V3ATldFEyGSDwQl8s1UZ+v1UltigdpLgJRfuYR9pt72Gmw4iSAaxL5r18nVqW8y/TmPoxSZiLFnxAooCfrnnBIjKXh8iLUmfW6ypV+ZzYR/m4p1mNnIFHgFIQqahzZ0qpNpALp06bA/OrDUSzHeMO7sMS/64/fJpe4saByPO1M26kh/O5861tQXUd0WpFcJyNnEmaJT7lZ6L6Lh3QE2TEToDvzHYcraZf7igFWA/qsSKBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 01:00:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 01:00:37 +0000
Date: Thu, 8 Jun 2023 22:00:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIJ5syQIVCPDMkZZ@nvidia.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n> <ZIHhgyUv7YmWsG3H@nvidia.com>
 <ZIH2h7GAV6qirAgw@x1n> <ZIIBhmoT7H2/q0lb@nvidia.com>
 <ZIIxs9kXQyULglIJ@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIIxs9kXQyULglIJ@x1n>
X-ClientProxiedBy: YT3PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fcdc84-9e6c-4464-ba87-08db6884efb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnI+nBlTwWI3f7iYpFULX6Rsc9vovLZvygCYcT8xZ8e2lB6CJFMmMbO3s3pFwWAEqv3L+aDFY9SRtiRIvh2gZXkJ9E95jmF5xL+NQwfuwbSKYmJZHS89ORCHFd8Gw3Vbn/9MIB5Kclqm0AzVjt/EOmN05jJImLMMOmE+1Lk3oktN5EAm8QdUMGK+KuoWgo3TAH99ztqFYX+AUefppLzcPmHHYZqhjxl9llF9pSDvnVykw3ggjlSB8qFdXNRAjjmEvDd7+CrSZabR3mFCtwFD3jYw1m4uyb76MCd6tWfSmt6GFGzgIn8KlZ8Zrz6YtTGwg3Zlf5obDpPAjj3YDTvsYEqahDkD5sKFwjd5VBMLWOVu6ikhMWUAOt5Ivzp8vT4l23mBoui5AILnHEzstFzAA3CKW2PI+zGA6cZ2/0Cu4PdNR4De/B1rkWKD0/kBHVnWQthERhAoiewhesNPdGONjD3SNtDpKFcbkq3SlJJ17fJjIVQPxxUQ8DNAeSLJV99IjCjsqEp7kMZje50Aqaob1B8LQjSflRSdRHtIS2yCB3vokdRnH8sokjd2Lur2Y/lO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(478600001)(186003)(36756003)(6506007)(2616005)(26005)(6512007)(6486002)(8676002)(66946007)(66476007)(66556008)(4326008)(6916009)(7416002)(41300700001)(86362001)(4744005)(5660300002)(2906002)(54906003)(8936002)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgnD/M/CE/gMi1QOIiKu2UID3XAa1MnEvo22HM1fbSzisVqKYfycFNIRrn1r?=
 =?us-ascii?Q?pYoD+vQO7/dUs0nFyo+gXK70BnNpRbMWZBu9VFyq47yyB6KDriE1dQn6/myR?=
 =?us-ascii?Q?1dFT/JVFuprZSSDMfbZvTy+L3y6UpeUY6KbOO4w2yuDBXwVrcTP/ltH+8kso?=
 =?us-ascii?Q?elkX4HbLtTIDlIyHTR15/7+4tROVkjrW38/rJdPZ8na69X90KJkSEw6ll4Uu?=
 =?us-ascii?Q?suIQGFc+x7hlJz+kyNkjUYKlWndZ3tH+a9ORMkdTKMX8Z+hYiO8d4IB8MgC4?=
 =?us-ascii?Q?7AzruP/VvKthw7UK/bcm0zUXISGu+PnMSHKr7d0czt3jU6EOrjn+XpU7mE0h?=
 =?us-ascii?Q?1a6pcfTDI1qj+J+UKTihxl7cAwl5Id7h9WRLJJSf+O8TQ4+DdCYNlhX2YyXe?=
 =?us-ascii?Q?3iQouqwioB5AXtrblvxvT5GSPdmaO6j4mUzz8cQv0xcAU7A230DmhoEuI1HY?=
 =?us-ascii?Q?ZPgP6EsXrbBmL28y5oBdg0j+Ul0MLRuU46IsrTYMy0xuv+DPuE8mF3wysmKw?=
 =?us-ascii?Q?lq/NNE95f2Z+ATMqkJzKgC/qALdq8Wc8eLdUxlSDU1YkMG0LOwwHGA4B6r4Q?=
 =?us-ascii?Q?rDtjrveBNa6TK/xSRcFrKRwnlzi7JD6/pqQTTniMkEIWR4FFVoaiERJQA3rG?=
 =?us-ascii?Q?AkyuS9aTS/QOn2+gSbfZmtKAk4MGz0wj9Xb5+ryunw7JN+MEha+GnBefWnD+?=
 =?us-ascii?Q?K9rcJ6U0h2OgNUp4my6JxvIbN1VKrvGhCXjLpF2AT1TsvXHL0txjZQg9caJ+?=
 =?us-ascii?Q?n8RlIDRXLpj1meqxCaYKNyeWHWRysHEHvVkx5LpUUD9gTWvcWLZNPaZaUdj7?=
 =?us-ascii?Q?FWHvb7UIXLxJopblsX4J2pp2hXWrWDhcxkwRSt23s0l6fvK0qRRayW1vZsAi?=
 =?us-ascii?Q?228BUiHRWnapPiyhQjOezZ/qyLEgPnDhzzDZn6UFvAbbAH9gz3UitU95m96R?=
 =?us-ascii?Q?z8nmHcTz+773JjX2M8gNS0ZOv7WYU4cguHbTaTcoPGTJeBvAZJ8ltYOxyn6A?=
 =?us-ascii?Q?RmLi1Jca3wYm5Gcgd+bCRxyPRCBkX+5f+Cs+S+QJFhpSsugwXk51NWlbMNJG?=
 =?us-ascii?Q?eMXMizNrGo1sr8PODHtqZM0E4OidD+Eyi0BmfyjYkNbREou7riMlM1kKMDJf?=
 =?us-ascii?Q?Qv80qGt2KoblDD/CWFLBX54c41f0XJOESB2klMziASWkUX1xCbSD0BmROENh?=
 =?us-ascii?Q?Tw9sNdBBgUO5ZHE0ifaLWw+zN59hddxGRujnjlK4UDGymZsePtQ6ImFnzS70?=
 =?us-ascii?Q?Dnk93jJYdd/7k8i6skvROfVKAKr/MFSiHq8GPTPeVRbOb+3oiFmlH4zcko98?=
 =?us-ascii?Q?Twccwf7T2Jr2NX0m18rhQZX+EIqEUsRmS8/rVJ+rEpcIYinnak+N/MTKwig+?=
 =?us-ascii?Q?ZTZwlrl4vCc9iviWVWR5UsimLM7aveNAgiYn+enqnRNUbbO1nEcbwSY7dPl6?=
 =?us-ascii?Q?mFXWz9jaQCY91vSMEHPYRoZILv26jDXP6c9Bv62+ejvVNIghYXx9bdSBWhtF?=
 =?us-ascii?Q?Qz63ubgA2zf3VeYP+4bNKR52p/muRIqNMzQRplFpJer1i0vXXukdT//Na0NJ?=
 =?us-ascii?Q?iSjcypZK9t08Vc2NfVk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fcdc84-9e6c-4464-ba87-08db6884efb8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 01:00:37.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h71of2fJ6oOURUQhTZi1ZflrULdVhm70Gw1ZEoDoOkGsfNHHj5WUU1mIijhuEPI5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
Received-SPF: softfail client-ip=2a01:111:f400:7eab::62c;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 03:53:23PM -0400, Peter Xu wrote:
> Though that does look slightly special, because the whole empty UNMAP
> region can be seen as a hole too; not sure when that -ENOENT will be useful
> if qemu should always bypass it anyway.  Indeed not a problem to qemu.

It sounds like it might be good to have a flag to unmap the whole
range regardless of contiguity

Jason

