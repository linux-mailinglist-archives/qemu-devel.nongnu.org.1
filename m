Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF460748BF2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 20:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH7JR-0006vl-Ds; Wed, 05 Jul 2023 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qH7JJ-0006vU-G0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:33:05 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com
 ([40.107.220.42] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qH7JH-0004lI-AZ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHLLKjU2H3kQwviUlU650mu/Z4/a4NewDWwpRI6lvEiM+nPJmDgilzHKb2Fh0o7ZkZPK5lWtShcUtyalfYdiMB3S0CumF2LZXRMRZxDwqAAS8xWGC821kt0WaAPembWCl0KlRMev5+5RH/BHUUmJ8yt5MBvVZ8NsQ0xuaw4IJR/LT9V4llGQO8g6URKGKaGCUXKEifhY3RWB6Kk2VKx6GdhCL/l4Q4M19u96hcOoeDJevgfbzUCaYGKzWYibaHJdiTVf30lCfZLCwV2TrbQdBwUjHdC0m/NKJQQsV/s0qFt5HpLxPxA72+ieobSiIrCgpy2T02RF53SA0fUnUiXyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm3cCinPBy1WmkuFaQLCmtQcl5JvjiPa5nZOgOKbmCA=;
 b=Q8oRuc6imz22Gg8w4h7KtVN8O4zzQ2U1QfydqI/sXczP418QDRAK4c0oyIpFJ3YXbuKxyaXaxNcvt73GrvLEnZ+UyAfEghUx6/J6GUtKheyEYBs8TH6NLeSwBCLw1BSy/lhCI0dGYOyXlShF64TgST6sa9iaXh7gNqNut1r2Fk029k7q2Nd5BpQkyou+uENcKyO8ai4NQfo2T4xPk36enFf+mKCEMnhMbP7wS6OJhZW85RRnJVRniH/mFG6hgTSAOgwdm2vSvcKk/WrbvSlXQlgYDTInsXUwuraNKQ5hw9bvOX/1KlRk5GrCzlOqJQ3fKAJWvYYAI44xl8vUzMiVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm3cCinPBy1WmkuFaQLCmtQcl5JvjiPa5nZOgOKbmCA=;
 b=RUCPM6VpY3OxXvEYunfYC6nK0T1hMYhqUa+OWsoikwu1NOXtq2o+WhJ5Oo8Qk4mt6iRapvNvAWYNS2ZPM+kEXcq2TbLnZfiJuB/WgJ7ANU4T8cTV/SoigcSJljYC/otxpTmeYn9mRbg8x0kigR/qOEcHYIGM/jfN/tVs9gcgP0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:27:55 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 18:27:55 +0000
Message-ID: <88543f52-e764-8b84-48a2-3fbdf0ac0cff@amd.com>
Date: Wed, 5 Jul 2023 11:27:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Content-Language: en-US
To: Leo Yan <leo.yan@linaro.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org
References: <20230629174310.14434-3-vikram.garhwal@amd.com>
 <20230703061445.GA1606549@leoy-yangtze.lan>
From: Vikram Garhwal <vikram.garhwal@amd.com>
In-Reply-To: <20230703061445.GA1606549@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 865046bb-590b-4ebb-1cba-08db7d858cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BUZcycEw25TbrMTZF5ecYZrCFwl9BZyKf1dQx8iwyxic2pvYCk0iEnGELZjZ6SeuJGx45nRXvazv+XI+jb3l3BiKnp7mDduUqW0YCoaVZ7bzdo1AODsqBS+C6VFDEvm7QJIgM8oScKCGDP6QRKYujBW/5oF9ahy1r1t32JmyGHF8d/Mdx6j6Wl6F06jnm92b7KIq0nRX6FL27iXpy3y6Y9lIXrZcfqZPg/i/0ysCM2y7yt4QIcSoxt0eD0etYeOZ1938Qt3UWBVV9frCiTO+Qdpi2XCR+KXploVBGos36H48GzCjG6rEbHqls14Q3IizwJaF/M+UpAls9oppHRrxZmRtVDHhNYcNgvldc0KAvAnFdAD+wdkpkKvXieSjlhpStksxxjqbxq22LEkALsEBf8j60YQB8AmHPC/XfCTLYwBdNOjGNJ4+F7mOSYpOM1dlY+r3H8WZs3piDKXkf1sZmB3y44Jx0UHroTd+/gVXALkyLTTfCSf+3k98yiADa4gte9h56GlZI3VrzjKD3fYeKnxkHCpSWl6IPKQdV/NXGPTGcS82ZUYZNYSNN822nqLQ6elqmTx3x+43sO1C25gB58nqTqRAVm0EgSaVzhsG+j6ie4M6zzDzQgnRIGuAX90ZbSaBoYU8FLT6JjA3mYh/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2616005)(31696002)(86362001)(36756003)(44832011)(41300700001)(8676002)(31686004)(8936002)(5660300002)(2906002)(110136005)(316002)(66946007)(66476007)(66556008)(6486002)(478600001)(6666004)(4326008)(6506007)(53546011)(26005)(6512007)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wno3blp3eG9ocU1NN1BHdmFXYXJvRUd1QVBOSFUwZ3NxQW5IZjdkdEtIdXNE?=
 =?utf-8?B?anh1bnpVNDVWRzIxVlphLzFqYjU0NmZHb3FIdFRWMFppRnJJdzM5ZGZYbnRN?=
 =?utf-8?B?K0tMdFRjMHd4Uk1paUllcXdSZG0wbHR0M2JvYi9GRGVVTEhLdW9yaHZFN3kv?=
 =?utf-8?B?emFRejFxajVTMXArK0VsaGNpS1hZd20vb0NGRGM2OUg0Q3BXUklaajdwazJz?=
 =?utf-8?B?cHVXSXdCTEpNYTRUbHVSUlR6cGxOclNKQnlhZlkvaml1aGdnSmFQbXpFUjdv?=
 =?utf-8?B?c004aVNHNEtxRnk5bWpUS3drbFg1VzUwQUMxdTh6QWdpbG93SmpGK2dPUjB3?=
 =?utf-8?B?OWxKUXp2OGsyczBHLzhrRjA5OHJPZjNjWVhYaEwxNmJYT0tibWJIRDVPcVF0?=
 =?utf-8?B?WUJvb3lvSjVjcE1qRVpvQU9ORUxkaVlCWlBOUE9oMGMzOVgvQmR6dnJzOER0?=
 =?utf-8?B?TFlnNVlpbEhyeCthY2RJN0szd0dWek9yY1ppTWVxQlpzWC80ZmFiMkIyQ00z?=
 =?utf-8?B?cXFlaGg0OUozU2ROWCtHNVVaL0YrZkcxQWxydVRrOVMzclZNWXZMbWZXUVJD?=
 =?utf-8?B?SWovakxxQWswYmpuQUk2WE1meXRFU1I2RjRGTURmalpsRWtZRkJBdHRuQ1BB?=
 =?utf-8?B?NVdXamdLOVRQV2wvN0FNM2d5T3pBSW5NTVpSbGt6Z3VTYjBTOFpCc1N1THVV?=
 =?utf-8?B?UURSTWg3UUQzQlBQODVPWE1iTzRLYmRKeHlaRTU4WjFHYk8wbDlMK29sQkJn?=
 =?utf-8?B?L0xRRkJHTkMrL3hEelpySE9ZMWlBNlVKeHY3Zi80OHJkM1lyTlBWd1JQZ0VM?=
 =?utf-8?B?cHRMbXNETm5hNU5GbUxIYStpOWEySWhrWXg2RlV2QWlDWUd4MHdReDNubk9V?=
 =?utf-8?B?ellRVVNvb1NLVytwd2JoMlg0bXNqWTNCbEFkV0pOb1JaL1FqSVdtQ2hCamoy?=
 =?utf-8?B?MXJmUFh4MERadmtJQUc4cVYvMnBKaFdOZzh3N1U3a3NGbWtRSDJiYU9xQ1J4?=
 =?utf-8?B?ZEVBUmJKQ000ekdGYzA2Ti8vb09kR2NLU2l2VzNQOHZBS0R6RjE0aGR3ckpy?=
 =?utf-8?B?NmNWSERhb0YwaTE1SlVYWU05UmxCamxtTnpPb2hYc2NiQWRtWTFVM21FRWp2?=
 =?utf-8?B?QUdOUmN1TS9ONzBwaFQweFlhc0tJTFhkWlF5UE85NVpzYkFJSzRDT0dmTXpZ?=
 =?utf-8?B?WjJKQUxKcTB4R01kRW02U0RMMWg2MktKTlZvT1ZJR0ZTVnk4bnlyWGdNc09q?=
 =?utf-8?B?Y2dMQlZFUkQzY1MxR1JobnZqdEZUZzJDUldEWTNicWp6WXd2V0tyNHJ0TDYr?=
 =?utf-8?B?eTh4aU5HNWFoaTdCT3JIY1VpMnhOcFdwZ2pZdC8xVGV4azZXbDkvWHM5N2t6?=
 =?utf-8?B?VTNEc1lMWEZtMFUyaGpwTjF5R0NDUG9yaUp0SUVGNVZ3em83SWc5QUd6UmlS?=
 =?utf-8?B?RFpDOXFoQzNrYkpGTlpqK3Z1NnhLakNQeVJJemxDY0o4Q1pGb0w4RmQyaURs?=
 =?utf-8?B?cHkra3FJMkJvaUpRQVNMZ3VRaTdNTUprQ012L0twVWJrZW93T3o2TkNlUXBQ?=
 =?utf-8?B?RXdQWXh5T3Q1NFdJOXpoUXh5ZFFieVNWV2wrcWpxYVNySy9GYU1nRE5QYXgy?=
 =?utf-8?B?NFl5VEZZd0RaZFBwNjZPUExTYTVJZW1nT3FaRjZCOTR0c04rbjFhRE02UG42?=
 =?utf-8?B?TVU3bmI3NDBCZ0hmbVFTcnRtZWRnQkVxVnJlbldBL05wTnZvcHhRMTFGek1p?=
 =?utf-8?B?cWVycDdpelJ0ektHemZNd0x6bGU0bW13VFdNNFZjeS9SMlQ4VS9XRjc1cjlK?=
 =?utf-8?B?Q3oxM0kvSkw4UDhsYkVtNEhIVEVsSGxmM2hBSnpQQUJDTUlWWWJWbk1hQ3Vn?=
 =?utf-8?B?TnMrMWVlL1RxdU5wb3hKRG8vTVFRRVdEVy92UnR2azQvQmd2bTA0Z3ZzQ2Zy?=
 =?utf-8?B?NFErYzlCandrMzRXVHJBMEs4NjFFT0RHZ1ZubksxSDQ2alRHaHlIWFBOdHdH?=
 =?utf-8?B?T2svM1IrWGhmdXBvaVlkS2JHZmFCdk14TVVURWZTb3h6WXkzdTdGTDV5ZTF4?=
 =?utf-8?B?WmRPQTBLeUNmRktiQWZLdTJKczVWUlZjL1RFT3FJbmp6SEVqWE1kandOM01s?=
 =?utf-8?Q?A8DVVnw0pGdU75hpLLnnp7slq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865046bb-590b-4ebb-1cba-08db7d858cd5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:27:55.1491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8/ZUa82JCaeEMckTAmAoxgyRsmysp5+zP7R/j5ntgrJWyCMVPmE7n8oaYiHrO4a8Tk4kh7SOnpcKNYZYjiYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
