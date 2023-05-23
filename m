Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E019670DD34
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Rkn-0000A8-Dr; Tue, 23 May 2023 09:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1RkZ-00007d-Bj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:08:27 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1RkX-0001Aw-24
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684847305; x=1716383305;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dHm3IZnBpmdjJxE4T0V+sWMg8PsT6Tqt2F473h8aibM=;
 b=BJ71wopP2kmqxObPICsCB7j23EABQKLM2Rp3U7dr2Bo0tapJHX54tK/S
 gz0poJIP0WwXnp1OmW+wWUwGGyBx7nN57F/o6UuOUvOMs4FR8ovTMYM77
 BRTgwMEWriyGJUv3qi/MVQp/gdcUHO7k0V2SijYF2OKgboDKtEHdff6Mb
 lYSDXdJGACuuJybo4WIjJatVe5oq1hoMnaNuEqmtIClnSvqv/XzFjnmxL
 ARcObE3zgn4MaO+EQCUz2eUTvopswuB1jtS+1Jjr/ovL3NzxcdGDDnWI1
 qgc3mvpgYeH9b6oJ1FaxrB+pe8VhfCELmI5WiN7RajjcU6q18CkojoXW2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416689616"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; d="scan'208";a="416689616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 06:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="773834935"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; d="scan'208";a="773834935"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP; 23 May 2023 06:08:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:08:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:08:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 06:08:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 06:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+7rNRAPDsSaKKCRJHmM2AQY6yXwL13At3pHn6kAyPW8Q3OepZ9enGCPEoFirj2PIpZiS8XT6A2LAUsSEC1iDZiDdEg2aqmRWckPWbIA1cDDk3ycLbtBhTt+cbnBwIWVM2yKRpRUtEkCyQu4sMHEuIFKHZHrrxIjh613Vk0K8Q+Cl7kLJRNh/znvuHMVO/xeONR+Gg9VhWJibAEfRhCxw8kyk/SAOFEQfmW0EfbiwkYi7ISz4477zz8OYrvYTI3hVdd3rR0+OZMQUG29xjOWAqnqkxlcjEqNxGO8NdyzcPL4wAg+ponlUT1e8ySej0SejyYIlVh5fDnLVzlIR2+3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4F8bzVtux9PDsXmtLbNHI/rkqxRqiHOW13NZ6SNuVo=;
 b=Lxtn1Q+ZXQ3oIfVn6hy+gHAq8l4cNWKrSToNlpeeWY76xflrcl+p+gb9B/Yj94JjSnno0d24mSxM/G0I1eK3L0cMQojU0MHmiBTOdROpLs/fneb+jHhoYK3GkfwDYobFxcFLfqy7YUtOpLaCHxsXQRBUrO2LlxvxhDX2iDvx1RSSAhggVwzAv5uS+VbhYOSwL4r8nuGBFIrqWmyeY1IimupCfpJuvm/1uSHjRCgOe2QLI13BrLq9vOCdXCFR16QZOhIOaHG1TWl97B2MxTCdoRvJrJVwgWMiNTPWR2qr98Mpb24QV4qbp0XrnshpIv3RSDwDh1LpGSpGgWOev3LmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4511.namprd11.prod.outlook.com (2603:10b6:208:189::18)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:08:16 +0000
