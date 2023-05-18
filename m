Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6470839F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeLq-0006eJ-9y; Thu, 18 May 2023 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzeLn-0006dv-SD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:11:27 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzeLk-0005BI-EJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684419084; x=1715955084;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iIrtEjr81jUvLviFiFjpS2qIwF/i37Ad0/g32Vg0Xsc=;
 b=apKYFEW4GhhJtfEglAylPU+FLiUfdRVSwvBPv4k6wnVWjMlB9nOHvYWE
 vONJDOH7SYfOat5MWBmMABDLJBM1nqqDXEUO5H0u39iQtMyMykWLJBGlz
 S5XdOgl1h4eb8+W9ikhsaXdOp1hRDGH6TYJ9f0YH4z/lJDrqqN7RG9JPy
 pa8RwZQdpiq3tEn1Zzi1rYFVWSKq1E7lTm4c8kUlrjnxVCXBWv7vu621H
 7btrXmSNEsyG+yD6tbRFvgAvNBAEKw16hTNR81nw/4bx83yLEznc+U0Da
 CTmEPMASbzekhbslehExj141mzldzZxwof2QBfCsIgf41UqiuJ2kuM/Rj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349588772"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="349588772"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 07:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="679687833"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="679687833"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga006.jf.intel.com with ESMTP; 18 May 2023 07:11:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:11:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 07:11:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 07:11:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyT1yDY0wHz2PAJN3sUCTtre3aodusDMMya9CiJc6namG7quIlThsjiuGUK6vkTr17ys+g9jYx/MFP3oTNWliHEIROwbbevI/3qU0Jzv6TN09bKKdJx3GJuH1KuED7m6wgvnpsuC6lFCKTrpT3qlvcATt/9/dNWptJr1O8+jS3UOPL3n6x84cWOjsEtSgTajKiXFuSoB9jGMcCdu0EB/818S1DXDcrFrbzbwi4N0sWwCKixX5oVtok3nWjbNyEmodnpWj5VX+6sWGIpk8I+RU+SwVDDLWocTqDX4lPYha87HKiJm3utvyNn3SXwGcRhygwK4GzFIpYdQMnUsSIZG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic7DabHvQ/+clhMDcDo0LUYg1O4VvLXV0Cjmo8HINVc=;
 b=hVl7d12mpsdGHlxxJSJ4twAwJU0Zj0lcRiQxfOW3+bvWXlEDryZde5kZinwnnNOF+8r0iMbMi3GsOQycDthfet5R308PTtuZ7UbKijguXURhzK8nO+dyVXePDL/Sf2Pvl/dqrC8RDVvtRAJVrlq5l8nYbfxEY6U3O8ZlZ60SmqM36ERt8+hQNG3VzN+dsjWSifZ3+YAgZUzSbZmZQaBQXto3S6J+axNOYlUzH1pk8kqEl5WZ8hU6m6Tbg8kGEuKuqoBXovOfXn1TEjU8FruNNNB/h2qWjCA2xyWfniR+nNeHB6RwvJvUhnTx2K/8Ns3O7hAxumANxivufhPAuZUgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 14:11:17 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 14:11:17 +0000
