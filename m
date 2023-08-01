Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1776C0B3
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyZ7-0003vv-6v; Tue, 01 Aug 2023 19:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQyZ4-0003vg-UV
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:14:06 -0400
Received: from mail-bn8nam04on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::60d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQyZ2-0007b5-Pg
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFgyNcIkVK4jq7a0jkEhIeMQrfvkpl9Ha8pmJZAitq0H3oIA5/fBJ/LBojVcGouUP1+slqdzvCQtc0VoMpJnHSq4H9RAZhLv9yxWB5i9Kcnx9UpLH85nvKQkbML3/T+sUNEDSiLOssrBL0F0hnnddZmBtIBM28aTTZ8skLVTqXjCMLgp70LBN1MsaQAyqVULHtjVz9HlVg7f2NO5WX6nSdFIPTEKGzWQ0wAexV5BRWedIw7dTooct+1Xhvrhv/WSxf4Lhsz9ib2brLQvam1vx4aYQR2d83jpNYHu+3DS+1rfNvbT9/fqtX2SD84/00I3zPVtQ8cTvbVF1CnRXwwPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K0DTsxPfmnbLcIU7o8XZUC+aHRpo4ieVrOcD5gnarE=;
 b=OuCxDXNbwEGb1jY4yEHBlfdcs83uKyZI62KLhVY0MxtnPFUcc7iJIHwLKkIvcB6lHWeGff/0ZdD2UWU1+gXO5YOVALBtUkSAaK6AsUzBdMJUKdb4ZbAUBEfsEQc3rHhpUwoNlWcJn07BQmUS9tjQ3sM3cvKPbsG+jTliJQmQySfkznUmLhOpVFRWWFVYnP6AFBjgK+I0XaNAjWvq7bSv6G7IVYT+XR9+J4JZ/9HebdX8ObLaZ6dH5DpnN1bu4JD5ky3G3i7pHr8NLUPOtvSutrgXsCDwmLmamI17IC2Q8+DGHPBiSffyYNCYaDFsdzlkx63FT0+RHFmiMqmpetHJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K0DTsxPfmnbLcIU7o8XZUC+aHRpo4ieVrOcD5gnarE=;
 b=gCHDxFZX7x7bpcQ4OBykQ2alHFi77M7qX8bs8MJPcuXPfpZJeNIdx0Lvw1wTz3vO3AQ6dvI6wuPZbqIpLNfIo4SABKgcuCAJlKAmMbFEidAQ48mOYItGfjKK7t8GW9fXQ3ACBMy1cnNmJXr5pKUtUSdRBz5llZxIB7c+J6ec97I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 23:13:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 23:13:58 +0000
