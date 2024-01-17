Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE0830039
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 07:40:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPzaN-0005fV-Hc; Wed, 17 Jan 2024 01:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1rPzaK-0005fM-SR
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 01:39:36 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1rPzaI-0005qu-Kx
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 01:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705473575; x=1737009575;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VxtZ/PNoJF1OJV2gRQrq8BqA9eEHXI4YxkXdzdA4nBk=;
 b=j9renAUcE7PcJEO6EyxRqSvpDJCH3YMtj/tQYBIjM4XQjKMh6ylJHRp6
 +pNaR0B5FNkddDMzzZX7oGHQzAvVW9JWguYT2LphIFmmmitwe6KqTV5g1
 oLwRxYKr2ITucSCLvR5YxbNrjGHyfgSxmmcMOJYNbj4GxNi4iu9GweM1A
 5XTFK9IJJvD/CfUeY+LPrlwfwbs6eHMhFo7idzLvOwYFSgIMJaElS20n1
 Eo2JNPayH38Nr98H1qHGwXk6u9GUuoHOgzME232CoVc4a9QtJKst+QYVA
 XvF4gkNMHlEgj4YrUkX9Cx8SrnJuAwgk/KdVa3WIIqnewUCE9YRba77R5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21563608"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; d="scan'208";a="21563608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 22:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907645384"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; d="scan'208";a="907645384"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jan 2024 22:39:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 22:39:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 22:39:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 22:39:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 22:39:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNisQaoOim9s9f6q7BankZ6h3wkxfB1vXtxkbcdb+Au12/+gcQ+RFWgDhrHE9SUIHYFWMwjC9hCAG+A2p+6PXdxWF411NFwZoyRzRwAVwe3OSy3wXirOMA/sIkYAPqqZH1g6Qo7cRhINr/nWq9DUgZVJBb5DwGIMbiV7XIEtVQHJDbn6xRYvw5sP/zAYpHucWGjbf7LXZqmlXGdhqZqd3R2+5q2He1Hoe2sv+vUxy8IxyVQWM93iFJSLpAv2Q6U6ZVS6CrXUo7yb8VTaMn7QPmCQKi9i405AzeoiISTNH9Av0oTlGiqCcoStNQ+5uNsf3GQaX2g45M7qPq1M+QdC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HKhHFdTN68Yj5ELdHwUQVELYrh2rKbzGsrzzVwvu7c=;
 b=awZGVhrMWRWVxsdQVRELIMxjhSd5zvubKUm5duwM7nCrZzwrYSuK4bGvgziasIHYkjwsKeq/ebIr3FfleGFEAdy+3Wpf+H3VW4EysyiWV5MY3GjTEQiHoi1ktyOtpv/vCYeH0KcInL5FMyv9igHe6BAd9pivuIkKzxTCMpVfH+kgP9uVX6BSGmZ7tC3AVMXsKt4OyP/JOByxJS2DtnRBTvXH4mMJYwKOYN/HrZcaXmCCXX8GK9UJc90MdmheUpD21fXcNTEMmjrjwVWelcqdSbdplEqSkh5r/CRGq+jQRv/P7t7MhOABw/P10ou64wrFOZ9Ys0nj/iDLMKNrf30dQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 06:39:13 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::819:818b:9159:3af1]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::819:818b:9159:3af1%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 06:39:13 +0000
Message-ID: <f32db126-ea91-475f-869f-adb33bc16c51@intel.com>
Date: Wed, 17 Jan 2024 14:39:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when
 CPUID_EXT_XSAVE is not available
