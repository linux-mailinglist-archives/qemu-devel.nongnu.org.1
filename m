Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345AC76EFCB
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbOb-0001us-GK; Thu, 03 Aug 2023 12:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRbOZ-0001ru-U8
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:41:52 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRbOX-0001Hq-GR
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqFc10YM/S1egxIUpT08w2YZ6W+/STO3FuhqCiE08Awz/2ArkPHhkuaYqhpG/eHtFZ7HwtdOPRVBIwkM/FOLJBzLWDNFVohDY6Pj7jJW/9V65uR5si4HJIetwab2vIC6eCwQW0NrLZiaiWXkzK41svIUwG2ZLrsSV6+2blTFfTJCl5OpnSjXdI2DnxmTgZ2INj0VLZ2FwyRfiosBxCdflCTAiSzrtkkDIetZHWhoXuWatPWIzjYRZqY3jP7BGgdZuHvcKl5s6flkQqbqIAW2DOcfdSXDh8Z69nygEj1cADIJsmwltF8DR+4LpXsslICcQL5gQQSf8IuTLHZyLGKIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8213cWXTFBZSJH9rGZAEnF6C2+2O/tdVAJxoMwfqPJQ=;
 b=drt3N0rhNItde9jvN2TsGy0SaoKaBz2yuUcGFcYvvxt1fRwPbGSAiKckgbAr4p7i+HBayRHQyHTkcGY3YQryR5W7Epnm6Wl68jyqkHjP4RHSvkEEReLfzhX/6RWeKfdH6wnoqAUNmKFiIO/oo2HKr63jAGPByNAll2L0sZVqHQudm5s1Hs+UQFJSki6nR4nsNnR/fzwWlxjM8VLI3wic8A+0jKFPI02m7zfflwGloITmUIYXg/fe3dv19WSKHWLhd2c37GgzrDUrQn/j9XOmvgIJB/yU51WK+RIJgjBxUfVA40B7H5J+Neq2QiHgRq2ejQBw+daU24nHzbovVTOVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8213cWXTFBZSJH9rGZAEnF6C2+2O/tdVAJxoMwfqPJQ=;
 b=ASVhUBPHY6X3dYNy1rnxto5vqjXpHO1KgDxWtx/KbE7eW1dzv3gcqu5YcMloGZwIsiHH/UgpwRQ6QCPHxdQJsFkb8PQnimxlbls6UWh5qvHmJrK/Qt51XLPbINipSORuUEqgbNFEk/0fHBVHU/o3gWxaqiTvvxv1CEip+JAsXXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 16:41:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 16:41:43 +0000
