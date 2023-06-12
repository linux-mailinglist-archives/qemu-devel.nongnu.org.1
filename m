Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364672B4EF
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 02:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8VDf-0002HN-6q; Sun, 11 Jun 2023 20:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q8VDZ-0002Gc-Qp
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 20:15:35 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com
 ([40.107.223.83] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q8VDS-0002Gk-QX
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 20:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ6NxlDYaAi+jwQ0Dta4IHBgB6hel/v5Eb6maDW00ZWS8HRRyq+T/jhoveVScMIbYQySq5dxIslJA8U91uLy4qqpe6QcH1/DLCZ4khLk2iKKLByDyFL2tGtTo6YaCRI7UG/gQVJrJs7a3k3vBCPImptJUmeMHtplNxgLPte8X6vj5ZwdK9eaQT43oLu5IKCxKnUNnW8N6ZZSZtITPFkK5wUJUP3Li7jrP64q5myex8BUcX5mZOeHBEIftTRpv5aZT8LdiuMaQ7ck92sfI5DIJ3RhdmbM/Vs+TRsbnLKcgaHyQBaNRo/u/Lw4nxrB8SkJYfXL/1kO58k0jBWpNSHufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIsfn76GmFifvymiqnA607T+LI/GFqP1vhsTLWn7sfY=;
 b=KqPwJ5cqt2ibcJns3aYCTjuSv4I4wxqWF2BEKdaCbLNhje/h3XZLQIex7UuHSBsInyynbyXnBpWpSTiuqy5zbA0l0+KF8xvBvJJhVZUtN/scIenBeVeXQJL5kLA9jFe/k7lMCregcHGVYP12TsTW79ohDDKIukGrFPVfBU2oKLj0YrzD5xcOROYPIBHIxfN+5kyLhJC6OUBEC1ME1wE7hNOqySjdIS+qvYMUwDOYYu+nkCLLX8OOr6e3ZPyZvp+CXhpUZqUlNS9syv9/LbrPlyzVsSlU/hTFFw+6oWILpiNuaifOzEELaZj57UvcFeINJlChL9nBPwf8BWvxprKW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIsfn76GmFifvymiqnA607T+LI/GFqP1vhsTLWn7sfY=;
 b=bUK93PDyu3LLOhzpa0/DjuWA9xjXeFlOu3g1PRLrrX+TjSFA3vfzyBa6wZNtZ/Zhk7lUD2c+tSauwy9HsUN/YsirGzQO0e2AZRmfb9Lwc54sBFsMNaGsKxlrQl9MF3nKe30iSW0GTAQpmNiCMbrP1+ddJpZIzxIGe6FwcJilaL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 00:10:19 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 00:10:18 +0000
Message-ID: <6ad25146-0cd2-f58f-ada4-fd0a3f8a5b95@amd.com>
Date: Sun, 11 Jun 2023 17:10:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PULL v4 09/10] hw/arm: introduce xenpvh machine
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Stefano Stabellini <stefano.stabellini@amd.com>
References: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
 <20230609170751.4059054-9-sstabellini@kernel.org>
 <3925158f-cd95-781f-5f46-fe3f5d8326ab@linaro.org>
