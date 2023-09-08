Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCA79800C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQ7f-00024Q-4h; Thu, 07 Sep 2023 21:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qeQ7Z-00024A-QL
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:17:19 -0400
Received: from mail-dm3nam02olkn2041.outbound.protection.outlook.com
 ([40.92.43.41] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qeQ7W-0008Si-7Q
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA3Z66O+46QToH4RdnRyuU0eG3KrBSjbnH3+da57rk2qVx/I+BtbE9cfvI6u+1zg10Abo2/csJGrmtYBlu+VXsWHMU6NlfSWFUob3dtj4EWEl8/uSDChIU9JGlEELSDYn/E0r60g457QvidF4H3XCL09EzZ6yopMwW7xe8r88sFgQXMKkkU52x1T6Ra4BwnTaPhb3TiIZH46T/dfxwH7eHJ7nVuw/RTrk8ejraQLQ5jol1itiWSagcFi3zgFk5IDFOA7YRPfzJcVC9RGw+2D3DyOumFUmMsiCc/pw2pmjNmfdQlMMZ6JDt3wd++zOnHrIJeAZyhkF0FZVlHQnQCtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95uB2ou1VY5fiNbxGAA0VvNbaN1TA/ozqTPpFHInB0k=;
 b=BILLCjDVVTRzzriYWL2JM0LkdwKIwgKAzdZ7YY31QBzSd0E/GxFAoSIwquQRh7OJVlOPu2IeSgDCrdugViZspFQN3dgr7b41AwI4ZTbOUq8qy4mtpfa2uaYQeoKmUpgbDDpgIAtDga5Fkdgq21SDH2W75BLF3gc092L0b7PTyiLmXiL7pA+Ri0UelO+ytYKiQgtCIrcdwZiANMntoPkFrPR5tbV5/GH2OZPVik9OhX3xIRa0dT8dzyftxwAhxjPHDjws0v8k2D4D0DKJYqFZa+Bo7WKOEJ+F8bQp6vhybpafMtXvWRZft3l4hZZ73ZbhKac1K0teFVDwAASB5ILvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95uB2ou1VY5fiNbxGAA0VvNbaN1TA/ozqTPpFHInB0k=;
 b=oYPuFhkfEhpy8+yeJdouDHG3RRNf9XA8NX1w6qfmHzZunzhatUOuHUg5sionblkW/+0pCw4oJ8WtxK2KNH1I1EEuQewpW5AMVA071dTRxRKEaynmlahLUohJODZACBEQ18b3uhY7vOyJeFb3BOpf80pxqJyumEOs0yaui3yh2Rs8OHutMCCM3jkLphuQlMx3+yl6O9MJZNJW4HdOtM6ht7U1xdiihDWJ7cZulq+kydwSTGx1blTqHccRrsUG9HAQyyGznwPV/D2vpc78sZWXWgWTXsP7rqz/EXmRRACyglw8ibOH4t20gPEsCamK0UQtkQdyrlf/gKpr/8O1GFISPQ==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 01:12:09 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 01:12:09 +0000
Message-ID: <SA1PR11MB676022C1C2E1BCCE1EEA39F3F5EDA@SA1PR11MB6760.namprd11.prod.outlook.com>
Date: Fri, 8 Sep 2023 09:11:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] softmmu/dirtylimit: Fix usleep early return on signal
Content-Language: en-US
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org
References: <SA1PR11MB6760A4AD57255448B62EDE38F5E4A@SA1PR11MB6760.namprd11.prod.outlook.com>
 <CAK9dgmYVeGGf=2jawm77DtiOeqvnN_dEiLvOWK3-r1zzC1DJ8A@mail.gmail.com>
