Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CD7242A4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VyZ-0003m7-Dy; Tue, 06 Jun 2023 08:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VyV-0003Hd-HX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:39:47 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6VyN-0000op-C8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WciAQYphOyVC33ByOj8forBf81whtBLiS2kCIUTTXMgycADqKSXLMTdL8zH8qMSYgLt+SyJFwpSXxh3dGiHx2gWKrzWHmONZWHpwV5cV/rEPn1A5umMRH+SzpgSln4USFbDlKVGKAyiH3WN7W/apPS7X32ijYea79WTKN0Yfb8t634gr97KDA5pwB8Df7RXOpKJHA8dGPsYpxwqpsp5yTrUmrGTBkIKEID3lqTU5k+MSC3M5JXIQSLMc2iyLTeOdXKpluWqB8vckECjGhJg22YAtpucbkBNLH5JXK9A6ewYmQW38wUQ5OxAhm+f5QCj0nQWZaDV4kV8VW7jtKqr5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljVmvxJ9VkbI3vorTEMNr5MIjkruoYMyKNgcEssXrBc=;
 b=m/tWfpt8S3Gm++ea+PQE1zugCNr3vAS7kCdgPVcqStSo+w0CRrrjfYnZ6rHCfy3DLJrz5j69jMd3eNhNOAAPNtzcbwE9EQUOPbD/4JePOY2qvs0t9ezKY3d8xlEJRF8G2EI1r1ZZsoGPJM5hrmvi1/WMXhfD/2eS1w2/+VdiZArZNoq8vDD64E5Zex0W984wg47XFaARWmKLpG7f4XRtKRo00OXilkEKl0r4IxvWSVIwpzBLhUj3hWVYW4DsJLzNd62R9OmuVSf1QxHJGaJpzS9XUaVIoVyz1fwT5FjFe+SngGH0oRAX3YWQ7ugCDN4celA3Dc1JJ3OyWsxQ1OFDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljVmvxJ9VkbI3vorTEMNr5MIjkruoYMyKNgcEssXrBc=;
 b=Jw2NMSXbx8mrFti3N3EFVF3nyVcm9XmL/DB2ymTCBC+rOlawWkKxs7hAOtbbt8O3x3E8THsOECWC0o8tZJbgs38luVGVIwNph0zgITIBIqa9u8EJrs/HLp8RbZYi75nUgGGsucMhFatDvMyybzzFvcgbD+LTEwca4LEBw+kluYnAPflyN+Dq8DJbJyevz7CpPxgqersLD0uR0GNrFtDxMIF6aXq6zMOzCSRpv2t68MTLUWDKHR5+cqyZeeMN0oQN3N53NL23U957zWtOGK09LSZ6aAkmWrhQsfUcBtHBsIx9JBvoZt97CTTb1Scscav8Z5T/J4a/iYCAoyg+Gf1MPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 12:34:31 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:34:31 +0000
