Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04C7A7008
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 03:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiltG-00009J-7X; Tue, 19 Sep 2023 21:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qiltA-000094-T9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 21:20:25 -0400
Received: from mail-bn7nam10olkn2101.outbound.protection.outlook.com
 ([40.92.40.101] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qilsw-0004G5-87
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 21:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs8cwyuNayPGxyoktlas6l9TDB6Sr+YwaAkCJv+/uCEll0Uaoyaz201NUEn5FDPFspCwrWTP0N59q7ZCdOqQuMaksyE0JBRNP/2wYbsgySmJgDIJ9U6/Kb1SgPLLw6fgvWkWshOC331fMlcp7xQAPhpLTrzglo+ehcYbmsCW+sfh6f5EfRVdO2eVD/xPOI0YoVc47TIEfMurW0OgJET59fDC4rdKyIgKKqFpd5yDKTV0V7J69ioVOm/xbdBCXtaxyTO70rqE0xWA+Xs+urEqnYUhC3AzfaaKjDJ9yNlJ1zE/ohkM9wbD2dFy2IlLXNkTRb5onoWVOC4kchcmaiBXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEwPMSzOuN/ozcZo8oVKW3kFRD4Gmvj/iFW2MQf7ZB4=;
 b=l381jm5VRwSGSEOv+QOxCqet09CNpZcV8dmn6SAgBZ/HD1YyFC08zwpEUYTCs0S6sdc8C58jTW2mI5miHiP7ep8+bNrHkhg/9A8gHGZWbP58jdOeGSTr5xhMD31Q+nC8CKMZ6hiv04y8QPVjG311L57w9G/sn3jHTpVPNYoFyjSPsQLaIMEQpahvCBlRKiJAc1gig+oJoEmnpygTm1FKV/QOpL1ZHqr4glqk5N4HAuOfeCKOQgdpwONBVYkTaBRNxLM7dyZKV5V8xcuHkON0qCHDl83X8PnC5EMOR3WPpni08kXudYHnEwMOFhrv4SW1da2QYpLihQIweQh2Mi0n3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEwPMSzOuN/ozcZo8oVKW3kFRD4Gmvj/iFW2MQf7ZB4=;
 b=GM7dcIMhWuXzoSDylBXs5rFGd5e7osPrsBOvjsYaiDbVKwogOqaf0dk+ihxXL3Y7mEgQBh4cBo6APd6lwbXlmyHwRyWa2wJUCNTEoL+RFcEHr1lKzNPSRWss333UkZFQ/hznTgcIVdjU8pBLYPDPrjZU4zgomTmGt8maqt2SrNpK/JeIEAdVmbqZ0bmgMkUSCGtvMF6ItTvek3rRW16Ws/H0xL9EAsL0pdTehjHotU6Xut5o0EYmWHP2nTl11Bo6p/LeFHBr7Yptn9UWA7dPy83LepqashBbzDJKHREqGyoQUTc+4Wi9OpxTJBcANAoaMPiajDlnG6I0OFbRUQ1G6Q==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 01:15:03 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8%7]) with mapi id 15.20.6792.023; Wed, 20 Sep 2023
 01:15:03 +0000
