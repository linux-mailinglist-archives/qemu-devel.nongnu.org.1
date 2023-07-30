Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2576840B
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 08:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ03K-0004GU-JK; Sun, 30 Jul 2023 02:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQ03C-0004GL-Ko
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:37:11 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com
 ([40.107.237.67] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQ03A-0004hd-Cf
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdnxaEMSAd6i4MOL6NRUtKKumPSQ4XNgrHjj+v8/LbhSyUCCYPyYFd3WMtJmJtRfdWuifU0Cc5XJfKl20cBHKr9mrCaTs+szvwsnSAOF5ZQOCQpz6lxB47aza6zZcxATR390x0rPslhLID1XfWKsRuvg3DpnNnoEN9ZavCmV2qubL69fXKxKR1XZYz6EKmBaOKZMUP+WhheiJ94TcuKzHbVvWlTOkBRDESkm0VRwcQuc32dwGU0cq7+kCekGbvVow7a+RDCUII81wwkvzG7ZMkquYNH3pKkL9IU2PQkynn7RZo7d+TwN6x1L/aVASZfXXwo/mbQgfAgh9Nrx1NlVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+79EKyUjGvIKMPy8MEhp3DYySgmEDc773QJ0wByG7lI=;
 b=NxVV1pDKlmCnpliKJdYoVsPKELBP1hCBqk/ZQGpjVCYSe6ZR1h203vZr9KlTbbKCuc49vK7EzNWAf6P+7Pn9AuqLgnZUAuJQLmjqQaQe3zlOOS1ocHgnuJrD3ki49Z+u+1sKMtSnRkMDyN4D7YxtfGp/qCj1NN2UvnUPW3+kqtgDg80McIbM702bhGj/GEnNAVvf7GEDzWYRAx1pbiw5ORjWR5wyPQs3lkmKlE3IMipCfH/fvFMGeKjHG9DBdkOAMbgPhTDIbsHSzGvXevdURNFpe4Gho3Wm7qgpIhPVUW85tbkh+7XgDpuRbEcHktu82nExd6DssMhWHwijD2cUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+79EKyUjGvIKMPy8MEhp3DYySgmEDc773QJ0wByG7lI=;
 b=F0dNxhsdJuDO+xdkL0eeirHfPmmtpcSsy9y3xHjSVTD5k82nCkViakXWAIp0bIaGUjeNwOBpOawgtSnrBCDTmZa1Np/zJKjnkhOH8Aq3pbaRoMkAHzwksNs7Vkdx9Lgcx0n68d5mXgchtihn7so2O/XYk1tJHD7KJRTh7RZQZLVKVX2qSHGSJCGFpOq3dFUnYJdMAWzxVRqHEUUx8AKRKHH4n6fJ2NQNUJT4ImFacQ50oiPL2Hk9AhwqsTzAQFiFdyEcdFdcJyZFWAlXX162AHWTt5oLwC4sgPMKHyLAy+1k8sl0zvIKqF5/DVVbCrV18OOwPKzkdY0Un7MMS+nPog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sun, 30 Jul
 2023 06:32:01 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 06:32:00 +0000
Message-ID: <0562c698-3223-005a-e63d-ec94126f0448@nvidia.com>
Date: Sun, 30 Jul 2023 09:31:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/6] sysemu: Add pre VM state change callback
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-3-avihaih@nvidia.com>
 <ea781305-fba3-83eb-aac9-fdef6a81b5c9@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ea781305-fba3-83eb-aac9-fdef6a81b5c9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f959713-c9e4-4be8-7d8f-08db90c6ae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7K/YoebskGk7YfdKR1ekpu1OHVXmfcUhqUV1E3xIiotDKfq3JEPfIxjd0VsZvQjtM7x4OsNjEi85QPCCM5O4uXaxrB7DXudspBIy0RT4vjORx+yfPixJEujsfaBEXFu/vTz908uuzcoJ90zimqbPaie4uDc3o69Zb1JqAaiBXXeLiIpOPwr8fd7+yrMb3nrL/Ydz2NRmcoc6TgSg1lU65nQ1JPunHed8Vyfw1J99yr+bbm+BxCmMUeVVKfV0aczbYX/oqt4LNbQrJ3zliFCLG6oI/FrU+eMvvxIgKMoDMAkkWCFXNmeebgfzjUEC98xeACR6DAVH4tKVRBG+seyy5t2Cfa03WpzMR4BnDUEzQyoJLwH/Y2OrB//NDiK98sTEikIqWqNpKF7AJSZyRX85xUHFQcNvRxAe8GJN5QSDLIWqe4sYJzy0kyF3WVbX307gPtPig/4euta3LF4/15PPaK/dhLmECqppRmzuK3cOPTLnFQcgZtvcsRUk9Z2hC9bKJ32lVs4E2sH3NN2Te5UH0drwb7QkkxrCJ9wrl6YR4JbEaesznPc+/UOTBaK/PErGvNG+7BAsu0EvPQZrKKt931pGv4lEeQCfvAwHdjHekbPsqhTwc+Co6aHaybEbfcCXrCV3sMYbTmNOXWHjC6fmfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(66476007)(66556008)(66946007)(4326008)(6666004)(31686004)(5660300002)(478600001)(6486002)(6512007)(316002)(54906003)(38100700002)(31696002)(107886003)(86362001)(41300700001)(8676002)(8936002)(26005)(186003)(53546011)(6506007)(83380400001)(66574015)(2616005)(36756003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpnaFVkWmZRNjN4ZnJYUDIxbVhGK25lM3Q5VXZwNUFvRTY0d1BTUHIraDRO?=
 =?utf-8?B?eGRLN1lLRzV6UjNJOEhGSHg5N3dxbDlNSzlqcVhzQWFYZUlZSFRmRmlkc1lj?=
 =?utf-8?B?VWw3UjZ5aTRtTS85TGxFMmE5VFRtNndLQ3dsRi9vT0g4WjZaOEt3R0RQaG9r?=
 =?utf-8?B?eXlnQmEvU0RDc01BR3RpUlhpUHkyeGx5dHZ0OGxIS20yY0ZCM1RPNnZPeVN6?=
 =?utf-8?B?ZVVwZW1hUWhKNzRNZXBqdmNwemJoSllIUlBLSWxJVWJJKzhxZitYYkJjVjlp?=
 =?utf-8?B?VHZ3cG90MEFBRnZkMVpYcUpIWWs3M3NSOXpJczdZLzhkdXhTQXZRQ25IKzZ4?=
 =?utf-8?B?WU41ZTJYakhpSHAycldZMzhjVllPOUFGY202dytwWENlckRqTFpUV1p4QW5F?=
 =?utf-8?B?MFgxQW9NQVdtQW5OZU9FM1NOb21tWDdVTk53NjBhNy9hSnNMQW5NTHRPTTE5?=
 =?utf-8?B?MVJUbnArZE1CS29aVHRYaDA5Zm4rN2tUODNwVnBMYUdWQWNXZnRtRC9TRnhF?=
 =?utf-8?B?WGFDWDE5VnpqeXNPSWVlYjRZTEVHWDcvWE5HMFhqa2EzRytkbkIxYlRkL3R2?=
 =?utf-8?B?N1FUZFFiVTRHeXVjVzhYc3RrblpjZ3FrTDEvYkZDRU1JbGQ1QUdKN25UeTl0?=
 =?utf-8?B?M3NTZ1RQc2pvMFYvR3NoNjJMTjU0THp5c3dic2pGNGY2NXQ0ay9tMDAwQ3Ba?=
 =?utf-8?B?S2k5dGZBRVliZ2FHTzR1OUhzcnQ3R05KL2xreGNNaHJXNmZ3MDM3aTgrNU4r?=
 =?utf-8?B?WUpVb1NRaHpySHMyNmJOMTJuUXhLVjNObUlZQTdZbnVNNkNWaHY3c0wwUmc4?=
 =?utf-8?B?Y1JmZEV6cXpyRWQwbkQxdXlSaGIwbGhvNmNsS2F0TkRhcFdGVHRiQ3hjVCt1?=
 =?utf-8?B?U3I0U2RQZmkyTklpY1U5aDc0NmpYU1FVMFd3RG1yRnY0eTNNRm44eHhQVDVD?=
 =?utf-8?B?RlBueUZ5T3ZoRURoU0lnZmtxdlJLQ0NuL0VLVHdtN0hERVZFRkc5M0w2cVV1?=
 =?utf-8?B?emZUaVJranFzRjB1Q2xvRjA4WnROOWZVVGxhNlp6b2JpUC95aHVqcDRFUkJI?=
 =?utf-8?B?dmNPVXIwRi94NXhlc3BMa2xqNU1xTHpYZ25jWk51ekowZVZsQ1JtTWp1L212?=
 =?utf-8?B?SHNJK0lxSWl4N0Rwa0sxa1N2TVAyWGNobUhwT2t1VStBVi84TkhpUGVJZDRU?=
 =?utf-8?B?WmJpVkRxTnNVTVhwYWltUWdEcG5MbElKajViQmJHeWxSdHUyY2dZNlZBYzMv?=
 =?utf-8?B?RzF5TlNENlZYT1IyTGhPRXExVS9JeGxQZDFSL2xWcVUwa2VDcnlqMzJ6cWx5?=
 =?utf-8?B?SFBkSDVHREs3VmFLVFhMUlY0REJyTUIxanB4VGNpeEFuQVRPVXVJcmRlUFlZ?=
 =?utf-8?B?SWh5aUNtcmZtREFMcDJGejVtN2VOa2g1VFNXYWpidk1XUzJQTERLN2NHL1Nz?=
 =?utf-8?B?bUVWZHF4VkRmNFNMWDNKS1h6Y2VaQUFEY1JBS0hkdXljb3pheTkwbGNLcFE4?=
 =?utf-8?B?VFRWSjNQVXlnd2sxd3dwZkpOdmkzU0hGcnhQdzZibTBiSkZzQUZLb0FuT2FN?=
 =?utf-8?B?WHZvOFFQSHpEQTAvV00wOS92a0pRNHQ2RmFiQ1cwSWhlWjV0Z0xVTFVrNC96?=
 =?utf-8?B?VzJhbm84UEdTZTg4eDMvcnlPMUwzMmRJaVVmalI1NkVDMlJQeEZ6Z0c3aGxa?=
 =?utf-8?B?ODFDY3o0ZzNkMkgvckQ0WTE2OTczb29pRlVxVjRyU0RwODJTN2lnRnYyRW54?=
 =?utf-8?B?UVA1SGtva2tRN0NQNUVLQTVqYmpiMmZHOGtpMDNpbVNUVVRKOWU5SzV6MlY4?=
 =?utf-8?B?dzFRYVZGV0ptaWxQS3c5Q05QSmZIdzhBNFMwOVFIVi9ycmlLaWJsMWJOYW9X?=
 =?utf-8?B?Q3YyM29oVHhVZ0MxRkwreGFOOTNUWEVwa3B2Vmw2em5NdE43clV1VlBFZFMz?=
 =?utf-8?B?elNHNHMzM1FVQmg5VlkxMHg1aDBIQTVCZ0hFODh1eEpLRmRTcTJVRzdqVWJQ?=
 =?utf-8?B?Z2V2SU1BeWZjOTlNNlF1ajcxaVhxZzVkczUzTHNXK0xZLzdkR2ZlVDVwbmFL?=
 =?utf-8?B?aDh2OURoZGZpQ1hCWmdXSEt3WTYzMERra0J4Y0VrdjQvZkl0VEt0VThHYTVZ?=
 =?utf-8?Q?pRt3mld73CyBf/NHj7SWrAfwB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f959713-c9e4-4be8-7d8f-08db90c6ae48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 06:32:00.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdrEv+8TGW7F4jtFaahfgUfRVQ6lZETM7jDGCRegs60nCS3QK7EItfz3zWlACt2bZiysvjR3peu+6cG2JbwvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