Message-ID: <0a0c4cb8-042f-a1a1-f283-1b5ba14a0805@nvidia.com>
Date: Tue, 6 Jun 2023 15:34:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] migration: switchover-hold parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
References: <20230602144715.249002-1-peterx@redhat.com>
 <20230602144715.249002-2-peterx@redhat.com>
 <0c459f0c-1a04-f460-2b51-e8c3f997370d@nvidia.com> <ZH4IFK7tq47Ympze@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZH4IFK7tq47Ympze@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e22e43-acfa-4ec7-d145-08db668a5fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1uCLuvr3b647RIhwR7vYJ730p1PAhg21mrBzwPnHWNq79Rm6Qzz3cexrGSZM9iI+6kKpYSKANz3yT47ZupjcLXzgtgbOhCBr4olqqOib0URA/LQpXJUEBm4WX8Ws4iOPjWdl57AtvLgBL4zPI6aoL1hKwWaSJMpa83vZYs4dwHbCCmavpCzILuNuY8VCMC74akXslqq8gZquBCaVKWjKyoMF2yR6wZe++gOhLjFjKX7iWtTiPGs7aE75ax/E8ZiHvHcyH1k/XxmTp2iJKV9NDooLHJvrt1mGr9ZVEosWLQIFrz9GXar3qJLY6NwyInQuSnbh7TcKcTS5qZYCVC4x2MQ+hFKAjyJ0rEBmeT9vqeiDaKRnHMlQgeWY4h4OY86xgduDn1DWGGixZnRDt4K4U85MwR1tDvMcHx/iY5jJGa2bRe0ktPKVSpRsK6fCg8rMV6YiXwruMSgO5Fv+9paUf/6u7E9pwDulJ6PjWQd85aM3RbWtqhIyKs4lLDsUCmrpmVafjwX5PnUz9NQDHRwHzVOhnDfmCkC1kwMqfL7AQobHDpIfqOUyhP1v2aMA70HTFkfn2aMOrRx19psvEkdAWcfwPXL/30xmk0IyIrqAhcEdD4sasfr0H7KwQxikgStDooFoVh7igUUoMWKk4kUzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(54906003)(478600001)(6916009)(8676002)(8936002)(4326008)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(966005)(6666004)(26005)(6512007)(6506007)(53546011)(31696002)(86362001)(5660300002)(2906002)(36756003)(66899021)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhLVCtqaXluM1Q2KzVnMUcxSHBxRWpoT01KWUxabE9CdjRpZ2hZVUtpbHRh?=
 =?utf-8?B?WjBFMDRIMnBRMjVTeU5DN285VUk0b2VVbk5OSjNYYXphRll2UmJ0K05LRlB2?=
 =?utf-8?B?RlBzdVJuRUVrSnRXZWMzNkUyR2ZjOWtERk4vb0x3ZTVuRkpHMjE3Q0Nib0NR?=
 =?utf-8?B?Q1B4Uk4rRkdmL0ljQ1loVjM1VFA5dlh1WjJxVTN3YlRMbCtvdERnbjlnNW1P?=
 =?utf-8?B?UmV1UXhVSzNIUXpIanFveE9PVitQa2d6VHFMTk5QWHlONDhYOUF2S2Rnb0FZ?=
 =?utf-8?B?Z1dHWGpjSDg1bWtCRXFFQWs5dktFWUhaS2ttdk5hTmlwVGUyT2lHb2c4aldr?=
 =?utf-8?B?MTRiYUZjZFBqbXM4Q2dKNStvcWk0RktXTU81aU81THpOMmFKOU1zaVplUENS?=
 =?utf-8?B?N3N3U1BqaTVNWU5HSEIzbHpDWTNRQ3hadWxkODdqYy9OVlZzSmM3S1QvdXJE?=
 =?utf-8?B?SFdwQjhPVHRUVTZMUHF4eDRscXlSTWt0RkZtVjBtZHRKODkrRStyOHRvMS91?=
 =?utf-8?B?eFhWeC9BdnpUTWlveXFRcVg3aGtGVG9OMWZBc1dCMjUrZFJRT2hUUG1SMmJt?=
 =?utf-8?B?VkkzUm5DT3dQcE05M0NlQ1pqQ3lEK1VVdENEckZieDBBRWNJYXZTVm1EVzVO?=
 =?utf-8?B?T1pWZFlsU2VVbUpOUTVTd0lFcDhKYTBSVXBDNlF5UjlsZ3pCLzNrazUxQUl6?=
 =?utf-8?B?bllUWVlEYlRXWDhOWk1WOVB0bE5pRWpka0krMzUzTUk4OWhnZ0JiQjZlRzBN?=
 =?utf-8?B?TStoTG9PWkxWem9QUTRjNGRta3pVVzRQb3R5bkQwWGwyb0FVdVdDWGFlSm5I?=
 =?utf-8?B?WGJ3Rmhaci9SNkplYVBQenhNQmpoZmRnWlA1TldUR1dtNzBWZjNCdlhRZ0gx?=
 =?utf-8?B?MHFBWHZ1dGk2T05sTHF6TFpzcGszSWxuTURCZkFENWZvMitNSXVtY2Vidnhs?=
 =?utf-8?B?KzRDdWcybStiM0NLbW9EenZVMDNhRFFEWFJyRHFDajdkOUFicnJNc0VZdFhG?=
 =?utf-8?B?V2RpYmN0bHUrbmUzM00vUGhVNFVDajZrZXl6NEl5T1dwb0hWeWs2dGYwZzBJ?=
 =?utf-8?B?YlFRSm5NYUMwdU1URldVN1VhdHNvVkpzUVZmSzZkb1ZIZDJxenBXeWVhTER0?=
 =?utf-8?B?ZzlWTEF5TUhSYytOa3BFNlJNa0FTSGRXWGpPYUY0cjhLTkdoc01oZ2ZhN3A5?=
 =?utf-8?B?U3NoTDEvVEJIeHJ0WnNtOEFtRitaN3FlcXNIYTZIeVJuNFNFSmNWZ09OL0ox?=
 =?utf-8?B?eWZMWXQxNDEwTkpYQ0tCeUJRUTlXQWdOT3hNS2dGUkRZd05sbm5YRmtlc2VB?=
 =?utf-8?B?TFpmcFowNU9XUk8vZkVpczBQZDIzUWZWY3VJS0VxTjQ1RDBmN3VlL25VeFNa?=
 =?utf-8?B?RlpMTVF1bHIwdFIrUEYxaGVDMmhER0VTS0ZKZE9uMU5PZGFSN1ROd2pZUk5C?=
 =?utf-8?B?bFdMbEhNQi94NDByakdIQ01NZGtiNmJDTTlRUHVPSW5zN1JDNUNzV1NWZTc5?=
 =?utf-8?B?dm5oamJxYVV2MzlpYnlRZm1aaGxERGllSWlmMHZVeXIybHN6TVdDN2NVVDU0?=
 =?utf-8?B?dVlkRE8xWGtUeGIvWnl4d0h3NURjUUJpd2MzVTREYTNJSzZsODd3MGZLZTFx?=
 =?utf-8?B?TmdGcEVNak1obThpRk1lYW9iSmxIb3ZjcThoSzEybUFwY2c5Ym5sWEFvcU16?=
 =?utf-8?B?QVgxaXpySy9LL0F0OWp4eVdPU2hUNmxQVE5vQVV5M09iOTNXeldGbjRGenR5?=
 =?utf-8?B?Rk0vWkNPQllqeThLS2VZQ1V4RkVoeTNhVnJ4L2gzTGFWVXFFa2ZCeXRnYnl5?=
 =?utf-8?B?WHU2WVRXblVtQjRWWFB0SGVGL3NIOHNveXEzYXlYYnV0NGVNNUhDMEFaMnJz?=
 =?utf-8?B?clFFTzRYQ1dyR0hMbm9wMEJQSlp1Q1EvRWlnem16M3d3ODk5ZlcvR08rTTcz?=
 =?utf-8?B?VWpwZVNZNEl4YTNWZTRJU01aRnQvVzB5bjNsOHppQktrV2RITHhwUU9YaFZh?=
 =?utf-8?B?dnZsQklQQjBicXFLK0hnYkREekVHMXhiZmlNRnE3bFdab2dHTjZuczRkVy8r?=
 =?utf-8?B?Tm5XSnFPSTVIZ1cyUnJIalJoa0dvVDFMbVZuV2NhaFplUXFrVDEwUTNNNlFK?=
 =?utf-8?Q?TPsyauzIJLQOeQjs2/quZGVWk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e22e43-acfa-4ec7-d145-08db668a5fdf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:34:30.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXFua01jFrjxp12cM78dr8hjCAvViVqyos/U2rHKa6j8CnEPIJtnXPiarUE1Oiqsa8vEewZ/vYtuGy3UIX087g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
