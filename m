Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC076C0C9
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyfi-0008H1-Ns; Tue, 01 Aug 2023 19:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQyfh-0008Gr-6y
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:20:57 -0400
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qQyff-0003jg-6d
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:20:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNtR1GlwfkFYsj4iUvDSTt5xVnjxPrSNLeHWEY77HtFcqwg8hVCgNmdaRWNJhNJYnSmM0rOMiUFfG7PSC1BAZY1263HJLJSYc66oFlBHXLSmi9X7QgfSgNUCSlvLl6ivFHBoeWTpEKlxIfIkgfpCohvv7pZcI35ELqF8EJftwA1f1zEbmiknYQqd7sQ9y7YKj3iX+BzRWBEae7nz3NflAs9nQz9rEn0oeVOTxGOlQmZRPNsvT7P1gcwuzpJcEM2KNwfCQhUC3ymcRqlKCPkrsGfkOAQ1v7jL1B/3IFQw1SfAXRxNZRMS5aP+TnSW5QBs/PCXUrewFbRlF9Agk6Fd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO82YKDTiMw56vIKNlS+uDCL7nMAEG2KAvT5WMIr8os=;
 b=b7I2VCfyRT6fwdopJHJetzI+pHWkrzH3+MKMcN00mBEh8gEkimRpeUKE8E+8zklf5vzGy87u3+MVlmWQMarxm9fHP2G013U3xvMDk90XuLEPo++D6y0NkO+rEfVWwYC+YTexthJGhjz/d6GDyI80s3o1RJj4G7iiQN9atuhhEYyv8TjtMIFnCs+yZvKG0cLbpXCUFDhASaqZ45Se/Dn33nwxohFqw/OoaI2/ZCr0ZfTV3SdeJu7icivE+xHe5DMcXxibkMLqarEQWCRkCfEssmNpjEQLDXruycGhERP1gFNsvCJRkoK01jfMqweDdCyDOjfKAM0GHcyZqvmjRjtXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO82YKDTiMw56vIKNlS+uDCL7nMAEG2KAvT5WMIr8os=;
 b=YWWn/rv1q6Bgz8pisKY+M7T4CkA6Pzq7UM/gQ1hARW03hPEj2M47S+6/zHeUKGdSCI5Pg7R2u6PO/YfgrqnxAnGeLJ5nQSV4UuCUuf7gmdt2upciZCkR6v4SOdZF+PHJsvwy5A/+IE4xB6okXIxu693BIHKMax9wOZtu4jgPn34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 1 Aug
 2023 23:20:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 23:20:48 +0000