Message-ID: <6fa10cb0-16af-2f3a-5d40-dda93f64b7b4@intel.com>
Date: Thu, 18 May 2023 22:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 10/15] monitor: adding tb_stats hmp command
To: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-11-fei2.wu@intel.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230518135757.1442654-11-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f86f643-7e2b-45c9-f89c-08db57a9bef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m/wQf/ij3+vf8DL2tGNP29ZjUqZbgT+/FFhiIh0k9jXCPMnbYWsQGKO7xnR2rGy0rVCdJOmvnnX5hQZnr4x9NOCHBeJ3R/uyazjvw+hCzSC2RDeBSn7xmbHCM0o73QDOrKe4Uku4S5lK+WhzseHRmfCAVV+hGRzQtPvdT0bZxd8Dw0WUOrePccFJephfbWPWa+xuiPqthFCbVaZDDZWhz9UbYxUSvgJYkFF6bTI5AK6fiKr/mLrdsJyEhGBq4RqlceMlvOkH/PknaSvKUf6ZIbM98jiFkzIed978OXsB6IgWO9k6y4cQ8djQ2fn7596+WOJvnDDYBAic5Jyvd/8S+z428a0FGt9rhAFmvN6MyxSFMvzSweE/w4PtUtbAvC8uLSMw5IYKzikLSIY13fHX68gC35IoKhpzUq+m35UAk0FlQvLLkN9lTBVIRgqxLH4ha6Ntu9Ou5Qbnt6d5MigAMtS7+a4j0Atc9K8Avdw0swWXSfG6wAmQEg1zJmX39BYKiKgKVSsXQ2DlK4sCSzH5K1uj0q6mzB1UZxcJXKFlgCB0HybA1gvXht7VGYweFZUU/qto5cL+3Azxu+qVaRPblpDHKZohwLrXw2QnD32XB5+3hAogP10ZQ5g9etKYD32qmKhkcyJqqan50alGJgGuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(36756003)(31696002)(86362001)(54906003)(316002)(66476007)(478600001)(4326008)(66946007)(66556008)(2616005)(82960400001)(8936002)(41300700001)(5660300002)(6666004)(8676002)(2906002)(38100700002)(53546011)(6506007)(6512007)(83380400001)(26005)(186003)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlYM3ZPU1Vnam1SbjlXdmVPcnNPRXFLUkhJUHNadkVGaVhEYitkWmcyc3pT?=
 =?utf-8?B?SWtzTTJ2WWJ0U3U2enNLNmRuZVFRYXRzMFRwSkdrdG5PTmRTeDVGRU1sd3Vk?=
 =?utf-8?B?a3FrZXdBcTdpRXJUeU5tWDhSVFA2SGs4bmpEeEYzOVp2bldiUHllSmhMWFlp?=
 =?utf-8?B?S2JEb081RXNxRkp6M3dUNFdxM2Ewc2Q3bjZQV20rSi9mSExZVERSR1JIQldG?=
 =?utf-8?B?MlkwWjQ2TjU1SGZoWmtidGJUQjFXNEt2VUZxNVN2anBvVmhQUWdwbllDYW1y?=
 =?utf-8?B?OTFVdGNhN3Q5WDhIckFRampjZW5uVGsrYVIyeXMzR3RtYmJuWFp0cGJWUzVS?=
 =?utf-8?B?dlJkUlFCYmJOQWNmYitveVFsd1FET2tNZFRjVWZOUjFpdXZ5bm54TFoyNitS?=
 =?utf-8?B?UEc2TTJIL3FOTXZQWGVkb2dVbVFWQWVQMnRGKzFWa0dYOHNjc2pmMXFvT3lu?=
 =?utf-8?B?ZVlyWkZ2dTJyUXZDd0x6Ui9wNldUTGR3bVJRekkzMWJOVk1IRDZ6MXVwcTFr?=
 =?utf-8?B?citycXJ0dEwwL0ROT1NZVldqblJOdVFjZ2pOYkpFZWt1VksvM2lsVVVZWHZP?=
 =?utf-8?B?TEorb0ZyL3BkNC9QU2NoZFNGcGY5dDdzNE1Pei9lTDZkWklieGtyWGdNckkv?=
 =?utf-8?B?eW1BcWtJY21PMkNMUTRCWkhwZkRQYkhmZnVTdkZpOGhHcFZGRU5NWFUwR1cr?=
 =?utf-8?B?UWxOVVNxck5WaFYxMUYzeWZXOGh4TzNGeWc2eVJtN2tCOVlxNmxzekR4ekt1?=
 =?utf-8?B?TXl0K3Y4dEVlTlBXWTliWVZEUkdoVTlZeDgzaWk5YzlBMW55YVVNQ3lQQUw2?=
 =?utf-8?B?YXhPMEMzMjFTTFZ3eU9FS0lsdlBTaGhrb2JlZ0lmcTg2ZlQyUmRza09JUU5S?=
 =?utf-8?B?V2NYYTlKWGFrZnVIYlc3NTRiZjhnbHVIZityOHF4ZVhtUXhOaVJaVG5ZdGhX?=
 =?utf-8?B?by9PaGh0S2xueHVmd0hwWmdVbTNrOGVRRWxIV0ludGd2bkJ6YlBYbDJDbHhh?=
 =?utf-8?B?LzZsQ1ZwTnVoTEdLR09yZUI1NXRvYVlleHl4Skl1bFFaK2tnNCsyaU1wT01C?=
 =?utf-8?B?RTE4SnJMN3MxRFpCZTNMd1RNbjNUNnVONGprbEZDY3cwajdsMkplTm96cE9Z?=
 =?utf-8?B?VEFqb1NycmJkUjgwdHM0Wm1aZDlEZVk0R3VTNFpzbDg4S21jNTlDZU1pVFVs?=
 =?utf-8?B?SU42Z1NmTHBFOHVBRzI0aEtWMVZJRTRVdDVoUkV6c1FiMDFkc1dZYWU3YktN?=
 =?utf-8?B?MVRva2ZsNy9EYUNaQjRZSVJNRWFocmUwbDJWN2ovTGhMWkJQN0tleG82YW9H?=
 =?utf-8?B?anVVTm9FQXRGcUpWS2pONm0zQjlGcEtYZ3lxcitnV3RrbDZ4MGwrTHhSY2dH?=
 =?utf-8?B?SGljQnBsVGRpS3JrZ1JLM29ITEJ3YmtCSC9mclJKZHRYNE55U3pNbWx4TEli?=
 =?utf-8?B?bzZHTzA4bXFqYTJueU0xbXI5Tys5bnR3Zk5OYUU2U25jVldNZWdBekhwQkZz?=
 =?utf-8?B?RlpDLzFjTWU2SEcwbzU1YWY2MWhRdmcwcWhZd1NBREN6V1cxSnVRRHB4YVBI?=
 =?utf-8?B?UXVYVTJnanF3cXV5NEpIZkFhaWdOQzdxZ0hIUnBzVGxZMWZJbUVDck4rcjZN?=
 =?utf-8?B?Z1NHUEF5L1RlNU1nQmNZbVVqYUlNa3MvSEUvN25iSStUOVU0K3ZST3draTdi?=
 =?utf-8?B?TXduNGQrd3BJUjQrSVcvMDBXUkRMdXVWRGxxQUE0ZDNMZmpheTRyU3Y5Q3ZF?=
 =?utf-8?B?V3dldTlhUy9KWVdFN0JzZlJqSGNJd3NUMEtaVUtrOWtKT0ZKa0ltdXBoNU5W?=
 =?utf-8?B?Z2NyMElBSVZ0VFFGbmwwUGhWbkFyM3hHK2hpbHdOeDIydVY4MGRnTjQ1SWVN?=
 =?utf-8?B?NSsrS0lqS05OdzA5SHBzcUV2VzFmbGp3amZUOWpVRUV6UE1JcE5RRG96SStV?=
 =?utf-8?B?SmdEaldBUStaQnhOUytmTTd0WmZjYnlKVmZ5QmFHeXdMeWdXVVk2cFhJc0sx?=
 =?utf-8?B?NzYxaFprNXdmU21UTEV0Z3dsNHAzaEFtYVpxREsrelVUQm9DZkVxdzhUU0pX?=
 =?utf-8?B?dVhEVDUyK3ZQazdjNDJzSkdwZnpDa3dZTHhIeFVIUi9pcUdOajJOcmxJcEhN?=
 =?utf-8?Q?OEkV660a7DLTL3cENq5k8RhDA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f86f643-7e2b-45c9-f89c-08db57a9bef6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:11:17.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m8+fcsBYuvgE304XAftBqLH9otwaVGGoBxNBGXBgx1IiAekG79svjy+c6CRNgnI1q0OZHK+rIvFV4BBDqYwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=fei2.wu@intel.com;
 helo=mga11.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 5/18/2023 9:57 PM, Fei Wu wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> Adding tb_stats [start|pause|stop|filter] command to hmp.
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
> 
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
> 
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
> [AJB: fix authorship]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  accel/tcg/monitor.c           |  45 ++++++++++++++
>  accel/tcg/tb-stats.c          | 112 ++++++++++++++++++++++++++++++++++
>  hmp-commands.hx               |  16 +++++
>  include/exec/tb-stats-flags.h |   1 +
>  include/exec/tb-stats.h       |  10 +++
>  include/monitor/hmp.h         |   1 +
>  softmmu/runstate.c            |   6 ++
>  7 files changed, 191 insertions(+)
> 
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 2bc87f2642..2e00f10267 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -11,7 +11,9 @@
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
>  #include "qapi/qapi-commands-machine.h"
> +#include "qapi/qmp/qdict.h"
>  #include "monitor/monitor.h"
> +#include "monitor/hmp.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
> @@ -87,6 +89,49 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
>  }
>  
>  #ifdef CONFIG_TCG
> +void hmp_tbstats(Monitor *mon, const QDict *qdict)
> +{
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +
> +    char *cmd = (char *) qdict_get_try_str(qdict, "command");
> +    enum TbstatsCmd icmd = -1;
> +
> +    if (strcmp(cmd, "start") == 0) {
> +        icmd = START;
> +    } else if (strcmp(cmd, "pause") == 0) {
> +        icmd = PAUSE;
> +    } else if (strcmp(cmd, "stop") == 0) {
> +        icmd = STOP;
> +    } else if (strcmp(cmd, "filter") == 0) {
> +        icmd = FILTER;
> +    } else {
> +        error_report("invalid command!");
> +        return;
> +    }
> +
> +    char *slevel = (char *) qdict_get_try_str(qdict, "level");
> +    uint32_t level = TB_EXEC_STATS | TB_JIT_STATS | TB_JIT_TIME;
> +    if (slevel) {
> +        if (strcmp(slevel, "jit") == 0) {
> +            level = TB_JIT_STATS;
> +        } else if (strcmp(slevel, "exec") == 0) {
> +            level = TB_EXEC_STATS;
> +        } else if (strcmp(slevel, "time") == 0) {
> +            level = TB_JIT_TIME;
> +        }
> +    }
> +
> +    struct TbstatsCommand *tbscommand = g_new0(struct TbstatsCommand, 1);
> +    tbscommand->cmd = icmd;
> +    tbscommand->level = level;
> +    async_safe_run_on_cpu(first_cpu, do_hmp_tbstats_safe,
> +                          RUN_ON_CPU_HOST_PTR(tbscommand));
> +
> +}
> +
>  HumanReadableText *qmp_x_query_profile(Error **errp)
>  {
>      g_autoptr(GString) buf = g_string_new("");
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 68ac7d3f73..55afe6e489 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -16,6 +16,7 @@
>  #include "qemu/timer.h"
>  
>  #include "exec/tb-stats.h"
> +#include "exec/tb-flush.h"
>  #include "tb-context.h"
>  
>  /* TBStatistic collection controls */
> @@ -28,6 +29,8 @@ enum TBStatsStatus {
>  
>  static enum TBStatsStatus tcg_collect_tb_stats;
>  static uint32_t default_tbstats_flag;
> +/* only accessed in safe work */
> +static GList *last_search;
>  
>  uint64_t dev_time;
>  
> @@ -170,6 +173,102 @@ void dump_jit_profile_info(TCGProfile *s, GString *buf)
>      g_free(jpi);
>  }
>  
> +static void free_tbstats(void *p, uint32_t hash, void *userp)
> +{
> +    g_free(p);
> +}
> +
> +static void clean_tbstats(void)
> +{
> +    /* remove all tb_stats */
> +    qht_iter(&tb_ctx.tb_stats, free_tbstats, NULL);
> +    qht_destroy(&tb_ctx.tb_stats);
> +}
> +
> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
> +{
> +    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
> +    int cmd = cmdinfo->cmd;
> +    uint32_t level = cmdinfo->level;
> +
> +    switch (cmd) {
> +    case START:
> +        if (tb_stats_collection_paused()) {
> +            set_tbstats_flags(level);
> +        } else {
> +            if (tb_stats_collection_enabled()) {
> +                qemu_printf("TB information already being recorded");
> +                return;
> +            }
> +            qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE,
> +                        QHT_MODE_AUTO_RESIZE);
> +        }
> +
> +        set_default_tbstats_flag(level);
> +        enable_collect_tb_stats();
> +        tb_flush(cpu);
> +        break;
> +    case PAUSE:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /*
> +         * Continue to create TBStatistic structures but stop collecting
> +         * statistics
> +         */
> +        pause_collect_tb_stats();
> +        set_default_tbstats_flag(TB_NOTHING);
> +        set_tbstats_flags(TB_PAUSED);
> +        tb_flush(cpu);
> +        break;
> +    case STOP:
> +        if (!tb_stats_collection_enabled()) {

This check looks not enough, it will result in STOP as a nop after
PAUSE. And do we need a STATUS cmd to report current status?

Thanks,
Fei.
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /* Dissalloc all TBStatistics structures and stop creating new ones */
> +        disable_collect_tb_stats();
> +        clean_tbstats();
> +        tb_flush(cpu);
> +        break;
> +    case FILTER:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +        if (!last_search) {
> +            qemu_printf(
> +                    "no search on record! execute info tbs before filtering!");
> +            return;
> +        }
> +
> +        set_default_tbstats_flag(TB_NOTHING);
> +
> +        /*
> +         * Set all tbstats as paused, then return only the ones from last_search
> +         */
> +        pause_collect_tb_stats();
> +        set_tbstats_flags(TB_PAUSED);
> +
> +        for (GList *iter = last_search; iter; iter = g_list_next(iter)) {
> +            TBStatistics *tbs = iter->data;
> +            tbs->stats_enabled = level;
> +        }
> +
> +        tb_flush(cpu);
> +
> +        break;
> +    default: /* INVALID */
> +        g_assert_not_reached();
> +        break;
> +    }
> +
> +    g_free(cmdinfo);
> +}
> +
>  void init_tb_stats_htable(void)
>  {
>      if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
> @@ -204,6 +303,19 @@ bool tb_stats_collection_paused(void)
>      return tcg_collect_tb_stats == TB_STATS_PAUSED;
>  }
>  
> +static void reset_tbstats_flag(void *p, uint32_t hash, void *userp)
> +{
> +    uint32_t flag = *((int *)userp);
> +    TBStatistics *tbs = p;
> +    tbs->stats_enabled = flag;
> +}
> +
> +void set_tbstats_flags(uint32_t flag)
> +{
> +    /* iterate over tbstats setting their flag as TB_NOTHING */
> +    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
> +}
> +
>  uint32_t get_default_tbstats_flag(void)
>  {
>      return default_tbstats_flag;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 2cbd0f77a0..9a40215d34 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1670,6 +1670,22 @@ SRST
>    Executes a qemu-io command on the given block device.
>  ERST
>  
> +#if defined(CONFIG_TCG)
> +    {
> +        .name       = "tb_stats",
> +        .args_type  = "command:s,level:s?",
> +        .params     = "command [stats_level]",
> +        .help       = "Control tb statistics collection:"
> +                        "tb_stats (start|pause|stop|filter) [all|jit_stats|exec_stats]",
> +        .cmd        = hmp_tbstats,
> +    },
> +#endif
> +
> +SRST
> +``tb_stats`` *command* *stats_level*
> +  Control recording tb statistics
> +ERST
> +
>      {
>          .name       = "qom-list",
>          .args_type  = "path:s?",
> diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
> index 04adaee8d9..8c7abb62e5 100644
> --- a/include/exec/tb-stats-flags.h
> +++ b/include/exec/tb-stats-flags.h
> @@ -16,6 +16,7 @@
>  #define TB_JIT_STATS  (1 << 2)
>  #define TB_JIT_TIME   (1 << 3)
>  #define TB_ALL_STATS  (TB_EXEC_STATS | TB_JIT_STATS | TB_JIT_TIME)
> +#define TB_PAUSED     (1 << 4)
>  
>  /* TBStatistic collection controls */
>  void enable_collect_tb_stats(void);
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 72585c448a..4bb343870b 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -33,6 +33,9 @@
>  
>  #include "exec/tb-stats-flags.h"
>  
> +enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
> +enum TbstatsCmd { START, PAUSE, STOP, FILTER };
> +
>  #define tb_stats_enabled(tb, JIT_STATS) \
>      (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
>  
> @@ -114,4 +117,11 @@ void init_tb_stats_htable(void);
>  void dump_jit_profile_info(TCGProfile *s, GString *buf);
>  void dump_jit_exec_time_info(uint64_t dev_time, GString *buf);
>  
> +struct TbstatsCommand {
> +    enum TbstatsCmd cmd;
> +    uint32_t level;
> +};
> +
> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 13f9a2dedb..2e7f141754 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -181,5 +181,6 @@ void hmp_ioport_write(Monitor *mon, const QDict *qdict);
>  void hmp_boot_set(Monitor *mon, const QDict *qdict);
>  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
> +void hmp_tbstats(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index 392e03c906..37390799f1 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -728,12 +728,18 @@ static bool main_loop_should_exit(int *status)
>  int qemu_main_loop(void)
>  {
>      int status = EXIT_SUCCESS;
> +#ifdef CONFIG_TCG
>      uint64_t ti;
> +#endif
>  
>      while (!main_loop_should_exit(&status)) {
> +#ifdef CONFIG_TCG
>          ti = profile_getclock();
> +#endif
>          main_loop_wait(false);
> +#ifdef CONFIG_TCG
>          dev_time += profile_getclock() - ti;
> +#endif
>      }
>  
>      return status;


