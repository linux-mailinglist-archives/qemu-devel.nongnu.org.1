Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5D8502C5
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Feb 2024 07:40:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYh1g-0003oT-18; Sat, 10 Feb 2024 01:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYh1d-0003oK-LJ
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:39:45 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYh1b-0006aY-RE
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707547184; x=1739083184;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=52FnZgmnbzyDSfhvCsqGo9MuajnL/H30/vxrUVgHjV0=;
 b=ivkyKTSbzEPH9hwGPhRKLnqrsGIeyoy3pICRJ7wN+RFqia83vCaCQs1G
 zVAlJPKrB+ZjxL2+6Ag5pFcVbtAUVR3SgAsYaMCLTPP+VbedcIkWU9XSe
 1DpZNEDw8eHZiKLWneAVFjO+aLPbqdwpezBhfB0B8S7GahRlGZ0HQH/FN
 kzqLT5uzQ5pNhNjy+H6uMmbmQJ5Ib4TK/Sor3UeGYV/uVI6VzYV3sLX4a
 I/82yrn2Bifs1AZuF5CV24tjuiyIT91ElYTnz6AKgzaUSSe0M5f1csMNM
 zpdmMyJCC3LHP3ViFHXvl/zBkeRCQzedHqGTWszBt/JO5EwsDMwRRj4kF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1442021"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1442021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 22:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2110467"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2024 22:39:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:39:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:39:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:39:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksni9lTHSDU8stqJMsjV6TjMPJjxp8VQsGdUh6r84eVmdY+42e8akMugZLf6OxuOfCm0FVq4PDPakl0hJc05SgyBpjvTGLcjTi9q+Vh4czscmPqAdcn7jm0Yu4hYYEHHOcl8BXAZhTdEWttxjVGJfvdwhbePPuJSScu+yUeuD9oR7dBip1Ok2qko0FHJBMSa42TPS2NvpX0qG2AIcY9Js2eW31XWbIFlvZudTbDQ852BQN/DxgfiDtXCf99bgWBGu9Yjg72hB1zKgp2OXxrmHek0ufnv5M5WuLY5e82nrfbNkw1DWUDcwRqQOHtYcbiQR3mdcd9ZqzsrdtBD3jo9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH4oPWa6gRMpNQm92jKSibvVaixRvgr/HaVcG7Rvc5k=;
 b=JMBbWPX9JmsK4wmk9DJipxwLj4V5NQlaMFUVUxseYvEPuYoF9v3xZ6QfvwwY9WVc0EbVQn6jOT9QBd/Z/KWRdyqZYIzxX/CwnFhlOt2bm0eQ9PgOsPB9nPMieQGECEaXCAa/C91Y8wtgpOcBfTFfftiYkBKta1iyUa5r7t7r+i0rm1iCBMrj2uAfdpSObhSiIzGRweSN7jxixZ86OOPOJZcg9KqtA+iW39avNDCjYJnspGUryHFWyzZT6u4Q8fMbELMXgrBAPOUXUvTqdyKlRy+j2tB9PtLVGxlF2w7e9zEMIdgzZkwJHJZf9ZQBuv4r8b9Ib9tZdBBdJKAxAxsf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Sat, 10 Feb
 2024 06:39:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:39:39 +0000
