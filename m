Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3282AF51
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuuF-00076D-GZ; Thu, 11 Jan 2024 08:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNutr-00074t-3C
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:15:11 -0500
Received: from mail-he1eur01on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::72e]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNutn-00020Q-Vt
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:15:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQamqVn5pQsgq2rcUyDQ3QVPoHO3UD4K9CBi5ETsrNc/g9PL82EYAiNo+jrgNYyKJ8hhJwebEfH8uQMFDJV1Fd2zZkFgsWiEaM1G5g6gtRDcasD/bqBKFw/QMJQn3sMyi2tzOvqSDoYi35Dc87l2Cm3qKL8pOw+AHUx1Usutkm9DMs6+Eind7rI3DVZKhTj+a1YZKW1nbDufZ/ScrQ9AJUAuUmhuC8JYpg5RxEuHWbQdRKRh7LpiHhrVEJ8LYQ2gF70tDL/Y6iETE23wbZ5HvfaEGanqVZiLsyR3Mk6xAecCKTlH1iRhFsxt2uYtsHwdlxT91kD99pBnVlPepIRanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZxXvx8f6tVripAvG0ofkc/Gwfm2z6G3MOTdsPs3Jh4=;
 b=I8cTo/EHTXvmlnjmjbBWZ2wXWMxHzsUCmcy8Uby4dwNBAJM77vkRd00/A09S7cWTuiDOg6vjF4oNdsqzuMXayCfRtDLQeZIZdCkZ7Y0guN9DNmBdsH1Mq9yMnKtL1zc6ftew1qBcmtmZVzL07a2Din/DND0RbFhDavSAmE4mcfkneIzS4vp1E5PKraQM9AKmQ/OxpsAEVUeqvSHNnlIotoH20wcspy+0BMvd+AQ1HnNP34FU0qt5aOYpUJa0ZGnMus2R8ct5d5RlyASawKmuGt0fFxabuw4Bsl1mf2MMFWEIvVA2dQpb7e+U5t3arnQ5apyBxsta4CcleBUiexEhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZxXvx8f6tVripAvG0ofkc/Gwfm2z6G3MOTdsPs3Jh4=;
 b=yozSpOg6K3PXaeTsrdf07cxTy014b1X/B+iN86E1E86nRL5ERKw7LEWxP0XBUbdxB+zAizBIiXT+pSe8zGWDC/2kTWwjeHnM8d1YMsbZ3DFZFTYcnXO8yfTQZ5OLs5wU3sgl5dOrzw9ehJtyq+ORPWJy1tS/eVFO42fq9D3SXmZ2ko36I6gRk0RhFCyysaqDhjGK/vfRSfyDRDX/CcLMacMBgvA//z2XweqHsnWpcqPj7XBhlOdquHvdnV9u3nD1iQPCC2jYDDqQkuVwaEz2/AlqMGcVSDRf+OarJNnBbRf3auW3fdnYY9Vs60Nf/uN6PufTtjOk1AR81lEARCJFOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5943.eurprd08.prod.outlook.com
 (2603:10a6:20b:23e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 13:15:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 13:15:03 +0000
Message-ID: <de8eed0a-468d-4433-ab45-4ef2c666e6b6@virtuozzo.com>
Date: Thu, 11 Jan 2024 15:15:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM
 exit
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
References: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
 <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace0cf3-394b-41cb-d172-08dc12a75245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQfpT6S0ASe84cr14anpPrb0Wyq52ufilQv++IwPrUGVHAR+li+xqq2o2+w1BeeR6PQngwN6A1orjt8ioP35ipvr8/aNBqHh7ZA8nM+c9Bvnw4xXylguwWze9DISCwd5u1o4eeROyFKlZRJbFsUkzEfSj8rO6CH7E+6EnVf3bR0RPnrMXZygZjK1z1A5RrjmtD0aWLr4By3e4iSffJ2IjTcZnTOiH2x2EcumDPhxhgBvjCpis8Nddoj0Aa2RQrmcB+qYvw7FmOsIlxvzStyazj2hsJ5rgGg6GPB0+o700h3UM7FeUwkKdA/vJsHO5OGcRxNjZWcufAfUa83pKJnFsmL6lsqCGJHLR+nHlBZsPYf8gLwQblxtPEeqEbZpCVzqEBBm2HIuIK6yNwPzbcv7ti1jWh+nUS/ADS5a6NhtC58Km7UjWEZ155iiWnPvOPCHbPBYYVallkR+laRXE0IYf60BdD6Py7XwAzl+n3WwMG340trwQVJttCfdLNUHYgKf34JtjYUmf0zUmPr0k9GM5RtWvzgDqBZ5ZR7x7XM3FO9KKr0hjitHv0j517gYvPMUiDmhw0YXsb8EdsQMeCXKfitkXIbYzuMx/vFTnuJ0UPotLDHBtNJpQDE0wIjHEyLtv4XmKAzrSqYuYrsb7ZxRJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(53546011)(2616005)(107886003)(26005)(6506007)(6512007)(55236004)(83380400001)(41300700001)(86362001)(4326008)(316002)(8676002)(8936002)(5660300002)(2906002)(44832011)(36756003)(66946007)(66476007)(6486002)(66556008)(478600001)(31696002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytRN0FwVzdTQ21BZk9FNXFCNTBwY0N1R1ZVVi84QlZRU1NTUlhzeHE3MTdo?=
 =?utf-8?B?Sk9zbTd6RUw3UDA1SFVhSnYvQnFKMm1LNmZNTzErV0dJQjMwT1Q0OHMyelpK?=
 =?utf-8?B?czl0N0swWjZTeUZ4MnMvcXJNanpSY1ZJa2ltc2N0MkJYTThNTk5oNCtuN1dT?=
 =?utf-8?B?UzZrd05oVnF1TmtwUlM0OVZFZmJLckF6bW9Vb0FtL3gzcnZMU0traGtGZ0pX?=
 =?utf-8?B?NjVoR0NXS1VjQWlaQUJNVlZvSitjNGFLWXZWeEhyMFNoSWNuWXBiUmZkejlL?=
 =?utf-8?B?Y21VTElKZytpVUxYTjJGdzNpMGljTFA5MWJmTWtXcGtaVk5BZURPeFVlcVQ3?=
 =?utf-8?B?alZ1U3J2b2VscTl2QUtqczR4bEZybEowOUhCV0FQRW1mZGJMU3lMd09kM3U4?=
 =?utf-8?B?WDJ1ZlE0TUFFNHh4RnRjUlVwc1JnQWk1OEMzSEJMbG12MXEvelAvdnJnYzQ4?=
 =?utf-8?B?WllzL0ExcDk0WmVlMVVydlpFUFI4aGg4NjNNR1NZSkwzMU00RnY0bFcxV2da?=
 =?utf-8?B?dzZXL2xhK2RuU05sVlBuSzZjMjErQzVTRFM4SEpnaFVqZGV5V0pUT3l6T0x1?=
 =?utf-8?B?UGJqVTZYc1F0S2Znd3prOUlWb2RRNkptalhCY2toVEMwQzBMV0w1c2lMcnYr?=
 =?utf-8?B?dVczTVNWcFMrbEdLT1JXMVZzbDZRWnpyaGRXMnJyTjF0TEZqTDVVZUtkQWlo?=
 =?utf-8?B?cE5Dc2JyWTM4K0JlQVp6ZUZwRWUveTM1Y09YV2oyYi9kM1JnT1gwMkVIYS9p?=
 =?utf-8?B?UUxzb3pZR29XTzhySCtYY0RyODB4Z0lSWkZmdkFnUHZUYk9JTk9yNkhxcTA5?=
 =?utf-8?B?ZFBBUEdjVlJiUVpzcWgwTXEwNm9wRE85UUkrRkN1VU5WOWJhR21qMVJyWGow?=
 =?utf-8?B?OTFmQ0VGVkFBWDJBTVR5TEoxTm5wVUw1V210NGF6SG1BSFhHMjhZeUtmaXpM?=
 =?utf-8?B?QWt4dzRJb0xrMTVScTRic3BwcnVnZnV4bm1jYkxmbytlZExaL2QxSmtHeFpN?=
 =?utf-8?B?YlVxN2JKd0FORmtkQWJXOGFXZFUrbDRMT2hDdTJvbVNwVCt6ZnI5QjVocjAr?=
 =?utf-8?B?QkJjaytGaHowTUJ4R1EybkRmaXFPY0E3WWNKV0x2WkptZmlrTEdBNkJWM3RV?=
 =?utf-8?B?V2tnQ1FJRE1lWGxaNHJ1cGswMkozT3RzL0E4U3QrVkVKNXlFMEJhWWNSVVZP?=
 =?utf-8?B?ZFBUanFGamxtaEVOK2J6SWd0WGQyWFFtamFlSHphdmV5aGhBUUQyeUtpaGR5?=
 =?utf-8?B?Sks0V2tna2Z1cWtDNlhmTU1mK3VEa2ZjSHplcTJYVTNmVVlNbDJFeVpvK1ZT?=
 =?utf-8?B?SmlkNVU2eE1EOGRjeFhlU2Z3aW1DNXFUMHl1K25MSEx6WWE0WWtFT29wT1gw?=
 =?utf-8?B?MkN5Z0JDK1dJeUtMckZCUUpSZEt5c293WGpyV1ZLaGUzdzcrZ29YL1dFdFBN?=
 =?utf-8?B?UXp4aTVEMEZUeElCaE11aXVPRU9YZU11MkRlUy9iQ1JtNkhUTEVDM1RNclBp?=
 =?utf-8?B?MGczQXhlcUZ0UFBxWXFDVWxmcTloSmVncDNwNXU0NEVnS3ZvbmFiMElmcHBO?=
 =?utf-8?B?dTRTUzFXRnNXS0xDRTBma1hMeWJ4T0Jpb28vZDhmbk9pM3UwbVpqdnBzbkJS?=
 =?utf-8?B?TzBnMmlSUHlsK05iS2RQdFZiY0F1TkYzNTFIRXNoZzlZVkZtalBFOXdvelNL?=
 =?utf-8?B?V3NENW1tc0VOOFBaZENRdW41eW5zQk1OUExXRWxtc3d0dlZxdmZjcUZtY3Qr?=
 =?utf-8?B?cHdSR3hZd2JheGlpZXUwNTNGNXYvWUh2Z3hOSjRUenBnU2tDN0JlYUliWWdW?=
 =?utf-8?B?S2lCRk03YVBCeVBlUkJtd1hFbm5MWXkzRWR4LzYwSFNWWVZaSkFhOCtHOVlW?=
 =?utf-8?B?emdIcFphb2k4dmNsR2ZPMlNlRWQzSnZXZ2hSR1JpaE5pTTA2VjMwTWVaRGd2?=
 =?utf-8?B?Q0N0S0JpQ1d5blJGdGJsbWVDVFNlVmNiVDB2TDkrbWJxaEpJbkJWb2NVTVp6?=
 =?utf-8?B?VjZhKzlIL3ltQnF5US8yUnRRdHRhMHVjZ09UVzJhdzhMb3VBeUlTUHZyN3pt?=
 =?utf-8?B?M3NmRUNaMjdoUU9Ic1dKaXJodEI2Y3lFN0VhL3RyWHJIWEV5Y0JNUE9XSDJJ?=
 =?utf-8?B?RE1hZVZzOWxqbjNmaU1JeWNCQ0l2TldwWk9SVzY0WjlWRURJcHkzb2I5b3R1?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace0cf3-394b-41cb-d172-08dc12a75245
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:15:03.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GZd4z6+hmiDGLmpYHQkaajja0cQQ9nygAQdLp+I6vFX8B08iN82XJ0b8/RenubSCQgyceHsD1k38vPr0As7+JtrBKbmLUJ6YuJ3SkHhQP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5943
Received-SPF: pass client-ip=2a01:111:f400:fe1e::72e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


