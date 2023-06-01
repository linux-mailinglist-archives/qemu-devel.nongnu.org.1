Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A078D719BB1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hAu-0004Vs-C3; Thu, 01 Jun 2023 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4hAR-0004SO-24
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:12:41 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4hAL-0005xu-FN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685621549; x=1717157549;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VA8c+HfI0ae5vCldT7RSkguvqeQ+OkpzWfKJZzYeETc=;
 b=FKQtbNZ2zmAgshwTkv6+9+gEA8cGKsSZxmXpnUBmicGqxlrQlR5b5b4z
 8vaVHDsBKdQDDPiU49SWvRqwTgKOfDHWmP8gnFWyZUPMycxbuV5YuVT6g
 JAVtDKChDcBB2cENBsuC5EoQ1LGmS7BrLKVv6jBKTPKUdO8USx2aWBRZv
 wy44HU8or/WaDk1pQhuOUvyrkoTMlrZrZ3KnJ/T32Ql72mrU5G1AvaSA0
 q3L5VJRaYWLHmlNNiZ7zFxnjY7fNyQlevy2t+0OC+TScuzoKAU8oFbQey
 Bue3VT4gWuuRWgw5H8G75kPFnhs9q7EtE9r5lDX+M2vL9bVLqwxTRT1OY A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="355547270"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="355547270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 05:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819743710"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="819743710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 05:12:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 05:12:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 05:12:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 05:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7E3VWg5Lnl2FlvGuEalg8U+ss6GvA94S5D1MvDgwCTtndvkwjwv+70+E+mG7O1tngB+bS5gFavw7uj8lmjPjAJgzJ9MUstnJUdCiMN/LXJr85pmEWLGsf5sflWd+jkQ7sna+4I6+i+es/lro68A2wJm7lbBKZE3w8hqA3gFwb8oV47YxH4seGn/81cw7L3CJK8wLFLSHCW3UMWpaueyqb44perbuvTbZmHSMtvlark1IBfjc0nlieTbM58Qry5UXv8mJDFaQqBEZfG6WZjL3pJIhdcaEscoQ2MySleo36s1RGwttBqJh3TTWZzTqkGUMWR2f/3K5hu+bjkf4s5CrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+4BwPiDW/MPgkcwVc3ArZRpdhmgFp985JEtJDDbbNI=;
 b=f/DmfTkNkaQ7qqnHULhfZ7Gbe6MfnjaHXuKZvJ5PbkbfiSD54wW9b8hANv98myfjuN6LaTyizBIGh/YnoEGHdhvg1YwHkgfopl33DJdBABlRkS+i2hJH4I3X1ZbqSNBztqSTGQ8/4l1J7YagCm6IPQdNuAZUrBcGJTsV7urHc9rkVMhbWIFIjS6xFNd6GWR8QywYI5T+KZ7XSYzMv29rcM1I8Yf/9kNlIIPIaixZuyTJUquSCytqj3/ZCkFkdd4J8T4clU6m4JviAdwx/hQI7+rFPXeElcczwQ5vSOtwZopRrC/2uTos0z1g8HkIx0uAhmkfyeFvEqD7UIia5zHg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 12:12:23 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 12:12:23 +0000
