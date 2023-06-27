Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BD73F64E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:02:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3dH-0005Ls-Tz; Tue, 27 Jun 2023 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qE3dE-0005LR-FF
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:01:00 -0400
Received: from mail-dm6nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::606]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qE3dB-0001Im-HP
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:01:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyh4BvBuex5dUoZC2ydUmzRoUsR5xZAVcx3TuaVKHkw3ZR3LB2bgiDYwuRW2rdNYdKAL8M6gaowKemBL3/JsCDzbhiuwFmxTZDiHoCuDD+fs+J1hjCjldYWVRNTDgp5DVXiLns9fRnHtWFRoB/IpruT3/pfxeMw3pL2K3OwpK11d2qXXVJCmLOSuGRXjj7PhpStJy8gzsIFi30Po4CUkSkCL6VDf3XzmuvPh1Smq8Q2WRFEccTI+HX5qvGm1a3/hutDEFp8npL3taTfcIUoM87vyMZ7jwY+Q+mg0a73HJJSG5R6MDl1YYw/xrfq2ZV/N+MxMWKPhZUIvlNKC5XojCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W2AkUfa8Uk++k5cxgz2dyxxHd0AmByNOKjlJhCVrfY=;
 b=VSo9IDs9j/fiXVLMBmnpGNzlnRLT2ZtQwNiu5pXrDjDPrCUtyB/662TTt/Jj1BayhRZlXjSVUn3mRuo/8S6+JfiLV5CYrHoY4nC0ZfdkxeWR1brBxmZcEncr0HZmb0cju2hI0K+NwndAjEuERggUirfnt82q//0aiS6EEA50AU9ytyGK8iQ3bCvqLZcwogsuvpdBh7DcAUwOxd7EW9UI4HU8d1ZQ0Dkp6jxISuwHQHIifNmyAG4bWcOls4TU44bfN2taxNFdFpntzIv8/HG3Vn0W7WCQLca/i/WTmF9tIV9mCIWJ8joXEZbOGiMz4ql/7sKcf0GlPVO3huxxGofVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W2AkUfa8Uk++k5cxgz2dyxxHd0AmByNOKjlJhCVrfY=;
 b=fWgxglqDl4kMmKPWjZXCC6RLeT4MvoQrwb7kx/2gz8AJlZRtirOdp17iIe5tD+aFlztQUdcwDDfqeW/r2x8Z97jBxpNCqOZZDm2fa95kWnsCCnZkY1zo5c8dTN/KWSoFJsy2nN9NtYksb///g+i12ZGzpeQXF9aLLsubzy9cWlyJiiz+TKTP7GwMCZZWQqh4DDUn7uj9O/+4g/YQJkKXqFMxxizzu4d+IpA6+QkbiFx50fBzl5JbXDPfvh7WZ82RyxHrdi/XJSgxSt3uEC6EpBoHFS+uBtDru126FkOKIivisRyEGlyevt9vvWO1R79IyoygjPptpvKco3//i7esDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 08:00:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 08:00:52 +0000
