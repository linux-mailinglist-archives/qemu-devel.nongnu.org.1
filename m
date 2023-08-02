Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39276D3B9
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRElV-0008Ug-O1; Wed, 02 Aug 2023 12:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRElT-0008UQ-7Q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:31:59 -0400
Received: from mail-bn7nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::612]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRElP-0004qE-Ah
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Toc03T2SVIO8wqXR2kUT5t8alOjpnYP/VjKyH2RADA7tIrnmykNt76JiTcQGu888kVbk1XyUJk1/VGLUNTp/ct++2JQJUVz26fPq0ri5Av4omr8q0Qr+hPerd6Vcvn872HsdUGuTUQVa3G8NmedpvXy2lKo3Ncb7+olAoYEQzYmG/Ky4qoclKnusLFVVNa/Sx099juwa+H+yAgaIh9YD5jJKceTJR1EzzSm0zsjhPBJ7f1l0Fgo2N+XyVr5PyYm3dZ7HJydiuRSiOeJcAUeqAtxUwFSpf0OdFxiQYpLopyHZeo23kD74XbrLtIt6Wj7YR7XbbgpoxYP84jMASI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCFnKhcAW3jj147FDRIOKMtwMebQFBNziLgEHY1TNfw=;
 b=MIN4MaN4Y3yoFh5temwerT35XfFeod89z8EIHgysMSI/3nvyJciU+9vkLFiyypqi3y4MR8DzfL1QwwLT0UuPYtQ25BfGnu/ro5r+0BIbKdXkCQ0oOINJw6kSGCeSDoRmTfKsO38dPiAmeSm3XzQxWJwHy2cO/FpAqlkBdmRDacGvt9CIRaDKDe+9oYUHN3oOK9lZX3hLgGUs6hNRKRNkKxtGrNXRBitP0j+J5ZM9eWdZVBDbVdyXSJUMp2iBE40hDZ0OYGU9lSyIvVCNKgG4lJWB05okRRDR1Ytu9CBMUkHPNAAxinCwdjCU6ZcM+6a3g3R40wFRXejjHxRjnV53VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCFnKhcAW3jj147FDRIOKMtwMebQFBNziLgEHY1TNfw=;
 b=otkvRPBZNwTSRuCHY474jEZ1gGrVCuKfQ4eCtmRyuwchoNt30s12gOdp0p3y7I8PH7/bu80bsziHPXmXzlNnO1xbJUt6p5IWiRXB/o6xA3q6jN+GLUure4N6v0eH2YWEA6AxclKoR9vi+e17bMPoMpTNSEX1hAy41pYJcVIbNY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 16:31:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:31:50 +0000
