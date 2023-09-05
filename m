Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0444792007
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 04:24:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdLiX-00049t-IG; Mon, 04 Sep 2023 22:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qdLiV-00049Y-Cx
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 22:22:59 -0400
Received: from mail-bn8nam12olkn2047.outbound.protection.outlook.com
 ([40.92.21.47] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qdLiR-0007tq-Fu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 22:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkigwsyqZfV8TTL/dNyzaoNja+8uN2M/2FPVdwff6XNtQvuWlrCJ0Ur2VTvpFQ2/I7m2+trnYp3VOz7mK4QOmyah6+kPXRPv7aH9SX4rS7o+9hf1Kw2yLLajRNHSnZP5P26qZ8WXGIEz4rZGGcB/yFDZsbzHHQVIUodbLhcYHVrL7v0rLxf+AcDByaKBF6+5QBoaqVMYua2xe67ctVqrRgZRVdy+tU1owWVh/y+m1UenE6NBxSDc4M/uCexdH9VG74OdAuGNl1+hQX0mPp6IE/2F7kTKjoaP37wKKmj3tHy97mFgnaCKS3S86f5I8g3svfdAWnJgAuBd6TtkdtDq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWtPnvEoRwvj0OD4tNmCjCPw0SlbbfM8O21J7oH4ZbM=;
 b=gXSO+OQyJkCOmA9KHeh0m/pWL5mw7Zhu/VHnOx0h+sylATmIUvLtcqu3DBVVzs0WVo5qr4xiVQG+QKs5+01kZYbEXbZ4QbtoWX3F27YTLt8WvX+USq1G2/IcOQim5txDbkZ//4DWbzVQ/piGfcGhLlJmMxheImRFn0ypHG3A/8C2E3Bmk2WGHNZv4NcM/sV/kWUykipIqnsr6grO6pzUynSL/XuhMooEkbj4nrTB7qI/rTRkNm17NVW1734Hzcy2DIdXVK9cietxB2iYpTCq+Z76CzboZkV308TQ/kWptM4dDqvucyzhDRTr/pd12xZrPe+/jKGwE0z4I85g9LKJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWtPnvEoRwvj0OD4tNmCjCPw0SlbbfM8O21J7oH4ZbM=;
 b=EvFpm54MDeTVz2gwGggEzPL4ziOWQFwG25+iMKbD3wxEYmq5xp/whWEPFE93etjZbmKMe6WRnVS8XHzlUYLwGaV9d7MCiyzk2iqD3STA4IP7wTGknn5QmUrKHW0Bw8kiVMGeNhxNNBzl4xh3tb/uJL7UW1+C2psVrquu5JZIDph+awBfe09utOMyG7XvtjayW/TdrQXGd3puctKQ7Qs3+UtYdeIERuSqbIT67YyQ8LlSvGHM+HDNQKcjuUM3JT4LiU3pKE3YyzSWI0zhADTxE8J4vci/pJW0UqCf0Uo7B6tjU6w4PcSZCbjaIWWW9qeu3KB6T3VAmPcybmj7gIcD+Q==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 02:17:42 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:17:42 +0000
Message-ID: <SA1PR11MB6760DAE48226BAAF55B7DF2FF5E8A@SA1PR11MB6760.namprd11.prod.outlook.com>
Date: Tue, 5 Sep 2023 10:17:32 +0800
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
X-TMN: [R5TkrJCDnBJETrU8UJ2wkNpkMxkwkJxY5jLFbfzzB54=]
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <c18a4cc7-42b7-2bfa-e049-ca318ee6e6ab@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e2b2a7-1394-4a14-9e7f-08dbadb648e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UJGvDh5pVCQDcHir8Ktnkm8UYiVSJZ8jr0w+O/X6xvZkfu7p3dBH9oWq7ti61TW/Je9rQu/YwtlVSkANP84O4m7ho+fhEUWqdJIoCzvCBeCPW1I97dOPo7RCIkqH2T9a7dDzZHcys77ioLUL89gkcRaHoTnxQc2qTdXu9Uau1rCMMmZZfZkUE94rXCTQj8e7xvgi7ZvtZkCONFxUVYmLwnnlTFweBZ1kgsbB80nGufLnm5WaWISr2nKVZAC12yk07bA3OajimGxTzlQeUJ5L3Eteroi5AL9GGlP/+d+c6DtaRhF7hb5g7nVjQWm1pWkPOJMopafR0VKJDpcQi0ZXcr27Cr0iyMzDwaC+3VgpUbF5xgs+VwA4iA/9d50mQLrnP4KqQP5nkXYDL6QKBE/2ia6bY8Cvl9wqI7JLJf94/e+d2W4TMzROG6psiyqln/gAoCOJqoXz69CCZgvWAtJUyNb7NZJJVJJT0yBqkc7Luh8rYX0W8AvXSz+3/GfpsFa8yrDRB5tfx+btpN55FI+GtQBaRTNHxvzALjh+AnmtY7ZLXY5ENac5tcHIZPP6buQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NsUmhtWEEySm5FTSt3QUs5NnFIRXB4MWZ4cWx0eGJ3bHJEbk90N0xxR1c1?=
 =?utf-8?B?TjVyNmFjTEE1UUxUSWF6aDcvTG8vRXhYVDJhd0tiYlBjSW5DTFFoTlVRU1lM?=
 =?utf-8?B?T2s2ZzJHWlZlWXlXcWpDVXNYS3pnbFNrRkU0VkxpejdBN1N4YnYzWDVDSTdD?=
 =?utf-8?B?NDNTMEZRNVlyRHlDVmkxODhjYjUrdjRGQzJJbm1xb1duK2dOaGV2enJNZzF5?=
 =?utf-8?B?eGRabnQwQndUNjhGb0RHSXV2Z3R2UXlzUjlIV1c4aEp2eTNYYUR3Tkt0Rm5U?=
 =?utf-8?B?djVualF5Y0M5bnlzWEFNNDRWd09YeE1QcXkwU0JWRFUyWkhvYks0MTNCUTg5?=
 =?utf-8?B?amdZRy80cExyTkEyTDNpYVV4RmVUYi9WQXYzRC90YU0xSWtwZTlobThaandW?=
 =?utf-8?B?dWxnSTZoVHBSN09sMjlRUVBlV1Y3aGJEdjlPak10b2c4U0VYbjZxQndEZ1JS?=
 =?utf-8?B?VUJLTzM5YnVvc0ttcVlnbkN6SmVmUHVLbEhLbUtiQUpXaU4wVDhhOWd4aGpI?=
 =?utf-8?B?S25MODFtcWV1amxscVdEd0poci9kQ0Y5QjAySVA2c1NtdjBzRUlsa1NmbHNk?=
 =?utf-8?B?bkFUTUJ0bDRrMUV1bi84Nkd1STRqK3JrZW56TFUrTW5JSzIweDk1QkxuRVA0?=
 =?utf-8?B?aHpKclhWSHZ2WDFiV0UxRGhiQ0hPVTJTU2l5bWV6L29zZ0N6Tlo5L3psMEtO?=
 =?utf-8?B?ejkwVzRqZ3dBcDA2d0hMSXdNYWJuQXovdWtvTmR0a05takh4RE1qYUtCYjVi?=
 =?utf-8?B?ZHg4Ymk4ZHIvRno2ak1uYkp5ZW1RYWNZeUxpbXgzYmw4Q3NVemNFTG5hbTBC?=
 =?utf-8?B?NUp3TmRxd1lpMlN0YTc4YmVwaXIrU1BhY1NlWHE4bWdHcUQwbzNRNGkzbmh0?=
 =?utf-8?B?K1V6SlY2TTJ6SGZhTVBEaHQ1ZU1YQURwNXYvZGp1b3BkK3hEMDZ5TDdlc09w?=
 =?utf-8?B?N3JzWVh5OERIVlM0czRyUDBWb0plSzJnWFd4YnR3VkhIVGlBQjRpL3BPMVpr?=
 =?utf-8?B?dlk1MmV2MGlNWkdzakhjaDk0eUk3TitXS1YxVXowemhuTCsvZkMvRzVBcnBZ?=
 =?utf-8?B?N2orcnh3SUN3YVBMbGFCMFc1N0hNVlZmdE5iZVpUM2NETlVkVDhSeE1aYWkr?=
 =?utf-8?B?bEF6cCtlL3NJcjBPMHRxd3FnbVphUkVFWXVINVZjWmRBNEFRckx1MFBxbnlU?=
 =?utf-8?B?R3FXWnIrVG1PZVdQaFZ2M2pndW01bEpkZnpEbnlMbG1KU3ExaHZITWNDOFRT?=
 =?utf-8?B?V01HRTNlMWY4QlJoSHRyMnZUNGE5RXB0ZWNmQ052TTR0V21FV3NaSkVyeFVj?=
 =?utf-8?B?QUFZelYxT3dPcFNQTEN5RDFkZGlBKzZ4SlcwbjVMVi9VaEdscTlTRS92UDlx?=
 =?utf-8?B?RXgyeVVFVUx1ZExBbEhqQWExM21GaTAvMCtmc2FJS08yMDBOYm5WbGRTcmF5?=
 =?utf-8?B?eGg1VXU3dXFHQkVtOWt0eFI3YkFmM3J2eU9VbERpaWlIZ3kvcUR3d0Z4bEd4?=
 =?utf-8?B?Vjk3bUhTN3d1UDNUS0pxOUNGMmk5NkhyVnFyZEJEWDU0NWh5T1dCNE9FSFp2?=
 =?utf-8?B?bHhEblQyb2p1MHRZSDY5RU1VeGZwTU4rVjl6MjhHbXJXdFVJUjNtUUNkay9l?=
 =?utf-8?Q?UXSsgIzamhFRjisUljkHEeKGkSW96mQ0FZqmrHa2PsGM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e2b2a7-1394-4a14-9e7f-08dbadb648e8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 02:17:42.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
Received-SPF: pass client-ip=40.92.21.47; envelope-from=alloc.young@outlook.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
Use the command line below with initrd built in tests/migration, guest 
runs stress at 5GiB/s. Migration with dirty limit on and default 
parameters, migration can't finish within 1 hour. The default vcpu dirty 
limit set is 1 MB/s, however, the mig_src.log show copy rate at 
128MiB/s. With this patch, migration finsih in 39s.

/usr/libexec/qemu-kvm -display none -vga none -name 
mig_src,debug-threads=on -monitor stdio -accel kvm,dirty-ring-size=4096 
-cpu host -kernel /boot/vmlinuz-5.14.0-70.22.1.el9_0.x86_64 -initrd 
/root/initrd-stress.img -append noapic edd=off printk.time=1 
noreplace-smp cgroup_disable=memory pci=noearly console=ttyS0 debug 
ramsize=1 ncpus=1 -chardev file,id=charserial0,path=/var/log/mig_src.log 
-serial chardev:charserial0 -m 1536 -smp 1


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

