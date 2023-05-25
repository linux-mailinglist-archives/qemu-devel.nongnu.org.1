Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4867108CF
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:26:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27Dr-0001zC-35; Thu, 25 May 2023 05:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q27Do-0001z1-CQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:25:24 -0400
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::602]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q27Dd-0002xs-Es
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIQD8oopCyHPOxJWVmrrwy64j9mK7j8pOxIWA9Ia7nAbH97TlQTlv/G3ZGqHaae1YHCJpkeyc1YrcviStNka+2kCruIwL/J1QlkgUo9k5fHgRtVZrZ0rbXlhYC89WnwkUl89nYo66YsTnQSQKUf/t987RCaa/OGH8GGjmro0aLsGrGQqYrGLI55QLIA71DVVtX7EppW84Emmvsn5dFIowCfAclPv/ThxCy7E4x/t48hDuwkV4D6DTxz8ga7EvBdlFMEd0Lzm1uLZYsfkbIkqRf/JEplq4ev1MSea3w+cCOhDHhklSK7c6aSXI4Ou4vhMq4dOWVlXK7wo3Z4DoTZ1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d/xNET1+/gi/op+pWMunQhkPCwKGOMEnpaFOUIModM=;
 b=auwtvVn9Fqju1xkP7ZZ5C8fhERgjjMsshDr+paIfiahqM8CXzGWhKwnPt9Z32SAxbz3IMt7D1oql+hPkrmHlJb52m4iJnyRemjJh6Xktwluez6IxY90JFVve/ZyA1m3n0Aqu23a1+PyxZ1+vFawVJKoZ1DF869Gkix/Zo96Df3pfjJOKv7rdpVQKz0y0grjDXK9+gIR8OIKbvdplJhhz3huqvvC0flW8yXOlk+IeDiMeyDfJ27vXHjJvGOnvV+Ljh/+XntS9FjJxUOINv+6RJbqgw3PO7Gfx06fz2n9JKjNPDvfgMpe45l+69hcqGYUWUuq2557mkbwG1UTRNzrsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d/xNET1+/gi/op+pWMunQhkPCwKGOMEnpaFOUIModM=;
 b=aELMF91GdCZB+E/vW67SiyUQqME3Nf546P/s3WF973uqzHalT85JVHL19rzq8GGmYpsuG6LwOGve8YpiZ5EtvChntOM7YG/NF6SH+UojGUhE+luzKnqwsxzabGmJQLMLtWQ854/zkfPEhecOszd6dVa46qeL+ZSyYksqE1yC8+1cpkmUbqSceJYJxs6yBceskp0UNPyszdWQBwjjEFaL+sRZl3iG/frnKUGS4XZjwo2kfH8xE0gI9h5zup7jE5ahmLblv7eWJeQ41PhvHpbc1y17jfPIDnrAFbULMSKmREGyIvwZuWdA1MRmFpOxuJZhU60Wd2GTH/aBJHI2VyRrrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 09:25:07 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 09:25:07 +0000