Received-SPF: softfail client-ip=40.107.237.67;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 27/07/2023 19:23, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/16/23 10:15, Avihai Horon wrote:
>> Add pre VM state change callback to struct VMChangeStateEntry.
>
> This sentence could be the subject.

Sure.

>
>>
>> The pre VM state change callback is optional and can be set by the new
>> function qemu_add_vm_change_state_handler_prio_full() that allows
>> setting this callback in addition to the main callback.
>>
>> The pre VM state change callbacks and main callbacks are called in two
>> separate phases: First all pre VM state change callbacks are called and
>> only then all main callbacks are called.
>>
>> The purpose of the new pre VM state change callback is to allow all
>> devices to run a preliminary task before calling the devices' main
>> callbacks.
>>
>> This will facilitate adding P2P support for VFIO migration where all
>> VFIO devices need to be put in an intermediate P2P quiescent state
>> before being stopped or started by the main VM state change callback.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/sysemu/runstate.h |  4 ++++
>>   softmmu/runstate.c        | 39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>> index 7beb29c2e2..bb38a4b4bd 100644
>> --- a/include/sysemu/runstate.h
>> +++ b/include/sysemu/runstate.h
>> @@ -16,6 +16,10 @@ VMChangeStateEntry 
>> *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>>                                                        void *opaque);
>>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>           VMChangeStateHandler *cb, void *opaque, int priority);
>> +VMChangeStateEntry *
>> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>> +                                           VMChangeStateHandler 
>> *pre_change_cb,
>> +                                           void *opaque, int priority);
>>   VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>> VMChangeStateHandler *cb,
>>                                                        void *opaque);
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index f3bd862818..a1f0653899 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
>>   }
>>   struct VMChangeStateEntry {
>>       VMChangeStateHandler *cb;
>> +    VMChangeStateHandler *pre_change_cb;
>
> I propose to use 'prepare' instead of 'pre_change'

Sure, I will change it.

>
>
>>       void *opaque;
>>       QTAILQ_ENTRY(VMChangeStateEntry) entries;
>>       int priority;
>> @@ -293,12 +294,38 @@ static QTAILQ_HEAD(, VMChangeStateEntry) 
>> vm_change_state_head =
>>    */
>>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>           VMChangeStateHandler *cb, void *opaque, int priority)
>> +{
>> +    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
>> + priority);
>> +}
>> +
>> +/**
>> + * qemu_add_vm_change_state_handler_prio_full:
>
> qemu_add_vm_change_state_handler_prio_all() may be. I don't have much 
> better
> but 'full' doesn't sound right. minor.

I followed the GLib naming convention.
For example, g_tree_new and g_tree_new_full, or g_hash_table_new and 
g_hash_table_new_full.
I tend to go with GLib naming as it might be more familiar to people.
What do you think?

Thanks!

>
> The rest looks fine to me.
>
> Thanks,
>
> C.
>
>> + * @cb: the main callback to invoke
>> + * @pre_change_cb: a callback to invoke before the main callback
>> + * @opaque: user data passed to the callbacks
>> + * @priority: low priorities execute first when the vm runs and the 
>> reverse is
>> + *            true when the vm stops
>> + *
>> + * Register a main callback function and an optional pre VM state 
>> change
>> + * callback function that are invoked when the vm starts or stops 
>> running. The
>> + * main callback and the pre VM state change callback are called in two
>> + * separate phases: First all pre VM state change callbacks are 
>> called and only
>> + * then all main callbacks are called.
>> + *
>> + * Returns: an entry to be freed using 
>> qemu_del_vm_change_state_handler()
>> + */
>> +VMChangeStateEntry *
>> +qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>> +                                           VMChangeStateHandler 
>> *pre_change_cb,
>> +                                           void *opaque, int priority)
>>   {
>>       VMChangeStateEntry *e;
>>       VMChangeStateEntry *other;
>>
>>       e = g_malloc0(sizeof(*e));
>>       e->cb = cb;
>> +    e->pre_change_cb = pre_change_cb;
>>       e->opaque = opaque;
>>       e->priority = priority;
>>
>> @@ -333,10 +360,22 @@ void vm_state_notify(bool running, RunState state)
>>       trace_vm_state_notify(running, state, RunState_str(state));
>>
>>       if (running) {
>> +        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>> +            if (e->pre_change_cb) {
>> +                e->pre_change_cb(e->opaque, running, state);
>> +            }
>> +        }
>> +
>>           QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>>               e->cb(e->opaque, running, state);
>>           }
>>       } else {
>> +        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, 
>> entries, next) {
>> +            if (e->pre_change_cb) {
>> +                e->pre_change_cb(e->opaque, running, state);
>> +            }
>> +        }
>> +
>>           QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, 
>> entries, next) {
>>               e->cb(e->opaque, running, state);
>>           }
>