Received-SPF: softfail client-ip=40.107.220.42;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

HI Leo,

On 7/2/23 11:14 PM, Leo Yan wrote:
> Hi Vikram,
>
> On Thu, Jun 29, 2023 at 10:43:10AM -0700, Oleksandr Tyshchenko wrote:
>
> [...]
>
>>   void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
>>   {
>>       hw_error("Invalid ioreq type 0x%x\n", req->type);
>> @@ -135,6 +170,14 @@ static void xen_arm_init(MachineState *machine)
>>   
>>       xam->state =  g_new0(XenIOState, 1);
>>   
>> +    if (machine->ram_size == 0) {
>> +        DPRINTF("ram_size not specified. QEMU machine will be started without"
>> +                " TPM, IOREQ and Virtio-MMIO backends\n");
>> +        return;
>> +    }
>> +
>> +    xen_init_ram(machine);
>> +
>>       xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
>>   
>>       xen_create_virtio_mmio_devices(xam);
>> @@ -182,6 +225,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>>       mc->init = xen_arm_init;
>>       mc->max_cpus = 1;
>>       mc->default_machine_opts = "accel=xen";
>> +    /* Set explicitly here to make sure that real ram_size is passed */
>> +    mc->default_ram_size = 0;
> This patch fails to apply on my side on QEMU 8.0.0.
>
>>       printf("CHECK for NEW BUILD\n");
> The printf sentence is introduced unexpectly, right?
I will rebase it with latest and resend v2.
Thank you!
>
> Thanks,
> Leo
>
>>   #ifdef CONFIG_TPM
>> -- 
>> 2.25.1