Message-ID: <cb782016-1daa-1e04-df1d-89171fcc814c@amd.com>
Date: Tue, 1 Aug 2023 18:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/17] tests: Rename test-x86-cpuid.c to test-x86-topo.c
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
 Yongwei Ma <yongwei.ma@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-3-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: ba87b6b2-279b-4b9f-49d8-08db92e5f09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e40GUt3+pCLHiBKTiEyyrJZnrBJ4yYW96P94EZyGyHIPJIVUqG2z7g5pKtKZMn4dQZyNajE+8s85wAHyD03ZzwTIl9bq4GcCotQBrVXnQVmGeHAowS2auK4dC8pGXXu+EdQYzUgpv8TPxLtWKSksL8ApAFz6saRHfC44zJBupLRlggQGzvWDzp39lTbgW9u66e3nrucCtnmtQePiBNrd5mPvEOx6RbhmvXqbOixQi7Rgfru+HBilTHCsw4dI+CJ5UpMAfBT+G60Uqg5xSoiKj9AJU5sbdj06qOftK33Y8ptSL6TULzBW1Fn+1h3mGC7PfH1mEJJyB7Oydt3D1dfmi+SfznVldcsV4ogapzgLpmj6Z9WFMPbJ7zq6MH+u1WH8klukgEyzbRIactkTeLE3GdKo1FC7ZllkKkJS563uthzcSGAwa7g1nGutPGrUkHFGVwFZ5y//N+310Tjg893WVofzc0GA7Xj+PntpzUTqhREEvlWwExi9Xm3+sDxmJEWBhcHaUxj6adlStVWxYu8UNvFkNk0MK5DoSQwr7HYmcaiNbYBe5OH8cnPOb5O6L+epZm41ROt44TDB+CarpxB00+m0lUOZkzo+zqJLqIjnK1s6Exgm5RYRt6tNWZLnebjG1014VT9NaIuwwmBBATARRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(38100700002)(8936002)(8676002)(5660300002)(26005)(7416002)(86362001)(83380400001)(186003)(41300700001)(2906002)(2616005)(36756003)(3450700001)(53546011)(6506007)(6486002)(54906003)(66476007)(66946007)(66556008)(110136005)(478600001)(4326008)(31686004)(6512007)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THF1Z2xlV29pQVd6TkpJZEZlcjE3alZPbnZ1YXhJeWQ2OG9BWjdWNitXeWl5?=
 =?utf-8?B?K3FxaC9ZNmhTcHJJeGQxeXovdm5lL0V4d3ZETWZkVUtrTTZaV21sTVVsdVN3?=
 =?utf-8?B?V3EyUmI4dUNFbm8zTXFxMmxNRXpKb2QzR1JzN09mM3RRWlJRNnJ4QlF5Tkti?=
 =?utf-8?B?TTB3OG5iMFBMdGNwOE1sWERBblFkMVROVDJLOFJTMVE2UURXUHppOXVzMFdr?=
 =?utf-8?B?SWt3R3pFVFdwZVEyUWh0dWhrTGFWS0ZGbFk4YW1CQ0pxV0R1RnphdkIvZ21l?=
 =?utf-8?B?L0M5UmlXUm9heGplbm5WVVdrcWF4VEFmTDZyaFJnTDdSaytTa29jTHkrWGls?=
 =?utf-8?B?RzNRMHl1S3ozSDVwYzMvQmx3dld2ZmRWcjJOMUkxaWNpMDJyRUdQM1pMTkdz?=
 =?utf-8?B?UUZ0MGQ0SE03RTlkTDBJVHY2Sk9QdFF4Q1MyZ2FyTXdlYStSVnp0Z3gwQkk0?=
 =?utf-8?B?SkV1ZU1CcDUzZTRXZjNRTGxOd1pNTlZsbHlwUjh0akpTVVNXa1dSMGFTclBy?=
 =?utf-8?B?WFpEamltTytwU0tqMWJzZmZzVFBsZldzR0NVM2Nycko5am9YaGM2MnJIQTly?=
 =?utf-8?B?enNUNENzdERZQ1Jaam9YN0tpQmJBcHFVWm9NVWVUV0ZPT21NQnNLSTlIZUJv?=
 =?utf-8?B?emN5cTBaNWJHN0RnU1BpcDNtOVkxaVJvTEwxenduOHhreXBxQSt0WjVmOFZk?=
 =?utf-8?B?TCtRbDdyRExxYjBYUWNKL3I2TmgyYmx2WnJXYmN5WWlGWUtXckF3bTdUMFIz?=
 =?utf-8?B?dDJxRiszNllDL21Lek9EeG55OVRTTmlVdW4ycTNWS0Z2cHY3b1lLZWIrZG5w?=
 =?utf-8?B?MDNTN3p1b1BQYi83Z2FSeTZTamRTRWNPMk9BaW1RMjZmVTI4dUpsTmdUUE5a?=
 =?utf-8?B?SUh4eTZCS2dPZzk1QjlnR205eWp0UHc5OGpmUjEydHordS91K3JsWk04VEpM?=
 =?utf-8?B?VmU5U1pwMUMwY0g5NWNOV1Iwanh6RnBvOTJBc3Iwb2ZHbVlSaUtKMWFMU3hK?=
 =?utf-8?B?TUEwak1aYkQrWC9aeUZUSXZjUmkyMWdKT3RtMDQzSDdIWmw1YkpCaEYwaXVL?=
 =?utf-8?B?dXRUL2xQeHlqSjRXc0FXZnF5VTZRQ1lmYlptV1VGSU1JWk40bVNkVm16Y1RS?=
 =?utf-8?B?NDJFVE9QWDhZMjV2U2tOSjdXQVExRzRxdEVZZzEvbWQzTTByQXFZSVpBK292?=
 =?utf-8?B?ckZacUsvWUFwYWhBa0JDQ0RWOExsN29haXNHVGNsWGszc1dZUXB0Yklqakts?=
 =?utf-8?B?YVF3eHNoL3QrdjNvbEdZbmxRMlFtOTJnNE9oVDJrcG53ejRwTS9rdXQ2UlV0?=
 =?utf-8?B?VXN2TzBvZVN6SEdhUnRsdkpzMEdra0EwUmhYaXZBOUkrZWpWdFdTNFhVWHRh?=
 =?utf-8?B?Zjc0OWozS2NrSWRRQVFzNFkwNnpvbFk1ZUR6Rmd1RVhLUENCdjBkek90aEFZ?=
 =?utf-8?B?Tks4RytKRUdjWkRDVmZvNVBvdW1tRCtaeFRUV084UksvcVJCb2xHdmQwUkZG?=
 =?utf-8?B?UTBFNnl5QWdjSmZxMnR4T3lOQVJjMllJamFtNHNKWlNCdmVzSG9Kd3JGemJV?=
 =?utf-8?B?TDl1V2lKcVAwNXNScFR2ZzZ4NnVabHJDSDlLTXN0NzRIVjUzRnJHVGprOXZ0?=
 =?utf-8?B?cnMxdEtUQS9xTERPY09MRnB6WHFvUFFrVXR6SElTU1VKVjFqdjFjaXhpODBk?=
 =?utf-8?B?dEVRTXZIOHUvWEtJN1oyMDVrY0JQTFFOVjNKQnBQaHZObm81VXJPdmNDUVdE?=
 =?utf-8?B?VFVPbFdOK2U2YUI3czJOMTRLRHFERUc0ajdtSkp3N1lyUTdRdWNWa3k0ZlBr?=
 =?utf-8?B?QUZuQUJPbE10cnZaTFAwOE11Z2ZTQlRnM2FidFNvVzV5bjdhdkV2QXkxQUpr?=
 =?utf-8?B?ZUVOdlBwNCtTcSs5eXYyY2RPMXMzWXF5Z0o5K1U0TjNrbi9zTHhLMEI2Ky9v?=
 =?utf-8?B?Z1crejQ4Sno2aldFN1FISy9KRXBKUUlvQ0pYblhXR0hLVnhKMUlzMkJSWlNX?=
 =?utf-8?B?REl3L25oNnZIZUFiZ2trL2QzYm4zaUU0ZEtUSktuK3pvMDVValBaNzdtNXg1?=
 =?utf-8?B?WlRqNEhsNXNJT3doNDZ4SHlkVGpNLy9sTGwrVnQ5YVl1TzJaNzFCcDYzSDN5?=
 =?utf-8?Q?ZHbM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba87b6b2-279b-4b9f-49d8-08db92e5f09e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:20:48.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2un1xu2e4iqBGzuYExHeAhbIvFNPziJ0HmraJD/3Mnjm758EXhvk+u3CC5gd6jaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60e;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Zhao,

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In fact, this unit tests APIC ID other than CPUID.