Message-ID: <c0307538-e1cc-f675-8c5e-1973f40fdaaa@amd.com>
Date: Wed, 2 Aug 2023 11:31:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/17] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-7-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-7-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa3aeaa-7554-4185-e4db-08db9375f8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mg9fDFEkF5LelooeJwj2q3OzGZBpmx6r6r7GanHesFQviL5BJHFcK9qwCS0yhCHQ8xS5O/936yTlrLmWTwuV8UO92XVB0mK0yyTj+mL+0hkHZGGwpJmtQymaRGNdEiO/gpqrx1uC71IsfOIGs4Cgvhs0oBav+fQconTXYpgzt7/ro+ae0VxHdvTLGR1fipIUZgHSlgS/OP6AVy39b+rtKQ/Ha9sq27SvZpyODXuHqAZ/OYN+iY7o7NaqobJzWGRwXTvb98tLO3/gSZ9rnvTISsKkvBk3AZMaFGNmPQXYrMgC4/YI18U9bVKxjw9fXZCl6MiE6iPF6azeRJ/t15DzNB05jH99bVwtV3yfRMgkcirXR4S4fQZ8LuK8paYB5fNqF4g7dtBOspei074fJRvZuzoryAUvO00bJjHtoZ2jTE56JbxOsGKWNBgtGc+V4ysV7XnSYNrdcpxEXFIgfNIQtZLPW788qJxNFWCkhclMINXcVNa7300uzNMTjCuUvg3ahH9dEpvA5pkAil/jHXnzU78+Y2Q60qTkm5O5GrCeWhQgYBiJNG/Ta9NvsyDxbRtcY1EOo7qUQrZ5lKHxaJX5MBQEuGL1zBZ+0NcMJLSXYOtlTui/kHlYTy9NKlUR56wqpT9CInXHKjKUJS6zmzsq2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(31686004)(31696002)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(2616005)(6506007)(83380400001)(186003)(26005)(53546011)(41300700001)(8676002)(8936002)(7416002)(6512007)(6666004)(6486002)(316002)(3450700001)(66476007)(4326008)(5660300002)(66946007)(66556008)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm0yYm1lc09pb2YvdFZFc0xOZXpmNnQrcEJXRG1Ld0xldW81S2g1MStJWlpH?=
 =?utf-8?B?UWNReERSclZOd0t0WE1reEpZNktoblhRWTQyQWZ2cGNIYVZmUHpOeDQxK04y?=
 =?utf-8?B?R09rcWd2TFFsd2RpYzFFakdGWEVUTmdNSC8rWnl5VWlOeUtyM0pzdmJsZUpP?=
 =?utf-8?B?NCsxdWxWUUZjb3pUMldqTWRrbnFmNmc0STYyVGZNbHFuWnBzY0pnZmJJZy9U?=
 =?utf-8?B?RkNvYWhlTWpYbjVPOVRSTFYraDhlZDkxY213d3NYbmRaZ2VMaXpMMUZzenhk?=
 =?utf-8?B?OWNKU2Vac1NYWWtpNE94dHBQc3FIc0E4QjRSUGdRUU0veE1yd0dGajd0Z1Za?=
 =?utf-8?B?R3JvK1V2dXhqaG9pR1AwVzdRSEd4S1lZR09Wdk9PUTB2T3g3UU1OQVBIY2ov?=
 =?utf-8?B?aEhvMFNvVlB4WTVDMW9ObDkvRHFQUVk0Zlh4UW14QjVONHVZc0Z5S2ZtTTZo?=
 =?utf-8?B?Zko2V3RwYXhOdDFzVTFRSFpYTEEyT29CUlY3U2dhL09HOFBubjkyVGdCT21C?=
 =?utf-8?B?VTloZXp2Y2k1WmVFZUR1NTQ4Vm12eGVQaFdFZ1dIK0JubDJEenQzWkhDTklw?=
 =?utf-8?B?ZkNTZFVBWjFldUh2aWREMkVJRjM5MHl5MHliV1VUMkRlNXFPZ1AwZ3RvUUJJ?=
 =?utf-8?B?Si9WTmRkSkEvb015Slo4bi8vMGpXN3BFd1NDMHNxQkUvZTJINzRHSk9Ha2RI?=
 =?utf-8?B?dEsvcGNKWHZsWWZEdWlKaENTS09ORlhlbk1SOU9RWVVkRWRhRTRhSFhNYXhj?=
 =?utf-8?B?QldHY1lYZG5QL2E2OGxydHQrdHJhSXBQNElXaDdiangzMEpXM3JMeUx6ZmFs?=
 =?utf-8?B?bUV2bU44SkRHQ202UHFCRmJFYWJrN0RBSEtaTWI1cktEbzFzMjBRM0wyZFFt?=
 =?utf-8?B?VHRia1dLdFBMa1BobFdzNG5EM0FnK0xTbnp4Qmg5ZE14dE9nUFlQSmJQbEth?=
 =?utf-8?B?MWZTU2llZjVmcDBWdzNPeDZCTVdnTzhKdzBrK21qNTYxc3VFa0hMT0J1NXhS?=
 =?utf-8?B?MmE3dnZrOXh2MDNWcGxTSHBIbnNQc2NpZmNnc0tIL0FISDQ4cjRERDBzQTFT?=
 =?utf-8?B?QmJwYVRCdHRqYlhYbWJ1ZUJ1Wmh0K2owbEtBTFFSZzU5YWZvSlgxWWthb1Ft?=
 =?utf-8?B?Q2NvNEZGL3BmT3VTcHVzNFJlUG5VTm85YlZ5OFY0VDhLY3ZuSmllZFhmQWFh?=
 =?utf-8?B?cGRReVVnR0RDVzZDV2krR0w0WWx1dDc1YUFhbjdMVVVqaHdYdm92WjVWaE9K?=
 =?utf-8?B?L1YvY2JkWHgzaU9uQ3hBTGRQNzdEbEswcEJlbHYzNFp1NDUwTnAzSDArOTZ5?=
 =?utf-8?B?TkFZZ21POWxuTXFnR0k3SnVob3VMS21jYTY4VHBHdjh2SWNDZWRhZ2lUL2Fr?=
 =?utf-8?B?NllXMGVuMkZnN2I4Uzg1bVEwNXlqYlMvNnlMaVBEUzljRWw0bzFGWTRnNDM0?=
 =?utf-8?B?K1dQbHlMQUJTS0NtUFB6TzB2cmtnNzlmQ2lWR0FDSlFjRjNmRFdXa2tuMHBh?=
 =?utf-8?B?RkpwSHE5UVdTbkpSZWFwRzNWdUQzZGFIZzJTR1Bzem1uaHFSbGVqd1krRTBx?=
 =?utf-8?B?MGYrSFdQV3FTZk5uWEFvL0F3RGpYajBxbVNBQzE0cE9CQ3paN2loS3FCYU9j?=
 =?utf-8?B?eThBa3NxMG1NMjJWeEtrL1R0cmJvMG9Qcmk4eDJRREJEQ1gzVGQyeDVMUnVa?=
 =?utf-8?B?dEFUemV3cng3WCsxejIxSXpEOUh2UHNXT1BCeE9icVpGNmtFTzRGdlVzbnYy?=
 =?utf-8?B?MDRZSXJXNWVuNWZFcThTSHNhLzN1OEZxQlNCT1dreklwWjdxOFhWN1c0Y1Jr?=
 =?utf-8?B?MldjUlRRNnhmTU0xclQxaGFWM2RWR2xRWnprYUJ2RGNhWnRSRFphRHpUY3lp?=
 =?utf-8?B?U253SktDckt0U2tpeCt1ZmxyS2l0VFlyRW5MMitLS255OXdyZ3Y2Mk1ib3o2?=
 =?utf-8?B?Ymx1cnZKczVIUjZtTVF5RDVRSEdidmkyV1BSQks0U1hvMTNpVGs0elhsdnVo?=
 =?utf-8?B?RExEUWdGUk0rK1ZsUzZPSzR1TEl3NmtUaUg4NnFYSzNQSHl5QjNZUW9Ib1Fz?=
 =?utf-8?B?QjFyMU9aNjdOWjZwbHdONVRhY1p5MlpmWjBnZ1Jmd3R5UXFXbFVPeC9YUk9Z?=
 =?utf-8?Q?FBpI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa3aeaa-7554-4185-e4db-08db9375f8dd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:31:50.1920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS4g16MHf3pZpaSjXB6p2CvmczoOrWDSMJdb5x4ltb8Ak/PTG2AczEGcqWn2YzEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::612;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In cpu_x86_cpuid(), there are many variables in representing the cpu