Message-ID: <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
Date: Thu, 3 Aug 2023 11:41:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
From: "Moger, Babu" <babu.moger@amd.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
Content-Language: en-US
In-Reply-To: <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0190.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ca7295-351c-4a49-045f-08db944084ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+0CINFEHghBMt2MCCT2CMi7oSEQ4XkxAtY3qUNEGxCJoJk1vhrGvklT0ghE8YEyW79rfaDPUusa5p5sOBYzoq9chF8UIQmiVkKth4dQeDzL1WXkxvChWRtRaajLFx90VP32SjuabEBaiUZV451yaecPQWd1SYhQAmeDbrTfLnKqaLHkS4t5FMhtemAXCTJKzWRcF+xqsoIzbl2PInuQoyfOOfObu7DzVu5eoTuNSQMdlioPMKGh0O0HZCloUbB1ondXanWoPZFNNGo1F4pJV/EgpFtviIxgSnM+nUDaANdTKcI2qz+7njYCMqm4d1FDRgDSIFzB/1iR5D0G7wVDyO6jW3dj2NiQybuO9p1GBpvRUU9uAI0dxJJh50kj/zqodI0l+KKc/vgvux8IxATe50jBkYYQQNXl6W54qqcTOKpPWfWFTbEys2IshuxrbvB6G+og4qVjY/BO9ehYQiTS4eXkDiXeMC/b/M8R/x5Dz5NgFEh92pyfeo5wHl5Tp7wY7UKDTdJWaLQeQ5Q9AQvoPKu6ozZkCm/9gx7hke5/zF5KCU8WRS8nK3GrVWqhOTcH9hdMAsODKDYveFvixiIaugJOJtW3fsiNZFRQ4OH3ERm00izQKEfsoulp5cngWViGOLpZ5nbw0fslG5ZSqTDR3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(53546011)(6506007)(186003)(83380400001)(26005)(8676002)(66476007)(316002)(66556008)(3450700001)(2906002)(4326008)(66946007)(5660300002)(7416002)(8936002)(41300700001)(6486002)(6512007)(54906003)(110136005)(478600001)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lLKzBRVWIxbHQ0MlNIWE8rbGlWOGR2eUhRUmdCNTBLOXJwT3hub0t6SHNB?=
 =?utf-8?B?UE5qL3R5R3crOWVVbVlpRkhQU2pVOXZNaTFUS08xaWVWUGJ5YVZVYVNPWkVa?=
 =?utf-8?B?QUVaU3VlMWRnY3RUbVVnQyt5T2F6dVl3QmxCVEVmK2RsY3dicUhjRGU2aWlR?=
 =?utf-8?B?VkhKK1lLRjJ2dGxRN3FVZjdQQW5oeVRMSkhNWGhHbmtIemhISzJFTHl5Z2M5?=
 =?utf-8?B?MERGbTBMMG9lUnBHYmpWcGk1dDA5bGE4QzIzN2svVXJDVWQ5RUhHZDNWV3Nq?=
 =?utf-8?B?NHhlR1lOU1daa05IYkR0UjFEcFIwSWY5UDlCcWF3WlZXMVVzVjY0TFcrQ1px?=
 =?utf-8?B?N2hRL2lWNjlkamhZa1R5VGgvOUFRcldBbzAraGNHbGtpTDAwLzFiVmIzU0FO?=
 =?utf-8?B?WmQzakdidUtiTTJBQ01iWmk2NkRYekx5UXh5RERuZWN2K296M0w1NzFBY2tD?=
 =?utf-8?B?SjJ3ekNCWEhJMk1McHRMV3d4Q3JNUkt2dVZqM1pVNFV1Q2l2NXBTbEtXVEMv?=
 =?utf-8?B?WDlNQU45dEhjOSt6aW9vQUFLb3F0UkdaNE9Fd1ZUdE80RnBZSmhocEFqWTNt?=
 =?utf-8?B?ajBrOEl1UFBEY0hxRUVCNE94M29yR0taL0JobGZiYWFBcDNPZmNBRUlZWmls?=
 =?utf-8?B?ODRQWS9jR2pjaktkTnE1VWtHSlpEcUxTYldhUU8rdmRPZ29yNjJNdjgvbVBo?=
 =?utf-8?B?Q0hDOHpyYi81ckoxQ3Y0anZzVzFvWkdSdmdFSjhTeEFpTFBrb1JGbWovZHRZ?=
 =?utf-8?B?NmRwOXgzK2VYWG5wOUdJbWNoOEFFdCtnME05S0JOTVRsbjQzVU42bmxEaTRZ?=
 =?utf-8?B?N2VpYno3UVpBWVgyTU9Eb1R2dGFndkhXbXVVRUQ1MkhDTUVqR3A1ZmxiWDJX?=
 =?utf-8?B?MHV6Z0ZKbjl2UnVwRldvQWdjYmM4UVZlQXZ2NGMzbE9SZ2FsSEdWQWdreVRv?=
 =?utf-8?B?MUVNdk9TUzQzVDNPdTdpWXpqd2xWc3pWSVBMQldqZy9aeVNuZWhLZk8xcTRj?=
 =?utf-8?B?VmRwcHJSb3dMNmxEaE5FS3U1cDlENTNzNERjd3dac1hwZ2NKOUl5U3hoZkdq?=
 =?utf-8?B?WUJzeW9zSi9FZlR4WWJMK2I1TVVtUS9tcEdvVkdoVWRwVUNGeFRubW8vaDZR?=
 =?utf-8?B?UGRvWE01czBUU1FiMGp2WjZ4UzJuZGlnK05VdzRYaWs3djZhZTkwbUtzZlVV?=
 =?utf-8?B?QnIrWmkyNEEzTXdIdTYvVVRSNTJRM3FuUUk3eDVtb094bEdCR0svUXJhSkts?=
 =?utf-8?B?NXJ2NnpKVXBHTXRLVFFoZEJXYXJkZnI2UDdzWER6anljVkkwWlFaVnFESGMx?=
 =?utf-8?B?OXpVSzZid2s2Mnp1M0ZZVXhkb1RZUUMyekswV01KN2Y5YjNQWklhWGtCUXhp?=
 =?utf-8?B?VVpoY3FqTHlzQklodTgxekJlVHdLdi9OV2w5ZzA4bS9NOHhZU3VIeHdibzJQ?=
 =?utf-8?B?Y0RNenJ0aGpNUU5YVU5tOXlKVzViUnJ2VmViZHdiLytIbnp6ZlMzWDZ1OVp5?=
 =?utf-8?B?NDJaUjBPd1Q0S25BdXVjLzZvZSs3TGRtb1JOcEtkSGxjWGVYNDJQVnFTUEVh?=
 =?utf-8?B?OUZCYWxhN2Q2bUFvam1qd1BxdTBHcC9MelAweFI4WG9tS0p5UVhhRlNMNXRh?=
 =?utf-8?B?R1F0cmluNW4ycnI5d2JoU0hiUHpYSHlhNEdFT1VMWng1ZjBBMTd2MjFOenFv?=
 =?utf-8?B?eS81TTBRK0lObEJ2Zm9VVEJzRlB6TDExUDJYMzY4N29vRllLNVJXOVNIL2dE?=
 =?utf-8?B?M1VxbGJ5QWJnVExjVStBT1dtZyttLy9QY01GNmNiOGNrTUN3NGFkVDkzeFhv?=
 =?utf-8?B?ZEErYmdYSUdVa1RzWUNmZy9WaUJFNlY2VGhuVWFSUDhZLzRxU2JXOGZwY2Jp?=
 =?utf-8?B?Q2U3SG5IZzhmUGpVV1FRV2VFTFRab1JYNmkyRDVwMGRpTjBYQU1iM01YS1lD?=
 =?utf-8?B?ZHdSanlEeHRSTWQwR2hFNGdPU3FUVUNSdnJiVFFpcy85NEVsWVlNdXFKbnJS?=
 =?utf-8?B?dGR1ZzVuUkhNdEh0aGxaWDN3c0t3OW1pMVU0UGpQSkRJUDU4a0VTckxGb1RU?=
 =?utf-8?B?MHhVdzJDNnpJK1VJdW9rMjlyZkQ5SXlyeDgrenAzY2lLYTlqR0lUNEsyZ3dL?=
 =?utf-8?Q?XWnY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca7295-351c-4a49-045f-08db944084ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:41:43.0582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMvTYR0BvuyTT4+/3BVmpumnAlCtfDFv1dw9t5OA/W96SMYjeIDlMr7lgadKMqLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/2/23 18:49, Moger, Babu wrote:
