Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5DF86D0C6
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 18:35:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfkIS-0007N4-1v; Thu, 29 Feb 2024 12:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rfkIP-0007Mj-DV
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:34:13 -0500
Received: from mail-dm6nam12on2127.outbound.protection.outlook.com
 ([40.107.243.127] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rfkIN-0008O0-I4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:34:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSaSKSedqq2S8dv1OpIcTu58M1liSnhTohFGnRRYjAjQuWzNimQ60tZqmxVJVLQTZB77jlPWvKlUGICZHBEdJVIrJ+viJ3d0f28MhwN/A1YZbmjJa7lEUPI3QSB4O/pmkSToDVPPC/d4Dia0VAuNI4ANbPMvFW+ICfBCMzpkfe+HGZ9zDbqd6gEXFFoo+cK9q6VHRdaXi59naMcFuCZvMFexKovoM+EGuMHxN7rlaqrmMnoUW9pUa+MXJhhkVpCZack8ZPQlhnfduacwPO7mAUAE8vXw8QN6mo1htdelOYko8EN7MQ+W/78yNzW8+6yLroqqn+BYPJekrBSsnN45Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoE971ZC/b0yIJClEpgfWPxbk8X8mWDgt0nO7DWKq10=;
 b=fZ+ERl1evYsGqRb5FBdKOPg7g7387rIgIq0vjZ9gfjzxuZlGUZwkXEjzV0+L5OmGbMnt8wa8XjsAPmjMc7ufFFp83mO/nVKZSgv2gTyTg15lPL4iNqvHqmCA/9FPqgXswC4SlmzAtJZ6UCOO2Pcal7JtkZfEOWgOWJ+2vJQr6zZja/d9ZG03O9h3e+o2F3v8znesQ9ukfvqvLSa4OEqGLpZUHcAacSvuSIBw4SJxDg+vD7AlB51/7no+eAMLCTtNa5dY/XGz15+ZdGlSSuwTfi3Few2VRlJctDkxlYjo1uqTbLKfKNVrhicrgkIRKvT25xlNinpKh3kyRxGN1OiaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoE971ZC/b0yIJClEpgfWPxbk8X8mWDgt0nO7DWKq10=;
 b=u1atIwJ2PLq4D+cGESHyKwhPk0qI4ujdtAgGY1HujQo+IsExD6FMr33ar4b9z6obCNNoM9Rj8O+h0hYQ6j3EtdWT/SxGYcyy/qIVML0XartymhDukKnaaLStE9ylSGU4z8cWOFYrQHEC0qERFMVZsq0AExEBcYyCwh29HXEJlxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by SJ0PR17MB4856.namprd17.prod.outlook.com (2603:10b6:a03:37d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 17:29:02 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::20e5:e2db:35fc:d24c]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::20e5:e2db:35fc:d24c%7]) with mapi id 15.20.7316.023; Thu, 29 Feb 2024
 17:28:59 +0000
Date: Thu, 29 Feb 2024 12:28:51 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Liu Jingqi <jingqi.liu@intel.com>, qemu-devel@nongnu.org,
 ankita@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, linuxarm@huawei.com,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Black <daniel@linux.ibm.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hmat acpi: Do not add Memory Proximity Domain
 Attributes Structure targetting non existent memory.