Date: Fri, 9 Feb 2024 22:39:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 2/5] cxl/core: introduce cxl_memdev_dpa_to_hpa()
Message-ID: <65c71a295f47f_d2d42942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-5-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-5-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: d93180b4-8227-4c61-4df5-08dc2a030e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clPG1UlsG15/edc2BgK0iJnvYuaj4bQBmSGa+8SCcXoOlxPKX04pcQIB7xTTD3yabXx54ILUz52BShXuiA3eyQdLJP1iwc7To971kdt8scwIwmjHZh/lYrjxXA2y8UvbMb2lU8nb5AZJ7GqE4nf7v2J2HvfvrLI9PC6XCj8VYAXAQDC/yUH+6N7WDk8NiyzF/35yV85IxioFyDVibMe8X+lRh+fR35IeTmibm9ujDKazOHL24JBDLwo6rtkobk4ZZpmQXbGFsAFtxX+svPkjfX5plpPEXNLV1N/PmI0MsG1E1FIjHakqSzpY19/Wv5bvnouuuCgrSRb343FmFsBSvQxiy8nX4aAfO1JjWJNBzN+7NFhBn9mIAz89jQSAuklThX8ybPtkMK1WRv7R6KqddV7hUpeiag3RNok5OzKtUwoIwxYmHJa2nFKgFBBR3reW7wS9Rig88dWos0eqdUsoMqT92LuYdJVlMfxgHkGs97pzcwdTQydT9a0MS9+2MKm10Jt/ibt66UrCfvbGcy4/om+VA0QYw840guDsuHQQB6KtjyXbJWd7h9NWlDgE2qTT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(86362001)(83380400001)(38100700002)(6486002)(26005)(316002)(478600001)(66946007)(107886003)(6506007)(66556008)(9686003)(6512007)(66476007)(4326008)(5660300002)(8676002)(2906002)(8936002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z18/UonYCXjXwotV8ROoaSbOkB//ta66HIrVYXqw/4p/24FjRPk31CpCWKpp?=
 =?us-ascii?Q?OKcph+yjS5XR5bbr1a4HZ/1QpjuFJRuNm/M6FUSTSZW30M6naH3vnc88zpMF?=
 =?us-ascii?Q?c0NIXE9I9lRUw/2NO3KxzrK2U03m1kcR0viIxuf8agoBt9ZMJ5GJtcMcKcai?=
 =?us-ascii?Q?95fKI2WZqtH48RSzuFXeaQlcePYMb/jMvT9bcWdFSvpTIXqrqZqK5wt+zf6f?=
 =?us-ascii?Q?IY9KBg24MHzZgQaIuw8paIad1ynKlsAcllF2JVjgzPPctANHDUclQQBF6NQ3?=
 =?us-ascii?Q?BBa851uDhNzSR2L784Oh6PEjZ9thKAWMrsyD1w9XCgcypxxKlKfVJFLpWBtF?=
 =?us-ascii?Q?dLzKzDaLaOhBZHFAEe3CoYYIgJ3mrYneLidsg4jiqs1rHAQkaDRqvccBPbxN?=
 =?us-ascii?Q?AxbwHXapnKMvCnhrYu7hhv1NqykXUoeZIBk/YQ+ukhEMgrL6I48MjK3RczMd?=
 =?us-ascii?Q?wdFtwcskrmDXdC8ILsqPf41matTNRhOvizhvNdpwRkBXoEt5/1kvGiMV5rAi?=
 =?us-ascii?Q?V9kcJ4D1qP2mKCKp+AMea+xETL5UeE8LbAfpyBa4LCznVyAdO7M/UBpGdgnN?=
 =?us-ascii?Q?PXMfOF6uaAALCkw+zDK7uA3KWe7t01M8e2lZXj9JHH0jIIPAqQjNfdj6WnV4?=
 =?us-ascii?Q?S/WRRW8nBY8pc+XMr9cE1rND/txEZhqctMVSvY6RBFd/m2RvOjGSg3fGQN2W?=
 =?us-ascii?Q?Scqus+gKIVyVxLIed0EPlsmBDvetYjH4A36ve+pVgZAHAk6OsR2y11y8C0Ub?=
 =?us-ascii?Q?unFBdkPRqxIkEqkt8hcEQQ3qKufSCYEUDe9oXG2yP/tDUccHscHv0KVHLEZe?=
 =?us-ascii?Q?SZOMDFeNCz5L90eYbeZogcT7VD3HXkx7N287y2HTrRght4SmVLzR9DfS5xFF?=
 =?us-ascii?Q?s9M9XuQDFADM5CpHIf1ht+LPUqwOH+4ap6WvI3icjs1mIoe2alqcm3msCdxR?=
 =?us-ascii?Q?tTPErOFCt4xQTnStyc2nI27OCzSPDfBGqHBegWuRJAuPyk4Tyy2UxRekWfjU?=
 =?us-ascii?Q?3j3bumyNHh/LrYno6IKda2Gv8btfKksVL+DXbL0MPz5rIgaDMI3TQpw9Ar/T?=
 =?us-ascii?Q?vrQD5nMywWfLe9DUz/eZjN0OowUkz1XXcao0UVCTpBvItkG8+SvKQGXOvgGS?=
 =?us-ascii?Q?STdRuJYPWjaome7Jy2pN4toqiMkljrNSNKMmbRS334RobhdQ6uZ7VraF6PlF?=
 =?us-ascii?Q?1MeKRN1gO6iijG2u50ajnbs9izMNvznk/dHWpALftWgQus/Q+HDlCFCfsz1/?=
 =?us-ascii?Q?Fu8fGekEJaX/FVaeDIpuAk5nidahtI2qArsFJQpnpgmXLBYRRMCIYyJf6fxA?=
 =?us-ascii?Q?havzbLhQZ71sgPKUK7LlgZ0+zaW4CZe0Hk/5UNE20qm3ekKBjl/BO88dbfPT?=
 =?us-ascii?Q?dpMSrj7lhBmGAwlduu6Mx5I4Elv738BxROTTOrVrSY6K23cngeFXDejqb5iH?=
 =?us-ascii?Q?pnIDZhxm5hk+uXEiDXLu1V6XciL+yhz4j8IQdjKNhkazq5KjW3V0UuO7Gzhf?=
 =?us-ascii?Q?AL0yd4QV/Dhwsuv0yMush2kDnVfwGRymQ8E4Vb1GxbLAIJNanMEPGGaL+EI7?=
 =?us-ascii?Q?stxPHdP7UlEhfpwpxtXXmbI531a4upT/HPpqKmgr8WezDahr7gbgrnLmXjIV?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d93180b4-8227-4c61-4df5-08dc2a030e4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:39:39.4170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6L9OYk1filfmSIE2e0+MULIj8xZ0kHKzyfWFGW5kpbf1AhZa+k1fBoEJlvms3q7CKHkTYrz2M0WQRQFPOTwZVZy1u0ygVCL1kTygPGGYmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
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

Shiyang Ruan wrote:
> When a memdev is assigned to a region, its Device Physical Address will be
> mapped to Host Physical Address.  Introduce this helper function to
> translate HPA from a given memdev and its DPA.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/memdev.c | 12 ++++++++++++
>  drivers/cxl/cxlmem.h      |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index dae8802ecdb0..c304e709ef0e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -319,6 +319,18 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  	return 0;
>  }
>  
> +phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +
> +	if (cxlr)
> +		return cxlr->params.res->start + dpa;
> +	else {
> +		dev_dbg(&cxlmd->dev, "device belongs to no region.\n");
> +		return 0;
> +	}
> +}

Hmm no, I would not say memdevs are assigned to regions, *endpoint
decoders* are assigned to regions. cxl_dpa_to_region() is only an
internal helper when the endpoint decoder is unknown. Otherwise endpoint
decoders have a direct-link to their region, if mapped. See usage of
"cxled->cxld.region".

