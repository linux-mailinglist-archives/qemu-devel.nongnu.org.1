Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35D785E80
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 19:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYra7-0001sM-O2; Wed, 23 Aug 2023 13:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qYra6-0001rv-06
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:23:46 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com
 ([40.107.220.49] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qYra2-0004ar-Ii
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 13:23:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izC75KxaMOXX0dR0L3NzzKvxUy07wkco6ZZH/dhQRdBDsFSSe8oS9hFXL2Ov8+Khzwo7ouijz0LWNVhvqXc6ZMlEx7tx1dvu+rZ+lHu5SaYmPlvoEVsuoBZfAEzb8KptqTaxTwxc3MrFnql1+4v3VJZG2jJ2u4+FgrZNmrXjVv/seWCSopcFk5PeXS3MXbGrZSTe7F94F5OtnE4I7KdBZbgJHHUArVSPWKd/aTt2MmtXKYJ1QqmS0a5jxFOQqiXlsptBMTUTyHh6L+Hj5MPsx6uWartyVX9Ms8Vr6YRuk7ueudmQOjg6oNgTOK/+Yej8JJsIj5uGwLZAPAX8TGm2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKjGRInXQCvwoVxEbz/uFf3T2GQP3Dy+ZYzfmlBwO1w=;
 b=Bq+JaTruWAni/TClVQDIfRx8OqRx/M4Gu3wd9eLuJM42PhIQOfH7RmA27CFmEmt0+w/fTnC7h/7SANysfZrXrCjBOho/2qiSdmErppsP5yjgVmQWXKfqF5+4tb/Hiw5PcCQ8+jfjudDItV6cVwsPUiZyPZZcyo8ieFzf3jFTISSNWzSGrZA2/aLsx5OtfPBYWyq9UA4CNCLcQ5WpxrvZNuImuRMRsqUPUd3sMYXACLJXp1XQz8iXedREJaApKi0RCakFTlVUvx75FKYsrEHJbgds4vjwHyfTsf8vpOsrEx24iA+vbCYgj6MUSP/uakRyC1ldiwzpMJrth+mu4jJDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKjGRInXQCvwoVxEbz/uFf3T2GQP3Dy+ZYzfmlBwO1w=;
 b=Es57pr6XU5o2nmXn5u9sg89lXsWwATzF8+FMT4W/9YYRkqUkml9Atp///Dw35NTPYwad6BozykgxmlRNsR3lsWeMF0aPuSD1QI92n6TPe8TP9ijy2m0JviXvj/i3hJUAT3AjnXm6x+SNxDQCRkhkjyzbrOTYKoEpovLTPrv45Y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 17:18:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:18:33 +0000
Message-ID: <1eb2e3e7-87e0-9d8f-0eb1-da5888c2f6cc@amd.com>
Date: Wed, 23 Aug 2023 12:18:30 -0500
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
 Wei Wang <wei.w.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
 <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
 <3f7510f2-20f3-93df-72b3-01cfa687f554@amd.com>
 <ZMzJaElw/T5caQU+@liuzhao-OptiPlex-7080>
 <5947274f-e29d-cb76-3325-5dc75f205eeb@amd.com>
 <ZNnkR+G6PvE2q77E@liuzhao-OptiPlex-7080>
 <4615221c-407c-1542-56c8-a9557a5800b2@amd.com>
 <ZN8fw0CU+j/dOvBy@liuzhao-OptiPlex-7080>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZN8fw0CU+j/dOvBy@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:5:3af::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 713dfef7-7548-4d6e-a9fe-08dba3fcfa56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lN+6BOx0PVpXZWYvH+M/eUJtiaJrVI56DhujiwwiXDjdAKs4qk9qaXQeKUCGw7oynu0tv9f4qHVAo1DX1hz5k7fX8An2n3zscDMgQm7mF3+CEI5SOfxHXQdrr3p7/Z7eEF+tdn+z2mtiUTBu/UTVgkRIlZ9hShTfkDcHy+beZaOa1Bps3rNF7Mo1jcudzGHnCJv0q2XQIJXE54RetuJ7j8mdreKZ4c/k7XdksT6ckCyrHn7T2QAnbVobJxCbeGdtw2E1DIl+J43ZbacFQhpgH6HVeuwD96a/Wjr/4mJ65QmiPeTdO1sFVMGvkf3eD4XBE0z7Tk7AqM25oY/WfBDIARHCHYxN4TiguBHCDiAKMPe8xsiUXjWXRUadSvN5to78GAKoxgxC6RyNYdnYR2nwqBwBle0zZX8Wyd/dFjUxjT5TMN2ZpjwW1rWox0BCoXS5c75U96qPQhuE7aB5wlMGTaa4d1TflXv4Zep1ufEJtj//2UO+4zHNm5ZaIjGpZOeFkbxFJvtyB11/El6WrZH3UuFZuX3lwgW6KXc0gfjFJJ+sn8xHVNnNSVy2i3q3GwdluNnzIFAYshM5G16CTImTEzKyghRrGagabD/tivTjPhCIj5oVm89s42b1gBH+2aGZbb6Q5f7oU9Cg8oLgudT62w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(3450700001)(83380400001)(2906002)(38100700002)(86362001)(36756003)(31696002)(41300700001)(6512007)(66476007)(54906003)(66556008)(66946007)(6506007)(6486002)(6916009)(316002)(53546011)(2616005)(4326008)(8936002)(8676002)(966005)(478600001)(31686004)(26005)(7416002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmwyaTUvQUxNWTRnTVNYRUlZUWwrMnc5c2FBVG5qQzNvU3NmTzRJdWg1amZO?=
 =?utf-8?B?VitpTG9tTmt2c2ExUWJDMm9tbGRlMHVYUlBCRDZvd3hTREhVL1BNTExZV3NX?=
 =?utf-8?B?SVRxV1NrT2Npa3Q3SlZJU1NwMmRwNFBXbmxYTjQ2SVFPZmpwc0tHdHBpc3Zh?=
 =?utf-8?B?TnV3alY1cVBXbWhrR1ByRE80YzR5TzZjSWsva2QzWGFCeExhZVIxdEphczhJ?=
 =?utf-8?B?aVdGaHM0ZHBTYkZTclZvUHQyS0g4cHJwb2pzRmJQeFl5alhqNHc0Q1IvT0NZ?=
 =?utf-8?B?MDloSnNzV3YxVDBSK3FERk1tVXVmYUJsQzI0Y1VhQmN1TmxuNEpYL01jck9X?=
 =?utf-8?B?dDdWSHhSVnpINGdET0lQbFFjSnpqalduZ0c0RitHU05pdmFhUlhMZDRHRTdO?=
 =?utf-8?B?TEF2L3BVZGpoZ0wrRis1REtaQ21WcE1raTI3aVVGTHpTVVdqbHBzYTRPcnE5?=
 =?utf-8?B?aklVSldoUCtTR1pQc0ZOdFNmMkxrRDJXSEZLTXYyMkltaktYNXFKMGttUU4v?=
 =?utf-8?B?V0E1QmlYVGxLQzdIL2dEamROL0swTHM2R0hscU5LUC9hMVh1MEFRODBnSnRY?=
 =?utf-8?B?UVY2VTBRZ2FYb1ZuOUN1dHE3bHByWUlPTUtCRVZDWm9BcDFiMDJFRlJyYkVz?=
 =?utf-8?B?NXFHaElDaytiYlRDVkZYNjlRWWZHRXNxb2xYY3VWSTVraCtLTFpJaVRtaGZB?=
 =?utf-8?B?R1lGTlpiWHVTOWdQaWxYM1hBWCtRZEdqbzYrTHhIWWxYcmVnNkxjMkZlUGl2?=
 =?utf-8?B?UG1XMTBwbTBINmw4eXpwdXNwWnBKVUI1ZFpUQlpxeitweUlwTmdSSzRORGNP?=
 =?utf-8?B?OFRPenhOVmZqRG9wc2pBd0lzb1JVY2oxVjRYbjZPc01iUmVteDJLbUk1VHJE?=
 =?utf-8?B?V2dQWkE1SDJIWmVqR25CSDJlNDU1RUhWS3RvOEp6Y09uODBtVVRsNTgrU0Ns?=
 =?utf-8?B?SEpkYXNuQkZMb1RZSW00c2s5UEkxWU42WmV2UWc2UFhSTnRUR3F2VnpEdTBH?=
 =?utf-8?B?WGswWGhTSXMzNFZ4aWlOaUZSMVNkYlBDL2tGTzIxSXpqZG83SVJEZmRYbjNs?=
 =?utf-8?B?dS9NbGV1WEZBb2RsVk5TQTQzQ0VvNmF1TkQ1blNjaitid3VsR3V3QnFHd0wr?=
 =?utf-8?B?ZXIveE9haStYZGo4K2NKNWl4QTV4dnRJVUdwRXZRYmMyMnNJMTdyVGJXMnpR?=
 =?utf-8?B?MkpHUmNxMzNUREZ0OVYxWWtQaHRKTy9TdjZXT2t0Y2dnbWk0Sy9DREJvcDR5?=
 =?utf-8?B?QzVBMVdrUS9WYVpJdXpWbGEyRmo1Rm1FSzNXMFh2ME8rczlyeXRwSkhNdEZI?=
 =?utf-8?B?bXVheTM4STExU0xvM0ZER1NnRU02T0JMVkhTc3JXOG1RalJIaGZ5VjdWM0Yw?=
 =?utf-8?B?WDloTG13cmFEWEtBUFlpNGprSUFtZ3oxOW5qR2xoYnJRTEQ0UEU4dk4rMGpr?=
 =?utf-8?B?TXRFS0R1ampiVXlWUHIrb2E0K3NVL08ydFhNN045Qk9QK1JjSXJGUG0zMFZP?=
 =?utf-8?B?R09SQ2FJTnVsRTE0aHBVL3RoU1IyeGdJbmhBeXZ4RTRmSVdNa1d5Y2lPYlAy?=
 =?utf-8?B?R1NtaEw2ZUtoUG9UU3lSN1pYSWhNYzVkWnF5V3JSc1FiMDREZ1hWM2Eyendk?=
 =?utf-8?B?YkNpMlhDd2pIQktDeEhWS1BqK1FLajZoS08wVUdKcXJ2bjRweHF2b0ljVFpW?=
 =?utf-8?B?V1dGSUZoWkdWVzVGZHU3V1dGYUVNSDdJNzAxTlI0Nm11NEtETWpMZ2ZteTBP?=
 =?utf-8?B?cTVTZkRxenhGK0FBTnhWaFI2YkFvOFJzMENWTi9FZ2Y4K29PQXRVMVArZzk3?=
 =?utf-8?B?VzgxV0hXeko3U2ErM2FqQm1hakdsZlM5emxHVHpBMTVIMUdDY3lhR2JpU3U2?=
 =?utf-8?B?SEs2NGhJZTNjaW41SDVoN0JSZlluaXJETkFKMnpNZmgvWW1sU3ZQSHFTMHlV?=
 =?utf-8?B?enoxeVBKY1ZVK3o1THRGT052Z1M4azFkNEdCMzFNOUttRzVJakUxdzNnUXFM?=
 =?utf-8?B?YlBPbnJJc0NKR1Jwdk5RbDJRQTNURCt2Y2MzdzBMZURCMmxsK0dQSUVIZk5O?=
 =?utf-8?B?a05kU25lbkhpWFlhaVc2RWlEZjRmV2hINmF3ejBrRDEwZkdzMk5RN1hsRUpi?=
 =?utf-8?Q?aeGM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713dfef7-7548-4d6e-a9fe-08dba3fcfa56
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 17:18:33.2084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW5SoBNy5w7qZ59fV9bY1DzFbBGaoErs8Iijx1wkVr6Ok2WNlC03CkVFOGgix/jC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
Received-SPF: softfail client-ip=40.107.220.49;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.684, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/18/23 02:37, Zhao Liu wrote:
> Hi Babu,
> 
> On Mon, Aug 14, 2023 at 11:03:53AM -0500, Moger, Babu wrote:
>> Date: Mon, 14 Aug 2023 11:03:53 -0500
>> From: "Moger, Babu" <babu.moger@amd.com>
>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>  CPUID[4]
>>
>> Hi Zhao,
>>
>>
>> On 8/14/23 03:22, Zhao Liu wrote:
>>> Hi Babu,
>>>
>>> On Fri, Aug 04, 2023 at 10:48:29AM -0500, Moger, Babu wrote:
>>>> Date: Fri, 4 Aug 2023 10:48:29 -0500
>>>> From: "Moger, Babu" <babu.moger@amd.com>
>>>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>>>  CPUID[4]
>>>>
>>>> Hi Zhao,
>>>>
>>>> On 8/4/23 04:48, Zhao Liu wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Thu, Aug 03, 2023 at 11:41:40AM -0500, Moger, Babu wrote:
>>>>>> Date: Thu, 3 Aug 2023 11:41:40 -0500
>>>>>> From: "Moger, Babu" <babu.moger@amd.com>
>>>>>> Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
>>>>>>  CPUID[4]
>>>>>>
>>>>>> Hi Zhao,
>>>>>>
>>>>>> On 8/2/23 18:49, Moger, Babu wrote:
>>>>>>> Hi Zhao,
>>>>>>>
>>>>>>> Hitting this error after this patch.
>>>>>>>
>>>>>>> ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
>>>>>>> not be reached
>>>>>>> Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
>>>>>>> should not be reached
>>>>>>> Aborted (core dumped)
>>>>>>>
>>>>>>> Looks like share_level for all the caches for AMD is not initialized.
>>>>>
>>>>> I missed these change when I rebase. Sorry for that.
>>>>>
>>>>> BTW, could I ask a question? From a previous discussion[1], I understand
>>>>> that the cache info is used to show the correct cache information in
>>>>> new machine. And from [2], the wrong cache info may cause "compatibility
>>>>> issues".
>>>>>
>>>>> Is this "compatibility issues" AMD specific? I'm not sure if Intel should
>>>>> update the cache info like that. thanks!
>>>>
>>>> I was going to comment about that. Good that you asked me.
>>>>
>>>> Compatibility is qemu requirement.  Otherwise the migrations will fail.
>>>>
>>>> Any changes in the topology is going to cause migration problems.
>>>
>>> Could you please educate me more about the details of the "migration
>>> problem"?
>>>
>>> I didn't understand why it was causing the problem and wasn't sure if I
>>> was missing any cases.
>>>
>>
>> I am not an expert on migration but I test VM migration sometimes.
>> Here are some guidelines.
>> https://developers.redhat.com/blog/2015/03/24/live-migrating-qemu-kvm-virtual-machines
> 
> Thanks for the material!
> 
>>
>> When you migrate a VM to newer qemu using the same CPU type, migration
>> should work seamless. That means list of CPU features should be compatible
>> when you move to newer qemu version with CPU type.
> 
> I see. This patches set adds the "-smp cluster" command and the
> "x-l2-cache-topo" command. Migration requires that the target and

Shouldn't the command x-l2-cache-topo disabled by default? (For example
look at hw/i386/pc.c the property x-migrate-smi-count).

It will be enabled when user passes "-cpu x-l2-cache-topo=[core|cluster]".
Current code enables it by default as far I can see.

> source VM command lines are the same, so the new commands ensure that
> the migration is consistent.
> 
> But this patch set also includes some topology fixes (nr_cores fix and
> l1 cache topology fix) and encoding change (use APIC ID offset to encode
> addressable ids), these changes would affect migration and may cause
> CPUID change for VM view. Thus if this patch set is accepted, these
> changes also need to be pushed into stable versions. Do you agree?

Yes. That sounds right.

> 
> And about cache info for different CPU generations, migration usually
> happens on the same CPU type, and Intel uses the same default cache
> info for all CPU types. With the consistent cache info, migration is
> also Ok. So if we don't care about the specific cache info in the VM,
> it's okay to use the same default cache info for all CPU types. Right?

I am not sure about this. Please run migration tests to be sure.
-- 
Thanks
Babu Moger