> Hi Zhao,
> 
> Hitting this error after this patch.
> 
> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
> not be reached
> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
> should not be reached
> Aborted (core dumped)
> 
> Looks like share_level for all the caches for AMD is not initialized.

The following patch fixes the problem.

======================================================


diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f4c48e19fa..976a2755d8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -528,6 +528,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };


@@ -1904,6 +1905,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1916,6 +1918,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1926,6 +1929,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1939,6 +1943,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };

@@ -2008,6 +2013,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2020,6 +2026,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2030,6 +2037,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2043,6 +2051,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };

@@ -2112,6 +2121,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2124,6 +2134,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2134,6 +2145,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2147,6 +2159,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };

@@ -2162,6 +2175,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2174,6 +2188,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2184,6 +2199,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2197,6 +2213,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };


=========================================================================

Thanks
Babu
> 
> On 8/1/23 05:35, Zhao Liu wrote:
>> From: Zhao Liu <zhao1.liu@intel.com>
>>
>> CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
>> intel CPUs.
>>
>> After cache models have topology information, we can use
>> CPUCacheInfo.share_level to decide which topology level to be encoded
>> into CPUID[4].EAX[bits 25:14].
>>
>> And since maximum_processor_id (original "num_apic_ids") is parsed
>> based on cpu topology levels, which are verified when parsing smp, it's
>> no need to check this value by "assert(num_apic_ids > 0)" again, so
>> remove this assert.
>>
>> Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
>> helper to make the code cleaner.
>>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>> Changes since v1:
>>  * Use "enum CPUTopoLevel share_level" as the parameter in
>>    max_processor_ids_for_cache().
>>  * Make cache_into_passthrough case also use
>>    max_processor_ids_for_cache() and max_core_ids_in_package() to
>>    encode CPUID[4]. (Yanan)
>>  * Rename the title of this patch (the original is "i386: Use
>>    CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
>> ---
>>  target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
>>  1 file changed, 43 insertions(+), 27 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 55aba4889628..c9897c0fe91a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -234,22 +234,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
>>                         ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
>>                         0 /* Invalid value */)
>>  
>> +static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
>> +                                            enum CPUTopoLevel share_level)
>> +{
>> +    uint32_t num_ids = 0;
>> +
>> +    switch (share_level) {
>> +    case CPU_TOPO_LEVEL_CORE:
>> +        num_ids = 1 << apicid_core_offset(topo_info);
>> +        break;
>> +    case CPU_TOPO_LEVEL_DIE:
>> +        num_ids = 1 << apicid_die_offset(topo_info);
>> +        break;
>> +    case CPU_TOPO_LEVEL_PACKAGE:
>> +        num_ids = 1 << apicid_pkg_offset(topo_info);
>> +        break;
>> +    default:
>> +        /*
>> +         * Currently there is no use case for SMT and MODULE, so use
>> +         * assert directly to facilitate debugging.
>> +         */
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    return num_ids - 1;
>> +}
>> +
>> +static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>> +{
>> +    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
>> +                               apicid_core_offset(topo_info));
>> +    return num_cores - 1;
>> +}
>>  
>>  /* Encode cache info for CPUID[4] */
>>  static void encode_cache_cpuid4(CPUCacheInfo *cache,
>> -                                int num_apic_ids, int num_cores,
>> +                                X86CPUTopoInfo *topo_info,
>>                                  uint32_t *eax, uint32_t *ebx,
>>                                  uint32_t *ecx, uint32_t *edx)
>>  {
>>      assert(cache->size == cache->line_size * cache->associativity *
>>                            cache->partitions * cache->sets);
>>  
>> -    assert(num_apic_ids > 0);
>>      *eax = CACHE_TYPE(cache->type) |
>>             CACHE_LEVEL(cache->level) |
>>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
>> -           ((num_cores - 1) << 26) |
>> -           ((num_apic_ids - 1) << 14);
>> +           (max_core_ids_in_package(topo_info) << 26) |
>> +           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);
>>  
>>      assert(cache->line_size > 0);
>>      assert(cache->partitions > 0);
>> @@ -6116,56 +6147,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>>  
>>                  if (cores_per_pkg > 1) {
>> -                    int addressable_cores_offset =
>> -                                                apicid_pkg_offset(&topo_info) -
>> -                                                apicid_core_offset(&topo_info);
>> -
>>                      *eax &= ~0xFC000000;
>> -                    *eax |= (1 << addressable_cores_offset - 1) << 26;
>> +                    *eax |= max_core_ids_in_package(&topo_info) << 26;
>>                  }
>>                  if (host_vcpus_per_cache > cpus_per_pkg) {
>> -                    int pkg_offset = apicid_pkg_offset(&topo_info);
>> -
>>                      *eax &= ~0x3FFC000;
>> -                    *eax |= (1 << pkg_offset - 1) << 14;
>> +                    *eax |=
>> +                        max_processor_ids_for_cache(&topo_info,
>> +                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
>>                  }
>>              }
>>          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>>              *eax = *ebx = *ecx = *edx = 0;
>>          } else {
>>              *eax = 0;
>> -            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
>> -                                           apicid_core_offset(&topo_info);
>> -            int core_offset, die_offset;
>>  
>>              switch (count) {
>>              case 0: /* L1 dcache info */
>> -                core_offset = apicid_core_offset(&topo_info);
>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
>> -                                    (1 << core_offset),
>> -                                    (1 << addressable_cores_offset),
>> +                                    &topo_info,
>>                                      eax, ebx, ecx, edx);
>>                  break;
>>              case 1: /* L1 icache info */
>> -                core_offset = apicid_core_offset(&topo_info);
>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
>> -                                    (1 << core_offset),
>> -                                    (1 << addressable_cores_offset),
>> +                                    &topo_info,
>>                                      eax, ebx, ecx, edx);
>>                  break;
>>              case 2: /* L2 cache info */
>> -                core_offset = apicid_core_offset(&topo_info);
>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
>> -                                    (1 << core_offset),
>> -                                    (1 << addressable_cores_offset),
>> +                                    &topo_info,
>>                                      eax, ebx, ecx, edx);
>>                  break;
>>              case 3: /* L3 cache info */
>> -                die_offset = apicid_die_offset(&topo_info);
>>                  if (cpu->enable_l3_cache) {
>>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
>> -                                        (1 << die_offset),
>> -                                        (1 << addressable_cores_offset),
>> +                                        &topo_info,
>>                                          eax, ebx, ecx, edx);
>>                      break;
>>                  }
> 

-- 
Thanks
Babu Moger