Message-ID: <4b393fd4-76ef-4313-212f-2e641260591f@intel.com>
Date: Thu, 1 Jun 2023 20:12:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0077.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::17) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9e470b-4b94-45bd-bb7c-08db6299748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqPgHgmKPGMIfcUJyyh1TCAB/lx+ugGlSLQPbgZQhXkwpxODkndyI6ztoagk7efRUe1CiccnxtHRYNHA8jpo1yVD675n1ApEITmliIqipjj/IW02UEkBIaUeY4YDUTCtIJ/DbaBCkOSt/6f0DsRgbn666Dcr+63CnJkcSpJEs/TnGJ4eFtVuiTkRJiZO2iGz6LkB2Hh0FBP2of0i3Pt4RsIu2fOdqGkQ4DRo+6VVJEgnzA2B5cyd05GjGtCU6g1Bs6f+p3DCP7ROKhF5sHpIc1FA0mYQ3IndpKyzyR2d0+0YrdKQ3jwbpaMmQ+ZJuJ3jugXFxx4B4Rcsd4M2UdrLyJR1bWRhefo6J6DysomBb5aH5oWOPfBmo3cMQlNOfjIwRetLdpcFj7GgyTFiuordmX6p+kPaIBDHFEFJLsiJAX7lzbxro77OPmEsozJKDXY/JMom75ONq3aiZ7C0V3dku+FXx5nQ3KNs/kSIZxHbc5vLmv7EKGRIAMKFW4NhGWv4SOBwUwFohXPCIPAHiiraUWhsHhiBs42QUTHMyIFxV7XWk4TPVbc7VqHDPkCufXLPhTO7ATj3jqV5prDO3wojNqHbsUokl4OuaX78/Cs4NNQeGzYkbzBp+IIbLh5LpB72JZY3N4SycqT+2fFLdQFZHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(66946007)(66556008)(36756003)(26005)(6666004)(6512007)(6506007)(66476007)(186003)(2616005)(54906003)(86362001)(2906002)(5660300002)(8676002)(8936002)(6486002)(478600001)(31696002)(4326008)(82960400001)(38100700002)(53546011)(316002)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG0xb1ZzWXpJVG0vK1J4d3c5UTdZNDF6SmRuNTdxMnQ3M0VaZmloQ3UvZTE0?=
 =?utf-8?B?c1dCUmYvRmxsblljUUtRSnF5ellPWTk3SWEwWnFRU3k3YnlvSWNOTWF0bTRI?=
 =?utf-8?B?UisvUVcrLzVSaUsrZmRkdzY1bDlzSTd0WHRvRk01S3NWV05UQlN5MFV4NVZs?=
 =?utf-8?B?bjRiT0Z4Y1ppdTJzY09DYWFZMXcxQXhGejdlMFlaZCtjZU9JK2x1L1NCVlp2?=
 =?utf-8?B?QzZtTkxvSUI3alZtbnBON1dUbko4NkRrZFVSdjYvRTAvNnNoM2tPUnM3bzgr?=
 =?utf-8?B?dFZocHRIaXpSL1Y3bFEzQkRVT094aFBlczIyZ2RMRnh3dWk2bnl5NmNrNS9p?=
 =?utf-8?B?aDhzMUJ5bm5vSXRlbXdOSTlrd0owdndVNDZLVmtVRFNubU4xa3BIUW1pUXRI?=
 =?utf-8?B?SUhSeGV0Z0NrMGlDYzZMWVlBa2tjNU4vSnpURDdBM0N6dWJsMmpvRWlRTDNp?=
 =?utf-8?B?NDZBakpYUDZRL1lkUXp0b2ZTVkI3RVgzZVFlbGVhQndONU9abG9sQzhVUWVN?=
 =?utf-8?B?Yk1FZnMwcGNPWTJBUVBFQ3F2Z1ZhWjdMQmJXV29mWkpBWjB0UGhQR3V0VmVw?=
 =?utf-8?B?dkFkcG9VM3JNclllSnhVN0VzQzYxWlBiREFSeGEySWZpMmpQQmIwcVFtKzZp?=
 =?utf-8?B?WjlCM1AwS0E2ZXpudVZ5bjNyeTVRbStBZ0xjN2VxVFpRTHVRTHF5SjljL21R?=
 =?utf-8?B?VGQ1ZnptRi8zbVhNWXZJbkN1UnAxY1p0MEdaVFJlbkFXbGN0V3NxUndqaTBo?=
 =?utf-8?B?eGJiN3prWVQ5YmV4YkRjVmliRnRVNndaQlpxZ3NyN3hvY3lMWGVBcTdhSDUw?=
 =?utf-8?B?RHMrMmtxR29CMWZUdDNjMG16WW55UHc0OGFMZWgrNG15ZWw5ZjlCRDRweE1r?=
 =?utf-8?B?MmZtVnBsdkxlcGJvY0FBZFVNNFYxdDRtQytNbWV2RWdoTEtJU0plN1pWK3Bv?=
 =?utf-8?B?T1hMVHdZSy9EV21yTXE3aHBldEJhcWd3VUtPeFBjS0pWK1I0ck9RY245bW9M?=
 =?utf-8?B?alIxSHlFcDJOSE5KMzhYcjJiV001bWdGdy83RnVGRWMvY1JIcS9rODVGRC9C?=
 =?utf-8?B?dnNSV0FtZi9PWVF1RDBHSlRKYldJTi9Hb1pUeXdBdDJTYWFTbXBjalRuNWd6?=
 =?utf-8?B?LzZrQ0VUc0djNHRoY2RTVmtxeFRxNk5xSWJZSTAwQXVJeXVPWWVMV1lSc01p?=
 =?utf-8?B?aHhCSHRVWmg5RkpRQzBNeXVnY292L0lwU2pIK3BraTFEUGFpSU5WaXBmbk5x?=
 =?utf-8?B?SlpjT3J0ZmExWFVvQWI0Tk1Xb09mM0I5cmNGeDBvYzlYSDhpTkJ6ZjRTWjVi?=
 =?utf-8?B?MzRFMkNGMnhKUmhLUkxGeHZqZmF0Z1JZcnBGZzVIbGZiMkNqcmtFWmhvaTVG?=
 =?utf-8?B?NzFDQTZ2WEJYUys2WHd3S3lIcHY0ZmFOMEFNcFlyc2p5TjFnVTJzQU9iREtW?=
 =?utf-8?B?c2ljK0VqZGJyemlYWXpzc2ZWM2tNOUM5S0RzaDlnSW1BNFFOQXBZSEMxaXd5?=
 =?utf-8?B?SVFnQnJUM0dEVVRybi9OWXNLU202QVVnWW9DUnltNjJ5d2pudE5Vckk0WVRL?=
 =?utf-8?B?T28zOEJsaXZxQkpqdXZtT3pxTGpXQ0ZpcUNnWVZTczFqZnFQQVlJQ2kvT20w?=
 =?utf-8?B?QkVRNmRxcFNOQktHOU9UeHFGcHdBQ0srWDZoVUlMVTl5VEdYcEMvQ1Nwak1o?=
 =?utf-8?B?R2ZrMzQ5UEx3WGpnRHNXcThmdE1HSjFSMnM0TXZvQWlrVEdoTmoxK09mKzBO?=
 =?utf-8?B?M1F5Nmh3aUpyUisyTkpIMGJhVjlPV2gyRHRpVUQ1SC8wa0NiWDNkTU42ZmRP?=
 =?utf-8?B?Wkd4NnpsaHRkT3U1ck9Bd21CdG1mR0JoQ1ExbXBYRWlxWmhXRXZNTDJURFpN?=
 =?utf-8?B?NW1hakJQdmFPT1B2Zys5akxFbjlXVzdKM0dxdW9zVnBrUWRmYk1ZTmorOGJw?=
 =?utf-8?B?TE1iR1lmeWZ2ZkVGMUdBVVZacUhjVW91RjRqZ1VRR0VYdHI5ZkpZOENJTEVp?=
 =?utf-8?B?aTdSVTNNUm1hZFhNTUUyNVNDRGxHR3BSRTZzZlEwZ1lVdExoam5CL1c3MzFy?=
 =?utf-8?B?cFdoMTBTVjlsZm9HME01dURJbTNGWXlJaGV1M083OU1RaEhYMUR5ZFN0WXZa?=
 =?utf-8?Q?SxeRRtpfrWbyWicn63qys/nxR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9e470b-4b94-45bd-bb7c-08db6299748d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 12:12:23.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1QHxLUc7t4bMK3HHa5BUfQq0L1p2d4FpVGV4Ji8AxgiLXj3Nx/IbvSrba1am3i2zHQFL1IkHC8Jp7anbOPcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=fei2.wu@intel.com;
 helo=mga14.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/1/2023 10:40 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> +static void do_dump_tbs_info(int total, int sort_by)
