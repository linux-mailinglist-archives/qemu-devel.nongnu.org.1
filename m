Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D476D1E0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDjo-0002A3-HI; Wed, 02 Aug 2023 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRDjn-00029s-BQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:26:11 -0400
Received: from mail-sn1nam02on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::61f]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRDjk-0003Sx-Ju
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSooxXtZoZNI9ATGehD2FyfAxL51Ay7mzAkmZuLPLH8jcwqRCdwbkmtA2P9CsjxtnZUYaLGkZmXpziPoCcVXQlUAftO8UIFG19D9v4v2UrlUzGLD6DKcSRt1KPins0XfJPoAM19mt4fLhOhINgl7Ol0Ss/K3uxsPewEOZUas6LEdHAPeICrS8K4bdPD9wKnJwN+X3L8quPUpKnIC0aoYCwEWNK9aiq2iOu138FhM1N5isiin6IhLai6nvjCh22Ka1yh/mDGg/fFkFXeBBYxUr+/S8g2gszpgdjy1aPfYcYqdimE1c5YlZcUtwzhHQqNyIkloZgzabliTI/Z67dAxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlRsy4zZ5hvOYm4ErnNxrIGOj3H8UEg+XYOm3J3cw3g=;
 b=VXN2AdRuMpCjYcQpEV2K6ibX/iUXZ69dnc2EyDWKKSLB6gsJjs4EUGnIBkEgOQPL8awQiXFuJPXmiqrQ0xIida9KRz+lkvhilCPSCkMz0khDxIe7nV3mXY38dZgtDswAYDEmcV7yeYKwVj9oa0r8+fqakTNK8axJJKPXhxNkzVo9wAx1YIvEnGgrWVtLOVHT+OOcfXTQM3tfWH3v80w+rEV/hrPJWzvAcVvnJl37X0sr83taOO6POG1T4WhkyNglYlZCu1KbKWnCepkxaeHch52ZDlF+tTJ/FSsujY8VE+cdu7SWSpyJBKaF5FENG203QEQTvkYI3ea9LEkUubmGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlRsy4zZ5hvOYm4ErnNxrIGOj3H8UEg+XYOm3J3cw3g=;
 b=hgRdnJZQwvfCaSwghWOXL811woAf3fyuGzM69qgYp3LcyShmj4MDXO8QDXNWmT0i7E/37zdWZS8d5CV4nyXW13Au++Kr54XlWoL5M4bDZeO8xB+mUvjCyeJH9B/Mc4We84j7pi73AHHMwuDnUV7j+ppduOpQDuoP7mGQ9BhwrnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 15:26:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:26:01 +0000