Message-ID: <4da67906-11e7-9655-387e-ca9689a78b89@nvidia.com>
Date: Thu, 25 May 2023 12:24:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/7] vfio/migration: Add VFIO migration pre-copy support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-7-avihaih@nvidia.com>
 <6958827d-e9ec-4617-324c-7c9a070fad9b@redhat.com>
 <1c3dc84d-c7f3-8ec5-93ec-f5781bcd16af@nvidia.com>
 <4c943f55-0ac2-805e-ea6f-3c77e61802be@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4c943f55-0ac2-805e-ea6f-3c77e61802be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0237.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 683c40b3-02b2-4a2c-50ba-08db5d01edc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCo5oMkPTEVb9v+PfivYR8iDboYij0yBaWVanfXacFSRYbWrNvM3nKCSqQMRcsfhwd5iB/0mYyi/784jHR6w7RlxaIUh1/w3IO39Y2g5s8f2sCSkJymQbsVZ+Qf/lDMZvDqw6DVuACTPGyofTB6IbV1t9GvNg0XnCGs1XT+/dtTV960Y6pPNmC4vodVcNtzd9q9o/7Rl5iCrQ7BwKHWlsw0G9JdtMBzlUVEqqcgshxE4i1iK/rjcpNybinyiHvDWQLhxnyjbwnC7w9BpSc+1ZH3NHKM8JQkVMy7G1+C8hJkSSU6wVwUcISdzpz4rV6JHaaETVBmBFJbVdlg3mx4sXmjYolrxtcjjuLr+bcx30pP1j24futTgkaVhcqnQmJoYYJKxRRMhP/D2is/J1wzJgLAW2yGWajYKepCLe8HwuK0gUehjdvdtCh9WpXfbxRYcmaGYzhU2NMbkH3+icL6JIkEv1v1aT+bfilGNmhaxgEU18jWzNfapOyjNOFe0I8vGvvvGIIqIsyHYEkzguZr2jInQS38SzUuskq/WcYUZicHCdx1UKC08iFXKlYlEzy1cd3giqCiZ+Sc77EvQm63KVDAzZaEA1fm1+rpXD/tHs/B3BmmNDJCwCGvgyCuULhUm9nZacpJNhPIOA7TgxmMsV9DiyG7U+kFIlalRmVb6gkYTskFa2ABnue2P7Lec6g3I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(66556008)(31686004)(66946007)(54906003)(6666004)(6506007)(26005)(6512007)(66476007)(316002)(4326008)(41300700001)(6486002)(966005)(478600001)(8936002)(5660300002)(8676002)(7416002)(83380400001)(2616005)(86362001)(36756003)(2906002)(38100700002)(31696002)(186003)(30864003)(66574015)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUc5RlVXSmRVOVZNbWxNU01xYXNyZm0zcll1RGJnemFXb1lOQktvUWZRdjRM?=
 =?utf-8?B?N3MwTDVTc2NqZ1B4bXZmM0VEdFluOGd1SkZVcHVENzNZc1pHZlF2dEEvQ0Iw?=
 =?utf-8?B?Y0FqS0tjQjFjdjk1alRSNU4xZ2poeDUrcUU5MndEZCtINS9MNE9aT3orVDU4?=
 =?utf-8?B?UVBhUnJ2NjJHajgxS0Z3enpZanYvNGRqTUlzM0hNNDkrRzZPd2tPZjBicVBZ?=
 =?utf-8?B?VWxGVkwvUUlrUkdWdm5aWkRieHU1eTBWRGF6TEZvb2N3ck90dGZCMEZodmZK?=
 =?utf-8?B?Y1V2Zk52MG55enRWSzAvbFZSVGxjbWY2dGpLNitIamNVcDFodVNHWUsyeUhK?=
 =?utf-8?B?ZHVaN2JlUHlReXdpVHViM2diY3lvOTgwOWNKb3hneEY2OFFjdHNaSTFya2Rx?=
 =?utf-8?B?R1BsMHpsVStoeXNLWFdrQzNiaFhzWEFidFRmSkZEb2pqM1F0SlZTajJxeGRs?=
 =?utf-8?B?aVlBZlZjMWdyb1VCei9aRHhzZmZWeFhnd1UycjMvaVUzVzNNQ21sQjBiM2h6?=
 =?utf-8?B?WmZ2cGJQUWtaZ0pqR0JCK0djVzdjaVJYS0oyL1VrNGhaeTJFV2VzcW4zN3Nj?=
 =?utf-8?B?YTVEN00wVXZtQk5xeEVkdHRVQ09qVFNuMjlVc0FhdlpGVFkrbXM0NnNxOGRn?=
 =?utf-8?B?MTROSWI3eHpzdkdHMW5xNUg0UGJxYTc0dXVXRkxtL2prK3cwWjVkL3JmMDhv?=
 =?utf-8?B?TWFlbDJXVzJTbFZRUjNJY3drQ1RVbURkMjdUK1MxOU82UGMraUNhTDNRQmxV?=
 =?utf-8?B?b25XdTBwMDhhdEN3Z2dXL2REbUdBTjYvbWtqRkNoUmU2ZjM5VWFyRDdGNVQz?=
 =?utf-8?B?RTN1dHRIdXJxZjhobkVyaEpWdk5sbFI2MGJTNUtHSHdzZ0pLbUw2M0srMmdJ?=
 =?utf-8?B?WDRRbHRkeGRaTFNMdnZJUTNjN011VDdQdmhuUW1RWUdVRjJPaFE0dk1lOGkr?=
 =?utf-8?B?bWQ1azh4V0dzRmRlcFVqZTJIYlY2VXZjK0N0d2pFSHBkYzR0WFFrNFM0Tjcw?=
 =?utf-8?B?TTNlazJxTjZJS2dyRW1CT3VkMnl6UU1ZZlFjR3REWm0wanpMcTBNL0ptT3pk?=
 =?utf-8?B?TVdyZTEzSWp1ZFBLMEFNbEo2bmhWVTNDN3VKSlpURkN6QVJoZFR3MEdnNGVo?=
 =?utf-8?B?eEZDUkZLNDZiQWRrMkFieG5NK3JFMDRvQmJqSWlTSWtPU1Y1K3RmWXVqQjU1?=
 =?utf-8?B?RnNjQ3p2dHh2aFI5dWUra3FiS0NyOWNYKy9SanI4eHllTHZ0Y3JMenU0MTZa?=
 =?utf-8?B?OXZnQU9EaFFKUGhvMEl5dktTOHczYTJvRENSa0VRNmlrNmplcEM5RTMrYzlx?=
 =?utf-8?B?M3RqallieVdJRTZtcmZ2L1RQYVV2YnZiZmJzeHZtQUtQTmVZcDZQMmFJKzQ1?=
 =?utf-8?B?RHZmaWtWZDJlTVRmQlVuaXpJM0lteU9YRmRialJSdGFrU2xBNjJoRDVvUERH?=
 =?utf-8?B?NXlCYW9lTS9QUVBCaU5GUkF4WlNGRnQzV1lvcVEvSnJDVGY0VEpYTTF2TGJp?=
 =?utf-8?B?Mjh3OFU5U0ZHNXpRdlNOR1Zrc0xJWHZCbTNLSzZxZmZBYmE2OGQ2WE1tN2VQ?=
 =?utf-8?B?c21FRXR3c3psQXZDd3MwcERhV0gxWnNGd0MxNGFGUkU3ZDZSUHFUTGNRQ0Zn?=
 =?utf-8?B?K21MWDNtYnpnckpVQ1YxUWxtSnJLblRuQnhKZm1yQUl0NUg4MFY0SHE3QSsw?=
 =?utf-8?B?K2QxblpvMDcwc0w5S05IakNPakY1NSthZ1VTN1lGcXA2Y1Fub0wyYjd6Kzdw?=
 =?utf-8?B?QU5CVmpnV1F6TW0wK0RrU3JJWFRVbnY3S25WNmZyd0hPV29RS2VtVHdydVJk?=
 =?utf-8?B?WkFMcS94ajVmRkgxTWk3ZnJaRlVLVzFuY3BFVjU3MHdLSmY3eng1M0JxVGNu?=
 =?utf-8?B?ZkxqUVF1bDBkR3BvQUZCTStCVFQwRFdNNHNzRXJmWDBiZU5aN1o5SXFlSTQy?=
 =?utf-8?B?TW81U1VObzVFdVoySmZ6TFcvbzArQklIbm1pdFdSYW9GRFpLeFBURDduVjlG?=
 =?utf-8?B?SzBuMFd6V2NCdkU5K1o2TERKZ2ZZWTNKbWdXSTJDNnJncjlSY3hCL0Y0UjI2?=
 =?utf-8?B?V1pqR09FZ1NraVdicGxxdEZueGpPdFhDKzBNTlpSM3l4cnZDdElJU2RRUUFu?=
 =?utf-8?Q?g4GH3NO14L6oyq3u8qZqeqzW0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683c40b3-02b2-4a2c-50ba-08db5d01edc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:25:07.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Hv6jqFgibuU16n+fUNIHv7AVJX5Uoxg+4a3EPTgk+0PKNsmcW7z78sI7GdDQRiA3gtt8NEIC8OHgUZYAlpbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::602;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, NICE_REPLY_A=-0.107, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