>> +{
>> +    id = 1;
>> +    GList *i;
>> +    int count = total;
>> +
>> +    g_list_free(last_search);
>> +    last_search = NULL;
>> +
>> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
>> +
>> +    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
>> +                                        &sort_by);
>> +
> 
> Why are you sorting on a list and not an array?
> Intuitively, sorting a list of 1 million elements seems like the wrong
> choice.
> 
> Why did you put all the comparisons in one inverse_sort_tbs function,
> and require examining sort_by?  Better would be N sorting functions
> where sort_by is evaluated once before starting the sort.
> 
> 
>> +++ b/disas/disas.c
>> @@ -8,6 +8,8 @@
>>  #include "hw/core/cpu.h"
>>  #include "exec/memory.h"
>>  
>> +#include "qemu/log-for-trace.h"
>> +
>>  /* Filled in by elfload.c.  Simplistic, but will do for now. */
>>  struct syminfo *syminfos = NULL;
>>  
>> @@ -199,6 +201,24 @@ static void initialize_debug_host(CPUDebug *s)
>>  #endif
>>  }
>>  
>> +static int
>> +__attribute__((format(printf, 2, 3)))
>> +fprintf_log(FILE *a, const char *b, ...)
>> +{
>> +    va_list ap;
>> +    va_start(ap, b);
>> +
>> +    if (!to_string) {
>> +        vfprintf(a, b, ap);
>> +    } else {
>> +        qemu_vlog(b, ap);
>> +    }
>> +
>> +    va_end(ap);
>> +
>> +    return 1;
>> +}
>> +
> 
> Not need on this either.  Global variable being checked on each
> callback, instead of selecting the proper callback earlier -- preferably
> without the global variable.
> 
> Did you really need something different than monitor_disas?  You almost
> certainly want to read physical memory and not virtual anyway.
> 
This makes me think the necessity of 'info tb', the primary extra info
it adds is guest instruction, which can be gotten from 'x/i' w/o calling
tb_gen_code.