Message-ID: <40340464-84fe-3512-0cc2-eb1d2622e353@amd.com>
Date: Tue, 1 Aug 2023 18:13:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
Content-Language: en-US
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
 <20230801103527.397756-2-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:8:55::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: b18b41ff-f457-4355-88b5-08db92e4fc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcg5Atk8yz+N5SrVMGQXVoQPytEAEcQHYU4aXilrm4lM9koKxjOcgFB+oWuNgXxM6etE0CtzkUFYEYiQ/NM/9DoZoZh0Woe5oc02It+2rgLydtG7x3xW1w4vnl5tSQPHLQKlafVD4nuubgsoupVOaRBY8/3dbr4Jnaisy5ZZUlLorini+sJl6D4fMoiDErtz2lQkqC0ZE0SkkxOYxisLHchynI97+vQLCJx7xx4frHXYX0t0YW2y2mEe87KwFOPU2j+pdSvnyH7A1cw8MpPJUVVrTjxcqJKLKi0Lj+/PTfw/2nWM4c5OGr0r8D3M1NhdMQGbaNl2S31wZC0FotwkXr6qAlHuLV/e2wU7qwV43WNJCbHAD+LC0/o6HgVgnd+Tf5epz11l9/lm0txw9MC8ts+AQNVyFNF7DIPgldEgnac434pKKzY7pD+Fs+43w9Y78Wdm30O9WzoDHREtrXS7HHyeCf4SH6uG67/LG4MHHPNTBVydDy5WkKSW2MM7/0AwzQSxc7T49HCTlIAeeNUny6WRaPQJkyz4XZfMSE0mEHNfr4M8GwxxaD7SN+pe0Ugk/B2jvxOfn8FPCBvHbS0VUYKpLF83m2vuq1u7MTOi38aU2nVjnTlUMZwVoJDHr9G5PHJsJtTcHCOd7p1eMRnUlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(2616005)(36756003)(966005)(6512007)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(66946007)(6666004)(66556008)(66476007)(6486002)(4326008)(31696002)(53546011)(26005)(6506007)(41300700001)(31686004)(8676002)(5660300002)(8936002)(83380400001)(7416002)(3450700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdGZlNNWGR1UTVQT1JQZkcxT3ZiNXN3bkVpOC9vWG1rRzlvR3JPTHRNUk9L?=
 =?utf-8?B?L3JuVXVjVS9MR1AwTmJGMTU2RXFucmJIdEVJcnNVZ3YxR0lad0hYMDVYejNT?=
 =?utf-8?B?SVhPUVF2ejJMMXB2MTRIbWNSK1dPZHN6R1RybFJYQzlNNW1pd0hkaVUzTTBV?=
 =?utf-8?B?RXcrWE92NElUVWpGRTNrSHFNZXVkdjBYNjJ0dUlRWnpvbUJ3bU1wZytKVnNz?=
 =?utf-8?B?WHNrUUxPSS81MzhWNWZJWGhGbnVMMmVteWxQUUFZVWNkWk1Ga2tUUjNWNEZm?=
 =?utf-8?B?VmpqcU5XcGtMSjI3SGdvUWdWZmVsWUkzclhOQ3Rkd1daRzROVDBiQkZIM0lG?=
 =?utf-8?B?YTVDRzdvNnE3MEVJaUdqQnNFQUo1aDRCNGJWc0Mxd1poSWNIMkt4MXhMOWJN?=
 =?utf-8?B?S3lBVXRxRVY4bC9EekhOTDZPSzFUOWthV3Q2Y3BlY0lPL2k4MHBiRStQSlRX?=
 =?utf-8?B?VExuVW1NUm4yTjA0N1UrZGF0Mk93WHdEWFZERDk4dFhKWlhVdGU5WW1weENR?=
 =?utf-8?B?SkJTRWJYaG81RFhyYzFCb3dmekF4OGhPRFpPR1ZSL0E3azZsc0VCMkw5RnVl?=
 =?utf-8?B?ZVMwQWZNd0VjWVVNU2gydHFvUGJ3N2V1Y3NzZjZMbUJhUUxoZDBsRWh5bXA4?=
 =?utf-8?B?MkM3V0kxVDYwc1ZkWEZ5WUdBZnY4UDg4UlJ0RitEMklXNXBhOG1YWitBWTZq?=
 =?utf-8?B?eUl1bDFFMmIzM2hWMDdQYkZiaXdwSW9Sc2t3UXBZNFF2UzBWWmxVN1hCeXky?=
 =?utf-8?B?MU51bGYxY3BWQXBEVmVFVmZHNW1kNTM3OHl6VExzSUNTVmRYVVNjQUExWWF5?=
 =?utf-8?B?WHNmd1NmNXBkdkJjV1RnVEl4dVdta25wbDdDVldwZkVjc0ZNL0dmOElmNVZV?=
 =?utf-8?B?OWpWbnJqQmpOOVhYSWlzdkVTbUsrUGxqNHdhcHFwdjEzY3BzbXptdXhBRnYz?=
 =?utf-8?B?amJOSWQzS2d0RU1ma3p5ZDI2T1o2UzVYc29kMGxTVmhrcHZudENFWWx1bStF?=
 =?utf-8?B?ZFBnVkxPRWdMazRRK05Vclc0bkJ1WjRCU2xSYWlvc0p3WlFyNVlEU2YvWCts?=
 =?utf-8?B?UnVxYnB5OGlyUVBOUS80V0ZFRDY0VlZienVncG0yQmlBZ0lxMHpMdjVLUUMv?=
 =?utf-8?B?dUJFbFJBZ2U4QWcxck5iL0QxWCt2YSt1c2RkVksrWXdPN2ptRlpnUXpxakt0?=
 =?utf-8?B?ajYzN0NrVnpRRk41dmJoYWErbTlva0pSUFFxYnpaRlgxYUFLb3BJQ3ZwWFZK?=
 =?utf-8?B?M3VXSVl4R1ZqemkwbFVTTzFYbDhPYjliWXREdFJFSE4vTWtsdkVETm02N216?=
 =?utf-8?B?a1F6L1F5T2lOOUIzeTloT2htVTkzazdSZGJCdkV6VUdNSzNUblRCWk1hd1dz?=
 =?utf-8?B?UDRxeksrUElyU0svVCtkWk1GMWlsNnlmblV1QVpVUTh4OU5KeUoxUVpKdVp3?=
 =?utf-8?B?REhJZmkvWVgxSmF4SHh4MENaL0dpN0kxSkV4RVA4UGRkdCtZek5pd0ZNTk4v?=
 =?utf-8?B?NW03aU90KzhoNzRybUlBdE1mZTNhZnFEbjJqdGhYMEppYjBGdGFWZS90WWdw?=
 =?utf-8?B?eEFRU05rRWs3UThPN1V0bjNlS2NGbEdGaklwZTQ5RTZJSGljTE9ORjBmUFBQ?=
 =?utf-8?B?bXlXQVA3OXlUdzBLR1FDdTJ2ajVVMGdTTys5d1Y5QWhIUytJQndYN1NsUk5y?=
 =?utf-8?B?NnVzMkxQcTBZWk0wM1U4L3M2em5ZV1d3blE5aHd2VlpTNVgwSGlJMk9GbGV0?=
 =?utf-8?B?TjhsMkZPQ1BUTk9MYWZWL1VmLzNTRkgyY1JQclp3K21hcWdhQ1BVN2V4a1Vz?=
 =?utf-8?B?aVhYc0xSQlM0SHRaYTRUbUhzQlNBZy9qSmNKMXpqa054ZGMxeG9yMVVzNjdD?=
 =?utf-8?B?aERqS3c5UGVxUXdmbW96akNIT0JYYzZNTGRTS201eEVjTkk5dElBMDlRa0Fs?=
 =?utf-8?B?WTdkM1hWMlVmbndkVjZLdDQ3UzJ6c24wQTZEaWRrY1oxNXl1ZGMzeGJnYlNS?=
 =?utf-8?B?RHhpaHFLZEgrbHNseTlvWXBMaDNyWXJsMHNHZUxnMGtQSU1pMFR6UFp1bUEy?=
 =?utf-8?B?UEtDUlI4SmZzb0o2Qis1N1hmVWF1c0xBUUhkU0krOEdkNzRSelk5a0NBdm9z?=
 =?utf-8?Q?SMfo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18b41ff-f457-4355-88b5-08db92e4fc65
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:13:58.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4L7X+1kdVqqwNnxMqanZQfwpNdJPjYmCNDzzh1cBJ4Gm0XD474X+4oI+9ZkMZ7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::60d;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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
> For function comments in this file, keep the comment style consistent
> with other places.

s/with other places./with other files in the directory./

> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
> Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/i386/topology.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 81573f6cfde0..5a19679f618b 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -24,7 +24,8 @@
>  #ifndef HW_I386_TOPOLOGY_H
>  #define HW_I386_TOPOLOGY_H
>  
> -/* This file implements the APIC-ID-based CPU topology enumeration logic,
> +/*
> + * This file implements the APIC-ID-based CPU topology enumeration logic,
>   * documented at the following document:
>   *   Intel® 64 Architecture Processor Topology Enumeration
>   *   http://software.intel.com/en-us/articles/intel-64-architecture-processor-topology-enumeration/
> @@ -41,7 +42,8 @@
>  
>  #include "qemu/bitops.h"
>  
> -/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> +/*
> + * APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
>   */
>  typedef uint32_t apic_id_t;
>  
> @@ -58,8 +60,7 @@ typedef struct X86CPUTopoInfo {
>      unsigned threads_per_core;
>  } X86CPUTopoInfo;
>  
> -/* Return the bit width needed for 'count' IDs
> - */
> +/* Return the bit width needed for 'count' IDs */
>  static unsigned apicid_bitwidth_for_count(unsigned count)
>  {
>      g_assert(count >= 1);
> @@ -67,15 +68,13 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
>      return count ? 32 - clz32(count) : 0;
>  }
>  
> -/* Bit width of the SMT_ID (thread ID) field on the APIC ID
> - */
> +/* Bit width of the SMT_ID (thread ID) field on the APIC ID */
>  static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
>  {
>      return apicid_bitwidth_for_count(topo_info->threads_per_core);
>  }
>  
> -/* Bit width of the Core_ID field
> - */
> +/* Bit width of the Core_ID field */
>  static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
>  {
>      return apicid_bitwidth_for_count(topo_info->cores_per_die);
> @@ -87,8 +86,7 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>  }
>  
> -/* Bit offset of the Core_ID field
> - */
> +/* Bit offset of the Core_ID field */
>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>  {
>      return apicid_smt_width(topo_info);
> @@ -100,14 +98,14 @@ static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
>      return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
>  }
>  
> -/* Bit offset of the Pkg_ID (socket ID) field
> - */
> +/* Bit offset of the Pkg_ID (socket ID) field */
>  static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>  {
>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>  }
>  
> -/* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> +/*
> + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>   *
>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>   */
> @@ -120,7 +118,8 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
>             topo_ids->smt_id;
>  }
>  
> -/* Calculate thread/core/package IDs for a specific topology,
> +/*
> + * Calculate thread/core/package IDs for a specific topology,
>   * based on (contiguous) CPU index
>   */
>  static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
> @@ -137,7 +136,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
>      topo_ids->smt_id = cpu_index % nr_threads;
>  }
>  
> -/* Calculate thread/core/package IDs for a specific topology,
> +/*
> + * Calculate thread/core/package IDs for a specific topology,
>   * based on APIC ID
>   */
>  static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
> @@ -155,7 +155,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>      topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
>  }
>  
> -/* Make APIC ID for the CPU 'cpu_index'
> +/*
> + * Make APIC ID for the CPU 'cpu_index'
>   *
>   * 'cpu_index' is a sequential, contiguous ID for the CPU.
>   */

-- 
Thanks
Babu Moger