From: alloc young <alloc.young@outlook.com>
In-Reply-To: <CAK9dgmYVeGGf=2jawm77DtiOeqvnN_dEiLvOWK3-r1zzC1DJ8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [qR0Iod+fwELxdifb8ZgBlYC3HtvGKGIKjqmreZNQ/zs=]
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <7859fbf0-e5f8-65c8-7c89-0d7c3e515bf4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 695415d6-00a1-47f5-5f8e-08dbb0089343
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ov9Swt/s0BrLsBEA4HF5GZlW62zY7UZOdRyVdTN7iP3Rp6PMiFyeZXfINuAJ0dRc+Tzv9mp7w1bX0EIsse2dnYGB9CT/t74zHxQpU0XiHGCzlv8+X2Qa9ujLq6u7INJLRPEEk4m5ZbBBqRTAzzXQ6CzYo0xjORj8Sq5E61mb5R24rF+bYYGTuvVY8KmHk5yaN9CQniAcQ0JVgScPpC3fbdksGWE87J7lJ2ILL0JnWPrD2L/Ahnc2tyyAQNy6HsY1X4B/SO3w4MA+MH0yUYRDEWUZ5r0HIaqRbNgOLjVekqSBrAGFIjra8NaFp7HX97D2hJ7Z9596R48UgeSRELbjCaRMXNC4NbXx8/7VH3SN8vdYbA/fN7qBO/bJGfj1OEhC5keZKTglKfTOSt1pJxR7/kjanCD2IyzPuCqE8eJeOXwWbwf+GYRmQMKUlmJdk4AaX5+/nOG+Z1agpNig4l3HFLR+dfNYepcc5LiRaSs62/p4BfOYnLyBcC+CSwTDIGG+JPaAF3D0tVTb5nLZT9FWEs9+hpXK+stdcEonzyCwdGcAdsks/EHbKeixWUjf6Uo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lRdW93aC90Q3RFKzNHanZWZDdEMDJmRjY5dDVjT2ZiZFUzZW9nUjN4UE9o?=
 =?utf-8?B?NkVrb1ZRY1V2bGlaRU5BRUZTVGFhenltckM3MWxMdzB6Uk5kZnNHOGg3cStG?=
 =?utf-8?B?U0Vham5xbHBOaGEvWXJQaTV2cWltUUNlbis0ckpEMmpPSTJRdVdZT2hpNlVz?=
 =?utf-8?B?NExJUFZYUjdneFdtQ0xPOEkvUnJ3RWZpWU8rd1d3YXFOL01HZVl1eFFlbHVQ?=
 =?utf-8?B?c0pJcWpKSnZiVisyeUE0TFJ3ck8xakdaM1BESFhSaGc4ZXpzeUo1R1ROcFhM?=
 =?utf-8?B?cnNDQ0ZNYzAzSkthZnlteG94emZiS2VnRUV5MkVYOHdrRmtOclFMaXorWmhT?=
 =?utf-8?B?U2Exb2JXKzY2TnpTcUkrSlkzNnFLWGl6VElwL1NldStrOS9iNWpxK1ExenVW?=
 =?utf-8?B?NnpZbnJSZTFTMEdjVTRLcmo5dVI2UlJRaDNtNjZWUXdjQk5wMVZ5MzF2STlE?=
 =?utf-8?B?VHlDR0EyMzBRRFJxTGxqakZmck93bTdUdHQ3ZnplZ1hublc1RHBHU0pJaGh6?=
 =?utf-8?B?NW9VVDBzUzd6a3lKNTRmSE9TdU1nWkZGeEZrblZrSEt6Ly81YXordWE1S2d1?=
 =?utf-8?B?Zm91MSs4OERRV3V6ckdvWFpWVHFJOFUvN0J2VGJERit5bVZxeGw1bHRCMFdV?=
 =?utf-8?B?YVRYRlcyb2Z0bmxHU3dwTHpFaFpGK0dHV2VydnRqWW5UWDdRaVJsWElrYUpY?=
 =?utf-8?B?b2E3d1l3dmVTc1h0UFo0ekhJSURyTy9ET1JOMVVDa2kxNktnQVZRU0lTZWpX?=
 =?utf-8?B?K0ZGcnB4elNYdmlMbFFJRDV5NEowQndFZWgxOVNhTnBrWjhHdzNwbWlZZjhm?=
 =?utf-8?B?dzNvcVpueU4vb3VZSDBvR1BpeTRvN2V0K3VEbTBXV25TcllFNDYvOFJMMXZE?=
 =?utf-8?B?R2VUTjdCLzFmZ3pKM0o2enhYVUlSOFBIMVc0TnRzK2FDYWVRQ1hETUtseTlk?=
 =?utf-8?B?UktPNEtKanZDWmgxckI1aEgvdmRQRkEwU29OclFOM3R1MzdhVTBoeDlzZmpp?=
 =?utf-8?B?bUNoSGFwRVVaOXhzWk52MDl5QjFIeDI2VW9pdG1xaTJCZThuNkF2YXdESVlx?=
 =?utf-8?B?TmkwSXVJZHdoanhQZGxxOFUvZlBqSC9TbXY1d0cvblMzaXJ1RXFzTmMrSFMv?=
 =?utf-8?B?OTBzOTJjejB6aWdkNlN3V0kzUGtKeTFIRDNtcExyL3lHNmVsZ21hMTJPWlNK?=
 =?utf-8?B?Nm5ZQ2JTZDRRcUIyUTZwZWQ1SHhYTXoxUHlMM0R3blh2MzM5SW4zbU1td1F5?=
 =?utf-8?B?bFg1SWQzbldWdUMwMzVkeE1LT1czV3B2anlXY0JpK0RqU3Jsd3YzV3pJMEpl?=
 =?utf-8?B?TE9mS2taeHhsOGUzcHNNSnlHNjBjT3EwNGUzWXRDdWI0VzJCT1BDS3FSSFhS?=
 =?utf-8?B?SWxDVGpQQkJmbUNwb1J4ZmpUcHJadjlFZzA3a0duaC84SVVwQTBodzdWZTlV?=
 =?utf-8?B?bFMvUHZQOG9lUHJBd3c5Mi9nOGhxUERNRU1iM3lhTmo3aFJ4eVVna3RLL0Mx?=
 =?utf-8?B?cXhHY1VnRjZGTzRuZEpvaDd0UDlIVDB6dHVsTFRjbm1PL1J2TGNKWWJyeTB4?=
 =?utf-8?B?R0ZqRHZOYkNjaVluVXhaU0w2MGoyalRtM3c5eEVKUGtRR3M4T3I4bHg5My9F?=
 =?utf-8?Q?FkrBUHCfu28w9IUrjq0R83ne8MbHgEz7S/XYC2CLpMJU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695415d6-00a1-47f5-5f8e-08dbb0089343
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 01:12:08.9596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
Received-SPF: pass client-ip=40.92.43.41; envelope-from=alloc.young@outlook.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_MOZILLA=2.309, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2023/9/4 21:27, Yong Huang wrote:
> 
> 
> On Fri, Sep 1, 2023 at 10:19 AM <alloc.young@outlook.com 
> <mailto:alloc.young@outlook.com>> wrote:
> 
>     From: alloc <alloc.young@outlook.com <mailto:alloc.young@outlook.com>>
> 
>     Timeout functions like usleep can return early on signal, which reduces
>     more dirty pages than expected. In dirtylimit case, dirtyrate meter
>     thread needs to kick all vcpus out to sync. The callchain:
> 
>     vcpu_calculate_dirtyrate
>          global_dirty_log_sync
>              memory_global_dirty_log_sync
>                  kvm_log_sync_global
>                      kvm_dirty_ring_flush
>                          kvm_cpu_synchronize_kick_all <---- send vcpu signal
> 
>     For long time sleep, use qemu_cond_timedwait_iothread to handle cpu stop
>     event.
> 
> 
> The Dirty Limit algorithm seeks to keep the vCPU dirty page rate within
> the set limit; since it focuses more emphasis on processing time and
> precision, I feel that improvement should strive for the same result.
> Could you please provide the final test results showing the impact of
> that improvement?