(qemu) info tb 1
------------------------------

TB id:1 | phys:0x79bc86 virt:0xffffffff8059bc86 flags:0x01024001 0 inv/1
        | exec:56962444/0 guest inst cov:0.61%
        | trans:1 ints: g:8 op:27 op_opt:22 spills:0
        | h/g (host bytes / guest insts): 26.000000
        | time to gen at 2.4GHz => code:747.08(ns) IR:477.92(ns)

----------------
IN:
Priv: 1; Virt: 0

0xffffffff8059bc86:  00000013          nop
0xffffffff8059bc8a:  00000013          nop
0xffffffff8059bc8e:  00000013          nop
0xffffffff8059bc92:  00000013          nop
0xffffffff8059bc96:  1141              addi                    sp,sp,-16
0xffffffff8059bc98:  e422              sd                      s0,8(sp)
0xffffffff8059bc9a:  0800              addi                    s0,sp,16
0xffffffff8059bc9c:  c0102573          rdtime                  a0
------------------------------

(qemu) x/8i 0xffffffff8059bc86
x/8i 0xffffffff8059bc86
0xffffffff8059bc86:  00000013          nop
0xffffffff8059bc8a:  00000013          nop
0xffffffff8059bc8e:  00000013          nop
0xffffffff8059bc92:  00000013          nop
0xffffffff8059bc96:  1141              addi                    sp,sp,-16
0xffffffff8059bc98:  e422              sd                      s0,8(sp)
0xffffffff8059bc9a:  0800              addi                    s0,sp,16
0xffffffff8059bc9c:  c0102573          rdtime                  a0


Thanks,
Fei.

>> +void qemu_log_to_monitor(bool enable)
>> +{
>> +    to_monitor = enable;
>> +}
>> +
>> +void qemu_log_to_string(bool enable, GString *s)
>> +{
>> +    to_string = enable;
>> +    string = s;
>> +}
> 
> What are these for, and why do you need them?
> Why would to_string ever be anything other than (string != NULL)?
> Why are you using such very generic names for global variables?
> 
> 
> r~


