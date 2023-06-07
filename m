Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC3725180
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 03:25:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6huP-0001BS-40; Tue, 06 Jun 2023 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6huM-0001Ae-4U
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:24:18 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com
 ([40.107.93.81] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6huJ-0003YE-Um
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQSVkL6rY57OavwTXNjZVhwL65G8YuQh/sHj7FyBoft3T89WkaLxwpLm06QpzxPNAje67wCaeLQK7zs0LLR+2w/QWJa+fYmaxUxo1bSbKiTD9/SwM4J1TAAn6wXlxFkutmLs9TZa10LzV5aoLj6E5IHjDITuDPlDoJOlKVcndz96yghnuXPyJy1TiA0YK4HFs2V8UeBQSyElyBVmDxpsMQXrk90tJ6ZibvAUKX7DFYkhjG2Ao/uDjtapj4FHIfs5sJ+CO+hMx31YQjKKKybrF0FRTBJtTozdc7nJ/3cdKSC+zrfN23qd0YivnqaBYfTWNB8YGXzj/7ADE+Wvv9nuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo1RRLOY8wJG9p3+zCXqnzr/3CceI/Kl/pDho/xTQSU=;
 b=B9JIPJdvmkFVkt48u9Q0plEbMyGOrH3SXS2HyxlQcbeX4IH0JUAmSFBYN6AyXHLk5bzUb5VYTiUxuCds+oIWC9VetoH0E3KKk0Z4ZPXBtvBL81AX6vfLpDRSA3V5MIZwoZr1jRM93/I8Ve7frc6HVOexy5vZ7QWuiYaJCDUlJ5bmyTzRzMQHKOA91+VOeQLomr491WXM60YUOfyPdK43eOsfRGUjiTonzyN/RxEpLMeTiDT5Jo3XXIlRKURkFvwzgZtCMZGJxMOtCzB3jL7p0erhtzEhSc6NVym6N3AewQHQGuCFEdO+laYGwNH9Jn6tWhyjrDQe/d9k3IQwENHVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo1RRLOY8wJG9p3+zCXqnzr/3CceI/Kl/pDho/xTQSU=;
 b=oc7jmdU3bMsGpZYbZLmMy7o3qNWUM8NCoSKn8wVVTipkwmhkwArGZiEEO1pv1j9vl3M1zbv4GqAdVnGT1tSiUpTfWygB1Ge3R4GSKQm8mNnlGDrSurA8CIIdBdHani2aB97XYB3r3gH6BkmisRc3FW8JpLh3NPdbPVlEim+9XZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 01:19:10 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 01:19:10 +0000
Message-ID: <6e9cba46-83b8-5cb6-dc86-14086b19cd97@amd.com>
Date: Tue, 6 Jun 2023 18:19:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/3] pc: q35: Bump max_cpus to 1024
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-4-suravee.suthikulpanit@amd.com>
 <20230606095502.49e9e697@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230606095502.49e9e697@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 16269a65-9a4b-403b-383c-08db66f5325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUrv/1/YwE31WOwfA/NeAjm+Bu9CW8A3vVYCeXbLMqWLqaHvppM18ETl7sWf9jnJ+uuuXtRyt1AoGxcr9NH+/rczzLFqzsg2MO/GWI5D1IFDKBtJgitkjaIJIEzNZnbfPpEWcpYHuPLdbub2GKm/qyllGZPkW6dGDzgcGf8ePIBxNqMa5HkCOEaTVfjrn9rj5Q/VfMUznRnXhSiNq5CwIfWCMJdXtG5AAg66bZJqhiDViSw17S61sWrxPqWUv2vlReig+4LRXxxbUF3P+SoGEhPe+5XXIzxHfHrbAGe8bqR71PhULtmT9wVzlwz3Y9DM5/M/VSiWS2aeLDdUZ3ImJGUU1KQ7LhOe5gRwBcrcrTqd7ZGgnHlWyio/ENLyZChdSgKNUUKdpV4lrmmiMel8f0DUKHXR+oFgTLL+i6YfDYzc81YWr+uqAyZVtE8HQQBA0jn0JGHeJMrQ68IYG7+eNruVWHAOOs8Ji4NJFxSuMo2GMBe8wuLhIX+Dp2bThEOmokzcAQqw6hvHrPmb/EXeG0+9vS6qZrOX9Ll70MI1pgFyRO1gqYxhUeqKcqbzC480Uz/tsDRkIW1WkFFW1FLP1joXk31uBOLAnitd/vh86vSV7rb74tNhKjlV9oOVlSqbT6kpsA4otCllXmZnvo3J8fhS9U3mSIwyJnyX9C4HI7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8936002)(8676002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZFR2xhRW1GTWU5TXh5L1lZelNuUWZIdy8yREpWQTR3Q0RXY3Q4ZjZGbDFr?=
 =?utf-8?B?Z0R5UndnY0MvajdneXBtWVQ0TE5lcnBITVdxN2QwYjREa1UyV0xBY0lqYW9J?=
 =?utf-8?B?SU9heEpRbm15UFNmL3MrZWIzZE0wK1M4RXAzYitsVno3ejVNRkszZm9iOUVW?=
 =?utf-8?B?bGhScTdTc0VrUDVkVEtTem1LWHVMV2pMZWpCMkZGSmE0MTI1KzNRbDJqMjVr?=
 =?utf-8?B?SE1CMHhCd0lEd3Q1Nmt2eWxOUEZhTkdMSzM2R0hrdmRuVklqZFZRbkFodWQ0?=
 =?utf-8?B?enFEQmZrdENNUWZTRzZpNExqMXFVSER1Y3lXT3dmMloxTTFZeEFQTC9ic2ZC?=
 =?utf-8?B?L0RZRzVjQ25zNU9SWWFrMW9NTTdRRnlkR1BxTmV4Z0daM3B4aFEvMm9FWGlq?=
 =?utf-8?B?YVdmemJBTGQ3RXIvdDVwLzRNcDJnV1pHdWZPZnZYWE44ejZGS2NIcGFwZ2ly?=
 =?utf-8?B?b3daRGRscENvL05jQi96M2piRzVsNE5SbW5VeFpxV3hDZFJMcitaaENpOGZX?=
 =?utf-8?B?RVFOUnlEQWdmS3I3NkZ4bG9GMTRKUStnajQ1SFQzbG4zdGRqeUlFMW1JK0pV?=
 =?utf-8?B?enlsVFhmaHNXNTk1K0lvQWNaRnEzQjNBSUlaYmxBVmRMenJaNk1XYzBmU2dX?=
 =?utf-8?B?MlJReFY3US9IajFtYWNYTkNkU1RBclRaSC9nRnJ0VDFHc1Mwc0E2RGdPaGp4?=
 =?utf-8?B?L25zK3RHQzhEeTlVOWpZKzRqTDZSTDZmUVFJNm8vM0VmTHVUenc5UWQ5T2t0?=
 =?utf-8?B?QXlaaG90b3pUbWs4SEY1bVVkTW13eCtsZ3JIdkJ1dktEYlRuZFJFOUxOZGJN?=
 =?utf-8?B?RGN4eHQrdmw3aDBoZDZiT20wZnVCWnZod2ZMUkRoUzdzM1hwTzF4NURFUzVS?=
 =?utf-8?B?NzNhN3VPdHY3N1NaUUlkOWRyOERTWk1wRHZ6V0JiaGRDS1RQNEhTQlJDbytY?=
 =?utf-8?B?a3FoSHVQNkt5VFhUZlpkUzFSdjl3cTE5ZktZRHNJZXJrRW1ZZDkyQklwUGVo?=
 =?utf-8?B?VDRCY0RiUTB2QjFJTWpzREdyU2NmUzdkTnBIdFVoLzdCUUZKcUM1MzNtNGNP?=
 =?utf-8?B?UVdYaW5KbVkrN0xOKzlsUmJUanJTOGt1Ui92UDczTzFlMmI0ODZEY2hvYTVn?=
 =?utf-8?B?enNvMktwQTZaakE4aXF3TmlkMVc0OVpPblJTV3h6Wk5uSnAxS0JRWFdCNlJQ?=
 =?utf-8?B?WmNmQktxWWZtS2ZiZlUxd1JNb2ZubnZZRkxGMTd5WmF5R3cvUmpscTYvOVlV?=
 =?utf-8?B?UHZsMUo1TXg2NTAwb1FqVWtxWTc5c3g3MVBvQXZ4UnlwL0Y1VmdKZ1NsV3Z6?=
 =?utf-8?B?TGxtbWkvM2xSV2I5cTlrQnlNQ3d3bVc5MVBuNlhzaWRKYlVJRi9VdnczRXZE?=
 =?utf-8?B?ZFdVZ21jZWRtZlV4blZnYm9TTjAzeEpteDNhSi83QVhtQU1jSVRmMytZT0Jj?=
 =?utf-8?B?UTVPeVIvK2NwSFBrdU16WUphY0FFTkpvRDBJUEVjNkJQSFZCTm1jS012Tk9s?=
 =?utf-8?B?MThkMTJ3dnU2bFA0VTV2Y20wWnRNUDMwYVJwTFdqNFA2Rng3dDE3MXo5V3k3?=
 =?utf-8?B?RHRnaDg1R0JnTlBib0dZSE9Zbi9rbkZUWkxWaVY4dURaTmVvRHJHTXdIWTk3?=
 =?utf-8?B?ZTlieUpBRzJ1NXI3dnlyaW5WeWxmVFpZVmpJcStOcTFrVTg0U0QwcUNkbzhG?=
 =?utf-8?B?RmpiQW50VjhPT3g3akkzelRjQ0Z3UHRINFRtUmhBaExGL0xSYTY2V3VLS3NY?=
 =?utf-8?B?dU9ib2tnWWFMOGNBTGlBbGJoVzNWOW93KzJSL3RTYmlkc3ZBR01oWSt0dHAz?=
 =?utf-8?B?WWFJUW1XdmtRTEpGUVJGMjYyazlSbU15SlNsa05BWFlsZ1hiS2dHL1ZmNVFF?=
 =?utf-8?B?Rnk3d2VCRU9nYTJTa1lWd094b25DTWdsUWdiQWhaVkduelBsdGpVY2NlRkk0?=
 =?utf-8?B?RW0yUWdiQSsrcW12aXF5QWtPUXpHTy9sV2R3aGVzWExMUnR6emZUQVJIV3l1?=
 =?utf-8?B?YVdZazhjL1hHdk9rLzFkUkY1ejIzMG9qSXcwY0FmaXZvMEhRR2JDV2NVSGlo?=
 =?utf-8?B?dVFPWVkvMWV5azdxTTh5aXd2MHpHVFhJYjhwNmdXU0sxR1hkbDBlUUNJUGth?=
 =?utf-8?Q?qSun1OLQgRBeJ/BgWE+8V3rQy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16269a65-9a4b-403b-383c-08db66f5325a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 01:19:10.2548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzdI6vALVw5osfLyk8YVX13LAA/ug/WEt2zAUo4gJRdpEKXXSfoTVXgiRaS8uLAJpjoXlg01hQRoF+r0M+LFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
Received-SPF: softfail client-ip=40.107.93.81;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

Igor,

On 6/6/2023 2:55 PM, Igor Mammedov wrote:
> On Mon, 5 Jun 2023 16:39:06 -0500
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
>> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
>>
>> In case KVM could not support the specified number of vcpus, QEMU would
>> return the following error message:
>>
>>    qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
>>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Daniel P. Berrangé <berrange@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Julia Suvorova <jusual@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   hw/i386/pc_q35.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 371cca7484..bd862add94 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -365,7 +365,7 @@ static void pc_q35_machine_options(MachineClass *m)
>>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
>>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>> -    m->max_cpus = 288;
>> +    m->max_cpus = 1024;
> 
> did you forgot to preserve value for older machine types?
> use commit 00d0f9fd6602a2 as reference

Thanks for suggestion. I'll fix this in v5.

Suravee

>>   }
>>
>>   static void pc_q35_8_1_machine_options(MachineClass *m)
> 