Message-ID: <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
Date: Tue, 27 Jun 2023 11:00:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <20230626112729.06dc48d8.alex.williamson@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230626112729.06dc48d8.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f05247-ebc7-448b-dd78-08db76e4a0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtcjSWuiB41yGgHk4PNY/J3wi2QvWzHwum8iFLZvJXio3XdpQtTyZVHi7CqsXI4oDK/3xZpHYBLvec3v4pf7xB3O3G0QBlkVnrjJKZYIVxe1/rEM5fPvHoshOuVTcV1a5xu+buyxghChF6oZW/9T6WIk/lsJJE5jk55Y5BuTV+xSoksvGXhSUv0BI2i68UyqlUSUKKzmDbjNRU2mdiqshdHg78EyOxOWQBXYJUiTQrYNkphVwJNdEEX/0neNLnWDG9xrIGSFGVPhmTw6vI+yY3llXy6Z+ekQxBL3aVEP/9ovwThTLUkIeoES2Uxm7BVBCfaB9URh8lkGN2Ue2Ecn9VNiD3M+BcM911YNJn6aEKNDrc0XZ3kQi6uCBvtp8yS2wJWAscILmgabMliHUVUFYMm4Xayp9bNm6yQVBy8mDWphLCxhbXxnPI+2pJ93yPXAOQVKb3Ye1d+GBNJ+i3Q6bjecM6AYK9LRjxQ0zYgd325jJ4sM9o0ConXX+H8MmosVUlXuYG3+5WpkT11spBmRkLSy+nL4o2Lp5KlB2YUSyhQAPM2haDaOhL0TpTzvZfu1cq6oa3+U0/VmI1Xz1oVAhCSyuNRGy5EFXkz6iiiYCFAcAPorQXtyWzhobg7Xkh6itmHk0fLmCQ4IytPgau8C0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(31686004)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(110136005)(54906003)(86362001)(31696002)(41300700001)(6486002)(186003)(66574015)(6506007)(6512007)(53546011)(26005)(6666004)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpWdzFPWVh5TjN1NWhDN05RT28yQnJNa1BudUQvWVc3NUUzR2x6NjN2d0I5?=
 =?utf-8?B?RVN3V3gzTE9SelJWODR3cDcvdDNXRG1Wa0Zab2k5aW9FMlpuSXZ2VHJ5MkI4?=
 =?utf-8?B?b1FoMnJ1TXdVMURTeHZUejdscXFpM3RIMGIrdWcrUzdVSjR1NU84QzFpWjhS?=
 =?utf-8?B?emdZL3lZUGNNMHVSVjBCV01VUU5pUXIwdHNCNFoveXY2MVhKTm1Kd3FrZXBZ?=
 =?utf-8?B?OW5SR0lYZ1lNY2FYN2krOXZPSVk0ZVZSeDBzbTdNNVU3NEZmeGpLV0lESXJQ?=
 =?utf-8?B?QzF6UUFzUjRLYng2YkJOOFBwNWNDQ0FvR1Ftc0NLZEhzdng3ekhra25Cc3BM?=
 =?utf-8?B?Q3lZTWVybkdhOFlrUHhVblF4NVA4SjhONHdMaDI1SjZiU0dJUHNTakhYOGV1?=
 =?utf-8?B?UHJyTDhleXV6RHdrV050cWlrK2d3VGRCWWYxeUF5cFg4M0xyRXVHaW9uRlha?=
 =?utf-8?B?aVZ1SVRNdmhVazVCeGI1SktnSExyMlVUTXpVQmtvVFgwL3JodTVNT2RMbEtS?=
 =?utf-8?B?VXpEcWJzQy9lUkM4K2JiRFNtNmd6MXJPUDN3ck1Pb0F2SGxQQTJvZmYwTzJp?=
 =?utf-8?B?NENMQnpFb0RWZXVRY2ZlY3ZnNFgwRUR0T1JOZ1pLZkZFYU0wNEUvY0R3djBx?=
 =?utf-8?B?M3dxbTRNMms4cEY4bEMvUTdWaGhLKzRSOWxzVUhYa0JvU1lLMlMzMk51SDlm?=
 =?utf-8?B?NkhzRGpoNGQySEtZRmpMTjlJNFR5dGIyQWNObW8wTlNLTGdoWTdRazU5Ly9m?=
 =?utf-8?B?ZlJPRzdHVzZZWEVBRDNUWDQxdnRDS1BrSm5kNFFZa3lVZlc4aCtvbEYwVXRG?=
 =?utf-8?B?UWZyZkVDdnpRQ212VmQrNGJzWUNRUDIvSFJ3MGdQNmJ5djB1REZMeVlra2Zm?=
 =?utf-8?B?eVRqb2ROeFl3ejVaUkpORlduVC9iVnpJejFFY0hqbEo2dkdrL041M0hFNU1X?=
 =?utf-8?B?Nk9zQjYzeXNjSFlvNVFsYUxMTmlaMGxCc3poUURTc2hWR292YnBHSWxxaWp5?=
 =?utf-8?B?WktXR1N0U2RXalZsallkQ0FTRUN4eFpkMksreFJ6SHBKV1BQcTkxcllURkZa?=
 =?utf-8?B?SkhQeDN1bVc4TTZJNmpZS1hLRFlPTUNFZW41bGZOQ1V0ZnZ4OGJ3bjNSNVFP?=
 =?utf-8?B?SE96Sk5STmNWd0RYRjMxamJTQ1p3bjkxNVNpbnIvLzY2R3JVVHZiNkFtNzZ6?=
 =?utf-8?B?K0ZHelhRalU2VXgwR01KZE5qZzJVam5CaXFHdmNpNERVN2E1aTdBZUhBUmtx?=
 =?utf-8?B?aXUvaHRTeXppclNNNGN0SHNaaDUxV1FKZGlldjk1Mm9kcmt1N2s1TlZSZmIv?=
 =?utf-8?B?MXlWd2VPWEZjalV0QTRiRHNoTnFQZEV4OTR2L1ROM2lVRS9uR3ZzVEdhSWpj?=
 =?utf-8?B?OHU1UVJOWTkvbVFqQ3c1SGZkTzN1NHkvWmtHK28wTkFST2lrQUY2WjdLYXlk?=
 =?utf-8?B?eW14ajN2Y2RWeGlmcTNyR1YyWmp0cnBxK3ZyL1Zucnhmbkp0ZmVIUXZEUTRs?=
 =?utf-8?B?OGdHcWlMN29wTDFVR3NJcEJjWDZ4MnhhOWdyc2pZVmNaS0VlVE80UE10WCt3?=
 =?utf-8?B?R1pzVnlNTldITE5rVlZpdkdJcExhQVk0MlV5MUVFbm05YldLRXdmSDNDVkVt?=
 =?utf-8?B?MWIyTUF1OTB3ZE1PZzZtMU5scklxdWJLb0lCRm5XVlZOclhkSHNQK1FERDJT?=
 =?utf-8?B?RjJtekpsZitBUTZwYkxqaUFNVE1PMmZHOEVBTDdIWFUxTUIvYjgzN1VqaUNm?=
 =?utf-8?B?Ukd6U211UnIzOGFiWlFERmlKMllvdDJFZUZmcWp5QVJyRUFia3NRSWNnUy94?=
 =?utf-8?B?R2E3dUFoQ1cxR2M2cFkyc3RJSzB0enU5NnkvNHFhTnlkVmNHUXZkMllMWG1N?=
 =?utf-8?B?WTBjeUdLTUZyMU16dzBmT3dUTS9VSVl0cks5VENDMEJjRkgvME5aOEZCQy94?=
 =?utf-8?B?ZS9FTjcvdmJGZ0dvay9KWmxEdGcyYlhvQmlYcmJoSDFZRzM3b21FTlpNTG4v?=
 =?utf-8?B?ek8xWHkveUZidVQveERHdjhkWlFiU3B0b2hRU3Q1Nm55NUwvT2p3SElpeVlZ?=
 =?utf-8?B?dHM4RkZRTFVYUFBMTmhhWVdyVHRLWWR6M1dkdlI4aDBoUzdSc2N1anRBOVE2?=
 =?utf-8?Q?/q05adOdB23lB/SvfuvDuOJdx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f05247-ebc7-448b-dd78-08db76e4a0bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:00:52.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlebpHWg1m35SBHjFSKXNC9tcSlaY38vlVAYHS0cIyatDIb/iNRz/ifc9DoZTDGG6/eaxYP15sBxaRjRvdaj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 26/06/2023 20:27, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 26 Jun 2023 17:26:42 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