Message-ID: <ZeC7EO/fQKScG8Rb@memverge.com>
References: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
 <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|SJ0PR17MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: ded30c67-ddb5-4f58-75c0-08dc394bea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9NO93oUWSkoBGU0JFVwAImsQoVhxHY+hLjXJc6fng5CzZQJ1L6FPU9fbTeEFSV87LSHo36J3N7fCfKhPBKP1Om8ztfh/Sbt8JHvoXj30VbTqObOisTxLgFxlyxY6b05bPZeAfHGFL8qbiHPHIPd2yGm8ZEzlqdysYyswbbWIAXNMT+1lC0vkKnzxQftKHFYQsEK7RzbedPP9cOmaViUXOvnn4n4A7F1PTusELlnFnCzTREiDygRcnhHmWtK1gsUhNlI2vJPY7mlCfLlfg2asEIOjBfCY79Fw+JYOM5zQXTv9RFCYlxYWwmei8eSU8q12fN2tUvh6mJTKflK7xOVRj1/DZ+04nor2Yv55LSVec5WFnP7Q7nW+iPoYiCiT4tHD0Xf1aHCYwJNO95mXX6qbdw6pgjq1n79ILWgDzZeDEhwBWRZNXYB8s6R6bql76Hyb88aHYnms0ZCsRr+0qsOVr3pVfHqovo5xV9vlMxO/b+NMnhiqv+Bn+RBpVfQ2Riv+B8IcUGzLsXw7uKg7ZWMri9Gfx1y6Zmnp0rD3jJszXnOhAZpsL9iB85SmYEc82KmurniiTInVvkAWfFjdgn6PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR17MB5515.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VTylwouK7fYdQSgnbrMB82D3nTYQ3LW7nrvYP3Dj0oQU6hiOTDWFy2T0EXu?=
 =?us-ascii?Q?nrnFVWPIUBYnp23h6es1C9WTSuXGL0WRiScdgEXfrQDAfchwTSbiNYGrOQa5?=
 =?us-ascii?Q?ByOvIew1Ua/hHlCnvdmaoR8fWy2oARuZBaRLPiKoJmrO98PONbQl0V5c/9Zt?=
 =?us-ascii?Q?IiXTb95VXJ92gIbgCGKVrdaMJvMf2c9pnmdZyXitf8e0B7zZ3zp7mfxRO7tW?=
 =?us-ascii?Q?v94H4O1Ge79Bn+TeOV9dsBghJRikBY0N3mnVCupUcXKrAc0jfVqvmp5jN1lD?=
 =?us-ascii?Q?CgQpTgmUB3kTaayI7KUmbg4LVc+IRNfhxrIPMBmDiNke8Bx257XcEfzCYAYI?=
 =?us-ascii?Q?qgfG+yKQWpMk8FXMbqCsZL3g34M/FbogKfVKNGcCuBWyMjXK2Nk30TsgzZ3O?=
 =?us-ascii?Q?Kkz8Z2uYw23ebMx0wHfliDhQKRP61+INu+N0oxKPT+6SxeAtqxjIG1gAmAS2?=
 =?us-ascii?Q?PTBpj7xwTPu0RwIdl8Ob+DJ8DPPpzp1//vFCVFoi3X7kH6k0lTXgELDYo6G+?=
 =?us-ascii?Q?raKuYcuQO4FbIE1AH97ApK2KK8628DpiTyNzFWbD0qDox9HWYwqIKnTpK9ck?=
 =?us-ascii?Q?bpqbPRmbpIqFVKHCiPCTHJfPdkCbkSNTAxQ4hqP0TzWEXvGYsZ55oa59as9P?=
 =?us-ascii?Q?2VCCnuBcBLXUD2fqSiLyNPb7NbeQrY84bTMz/Fey0DEgUxhYedRVJyjkT+q7?=
 =?us-ascii?Q?PB66jnBr2Tjis7uOZ6LTXnCzLh0hA6eduV4wKmjfaN2SzoHVFqZ1nnQVYrgM?=
 =?us-ascii?Q?D8zD4U/FyxeJUctN+P5P3RRm88nUSMG844qjnxqqgwySwqpDsLCGcoeNAGIl?=
 =?us-ascii?Q?v0ZZMtNbKxE63nMDlNRGSUrs9tCp1luL7ir2oCJNIkMTWL9ADdjRRBiz0V3y?=
 =?us-ascii?Q?Hh/OLjyDar7PATH7ZBycLJMHbcxj06o6W+d/8dGkBiw2tdm9dVxTjbdajxFL?=
 =?us-ascii?Q?iVNvwiNPt9bK6JdzAl9oJ9snQFmmQ7fWBxsuMRDCnyu5DNTasyBvY/Bzl797?=
 =?us-ascii?Q?iHsT8uafLHhKWG+KUi3H3w3Rzbl41KRWZWTaLX9p8/H5x1VVMbGv2mAPkxff?=
 =?us-ascii?Q?qbEpSPh9cn3TsYEqckbuEOOXywO3HyakGbnsuxWl9FjfoDmwxUS1ZdUWOqrG?=
 =?us-ascii?Q?GldUFX0H44kOW3lHWhOgkz4ph0xZNYol/eqZhSa7sVH3QzNWuzMc8jFjtIhY?=
 =?us-ascii?Q?qV2pb9brMHLIVLGszlvb1w+WesDQHvwSE5Ehux2oRGUT+I6IJrzsYEh8VuEf?=
 =?us-ascii?Q?ImxX4yIh8ZbvmTZbs1paESrbCACLq78JHusIDb2mFtvl70SXyYXupkSu3iTq?=
 =?us-ascii?Q?ytu7OA7S9n+P9d6tICzuVpOoQ1FLotMGEoy4Gxlg8VrNN37ZRBvnrAknBpMB?=
 =?us-ascii?Q?tqwj7yElKFOnOcyrfgmAzUpTksMcgDREYUM2aYTrSwgvI+gInJvOzTG9735+?=
 =?us-ascii?Q?9GuuqEbsBu4NFDAy1iQ2/eBLttWQGCEX8WxH+jJvQ1QL2zmkyF1z1cgeqonX?=
 =?us-ascii?Q?2C1EeOhL9wFEMKQQMqpe0FoDPPZGeoPQXLI/0oUafBA7hrUkwGVr91KIKFGh?=
 =?us-ascii?Q?fg7g/4i5etthGBxiuxHMZDEDt2VAcWUYPtg7EtuZvpgqUzWQ2hSvpKWQZ5bk?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded30c67-ddb5-4f58-75c0-08dc394bea3f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 17:28:59.6163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqWSasfOM+GY7nijyZQgfvl8N8Tl+tQbpaJMDhnSo8cgdbpnUCgu2YADOHzxUVVU/klydaF8YjGYrPRqNXF7woMuJrBzXgVNvGZPqdIWAco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4856
Received-SPF: pass client-ip=40.107.243.127;
 envelope-from=gregory.price@memverge.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Feb 29, 2024 at 04:25:44PM +0000, Jonathan Cameron wrote:
> If qemu is started with a proximity node containing CPUs alone,
> it will provide one of these structures to say memory in this
> node is directly connected to itself.
> 
> This description is arguably pointless even if there is memory
> in the node.  If there is no memory present, and hence no SRAT
> entry it breaks Linux HMAT passing and the table is rejected.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/numa/hmat.c#L444
> 

Nit: This link becomes out of date pretty much immediately, consider
using a versioned link.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/hmat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 3042d223c8..723ae28d32 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>  
>      for (i = 0; i < numa_state->num_nodes; i++) {
> +        /*
> +         * Linux rejects whole HMAT table if a node with no memory
> +         * has one of these structures listing it as a target.
> +         */
> +        if (!numa_state->nodes[i].node_mem) {
> +            continue;
> +        }
>          flags = 0;
>  
>          if (numa_state->nodes[i].initiator < MAX_NODES) {
> -- 
> 2.39.2
> 
> 