From: Vikram Garhwal <vikram.garhwal@amd.com>
In-Reply-To: <3925158f-cd95-781f-5f46-fe3f5d8326ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 930f5f8d-0181-4ad5-dd7b-08db6ad967e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eulZo8+PdSmdQQCHpWMrRSEcFZWsp2qZKFbo6gD9RB/7HcWa+UY+El0w3ZAR3m258wZH9hPne11/I4T9I/326qcAzD7385nwP8PtR87dVL2X0jnNiHsHsD/ewxNKhcd7cQnSl8Q17txTm1MwqKa7G8aoHO8auudLvgZxpMRulII9MxFIU1X6+IOWSzwx+yIEXzox9s2vU0JIZPHqCT0PzfwkY2F3RTUSWy537g8z41EluBC0x4rdFZ0akpA6ycTPYwPWyX453xvb9ioEBReagLENPeBb5SaDJDt7tZQsMxxwbUv9KgsKIHQbiss5OWoMGvA0G8w3BYJLF+olxI//73X58ZPU8P8FCOktagQ2DYeHR0GtQf/2eKxI2ROniioZcJc7x6hCrtWiSHD9XaPoda/m2E+zl8mjSkAsDlgpy7nms7uafQhSgboLruVOzZgwTpCTxDbAEGyKVf1c1ggao8HQIOLPNOcx4gOLtSIY2Q/bWRuVzjPHqC/dYFFZN3ieRTg6fGRuJPPFB2DzqQ6kb4vPu+hHJ8qN3CbB7k4bNEEaYz8ox7BfRkLPFUeeqjcJLlAXmzn4e7Jw2f493NdOJUr5iqFCuUFBMKOd0pNCFnKEGPAmMZVoFY66K3VikiugJp4RLPoQEv5p3yKPutvmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(2616005)(83380400001)(38100700002)(86362001)(31696002)(36756003)(478600001)(44832011)(110136005)(4326008)(6486002)(8936002)(8676002)(2906002)(5660300002)(66556008)(66946007)(66476007)(31686004)(41300700001)(316002)(53546011)(186003)(6506007)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFoNHp4cWV3d2FIOXEzcXdaaGp1cXJkcjR3UmpOZEphSTROWDJWTFNWN3Fk?=
 =?utf-8?B?bTU4MTdtK1JBOWR3WHUyL2pXVWdmWDI1Z1RrYUE3MWg4eDV4b0J2aXZsRkkz?=
 =?utf-8?B?b1NyYWl1QVFtN2tLeTcrQmZDWVV4YlhZejAvS0dTbWhOcm9rV2plN3Z4dFVD?=
 =?utf-8?B?TWFkd2pxdkNlbmdiUEJnTHJqU0VNeTZ5V1BmcHoydzFUTnNsRVFpZHBXL3Bn?=
 =?utf-8?B?S0xpOHY3amJWRlFWOHNKMTJsbSsrMndpdHg3OW96VHNMd1ZqWGRwL1BQcUE0?=
 =?utf-8?B?dlNRRTVVMmFCQUU2TEJaNnF2UE40NTRVOXRUTzAvTjhOa2ZjTmFaSFQ3a0pl?=
 =?utf-8?B?VTJEblQ4K1BHYVNWR2hxV3B2RlBac3BIMmtJZ3k1VVVMZTFubDVhZ1g4Qi8v?=
 =?utf-8?B?ZElDTnIvZDZ5eVFXNFF2cTFyV0Q3a1VtTWJvVWp2RDRTWE5obEgvVjdFa09l?=
 =?utf-8?B?b2dGYk5La3J1STdNL1NaY1hlZXdGK3RVdDNqTE1NN0pveE42T0x4VUQ2aXc0?=
 =?utf-8?B?ZmROMEw2ZDlyUkoyQmtUTE91dWlYWldoWjVVK2w2NG5Qa1NUMXlGdE1kVFJo?=
 =?utf-8?B?VEVQUXRCMS92TGF1SnVYWkVha2VEa1lhblJ2YU9WTW1ielBGU2NKdllMYTVr?=
 =?utf-8?B?TVFPU0xiU1c4THdhRThyMFluUmorSHd1VU9nRkl5Ny9lUTdlRlZ2RitPMXht?=
 =?utf-8?B?dDhoOWJTa0lRRzRackwvUEZnbXZvZVBWSU5keWxSQ1JuY2wwUFdEM0xVaXBx?=
 =?utf-8?B?L3RTTUZTdW4vMmVmaWNqTjRMWHhPeE1MT3gxcVNWVk1NemhaMXVkMXdFQjRW?=
 =?utf-8?B?QlF1UVZPRGZieWQ0cGxUajdPSm9lVzRKeGVmUkZnSXRTN0hacTd4amdkU1VL?=
 =?utf-8?B?b2UwMmY1R3ZQeE1xL0RUTkxZTGtiRE9XOTNwRHpoV1FpOGdaR2p2clh0WGtl?=
 =?utf-8?B?YTBOdVdmTmxCdzlrMkxqQ3l3OUxpdWhPZHdlbGdqTkZaSkRWMWF2aGR1Njk1?=
 =?utf-8?B?UkZSaGxrQkJGaEgzbTA1WGRadVlYMGpsWjdqSnBmV3RVL2VYbTBac0g2dkhX?=
 =?utf-8?B?S0RoekVodDZwUDZQcDd3WlFMTVlqY29aUFBKVzM3TmY1ZVNEQUM5RkJzTkUw?=
 =?utf-8?B?VkZvWnFLZnpyZjZsK1E2RXYzb1FvN2RKSitSUzUrWDZYckY2MEZsY1o1eDZU?=
 =?utf-8?B?VGhYVjVzck9PMFNPamJWcS9qYklGVGlEK2ZoSUE4akhGbmREc1E4UGp5bzFl?=
 =?utf-8?B?MlBJV2dBcWQ3b29PTDZvWjh2NzZEck10aFpEbnpGR2lWTWh0MUZnL3cyTllK?=
 =?utf-8?B?MWpNUkhXMjYvRGlXSGtGRXVWQm5ia2o0TjE4ZUNYYklwcjRBenZteUNPWm5j?=
 =?utf-8?B?VkhSODkvSmhPZVhSWVd5Y2dxSkVNRG52azF3dXlkUWlQbkZtSlJQdlpsY2tU?=
 =?utf-8?B?ZDByUGgxbjFZR1cyM2xISkFJQWpRZW9WRHE4YzNWNVUzR25ncmROcmtOMFpP?=
 =?utf-8?B?eWVkelJVazNLajc2TjdBQ1dsNWpLdG8xUVlodDVDT0dVVEZXMTM3bmN5L3di?=
 =?utf-8?B?NDFEZzY5cE1NL25ZMUZRR2VsNzlJZEFMVHlJazZla3Z4S01McGZYVnZTRTF1?=
 =?utf-8?B?QjVwZTVFOWNrQjV4Y3pkRHRWcVJnb0Q4RXBSVlVQNHA4Tms2bXUwMUpTenpu?=
 =?utf-8?B?R0hMTUNlN09adjY4eFFOdjdMZENXWklFbVQ0THBtRzVBNXhYRDJPdk9JV0FE?=
 =?utf-8?B?RExXSiszeisyRnd2Z0VsbDBjcnp3K1hxb1R4V3gzVTg4QlZGTkNqRGNTWGs3?=
 =?utf-8?B?SDFlWVNFSTF2clg0VmtyanBLdllnWFdDMnkyeWl1Q2x0ZVpjNllvSXJ6d1Qx?=
 =?utf-8?B?cGtKb0ttbklmYnJqTkd5RVE0WG9CYkNpSjFXZHBLQXJGUDFiWG0xZXozVGp3?=
 =?utf-8?B?dEpDWWNLcSsrM0lTZXFiV2pNL29YcndQdXZGa3hGcmNJTzFVa1ZsSFMyQ0hr?=
 =?utf-8?B?eHRuSmNEOTN6UVBrTEpidU4rTG5DWFRUUUgzUExvNzNCWDdOT0hORVcxYVl0?=
 =?utf-8?B?Z2V0Ly9NZEdqNU43V2hxZnBNNGlPVUZtM2s2ODVyMHg4alBpTmMvUDlnT0hT?=
 =?utf-8?Q?xfb9eYaJVG+BhRCl1o2hTUSPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930f5f8d-0181-4ad5-dd7b-08db6ad967e6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 00:10:18.7787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWirLq3o8AJx28p4H68OY2rN7Jyz5SnpgoCIpOlwhbC7EWFChx2tpiXESzjSQ6t0A+4clK7vPfC+DROGE1Oqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