>
>> On 6/26/23 15:40, Joao Martins wrote:
>>> On 26/06/2023 14:20, Cédric Le Goater wrote:
>>>> Hello Avihai,
>>>>
>>>> On 6/26/23 10:23, Avihai Horon wrote:
>>>>> The major parts of VFIO migration are supported today in QEMU. This
>>>>> includes basic VFIO migration, device dirty page tracking and precopy
>>>>> support.
>>>>>
>>>>> Thus, at this point in time, it seems appropriate to make VFIO migration
>>>>> non-experimental: remove the x prefix from enable_migration property,
>>>>> change it to ON_OFF_AUTO and let the default value be AUTO.
>>>>>
>>>>> In addition, make the following adjustments:
>>>>> 1. Require device dirty tracking support when enable_migration is AUTO
>>>>>       (i.e., not explicitly enabled). This is because device dirty tracking
>>>>>       is currently the only method to do dirty page tracking, which is
>>>>>       essential for migrating in a reasonable downtime.
>>>> hmm, I don't think QEMU should decide to disable a feature for all
>>>> devices supposedly because it could be slow for some. That's too
>>>> restrictive. What about devices with have small states ? for which
>>>> the downtime would be reasonable even without device dirty tracking
>>>> support.
>>>>
>>> device dirty tracking refers to the ability to tracking dirty IOVA used by the
>>> device which will DMA into RAM. It is required because the
>>> consequence/alternative is to transfer all RAM in stop copy phase. Device state
>>> size at that point is the least of our problems downtime wise.
>> Arg. thanks for reminding me. I tend to take this for granted ...
> My initial reaction was the same, for instance we could have a non-DMA
> device (ex. PCI serial card) that supports migration w/o dirty
> tracking, but QEMU cannot assume the device doesn't do DMA, nor is it
> worth our time to monitor whether bus-master is ever enabled for the
> device, so QEMU needs to assume all memory that's DMA accessible for
> the device is perpetually dirty.  Also, if such a corner case existed
> for a non-DMA migratable device, the easier path is simply to require
> dirty tracking stubs in the variant driver to report no memory dirtied.
>
>>> I can imagine that allowing without dirty tracking is useful for developer
>>> testing of the suspend/device-state flows, but as real default (auto) is very
>>> questionable to let it go through without dirty tracking. When we have IOMMUFD
>>> dirty tracking that's when we can relieve this restriction as a default.
>>>
>>> But then note that (...)
>>>
>>>>> Setting
>>>>>       enable_migration to ON will not require device dirty tracking.
>>> (...) this lets it ignore dirty tracking as you would like.
>>>
>>>
>>>>> 2. Make migration blocker messages more elaborate.
>>>>> 3. Remove error prints in vfio_migration_query_flags().
>>>>> 4. Remove a redundant assignment in vfio_migration_realize().
>>>>>
>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> ---
>>>>>     include/hw/vfio/vfio-common.h |  2 +-
>>>>>     hw/vfio/migration.c           | 29 ++++++++++++++++-------------
>>>>>     hw/vfio/pci.c                 |  4 ++--
>>>>>     3 files changed, 19 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>> index b4c28f318f..387eabde60 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
>>>>>         bool needs_reset;
>>>>>         bool no_mmap;
>>>>>         bool ram_block_discard_allowed;
>>>>> -    bool enable_migration;
>>>>> +    OnOffAuto enable_migration;
>>>>>         VFIODeviceOps *ops;
>>>>>         unsigned int num_irqs;
>>>>>         unsigned int num_regions;
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 79eb81dfd7..d8e0848635 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice
>>>>> *vbasedev, uint64_t *mig_flags)
>>>>>         feature->argsz = sizeof(buf);
>>>>>         feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
>>>>>         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>>>> -        if (errno == ENOTTY) {
>>>>> -            error_report("%s: VFIO migration is not supported in kernel",
>>>>> -                         vbasedev->name);
>>>>> -        } else {
>>>>> -            error_report("%s: Failed to query VFIO migration support, err: %s",
>>>>> -                         vbasedev->name, strerror(errno));
>>>>> -        }
>>>>> -
>>>>>             return -errno;
>>>>>         }
>>>>>     @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
>>>>>       int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>>>     {
>>>>> -    int ret = -ENOTSUP;
>>>>> +    int ret;
>>>>>     -    if (!vbasedev->enable_migration) {
>>>>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>>>>> +        error_setg(&vbasedev->migration_blocker,
>>>>> +                   "%s: Migration is disabled for VFIO device", vbasedev->name);
>>>>>             goto add_blocker;
>>>>>         }
>>>>>           ret = vfio_migration_init(vbasedev);
>>>>>         if (ret) {
>>>> It would be good to keep the message for 'errno == ENOTTY' as it was in
>>>> vfio_migration_query_flags(). When migration fails, it is an important
>>>> information to know that it is because the VFIO PCI host device driver
>>>> doesn't support the feature. The root cause could be deep below in FW or
>>>> how the VF was set up.
>>>>
>>> +1 As I have been in this rabbit hole

Sure, I will add it.

>>>
>>>>> +        error_setg(&vbasedev->migration_blocker,
>>>>> +                   "%s: Migration couldn't be initialized for VFIO device, "
>>>>> +                   "err: %d (%s)",
>>>>> +                   vbasedev->name, ret, strerror(-ret));
>>>>> +        goto add_blocker;
>>>>> +    }
>>>>> +
>>>>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
>>>>> +        !vbasedev->dirty_pages_supported) {
>>>> I don't agree with this test.
>>>>
>>> The alternative right now is perceptual dirty tracking. How is that OK as a
>>> default? It's not like we have even an option :(
>>>
>>> Maybe perhaps you refer to avoid strongly enforcing *always* it to allow testing
>>> of the non dirty tracking parts? Maybe when you 'force' enabling with
>>> enable-migration=on is when you ignore the dirty tracking which is what this is
>>> doing.
>>
>> I see ON_OFF_AUTO_ON as a way to abort the machine startup while
>> ON_OFF_AUTO_AUTO would let it run but block migration.
> Agreed.  There's a little bit of redundancy between the device-level
> "enable-migration=on" option and the global "-only-migratable" option
> relative to preventing machine startup, but it also doesn't make sense
> to me if the device-level option let realize complete successfully if
> the device doesn't support or fails migration setup.  So I think we'd
> generally rely on using the -only-migratable option with the default
> ON_OFF_AUTO_AUTO value, allow the ON_OFF_AUTO_ON value to enable
> dis-recommended support, and live with the redundancy that it should
> also cause the device realize to fail if migration is not supported.
> Thanks,
>
> Alex

OK.

When enable_migration=AUTO we allow blockers.
When enable_migration=ON we don't allow blockers and instead prevent 
realization of VFIO device.

Regarding device dirty tracking, we keep current behavior, right?
That is:
When enable_migration=AUTO we block migration if device dirty tracking 
is not supported.
When enable_migration=ON we allow migration even if device dirty 
tracking is not supported (in which case DMA-able memory will be 
perpetually dirtied).

Thanks.

>
>> We would
>> need an extra property to relax the checks, else we are hijacking
>> some pre-existing option to fit our need.
>>
>> Since dirty tracking is a must-have to implement migration support
>> for any existing and future VFIO PCI variant driver, anything else
>> would be experimental code and we are trying to remove the flag !
>> Please correct me if I am wrong.
>>
>> So, the case !vbasedev->dirty_pages_supported is just an extra
>> information to report for why migration is not supported. Does
>> that sound reasonable ?
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>>> +        error_setg(&vbasedev->migration_blocker,
>>>>> +                   "%s: VFIO device doesn't support device dirty tracking",
>>>>> +                   vbasedev->name);
>>>>>             goto add_blocker;
>>>>>         }
>>>> I agree that with ON_OFF_AUTO_AUTO, errors at realize time should be recorded
>>>> in a migration blocker. What about the ON_OFF_AUTO_ON case ? If migration was
>>>> explicitly requested for the device and the conditions on the host are not met,
>>>> I think realize should fail and the machine abort.
>>>>
>>> +1 Good point
>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>
>>>>> @@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error
>>>>> **errp)
>>>>>         return 0;
>>>>>       add_blocker:
>>>>> -    error_setg(&vbasedev->migration_blocker,
>>>>> -               "VFIO device doesn't support migration");
>>>>> -
>>>>>         ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
>>>>>         if (ret < 0) {
>>>>>             error_free(vbasedev->migration_blocker);
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index 73874a94de..48584e3b01 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>>                         VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>>>>         DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>>>>                         VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>>> -    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
>>>>> -                     vbasedev.enable_migration, false),
>>>>> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>>> +                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>>>>         DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>>>         DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>>>                          vbasedev.ram_block_discard_allowed, false),

