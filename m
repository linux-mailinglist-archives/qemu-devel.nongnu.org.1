Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903337DE47E
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:20:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyDvd-0003jJ-DI; Wed, 01 Nov 2023 12:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qyDvb-0003j2-8t
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:18:47 -0400
Received: from mail-db8eur05on2112.outbound.protection.outlook.com
 ([40.107.20.112] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qyDvW-0003Uw-Rf
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgnYOilZk+E3EtXLFMSP3xIyNpJ6srTyeW59pRvcZvji6DZ3/M6/NJb59czMy7MQiIYidpPj86sRQTXqxZ+iSHBwAaXQE3Y/O6myutkmyrZVjcdq1oz03+G99N4cgueh87oxEWO0kwS9Xj2F8pFlu/J68DQFTl0doQvVfBaDc4Crw5YNO8V92N0nFsedRUpBfWQMt3zEqG4AqX0PGX+XB0l6HAat7/tzTfcuBv29YPGJi6ao2uQ0r1uoLEKJAuuWECw88f3N7cD5XnGFJ4gViG4NJc0J6bXAPhY4bKLTJhz0kdruUkfIZXAqK7LW+ZLSsiMGvLsHm8z2VtRy2bsVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keUiuyYyxMsSru08nL4vCOT1gXYajH6PlSuIIeEHU+0=;
 b=btcMTUaMi6UkexMjIh1ujUdujOBgRxCgi1Ov3YPnIkn5KNs1HmRrWv0Os2rujZhjRpEHAGIZyojuoQnnHxzLRZI6LOPxtWrI5Ku2fYZRqZfWPiizeGbfPlggGb09dEqcwxrFD6zeD8rZVJlNlrYzc7EEDd8PADj/V1vlLXiG19nFdfMgVPTfVvy7MWUcHB+MT6Awd/dZxBE75gIgG9k3YuxWfxH1k+MhakV7Gz661xI9PVxhR7AO8yEayMeQF95kw+9ImN3fYc/bAQZtf1g7/CajV2mbufIR8Y1sBiqK6fJkS0PpTh0B/ScVZ1wffcYfYTB9gSoMijyJT+fScZ9j5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keUiuyYyxMsSru08nL4vCOT1gXYajH6PlSuIIeEHU+0=;
 b=MdHqmcD3XMHRtXkGyN9WkwJxdoOtjaWrWA+DzI0/L3FQF63NKXTVq/XkVulXvIwhpldKE2PcsSCz1F6UFdMF5Nv2pXSxXfO17midcg3wBfsA+4vK39ShKZQHwulQTvLS7TazJiZ2vZZ3PJK7I74qEWISMKADgtvk2hd3SLjikele7Zh3sAzuAdKCjsLAc58hNxYBk+oer6sLbQJqzyz76ZRJtp2Khj8sphJq8MVYYk8cbCU5wdghxLdksg7L1J7ufpH/7U33Rm1btBYTp1yqNQflcDL4OhN+N65TPkIZPvruSicEGPc8A60yQX1h4imAXeclwPl0zvVpGN0QpxXhWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV1PR08MB7804.eurprd08.prod.outlook.com (2603:10a6:150:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 16:13:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 16:13:34 +0000
Message-ID: <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
Date: Wed, 1 Nov 2023 17:13:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM
 exit
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
References: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV1PR08MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbccca9-d0c6-46fa-1c00-08dbdaf57f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJ0AIlWvA95KSWq4rBA+cPFNakB706ZPlKiF2LmjkrINm4gkCLmIYWDGMsin+uTqqtwMHUMwr0n8ngTnN5PsrvS+WXKih0wQcelhlGngZaOwRalNM59eCBGpGE6e3D07nZ0GyWAItMffR0WYhp9u63t/mfFS4k1jvsuQ3LIknN/FwQUXxZ2J6nfvwvo4K76W2A8TzzofTk2Jh4f4sAuQxP9OVoa1auxMlnfsRZWXMDZz+G4GpNYQdNqcVfwB9rxcmbeJL+wg8HqGmBAdSnMNTwrp05Ylbu7H/ZUbIG5KjguG+SAA8mdi9ydf0HmdBH8OukTOdPekRlPrr5juqCQ4Yn5LXSdiH4jabE8och0MNwFDTN5w8PfDDFQQHm4TgQGjH5XRxyu1XKX1/KymmI3oSk6l49A3hSSb6XC5pNnlb9hLUIJwKtaTvoAc6Byc+5iLBR0trmp0dY8WjhrpfkooCJOn92VcjqvIjrgyNFeD41e4hhVey9EiAx/UUOG/7IGoJtjcI6MNFlbDQJ5cyIjaoUD/LB3V5VfRtobBN8kWOZeOT5Ln0wUcWxGwqpRlqlnS6f/VmMfmTUdqvLwb3agBZrlbNMhYkyg+THLwEiUTUZMt285fJ0kX1QaHPxkQXUDPAW2FwsFxb2GE+Ex1cDa6PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(376002)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(6512007)(2616005)(26005)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2906002)(6506007)(5660300002)(8676002)(6486002)(478600001)(107886003)(53546011)(66946007)(66556008)(316002)(8936002)(66476007)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFkaVI0a1FiWVJYbzBKVUZRdUhnamY2WGg0V2lveng3a2Nta1pFa2VYVjlU?=
 =?utf-8?B?cWVtK01lSnh5aHl4dTh4dGJnenlQY3g2ZEoycDNwWGJNVElQVVE4MHpHNlNN?=
 =?utf-8?B?UTlZR0xmelVjOEZmQmd5a3MxOFhsMHorRFA1RkVGRlFTYmUrWXd5Nnk1RmU2?=
 =?utf-8?B?UTIvaXEvT0ZDR2VUQ0F6SmZPQzJER0R2K2VNTWdGZGQvTTBFZXUwaVFZTy81?=
 =?utf-8?B?L1FMbUYwd2JZZkNiMDdMZXF3dVo0Q2JQSmp3WEdVVUhBSHE0M0t3K24xN1FR?=
 =?utf-8?B?M0hBcUM0M0V2bjZab0hMYkx3ZUM2SzBnN2VsczNzMnhFRUl4ZHkzQlJYdkx3?=
 =?utf-8?B?ZlVlV2xIcXhDTXRWdVJyT2M2NndJNHUxSWNZY1dMU09OVjVVcUtBbExZaUhJ?=
 =?utf-8?B?bFY2YzZWSGhqWTRFbVM4aHhVcENXaEhWOEVqR1BvRmVEUkRQWmxhZklnOUdP?=
 =?utf-8?B?Q2pKczFuT1J4dFB3V2Y4Z08zRmt6cDgrZWI2Y1VPa21lYXlRUjFValRJRDVz?=
 =?utf-8?B?ZHZQUFVrVHEyMVdmWXA0dmZQcDkzeWJXZmdWTW50QVprajlLTmdrYUlSc3c0?=
 =?utf-8?B?a3ZQNFNjOStQSlVyVFo0U3FOY3BoaFNReXc1cS9zMjRpT3JBVEhRVjdENWRs?=
 =?utf-8?B?aWJ6ck1WdmhvMVBLTFg2TSszaURFRWNab2Y0TnphOWx3UzJ0SVhiQk5WemZn?=
 =?utf-8?B?dkw2THJkM3htb1BiMmhPRkMrSmpCTXVUTW9Tb0p2WTl2WGpsYURMNDVGZ0lr?=
 =?utf-8?B?Q2xla3ErODAvdE1iYTFnS0pzaTJXaEVGN3RibWY0WDlWWk5TS0xHNHNLcmc4?=
 =?utf-8?B?b3VDY2JmWXFMRGxkQkJBMDRwZ3ZaOUZBZzJsNjJyVjRhWWlVSUtKVkFzdTZy?=
 =?utf-8?B?b0VxRXkyR2htV2pvM0ZXQVJkaGoxRE9XMlNMOXB2UEF1bEM5VG5VRDRWeC84?=
 =?utf-8?B?K29ZdDRRanAyOEUzbXFueHo5UEpiUzQ4U2xsdit5QU1aRHhocEdra1FvZGhU?=
 =?utf-8?B?bUxlWXJ6VnVTZlRqN00zVkl4dVFxSlo1OTRYelJKSGhHMWorSTFlelNKUWo3?=
 =?utf-8?B?S0NCaVROQTdRWm42Z2wvakVKZHltbnJQMEF0R2NkcUFCL2RQMzhPSDFJKzZI?=
 =?utf-8?B?bDJBRFk4NWFmalFHV1dmcEh5bXo1UzE4K3lnSHJYK2hEak9xTm92UU1iWE9q?=
 =?utf-8?B?YitZaGxoRU1MdWpWamcyUnJsd21CeE1QUFVuQ2g4b3FFaytqNEx1K1V0dGFO?=
 =?utf-8?B?dVZEaktpS0E3dFFnYnhjUXlHV3kxRGZkR2hLSG1jWjhubHNNL0VrT01TMG5Y?=
 =?utf-8?B?dDJRamRXVWpzSnU2d2pVc2ZoMVVvblRzRTI5eDRRK0FwVzdhWFU0N1BVSGwz?=
 =?utf-8?B?cHoyRWswMFVVSHFQb3RObHpIRFlGdjQ4a1JQWmFzQjdHMjFkVFIxbElqV2NS?=
 =?utf-8?B?R0t1SzBIUzNTS1BVV2QxaVQxUXNMNXB5c2hxbCs4bFVqN00zUUtXVHl3RjFQ?=
 =?utf-8?B?MTI1ME1rZ21CRVJsVFM5WkRMeE1NWVBWT3ZvWklPTDdleSt5bFJ2RXh0ZkV3?=
 =?utf-8?B?TEdNM0IxaUhGT1pJTml4cEY0TGJudFg3MnlncHBERy9XemhKbDczaHhPMzlU?=
 =?utf-8?B?aklEbU5pKzIwNDV3OWIyaE5vYVoxTzRyRlVZdHRROHoyeE91dHdLVDZvNHcx?=
 =?utf-8?B?ME9ONytYc3krSTFJMlNybjBGZ0c2cEZhZ0tjbzZQdXNBMDBwMy9EK0hhSEVJ?=
 =?utf-8?B?QzlqTUNnalFRVENXTlhGTWsvZnhSdzFBNmg5SEtnVldORVdWT2JZQmRLajND?=
 =?utf-8?B?WUtDRzZxOEJUcVB5ZWM1NE5qVUw2cmQ0MDRJbHZIdXV3Z3Z0RDd0STQvelhU?=
 =?utf-8?B?RURycmxweC9xamY1RVJJcU9FRWtaaVJjVkxqS05aTzdLQU5KdkpVaHJheU8r?=
 =?utf-8?B?WHhjUTRyejRFWjV4bTV4Vjk2UGx0cmFZZUVKVFFpMWovV2lUbGRSNVU4SENu?=
 =?utf-8?B?ZUpvK0dUWUk4M1FTdHhjQm1hNnVrT2l4cGRKazJuaEFpTTNZYVNPQTMvOWYy?=
 =?utf-8?B?UWlrTWJsMG0remhxUFBPdnFXdFNFbGVFeHA5U1JHRTR3eUxCQmZjZDdkdGY2?=
 =?utf-8?Q?IGxe6ws4bQ7DJpRgq+8AUMPsk?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbccca9-d0c6-46fa-1c00-08dbdaf57f7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 16:13:34.4903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4/iwrXITWaaeHuf3CvRXHG+Ov2Wg2Qnxvd6YQq3vHkWxic7K8hknQQRp5u7xkuExnCdbiZqHAp7Sgz0RznZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7804
Received-SPF: pass client-ip=40.107.20.112; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 11/1/23 16:23, Andrey Drobyshev wrote:
> Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
> KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
> extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
> exit.  That's a natural thing to do since in this case guest is no
> longer operational anyway.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Acked-by: Denis V. Lunev <den@virtuozzo.com>
> ---
>   accel/kvm/kvm-all.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..d74b3f0b0e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
>       } while (sigismember(&chkset, SIG_IPI));
>   }
>   
> +static void kvm_emit_guest_crash(CPUState *cpu)
> +{
> +    kvm_cpu_synchronize_state(cpu);
> +    qemu_mutex_lock_iothread();
> +    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> +    qemu_mutex_unlock_iothread();
> +}
> +
>   int kvm_cpu_exec(CPUState *cpu)
>   {
>       struct kvm_run *run = cpu->kvm_run;
> @@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
>                   ret = EXCP_INTERRUPT;
>                   break;
>               case KVM_SYSTEM_EVENT_CRASH:
> -                kvm_cpu_synchronize_state(cpu);
> -                qemu_mutex_lock_iothread();
> -                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> -                qemu_mutex_unlock_iothread();
> +                kvm_emit_guest_crash(cpu);
>                   ret = 0;
>                   break;
>               default:
>                   DPRINTF("kvm_arch_handle_exit\n");
>                   ret = kvm_arch_handle_exit(cpu, run);
> +                if (ret < 0) {
> +                    kvm_emit_guest_crash(cpu);
> +                }
>                   break;
>               }
>               break;
>           default:
>               DPRINTF("kvm_arch_handle_exit\n");
>               ret = kvm_arch_handle_exit(cpu, run);
> +            if (ret < 0) {
> +                kvm_emit_guest_crash(cpu);
> +            }
>               break;
>           }
>       } while (ret == 0);
This allows to gracefully handle this problem in production
and reset the guest using on_crash action in libvirt.