Received: from MN2PR11MB4511.namprd11.prod.outlook.com
 ([fe80::3e0f:6791:2a1c:c4cf]) by MN2PR11MB4511.namprd11.prod.outlook.com
 ([fe80::3e0f:6791:2a1c:c4cf%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 13:08:16 +0000
Message-ID: <fcdb02eb-1c35-d0b0-bd38-347193a41370@intel.com>
Date: Tue, 23 May 2023 21:08:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
 <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To MN2PR11MB4511.namprd11.prod.outlook.com
 (2603:10b6:208:189::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4511:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 64867d96-6ea8-4ff8-8675-08db5b8ec553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YasmCbBATZWM7DPO7OQlc2W8m1cQidgMMWyynnkLiXahC9/bzii7/nrd8F5/BweFLuGuSI5UeQ9YHJbLjGAA22jHitl2Oowr4lTNvPEJfz33BHWN6Um8qPSwgabTUTseQNmxUos8MF+AVh+dCMCaxB5oIp94KZzlbP1Y8PSbW2QYLCEIys79F6T032DZ7vajPUCknF5WQgRHJEDhMtnNicC8nIp6Wlp4KiQmBXUwUPfQBRu21T5V69TFctJxXU9LOCwmulj70zZvs4EwUNeXzlKKAyK3vtEdAREvruS1AkRI7bypMe/DpRhLo+TvoTmJclGYRPZnQQcC2kk2H+m8I0ocvO2n0iwtavkfyTiW39fYZA2G3mFIoE+469dg+HP4adFIheqHVXD1d1diH8bzy+a30dtAaRiXcJwT8T08I7JE3ltcfpiB+QLJenMPluoxELGHpNrgB+qyDyni0NDt0CaOl+yJtIOIs2AJ3UFccWkqIUt6pb9PyNVwRp7OP1AmtRozqGfQvu63KXnp3HIMjAKbe6m9NOYUFqWWD/avY89l4ffAChTIe7tLlx4dLGafh+zngIYV9AgaG1sF1YyH4XpVIdJ4sJs00CWEFJzghmEOArDXyWsjPRiy/iLs24JM3jUL9ySFK4GDNq222u6wkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4511.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(31696002)(41300700001)(5660300002)(82960400001)(4326008)(38100700002)(316002)(8936002)(8676002)(66476007)(66946007)(66556008)(86362001)(36756003)(83380400001)(31686004)(6486002)(6666004)(26005)(6512007)(186003)(6506007)(2616005)(54906003)(53546011)(2906002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpQVzRHWFk4TFU2enoxa0VtTHNiQ3lUUnFrTVZzeC81dU96V3FxS2hFSmdF?=
 =?utf-8?B?WklOdmlLZHl6RmdxSFlGaXBseWxhZ0VFN252ODFXNFZrWW9JdWQ4VjFmZnVa?=
 =?utf-8?B?SEhzK01kY0ZSQjh4K0xxZjhvdEVabStsZEpseHBiL1dEWUhpOFlvSENXRlpM?=
 =?utf-8?B?emRLMlNmR2F6SEZSNGk1U2xpVzBsUFgrRWFwVVM5RnhlRWd1UDJnUWNoUURq?=
 =?utf-8?B?NG1CT2FPYUswbVF3T2JGbUdXYmxuM1dPRzBUUnp4Y04zWC9PK0xyMUhCckF5?=
 =?utf-8?B?RXh6ckNzMElMcU44OUI3VkV5TjYyb3Z6VndTc09qK0QvaktaWitBeXBMUnVU?=
 =?utf-8?B?SmNmYzhQRlVnRGlZZ0NiU2FxTGhBWUpOT3BGcjQvcEd0WVREdXBzeFRtTERX?=
 =?utf-8?B?K3pYMGdUaEZsU1JRVEhFR1dDVDNwMEthdFlwbkJyb2pOT3R4MkhMZG9HS1lj?=
 =?utf-8?B?a1Y2UmNCRkdNaTRNVlBkY05NTE1tM1NaZnc2V2Z6SlhoNzhGaWxLMFVpSThn?=
 =?utf-8?B?NUlZNEFWb2U5bzB6WUVTZzZVNEVMVVRJY1JtZ2tIeXFtU2M2MThFbnZ4WmFT?=
 =?utf-8?B?RzVKZ3QzdFpNZjM3N21UZElWQWFSb3FJdjl4RGU5TFhDREpudktsYTU3cmlM?=
 =?utf-8?B?RTVQTW13ZDBYT2NUTDRiSEpsc3YrZ0I2TW5aYXZTT3IycnJiU1dBSzFLdE0y?=
 =?utf-8?B?RWcyMmUxUWtHZTlCS0l2bWU1aGRUbC83aFNKWDJUcEZYc1lMMjdRNHlyQWJy?=
 =?utf-8?B?endjNDRMVzZaTWNxZXN1VXV4by92NHZEaVJ2a3ZpRHZqczV3L253N2xIczdO?=
 =?utf-8?B?S0NPTENPb1J2amRvNWJZd0JVNkZHMTZXUGRnZi9meldqQ2FOdFI3Y3E0Wndp?=
 =?utf-8?B?aDk1WldhdEVXR2xrWEsxdlAwVzhaWk9yRHoySHh1U0NETTgwU25ySkpsMHZx?=
 =?utf-8?B?YXBkbVQ1R29TNTQ3NUhyNVZyK3VGdmRzTlRYcFpoZWlaSkd1N3E3UFhpM0pq?=
 =?utf-8?B?bTVhMzE0bDJ6a1ZNMmx4Q010K2c3U0pFRTFycVpIL1dLZytQQ3RVMG1URi84?=
 =?utf-8?B?US9HYTQ2VUt1c0o5L0dMTGtLa0ZHcDNZbmQ0WEhVazhLcjdHY1FzV0J1RzF1?=
 =?utf-8?B?dHNZQjUvTFdUa3RiQVdNNTJGMHMrL2Z0azJMMjRkckt6c3lldXFxNDdLbmY1?=
 =?utf-8?B?QUVtNkdBdm9wK2dsbnNHVHMyMlQ4OVIwNlUrTjI2SmZ4T2RFQ3B0UFd3alJB?=
 =?utf-8?B?bHFYam1ITjBEUnJ2Z2ozSDkwN283QWdNbEFUMng5U1BGdjhBbmFPc1NzMXd0?=
 =?utf-8?B?cU84dmNFT1dLd0NCOFYyYnN2cUtvdTJNT3RZbjlSeTBvUm8rTTJFSENraHl1?=
 =?utf-8?B?aUFPMkQ4eWNBdzBwNnI4NVBuNjhES1lRS1BhTVpiR09xVmhiNFVKWElrbGxM?=
 =?utf-8?B?N2hjWEJGVVlTbUh1QmZwODhSellNb05EWlBMdEVuOEtlWDl6bnU1WFplM2lT?=
 =?utf-8?B?K2ZBcTEzcUg3TEdZWWlWVVI3SnhNR3UyTHV1WG0rOG5HTzFaUTg4b2lsNHly?=
 =?utf-8?B?MHhDb3lxOWJXS1BrcmswRDgzVE9lNTEzZURIaGhxbTdmUnd5QjNUM1VhLzV4?=
 =?utf-8?B?VWRFYkZSRnZEZU1PNEJKeGlZVkdmUDMxZlo0R2JxcVI0b0YvMTNqOWtnQ0pY?=
 =?utf-8?B?Sm5Id0xES24xSmUxMytKRWdZSTVYMm1ScXhTV2E4VzB5dTVqVy9BZ3FpNVBC?=
 =?utf-8?B?YVpuMHQ3OUc0M2dKTVlhQnNZNmd4cFd5ejJ6cVF5UHFpSUpBT0FxSTBsOW9x?=
 =?utf-8?B?aXMxU2RvaDZrQ0Z2VCtBdFRLS3dibFh6QkljVmZpb3FDaGNac1prc0xyaWVT?=
 =?utf-8?B?d0dUYWp1N3pSU2wxWHZwZ3c2Y2V6S3RNbk1uczhKeWlIa0l0M00raWNHZ1pI?=
 =?utf-8?B?ZnkvSis0VHRtVFBMc25halpmMTQzWFVMR0pjS1psVnlwQU43YUkyc0lxVFZy?=
 =?utf-8?B?dVdYY2ZGWVVFakoweSt2dDZJVGd1dkVzb3lhWldsbnU0emdXczdSSjRCS0JQ?=
 =?utf-8?B?WWVtRk1uUGs0dFN3NEsxcHpiNCtBZkJNRUVNeVlmbDNpOGdwZTNLN1dLdW5q?=
 =?utf-8?Q?2wMrVnOWb2+EirbYzShQo/RvM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64867d96-6ea8-4ff8-8675-08db5b8ec553
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4511.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:08:16.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5OChRz5ofRXDw0xhOIbo//x92PFwxWGqNhkLqEyxtNaHn6O58O7acLD0AipQPLOz2HhS6kYvLumb69zUMj19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31; envelope-from=fei2.wu@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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
Here is the coremark results on a 4c qemu-system-riscv64, coremark takes
1cpu in this test.

(tb_stats stop)                         Iterations/Sec   : 5358.012664
(tb_stats start all)
    helper - qatomic_inc(normal)        Iterations/Sec   : 2416.626390
    helper - ++normal                   Iterations/Sec   : 4307.559767
    no helper - inline add              Iterations/Sec   : 5168.930031

Also if coremark runs on 4cpu, tb_stats will cost much more even in the
inline case, it's an extreme case though.

Thanks,
Fei.

> 
> r~
> 


