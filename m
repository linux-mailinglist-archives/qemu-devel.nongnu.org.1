Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF8B768C16
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 08:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMX0-0001p6-38; Mon, 31 Jul 2023 02:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQMWu-0001mV-JX
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:37:21 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com
 ([40.107.244.63] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQMWr-00067K-Ru
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxmyTI5D5LHS8IhLYj9Kb5NXiGGFSvemo/twypo2S/RaYcGzUrKNIKR9JxyDEZkto6pE+aqqIi10FlgcOUu6qfUzcmlLzEDr8JL3wZgzk17XLZBx+62N2Yc4HBFohJ3yGCTH/gjKdP1MCABEjwwkZsJypL1SYL/cLJApPP3HqvmHz1ZWCS5k34SSWp9wb2WhZXd55cT8CU4LTM6F3xANeLy1sXn1lsz1wB53x2ZH4hc1moBaYQiCR8iMRpfsOrtEqy1E0tKQIV1p4v7m38rjTVnvh8Mxmx4tqJNlLsLMdCXOBP7zZVZodx43t21UoZXyU+e2mm01wi8gJOrP+dW+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNifNR3579CSTDf1aKrxi21eo5oHXqOtngIWGFFCfno=;
 b=F220jbNRs737ieeBXFOg4sHd6m/P1PVVUxm4TPSz1sx1CySHn/qRA77/ysu6PFsSUwe8KklEEQ3l6+f/S5TZL+NpEWDw+Yu+eI5Ne/HfBZb0xjND4spezccPSRqybnjrOZUoOCJQJBuD9JJY6IXUC3M40u/JlG74tGk/g05V+Yf3KRTk10+5SYasGu4NzGN71AB7PHCUMvdZUA8OLIyvLI5xPXPQDwHwU2ORIo1S8W3xTtpgw+X0edzfbEVx46I2FTdhsmPwp/TCU7LHFQiIbWA2T3YKdlo0xnGeIkMtZl/XusKbn2zOn62ci+a7MZLOaoO63W+Eftg0aPCxsUyYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNifNR3579CSTDf1aKrxi21eo5oHXqOtngIWGFFCfno=;
 b=XjUFn5vRrM6ouH64N97QLqJu5ZMBa/OqwQmukIyfCzqejSclOVOHS3xaMSgPOrW3Ky6RaA6xW6zovkqGqqghRcBuKKE5VSgTpeUZofxjpA62wqUwQUdPtnh7vefyCLRB1LXTOEPF/WgNvmOgRBWp9qI1WZvyMxw+SGGDUWcUrO8O0hXOu2CFwSN7Bk7pWHiKa6Zryjye5Wgj7qxMxSynfDFkqXsQikzGpbK0HIh541Xn2a5vrGg6RkXAOb+gY5+rjOHqcHqDHv9dUn3Mwd55QvaV8jQNXnyjMQgnvWQZ16Wjae6sJACQtq9rDl0beO02FFdqzgJLGo9bIxV16kuwiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:32:09 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:32:09 +0000
Message-ID: <26daa2db-13fd-3705-fbbf-22b8643dc9ee@nvidia.com>
Date: Mon, 31 Jul 2023 09:32:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/6] vfio/migration: Move from STOP_COPY to STOP
 in vfio_save_cleanup()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-2-avihaih@nvidia.com>
 <dc2365df-4e71-e2d8-988d-f74431800123@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <dc2365df-4e71-e2d8-988d-f74431800123@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f33733-07a0-4446-1b12-08db918fddb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/w1saOlEvqaMI9EVh+XrIpNcoqWZxvDbHOOuJgagTs5jtOqxjr2W+tYxFdmb8/S4TZ0k42u/x99O2JGGOx+yksdI8JW6DSe3XK+4vt7kXC0q86nwLAnjREm+GCxFeV7kec874Sc1AxjDDVRGuN1dt0EV7GW/At2iXll6Qz52BtNT9GhrIal9lq4L4+/C3APR8kxCpL15Zug6iQDPiHpdNVeDdxKjQG5eXtserjt4y4CmZVsS+2tjY3LRHGlSVLIEftuE4x/mhN2jlkWXNlPmXWCy7SFEKo1yT4scTFNDhTt5TnKARjRoi6TmU5RWDGre9aT6by6snvrGqqYfUpo4ueRNlfKGz+OzVdOb4niUFHtSlwJKTqTb0TfBia4fqQYVPhWQAJX1pUWlx8SQcQicRO2tYaIo6hNTu1tB91J37HkIxTFofa9pR/WUnTLjYzZ6VuC0fAhxbcYFnJ+M1CQrSgIysqA3+MzB/PN5KREVJAcw3aX90p0hQz3NU6mmV7aYi+0DMx7s+pqdfCitoGK+oSDlnVFg5a/8D2kYjC1VwoQcT3BVZVTaRgRhekqHukANNQQ1u1qfOtj0ko3DGjwpIgjXMiz2fLkm8aTUQ2yyPDpufM8fPB68QtDPOeVqxyOHLTwmMmNaZR4Mt6As8LOKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(83380400001)(107886003)(186003)(66574015)(66946007)(66556008)(54906003)(41300700001)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(31686004)(38100700002)(2906002)(6666004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWUyN2h5cVZuSktYdHFaNGV5Mks2algvWEJ0MWE4ZVVKcG0zY3MrbWoxRlFV?=
 =?utf-8?B?WFkvcDZaT0luRDdQazNhcWhhQUlicWlHTWYxQXBPSXd6dkxBV3MxUUprT3ZE?=
 =?utf-8?B?bHREUEVlblp6M0E4YUNiQU11a2tVZnljb1JHMFptSE1KbC9QcnpvYkdrRUVK?=
 =?utf-8?B?ajB6am9aeGJlUWorK2RxWUJGbURQS0RkVTdQRHRzb01Da3MyZ2FKS08ya1Q4?=
 =?utf-8?B?NzJyOXE3dnB2SEg2aGkva1hzdHExU0tLOXFacEJEZ2N2bS9Ia2JsUndjZEdO?=
 =?utf-8?B?SnYrdmRYK3dCcTE4R1hZRllsMXIydURtNU9nUUVKbllyc0VWZ1ZHeVNmRVhj?=
 =?utf-8?B?RnV6RDdyMjJjSXEwUVRrSndUblNhY3llT1hxb1I3SDBxdHo2dnNJUFIwWnFS?=
 =?utf-8?B?MjdnQ0FuRDhtSkhnZ2NZcjFyT25DVU1FUHRaSlpUNTJMeXdNcnBKTi8xZk50?=
 =?utf-8?B?WHVFeEdzTk01RVhCT2pQVXVkcEdHOUhXbDR1WkFyeVk5MVZyZ2diTmVxY0xr?=
 =?utf-8?B?ZThIdkt2eXc3L20xZmhKNGljYlFmOTVVZkU1UW5KMTFxMDJ3MDdRSHgyYWZ1?=
 =?utf-8?B?UnFSTUllczhJOWpDSDdSRnpqMUFCMlBJL01mUkg2WHhRMVk1TWNHb3RaMHkz?=
 =?utf-8?B?ZnE5MktGamoySGwvTHNkNEs2TnNHZTQ3VlVkQWdKY3hKa1Q3L3F4OExrdHlm?=
 =?utf-8?B?NUhlOTU4TXBydnVKL1V3RmRVZWF6aFRzdU9VSEJZNlE5WW10c1V2MUVsK1l2?=
 =?utf-8?B?Sys2VjFNclRsakpNY01SUDNYV3hZTTBqZVhTazAyU3I3OTNQM0tWVVFWQXBp?=
 =?utf-8?B?UUdPMmdNTVllb1BvcmZjQWNLMDFFa3RkUVUwaHNTQkIweHhVNWxPK3oyeGlx?=
 =?utf-8?B?Vm1pOVdtaWNtVlM2RWhaVkRzNTdoTlRXcUxpanVDV3ZxdjBwTU5MU0wxRFpO?=
 =?utf-8?B?THJ1OWVPeWRPSTRsTys2WkhsY2QyNDBtSVFIL3lCdDdKVGRLbmtVOS9vZndT?=
 =?utf-8?B?MVFzdUw2ZVJvRjROM3kxakxkNk8zQ28vb0Y5cFVLV3VsRTg0cEtobmhSbWVy?=
 =?utf-8?B?dEpHRWFqMkRDRmpsdTUyaS9YU2JWdjlvRmNLeDIvamxwWEkxOUJuTnNiSVlh?=
 =?utf-8?B?b01rYmxlRWZHc2pGVVhjUXRncFl4bzB6b0JKeitjKzZNZGVjSVFPZ1ZMc0ly?=
 =?utf-8?B?MzFwNEY1cHFoTVpVZ05nYXBFb29wL0l1RGJwQ3RZZ3o2NmUybGtOeHZZYjRK?=
 =?utf-8?B?TlFuWFlHaE9wNkdaRE5hcUlqNHhLSnNKSnp0M2Z2VExkYlJuMmtQc1hKRmN1?=
 =?utf-8?B?ai9wTnVjbmYxRDAzOHJiaGRHUnRINHRYMEZmbVRNYUUrWHpIamZhOEQwOWZV?=
 =?utf-8?B?ajZUZDR4SC9rZVp3cVlWd1ZWbnl2Z1hqN20xdXpWejNvamxKcFoxTjkvRTQr?=
 =?utf-8?B?RWF0b3J6YzkvM2RYZzhTZ3hwck5oNi9leWEwVFJsVnRxeHNwM2FWVU5nS0Yv?=
 =?utf-8?B?U3BaVEpmNUFQcG85Ny81eXFhK3dPSnl2SGVLYTNCUldyUjh2T0VEcDU0dnhV?=
 =?utf-8?B?S0w3alkrbCt0SGRBWE0rVGxEalkrRVdFYlRwUmpTSWJHaEp6czd6emRrQmtM?=
 =?utf-8?B?VzI2SzRQNUlodDdXNmd1WGZLVWNwWXFCVmlhQU1tTG80SzFXMGtXWFN6SXZs?=
 =?utf-8?B?SlZ3Qnd3VUxCNE44ZEJnVkZaZDk2aEt4THV2VjVQOGRteml6cmk3Q2EvVVZp?=
 =?utf-8?B?ZG1VMCtaVm13TnVMVk81V0pLVktJYUdxNkEvUG5vcUxJY3VGKzlBZlVuOWN4?=
 =?utf-8?B?alpPcXZ3Vk8zR2UwcUh0Uno1QVVGYnpEOFNDdk9GUTFNRVRrREtjb2VJRzQy?=
 =?utf-8?B?dUhsb0VjOXJudURGMGxWUkFsYllrM2tiTVRvQTlDTGtKcGQ5Nkt1ZXA2a2JD?=
 =?utf-8?B?NXhsNHNYV0JCV1pJbFhocW5sK3krZEl3c0ZPTDdseitrOHZyWFR6cVZQbVZ4?=
 =?utf-8?B?YWFoYXRoN1IwVEVMamRxQkFTOWJBVXVRYXFWQ1o4N2lPclFsWVd4dEljZnNY?=
 =?utf-8?B?a3AxeHBOVVh0VHFLdEljQVIvdDUwUTljT1Q1a2FWOG90eTcwYm5OcUFLQnF5?=
 =?utf-8?Q?QaRqAMiDGDnGa9zfvwxTgkvpy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f33733-07a0-4446-1b12-08db918fddb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:32:09.1493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V+iS0u//dmjVEJ7/lF5x7mkutF+3fVQ/Ocxkd+jvGLVVvQWgfrqfVipVGURMCX1D8TBVYAMsT6w1EY2H3ct5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
Received-SPF: softfail client-ip=40.107.244.63;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 30/07/2023 19:25, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/16/23 10:15, Avihai Horon wrote:
>> Changing the device state from STOP_COPY to STOP can take time as the
>> device may need to free resources and do other operations as part of the
>> transition. Currently, this is done in vfio_save_complete_precopy() and
>> therefore it is counted in the migration downtime.
>>
>> To avoid this, change the device state from STOP_COPY to STOP in
>> vfio_save_cleanup(), which is called after migration has completed and
>> thus is not part of migration downtime.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
> Have you tried this series with vGPUs ? If so, are there any improvement
> to report ?
>
Not with a vGPU.
But I tried it with a ConnectX-7 VF and I could see up to 6% downtime 
improvement.
I mentioned this in the cover letter.
Do you want to mention it also in the commit message?

Thanks.

>
>> ---
>>   hw/vfio/migration.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2674f4bc47..8acd182a8b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -383,6 +383,19 @@ static void vfio_save_cleanup(void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> +    /*
>> +     * Changing device state from STOP_COPY to STOP can take time. 
>> Do it here,
>> +     * after migration has completed, so it won't increase downtime.
>> +     */
>> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> +        /*
>> +         * If setting the device in STOP state fails, the device 
>> should be
>> +         * reset. To do so, use ERROR state as a recover state.
>> +         */
>> +        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> +                                 VFIO_DEVICE_STATE_ERROR);
>> +    }
>> +
>>       g_free(migration->data_buffer);
>>       migration->data_buffer = NULL;
>>       migration->precopy_init_size = 0;
>> @@ -508,12 +521,6 @@ static int vfio_save_complete_precopy(QEMUFile 
>> *f, void *opaque)
>>           return ret;
>>       }
>>
>> -    /*
>> -     * If setting the device in STOP state fails, the device should 
>> be reset.
>> -     * To do so, use ERROR state as a recover state.
>> -     */
>> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> -                                   VFIO_DEVICE_STATE_ERROR);
>>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
>>
>>       return ret;
>

