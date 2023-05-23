Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0C70D0A9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 03:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1H8d-0003Ga-JB; Mon, 22 May 2023 21:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1H8X-0003GQ-Hi
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:48:29 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1H8V-000146-7r
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684806507; x=1716342507;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c04pjnLUhbrJtW2YJogclmssU58b5emuZL96jBXG/sA=;
 b=oEVBNs5ouTGN2hC2ONee6C0wXGibPjjmS6GX/SKqU0eQyYX3EV7SUsja
 CJNbrf++G7s4/rZhY25AyB8KjhuMpAQgCDYOQbEXAGHR6l4998Lg7PU+3
 n4vwRNXEetp2oeNOptNW16En3HZVnvke9SAZVwwnx0/kXQg3+5ZBJD6De
 er/xUe6ggjF4TAhJ2btpt59P6WuO4XtYDaTSK3LAK9MJuYFDgCYgtdfYR
 C0aMxkFdW4XD0OcReX71+ZlPJFS0+d3WCH6+tECjhmmfnFxyYjF5h0r/+
 h85/YzQH2YzzYuBrVme8dYOnffhp9wVB42H/Fr7bc88f5MlLw41bfk2uj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342553207"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="342553207"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 18:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703759765"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="703759765"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga002.jf.intel.com with ESMTP; 22 May 2023 18:48:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 18:48:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 18:48:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 18:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY3sq4pxuI2qVsuz66dRhuSlOg/A9k3MFTga25hKQuTo1lGkiD8Vsi5XWZyHqK4Jj4VovXn2ekCljXH7hFDvp/Dm3T1GB6bwglsXwJXDLNsFYENdvKVlRsUVsV/USeaH1CH/UjS2nCPlkWtZRe70QTbm+nNLeVcK/kylP2HEN08iI+xx5eE/HVRmIyg2ZIa/NDDmWhQeQR8Ktp1ZvpFJe/+UDZFMj6xbLlIybBe6mIVNLK+KJgOJ+5NPn2jQuJ9ZnY9zY02IhAl2IVTmvSh9ScgxyUb4T5DCQQx2lSbTzYFeNt+X89HKhPBy3zYO53IYGBBgdTHKGZGJyckXbqqFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7LY6r1nzgeVHxU3Hzo1NVnGmh3AyRWMUwEjp4qxnaw=;
 b=ULpPOaGlObfpR+5ychvjuLhfbftud23qfZWDhKQ+4mNwYVYfdEI/sKd9E7iN8kZmnmtSxAnywRMbmoduw15hKa6asW8hM+WfW62B+DgnC5wmOmt/AbXtv09DGWx2GvupuEcL5SRVFf6tMr5/MCdFP7aonLpPAsDFsyIMVOtEGQYvNtK1zlnshJguNIhSSSIdY/WYNZ90snVusdPOe1L1tDicp4zqpHQcuuzwhvJotfpzESrRxgZzGc39npXfPdIEi+7NKkS5MO0WrTP66SSeNoS/vAhVt3MG0qHJtabEQn5a/NqtlhDM1y5/Bp4O1PgulyI0gAQOEztvPDBrUW0kSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 01:48:21 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 01:48:21 +0000
