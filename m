Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE9706506
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEHW-0002zt-QF; Wed, 17 May 2023 06:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzEHU-0002r8-CS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:21:16 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com
 ([40.107.93.46] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzEHR-0000w0-MN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqmcBI9BxIQF6f+buNuLBpqgyjDgXmNOwXXzahr8lRbk5RJbUXlot5FAHeCBXg0MHOM8pEKGoTeiUVmXte5u1bICmiOWiFW8Teb4gqPqwjZmpERX2C88NHoX3Q4nUbnlQOo2a6vHGgualf3O/hh9hYl4q1OOwwxljEUW/UNdl/bN4F/PFX7+8usTcG/VbbvlqBJhEMB8LN3t2yKNdOwGmCW936WsdKGZCg0m+T3O6/yIAS9Yv+c5Jy22hAMDOF1Y0ti/srBLgmxv9bu+kh+HMKLZe8AQCPdkmw23fJLYg5+NjYK1Jz4NlLQCqQPYpJVwCOHy43YApa364O24xClEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P23RIEhXivLVeyO2G5Z/ovOy7hd/6iua6ecsPzZmIpA=;
 b=O1oNfpPEw3XicKm0xAt8th4Yx3YBiyJH7H5EINCcWP9WD0nWRqANndXNsZgg8YL4ByqOjrwfBs/LZW82LbncdRMN910BO2rr6yviXiEniphWVU3QbO10HFSCeTGkUkC44k83FOG+jIRAya4EjN7y1yPiDkDllx01qIjEX9rpinO3InXKXvFV0aTaJk34M6VZkZZzUnrEkVku38val6GDnluS5/WBRZ24C9a8FuFcnPIHL1i4I2wrjD3T5akhA83gKTTIKOCH5oTTSakVdeSRYvwVMaODm/f2UxmC2xfi2CSq3+FZDybMVQNDVnjbi9aAyRTKKhAvo6F/Rejx+sE+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P23RIEhXivLVeyO2G5Z/ovOy7hd/6iua6ecsPzZmIpA=;
 b=VZ4EHtxiWvjUIwSEG7XSk+RovAKNGDQ6Zq8ph/r0KLXzHOp39sNEMqXe+2TVXdowpPm1GiEqIzdrYk/lOex8T0n9EYNyJ/X/WAVnTaiOfOkK0Qg1xWtrGugH0UHytH4aAMikdEo7fTW7OhcJdV9W7HK3c4TqK95nsczY8Iq8AdlRHtiGo7lkfY2by+mjharxisjUhiUfVb1NQw/iD1nEr2l/WudsBPBsSRRwzQ2SUMOvke99U97DngbVKVNboRU4wsSyPC4cUbTiw/qQhKJlHwa8LFoQ1vsp9lqjVVegwBum2TWJXR/YRk2uUe72RjbUoSpXOtVf3M89m79DOzceZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 10:16:08 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 10:16:08 +0000
Message-ID: <1836389d-0774-08a1-ef54-8487d238fe73@nvidia.com>
Date: Wed, 17 May 2023 13:16:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/8] migration: Add precopy initial data capability
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230501140141.11743-1-avihaih@nvidia.com>
 <20230501140141.11743-2-avihaih@nvidia.com> <87lehn71wm.fsf@pond.sub.org>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87lehn71wm.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0405.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL0PR12MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: c60d6587-b7b2-4f79-af1b-08db56bfbb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs+7C03mftTSq9fvZvKvKtyBoC+kyrKJOkG5/ONT5LcC+Kaq+JHlyoPINLBu6Sif4nHus5G1I8+WX5cRTBUzOT/is2sHlXlTVsb3Ua9/K8qonrzkoZwZY+xQnUZBWA5+epfDB9lEFyNKGEWGy3uQyCTZGimREFKjSPaXlLgzcLH+Q4RKtWh7zVOVxlR/Icz0cJeRsApn4z1RBJIR+2CTq5ZxiubHMeOt8JK8KbuRw7kjM+ryKSEKTRRawfysZ7RRHCJxNQDYoesrTkzjzpc5FX5RHGMvracTJuVwWkExvfcaf+X2UH37y52fKdjgzQjOzKSkIlOk2NsvZSECXwwn9+8rEpwei3cIm50JTFGNyFy5kDzHyHm459C1BN0ljLeJTiia9FuRGN5tGFYz5zFlxQhKacJvtypTCGzvYfOVlRjWIBATxZzsy0J+uBpk+Qr1CGwgAoEPa+IcV3fsMThwPaHeqghvydKPrJYCz0RmjESqgHdpnFmBPLEeN8PLV9zfsO5QDrM5S2cmbHlY1npDiPTRbwATryUCHv8hYaex+njg8eZJQsWAn89tSqjbLB47f60e7gIbvmGNjFG1dkiO8xnPsv9/T3RsTB17irDGOGvVa/tPRuyB6AUNTZrcP6vrlxe+kjolc0rZkdiu8+oArA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(31686004)(6916009)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(54906003)(36756003)(31696002)(86362001)(83380400001)(6506007)(6512007)(26005)(2616005)(53546011)(186003)(41300700001)(6486002)(5660300002)(8936002)(8676002)(7416002)(2906002)(6666004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlqMmpBMC9Id05CWVEzd1BKWEpLZkFpTXdRL0ZDeTJMbm0xL3hzeWRHUnNw?=
 =?utf-8?B?RWhmQTBVSDNqTXlvOVNDRHFjQTNKMXN5RjZaZnY4YllValZ4bXRwYlFBTmhK?=
 =?utf-8?B?RFRHcFM0T0pkQk5yeThQZVVYYk01d01ha0pxQnlGRGVzUzhjaWsyVDVpTW1j?=
 =?utf-8?B?TWdzQVp2SEtFa0NWWDU3SWNjaVU4VlI1Zm5TN3JVMkt6SklxMjVXOVRIb1ZS?=
 =?utf-8?B?VDQ5Mm4vaWVDMnVQRlJVckdOMUVGUDB1TWNYMDhqcktLT25XWDN6Z3kvdk5S?=
 =?utf-8?B?ZFJQemgyOTNjTEZoTksrakRzdXlVQjdERnpySk5ab1JTckJYWGJRWmVrWVdN?=
 =?utf-8?B?K20vcVU2dUFzV1kwYTBjbHdzdkxNTExBN05NS3dRR1lDZmUwOVozNHg3enRH?=
 =?utf-8?B?QUxaSW9TSHhSTWYzRW1UaVU4a05pNzg1RFFaWm5NTEhQZXdYMTI2aEFVSHJF?=
 =?utf-8?B?WmRoTE1CR09zQ0lkNDJqdkJFVDhLZEFpYzBHMGZqRVJRc0QrUUdXR0FoU2lq?=
 =?utf-8?B?YitldlY2cHRCc1dTSUd5elcxbWZpMXJ4SUFUWS9DMUxHUVE2K092d2tHQnZN?=
 =?utf-8?B?cUpUMURCN1p2MW5EcVZnaGR6cXhlWEpaWHRvRVBYeGRTSG9ZblZNeDl5alRq?=
 =?utf-8?B?QVUrb3VKL3pHYklHSjNlYUdYMTJ0WjJYeTNNei8vdC9xQXAvem9UY1V0N2Ro?=
 =?utf-8?B?SHhxS09ySlpLWHY5R1RBQXFwNThCampCbDFNY3NFTFNrYjN1MUVZOWFDc0sx?=
 =?utf-8?B?TFlOTTkyWkdZbGs1b25PNm1sWEZZUHJKQ1BCSTdRY05OYTR3bVpwRDVLUFJN?=
 =?utf-8?B?d3FQeTRYNERzd21pOG1IY0EvMTJNOVdhOGVOWDVOZE0xa21aS3FSRnEyK1Ew?=
 =?utf-8?B?N3doc2dmbEI5UlpjRitsM1JvSVRKWFZvcFpadUgyTitHN1hZcncwbDM4OEo4?=
 =?utf-8?B?bktBV1BDeTBhcUw2Yzcrd3lDVlo5bVRZMy9QQ3JCaDNjSHdVRXNYOGRtTnlq?=
 =?utf-8?B?V1JiMG8xY2lRQ2cvRzhsWG93T0x1MVRITVlUZHRTczhrWnNubUJnT2hjdmN0?=
 =?utf-8?B?NFVkbmJDdGw3VERxMmJWQlVEelVCZmM0c1RLNEhYL1U3Q2NVOFFRSVNVbE5a?=
 =?utf-8?B?dUYzSVNqbHBEU09TcjZRTzdvcHhWWHpXWUgvQ3UwRWordTNoaEphWTdWVUFo?=
 =?utf-8?B?VFdzZW96QTF1azVaOUNkdEJQSHFNcDV4cHVZeDdOdUQ1b0E2TVFRUm1hcHJT?=
 =?utf-8?B?aldQWm16YjRlVkoyYy82TzlUZzlmZ3dSV3B3eXZPMEpwdTBzZUFVNStBcDlS?=
 =?utf-8?B?NVB1aGh2cjMrN21wS0N3RDU4KytqYjNOQWR0TklrOXJrVkh0UVlRY2szMStJ?=
 =?utf-8?B?aFhyeUZtY0c4aEVQOEdsdWFuRkhYUWgyNmRrelhoSUFMeEVNaHVvcVVrbUF6?=
 =?utf-8?B?M3RJek1qeW5MdGxUdzdEWDd6MU45dUJzL0JJZWJKdlQ5amJCbHNmUmJSckFm?=
 =?utf-8?B?R3czTXhtdXlYeHdRa2laYWEvUXAvL1NkcUMwYysyVVpUVkI1NU8yOG1Xc3FK?=
 =?utf-8?B?UEk1S25nR0dtMzUxYUQyMFhkQ3oyeEIvLzk3VklOczFsMnM5d1J1M25LSklq?=
 =?utf-8?B?QTlrcjc4ZjVVSmZMWmRjOHBNajFpZCtUZk5Ca1h6TWlVVGxxOTZSdlJ4M0xr?=
 =?utf-8?B?bDdqK0xGb1lhZWswcWJqTGtudEpkem15Uk5xOEFzYm1wNktwa3BZaDdQbjRZ?=
 =?utf-8?B?YWYvWG9mNVBNYmZHNnRlSzlvSGJGeHk2RjdYRkQ0cnRZdkpnYnVnVkppelJ0?=
 =?utf-8?B?YzZWdythdmFpak43Rk00cExNdStxSFRtZlBrNXdTSHQvanBhcVkwajliNytX?=
 =?utf-8?B?SERSNGViZnQxTHJrNzJVTkpBYXNQbHMrakwxSW51T3NiV2lLSU9xMUxOeUNx?=
 =?utf-8?B?N3J3MlhLK1JBMDNpL3pwRm9KSzJJS0x4Wk8zZnNreC9kVklEaEdndDAwRWZ0?=
 =?utf-8?B?RHEvbk83YnpCSm5RZXRBdS9ySnJ1a3BINnAwdTR0M1NSSllpTHZOd3FNblVz?=
 =?utf-8?B?czZzY0NPaUphVjd4eWdvNVU4cXkvV2xXaUlqcjVKUU1oMUhIMWJDcmFpUXJt?=
 =?utf-8?Q?Uy1ZlBDxnkMi/T9p//5/8atO1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60d6587-b7b2-4f79-af1b-08db56bfbb25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:16:08.3844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39BCVoP9sLBJloU2yEObvjdWC6GtFNNT7hATQwX8+JSunpQs+Bv47EiYcG/s2btzmI5rat8HSsV7ncC84fZhoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
Received-SPF: softfail client-ip=40.107.93.46; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 17/05/2023 12:17, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Migration downtime estimation is calculated based on bandwidth and
>> remaining migration data. This assumes that loading of migration data in
>> the destination takes a negligible amount of time and that downtime
>> depends only on network speed.
>>
>> While this may be true for RAM, it's not necessarily true for other
>> migration users. For example, loading the data of a VFIO device in the
>> destination might require from the device to allocate resources, prepare
>> internal data structures and so on. These operations can take a
>> significant amount of time which can increase migration downtime.
>>
>> This patch adds a new capability "precopy initial data" that allows the
>> source to send initial precopy data and the destination to ACK that this
>> data has been loaded. Migration will not attempt to stop the source VM
>> and complete the migration until this ACK is received.
>>
>> This will allow migration users to send initial precopy data which can
>> be used to reduce downtime (e.g., by pre-allocating resources), while
>> making sure that the source will stop the VM and complete the migration
>> only after this initial precopy data is sent and loaded in the
>> destination so it will have full effect.
>>
>> This new capability relies on the return path capability to communicate
>> from the destination back to the source.
>>
>> The actual implementation of the capability will be added in the
>> following patches.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   qapi/migration.json |  9 ++++++++-
>>   migration/options.h |  1 +
>>   migration/options.c | 20 ++++++++++++++++++++
>>   3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 82000adce4..d496148386 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -478,6 +478,13 @@
>>   #                    should not affect the correctness of postcopy migration.
>>   #                    (since 7.1)
>>   #
>> +# @precopy-initial-data: If enabled, migration will not attempt to stop source
>> +#                        VM and complete the migration until an ACK is received
>> +#                        from the destination that initial precopy data has
>> +#                        been loaded. This can improve downtime if there are
>> +#                        migration users that support precopy initial data.
>> +#                        (since 8.1)
>> +#
> Please format like
>
>     # @precopy-initial-data: If enabled, migration will not attempt to
>     #     stop source VM and complete the migration until an ACK is
>     #     received from the destination that initial precopy data has been
>     #     loaded.  This can improve downtime if there are migration users
>     #     that support precopy initial data.  (since 8.1)
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).

