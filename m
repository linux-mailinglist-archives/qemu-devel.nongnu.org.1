Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3C77BDA2
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVa7x-0006Uk-Be; Mon, 14 Aug 2023 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qVa7t-0006UH-4H
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:09:05 -0400
Received: from mail-bn1nam02on2045.outbound.protection.outlook.com
 ([40.107.212.45] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qVa7q-0006wh-Ri
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md4F7rTLAjGcsme3HLo45QZxRAtupXiZLy9h4fNhCVLum4VL/5xTzmU1vt2lGzOWhK9wJ6cgFCye2qpQaL5eObpVLLDgqM1EVzkPHbE5jYkYjX2PLNmw3rHfN2OdOC44/HFb3HoYNBmDqLWPCwe3gNnHC0PV0y7ML6riKMROI7NiAMNc3DZJLO9SEUlpDvDEGzOzdSq/mB1HXoyQlDUc07YGXJyYAQ3XxgLNY6s+qQokiuodGSqd/Y0Ph577e+zcsUwcijjw9HIFLNhSQDRgJzMMVq32yjLoMw1sPhjMgTY6NtK5W5vJCY/1cpbU+0zE3IzLYRCXf4ev3NQ8ptHAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGbiotC1ZATQc8DCKih9IKl0s/ecmOH8N14obeyStJA=;
 b=En+DuMLX97moqWng0arnR8GYv5SR4UIZy1Q4qkfFampjSYloNa66BC5fgdxL+6UadFTQunGYF/asxFZ3231Ma98+7+oAdbuJp4kQLwqrbpT6BPmojgkNA9VL1oy6gecuYZ/W1oIU00LZunL26x0f6jDkEMJb/TGynJWu8VE9f0O3dUOLDkk1/CyuJ84urs3gS5T29xtFvtz9dP2EUmL7Vs4XJh+nUsvv3y+CGLvXa+UfqUlyq7p9YBQZ8mBsyx2r+s+eTZ/SUKGhpRXRvlAKKz1F8UZDb7k+S6P8AWeJEuz/HZQvuh8yFmvZv80UMaUR4bZfD8Stur8kWsbSW27/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGbiotC1ZATQc8DCKih9IKl0s/ecmOH8N14obeyStJA=;
 b=SWRScBVcwmPDKMQnWSdYK1YJu2SFwh1Yc4+ogXO2sP2l9F54nfmN4PjVfr95sBUsc5M05G72302vHhYvO3aGoQHI30zE2S8MxT3+7muk9bTvhJaNHm+eQiZZ6eW60x8KpjWqIsxnbgxV1G1giOttupSNLXRQsmibw+3JgQBuuxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 16:03:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:03:56 +0000
Message-ID: <4615221c-407c-1542-56c8-a9557a5800b2@amd.com>
Date: Mon, 14 Aug 2023 11:03:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Wei Wang <wei.w.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
 <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
 <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
 <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
 <ZNnkR+G6PvE2q77E@liuzhao-OptiPlex-7080>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZNnkR+G6PvE2q77E@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 143a0d61-7ea3-42bb-87d9-08db9ce0101e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqRA5NQN2P8Lj15reLfsWlWKkhdfR6A9KM5ld2KwTR7ae0vXuyBShuOFm5RYHhheLothEsgZ5OXQKIh7a52/PEa9avgq6C4AQlHJjOYchbzajWG33wGwQKj8zJSUnVeLognKvsruRMtUYwHqR0SNlr6UykPWUVFBlXL/KPZkKqVpMQsIfp6KBCwCigqAKLYnNtQo7G2elnWMo1OSLTx26uTIMXRXwQNARtzHdjyds5KPyqOD+PLwX2XgJQx6fYLYSBRAvyNU0Ds6t5zyvdwaPvhSooaayCTVdSmQRcihE7kV3hLusySIYnPuI5vA7CabQsxvFLXzET8Rd0CVs1L7hFS6tOSPT6SYhLM8lEFCR/Meof8D+WJkbdhl13dAoeCBrlPosxhkuR+CQt+XdRIgIUG8oKkQsuBPvvjY7z0HBFfR5X7ZDoQZc3qXNd7B3kLWkOMD496m/y9ygFSwENrigvyR2FoYYJsLLz9msKCE7KNdDdI2pZIlHmDM4iFWFQ4bfnGmhQ/iGibLatuCLz0cgieOgkYNmEhnZXNdD4/oc6N5TKOKfkA44BMLDwbaPPYREuIoF+E6+Z9lBuz7teT46bUk4QEVCiS/76n/eibpdSveBmH+nt4p0iPC5633JyH5UrJU12rm2laaLDt3SaMZJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(38100700002)(36756003)(86362001)(31696002)(3450700001)(6512007)(53546011)(6506007)(6486002)(6666004)(478600001)(966005)(2906002)(7416002)(31686004)(2616005)(26005)(83380400001)(316002)(54906003)(41300700001)(66946007)(66556008)(66476007)(6916009)(5660300002)(8676002)(8936002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFIbnVjeVZGVE1SbkVvN1hISkcyWVZteExzVXJPTU5BUlgrckxKdmhBN3Q0?=
 =?utf-8?B?SHFHZ0ZCeE9OK1NKVGkwalRMdVlpWFdCUTBzSWRvQzN4WDlNRC9UUGQvaE44?=
 =?utf-8?B?bUcyOExmWGF6NmdoamQrLzFLWjNPVDhNdkhyeE5TcHhiRysvbEcwYkJsVEV6?=
 =?utf-8?B?RE9tTWYvVW8rOHFxc3ZLL3lMV21iTURxMU5ORTdqRTdTdkp3MTBpMGhjL1E0?=
 =?utf-8?B?RU5RZHJ4RWROQlpiQmdOZ1YrdjBmWVB4YW1NSlFXVjI3YlJIV1pBTnpsbEMx?=
 =?utf-8?B?bS84Y2ZTTEhRcytZTi9ZVnMvSDhzb2JWTmNqSE9lcThkRWNNRlI2OXdlYmFm?=
 =?utf-8?B?dDRZRjVJOUQ1R1lXN2dTS0VpSGVNbHBLWnhYNE1tdXpuN3NvZ0JFM2Y3NWcw?=
 =?utf-8?B?WXFkODgzbVo4SFdjR3dBaDNSblY4MytjVU1JMnQ2Kys5andWMW1QRkYvOSt3?=
 =?utf-8?B?clhGbGlOM2J5cXBQK254UHBqTXhTVUxwVFpKYXRXUzhiTjg5ZHlXTTZKUWIr?=
 =?utf-8?B?NTBseWlQb1VXU3RXSmVkVmttMXhtaFpUaDVrZFRhQjB2N2VEdllyTHNWZnRs?=
 =?utf-8?B?SFJmVEpJRkh3d1ZtWEhPVWNxSnkzRXdtYjhRMzBQYnI2aDR5dGR5NVpsWHFY?=
 =?utf-8?B?QmxPL2NTMzJIV3MxZHBZR01BeTlaNlpzd3dDZ3ZsZmNENFUzcXo0OENMRXp6?=
 =?utf-8?B?OUtHSE5xc295Rnhpd0ZGZ2syMlVVU0JOb1NJRE9VZ1ZiWk9RdzNlNEZ3aXlp?=
 =?utf-8?B?MmFReExicFM1UXlLZnluN0RocUpqL2NOaU9YS1FRakwwb1BxWG12dklhY3hy?=
 =?utf-8?B?ZTNOWkhDeVoxWnpLQmxBSUhmK1NDN1kwc29EaFFvdjJNQXRmdnFaRDVpSThz?=
 =?utf-8?B?b3hvWG1EdkpkcWp6RGlvVmhhc0ZLenBIK3RMa3dlbVZmM1lLYlA3RFA4QkpU?=
 =?utf-8?B?bWhHZm9Fakw3dHZSMkd0OE9iN2lBbmMxTkZxZE53bHFOVlBkWjh2SGRScWYx?=
 =?utf-8?B?d3NiMjZLbGxYc08vdTFwbEVjeUpWWE1KbGJRdzNwdjFQZk1IdnVQamRzRW5X?=
 =?utf-8?B?RkNIMjJEenUvaXpFM1JNSDV3Wmprc2dOTktPRVBPaUJCd3dYd3orTUY4VXFj?=
 =?utf-8?B?UU83R2wrOWpwYkxxdW1lYTBqWXhNamNoVTAvMkZUWFZuTlZ0R2VxSGNIR0Qy?=
 =?utf-8?B?eDhGY05VNXdIczRTREhmcmduZXNmZzBDRHBDZkM0Zlp0eVlSd1dZTldwWmkr?=
 =?utf-8?B?M3RiS1J4dE1aakNLQU1QRU1TUkNmV0doTDlOY21rckEyQko0MC9nVGZlSWUy?=
 =?utf-8?B?YW5Kd3pUcE0xeFBsTzNla29PRHZaN01qbWswZ3psc1JEbWtvU3E4U2NETjRx?=
 =?utf-8?B?V3pabWhOUXczVmpCU0tZQ2pBbjhjN0R0RXF1RG81aUVWbDRTMWE3WEFBMDVv?=
 =?utf-8?B?Sm9UZWJvRjRxakJCQ3Y2dmliblliSTFnZXh5WXNXU0pESzZIM21Pejhvcysv?=
 =?utf-8?B?OFNuTmd0MVgvVzFxWnpvRkRMV0wzVk1TczA2MEJUNTBJMzVBUlczRHNKUWFR?=
 =?utf-8?B?d0l3S0Vud1NBckxaNEE2ZWRNL3ZOR3I5Qi85eXFLakhDUG5PL1lOTldyT0gv?=
 =?utf-8?B?YU5IOHZwdW1RcXczN2tRMnZOTVFQNGRjdkVzMHhpVzVoUEI2SzRCeFFPK0E5?=
 =?utf-8?B?dWVHampLUmpCSW5XQ2FMZXRMQTA5dWdLSHlqajEvbG9aT2pQbGxFeTBadWt5?=
 =?utf-8?B?U1BtM2JNZHJrUElYYmUxNHI4MDFmY3cwcXVRNUhiS25zcmJMdmdUa05sTEpS?=
 =?utf-8?B?K0dJRTlYTWdLS3BHN3crMVZZaWdiYmVFUVNycElBenAyNWFzVjZaU1YxOHNr?=
 =?utf-8?B?VExncWNZbnhSU0FubVcxQVAwZnB1ZG9nQTdqRmErZ3VwNmxVNE5rYm5LRmMy?=
 =?utf-8?B?YTE0enpMcVM2VTlGclhYb3B3dnkzaVRLeFBYaDE0ZG9ybEpVbytLMjFWVlJF?=
 =?utf-8?B?M3NNZXRSNFZaNWY4SXVHWVVpWG44THlVdlpXQ0txYkNLMHBKOThZYUo3djQ3?=
 =?utf-8?B?NWEvME5FY2tYd1RQKzIxTkJRVjZJTTZSc3o0RGxQSUpUNllNTVhpd0wxa3pn?=
 =?utf-8?Q?+QRI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143a0d61-7ea3-42bb-87d9-08db9ce0101e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:03:56.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GoD/bkufaSemeaQvpbnL6OM5dFbV4Cg7lxV/DePW3buQWAwPNMaAMfKeAQfeTmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
Received-SPF: softfail client-ip=40.107.212.45;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.265, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,


On 8/14/23 03:22, Zhao Liu wrote:
> Hi Babu,
> 
> On Fri, Aug 04, 2023 at 10:48:29AM -0500, Moger, Babu wrote:
>> Date: Fri, 4 Aug 2023 10:48:29 -0500
>> From: "Moger, Babu" <babu.moger@amd.com>
>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>  CPUID[4]
>>
>> Hi Zhao,
>>
>> On 8/4/23 04:48, Zhao Liu wrote:
>>> Hi Babu,
>>>
>>> On Thu, Aug 03, 2023 at 11:41:40AM -0500, Moger, Babu wrote:
>>>> Date: Thu, 3 Aug 2023 11:41:40 -0500
>>>> From: "Moger, Babu" <babu.moger@amd.com>
>>>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>>>  CPUID[4]
>>>>
>>>> Hi Zhao,
>>>>
>>>> On 8/2/23 18:49, Moger, Babu wrote:
>>>>> Hi Zhao,
>>>>>
>>>>> Hitting this error after this patch.
>>>>>
>>>>> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
>>>>> not be reached
>>>>> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
>>>>> should not be reached
>>>>> Aborted (core dumped)
>>>>>
>>>>> Looks like share_level for all the caches for AMD is not initialized.
>>>
>>> I missed these change when I rebase. Sorry for that.
>>>
>>> BTW, could I ask a question? From a previous discussion[1], I understand
>>> that the cache info is used to show the correct cache information in
>>> new machine. And from [2], the wrong cache info may cause "compatibility
>>> issues".
>>>
>>> Is this "compatibility issues" AMD specific? I'm not sure if Intel should
>>> update the cache info like that. thanks!
>>
>> I was going to comment about that. Good that you asked me.
>>
>> Compatibility is qemu requirement.  Otherwise the migrations will fail.
>>
>> Any changes in the topology is going to cause migration problems.
> 
> Could you please educate me more about the details of the "migration
> problem"?
> 
> I didn't understand why it was causing the problem and wasn't sure if I
> was missing any cases.
> 

I am not an expert on migration but I test VM migration sometimes.
Here are some guidelines.
https://developers.redhat.com/blog/2015/03/24/live-migrating-qemu-kvm-virtual-machines

When you migrate a VM to newer qemu using the same CPU type, migration
should work seamless. That means list of CPU features should be compatible
when you move to newer qemu version with CPU type.

Thanks
Babu