Message-ID: <SA1PR11MB6760FDD4981606F5E5B88A38F5F9A@SA1PR11MB6760.namprd11.prod.outlook.com>
Date: Wed, 20 Sep 2023 09:14:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: ping: Re: [PATCH] cpu-throttle: Fix vcpu missed throttle work
Content-Language: en-US
From: alloc young <alloc.young@outlook.com>
To: pbonzini@redhat.com
Cc: philmd@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 alloc <yangcg26@midea.com>
References: <SA1PR11MB67600F56B3AE6348E7D6FEBFF5FBA@SA1PR11MB6760.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67600F56B3AE6348E7D6FEBFF5FBA@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [xa/h/6OchVF7fLLEttXI9mnC/iJ/NcLR]
X-ClientProxiedBy: TYCPR01CA0188.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::20) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <48f603ee-8bb7-f65a-64d9-c166692b31b4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SJ2PR11MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ccb5dc-4e71-4c1d-0500-08dbb9770496
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjZdFbcVzqyun4rj3E3swiOj/4z0ttUmGXA7BJng0+t37aat0ZVAg+3ylevZkUgm9nVzmyDPjwxSjyJI7ib15tyHQDMR/BsQd81m5YcDeGBQcXCOO6EEvD2NQm/5q6UWXxvz6Yuazl9TJzbq1Irk+mqQ/fkpoEWmZQDbZOgT0eOWcZZbmrhoQIxYiTtW5h2xHjgujCV7TyO4Zo4CwalLdCNrAQ7gPjz6B0DvTjzHB6ufb7ZN7RATc+7QuZaEY1R9kkP4sdFHlLj4szHcqBZScXS8zyVrMUnEJN+1HzFQa2aXv5V/4BJPtfakUtTonkXFTwvUf/Ku8REfF0znUXsKcEqqIiN9cQnAAVootVRKKZpu2HFyw3n7lAHGdoWMPXB99S0mwksPtEsmNlBzB6K8RB7jgGW69Wzdoj3A1hxnSeVFWR62UGNtI4BwzvrUTWO0U5odNiBEFFcGIdt25FUBUonQ7YMKoAX8RP5rLn4jAysADnUXeGsuHDMXX7vrzeafvYg29t5k+GELPWnSwoPTUE59xnvQIkj4gvlKvfIpwlRp5naVaPLrQh0khzoWGF27
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlyTENEMWhhSENJalR1dDR5cE1rVDh2dE5DSFprMFl3OWoyZlV0Y1BWTGtn?=
 =?utf-8?B?bW4rNjBvdjdkOE4vMVUyS0NUejlkUHA0ZGtwdm9ueVRpZFpDTnJXeGdFeG5L?=
 =?utf-8?B?bFlqZkN1K0xCd3lvMnhJZVVWRU5zb0RpZVN3V1FTbjJmd2kzSkJ1UStjVW9v?=
 =?utf-8?B?RlFIN2VSM2lVSlhmOFhQNzRtVGtRMWVYeGg4RzlJckFQUG8wNVRBYmZwOWxR?=
 =?utf-8?B?YkhESDdWWXJBRjNoS0Q1WG8zNUdZV3MzRzVsb1crV3RGRGlnSE9rN2tWQTR1?=
 =?utf-8?B?dC9nNWhSNng0Q2pVSFFXWHltMGN5UmFNNGgwb1Ixb3VWVnFreGkzeWZscjhM?=
 =?utf-8?B?L1FlR1ZzWWhYSW14d01KeG45d1RzdnNnRWt0aHRlS3JPYTZzWm5na2drWHJ4?=
 =?utf-8?B?R1JNUmZSaEVYTWRSOFFERUtIZVp6STZyVnYrSmxJdEE2dERTOXNDa3htU2l6?=
 =?utf-8?B?dmpTTDVGOC95N3k3Mko4S0RYcjhVRlJvYkRjbHczZ3FlVUdycitmNERFaGNC?=
 =?utf-8?B?VVFmMDZPZ01uSkYyTktvODRYZ2d0dUpqZEVhUmZ4M2twVEhVdENlV0V0Z1hJ?=
 =?utf-8?B?VUhyQnNjeXdTcXpPODg5SVQ3dWd2YVExWjF3UExDZjFYdjRNN1VhQVM4aEcv?=
 =?utf-8?B?TjVYeDBKU09kL0NzV1pnTmluTklMM0JRalNVSW92eDRZK09IVUV0dzVGYUpM?=
 =?utf-8?B?c1N3a0xBQk5TbjBZZ2R0UmtlU0dPSXpVOGRQU3hDVzNWU0ZJSzh1L3FXUHJT?=
 =?utf-8?B?UmxaeVVIaVJuTnhXUzJoVWszTTZ6WVQ0b3BRM2JacFZwUVFReGlXV011Sm1Y?=
 =?utf-8?B?U1FNbnl1QzRIQzVha0tHK3lWNjlHdEl2dzBBbjBJY1UxTksvc2VWY0ljd1lP?=
 =?utf-8?B?bzJ5Nm4zUDZRS3hITWNxeXFFQlo5N0VYMm95NjRhL3BTQmdzamd1R29XaVVl?=
 =?utf-8?B?WmpKZWZYRi95RVIyTllROXNLWjBraFlzZVc1cGZnR0V2bGcyWElJV3V4K24z?=
 =?utf-8?B?WjZPSkt2T0FJOUMra1ZTUS9SY1J4WEdxK2lHNWhzZmQ4UndUcmVNbnd0U1do?=
 =?utf-8?B?RWlWdUlrSUVEODd4N1p5K1dZUVhTTGgyaXdSb09qOW9zT3NpQkROVVIvSjlP?=
 =?utf-8?B?bWl6STg3NGJMaXFBT1JqL25aYWtSVWdsZVd6dVVVRlAyd0lGVGxkcXFVSnlp?=
 =?utf-8?B?YUowMmlhSDJLcC9Wd1JrWGo3UzJ4dCtJbWNydklsM2VIN0c5bzFud28xQUxv?=
 =?utf-8?B?L1F2TjI2RnM5Z05DQm1ad2hoYUZNd01veWQ5cW5XREh5VXNFbzdyakhEMU9S?=
 =?utf-8?B?UmFWSjRGdWJhWUErRlNZaHdFSnN1VktxVGZEYlkrK0FHNjZrM3pIMTFrUXVz?=
 =?utf-8?B?K2cxaU9FQlU2NVl6SXZYTzBvZWlQWHp0Mk15VnB4RzMyUGxzN0Y5VEU5OTA0?=
 =?utf-8?B?dTFidm12NTB1cU5rZ21ObWQrSTdhMkw3dmtIYlptTm1SMUlNQlpwRlhUU053?=
 =?utf-8?B?RzV5eXhvamx0MmpsUjNZUDFUa0QwNnNkV1dRK2E2UDRuNUZhTHFBUXdYbUxy?=
 =?utf-8?B?N0VaTlYwM1I1Y004VW1HZCtoRDFCdkkvWDhhY1hIa29hdmJSb0tia0xXMlQw?=
 =?utf-8?Q?WoeaqAgvzYxBKB9WM4WeP0KgJW+xbfOzErMqUxlA02M0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ccb5dc-4e71-4c1d-0500-08dbb9770496
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 01:15:03.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
Received-SPF: pass client-ip=40.92.40.101;
 envelope-from=alloc.young@outlook.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi pbonzini:
     please take some to review this patch. It fixes