The kvm_cpu_sync in dirty ring flush has to wait all vcpu to exit to run 
sync action, while the vcpu sleep may blocks this. Before this patch, 
the kick can reduce early vcpu return and add more dirty pages. It seems
the kvm_cpu_sync conflicts with vcpu sleep, why not measure dirty rate 
when dirty ring fulls?

> 
>     Signed-off-by: alloc <alloc.young@outlook.com
>     <mailto:alloc.young@outlook.com>>
>     ---
>       softmmu/dirtylimit.c | 19 +++++++++++++++++--
>       1 file changed, 17 insertions(+), 2 deletions(-)
> 
>     diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
>     index fa959d7743..ee938c636d 100644
>     --- a/softmmu/dirtylimit.c
>     +++ b/softmmu/dirtylimit.c
>     @@ -411,13 +411,28 @@ void dirtylimit_set_all(uint64_t quota,
> 
>       void dirtylimit_vcpu_execute(CPUState *cpu)
>       {
>     +    int64_t sleep_us, endtime_us;
>     +
>     +    dirtylimit_state_lock();
>           if (dirtylimit_in_service() &&
>               dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
>               cpu->throttle_us_per_full) {
>               trace_dirtylimit_vcpu_execute(cpu->cpu_index,
>                       cpu->throttle_us_per_full);
>     -        usleep(cpu->throttle_us_per_full);
>     -    }
>     +        sleep_us = cpu->throttle_us_per_full;
>     +        dirtylimit_state_unlock();
>     +        endtime_us = qemu_clock_get_us(QEMU_CLOCK_REALTIME) + sleep_us;
>     +        while (sleep_us > 0 && !cpu->stop) {
>     +            if (sleep_us > SCALE_US) {
>     +                qemu_mutex_lock_iothread();
>     +                qemu_cond_timedwait_iothread(cpu->halt_cond,
>     sleep_us / SCALE_US);
>     +                qemu_mutex_unlock_iothread();
>     +            } else
>     +                g_usleep(sleep_us);
>     +            sleep_us = endtime_us -
>     qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>     +        }
>     +    } else
>     +        dirtylimit_state_unlock();
>       }
> 
>       static void dirtylimit_init(void)
>     -- 
>     2.39.3
> 
> 
> 
> -- 
> Best regards