This is not clear.

The tests in test-x86-topo.c actually test the APIC ID combinations.
Rename to test-x86-topo.c to make its name more in line with its actual
content.

> Rename to test-x86-topo.c to make its name more in line with its
> actual content.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
>  * Rename test-x86-apicid.c to test-x86-topo.c. (Yanan)
> ---
>  MAINTAINERS                                      | 2 +-
>  tests/unit/meson.build                           | 4 ++--
>  tests/unit/{test-x86-cpuid.c => test-x86-topo.c} | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12e59b6b27de..51ba3d593e90 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1719,7 +1719,7 @@ F: include/hw/southbridge/ich9.h
>  F: include/hw/southbridge/piix.h
>  F: hw/isa/apm.c
>  F: include/hw/isa/apm.h
> -F: tests/unit/test-x86-cpuid.c
> +F: tests/unit/test-x86-topo.c
>  F: tests/qtest/test-x86-cpuid-compat.c
>  
>  PC Chipset
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 93977cc32d2b..39b5d0007c69 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -21,8 +21,8 @@ tests = {
>    'test-opts-visitor': [testqapi],
>    'test-visitor-serialization': [testqapi],
>    'test-bitmap': [],
> -  # all code tested by test-x86-cpuid is inside topology.h
> -  'test-x86-cpuid': [],
> +  # all code tested by test-x86-topo is inside topology.h
> +  'test-x86-topo': [],
>    'test-cutils': [],
>    'test-div128': [],
>    'test-shift128': [],
> diff --git a/tests/unit/test-x86-cpuid.c b/tests/unit/test-x86-topo.c
> similarity index 99%
> rename from tests/unit/test-x86-cpuid.c
> rename to tests/unit/test-x86-topo.c
> index bfabc0403a1a..2b104f86d7c2 100644
> --- a/tests/unit/test-x86-cpuid.c
> +++ b/tests/unit/test-x86-topo.c
> @@ -1,5 +1,5 @@
>  /*
> - *  Test code for x86 CPUID and Topology functions
> + *  Test code for x86 APIC ID and Topology functions
>   *
>   *  Copyright (c) 2012 Red Hat Inc.
>   *

-- 
Thanks
Babu Moger