autoconverge migration issue for heavy memory dirty
pages. Any comment will be welcome, Thx.


On 2023/9/18 11:29, alloc.young@outlook.com wrote:
> From: alloc <yangcg26@midea.com>
> 
> During migrations, vcpu may run longer than 10ms and not exit
> on time. If the vcpu runs over 20ms, then it'll miss a throttle
> kick and will run the whole tick. When this happens and vcpu
> dirties pages fast, the migration will take long time or event
> not enable to auto converge. To fix this issue, take overrun
> vcpu time into account and adjust the whole sleep time.
> 
> Signed-off-by: yangchunguang <yangcg26@midea.com>
> ---
>   include/hw/core/cpu.h  |  5 ++++
>   softmmu/cpu-throttle.c | 58 +++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 56 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 92a4234439..0b3cc3e81e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -430,6 +430,11 @@ struct CPUState {
>        */
>       bool throttle_thread_scheduled;
>   
> +    /* Used to keep last cpu throttle tick
> +     *
> +     */
> +    int64_t throttle_last_tick;
> +
>       /*
>        * Sleep throttle_us_per_full microseconds once dirty ring is full
>        * if dirty page rate limit is enabled.
> diff --git a/softmmu/cpu-throttle.c b/softmmu/cpu-throttle.c
> index d9bb30a223..bdec8dc954 100644
> --- a/softmmu/cpu-throttle.c
> +++ b/softmmu/cpu-throttle.c
> @@ -36,22 +36,66 @@ static unsigned int throttle_percentage;
>   #define CPU_THROTTLE_PCT_MIN 1
>   #define CPU_THROTTLE_PCT_MAX 99
>   #define CPU_THROTTLE_TIMESLICE_NS 10000000
> +#define CPU_THROTTLE_RUN_MIN_NS (CPU_THROTTLE_TIMESLICE_NS / 100)
>   
>   static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>   {
>       double pct;
>       double throttle_ratio;
> -    int64_t sleeptime_ns, endtime_ns;
> +    int64_t sleeptime_ns, endtime_ns, now, overrun_ns;
>   
>       if (!cpu_throttle_get_percentage()) {
>           return;
>       }
>   
> +    now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>       pct = (double)cpu_throttle_get_percentage() / 100;
>       throttle_ratio = pct / (1 - pct);
> -    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
> -    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
> -    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
> +    overrun_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) - cpu->throttle_last_tick;
> +    /* If vcpu runs longer than 20ms, then the vcpu will miss next throttle tick and
> +    *  will run almost the full tick frame. When this happens and vcpu runs fast dirty
> +    *  pages, migration may take long time or can't converge at all.
> +    *
> +    *  Example of guest run longer than 30ms when cpu throttle is 99%
> +    *
> +    *  guest run(x) throttle tick(*) guest sleep(+)
> +    *
> +    *            +++++...+++++x xx+++++...++++++xxxxx...xxxxxx          vcpu
> +    *
> +    *  ----------*----...------*------...-----*------...----*---------- timeframe
> +    *
> +    */
> +    if (overrun_ns > (CPU_THROTTLE_TIMESLICE_NS - CPU_THROTTLE_RUN_MIN_NS)) {
> +        int64_t timeframe = CPU_THROTTLE_TIMESLICE_NS / (1 - pct) + 1;
> +        int64_t new_ns = overrun_ns / (1 - pct) + 1;
> +        int frames;
> +        int64_t adj, remainder;
> +
> +        frames = overrun_ns / CPU_THROTTLE_TIMESLICE_NS;
> +        sleeptime_ns = overrun_ns * throttle_ratio + 1;
> +        remainder = new_ns - frames * timeframe;
> +        if (remainder > 0) {
> +            int64_t left_ns = timeframe - remainder;
> +            int64_t left_run = (1 - pct) * left_ns;
> +
> +            adj = left_run < CPU_THROTTLE_RUN_MIN_NS ? CPU_THROTTLE_RUN_MIN_NS - left_run : 0;
> +            sleeptime_ns += left_ns * pct;
> +        } else
> +            adj = CPU_THROTTLE_RUN_MIN_NS;
> +
> +        /* Limit max vcpu sleep time to avoid guest hang,
> +         * max sleep time is 10s when cpu throttle is 99%
> +         */
> +        if (sleeptime_ns > 10 * timeframe) {
> +            adj = remainder + CPU_THROTTLE_RUN_MIN_NS;
> +            sleeptime_ns = 10 * timeframe;
> +        }
> +        sleeptime_ns -=  adj;
> +    } else
> +        /* Add 1ns to fix double's rounding error (like 0.9999999...) */
> +        sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
> +
> +    endtime_ns = now + sleeptime_ns;
>       while (sleeptime_ns > 0 && !cpu->stop) {
>           if (sleeptime_ns > SCALE_MS) {
>               qemu_cond_timedwait_iothread(cpu->halt_cond,
> @@ -70,6 +114,7 @@ static void cpu_throttle_timer_tick(void *opaque)
>   {
>       CPUState *cpu;
>       double pct;
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
>   
>       /* Stop the timer if needed */
>       if (!cpu_throttle_get_percentage()) {
> @@ -77,14 +122,13 @@ static void cpu_throttle_timer_tick(void *opaque)
>       }
>       CPU_FOREACH(cpu) {
>           if (!qatomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
> +            cpu->throttle_last_tick = now;
>               async_run_on_cpu(cpu, cpu_throttle_thread,
>                                RUN_ON_CPU_NULL);
>           }
>       }
> -
>       pct = (double)cpu_throttle_get_percentage() / 100;
> -    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> -                                   CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
> +    timer_mod(throttle_timer, now + CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
>   }
>   
>   void cpu_throttle_set(int new_throttle_pct)