> topology, e.g., topo_info, cs->nr_cores/cs->nr_threads.
> 
> Since the names of cs->nr_cores/cs->nr_threads does not accurately
> represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
> to confusion and mistakes.
> 
> And the structure X86CPUTopoInfo names its memebers clearly, thus the

s/memebers/members/
Thanks
Babu

> variable "topo_info" should be preferred.
> 
> In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
> replace env->dies with topo_info.dies_per_pkg as well.
> 
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Extract cores_per_socket from the code block and use it as a local
>    variable for cpu_x86_cpuid(). (Yanan)
>  * Remove vcpus_per_socket variable and use cpus_per_pkg directly.
>    (Yanan)
>  * Replace env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
> ---
>  target/i386/cpu.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c80613bfcded..fc50bf98c60e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6008,11 +6008,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t limit;
>      uint32_t signature[3];
>      X86CPUTopoInfo topo_info;
> +    uint32_t cores_per_pkg;
> +    uint32_t cpus_per_pkg;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
>      topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
>      topo_info.threads_per_core = cs->nr_threads;
>  
> +    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> +    cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
> +
>      /* Calculate & apply limits for different index ranges */
>      if (index >= 0xC0000000) {
>          limit = env->cpuid_xlevel2;
> @@ -6048,8 +6053,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_EXT_OSXSAVE;
>          }
>          *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        if (cpus_per_pkg > 1) {
> +            *ebx |= cpus_per_pkg << 16;
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {
> @@ -6086,8 +6091,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               */
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> -                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> -                if (cs->nr_cores > 1) {
> +
> +                if (cores_per_pkg > 1) {
>                      int addressable_cores_offset =
>                                                  apicid_pkg_offset(&topo_info) -
>                                                  apicid_core_offset(&topo_info);
> @@ -6095,7 +6100,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                      *eax &= ~0xFC000000;
>                      *eax |= (1 << addressable_cores_offset - 1) << 26;
>                  }
> -                if (host_vcpus_per_cache > vcpus_per_socket) {
> +                if (host_vcpus_per_cache > cpus_per_pkg) {
>                      int pkg_offset = apicid_pkg_offset(&topo_info);
>  
>                      *eax &= ~0x3FFC000;
> @@ -6240,12 +6245,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          switch (count) {
>          case 0:
>              *eax = apicid_core_offset(&topo_info);
> -            *ebx = cs->nr_threads;
> +            *ebx = topo_info.threads_per_core;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>              break;
>          case 1:
>              *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = cpus_per_pkg;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          default:
> @@ -6266,7 +6271,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (env->nr_dies < 2) {
> +        if (topo_info.dies_per_pkg < 2) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -6276,7 +6281,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          switch (count) {
>          case 0:
>              *eax = apicid_core_offset(&topo_info);
> -            *ebx = cs->nr_threads;
> +            *ebx = topo_info.threads_per_core;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>              break;
>          case 1:
> @@ -6286,7 +6291,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          case 2:
>              *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = cs->nr_cores * cs->nr_threads;
> +            *ebx = cpus_per_pkg;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>              break;
>          default:
> @@ -6511,7 +6516,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           * discards multiple thread information if it is set.
>           * So don't set it here for Intel to make Linux guests happy.
>           */
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (cpus_per_pkg > 1) {
>              if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
>                  env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
>                  env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> @@ -6577,7 +6582,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *eax |= (cpu_x86_virtual_addr_width(env) << 8);
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> +        if (cpus_per_pkg > 1) {
>              /*
>               * Bits 15:12 is "The number of bits in the initial
>               * Core::X86::Apic::ApicId[ApicId] value that indicate
> @@ -6585,7 +6590,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               * Bits 7:0 is "The number of threads in the package is NC+1"
>               */
>              *ecx = (apicid_pkg_offset(&topo_info) << 12) |
> -                   ((cs->nr_cores * cs->nr_threads) - 1);
> +                   (cpus_per_pkg - 1);
>          } else {
>              *ecx = 0;
>          }

-- 
Thanks
Babu Moger