Sure.

>
> What do you mean by "if there are migration users that support precopy
> initial data"?

This capability only provides the framework to send precopy initial data 
and ACK that it was loaded in the destination.
To actually benefit from it, migration users (such as VFIO devices, RAM, 
etc.) must implement support for it and use it.

What I wanted to say here is that there is no point to enable this 
capability if there are no migration users that support it.
For example, if you are migrating a VM without VFIO devices, then 
enabling this capability will have no effect.

>
> Do I have to ensure the ACK comes by configuring the destination VM in a
> certain way, and if yes, how exactly?

In v2 of the series that I will send later you will have to enable this 
capability also in the destination.

>
>>   # Features:
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>>   #
>> @@ -492,7 +499,7 @@
>>              'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>> -           'zero-copy-send', 'postcopy-preempt'] }
>> +           'zero-copy-send', 'postcopy-preempt', 'precopy-initial-data'] }
>>
>>   ##
>>   # @MigrationCapabilityStatus:
>> diff --git a/migration/options.h b/migration/options.h
>> index 3c322867cd..d004b6321e 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -44,6 +44,7 @@ bool migrate_pause_before_switchover(void);
>>   bool migrate_postcopy_blocktime(void);
>>   bool migrate_postcopy_preempt(void);
>>   bool migrate_postcopy_ram(void);
>> +bool migrate_precopy_initial_data(void);
>>   bool migrate_rdma_pin_all(void);
>>   bool migrate_release_ram(void);
>>   bool migrate_return_path(void);
>> diff --git a/migration/options.c b/migration/options.c
>> index 53b7fc5d5d..c4ef0c60c7 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -184,6 +184,8 @@ Property migration_properties[] = {
>>       DEFINE_PROP_MIG_CAP("x-zero-copy-send",
>>               MIGRATION_CAPABILITY_ZERO_COPY_SEND),
>>   #endif
>> +    DEFINE_PROP_MIG_CAP("x-precopy-initial-data",
>> +                        MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA),
>>
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> @@ -286,6 +288,13 @@ bool migrate_postcopy_ram(void)
>>       return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM];
>>   }
>>
>> +bool migrate_precopy_initial_data(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    return s->capabilities[MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA];
>> +}
>> +
>>   bool migrate_rdma_pin_all(void)
>>   {
>>       MigrationState *s = migrate_get_current();
>> @@ -546,6 +555,17 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>           }
>>       }
>>
>> +    if (new_caps[MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA]) {
>> +        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
>> +            error_setg(errp, "Precopy initial data requires return path");
> Shouldn't we mention this requirement in the docs?

Yes, I will add it.

>
> To make sense of the message, the user needs to make the connection from
> "Precopy initial data" to capability @precopy-initial-data, and from
> "return path" to capability @return-path.  More helpful, I think:
> "capability 'precopy-initial-data' requires capability 'return-path'".

Sure, I will change.

Thanks.

>> +            return false;
>> +        }
>> +
>> +        /* Disable this capability until it's implemented */
>> +        error_setg(errp, "Precopy initial data is not implemented yet");
>> +        return false;
>> +    }
>> +
>>       return true;
>>   }

