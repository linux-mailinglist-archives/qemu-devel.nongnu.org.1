Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96015770552
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRx7W-0000UZ-Op; Fri, 04 Aug 2023 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRx7U-0000UQ-VT
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:53:40 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com
 ([40.107.243.63] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRx7R-00035J-CI
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNRkpTdQdfSVda6k8Grat1TmKqpBrEegIOFV13+k4ap7pVFBWtlZ2WWGt+epQTAHDIE7deFn1QttOSDoY3aag5o+e+xuc7xHiFQlcGEz++b0QnCb0vnAl8GamTYmGrCh6G1qehLtWaqlaMY416BLQ/6E6ys2vXCLmVmNFYcaIs7jztWhtRkvk0FbE8vF1PbIA/pywqb5m0dZpHwdxQ67VUe0jAtUqLx9DfKsbc6NjsUoH9+TBuZ3HDn27TmNFOh7aIR6M1RPSTjNP+/7xFLEc0caAxveZOv/vZ9hnW6OmFfrtTM2dC4dsuBxbk8N8vK09Kc7DMfn0g7wcBbY8/FLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIi7h3dVb+gdVTNG7ty0vj7WBDXADTiZeSj9k6OX7xQ=;
 b=FGx6X8BSSJdmWEnGrXgovuHozC9xnNMNR8jQzcEt4WLUN6w/x/TIHdOWIJYzRnslSfKr4wpki7/f1vdu8ThQr/l1wQ/VbdwH0M7pbPriQgtXpQS/zDyKIm0FYcmRRv4o7Y6JqdOx18rWEgCKuR8TwXwP5t0RJPEvohCeEgnePJqWPy6Zco+/HtXqSQBmALXC2sZbpM/EKl0lPvkpz9Cr/QDBAhegQqumhSmsw8FrgCKPob25d0zvueCXqbVMEG8ex6PCPwlpB9/bE/GbRK548cdzlUBzB9dGp+d0c0329PgKZlJ7exjCQXrYK02dR23HGRto3mYMnEwcIxONjgYo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIi7h3dVb+gdVTNG7ty0vj7WBDXADTiZeSj9k6OX7xQ=;
 b=JE1aiRNJpL6EeQVKUU9H1wommHWx6IdahHzHodgo3cjYZ6pqs03OHTOnlXQOCFNqO0GvsfRBr7ZEoIdWTfcmeXZP7IHwbn2zhlwcZn9JL1BK6rIsrBU0K0RADix3srP8fg3GAteWr0je+1bkC0CueiPVOrX8xemr/e6GLCgG2Ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Fri, 4 Aug
 2023 15:48:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 15:48:31 +0000
Message-ID: <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
Date: Fri, 4 Aug 2023 10:48:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
 <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
 <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ff9e22-2d3a-4f39-f846-08db950240e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SDQY3vffPEPObrV2UlTZYekGi/fAmE/qrWLDNWNTxCbWZyaKt3uzcIxspQZG9aENLr1LokWea8/K7eYOJy0kKCV0/iNz9WX6k6BHel5xGZV5wum+ByvwB72eDY/REiu4ciFkDbeu/D8MdpDWfEtTjjFLDTYoYvIqz0D0sFhcfcG+r9v7TP0Ogg7rTSJ2PAaBokGXDlsMgdRoG3nLaqEo0SSkxbecTpLnKWJuTzbOfTl5s4zztXLYfPi8wGTkdTD8Nl93OyoGPjpZnlt2SnSp8aMZ5P+esACBDqKvPxIYbGQI5lrfgV6rmiHHtJOWaMjuppVshOMHPaVsdBql0PyEiXOd5/Zg/Fqs3k62ooqCUJK/1Og11E/6N8kaBKRQWHxOEONWdDm7zxrfF35yEwTVdT6uAOI7KQD+Obog1LSd5Rs02RBis6pCAQUO/5sK+Fd32J2slmB5A/vL/gbM/zZBiPeCySfQXC9TuJAimjf8kGB3XRnd49G9RGmj39oNpNAKQ3+weQtSAxfOvA7Nx0ohYlo4uxj9YIcRWDb6FTcV6SCz043Z5Oj0lZKNdRvsOwYWaoJYgaoFmQhI8u9ZUvDWQ2ahowuQETWGOqlDCCdM3CBuhN4bu/3Xv/qCN5G8270/95ZPaX/f/ech++yVLEzAovu++GGTDVUWMiXWSdRcNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(1800799003)(186006)(451199021)(6916009)(66556008)(4326008)(66476007)(66946007)(38100700002)(2616005)(53546011)(6506007)(2906002)(26005)(7416002)(83380400001)(54906003)(31696002)(478600001)(86362001)(36756003)(6512007)(966005)(6486002)(30864003)(45080400002)(41300700001)(8676002)(31686004)(3450700001)(5660300002)(8936002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRsM0U2ZnMxd3NnZW9zcDM0VVlXd3J5bHBIUVI3TW1xWnZxNkNxc1hTTkh0?=
 =?utf-8?B?dzkycjRyVmdjdUJCSE5KOTFjMFVmN3l2NmNJK295VjZTK1VMUG1zcndSTm80?=
 =?utf-8?B?SnU0aFpyTFlub2htUFNVVksySEZJVXdwcVBvNFR0anptSERNbnM1dGxDWjEw?=
 =?utf-8?B?UnlGV01LakZoRk1uMDNscGpLQTg2UWs2VkYwR1Y2OUVwZ3VDWlY2d1dBdjd0?=
 =?utf-8?B?NExzZVpCS1NibHpJOVlDMHhkdnF6ejZRNXJhWUhnc1k5V1JUbWNOOG43czBB?=
 =?utf-8?B?aE9kN2dVZFpBRnN4WVVybXdzQ2Jhd3ZvcURsaEN0a0dEZm9nMkRRL0p2V3JE?=
 =?utf-8?B?NXBTSHRnK2VyeTV3dTN0VUl5QzgvUWRpWTl3c21jeWljS0tUMWpXVm5tVUxj?=
 =?utf-8?B?VmgrS2N6bkJETnd3alN2Y2orZzhoOUpwaXpXVi82Qk85OEptcXhacUNhNE1T?=
 =?utf-8?B?NmpWZTY5dnhaZHhMd21WQWM0aVJvb2xRUHR3NjNGN2JocmRxay9IdjV4NUd6?=
 =?utf-8?B?OXRmZFZwNUUxWEoxR3BGUFM5THpvcEhtbGN6YnJLWWw4cjdtVHJSbUJsSTZj?=
 =?utf-8?B?aFdyeGxCV0lNUW12REtpT0Y0UFVQNk5NYXRTbURXQWt0ZlBZSVZUVzd0bDQ2?=
 =?utf-8?B?VVdEY2R0c0hOSGRyRzd4bTRRZkRZTUk2a01OT01ZbE5sZi8vcm1wK2xyN2Jw?=
 =?utf-8?B?ck9oZ0FzeTE5OSs1bWxNNmUraHJYdVNXUkxKNmhJK3ZwTVpwRC9HU0RqSE1w?=
 =?utf-8?B?Z0UrcFRqU3BLNTg4Y3R5bVhpOS9wUjl5OU9ta1pKNXlyZ2FvVldWSUVkSHU0?=
 =?utf-8?B?Y0FtdjNhL2c4RG5UWnpBSmRLeEV3b2tDcEE4QzU5Q2QzTGRCRnJGTkppVzFR?=
 =?utf-8?B?cjNOYnEvc1g0NlJZaVBOb0lvRWNCNVFITTlIN1RIWHY3bUphcWsvNUo4dity?=
 =?utf-8?B?elNJQlVuR1M4cGRSSXBENzV4VmxvWEhWZXFnMXg5ZXVHUkwvNS9xcUh3cVZ3?=
 =?utf-8?B?NUxWeXZhSS9mU2xNTHR4LzVjWDQ3NjU3Ynphc1Q0aWJIRW9LMXhvcjFaTEVE?=
 =?utf-8?B?cTBkQkRkcHdGRE5oV2hmWUNKcU9rOUtOTUFZbUJxZEhtMnp3SElWQTFrdTFX?=
 =?utf-8?B?czNubkl6M1pYeWdYMHQ0dFRaZUtjZmYzT0FPWjFvOWNrZWcxV1Z4dkdRdEph?=
 =?utf-8?B?RHVHYlZUcjNpZndWVW55MEJqaldFdUluMm10clNwaTlPaXM2OVZPcXRWN0V5?=
 =?utf-8?B?bnhKZDBHa2VkS3pkcFhpRG41a0Jkd3lZM1QvWEhUWXZlQnR2Y1Q1STcrL1Rh?=
 =?utf-8?B?Q3pWTFFLSkg3Z1p0dU4xaEtSQ2t2SkZLK0ZMZFlMRkF5WitSUnZ5VXF4Z3hs?=
 =?utf-8?B?V1ZON1Bid1NvNldiVnZHRFMzU3NqK2VpU3FoeXpEanNYaGdvWXNTSDFxQ1VQ?=
 =?utf-8?B?b3ZXcmV3anBpTnNIbW16OXAycnBmTEFCQTZxSGphcFpLNFdWTjFsYVFFR3ZP?=
 =?utf-8?B?Ym50b3R0WXJBNmFSV0N3QW1PK1VCOWZkOWswL2oxYUdxR3RUVmp0bXFVRGY0?=
 =?utf-8?B?aVVGYk1JdjMrTWp3ZmNiL3B3STNkQmZUQmZ3Z3JGekZ4VGlwdzRhbjRGbDls?=
 =?utf-8?B?T3ZjT0RXM3pVVlZDNGJVUjV6TDJ5TWF1NTE2RWJtc1dlUWMzTE5IK2lOOFFJ?=
 =?utf-8?B?MUU0SGlPVDBtQ0QwT083QW5Bb0pFR3A0ckd4ajNIYjF1U2hwTVlDdk5kRUl4?=
 =?utf-8?B?ZDRKUFJVZ2NkN2tqaTZVTnZ0WWhtc3h1b3Awc0kwZFU3TC9TTFNlQ1dVVy9l?=
 =?utf-8?B?U3Y3WGRlN1lndFhqM2doSjl4Tm1VOWIrRnM1WjFBdFhuVWpvSmRneG4rUWVK?=
 =?utf-8?B?eTB5WE4vMTBzcG5mUWVRNzU2NTkvTWI1UHpkUGFETXViSks1eGQ4c3NNL3cy?=
 =?utf-8?B?K0pRVHhqTDQ0WkdaZTVGd1Q0UmxxYytaaG0vLzBGdnF5Y2Rvam92OCtlR1Iv?=
 =?utf-8?B?WVVaa3E1QmpzNXM5L3F5U3FCajN5YnRSQ2d3S3plTTJUWDEzSTBxVDRJclk5?=
 =?utf-8?B?NjJjc3hzd1JHVVhjWm9SblBHV1YrT2Y0ZWFZQ2VMcS9tV0lKZ04yV3Z1cHQ5?=
 =?utf-8?Q?NW4k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ff9e22-2d3a-4f39-f846-08db950240e8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:48:31.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSVD5QFNJA0Lgmzh+jJvMlf9xSXTX32sbc+CiKRSovxVZC2gOFyBO+2zgDHOlG+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
Received-SPF: softfail client-ip=40.107.243.63;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/4/23 04:48, Zhao Liu wrote:
> Hi Babu,
> 
> On Thu, Aug 03, 2023 at 11:41:40AM -0500, Moger, Babu wrote:
>> Date: Thu, 3 Aug 2023 11:41:40 -0500
>> From: "Moger, Babu" <babu.moger@amd.com>
>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>  CPUID[4]
>>
>> Hi Zhao,
>>
>> On 8/2/23 18:49, Moger, Babu wrote:
>>> Hi Zhao,
>>>
>>> Hitting this error after this patch.
>>>
>>> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
>>> not be reached
>>> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
>>> should not be reached
>>> Aborted (core dumped)
>>>
>>> Looks like share_level for all the caches for AMD is not initialized.
> 
> I missed these change when I rebase. Sorry for that.
> 
> BTW, could I ask a question? From a previous discussion[1], I understand
> that the cache info is used to show the correct cache information in
> new machine. And from [2], the wrong cache info may cause "compatibility
> issues".
> 
> Is this "compatibility issues" AMD specific? I'm not sure if Intel should
> update the cache info like that. thanks!

I was going to comment about that. Good that you asked me.

Compatibility is qemu requirement.  Otherwise the migrations will fail.

Any changes in the topology is going to cause migration problems.

I am not sure how you are going to handle this. You can probably look at
the feature "x-intel-pt-auto-level".

make sure to test the migration.

Thanks
Babu


> 
> [1]: https://patchwork.kernel.org/project/kvm/patch/CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com/
> [2]: https://lore.kernel.org/qemu-devel/20180510204148.11687-1-babu.moger@amd.com/
> 
>>
>> The following patch fixes the problem.
>>
>> ======================================================
>>
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index f4c48e19fa..976a2755d8 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -528,6 +528,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
>>      .size = 2 * MiB,
>>      .line_size = 64,
>>      .associativity = 8,
>> +    .share_level = CPU_TOPO_LEVEL_CORE,
> 
> This "legacy_l2_cache_cpuid2" is not used to encode cache topology.
> I should explicitly set this default topo level as CPU_TOPO_LEVEL_UNKNOW.
> 
>>  };
>>
>>
>> @@ -1904,6 +1905,7 @@ static CPUCaches epyc_v4_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l1i_cache = &(CPUCacheInfo) {
>>          .type = INSTRUCTION_CACHE,
>> @@ -1916,6 +1918,7 @@ static CPUCaches epyc_v4_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l2_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -1926,6 +1929,7 @@ static CPUCaches epyc_v4_cache_info = {
>>          .partitions = 1,
>>          .sets = 1024,
>>          .lines_per_tag = 1,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l3_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -1939,6 +1943,7 @@ static CPUCaches epyc_v4_cache_info = {
>>          .self_init = true,
>>          .inclusive = true,
>>          .complex_indexing = false,
>> +        .share_level = CPU_TOPO_LEVEL_DIE,
>>      },
>>  };
>>
>> @@ -2008,6 +2013,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l1i_cache = &(CPUCacheInfo) {
>>          .type = INSTRUCTION_CACHE,
>> @@ -2020,6 +2026,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l2_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2030,6 +2037,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>>          .partitions = 1,
>>          .sets = 1024,
>>          .lines_per_tag = 1,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l3_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2043,6 +2051,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>>          .self_init = true,
>>          .inclusive = true,
>>          .complex_indexing = false,
>> +        .share_level = CPU_TOPO_LEVEL_DIE,
>>      },
>>  };
>>
>> @@ -2112,6 +2121,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l1i_cache = &(CPUCacheInfo) {
>>          .type = INSTRUCTION_CACHE,
>> @@ -2124,6 +2134,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l2_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2134,6 +2145,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
>>          .partitions = 1,
>>          .sets = 1024,
>>          .lines_per_tag = 1,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l3_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2147,6 +2159,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
>>          .self_init = true,
>>          .inclusive = true,
>>          .complex_indexing = false,
>> +        .share_level = CPU_TOPO_LEVEL_DIE,
>>      },
>>  };
>>
>> @@ -2162,6 +2175,7 @@ static const CPUCaches epyc_genoa_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l1i_cache = &(CPUCacheInfo) {
>>          .type = INSTRUCTION_CACHE,
>> @@ -2174,6 +2188,7 @@ static const CPUCaches epyc_genoa_cache_info = {
>>          .lines_per_tag = 1,
>>          .self_init = 1,
>>          .no_invd_sharing = true,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l2_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2184,6 +2199,7 @@ static const CPUCaches epyc_genoa_cache_info = {
>>          .partitions = 1,
>>          .sets = 2048,
>>          .lines_per_tag = 1,
>> +        .share_level = CPU_TOPO_LEVEL_CORE,
>>      },
>>      .l3_cache = &(CPUCacheInfo) {
>>          .type = UNIFIED_CACHE,
>> @@ -2197,6 +2213,7 @@ static const CPUCaches epyc_genoa_cache_info = {
>>          .self_init = true,
>>          .inclusive = true,
>>          .complex_indexing = false,
>> +        .share_level = CPU_TOPO_LEVEL_DIE,
>>      },
>>  };
>>
>>
>> =========================================================================
> 
> 
> Look good to me except legacy_l2_cache_cpuid2, thanks very much!
> I'll add this in next version.
> 
> -Zhao
> 
>>
>> Thanks
>> Babu
>>>
>>> On 8/1/23 05:35, Zhao Liu wrote:
>>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>>
>>>> CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
>>>> intel CPUs.
>>>>
>>>> After cache models have topology information, we can use
>>>> CPUCacheInfo.share_level to decide which topology level to be encoded
>>>> into CPUID[4].EAX[bits 25:14].
>>>>
>>>> And since maximum_processor_id (original "num_apic_ids") is parsed
>>>> based on cpu topology levels, which are verified when parsing smp, it's
>>>> no need to check this value by "assert(num_apic_ids > 0)" again, so
>>>> remove this assert.
>>>>
>>>> Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
>>>> helper to make the code cleaner.
>>>>
>>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>>> ---
>>>> Changes since v1:
>>>>  * Use "enum CPUTopoLevel share_level" as the parameter in
>>>>    max_processor_ids_for_cache().
>>>>  * Make cache_into_passthrough case also use
>>>>    max_processor_ids_for_cache() and max_core_ids_in_package() to
>>>>    encode CPUID[4]. (Yanan)
>>>>  * Rename the title of this patch (the original is "i386: Use
>>>>    CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
>>>> ---
>>>>  target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
>>>>  1 file changed, 43 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index 55aba4889628..c9897c0fe91a 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -234,22 +234,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
>>>>                         ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
>>>>                         0 /* Invalid value */)
>>>>  
>>>> +static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
>>>> +                                            enum CPUTopoLevel share_level)
>>>> +{
>>>> +    uint32_t num_ids = 0;
>>>> +
>>>> +    switch (share_level) {
>>>> +    case CPU_TOPO_LEVEL_CORE:
>>>> +        num_ids = 1 << apicid_core_offset(topo_info);
>>>> +        break;
>>>> +    case CPU_TOPO_LEVEL_DIE:
>>>> +        num_ids = 1 << apicid_die_offset(topo_info);
>>>> +        break;
>>>> +    case CPU_TOPO_LEVEL_PACKAGE:
>>>> +        num_ids = 1 << apicid_pkg_offset(topo_info);
>>>> +        break;
>>>> +    default:
>>>> +        /*
>>>> +         * Currently there is no use case for SMT and MODULE, so use
>>>> +         * assert directly to facilitate debugging.
>>>> +         */
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +
>>>> +    return num_ids - 1;
>>>> +}
>>>> +
>>>> +static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>>>> +{
>>>> +    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
>>>> +                               apicid_core_offset(topo_info));
>>>> +    return num_cores - 1;
>>>> +}
>>>>  
>>>>  /* Encode cache info for CPUID[4] */
>>>>  static void encode_cache_cpuid4(CPUCacheInfo *cache,
>>>> -                                int num_apic_ids, int num_cores,
>>>> +                                X86CPUTopoInfo *topo_info,
>>>>                                  uint32_t *eax, uint32_t *ebx,
>>>>                                  uint32_t *ecx, uint32_t *edx)
>>>>  {
>>>>      assert(cache->size == cache->line_size * cache->associativity *
>>>>                            cache->partitions * cache->sets);
>>>>  
>>>> -    assert(num_apic_ids > 0);
>>>>      *eax = CACHE_TYPE(cache->type) |
>>>>             CACHE_LEVEL(cache->level) |
>>>>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
>>>> -           ((num_cores - 1) << 26) |
>>>> -           ((num_apic_ids - 1) << 14);
>>>> +           (max_core_ids_in_package(topo_info) << 26) |
>>>> +           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);
>>>>  
>>>>      assert(cache->line_size > 0);
>>>>      assert(cache->partitions > 0);
>>>> @@ -6116,56 +6147,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>>>>  
>>>>                  if (cores_per_pkg > 1) {
>>>> -                    int addressable_cores_offset =
>>>> -                                                apicid_pkg_offset(&topo_info) -
>>>> -                                                apicid_core_offset(&topo_info);
>>>> -
>>>>                      *eax &= ~0xFC000000;
>>>> -                    *eax |= (1 << addressable_cores_offset - 1) << 26;
>>>> +                    *eax |= max_core_ids_in_package(&topo_info) << 26;
>>>>                  }
>>>>                  if (host_vcpus_per_cache > cpus_per_pkg) {
>>>> -                    int pkg_offset = apicid_pkg_offset(&topo_info);
>>>> -
>>>>                      *eax &= ~0x3FFC000;
>>>> -                    *eax |= (1 << pkg_offset - 1) << 14;
>>>> +                    *eax |=
>>>> +                        max_processor_ids_for_cache(&topo_info,
>>>> +                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
>>>>                  }
>>>>              }
>>>>          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>>>>              *eax = *ebx = *ecx = *edx = 0;
>>>>          } else {
>>>>              *eax = 0;
>>>> -            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
>>>> -                                           apicid_core_offset(&topo_info);
>>>> -            int core_offset, die_offset;
>>>>  
>>>>              switch (count) {
>>>>              case 0: /* L1 dcache info */
>>>> -                core_offset = apicid_core_offset(&topo_info);
>>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
>>>> -                                    (1 << core_offset),
>>>> -                                    (1 << addressable_cores_offset),
>>>> +                                    &topo_info,
>>>>                                      eax, ebx, ecx, edx);
>>>>                  break;
>>>>              case 1: /* L1 icache info */
>>>> -                core_offset = apicid_core_offset(&topo_info);
>>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
>>>> -                                    (1 << core_offset),
>>>> -                                    (1 << addressable_cores_offset),
>>>> +                                    &topo_info,
>>>>                                      eax, ebx, ecx, edx);
>>>>                  break;
>>>>              case 2: /* L2 cache info */
>>>> -                core_offset = apicid_core_offset(&topo_info);
>>>>                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
>>>> -                                    (1 << core_offset),
>>>> -                                    (1 << addressable_cores_offset),
>>>> +                                    &topo_info,
>>>>                                      eax, ebx, ecx, edx);
>>>>                  break;
>>>>              case 3: /* L3 cache info */
>>>> -                die_offset = apicid_die_offset(&topo_info);
>>>>                  if (cpu->enable_l3_cache) {
>>>>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
>>>> -                                        (1 << die_offset),
>>>> -                                        (1 << addressable_cores_offset),
>>>> +                                        &topo_info,
>>>>                                          eax, ebx, ecx, edx);
>>>>                      break;
>>>>                  }
>>>
>>
>> -- 
>> Thanks
>> Babu Moger

-- 
Thanks
Babu Moger