Received-SPF: softfail client-ip=40.107.236.40;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 05/06/2023 19:06, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jun 05, 2023 at 03:27:53PM +0300, Avihai Horon wrote:
>> Hi Peter,
>>
>> On 02/06/2023 17:47, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Add a new migration parameter switchover-hold which can block src qemu
>>> migration from switching over to dest from running.
>>>
>>> One can set this flag to true so src qemu will keep iterating the VM data,
>>> not switching over to dest even if it can.
>>>
>>> It means now live migration works somehow like COLO; we keep syncing data
>>> from src to dst without stopping.
>>>
>>> When the user is ready for the switchover, one can set the parameter from
>>> true->false.  That'll contain a implicit kick to migration thread to be
>>> alive and re-evaluate the switchover decision.
>>>
>>> This can be used in two cases so far in my mind:
>>>
>>>     (1) One can use this parameter to start pre-heating migration (but not
>>>         really migrating, so a migrate-cancel will cancel the preheat).  When
>>>         the user wants to really migrate, just clear the flag.  It'll in most
>>>         cases migrate immediately because most pages are already synced.
>>>
>>>     (2) Can also be used as a clean way to do qtest, in many of the precopy
>>>         tests we have requirement to run after 1 iteration without completing
>>>         the precopy migration.  Before that we have either set bandwidth to
>>>         ridiculous low value, or tricks on detecting guest memory change over
>>>         some adhoc guest memory position.  Now we can simply set this flag
>>>         then we know precopy won't complete and will just keep going.
>>>
>>> Here we leveraged a sem to make sure migration thread won't busy spin on a
>>> physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
>>> its best to sync with dest QEMU from time to time.  Note that the sem is
>>> prone to outdated counts but it's benign, please refer to the comment above
>>> the semaphore definition for more information.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    qapi/migration.json            | 25 +++++++++++++--
>>>    migration/migration.h          | 16 ++++++++++
>>>    migration/migration-hmp-cmds.c |  3 ++
>>>    migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
>>>    migration/options.c            | 17 +++++++++++
>>>    5 files changed, 111 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 179af0c4d8..1d0059d125 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -779,6 +779,15 @@
>>>    #     Nodes are mapped to their block device name if there is one, and
>>>    #     to their node name otherwise.  (Since 5.2)
>>>    #
>>> +# @switchover-hold: Whether we should hold-off precopy switchover from src
>>> +#     to dest QEMU, even if we can finish migration in the downtime
>>> +#     specified.  By default off, so precopy migration will complete as
>>> +#     soon as possible.  One can set it to explicitly keep iterating during
>>> +#     precopy migration until set the flag to false again to kick off the
>>> +#     final switchover.  Note, this does not affect postcopy switchover,
>>> +#     because the user can control that using "migrate-start-postcopy"
>>> +#     command explicitly. (Since 8.1)
>>> +#
>> I think this should wrap at col 70, and need double space before (Since
>> 8.1).
>> Also in other places below.
> I don't know that rule; anywhere documented?  It seems true for qapi/.