Content-Language: en-US
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240115091325.1904229-1-xiaoyao.li@intel.com>
 <20240115091325.1904229-2-xiaoyao.li@intel.com>
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20240115091325.1904229-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f567e8-a1f3-4c39-270b-08dc17270493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHT4VkCcp/KoUnxnTVcKvhWQyqGPmNOJFYfJsCasxsOARI7pMdNnJY+wzSDhGuoaH38kCa5ynr4DJuJAcxpD2XoudDFQb28js2dy0qdFFkG3185HKL/ozsQD0t8peZCekt2NcUuy/YqC9+nVhcM3ggFikm5ybmLumm/YPlLU1U5mCbRb2bc3z6km658WeCPwAA9IMmXyGokdG/sqQJV4eFkde22lMF0A2/U5YTuCSx6JjQrBv2wand5L8FtuSvciyVcbyc+EHlvadDnas4LcMhLz/jLeAAUDGEyv3lPKhky0ZvgYJLJ6OAq7kqDJONiQASmiuinVjf2KRwK3WK0/CK9mRdnrhOBA2UUU1mHkLQmYkT8exFsT5Hvg7HjNEmJGY6STsz00kPb8a6wRF/NFOsCKpEBVRrS0Jpk632sSxl0cFQI0/3mowO4FS0DgdqutzmcZNQ1nYFwuaA+ZbIwCg4o37P4TzluLS2XEQoY+AlDD5vcTE+ZDkoYQ+pDs6FjRTV8q+S2ZvQahWKg/J7g0ls1O0JPdfi8s8lo4gDNb6VD61ZupXVVzzb9zmVkeqpW4j2BMv14SJ/dDnstfj6H7kJB1EDHItNC3qJb//Ly6nhMMz3Y9uUQeWXBZ0/t7LctdgPraJTwc6iCH5dzdv8atIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4965.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31696002)(8936002)(4326008)(8676002)(5660300002)(4744005)(2906002)(31686004)(26005)(38100700002)(86362001)(82960400001)(2616005)(36756003)(6506007)(316002)(6666004)(53546011)(6512007)(110136005)(66946007)(66476007)(66556008)(6486002)(41300700001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3UzMG9GUmQxME4xSzJTMmFxZEZ5eXhKY1lBeCtrdmtmRlN1T2I0R3BWSWVE?=
 =?utf-8?B?S25NdEk0ay95OU9iM0hCWUZOR2hVR3NFdWg4UUJRY3c1UzJqL2YzQWhRdUpj?=
 =?utf-8?B?NERQSGtKZHhMb1JDRE01TFJNV3BFN1BBWkxVcU9yL0JqbFVLa0ZWY09YUzZ3?=
 =?utf-8?B?MzNDK2p0bFJ0RlRPYS9OMXptU2xhQnAyVHNnelMyUGxzWVFoVDdOMHFEL285?=
 =?utf-8?B?V0NDdDNTRDBQMVJqRHZkNEQzaXJubVRwQ293VWphdC9qU0FEOCs4cWtRNVRI?=
 =?utf-8?B?OElKVTBvZ1AweCtFWmdJdG9zL2FyY0o2Qkoyb2tJdHdoVGtTWDVrUW9WWmZt?=
 =?utf-8?B?SHVRR1lXekJtekN3SHBZWkFBU3Z0K2VnRWxrYmVZYk1SUnNmNGY1TUJDbnB0?=
 =?utf-8?B?bm9ZZ2I1M2xpQWRhVm5GUE5sYlA4UmFqaUVmRDJ0cjM0U2JjVzBqaFpIZDZY?=
 =?utf-8?B?QzBSZ3orY3RsUkx0Y1JZcDdYdzRiRUFrTFh2YjBuVXBoYUlwVi9ibGM5aW52?=
 =?utf-8?B?aFM4M0xnOXZyTnNBUEFQTGs2YXVCZnpJcXBUaGxib2hxdlVSdlU0R0lmTy95?=
 =?utf-8?B?Y2FZcVUybGFFVjZYcy96Rzl0N0hSRDI5aW44b0tzbEtzYXJPbmZLN1NlNWU5?=
 =?utf-8?B?VlRpQWs5V3BuWHFFTWY3M1hwTC9PQ1pxRTEvR00wdllhSmc2VE5zZWgwUU0z?=
 =?utf-8?B?Tzgyc3JVL3JQazJCNmNlTEQzRzRqM21uVCtTcXhKVGJBc1FnYnRMWGdFS3Z3?=
 =?utf-8?B?ZU96QzJHTkUzVWRqd0VaRjR1Mkt5NlJXZ2RLSGl1T2wyVEtEVW03Q3JDL2NK?=
 =?utf-8?B?dURmVTBZMmVQTlVySVByaGNZVGQvTS9CaTg0OHNrWEtGRkd0dXh2bnNoRDBM?=
 =?utf-8?B?czA5OUVQdmV2N20xUXFjUXorcC96a3hObXJucGwybERqQmE3ZEUvUlRkMThj?=
 =?utf-8?B?ODdiR21sNnZkWHZ5WjFKRUVoODVXc2VObHYwNVpnblVDeDRNQTRNcTlHbGJP?=
 =?utf-8?B?enNKMUsyZUFKSVZSWndabmVFRC93bTFSSEIzQ2dRUVFWc2JYbUEwZDduejRI?=
 =?utf-8?B?V3kycnNIbUt1WDl3VFF0SnFXNGsxT1RYa0pwRHVueDBRbHo1eVhROXFJdXl4?=
 =?utf-8?B?c08wVld0bEsrMy9qbTRUMVpFOXVab3ZHZXZwWkJuUEk0dThYMVVzdzJzUlpE?=
 =?utf-8?B?V3RzU3hhclRSUSs0QzI1T0wvWkp3Z2xGcU5IMmk4N2hLY3dsWkpDZGlGelU5?=
 =?utf-8?B?azMyNEh3Ymo3dms4c3hsbnJtd1ZuZUV6WmJjKzRDeVZJZ0RGUWR3S3lGTkEz?=
 =?utf-8?B?SU9uY2JrUFVzSndKcExpWTlCTnludUhmU2JPektxdE9YUi9FZDdaOTBHWHhO?=
 =?utf-8?B?VHJCR01NZkQyeTBhV013ejhBOC9HSXhobzJRZE1rNWhpdjNVTG90UGZSL2VW?=
 =?utf-8?B?OUFIbk44RFMrYk1iZVhKZzM0NDNRaHhqVVEyV09YU3FaOGRpd0xoZElHR3E5?=
 =?utf-8?B?ZHBRZXhMZGg0L3hZbFpjdVdSdHp4eFAwWHRWY21rMWJsU0pQR01aNVo1YWo3?=
 =?utf-8?B?cEZCbk51YXN4VWh2SkJlV1BMODd0a01kUThac24xV0tmRjFDbGRXODc1SDEy?=
 =?utf-8?B?R0NXeGRoQlJtbVdJLzMzWFFyd281MHdvWnZ0Z0NyaUlIc0M1NTBnTzM5d1VZ?=
 =?utf-8?B?Vm9PbDZRclRscVhPaFZXWTl1alNRa0gzdDBDVFd4ZU1WN0hVRmF3SHB6ZnJN?=
 =?utf-8?B?SitCdTZXYWFQT2xmQXBxZFZlRW43dlU2SXFRZS8wbk54YlhUbXM4YVVScVl0?=
 =?utf-8?B?bDhpb1hLYTJBUFFhNUZFdy9vYU5NQU1SbTZxblJ4aXJQZUZsbWdLU0JXUkFX?=
 =?utf-8?B?WDg3U1ZaaTVuSWlxNm05NEZhUjJaUXNHSkRRYkt3THJKaTBlSGpSRnBpWjJL?=
 =?utf-8?B?dFdOMlhOcDB2VENpOUIwc253R2NQWWZNajYrbGJsS1BldkJXSzgzOVVDYkx1?=
 =?utf-8?B?VEx2cDRqS0FBNkczclVoVDNsSVI1d2hCYlhzNUNHb2lhbVMyV0x6NWlaQUdB?=
 =?utf-8?B?RWJJMjBOVkZWdXlJNm5sVnc1WGF1TDA3bnJiZmlreVdqSDFHcXRLU09RaVpm?=
 =?utf-8?B?RVp5SGoxZnloSzNReGJGNmxoMVZZSXNEUHVlYmt1NVFzMTk2VVN4ZVhqb1hr?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f567e8-a1f3-4c39-270b-08dc17270493
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 06:39:13.0434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKxL3tt/39HnJEm3yyIkmHPQtOFe214YNiKtodHUSeBMCNFzn9o66hSYFSkt2p//Qty2C+0Vy8gomh5tlJOgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=weijiang.yang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On 1/15/2024 5:13 PM, Li, Xiaoyao wrote:
> Leaf FEAT_XSAVE_XSS_LO and FEAT_XSAVE_XSS_HI also need to be cleared
> when CPUID_EXT_XSAVE is not set.
>
> Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2524881ce245..b445e2957c4f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6926,6 +6926,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>       if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
>           env->features[FEAT_XSAVE_XCR0_LO] = 0;
>           env->features[FEAT_XSAVE_XCR0_HI] = 0;
> +        env->features[FEAT_XSAVE_XSS_LO] = 0;
> +        env->features[FEAT_XSAVE_XSS_HI] = 0;
>           return;
>       }

Thanks for fixing this!
Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>

>   


