Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465287F45DC
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:21:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mDk-0001ve-6S; Wed, 22 Nov 2023 07:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r5mDh-0001vF-Dw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:20:41 -0500
Received: from mail-vi1eur02on2125.outbound.protection.outlook.com
 ([40.107.241.125] helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r5mDf-0007bI-DC
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:20:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu6bMRs7ZbqK55LkT6f4CWxY2SANre2WnzVJvXeZwn6NQmsG4aSuf77U5dkfmMEpsHFjATXy6fEFREFI4aHJTlZVLSqfDLxCLAmT+uVwTzYjeXhVNQ8fuv49iv+mOd4KTk+pvaCyWAgNexLyGVABprvGjjBhfKqcPvoTbpItxXPNceIJE4qmnG3GPLTioIVFs0m8lCdeZRH9Z1dwMdgpYHZQBz0CZsjGAZOSRpr3NB/wNjwEtB9Vr7FLew2A7RresT9H3TxH1d2/URmjiGBjv7d+RAfYHNJy3YYBbDnr3I98aUlMIhknB4+ySxmaKWaUp7RL56v9IDXNHto9e6cuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZxXvx8f6tVripAvG0ofkc/Gwfm2z6G3MOTdsPs3Jh4=;
 b=TfegqA2ejSMEARo5XuLaasdBkjxXqaXIVaE9bhgJ+36BRt9TwCfYycDShiqJ8WD8YgSKDDdahWnpNm9NYXvvFXgEejQzm+hMHRdWhw+Hi4+kV5VuyddZ1LdVZbUtimfvi7iu3udpv4ap5m6f1HMrEw9Ma3ghcwRyryX9KPk/3h+/Xc5gL1NmxGFVkMI7TL2mZibivV9Ntq940GP9aJJv7SrobS10xNhBUhhElQfZnafGNvBncb09cLhpuSqK5voXrbvL4tLyJxWCppUtVVL9gwM9h3k+yCFttX8ZWua7Hukkn+06qP8y5s2dwGcCJf+rOGnS1S6r0B2YfXjPvszkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZxXvx8f6tVripAvG0ofkc/Gwfm2z6G3MOTdsPs3Jh4=;
 b=YfjoGf7A/GwP1WjQ+Ktdc12WgaL9oq1DT9SR+mDdFAJgyG2EA2UV+SS0CoST+p1+UUQIQlgAWRUint5pILUickGf3Dc2gXIBiKYRJHUZqSv/5Ot6A8HPQ1PKlft5srleQBuQfewzCCqNnLuAV+nfQ+Mi9v0a3xoWSQM302wnEaD3Uyog9PSuEIC73bwqwUDM82wrcP4/i7AIUpdBPiXK1hhd59zD5qRRc6cre5Jp+Mf4YDtxa0seHrGRk4KJYNZmRpiIPC9zPZq91ofaZl5g0/oGPHe9dA+TmisIYwhb4ecwJVuv4wCjU9uMRLBD6fZAbP4cWfxZKbOEClwJI7wUeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5435.eurprd08.prod.outlook.com
 (2603:10a6:10:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 12:15:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 12:15:33 +0000
Message-ID: <3680db49-46dd-42b0-a570-afe562c6ff9c@virtuozzo.com>
Date: Wed, 22 Nov 2023 14:17:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM
 exit
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
References: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
 <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fa5f67-30f5-4d7c-fe1d-08dbeb54ba1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dATtz026qZOQXU3KAMSNVT7k/Y7gbQew8ZrDD1v3M6QFI82XP+HBgi0fbtziHfNLV6TZW//NwPH2JrLrATKy11ILfUWzHGqBKQYKH93bntx1Vvu4M9CbAX+cWZ/f3TphGU/BBoKVE1f5JXH5gTuq3emQuJ3IutTjHE6cH475Wd/vwP64K/QL3WQ7C4CiPvt4qTrh1B4CM6teYxkKnb7/JWJXwZxJamjH6diDQkRKK24aoNcMMaZDRQsRyHHnonrJf0/O9Q2nvp1W6DlKKR7c8ElhMYvTtVZJmU45WISGm541p0fhu9JkZg0nyoXaQdp8D/xsCNdlidEc17iGIiDJJTicClnygRe9MFmENO1RwtLKwcs5vA1OlwbxQ3dCr3BZbcOoFuRaS613XWigp5m2GpjLxfoggqjA0XjrYFgIfzjgoEYpCYFI4qXokMfwDX3wQFGgpO8b+oWcOpY+iGnvnpXYGST8I4Up/cPTQTEBr39K8NymW3a50cABGLrBzjmJAjtG8KUz/W+kXLLfIuhYAITz2+7HLqmkYgtOPDD59RdIVJSzox0pT+/YexEKdF91uh0FznQevTV1KUjY62rRRumse55SsTbsQ9gSQ7bMxn5gIXs90J0WClvWkFevCx/eHIlaX1BgodP7wanqRyj70A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(2906002)(5660300002)(4326008)(8676002)(8936002)(44832011)(316002)(66946007)(66556008)(66476007)(26005)(2616005)(478600001)(6486002)(6512007)(6506007)(55236004)(53546011)(6666004)(38100700002)(83380400001)(107886003)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdvWEJyVU14KzVBNGhDeTBtNnZhbzZMZFBiQ1l5NGplM1k4bm83a1YzUE5M?=
 =?utf-8?B?R2FhaUd3UmRUb0tKbFBWZHZlQ1B1eTdsMHdZZ3dXNGVlSXczc01oYkhuN2Ux?=
 =?utf-8?B?cGhtWXR6SE9qUDM0eFluTi9mUTFFNVBOYXVIVXN3Y2lkcmhLTWFmdmRHVzE1?=
 =?utf-8?B?cDdMVFkrUThpeXN3WUdWREVwcmZtbkVHRUFvNjVKb2JIaU9SZVBoLzZiVERO?=
 =?utf-8?B?TnF0MUQ4MFJIcEZpa0t0d09MWHY1Z2NtYzkrK29CUWthUmhjWkVGbm9Ic2Iz?=
 =?utf-8?B?K2c5YlNxZUN2WG1DbktneGtlWTBtWTJ6TTNSUjl6ZUdnZFVoTEJTajJoaFlr?=
 =?utf-8?B?alZ5K1lsVnJxY3JxUDNRa3pvNDhqUU9OTHNTd3FrQUJ5c1A3RWlLeVVTMC9l?=
 =?utf-8?B?eUdWcDVKeUFpL05OWnh6Z05ObkF2S0xiY2QyY2hQNXBFQVllbFByVmxpR1R6?=
 =?utf-8?B?UG5PR2ZGVGdkUTNTTVNnRTlNMkZDN0phczFnUkEycldqRE45Y3JHT3JKbG1Y?=
 =?utf-8?B?SUd0RFZLTW5jVmpNTllXVXppdHN4NU5nTVZKZlJiOXlINnEzWndRNnBIbnhv?=
 =?utf-8?B?WXMzZGRKMGl0a1BUZVM0cXZNTTRjb1hEVnhnUUNNd3NycW8raEtKd3Zmajhu?=
 =?utf-8?B?WFUwbHEzaE1NbzNuTmhLNHBRS1htMkhZNGpiU3pGbjRyeVFRQlprY3NnYkNx?=
 =?utf-8?B?RGJLeFN5eE5vZmhtYk1IbUF0RnMzUFgxdGxLaU9UOE96ZmVEcWNhRFg0cUhK?=
 =?utf-8?B?ckZQQm51dWZibmcvNU92dzlUcExtaHkzWmZmUnJtODRTK1RkM3ZzZjJ3VXZW?=
 =?utf-8?B?eEpQNENPeHIyTzVRa2t6dE1jMmJ0Qm9WS0YvQ09zUjNqbDhDOWxVNXVuMjBD?=
 =?utf-8?B?U2w0c2lIc0QycUZ3QWx3ZWtMUVYwWVRRMU9JNklRNll1bGZndVdnWlFQcUFO?=
 =?utf-8?B?ODBkdFFIbjJ0TlhZb1ZsSCtXczd4dlpSU1BDaXBhYzNwc1B4MDFISGhYK0RM?=
 =?utf-8?B?QUx6U3M5bElXVHVMcjZJZjc4YS8vL1gzMFRNd3MzOXBwbUV1eWVTaW9uekty?=
 =?utf-8?B?T3Q1c0NSSnlUNzNLblR5WnBJR0h0VE4ybHdXV0FGQ1NOLzBQa1dJOVFoRWV2?=
 =?utf-8?B?b0tWZnpYWkhUT0FDOEVrZ09nV3h6OWRlZXluc0p4dVZ2L1FIRGFKNmVBK1Za?=
 =?utf-8?B?RDdDWGdyRS9WbDVwUmVSRkgwMkFnNlBWOWtjY3RGOGJLdHQ5c0Fid01qMkhl?=
 =?utf-8?B?Y0dDYmZxdjRBZEFsQ0hKL2dISzlHQU9oWWo0WDRYamwwck84aDJqWWN0V2F0?=
 =?utf-8?B?Ync3MGlOTTNYWTRtU3VoT241Y1pVOWFpRzVVUjhldmh0OVV1MCs2L3JmRGUv?=
 =?utf-8?B?ZEdFWVNTejZYUzYrclhBRXBxb084NlYreXRoZ3RoMUh6em5ja04wM2ZTR3Bh?=
 =?utf-8?B?bEh3ZExJcnRydG56NmwyYVR2OG0rTm5KaWQwdTFabUVFQVFNVVVzWW1SNFJk?=
 =?utf-8?B?V3RXNU1qZWY4MXcwUFBENVhRR3NPTVBnV2pDNVNuYTYwaWxWUVBvTTYxUERB?=
 =?utf-8?B?S3ZWYjNHZVgrVmI0K0FDTjl4aDVHUEpJbGZZMURnbVcvSFdFNm92VDE1anlU?=
 =?utf-8?B?TlptMEFFZ0lnc3c2cDZHLzdiOWU0UFVJekFETFdFUHlpa1k0SWk0em1pRjlK?=
 =?utf-8?B?NW1lVzlLS2xVdkU5WitsY0ZCWW5yUG1zU2tzNWJEaVRzVkhiQmhHaEs2QXJW?=
 =?utf-8?B?TEdxa0JXQ1NkOGd5Vk5xdXUwcTBFVDIwRHkxTXM4TVd3OUpRNUxBQnJZKzZ4?=
 =?utf-8?B?S2dGdzhSZjUzT3p4YWkwemhxQU5RWVV1cWRPSUxaVCtRTTUwWG5BRmlVbFVv?=
 =?utf-8?B?RkNLWjZpYVMzaXY0VlV4bitWeHJMTklBWEw2MEJweUptTmNmTElYQjdpMnZN?=
 =?utf-8?B?ejFjdG9nRWMrejRHVGxaRXJFMGdWdDhGeTVUUDArVzNHZFFyRG0rMDE0azB0?=
 =?utf-8?B?R1crS2dBTENHZHJZa1VIbnRjTmFYSHBRRDBnNkNKdEtGdE8rRTlWcDBQUjdv?=
 =?utf-8?B?MkVGQmVYenpBYm56eDhlenUyZWRZaFRQSlUxQ0hKTzUyY1R6elRuYXJYVmJG?=
 =?utf-8?B?TElwNHgzUXY5Q1hWNUhwZlJudnZSQTVjdFl1dHVYVTF6YmMyQVAvNU42SCs4?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fa5f67-30f5-4d7c-fe1d-08dbeb54ba1d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 12:15:33.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM55t+E6crzmwwsUnGjyiMRWQSaraL+nv7ifSJIZRlgMZ8Rpf1exI+NRQnemIAmJAxSdq6/FdmHBQo8DJHMcVQRyHGjsWp2jnaUGeypEC7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5435
Received-SPF: pass client-ip=40.107.241.125;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 11/1/23 18:13, Denis V. Lunev wrote:
> On 11/1/23 16:23, Andrey Drobyshev wrote:
>> Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
>> KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
>> extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
>> exit.  That's a natural thing to do since in this case guest is no
>> longer operational anyway.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Acked-by: Denis V. Lunev <den@virtuozzo.com>
>> ---
>>   accel/kvm/kvm-all.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index e39a810a4e..d74b3f0b0e 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
>>       } while (sigismember(&chkset, SIG_IPI));
>>   }
>>   +static void kvm_emit_guest_crash(CPUState *cpu)
>> +{
>> +    kvm_cpu_synchronize_state(cpu);
>> +    qemu_mutex_lock_iothread();
>> +    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>> +    qemu_mutex_unlock_iothread();
>> +}
>> +
>>   int kvm_cpu_exec(CPUState *cpu)
>>   {
>>       struct kvm_run *run = cpu->kvm_run;
>> @@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
>>                   ret = EXCP_INTERRUPT;
>>                   break;
>>               case KVM_SYSTEM_EVENT_CRASH:
>> -                kvm_cpu_synchronize_state(cpu);
>> -                qemu_mutex_lock_iothread();
>> -                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>> -                qemu_mutex_unlock_iothread();
>> +                kvm_emit_guest_crash(cpu);
>>                   ret = 0;
>>                   break;
>>               default:
>>                   DPRINTF("kvm_arch_handle_exit\n");
>>                   ret = kvm_arch_handle_exit(cpu, run);
>> +                if (ret < 0) {
>> +                    kvm_emit_guest_crash(cpu);
>> +                }
>>                   break;
>>               }
>>               break;
>>           default:
>>               DPRINTF("kvm_arch_handle_exit\n");
>>               ret = kvm_arch_handle_exit(cpu, run);
>> +            if (ret < 0) {
>> +                kvm_emit_guest_crash(cpu);
>> +            }
>>               break;
>>           }
>>       } while (ret == 0);
> This allows to gracefully handle this problem in production
> and reset the guest using on_crash action in libvirt.

Ping

