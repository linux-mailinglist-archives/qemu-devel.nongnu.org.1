Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B27971A8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:14:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCxn-0004Ve-0E; Thu, 07 Sep 2023 07:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qeCxf-0004V9-Dj
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:14:11 -0400
Received: from mail-dm6nam04on2085.outbound.protection.outlook.com
 ([40.107.102.85] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qeCxc-0007Ld-M7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUZAWL73q4fezNlI9JBvgCJ55djRy0S6kuRiR3acS3xLQXEG1ZJ9BV7qA1bmaNskIawqiSosOPDK0lRwutwI27Jf8ugYxHwT0kPsHapNWPLWWe/uG35CbX+NjAAeFRW4OIQqOYlQrBXFiIIp+SvbM9uv0ngeFZawtv6LvTtquq6ZwjcmWC9PlRrHmYpCSPG4FzEVP6Ffv3wv1zRzdDHu6eDoMy2mS1F8qnYSZ4Iz9TEo4DWHKythMDf9GBEutdoVQONb6TT9lmyOd48K5jdbSJZBZQgCMeP2y0jH50eSDOXqtw/Lwaq2RcrorrMQCJzXgh41T1HGXBXBSwvc7Sji4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0p+ZsQaMFt7DgBybuJOnV7HI90yax3miQ1+EbTRbE4=;
 b=aXkUQDrv1Lh/m09D0XABHnP68vTYFOt5ymiXt35tXa8JATsAq42gxMrEuEWOMEa97lNSX1iIkxhl/H8QEkAVppKwvt0EywzBucXK0rxln7KvojLzvsySysalLfFOqxC+97FHSRdBAR4ZV11SoXfokHQUL1h+H93KITN9UA7Bj9r4HafxM4dg1FlnjvpWM9rjVZLLzgNFnHZsn8V+BLcjGQ4bZxbWlRqSR0HXaWbVV4Ih35RvpUVubbu7XcgMRPhlPIf7HlIwaBYkM78JxD+EemzpQUvKr28Oc509iGY7vgtxUevFcdCqvK0oXRNDZ2eO/WXPd5KVkE3Yr98UKRcPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0p+ZsQaMFt7DgBybuJOnV7HI90yax3miQ1+EbTRbE4=;
 b=EX6Xm5CTtm88BD7VgBUuLX5xQScClJsNudVFdFMJ3BALorz4OCFS1FmqlyWha3mAx//2s0o3zCZqoXNCdUVOG2k/NbR+TwsEZmFi7msoolYF6fC/+41EjFNTkzpw1Pb/GtY81pJJI75Jzq3CyfGAWrUyPZNClIO7LlM3UnttXH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:12:36 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb%6]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 11:12:36 +0000
Message-ID: <6efe4fc0-3c9a-dc91-4a04-498b38c66374@amd.com>
Date: Thu, 7 Sep 2023 13:12:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 william.roche@oracle.com, joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230906205308.50334-1-john.allen@amd.com>
 <20230906205308.50334-3-john.allen@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230906205308.50334-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2332eb6b-37fb-4e82-8d27-08dbaf9356e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PsnwLW8xkTd7DqKGPkpzgmnluS/C4KONjFlBZhw4IdKiEBxhbpuxHiLLYUWLpPZBjJ8o2OOfYzLpcjjhXohFohRp/zAXazL9/BVnCCjftSq6YWAKZnHlOnNNj5d+ynnUG4plXyWLjO+53VCdcXWPcHqlOBlS0vH3GyNZ7jCFKzqoBrLdGXIgKnyyC/fuYXR4YzxxmM48XoE0NHr01RFbYYLWGWIOv45BuKlf8e9+qyccVzEyHNoyvRav9lKJEV9fU8P5JKkDkmASlJG95hpG4IcGCcx2b1Ld+ruRWRTtV+Cw+bQd9FtbEsp5nBBEav7Rs/0rJodO7O5CFw/lysY+c3WgY12LzXpxC9qSSlv89uB4SyeN8BST8Cz+vqjRXqcB3jmk0SDAbu/nlW10+ugfqdNzQaJbNvj8OLjemSiQuWgOknhCKrZ0N+pbEJGwJ8H8PFaNDS+KjXGLr6xY6Vfur0OyzXUFkpiixgDawkCQTishA14jNa9VuLNUcu//VGNCt9lth9dwmtZeZQZ3IkNDE36EShbcL4qVePr/WPdZSQrHLH42k1pXnwqHCMY9ejbo3b+RsFKSm6mCLt33vYnczfmLn7PthaZ4thNd/rzRPNAVEL0cEf4maYMrrN/qcZ19sxH97B839v1eFFaVwVKCl3/N+f0NDgoSvCjrgadXXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2810.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(66899024)(86362001)(31696002)(53546011)(26005)(2616005)(36756003)(478600001)(6486002)(6666004)(6506007)(38100700002)(83380400001)(6512007)(41300700001)(8936002)(8676002)(4326008)(5660300002)(31686004)(316002)(66946007)(66476007)(66556008)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2U5MTlOWTVzdEo1TzNVQXk5Q0gzWWdJSWVRTUNFRmhjRDVmLzdtZHMwa0RV?=
 =?utf-8?B?VUsrb0J1aDNseW9mZW9Sd1RUQjZ2NXErSUwrZnhyZk4yclZ4RTZUZ2FrQjJk?=
 =?utf-8?B?bFhPSCtvWVh5amVSdnYwOGFEakVhdzR4SXN1V3U2R1h1OWVTVEFtVnh2YTVy?=
 =?utf-8?B?ZlVDM0lqZ0lNcGFGWkZMU1lLZER2eDRQb2thZmdEaG14cm5RbGRIMlFJOFJU?=
 =?utf-8?B?Y1lKZCsvSjJUd0pJKytEc0I3ZUhFK3JTNVNZY3k2bDVXeU5DMnF4KzYvSGpJ?=
 =?utf-8?B?UE0xWnlwVkx4UVNDTUJYWm1LckxiT1NDZWdGUFBmc2w3QnI2ZkFvZVJCWm5J?=
 =?utf-8?B?TTBBb21XRmZOZlB6WTJycDZqZmZKRGcvdTBmbWVRQ05CZDQ1VjBpQ0Y2RURv?=
 =?utf-8?B?Rm5jUVFaWVRHWXFTa0ZRYUZwWktrTEI5aXZCcmw2MEVldTRlMmp0Ym1FZVlR?=
 =?utf-8?B?WkZXaFMraUhxZVZwYVpnRlBoMzNlUkVFN0xBL29RSzZkeDh6Sm5FOUpnOHc5?=
 =?utf-8?B?TGIvNXRZWk1rdG1RY0RFMGxlYTR4WjJhTnhhVy9QMTNRMFZsZUcyTUNxYTJM?=
 =?utf-8?B?d0JMVXBXWGJDa1RvcmhHOXpId3pKYnNaSWpuc05CNE5KRTdWNGwwN2h4d2F1?=
 =?utf-8?B?dGpWcGVIYVFjeE5kK2s3NkFDVi9yY0NGaDlkeE9XM1Q5OC9YVEg0c0k3Q1VV?=
 =?utf-8?B?TFIzMkpPYTdjdm1rVC9kdC9COHRDamFOUmNUUHd5YjZFV2xucXdhV0Z3UWVS?=
 =?utf-8?B?OEE4ZURXRHlZLzMwTHp1UHFsZnZUeENmUTROVUNsUXEwQkNpcG9ES0dTNCtq?=
 =?utf-8?B?bzJhVWxnSGJsYWVIa2YyY3Axc0c5ZUZqbVZyZXpZRTNsdGpPVU9lVFJiOXVa?=
 =?utf-8?B?WnRRUHA3d29PWnJuZ2VpTmtZMVo0aW5wVVZINGNzSVVUd2tUVnhqU1pNcFRn?=
 =?utf-8?B?N3ZUTWNPYlpBdmNhcEd4QUl1UlFUcVcrK0lvSjgvMDBxZzU2bitUNmxRNysx?=
 =?utf-8?B?MGNaZWM2enZPbmhXWjB5ZHloVTlTbEFobk1QbzNNd3QzOUJWVWY4WVIraE1N?=
 =?utf-8?B?MTZyeFNaRnlhTG01THBieE0xTFRmcnRjOExjQ1ZCUHltNlFaeDlFRTJZd2RT?=
 =?utf-8?B?SFkzTnA4TjYxQ1NnRWJxb2F4akhGbXBLNmtpS2xwQkRnUTlRQTFaS3Z6cW53?=
 =?utf-8?B?UDVRR1I3OGlvTERqQzJTZVpLMGt0VHBXV3U2S3V1bS9jdFVVam9ZNG5IY1Nm?=
 =?utf-8?B?TnFjRzZDNURJakNWcFJ4K2dzaTdIWkYxYXFIZlgwUnR2NER1VDByYndIdWdV?=
 =?utf-8?B?bVVLZEtNeDVJcUJjOTFvc05KQ2duMGlPQndMdzNtMGJZejdWK0VlT2FHZGJo?=
 =?utf-8?B?N1lBazVVUEdyL254YkkwL1czdmtNNm0rV3R3Q3N6ZWJQSEE3NlJ2MUVIMFpj?=
 =?utf-8?B?Qk4rbUh5QkVpYWZjUlZJSkI2dmt1eW9lQllUaW9naTV5RklSSkEyMG04eTF1?=
 =?utf-8?B?T0Zmbyt2QXVweFhKN0RLL3laSVh0cTh3N2RRcUNUcDNxdjA3eS9iTGxOYWJH?=
 =?utf-8?B?a2Zxd3N6YjVRVHpIUmw2ZnNGTkVQOUo0VWs5RUVZeEo0cFp0UDlHMndFaFli?=
 =?utf-8?B?S0M1bHllZVZWd2VvVXVZL1ZBdGFjYjcvbTFOdFdlS2RTdzlKRjhYMTNjZlgx?=
 =?utf-8?B?c3BHRzE1c1JRdHJpRERwN3ZrR2wrcEhIdWhMdnh6aXlqdGF5aFp1cThFZWdG?=
 =?utf-8?B?dVc1U1l6UHAvQWM5UHNqZHhISmE2bFpjYzVNd1h2OTZYYUFKRFFSZlIxWG5C?=
 =?utf-8?B?MlZyMEZ4SGNla2ZUVjZHTDhSdDhaQUErUnBFQmN0NVJBTjRGS0I2bjZsd0Zz?=
 =?utf-8?B?elQxMlkxOHc4V09kRi9wZHFlTDNlN1AwSGdIRUMvaUJRRTRmWEpZK2RMQnI3?=
 =?utf-8?B?VFJCNHBxL1kvajN1Q2MyemRxcy9PM05tdEZIVnZVbHZIck1uY3RZSENVMTc3?=
 =?utf-8?B?WE53eDhBVGRGT1N1ZEhxK1ZUaU91SWZQSzVveS9KR2NEMzJSaXU3MGZHNEMx?=
 =?utf-8?B?Z3F6eHBNY2VJVW1aL2tEaDZNbzZLa1kwVlcxMGlIM25TZHdMYm9xZDNSejhB?=
 =?utf-8?Q?TE2jb2IW1YDEHvLh562SawAoI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2332eb6b-37fb-4e82-8d27-08dbaf9356e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:12:35.8627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lT3yrl0vDclvcnQKggKvW1WXkA+PMYZx0f6AdpKLosQdgKA0/bfvpEjq1ILwyYFnOp80dR3LR0CrpLcbu2p/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
Received-SPF: softfail client-ip=40.107.102.85;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/2023 10:53 PM, John Allen wrote:
> From: William Roche <william.roche@oracle.com>
> 
> AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
> as it panics the VM kernel. We filter this event and provide a
> warning message.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
> v3:
>    - New patch
> ---
>   target/i386/kvm/kvm.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 5fce74aac5..4d42d3ed4c 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>               mcg_status |= MCG_STATUS_RIPV;
>           }
>       } else {
> +        if (code == BUS_MCEERR_AO) {
> +            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
> +            return;
> +        }
>           mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>       }
>   
> @@ -655,7 +659,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>           if (ram_addr != RAM_ADDR_INVALID &&
>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>               kvm_hwpoison_page_add(ram_addr);
> -            kvm_mce_inject(cpu, paddr, code);
> +            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO) {

Isn't the 'optional' case we already handle inside kvm_mce_inject()?
So this check seems repetitive to me.

Thanks,
Pankaj
> +                kvm_mce_inject(cpu, paddr, code);
> +            }
>   
>               /*
>                * Use different logging severity based on error type.
> @@ -668,8 +674,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>                       addr, paddr, "BUS_MCEERR_AR");
>               } else {
>                    warn_report("Guest MCE Memory Error at QEMU addr %p and "
> -                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
> -                     addr, paddr, "BUS_MCEERR_AO");
> +                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
> +                     addr, paddr, "BUS_MCEERR_AO",
> +                     IS_AMD_CPU(env) ? "ignored on AMD guest" : "injected");
>               }
>   
>               return;


