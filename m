Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A876B5DD
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpRM-0002pb-It; Tue, 01 Aug 2023 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQpRL-0002pR-69
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:29:31 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com
 ([40.107.92.41] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQpRI-0008Ep-9n
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUW/IlnTBwSjzijAa7n9b1RizHyHYNx7ryb5RO6Mp3jjGU+xxicCQDe6pJM7ttEsIg9dD4/gGCq32c5kV9ANBEo0/IyZgkHylE0AxodHL47VkzFxYXI0D0VjrMscjh/fujwmvr+16A6fFvHdcuiRKG7waYhvTPrzxx4T1VJxVf2TtjsOmNbhf8REYaJwksHr1hhn5iA/osqGXFG6XMIK2aTdSciCu/c3Tx71ABiJKhBLZZRIwBIeq5i+wUpYYy70aUA9KHofmG/CETq4zKLsFy4/awgq/IkHH5oeg6DOJ5UkXK6peBkWz6D97sWTrZP3JpweOqqISvREXbExdF46OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVgu8HYvUfjwkn+YwHNpIWojB7ZxbcJhcfz2yiYNMmQ=;
 b=cZOjGYArVlUPcNkkKZASQVgUFVk8SPNb6wzgYc2Tx3sPxBZzuL04a7J3HMYIYRtraNjUVb9ow5+u7QqI4zy0UTuxlrA/Osz7kxgDFlugwMiecElctSrnInJ9dlbp69C/1UUte6Rn8ek+Rd2tsT45477sOV4dssN79fZEymP//inmZCccfKKRBCmdR5Am0wgrnOMFw40nRo9m6sCow9NVtX/7vzPNwEUV72weNOuE04T6jcksik7xZt1KNH7z+ea1v2vjCoGSWU6hggZMn/bOCaustp+1ZairLJtf9nXLuVi94/HfDUf1JVGCHR8PoxBguV9GqjEPqSPBn+lebFkxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVgu8HYvUfjwkn+YwHNpIWojB7ZxbcJhcfz2yiYNMmQ=;
 b=NXg10kvn1hAz+XRzwTn+/tnXgCsy6wyrN0KHCpZf5+HLMGBJJfUZ/U51a+mFawsrAtkeybtKDot70kpP7UA6dhJs4/a1G5AZ8Es1Y8dqlF9fAC5z0+oDZKXtFaTkI50XMYLNzEWlxSzWzN+dZ8i88Pc7W2GoJU5T7hjC2SIHO/83P+eaWzpGClDSdl3V8YwfMOEPeLN4ji8yuIsS2oZqrA9IOd5etZBDDK/Cn8YAdpO29TGf64zAwU1knUkqWIRUCZjtFtTcaIn21lhjGRFdJWpr9gUBiDL5EDIswnlpACEid5zZGW14PzjBQeQDZgDmk+A2XWFViPhNcBMvrtc6ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:24:19 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:24:18 +0000
Message-ID: <87fcaf07-372d-abab-7140-fe901e05bd99@nvidia.com>
Date: Tue, 1 Aug 2023 16:24:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v2 5/6] vfio/migration: Add P2P support for VFIO
 migration
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
 <20230731102521.15335-6-avihaih@nvidia.com>
 <977f0fae-5dca-c56c-e740-739e2a984a7e@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <977f0fae-5dca-c56c-e740-739e2a984a7e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: a475b6bc-ea07-4389-b353-08db92929c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fH/IIUThGIKj37cSuG+oS+mvhWqCHz2P3EMSgG/ujXYJAVzpBg1MEOPJsMNvREbi7pwHc6Y4G7biASoGVq0lYZKoyWc6d4VKW4FcI8KYq3pNC3qqb1xNiDRh8Tx6oAaKtYb45tm1qC1iiKfqhz9VkwdiwThR1+XbWKUvalT//9wM/m50507ZWQNK1A7lnWZdluMWLI9NWEjoz0GuBzS1Y8nN0SXCfZGGEklJSJ2X7qWEzU0a3mVeZG2VR6Lhtqf01iDNKF2PdekJG+hAK5kyM+vH0Neh4jLfzQ8kwjfrfd+BI182jvm2Xijqxa/ygD8icjmgLMezrwfIuknclbnqX53whnXzRYMV5S9ShOgRRmRI2bWZp2YByorq/uVfYiH3gNhzBskIUuBvarBpeJQt0Erl0mZNRmk7fStxduiPxBSn0HvZutLYB/D87cf5KUipE1Q3rHMkVRVjn377ZooQPGnL1/4HTmWWjXM6GWLaGTO/P7Wt4qf86zpfrPK4NvLq+a2v1df/a9mrCmcFGUWHqD8ic8ImGPKInj1z9V8TzL3WzyocJSahItWM9KstHTSgp96VK7xu9I4aOMHO4qvtXEJxlfH6/EKGwnprk5y30TMJ9CUclNTjQhS1xC+gLDWGYhRSj/I81K7wtm6Fw6b+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(8936002)(8676002)(31686004)(36756003)(6486002)(41300700001)(478600001)(30864003)(2616005)(2906002)(66574015)(6666004)(26005)(83380400001)(316002)(31696002)(186003)(86362001)(6506007)(5660300002)(38100700002)(6512007)(54906003)(4326008)(53546011)(66556008)(66476007)(66946007)(107886003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJ6VnJEVXZiaG1XV3o5T3lVYVo4b2Y1c3BRYUk1SE4wdW5ReGZjMldYajgr?=
 =?utf-8?B?RnBDU3JqdGtnRm96US9NNkVkS01UY1hzUHlzUU9QZWJFSzJLWUhsWXlwY1NI?=
 =?utf-8?B?ODYrTjhQTDE4NGN3RjBjYW85SkpsTFRIMU9zenZnL04vcjI3OFBJUUdjdEh6?=
 =?utf-8?B?blBSd3RsVytBclh1SnluOFBVU0hVVU5WVVF6SXcycUVyQmlzWjlqbitDSGJM?=
 =?utf-8?B?YVdzWmNLTXY4a1YwVTF0b0VlTm03WHFJMnVuOFlvR0Y5Y2tyMlI3Mll6bitX?=
 =?utf-8?B?NFhVc3pSUGNTV0I5dXJyaTBUN0RKNUZCNGpVaWdPbkt5cHRDT1VHSyswS3N2?=
 =?utf-8?B?YlJnZTk0Z0c0b0ZTb1UwaGRqRmxaN1BqL21DbUtRYnFHWC9jUlU0KzdyYUhn?=
 =?utf-8?B?Zm56TU9raWxnUGg1MldDaEQ4bWNHK0k3WW1UVmJxa3RQQ3AzMFVuTVl6WlBn?=
 =?utf-8?B?QU4xSXpIN1l3WUZiV3VZYjJnT0QraCtEYVMzSk84OU5tR0sxYmgyTHBJa0FI?=
 =?utf-8?B?TkZCQkpmM3drem1XZkVuTHgzOWJrb1BDNVEwdE1kMjh4cC9XeVZQZTE5aTM4?=
 =?utf-8?B?Ui84T09jZW8wTDBJbTROWXVqRmtyeWtjSDlDSkRnWWhMWUF0S3R1YXE2aVZw?=
 =?utf-8?B?NGVjS2tWVXVqcEdwUlZDejJCb3h4ODN2cDdLT1NZRWNGalVTd3UvazlUVnFS?=
 =?utf-8?B?UFM0UFJwVnN3dlFhdlBXZ2hMRUN5QjZYL2YybWMxZmsvVTQ4bmp3L3FuYUdD?=
 =?utf-8?B?Q3VJTEFneS9mV25wYVJKU3NTSUE1MXZmajZEcU5UdU5yZkFmMndaZWticnR0?=
 =?utf-8?B?ZnBVZFQzcENrOCs2b09BeUxYWnR0VTZReFBZZFhGUCtZMUNKS00xRHJwTS9E?=
 =?utf-8?B?OGtqMXprWk5NSkV2anQ4VVExRGJQSEsyRHNpY0RvcnRVdU9FVFZGU3NVS2Jl?=
 =?utf-8?B?V0dkL3hXRTlGTHYyYlNaaHE2YzROaVJtbXNtenFsZ3dNWjNXWFowYnF0eDB2?=
 =?utf-8?B?SzB1Z0xyVDNVT25LQVJFQlZkMUNNT05UMEJhSnlibUczN3JhYTFwVnlnMHZT?=
 =?utf-8?B?RXdQUjRuM0pqN1NhbTcwL3RYTENrWExiTUkrM1FqdE1xT2lkL2hLMjE2aEhN?=
 =?utf-8?B?U25QdjNLaW9ETnN6a3FUUVByVHM4am9Da3FyTTJOeVVPRGtIcGdiU21wN1Br?=
 =?utf-8?B?OW1lb1NFK3BzSnRiMFJSdjRCKy9xMUUzS3RQWDZXTlAwcG5zcEJCK0NrNUxm?=
 =?utf-8?B?K2U0WlBlN2RYMUtNbkhzcnJBcmlTUGJrVEVJVVFBN0g2eXp6aCtVaW5hNkw4?=
 =?utf-8?B?cE9Fa0ptRXRWR09RT2N0YlNPUWlYY05veEptdEduUjdEL0NnN0FDemRCRVd5?=
 =?utf-8?B?cVFZZ3pZSjhjcDhTMnVBMVFkcFBXVkcvVHNkdzk5N0MzOVV2Zm1RcVI4TVA2?=
 =?utf-8?B?enE3aU5XTzVmTnZXWG54N3FpRjQ3dmZDSXgwSUZROXMyLzhlVENNMjcxVU5E?=
 =?utf-8?B?SzZWV0VXZkRvUFBCelNIcTFXb2R1dUIzSTNJVW5Bb1p4dmhSdzV1L01uRS9P?=
 =?utf-8?B?Q2xkK2NpS1Bkd3RoS0FXRmVOd0ovOVhVV25WaWwyc1llT1g3UytKNUQzMjk2?=
 =?utf-8?B?Z3V6dVNCbUI0aTR1czFxNDRIK2UxZGszdm9zNWtWRlZ6ZldtY1NxTWZYSDho?=
 =?utf-8?B?YWtDbWgzNEhZL0JIdE9XM0oza3ZNUGFiWEJOaWxWVzYrSUFmQUs3MUFCUFJC?=
 =?utf-8?B?TGs5V3Q3R0J3TXpQeHp3UGlhbG5UNit1YzFFYU5oaXJkWDFsdUNsdmkwbEtZ?=
 =?utf-8?B?QWNJQXB4Sno4b1A0VGczSjNISmd6aDh0eU8yWHhEZlhFZHVhQUcvd1RMQ2U4?=
 =?utf-8?B?eGFKdWlmS045RWp2N0FkT05ISHA1Rlh4aThxNVU3OUNWVnJIUXZTb3BQZVp1?=
 =?utf-8?B?YlZiR0pXcms2YnlwcSswclBTSitTWDVXbkhNM1hXNlpTcFZkU1lrUHNkVnBL?=
 =?utf-8?B?akErYmptaGg4SkE4ZFlWWHZwdjJDeUgzQWlMUlJiQWhsdmczZ0h3Vk5VQk9j?=
 =?utf-8?B?MFRuOGh2UWlpK3BCMGZVa3R1dWhtTHpxNXlpOGhZMzlraUJlczdmRGhBQ1Jz?=
 =?utf-8?Q?uxCpQgJpz0qwfIk7rHCcExv6V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a475b6bc-ea07-4389-b353-08db92929c12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:24:18.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9AxXCbPY6TVi+kbexIPec9buDxtSSSoxSrJKfUAqcYrHK8d/d4ZOxT2Y3GOK7CcJuPjQagR0x2Zx2dK1P7WCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