On 24/05/2023 18:38, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 5/24/23 14:49, Avihai Horon wrote:
>>
>> On 23/05/2023 17:56, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello Avihai,
>>>
>>> On 5/21/23 17:18, Avihai Horon wrote:
>>>> Pre-copy support allows the VFIO device data to be transferred 
>>>> while the
>>>> VM is running. This helps to accommodate VFIO devices that have a 
>>>> large
>>>> amount of data that needs to be transferred, and it can reduce 
>>>> migration
>>>> downtime.
>>>>
>>>> Pre-copy support is optional in VFIO migration protocol v2.
>>>> Implement pre-copy of VFIO migration protocol v2 and use it for 
>>>> devices
>>>> that support it. Full description of it can be found here [1].
>>>>
>>>> In addition, add a new VFIO device property x-allow-pre-copy to keep
>>>> migration compatibility to/from older QEMU versions that don't have 
>>>> VFIO
>>>> pre-copy support.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/kvm/20221206083438.37807-3-yishaih@nvidia.com/
>>>
>>>
>>> May be simply reference Linux commit 4db52602a607 ("vfio: Extend the 
>>> device
>>> migration protocol with PRE_COPY") instead.
>>
>> Sure, I will change it.
>>
>>>
>>> some comments below,
>>>
>>>
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>   docs/devel/vfio-migration.rst |  35 +++++---
>>>>   include/hw/vfio/vfio-common.h |   4 +
>>>>   hw/core/machine.c             |   1 +
>>>>   hw/vfio/common.c              |   6 +-
>>>>   hw/vfio/migration.c           | 163 
>>>> ++++++++++++++++++++++++++++++++--
>>>>   hw/vfio/pci.c                 |   2 +
>>>>   hw/vfio/trace-events          |   4 +-
>>>>   7 files changed, 193 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/docs/devel/vfio-migration.rst 
>>>> b/docs/devel/vfio-migration.rst
>>>> index 1b68ccf115..e896b2a673 100644
>>>> --- a/docs/devel/vfio-migration.rst
>>>> +++ b/docs/devel/vfio-migration.rst
>>>> @@ -7,12 +7,14 @@ the guest is running on source host and restoring 
>>>> this saved state on the
>>>>   destination host. This document details how saving and restoring 
>>>> of VFIO
>>>>   devices is done in QEMU.
>>>>
>>>> -Migration of VFIO devices currently consists of a single 
>>>> stop-and-copy phase.
>>>> -During the stop-and-copy phase the guest is stopped and the entire 
>>>> VFIO device
>>>> -data is transferred to the destination.
>>>> -
>>>> -The pre-copy phase of migration is currently not supported for 
>>>> VFIO devices.
>>>> -Support for VFIO pre-copy will be added later on.
>>>> +Migration of VFIO devices consists of two phases: the optional 
>>>> pre-copy phase,
>>>> +and the stop-and-copy phase. The pre-copy phase is iterative and 
>>>> allows to
>>>> +accommodate VFIO devices that have a large amount of data that 
>>>> needs to be
>>>> +transferred. The iterative pre-copy phase of migration allows for 
>>>> the guest to
>>>> +continue whilst the VFIO device state is transferred to the 
>>>> destination, this
>>>> +helps to reduce the total downtime of the VM. VFIO devices opt-in 
>>>> to pre-copy
>>>> +support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>>> +VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>>>
>>>>   Note that currently VFIO migration is supported only for a single 
>>>> device. This
>>>>   is due to VFIO migration's lack of P2P support. However, P2P 
>>>> support is planned
>>>> @@ -29,10 +31,20 @@ VFIO implements the device hooks for the 
>>>> iterative approach as follows:
>>>>   * A ``load_setup`` function that sets the VFIO device on the 
>>>> destination in
>>>>     _RESUMING state.
>>>>
>>>> +* A ``state_pending_estimate`` function that reports an estimate 
>>>> of the
>>>> +  remaining pre-copy data that the vendor driver has yet to save 
>>>> for the VFIO
>>>> +  device.
>>>> +
>>>>   * A ``state_pending_exact`` function that reads pending_bytes 
>>>> from the vendor
>>>>     driver, which indicates the amount of data that the vendor 
>>>> driver has yet to
>>>>     save for the VFIO device.
>>>>
>>>> +* An ``is_active_iterate`` function that indicates 
>>>> ``save_live_iterate`` is
>>>> +  active only when the VFIO device is in pre-copy states.
>>>> +
>>>> +* A ``save_live_iterate`` function that reads the VFIO device's 
>>>> data from the
>>>> +  vendor driver during iterative pre-copy phase.
>>>> +
>>>>   * A ``save_state`` function to save the device config space if it 
>>>> is present.
>>>>
>>>>   * A ``save_live_complete_precopy`` function that sets the VFIO 
>>>> device in
>>>> @@ -111,8 +123,10 @@ Flow of state changes during Live migration
>>>>   ===========================================
>>>>
>>>>   Below is the flow of state change during live migration.
>>>> -The values in the brackets represent the VM state, the migration 
>>>> state, and
>>>> +The values in the parentheses represent the VM state, the 
>>>> migration state, and
>>>>   the VFIO device state, respectively.
>>>> +The text in the square brackets represents the flow if the VFIO 
>>>> device supports
>>>> +pre-copy.
>>>>
>>>>   Live migration save path
>>>>   ------------------------
>>>> @@ -124,11 +138,12 @@ Live migration save path
>>>>                                     |
>>>>                        migrate_init spawns migration_thread
>>>>                   Migration thread then calls each device's 
>>>> .save_setup()
>>>> -                       (RUNNING, _SETUP, _RUNNING)
>>>> +                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>>>>                                     |
>>>> -                      (RUNNING, _ACTIVE, _RUNNING)
>>>> -             If device is active, get pending_bytes by 
>>>> .state_pending_exact()
>>>> +                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
>>>> +      If device is active, get pending_bytes by 
>>>> .state_pending_{estimate,exact}()
>>>>             If total pending_bytes >= threshold_size, call 
>>>> .save_live_iterate()
>>>> +                  [Data of VFIO device for pre-copy phase is copied]
>>>>           Iterate till total pending bytes converge and are less 
>>>> than threshold
>>>>                                     |
>>>>     On migration completion, vCPU stops and calls 
>>>> .save_live_complete_precopy for
>>>> diff --git a/include/hw/vfio/vfio-common.h 
>>>> b/include/hw/vfio/vfio-common.h
>>>> index eed244f25f..5ce7a01d56 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -66,6 +66,9 @@ typedef struct VFIOMigration {
>>>>       int data_fd;
>>>>       void *data_buffer;
>>>>       size_t data_buffer_size;
>>>> +    uint64_t precopy_init_size;
>>>> +    uint64_t precopy_dirty_size;
>>>> +    uint64_t mig_flags;
>>>
>>> It would have been cleaner to introduce VFIOMigration::mig_flags and 
>>> its
>>> update in another patch. This is minor.
>>
>> Sure, I will split it.
>>
>>>
>>>
>>>>   } VFIOMigration;
>>>>
>>>>   typedef struct VFIOAddressSpace {
>>>> @@ -143,6 +146,7 @@ typedef struct VFIODevice {
>>>>       VFIOMigration *migration;
>>>>       Error *migration_blocker;
>>>>       OnOffAuto pre_copy_dirty_page_tracking;
>>>> +    bool allow_pre_copy;
>>>
>>> same comment for this bool and the associated property, because it 
>>> would
>>> ease backports.
>>
>> Sure.
>> Just for general knowledge, can you explain how this could ease 
>> backports?
>
> The downstream machine names are different. Each distro has its own
> flavor. So adding a machine option always require some massaging.
>
> That might change in the future though.
>
> Anyhow, it is good pratice to isolate a change adding a restriction
> or a hw compatibility in its own patch.

Ah, I see.
Thanks for the explanation.

>
>
>>
>>>
>>>
>>>>       bool dirty_pages_supported;
>>>>       bool dirty_tracking;
>>>>   } VFIODevice;
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 07f763eb2e..50439e5cbb 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -41,6 +41,7 @@
>>>>
>>>>   GlobalProperty hw_compat_8_0[] = {
>>>>       { "migration", "multifd-flush-after-each-section", "on"},
>>>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>>>   };
>>>>   const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 78358ede27..b73086e17a 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -492,7 +492,8 @@ static bool 
>>>> vfio_devices_all_dirty_tracking(VFIOContainer *container)
>>>>               }
>>>>
>>>>               if (vbasedev->pre_copy_dirty_page_tracking == 
>>>> ON_OFF_AUTO_OFF &&
>>>> -                migration->device_state == 
>>>> VFIO_DEVICE_STATE_RUNNING) {
>>>> +                (migration->device_state == 
>>>> VFIO_DEVICE_STATE_RUNNING ||
>>>> +                 migration->device_state == 
>>>> VFIO_DEVICE_STATE_PRE_COPY)) {
>>>>                   return false;
>>>>               }
>>>>           }
>>>> @@ -537,7 +538,8 @@ static bool 
>>>> vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>>>>                   return false;
>>>>               }
>>>>
>>>> -            if (migration->device_state == 
>>>> VFIO_DEVICE_STATE_RUNNING) {
>>>> +            if (migration->device_state == 
>>>> VFIO_DEVICE_STATE_RUNNING ||
>>>> +                migration->device_state == 
>>>> VFIO_DEVICE_STATE_PRE_COPY) {
>>>>                   continue;
>>>>               } else {
>>>>                   return false;
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 235978fd68..418efed019 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum 
>>>> vfio_device_mig_state state)
>>>>           return "STOP_COPY";
>>>>       case VFIO_DEVICE_STATE_RESUMING:
>>>>           return "RESUMING";
>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>> +        return "PRE_COPY";
>>>>       default:
>>>>           return "UNKNOWN STATE";
>>>>       }
>>>> @@ -241,6 +243,22 @@ static int 
>>>> vfio_query_stop_copy_size(VFIODevice *vbasedev,
>>>>       return 0;
>>>>   }
>>>>
>>>> +static int vfio_query_precopy_size(VFIOMigration *migration)
>>>> +{
>>>> +    struct vfio_precopy_info precopy = {
>>>> +        .argsz = sizeof(precopy),
>>>> +    };
>>>
>>> May be move here  :
>>>
>>>         migration->precopy_init_size = 0;
>>>         migration->precopy_dirty_size = 0;
>>>
>>> since the values are reset always before calling 
>>> vfio_query_precopy_size()
>>
>> OK.
>> I will also reset these values in vfio_save_cleanup() so there won't 
>> be stale values in case migration is cancelled or fails.
>>
>>>
>>>
>>>> +
>>>> +    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, 
>>>> &precopy)) {
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    migration->precopy_init_size = precopy.initial_bytes;
>>>> +    migration->precopy_dirty_size = precopy.dirty_bytes;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /* Returns the size of saved data on success and -errno on error */
>>>>   static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration 
>>>> *migration)
>>>>   {
>>>> @@ -249,6 +267,11 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>>>> VFIOMigration *migration)
>>>>       data_size = read(migration->data_fd, migration->data_buffer,
>>>>                        migration->data_buffer_size);
>>>>       if (data_size < 0) {
>>>> +        /* Pre-copy emptied all the device state for now */
>>>> +        if (errno == ENOMSG) {
>>>
>>> Could you explain a little more this errno please ? It looks like an 
>>> API with
>>> the VFIO PCI variant kernel driver.
>>
>> Yes, it's explained in the precopy uAPI [1].
>
> Oh. I forgot to look at the uAPI file and only checked the driver.
> All good then.
>
>> Do you want to change the comment to something like the following?
>
> Yes, please. It would be good for the reader to have a reference on
> the kernel uAPI.
>
>> /*
>>   * ENOMSG indicates that the migration data_fd has reached a temporary
>>   * "end of stream", i.e. both initial_bytes and dirty_bytes are zero.
>>   * More data may be available later in future reads.
>>   */
>
> Please add something like :
>
>  "For more information, please refer to the Linux kernel VFIO uAPI"
>
> No need for links or file names.
>
OK, I will add that.

Thanks!

>
>> [1] 
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/include/uapi/linux/vfio.h#L1084
>>
>>>
>>>> +            return 0;
>>>> +        }
>>>> +
>>>>           return -errno;
>>>>       }
>>>>       if (data_size == 0) {
>>>> @@ -265,6 +288,39 @@ static ssize_t vfio_save_block(QEMUFile *f, 
>>>> VFIOMigration *migration)
>>>>       return qemu_file_get_error(f) ?: data_size;
>>>>   }
>>>>
>>>> +static void vfio_update_estimated_pending_data(VFIOMigration 
>>>> *migration,
>>>> +                                               uint64_t data_size)
>>>> +{
>>>> +    if (!data_size) {
>>>> +        /*
>>>> +         * Pre-copy emptied all the device state for now, update 
>>>> estimated sizes
>>>> +         * accordingly.
>>>> +         */
>>>> +        migration->precopy_init_size = 0;
>>>> +        migration->precopy_dirty_size = 0;
>>>> +
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (migration->precopy_init_size) {
>>>> +        uint64_t init_size = MIN(migration->precopy_init_size, 
>>>> data_size);
>>>> +
>>>> +        migration->precopy_init_size -= init_size;
>>>> +        data_size -= init_size;
>>>> +    }
>>>> +
>>>> +    migration->precopy_dirty_size -= 
>>>> MIN(migration->precopy_dirty_size,
>>>> +                                         data_size);
>>>
>>> Do we have a trace event for all this data values ?
>>>
>>>> +}
>>>> +
>>>> +static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>>> +{
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +
>>>> +    return vbasedev->allow_pre_copy &&
>>>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>> +}
>>>> +
>>>>   /* 
>>>> ---------------------------------------------------------------------- 
>>>> */
>>>>
>>>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>>>> @@ -285,6 +341,31 @@ static int vfio_save_setup(QEMUFile *f, void 
>>>> *opaque)
>>>>           return -ENOMEM;
>>>>       }
>>>>
>>>> +    if (vfio_precopy_supported(vbasedev)) {
>>>> +        int ret;
>>>> +
>>>> +        migration->precopy_init_size = 0;
>>>> +        migration->precopy_dirty_size = 0;
>>>> +
>>>> +        switch (migration->device_state) {
>>>> +        case VFIO_DEVICE_STATE_RUNNING:
>>>> +            ret = vfio_migration_set_state(vbasedev, 
>>>> VFIO_DEVICE_STATE_PRE_COPY,
>>>> + VFIO_DEVICE_STATE_RUNNING);
>>>> +            if (ret) {
>>>> +                return ret;
>>>> +            }
>>>> +
>>>> +            vfio_query_precopy_size(migration);
>>>> +
>>>> +            break;
>>>> +        case VFIO_DEVICE_STATE_STOP:
>>>> +            /* vfio_save_complete_precopy() will go to STOP_COPY */
>>>> +            break;
>>>> +        default:
>>>> +            return -EINVAL;
>>>> +        }
>>>> +    }
>>>> +
>>>>       trace_vfio_save_setup(vbasedev->name, 
>>>> migration->data_buffer_size);
>>>>
>>>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>> @@ -303,22 +384,36 @@ static void vfio_save_cleanup(void *opaque)
>>>>       trace_vfio_save_cleanup(vbasedev->name);
>>>>   }
>>>>
>>>> +static void vfio_state_pending_estimate(void *opaque, uint64_t 
>>>> *must_precopy,
>>>> +                                        uint64_t *can_postcopy)
>>>> +{
>>>> +    VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +
>>>> +    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    *must_precopy +=
>>>> +        migration->precopy_init_size + migration->precopy_dirty_size;
>>>> +
>>>> +    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
>>>> +                                      *can_postcopy,
>>>> + migration->precopy_init_size,
>>>> + migration->precopy_dirty_size);
>>>
>>>
>>> ok we have one :) I wonder if we should not update 
>>> trace_vfio_save_iterate()
>>> also with some values.
>>
>> Hmm, yes, I guess it wouldn't hurt.
>>
>>>
>>>> +}
>>>> +
>>>>   /*
>>>>    * Migration size of VFIO devices can be as little as a few KBs 
>>>> or as big as
>>>>    * many GBs. This value should be big enough to cover the worst 
>>>> case.
>>>>    */
>>>>   #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>>>>
>>>> -/*
>>>> - * Only exact function is implemented and not estimate function. 
>>>> The reason is
>>>> - * that during pre-copy phase of migration the estimate function 
>>>> is called
>>>> - * repeatedly while pending RAM size is over the threshold, thus 
>>>> migration
>>>> - * can't converge and querying the VFIO device pending data size 
>>>> is useless.
>>>> - */
>>>>   static void vfio_state_pending_exact(void *opaque, uint64_t 
>>>> *must_precopy,
>>>>                                        uint64_t *can_postcopy)
>>>>   {
>>>>       VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>       uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>>>>
>>>>       /*
>>>> @@ -328,8 +423,49 @@ static void vfio_state_pending_exact(void 
>>>> *opaque, uint64_t *must_precopy,
>>>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>>>       *must_precopy += stop_copy_size;
>>>>
>>>> +    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
>>>> +        migration->precopy_init_size = 0;
>>>> +        migration->precopy_dirty_size = 0;
>>>> +        vfio_query_precopy_size(migration);
>>>> +
>>>> +        *must_precopy +=
>>>> +            migration->precopy_init_size + 
>>>> migration->precopy_dirty_size;
>>>> +    }
>>>> +
>>>>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, 
>>>> *can_postcopy,
>>>> -                                   stop_copy_size);
>>>> +                                   stop_copy_size, 
>>>> migration->precopy_init_size,
>>>> + migration->precopy_dirty_size);
>>>> +}
>>>> +
>>>> +static bool vfio_is_active_iterate(void *opaque)
>>>> +{
>>>> +    VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +
>>>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
>>>> +}
>>>> +
>>>> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>>> +{
>>>> +    VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    ssize_t data_size;
>>>> +
>>>> +    data_size = vfio_save_block(f, migration);
>>>> +    if (data_size < 0) {
>>>> +        return data_size;
>>>> +    }
>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>> +
>>>> +    vfio_update_estimated_pending_data(migration, data_size);
>>>> +
>>>> +    trace_vfio_save_iterate(vbasedev->name);
>>>> +
>>>> +    /*
>>>> +     * A VFIO device's pre-copy dirty_bytes is not guaranteed to 
>>>> reach zero.
>>>> +     * Return 1 so following handlers will not be potentially 
>>>> blocked.
>>>
>>> Can this condition be detected to warn the user ?
>>
>> I don't think so, it depends on the kernel driver implementation.
>
> OK. We will see how it evolves with time. We might need some message
> saying pre copy is not converging.
>
> Thanks,
>
> C.
>
>
>>
>> Thanks!
>>
>>>
>>>
>>>> +     */
>>>> +    return 1;
>>>>   }
>>>>
>>>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>> @@ -338,7 +474,7 @@ static int vfio_save_complete_precopy(QEMUFile 
>>>> *f, void *opaque)
>>>>       ssize_t data_size;
>>>>       int ret;
>>>>
>>>> -    /* We reach here with device state STOP only */
>>>> +    /* We reach here with device state STOP or STOP_COPY only */
>>>>       ret = vfio_migration_set_state(vbasedev, 
>>>> VFIO_DEVICE_STATE_STOP_COPY,
>>>> VFIO_DEVICE_STATE_STOP);
>>>>       if (ret) {
>>>> @@ -457,7 +593,10 @@ static int vfio_load_state(QEMUFile *f, void 
>>>> *opaque, int version_id)
>>>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>>>       .save_setup = vfio_save_setup,
>>>>       .save_cleanup = vfio_save_cleanup,
>>>> +    .state_pending_estimate = vfio_state_pending_estimate,
>>>>       .state_pending_exact = vfio_state_pending_exact,
>>>> +    .is_active_iterate = vfio_is_active_iterate,
>>>> +    .save_live_iterate = vfio_save_iterate,
>>>>       .save_live_complete_precopy = vfio_save_complete_precopy,
>>>>       .save_state = vfio_save_state,
>>>>       .load_setup = vfio_load_setup,
>>>> @@ -470,13 +609,18 @@ static const SaveVMHandlers 
>>>> savevm_vfio_handlers = {
>>>>   static void vfio_vmstate_change(void *opaque, bool running, 
>>>> RunState state)
>>>>   {
>>>>       VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>       enum vfio_device_mig_state new_state;
>>>>       int ret;
>>>>
>>>>       if (running) {
>>>>           new_state = VFIO_DEVICE_STATE_RUNNING;
>>>>       } else {
>>>> -        new_state = VFIO_DEVICE_STATE_STOP;
>>>> +        new_state =
>>>> +            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
>>>> +             (state == RUN_STATE_FINISH_MIGRATE || state == 
>>>> RUN_STATE_PAUSED)) ?
>>>> +                VFIO_DEVICE_STATE_STOP_COPY :
>>>> +                VFIO_DEVICE_STATE_STOP;
>>>>       }
>>>>
>>>>       /*
>>>> @@ -603,6 +747,7 @@ static int vfio_migration_init(VFIODevice 
>>>> *vbasedev)
>>>>       migration->vbasedev = vbasedev;
>>>>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>>>       migration->data_fd = -1;
>>>> +    migration->mig_flags = mig_flags;
>>>>
>>>>       vbasedev->dirty_pages_supported = 
>>>> vfio_dma_logging_supported(vbasedev);
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index bf27a39905..72f30ce09f 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>>> DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", 
>>>> VFIOPCIDevice,
>>>> vbasedev.pre_copy_dirty_page_tracking,
>>>>                               ON_OFF_AUTO_ON),
>>>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>>>> +                     vbasedev.allow_pre_copy, true),
>>>>       DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>>>                               display, ON_OFF_AUTO_OFF),
>>>>       DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>> index 646e42fd27..fd6893cb43 100644
>>>> --- a/hw/vfio/trace-events
>>>> +++ b/hw/vfio/trace-events
>>>> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int 
>>>> data_size) " (%s) data_size %d"
>>>>   vfio_save_cleanup(const char *name) " (%s)"
>>>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>>>>   vfio_save_device_config_state(const char *name) " (%s)"
>>>> +vfio_save_iterate(const char *name) " (%s)"
>>>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " 
>>>> (%s) data buffer size 0x%"PRIx64
>>>> -vfio_state_pending_exact(const char *name, uint64_t precopy, 
>>>> uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 
>>>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
>>>> +vfio_state_pending_estimate(const char *name, uint64_t precopy, 
>>>> uint64_t postcopy, uint64_t precopy_init_size, uint64_t 
>>>> precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" 
>>>> precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>>> +vfio_state_pending_exact(const char *name, uint64_t precopy, 
>>>> uint64_t postcopy, uint64_t stopcopy_size, uint64_t 
>>>> precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 
>>>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy 
>>>> initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>>>   vfio_vmstate_change(const char *name, int running, const char 
>>>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>>>> state %s"
>>>
>>
>