Received-SPF: softfail client-ip=40.107.223.83;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

Hi Richard,

On 6/9/23 3:59 PM, Richard Henderson wrote:
> On 6/9/23 10:07, Stefano Stabellini wrote:
>> From: Vikram Garhwal<vikram.garhwal@amd.com>
>>
>> Add a new machine xenpvh which creates a IOREQ server to 
>> register/connect with
>> Xen Hypervisor.
>>
>> Optional: When CONFIG_TPM is enabled, it also creates a 
>> tpm-tis-device, adds a
>> TPM emulator and connects to swtpm running on host machine via 
>> chardev socket
>> and support TPM functionalities for a guest domain.
>>
>> Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
>>      -chardev socket,id=chrtpm,path=/tmp/myvtpm2/swtpm-sock \
>>      -tpmdev emulator,id=tpm0,chardev=chrtpm \
>>      -machine tpm-base-addr=0x0c000000 \
>>
>> swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built on 
>> libtpms and
>> provides access to TPM functionality over socket, chardev and CUSE 
>> interface.
>> Github repo:https://github.com/stefanberger/swtpm
>> Example for starting swtpm on host machine:
>>      mkdir /tmp/vtpm2
>>      swtpm socket --tpmstate dir=/tmp/vtpm2 \
>>      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
>>
>> Signed-off-by: Vikram Garhwal<vikram.garhwal@amd.com>
>> Signed-off-by: Stefano Stabellini<stefano.stabellini@amd.com>
>> Reviewed-by: Stefano Stabellini<sstabellini@kernel.org>
>> ---
>>   docs/system/arm/xenpvh.rst    |  34 +++++++
>>   docs/system/target-arm.rst    |   1 +
>>   hw/arm/meson.build            |   2 +
>>   hw/arm/xen_arm.c              | 181 ++++++++++++++++++++++++++++++++++
>>   include/hw/arm/xen_arch_hvm.h |   9 ++
>>   include/hw/xen/arch_hvm.h     |   2 +
>>   6 files changed, 229 insertions(+)
>>   create mode 100644 docs/system/arm/xenpvh.rst
>>   create mode 100644 hw/arm/xen_arm.c
>>   create mode 100644 include/hw/arm/xen_arch_hvm.h
>
> Fails testing.
>
> Summary of Failures:
>  10/423 qemu:qtest+qtest-aarch64 / 
> qtest-aarch64/test-hmp                  ERROR 161.45s   killed by 
> signal 6 SIGABRT
> 210/423 qemu:qtest+qtest-aarch64 / 
> qtest-aarch64/qom-test                  ERROR 327.56s   killed by 
> signal 6 SIGABRT
>
> # starting QEMU: exec ./qemu-system-aarch64 -qtest 
> unix:/tmp/qtest-669817.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-669817.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -machine xenpvh -accel qtest
> qemu-system-aarch64: The -accel and "-machine accel=" options are 
> incompatible
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:../src/tests/qtest/libqtest.c:474:qtest_init_without_qmp_handshake: 
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> Bail out! 
> ERROR:../src/tests/qtest/libqtest.c:474:qtest_init_without_qmp_handshake: 
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> ../src/tests/qtest/libqtest.c:186: kill_qemu() tried to terminate QEMU 
> process but encountered exit status 1 (expected 0)
>
>
Found the fix. QTest adds 'accel = qtest' and xen machines already have 
"accel = xen" option by default. Adding this xenpvh machine to skip 
fixed the issue, other xen machines are already in skip list. I am 
running the gitlab-ci locally to see if there are other fails/

i checked your pipeline and can see there are other failure but 
unrelated to Xen. To make sure, are there any others failures related to 
my patches?

Also, I am not an expert on gitlab ci flow. What i do to run gitlab-ci 
is this: Create a new gitlab pipeline with QEMU_CI = 2 and this runs 
around 120+ jobs. Is this enough or there any other variable setting needed?

Regards,
Vikram
> r~