Message-ID: <275a4850-2d70-4a6e-a72e-5c3fd20f98ba@amd.com>
Date: Wed, 2 Aug 2023 10:25:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 40465ac6-f89b-4055-25a5-08db936cc749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqdldmc8muOkWdi5vI+MXhiMWtj4ufR4aLERH4wssxcTx1GY7/QlXz/vVoCVzz4/Z2HKq/jVumcbeavPSThSpK2xvmkyUNKcjIV4Bbk5EIt5/Bacw4qsXgGBaJ1geZfnp+pE4dXFYFYh4naOqXMVgR1nye8oWnyYf4G306B3/dV/dKBVAIED/aYb91TEgi9eYm2Mqy/WHvyTLS9HmFcUghYxuyW301/0JeRh864BaMkSKp0CY7p37Tp2DnEsQCbBFUsns8MiNNsL+DCRCsfE1ae0zCNrKdqakgyoseGB+swr/GaMY+WwG7foFjGe72StASbPSXElzG40Y8dNnRJPEDBQvMowA3JPFrv+yJMXyQRhJeWg1SNBUB5VZ9YuPPQMZe74r5eoGbYNGjKBVBOhHjnve6yF5FkwVAsCxQtPslNs4gLsk6Yhe4Fx8XImJjY7bC3JWXkihB54kewJYE6Iq0AERlhLeMgmTlzGIGcyRRQmUsMHWqv6nNFM0didxqNDqDL6o0D4OC6vcQxOXtQVaBegelv1lZq4brMA3VhJJrzpMvIE+wftDKmI+6/Wizn1WUamkorPADHX6LL9N40kjOGfHZwL/fBWmgo0nuC6oEadp/Vkd9CKkHJdl7M4lxOOpqF9OqtPLF93UuUE0y//aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(31686004)(31696002)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(2616005)(186003)(83380400001)(6506007)(26005)(53546011)(41300700001)(8676002)(8936002)(7416002)(6512007)(6666004)(6486002)(316002)(3450700001)(4326008)(66476007)(5660300002)(66946007)(2906002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmhoOFBLMmRvOVIwZE85RTUzcUJkbEVydThraDlIanZwZWd3NFlNTm9DR2pi?=
 =?utf-8?B?d0tXbEsxUVk1N2hPWXlFR2RYd0xaZ1k5L0t5Z1Y5cjlsVGtQcTk5bFJTQVVq?=
 =?utf-8?B?d2h1R0lkVnJxeU0wT3U4a2V6VWZrbWVtZVVoVDdZWUJNQW5tSGxWYW1tSGVi?=
 =?utf-8?B?YXRuQzgwNU80bmx0WFZPVDJON0dCYXNKZTF0SVNSdUFnQzQ1dGRKcEoyWk1n?=
 =?utf-8?B?RW14N0xVMmFlVzlGYWlmS0wxUWYzUnBvbHVEOG5RNFpNVHFvSWtJNHRPVjI1?=
 =?utf-8?B?N3ZJKzZwK0IvOGtMNnI3NW9UREk5bUQ0SGxsM0RDbjZRaGJobWNWVXVrUVpp?=
 =?utf-8?B?NkxmazlqV2ZPS0hDc1M1TVAwRWd4eXd4Q2lPbktmdzFPUEhiWk40N3gwaGNw?=
 =?utf-8?B?VGtSNlN6VW1vQlplTnNHd2pnSzhqM3dDa0ExN08wTTJ1QWZ0T2drazdyVG56?=
 =?utf-8?B?VjgraFdQNVQ0R0xybkJtZ3hLS2E4bFVtUy9JcVREeHlBNHRPV0d1YTk1ZENS?=
 =?utf-8?B?TmZXZUtoTnhZeFByY210eEJua3Z3MEcrS2RiZDZ5c3dhdzhIcjA5aTYrL1B1?=
 =?utf-8?B?Y1ZnaFZDeHpkVEwzKzJTekdiRFpGUnVJUjlwR204bDdaVXNuUmd2YVh5TzJX?=
 =?utf-8?B?bzF1Z2MzY3ZBVTM2ZVZPdVVwV2xIa2R3ZDArdW1kSCs3Rzh0TGdKbDZYUm1t?=
 =?utf-8?B?UGdmQ0hYZXlwYmNOYkdxeVdIc1lNWmdseFpraUNQK3BNYzdJSkdSZ3RlcHIr?=
 =?utf-8?B?enQ1ZW1EMFNkU29kZTdPeWlsaGVVbFlRVG1pVUlJMjg3Z2N0cUFkOTliMGN0?=
 =?utf-8?B?M2RoQlJCTmZUTzRoTERvQytjV0h4M1g2aHMrclc1ZHpLNXM1bE5qM0FWNXM2?=
 =?utf-8?B?M20wZjRNN0Z5S3RXWWJlcDlJdXdCckFERm1CYmRDRmF0V24xOWhZZSt0R0Jy?=
 =?utf-8?B?clZ4b0dDTG5wOXZrUC9XaW1WdWdTeWxOMDZ3NlYvQlUrcFAxby9OT0FvT3U4?=
 =?utf-8?B?VXRGeHp2dnNZWW5aK21iNGxUMkRwL2JQLytmL1JNT2NPQWtrZC9ZeDlUOUZV?=
 =?utf-8?B?ejJHMTdCbmVab3hXOUpTNHhwVmFSVFQvajBmTjBmZjRwSW5TN1FXcDZPMnZH?=
 =?utf-8?B?dFFTS2xObW85YjQwMXhRZFJMQ1hmem55NzNSdFlwK1JpMC96ZitUa3lld09o?=
 =?utf-8?B?NDRhRnl3L1c1b3NvaDlGTzFZSlpsMjZrekprMHVhM1ViU21PNlJ2OUFiU1VV?=
 =?utf-8?B?SS9iaEc1Z2IrVURoVzRseFhZYUhKSkdrK3M5WUk1UG5lU3U1RVkzZHRwUmdQ?=
 =?utf-8?B?QUVqR1VabXB6Y0w3aGhqL3FvYUVzVFhiT1ltK21QTVVsREVYLzlKTERHQVhq?=
 =?utf-8?B?ZlVmSUp0K01Xb3VIcVoza1JRclV5QkVpcDdmZGFDWUpobkdaQ3dlSTh0UWZm?=
 =?utf-8?B?Q0o4WGExZ3p1aXJlTldOOW9iT001VjJrZTZ0S3N4V1VCcDhic3UvQzdER3dK?=
 =?utf-8?B?RXJCdGtkRUtSSHYvYy9FRU1LS2dKbjFMN3Erc3ViWi9wU2V2YTJjc09mTWZh?=
 =?utf-8?B?S2VTR0VjUlRodDIxdmhNY0s0ZE0zNzlnc0U5VGQyQVR3bFp0TVRSZ0xMMzdQ?=
 =?utf-8?B?UDJDSWl1c0hSWTlRSTRDNFhhVWxYK2I2MEdKVUlVVEVvSklUUVFheklBTnN3?=
 =?utf-8?B?eTFtUzJBTGlFVVdBSXhwdXpaMUh2OFVIUkFFNFlrd0NROHN3ZGpHRjQrdmtu?=
 =?utf-8?B?bmI5aW43WmdDU29NaVVBUlk4N1YyVUZJTUQrb2hOM2Q0cHFWRnBhVXpZbW5y?=
 =?utf-8?B?VU81SkJTME9DNFZqWDFndWJVTEErTndhNzE5aCtYZUZNejV2azAvNXdtNjgv?=
 =?utf-8?B?eU95N2RqbnZTU2xCTXU3Z2dHUUZPTFJ2a1VPYWNIK3p6OVdka21kYmo3Sysx?=
 =?utf-8?B?Ynd1RDFwYk9OWWFvSmErNGpzaHZ3K3hjbWxmekpXT1pVZXdFTDkxSFdSNGh1?=
 =?utf-8?B?MVlIVDRXN3pVNkdHZlRjei9QZEo1dVpqeTZIUmVEbDVQR1h2aC9GaWVldXlI?=
 =?utf-8?B?bGtpL1V2dFU5cDFQM1pCWFFQNmtLNVlta0NjSG9CK3BsK1NYeVo5NWpuS2kv?=
 =?utf-8?Q?0xpU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40465ac6-f89b-4055-25a5-08db936cc749
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:26:01.6166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5VZmafwQjFIbDRGKK/AfVx2Dw4GtjpgI7l1x4nuZfS7eHnrmy4wBjgNxl7xbcao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::61f;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
> From CPUState.nr_cores' comment, it represents "number of cores within
> this CPU package".
> 
> After 003f230e37d7 ("machine: Tweak the order of topology members in
> struct CpuTopology"), the meaning of smp.cores changed to "the number of
> cores in one die", but this commit missed to change CPUState.nr_cores'
> caculation, so that CPUState.nr_cores became wrong and now it
> misses to consider numbers of clusters and dies.
> 
> At present, only i386 is using CPUState.nr_cores.
> 
> But as for i386, which supports die level, the uses of CPUState.nr_cores
> are very confusing:
> 
> Early uses are based on the meaning of "cores per package" (before die
> is introduced into i386), and later uses are based on "cores per die"
> (after die's introduction).
> 
> This difference is due to that commit a94e1428991f ("target/i386: Add
> CPUID.1F generation support for multi-dies PCMachine") misunderstood
> that CPUState.nr_cores means "cores per die" when caculated
> CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
> wrong understanding.
> 
> With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
> the result of CPUState.nr_cores is "cores per die", thus the original
> uses of CPUState.cores based on the meaning of "cores per package" are
> wrong when mutiple dies exist:
> 1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
>    incorrect because it expects "cpus per package" but now the
>    result is "cpus per die".
> 2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
>    EAX[bits 31:26] is incorrect because they expect "cpus per package"
>    but now the result is "cpus per die". The error not only impacts the
>    EAX caculation in cache_info_passthrough case, but also impacts other
>    cases of setting cache topology for Intel CPU according to cpu
>    topology (specifically, the incoming parameter "num_cores" expects
>    "cores per package" in encode_cache_cpuid4()).
> 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
>    15:00] is incorrect because the EBX of 0BH.01H (core level) expects
>    "cpus per package", which may be different with 1FH.01H (The reason
>    is 1FH can support more levels. For QEMU, 1FH also supports die,
>    1FH.01H:EBX[bits 15:00] expects "cpus per die").
> 4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
>    caculated, here "cpus per package" is expected to be checked, but in
>    fact, now it checks "cpus per die". Though "cpus per die" also works
>    for this code logic, this isn't consistent with AMD's APM.
> 5. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.80000008H:ECX expects
>    "cpus per package" but it obtains "cpus per die".
> 6. In simulate_rdmsr() of target/i386/hvf/x86_emu.c, in
>    kvm_rdmsr_core_thread_count() of target/i386/kvm/kvm.c, and in
>    helper_rdmsr() of target/i386/tcg/sysemu/misc_helper.c,
>    MSR_CORE_THREAD_COUNT expects "cpus per package" and "cores per
>    package", but in these functions, it obtains "cpus per die" and
>    "cores per die".
> 
> On the other hand, these uses are correct now (they are added in/after
> a94e1428991f):
> 1. In cpu_x86_cpuid() of target/i386/cpu.c, topo_info.cores_per_die
>    meets the actual meaning of CPUState.nr_cores ("cores per die").
> 2. In cpu_x86_cpuid() of target/i386/cpu.c, vcpus_per_socket (in CPUID.
>    04H's caculation) considers number of dies, so it's correct.
> 3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
>    15:00] needs "cpus per die" and it gets the correct result, and
>    CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".
> 
> When CPUState.nr_cores is correctly changed to "cores per package" again
> , the above errors will be fixed without extra work, but the "currently"
> correct cases will go wrong and need special handling to pass correct
> "cpus/cores per die" they want.
> 
> Thus in this patch, we fix CPUState.nr_cores' caculation to fit the

s/Thus in this patch, we fix CPUState.nr_cores' caculation/Fix
CPUState.nr_cores' calculation/


Describe your changes in imperative mood also spell check.
Thanks
Babu


> original meaning "cores per package", as well as changing calculation of
> topo_info.cores_per_die, vcpus_per_socket and CPUID.1FH.
> 
> In addition, in the nr_threads' comment, specify it represents the
> number of threads in the "core" to avoid confusion, and also add comment
> for nr_dies in CPUX86State.
> 
> Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
> Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v2:
>  * Use wrapped helper to get cores per socket in qemu_init_vcpu().
> Changes since v1:
>  * Add comment for nr_dies in CPUX86State. (Yanan)
> ---
>  include/hw/core/cpu.h | 2 +-
>  softmmu/cpus.c        | 2 +-
>  target/i386/cpu.c     | 9 ++++-----
>  target/i386/cpu.h     | 1 +
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe8735258..57f4d50ace72 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -277,7 +277,7 @@ struct qemu_work_item;
>   *   See TranslationBlock::TCG CF_CLUSTER_MASK.
>   * @tcg_cflags: Pre-computed cflags for this cpu.
>   * @nr_cores: Number of cores within this CPU package.
> - * @nr_threads: Number of threads within this CPU.
> + * @nr_threads: Number of threads within this CPU core.
>   * @running: #true if CPU is currently running (lockless).
>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>   * valid under cpu_list_lock.
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index fed20ffb5dd2..984558d7b245 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -630,7 +630,7 @@ void qemu_init_vcpu(CPUState *cpu)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>  
> -    cpu->nr_cores = ms->smp.cores;
> +    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
>      cpu->nr_threads =  ms->smp.threads;
>      cpu->stopped = true;
>      cpu->random_seed = qemu_guest_random_seed_thread_part1();
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8ba3..50613cd04612 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      X86CPUTopoInfo topo_info;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
> -    topo_info.cores_per_die = cs->nr_cores;
> +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
>      topo_info.threads_per_core = cs->nr_threads;
>  
>      /* Calculate & apply limits for different index ranges */
> @@ -6087,8 +6087,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               */
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> -                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
> -                                       cs->nr_threads;
> +                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                  if (cs->nr_cores > 1) {
>                      *eax &= ~0xFC000000;
>                      *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> @@ -6266,12 +6265,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          case 1:
>              *eax = apicid_die_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          case 2:
>              *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
> +            *ebx = cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>              break;
>          default:
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a10433b..7638128d59cc 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1878,6 +1878,7 @@ typedef struct CPUArchState {
>  
>      TPRAccess tpr_access_type;
>  
> +    /* Number of dies within this CPU package. */
>      unsigned nr_dies;
>  } CPUX86State;
>  

-- 
Thanks
Babu Moger