Yes, it's specifically for qapi. It's documented here [1].

Thanks.

[1] 
https://lore.kernel.org/qemu-devel/20230428105429.1687850-16-armbru@redhat.com/

>
> Obviously I forgot to copy Markus and Eric at least, since this is qmp stuff.
>
>>>    # Features:
>>>    #
>>>    # @unstable: Member @x-checkpoint-delay is experimental.
>>> @@ -800,7 +809,7 @@
>>>               'xbzrle-cache-size', 'max-postcopy-bandwidth',
>>>               'max-cpu-throttle', 'multifd-compression',
>>>               'multifd-zlib-level' ,'multifd-zstd-level',
>>> -           'block-bitmap-mapping' ] }
>>> +           'block-bitmap-mapping', 'switchover-hold' ] }
>>>
>>>    ##
>>>    # @MigrateSetParameters:
>>> @@ -935,6 +944,10 @@
>>>    #     Nodes are mapped to their block device name if there is one, and
>>>    #     to their node name otherwise.  (Since 5.2)
>>>    #
>>> +# @switchover-hold: Whether we should hold-off precopy switchover from src
>>> +#     to dest QEMU.  For more details, please refer to MigrationParameter
>>> +#     entry of the same field. (Since 8.1)
>>> +#
>>>    # Features:
>>>    #
>>>    # @unstable: Member @x-checkpoint-delay is experimental.
>>> @@ -972,7 +985,8 @@
>>>                '*multifd-compression': 'MultiFDCompression',
>>>                '*multifd-zlib-level': 'uint8',
>>>                '*multifd-zstd-level': 'uint8',
>>> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>> +            '*switchover-hold': 'bool' } }
>>>
>>>    ##
>>>    # @migrate-set-parameters:
>>> @@ -1127,6 +1141,10 @@
>>>    #     Nodes are mapped to their block device name if there is one, and
>>>    #     to their node name otherwise.  (Since 5.2)
>>>    #
>>> +# @switchover-hold: Whether we should hold-off precopy switchover from src
>>> +#     to dest QEMU.  For more details, please refer to MigrationParameter
>>> +#     entry of the same field. (Since 8.1)
>>> +#
>>>    # Features:
>>>    #
>>>    # @unstable: Member @x-checkpoint-delay is experimental.
>>> @@ -1161,7 +1179,8 @@
>>>                '*multifd-compression': 'MultiFDCompression',
>>>                '*multifd-zlib-level': 'uint8',
>>>                '*multifd-zstd-level': 'uint8',
>>> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>>> +            '*switchover-hold': 'bool' } }
>>>
>>>    ##
>>>    # @query-migrate-parameters:
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 30c3e97635..721b1c9473 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -440,6 +440,22 @@ struct MigrationState {
>>>
>>>        /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
>>>        JSONWriter *vmdesc;
>>> +    /*
>>> +     * Only migration thread will wait on it when switchover_hold==true.
>>> +     *
>>> +     * Only qmp set param will kick it when switching switchover_hold from
>>> +     * true->false.
>>> +     *
>>> +     * NOTE: outdated sem count here is benign.  E.g., when this is posted,
>>> +     * the 1st migration got cancelled, then start the 2nd migration, or
>>> +     * when someone sets the flag from true->false->true->false.. because
>>> +     * any outdated sem count will only let the migration thread to run one
>>> +     * more loop (timedwait() will eat the outdated count) when reaching
>>> +     * the completion phase, then in the next loop it'll sleep again.  The
>>> +     * important thing here OTOH is when the migration thread is sleeping
>>> +     * we can always kick it out of the sleep, which we will always do.
>>> +     */
>>> +    QemuSemaphore switchover_hold_sem;
>>>    };
>>>
>>>    void migrate_set_state(int *state, int old_state, int new_state);
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index 9885d7c9f7..63a2c8a4a3 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>            monitor_printf(mon, "%s: '%s'\n",
>>>                MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>>                params->tls_authz);
>>> +        monitor_printf(mon, "%s: %s\n",
>>> +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
>>> +            params->switchover_hold ? "on" : "off");
>>>
>>>            if (params->has_block_bitmap_mapping) {
>>>                const BitmapMigrationNodeAliasList *bmnal;
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index dc05c6f6ea..076c9f1372 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2693,6 +2693,55 @@ static void migration_update_counters(MigrationState *s,
>>>                                  bandwidth, s->threshold_size);
>>>    }
>>>
>>> +static bool
>>> +migration_should_complete(MigrationState *s, uint64_t pending_size)
>>> +{
>>> +    /* We still have large pending data to send? */
>>> +    if (pending_size && (pending_size >= s->threshold_size)) {
>> The parenthesis here are redundant.
>>
>>> +        return false;
>>> +    }
>>> +
>>> +    /* The user doesn't want us to switchover yet */
>>> +    if (s->parameters.switchover_hold) {
>> Should we check this only if we are in precopy? I.e., skip this check if
>> postcopy is active?
>>
>> I thought that this parameter is all about precopy switchover, and the fact
>> that it prevents stopcopy from reaching migration_completion() is just an
>> undesired side effect.
>> As I see it, if this parameter is set then precopy switchover is hold off,
>> and if on top of that a user starts postcopy then this parameter is not
>> relevant anymore - we should start postcopy and ignore it for the rest of
>> migration.
>>
>> Does it make sense?
> Yes, it matches more with the doc update indeed.
>
> I didn't bother with that and added flag=false in the postcopy tests in the
> follow up patch because logically a postcopy user shouldn't even use it
> (also per the doc), but I can also make it strict here as you said.
>
> Thanks for taking a look!
>
> --
> Peter Xu
>