Received-SPF: softfail client-ip=40.107.92.41; envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 01/08/2023 15:02, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/31/23 12:25, Avihai Horon wrote:
>> VFIO migration uAPI defines an optional intermediate P2P quiescent
>> state. While in the P2P quiescent state, P2P DMA transactions cannot be
>> initiated by the device, but the device can respond to incoming ones.
>> Additionally, all outstanding P2P transactions are guaranteed to have
>> been completed by the time the device enters this state.
>>
>> The purpose of this state is to support migration of multiple devices
>> that might do P2P transactions between themselves.
>>
>> Add support for P2P migration by transitioning all the devices to the
>> P2P quiescent state before stopping or starting the devices. Use the new
>> VMChangeStateHandler prepare_cb to achieve that behavior.
>>
>> This will allow migration of multiple VFIO devices if all of them
>> support P2P migration.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
>>   hw/vfio/common.c              |  6 ++-
>>   hw/vfio/migration.c           | 47 ++++++++++++++++--
>>   hw/vfio/trace-events          |  1 +
>>   4 files changed, 106 insertions(+), 41 deletions(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index b433cb5bb2..605fe60e96 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and 
>> loaded in the destination
>>   before stopping the source VM. Enabling this migration capability will
>>   guarantee that and thus, can potentially reduce downtime even further.
>>
>> -Note that currently VFIO migration is supported only for a single 
>> device. This
>> -is due to VFIO migration's lack of P2P support. However, P2P support 
>> is planned
>> -to be added later on.
>> +To support migration of multiple devices that might do P2P 
>> transactions between
>> +themselves, VFIO migration uAPI defines an intermediate P2P 
>> quiescent state.
>> +While in the P2P quiescent state, P2P DMA transactions cannot be 
>> initiated by
>> +the device, but the device can respond to incoming ones. 
>> Additionally, all
>> +outstanding P2P transactions are guaranteed to have been completed 
>> by the time
>> +the device enters this state.
>> +
>> +All the devices that support P2P migration are first transitioned to 
>> the P2P
>> +quiescent state and only then are they stopped or started. This 
>> makes migration
>> +safe P2P-wise, since starting and stopping the devices is not done 
>> atomically
>> +for all the devices together.
>> +
>> +Thus, multiple VFIO devices migration is allowed only if all the 
>> devices
>> +support P2P migration. Single VFIO device migration is allowed 
>> regardless of
>> +P2P migration support.
>>
>>   A detailed description of the UAPI for VFIO device migration can be 
>> found in
>>   the comment for the ``vfio_device_mig_state`` structure in the 
>> header file
>> @@ -132,54 +144,63 @@ will be blocked.
>>   Flow of state changes during Live migration
>>   ===========================================
>>
>> -Below is the flow of state change during live migration.
>> +Below is the state change flow during live migration for a VFIO 
>> device that
>> +supports both precopy and P2P migration. The flow for devices that 
>> don't
>> +support it is similar, except that the relevant states for precopy 
>> and P2P are
>> +skipped.
>>   The values in the parentheses represent the VM state, the migration 
>> state, and
>>   the VFIO device state, respectively.
>> -The text in the square brackets represents the flow if the VFIO 
>> device supports
>> -pre-copy.
>>
>>   Live migration save path
>>   ------------------------
>>
>>   ::
>>
>> -                        QEMU normal running state
>> -                        (RUNNING, _NONE, _RUNNING)
>> -                                  |
>> +                           QEMU normal running state
>> +                           (RUNNING, _NONE, _RUNNING)
>> +                                      |
>>                        migrate_init spawns migration_thread
>> -                Migration thread then calls each device's .save_setup()
>> -                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>> -                                  |
>> -                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
>> -      If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>> -          If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> -                  [Data of VFIO device for pre-copy phase is copied]
>> -        Iterate till total pending bytes converge and are less than 
>> threshold
>> -                                  |
>> -  On migration completion, vCPU stops and calls 
>> .save_live_complete_precopy for
>> -  each active device. The VFIO device is then transitioned into 
>> _STOP_COPY state
>> -                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
>> -                                  |
>> -     For the VFIO device, iterate in .save_live_complete_precopy until
>> -                         pending data is 0
>> -                   (FINISH_MIGRATE, _DEVICE, _STOP)
>> -                                  |
>> -                 (FINISH_MIGRATE, _COMPLETED, _STOP)
>> -             Migraton thread schedules cleanup bottom half and exits
>> +            Migration thread then calls each device's .save_setup()
>> +                          (RUNNING, _SETUP, _PRE_COPY)
>> +                                      |
>> +                         (RUNNING, _ACTIVE, _PRE_COPY)
>> +  If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>> +       If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> +                Data of VFIO device for pre-copy phase is copied
>> +      Iterate till total pending bytes converge and are less than 
>> threshold
>> +                                      |
>> +       On migration completion, the vCPUs and the VFIO device are 
>> stopped
>> +              The VFIO device is first put in P2P quiescent state
>> +                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
>> +                                      |
>> +                Then the VFIO device is put in _STOP_COPY state
>> +                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
>> +         .save_live_complete_precopy() is called for each active device
>> +      For the VFIO device, iterate in .save_live_complete_precopy() 
>> until
>> +                               pending data is 0
>> +                                      |
>> +                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
>> +            Migraton thread schedules cleanup bottom half and exits
>> +                                      |
>> +                           .save_cleanup() is called
>> +                        (POSTMIGRATE, _COMPLETED, _STOP)
>>
>>   Live migration resume path
>>   --------------------------
>>
>>   ::
>>
>> -              Incoming migration calls .load_setup for each device
>> -                       (RESTORE_VM, _ACTIVE, _STOP)
>> -                                 |
>> -       For each device, .load_state is called for that device 
>> section data
>> -                       (RESTORE_VM, _ACTIVE, _RESUMING)
>> -                                 |
>> -    At the end, .load_cleanup is called for each device and vCPUs 
>> are started
>> -                       (RUNNING, _NONE, _RUNNING)
>> +             Incoming migration calls .load_setup() for each device
>> +                          (RESTORE_VM, _ACTIVE, _STOP)
>> +                                      |
>> +     For each device, .load_state() is called for that device 
>> section data
>> +                        (RESTORE_VM, _ACTIVE, _RESUMING)
>> +                                      |
>> +  At the end, .load_cleanup() is called for each device and vCPUs 
>> are started
>> +              The VFIO device is first put in P2P quiescent state
>> +                        (RUNNING, _ACTIVE, _RUNNING_P2P)
>> +                                      |
>> +                           (RUNNING, _NONE, _RUNNING)
>>
>>   Postcopy
>>   ========
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 16cf79a76c..7c3d636025 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice 
>> *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> -    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
>> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> +           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
>>   }
>>
>>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
>> +           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>   }
>>
>>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 48f9c23cbe..05b1dac2ed 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -71,8 +71,12 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>           return "STOP_COPY";
>>       case VFIO_DEVICE_STATE_RESUMING:
>>           return "RESUMING";
>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +        return "RUNNING_P2P";
>>       case VFIO_DEVICE_STATE_PRE_COPY:
>>           return "PRE_COPY";
>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>> +        return "PRE_COPY_P2P";
>>       default:
>>           return "UNKNOWN STATE";
>>       }
>> @@ -652,6 +656,43 @@ static const SaveVMHandlers savevm_vfio_handlers 
>> = {
>>
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>>
>> +static void vfio_vmstate_change_prepare(void *opaque, bool running,
>> +                                        RunState state)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    enum vfio_device_mig_state new_state;
>> +    int ret;
>> +
>> +    if (!(migration->mig_flags & VFIO_MIGRATION_P2P)) {
>> +        return;
>> +    }
>> +
>> +    new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>> +                    VFIO_DEVICE_STATE_PRE_COPY_P2P :
>> +                    VFIO_DEVICE_STATE_RUNNING_P2P;
>> +
>> +    /*
>> +     * If setting the device in new_state fails, the device should 
>> be reset.
>> +     * To do so, use ERROR state as a recover state.
>> +     */
>> +    ret = vfio_migration_set_state(vbasedev, new_state,
>> +                                   VFIO_DEVICE_STATE_ERROR);
>> +    if (ret) {
>> +        /*
>> +         * Migration should be aborted in this case, but 
>> vm_state_notify()
>> +         * currently does not support reporting failures.
>> +         */
>> +        if (migrate_get_current()->to_dst_file) {
>> + qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
>> +        }
>> +    }
>> +
>> +    trace_vfio_vmstate_change_prepare(vbasedev->name, running,
>> +                                      RunState_str(state),
>> + mig_state_to_str(new_state));
>> +}
>> +
>>   static void vfio_vmstate_change(void *opaque, bool running, 
>> RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> @@ -798,9 +839,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>       register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, 
>> &savevm_vfio_handlers,
>>                            vbasedev);
>>
>> -    migration->vm_state = 
>> qdev_add_vm_change_state_handler(vbasedev->dev,
>> - vfio_vmstate_change,
>> - vbasedev);
>> +    migration->vm_state = qdev_add_vm_change_state_handler_full(
>> +        vbasedev->dev, vfio_vmstate_change, 
>> vfio_vmstate_change_prepare,
>> +        vbasedev);
>
>
> We could also avoid registering the prepare handler if 
> !VFIO_MIGRATION_P2P.

Oh, right.
I will remove the check from vfio_vmstate_change_prepare() and add it 
here instead.

Thanks.

>
>>       migration->migration_state.notify = vfio_migration_state_notifier;
>> add_migration_state_change_notifier(&migration->migration_state);
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index ee7509e68e..329736a738 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -167,3 +167,4 @@ vfio_save_setup(const char *name, uint64_t 
>> data_buffer_size) " (%s) data buffer
>>   vfio_state_pending_estimate(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t precopy_init_size, uint64_t 
>> precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" 
>> precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>   vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size, uint64_t 
>> precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 
>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy 
>> initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>   vfio_vmstate_change(const char *name, int running, const char 
>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>> state %s"
>> +vfio_vmstate_change_prepare(const char *name, int running, const 
>> char *reason, const char *dev_state) " (%s) running %d reason %s 
>> device state %s"
>