Message-ID: <9db62084-b660-449a-a0cd-f9c13fb30c28@intel.com>
Date: Tue, 23 May 2023 09:48:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
 <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf8a4b7-4026-4dc4-ba68-08db5b2fc981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWpvD7IPiLPhKVHBK9ubNof0hTj9IQC+99b+OtIa+GM6apvM8AWeXiTB/7xUrI4Fid3w/eCxdyDNY5rzcMlCdB6v30yl0f5AK6bmEyMvXsLvYxwGSW10p1bzK3gDZr3KtLQBZiJ1TbOdlNdXDLpzaBtRs4I9ERZddB0TaXXp2lMSylSESI7/Tzn9mt4OpOvMpL9Vpmwu1qs4o1fScNMsKYV8+II1Q0Sk6zG1qXfWBFiI6EjXUEJESr+tOijfH5gG54D8uvNyerpFSSNbhPmS2W25owuTIFKXCUMkXZqwTwplRulfvTJdkkYO8gPRl4XGXjumEIPIkALURo9iY5QFPv+2lgCr+qvt6Y94HSyVVS7E1t6LR1OkMi8fRaFRP4OvAKyoePIosODLZrSp7fjUA6mVi6dpk+zmh4rHq+XDlLwcgWAQXevnO4HWdsNvEAzQ8zLh+aaGA/iCaDg7A4Lj5fheH1+YDnaQeOTf73u4+kYoQCGJorEBnc0FN5v/Hev9BjEfYKeilqYaPcQy5zenGVRt5ztZXTvfgayZZUGO3yh115DuQYXxJz8TPyg9u7bTyRgo1/wA3Uu3cK8+JAm0k3lkkPOPSJI5wnqWSg83ci0pe1xrW43LU4Kbl48uNl8lLvEA0xQV/4ju6lh/g93KLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(8676002)(8936002)(5660300002)(83380400001)(186003)(53546011)(6506007)(6512007)(31696002)(2616005)(86362001)(26005)(82960400001)(6486002)(38100700002)(41300700001)(6666004)(478600001)(4326008)(66946007)(66556008)(36756003)(66476007)(316002)(54906003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFV0U09HeHJvMy8yVHpvZEJCRzJ3SEY5TGpoVzVhSkxJOHByTjA4Q3dkYmpv?=
 =?utf-8?B?cm9vK0dwdThta3Vjc0o1TFZDSFNHNjM0UFhMTC9TcGh1MDlUVklBekIydDhX?=
 =?utf-8?B?NjVoNkdNdmpFcDExUXpERm10SUE4SzF1eEptMmdkTEdhL2VnWW1ZWjVKMUlx?=
 =?utf-8?B?cnZSSFhMMURtbFZHZENQWTVCakcrMkorQVNySVd2VHphR2h0QytNeWg5Rmdr?=
 =?utf-8?B?Wi8rWWlWS3NhWDBzdkNrUGJPcmxQUW14WVBSa2l0NDZnWFR6a0FkT2lQN01p?=
 =?utf-8?B?eDlpbXYzb1htS21WbkpvdStBbU05S1lUb2N6SVVvM1c5TUppQXkxVFNVaExL?=
 =?utf-8?B?RldTNXJCSDFZY3lndENxTXBpY0lSNGt4YTRnQnN1YjRXdURoQk1VcmRtSktY?=
 =?utf-8?B?NCt1Y3AvNFg0RVN0aDd6YzhhUTRyZGROdjlSRXdCQ3p1SWMydnhyMGluYVhv?=
 =?utf-8?B?RVdrbEphRnFCVVByS0tKUVBvOEExajJUdFFtWTVES2N3SzlMblkxaVVpYVk1?=
 =?utf-8?B?eDlzOElxUGVBSnpUUDBSemoxdm82QWdUVmh6TVpSOUx3akNXY0lvclBubTBv?=
 =?utf-8?B?RFpCNjlxbFF0V3M4RWNWaFFaL0tIZ01TTHNHQ2duL3U1MUpTNytlTDloM01W?=
 =?utf-8?B?K0F5cFFUMmlFaHRPR1dPTWI4UUpGUlZDNUJ0aHJHSGJwWkY5aWlSS1U2dGpt?=
 =?utf-8?B?WVVFV3ZxVjY3bTU5bDlTanNnaW5KQjdPQkNLK3lzR3ZhZXdnVTY1aWkyTWdw?=
 =?utf-8?B?d0VaalY0WXFJQlVndW5QbWxUM1pZdmE1R3laaVJ5bWpyRDZweGxaSGdPL2VS?=
 =?utf-8?B?ejZWajN4QTZMeTgzUVEybHkyUVdRSEFYR1RqM2ErVXZoK2lvakVodnhIVjZk?=
 =?utf-8?B?YkpyMGYxNUZJdmVjZFZaWGNTU1NPL0d3ZHFWaXF3d08rdlowbDU2WWdPVlRq?=
 =?utf-8?B?ZEVSVkNEMHYrRS9ISy9JdFNJMS8rcldCZmlpUnZWR1VOWm9YM2JFVGlsV0VY?=
 =?utf-8?B?bkZIRnRIT2RyaEZtQVZtR01SUWl3ZFgvRVNMWDhWdUlNT094c0Q0T1QzRzc5?=
 =?utf-8?B?ZDdjTS9CY2J5Ykd6SURhVmtkZnVLWlZ6WlY4b0t1NmZaK2JYcFRDWVZwWTUy?=
 =?utf-8?B?cnB4Tm5kNkRkK3NrUS9namdSNzhvanVvZHdPT2F5aGFETXMvaWN3Vlc2bDk0?=
 =?utf-8?B?S3pGa0F3Z0Ircm96S2xzYlBGWTZXUjU3OWtSRlNFL3JpSmlJVnRSRTk0VW1o?=
 =?utf-8?B?cjFNbmRZaTBncG1JT2kvM3IrVi9oSE1qbEs0ekpSR0RmUkt5ZDZHaWJRY0VK?=
 =?utf-8?B?ajRiK28veHErR1NtV0pYc3FXS2NpYlZEUjU3L0RpZ3hMN2Fja015VXdHM2xH?=
 =?utf-8?B?aUE4VTM5OHh6ZGQ1bnk2QUtJS3BNVjNPdmNEYllkZmh0S29yQUdOVS93WTZR?=
 =?utf-8?B?Nk42QkxiVkRkQ083Q2lWOHBkREY2WVhrR3UzdUZwQmNjeHRpbW1DVVpiRWFG?=
 =?utf-8?B?N05nZ3JaL0R1azhqM1ZiWlZCaU0waEx4a0xuaWJQa0lSQmRpQVpYY05QRDRk?=
 =?utf-8?B?QjMvYjBqbkprYTFtQVdlS2RNbDdDOWlKV2pwck90NzFuN3dKWmJDc1NSR205?=
 =?utf-8?B?dVZTY2JVN2p2M1hBR0dVUklTVXFPVmoyWnBJaDVyaUhoQzEyazNCTHV3bGdE?=
 =?utf-8?B?eFZmNTRNcXE4V1h3ZjAzbkdJS1FDWWJYTE1HYm51OCtVQ2VSSnU1REd4NWFr?=
 =?utf-8?B?UU50RFNPQlZab0s4Q21NVzUvZHB6RURJaDVWKytXM1hNL0FQUjdkMzdHcEMy?=
 =?utf-8?B?WEVSWmFRNHduM2wraC9UTkZrUGg5MHNlem4zNGZPNGZicVpZdER1eUgvYnhO?=
 =?utf-8?B?RkkvSmdzbVoyYkZGTTc3d1ViRmx4cmVnNHczSk83VFFxVUhsaDU5a1R5eXFh?=
 =?utf-8?B?WjdBS0VXMDVZQldtVWRXeWZuYUdjRFFnTmVDZHBSaGZVKzFZYm1CN3dXdG9u?=
 =?utf-8?B?aFdJbUtXUDRROENkT2ZPZkttWEZFRHFXYW5kbXovR1FlS1NaZW1FRkhjc0p0?=
 =?utf-8?B?Qy9aU2lCeGdURGF2dDZRTEFvc0NUcWx6TVI1bjByT2VUWERrTW5YbmhibUtj?=
 =?utf-8?Q?+gKMeJ62lpN5HAxCDNPtoXwOi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf8a4b7-4026-4dc4-ba68-08db5b2fc981
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 01:48:20.9354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPQ2j/UcFCGsECBaM0iEd1ycQtlItkgjUEYloAyQ00xWNJl7hbrGELCnT4Z58JQAeavoYg+hBzRq+hmPgiAOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/2023 8:45 AM, Richard Henderson wrote:
> On 5/18/23 06:57, Fei Wu wrote:
>> +void HELPER(inc_exec_freq)(void *ptr)
>> +{
>> +    TBStatistics *stats = (TBStatistics *) ptr;
>> +    tcg_debug_assert(stats);
>> +    ++stats->executions.normal;
>> +}
> ...
>> +static inline void gen_tb_exec_count(TranslationBlock *tb)
>> +{
>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> +        TCGv_ptr ptr = tcg_temp_new_ptr();
>> +        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
>> +        gen_helper_inc_exec_freq(ptr);
>> +    }
>> +}
> 
> This is 3 host instructions, easily expanded inline:
> 
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,6 +11,7 @@
>  #include "qemu/error-report.h"
>  #include "tcg/tcg.h"
>  #include "tcg/tcg-op.h"
> +#include "tcg/tcg-temp-internal.h"
>  #include "exec/exec-all.h"
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
> @@ -18,6 +19,30 @@
>  #include "exec/plugin-gen.h"
>  #include "exec/replay-core.h"
> 
> +
> +static void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> +
> +        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
> +        if (sizeof(tb->tb_stats->executions.normal) == 4) {
> +            TCGv_i32 t = tcg_temp_ebb_new_i32();
> +            tcg_gen_ld_i32(t, ptr, 0);
> +            tcg_gen_addi_i32(t, t, 1);
> +            tcg_gen_st_i32(t, ptr, 0);
> +            tcg_temp_free_i32(t);
> +        } else {
> +            TCGv_i64 t = tcg_temp_ebb_new_i64();
> +            tcg_gen_ld_i64(t, ptr, 0);
> +            tcg_gen_addi_i64(t, t, 1);
> +            tcg_gen_st_i64(t, ptr, 0);
> +            tcg_temp_free_i64(t);
> +        }
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}
> +

Thank you for the method, I will try it and measure the gain, it is
indeed the hot path and usually takes a lot of time.

Thanks,
Fei.

>  bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
>  {
>      /* Suppress goto_tb if requested. */
> 
> 
> I'm not expecially keen on embedding the TBStatistics pointer directly
> like this; for most hosts we will have to put this constant into the
> constant pool.  Whereas the pointer already exists at tb->tb_stats, and
> tb is at a constant displacement prior to the code, so we already have
> mechanisms for generating pc-relative addresses.
> 
> However, that's premature optimization.  Let's get it working first.
> 
> 
> r~
> 


