Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF58790B29
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 09:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qchzM-0006cY-SI; Sun, 03 Sep 2023 03:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qchzK-0006cO-UA
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 03:57:43 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qchzH-0003OV-RZ
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 03:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0rzkd2l+bmiec4X07An8xCi/9LUmKbNJ+VBXIFp+l4Ed/0h/M3lj9xPFm3uAJnt5bIdh/4tduYPBu1C3Ssq8zQhDQ6aalDBB4OKAcVAiGeFaLxaOrKqSXWwPLEu+ImW4e8JaDgmWkKQfhTC9gi6v5pPMkv6R3a6dYv4Wxd+RxaoQ/2Yo7zvuIFsitdodgxiaYZR3+u5TdlcxfjfJSC5tr9TmLi9DennH+8GlgsR6XQUI30LTS3RNrBxiIMf+5JjRAeqIU0JtfVPMQ1K6ccYEj8Gxp8Hk1LtMet8UXegIaxNeG4ICUTnRgX0TPtpu1IX9wbnESLdyt5RfnaIAvtG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJpfjwIryZK7Nmo9KNtbs5ezY2y2555HCrK/9u+Yptw=;
 b=ewMnIii39Bd4Q9PPP1k3IwxpmyVY3uEp7woeGAxRw/F9a6PGVcqnc57QnCKmym7edQQYT6KS78kUheD6higSBMy6eCphoudzImidnF9GXFCsANIfn1Mb2AGr8qu3ixXoIyf6+GR1mMaefDHVNgSwwbAfTHBc9IQrO7+VVKJi1p+voLdm1xcRvXR4L6JD4PQHaIUorxGxyVcickltXq8ToeU1U5h8fGW93P0Pl+jETE8/ySeEuKT3/9E3KeRD7X/7kAf8Vp2ESFzMRQNpLRvyFPFMLKJY6yDQ8jcHOLRjnV8u512nUL9F5Bu6q3O76HXB3qXEtghyXe31vxNkgEq/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJpfjwIryZK7Nmo9KNtbs5ezY2y2555HCrK/9u+Yptw=;
 b=mjjfI/SSpT6sLRgw/N68eR/4ILf5lPxEvV0/1PomK6p98FKIQ7W3KYO2W+Jx1r8Z+zZ4MJAyAi+LCDk94Gzsq4WKT1N5imWtkkjE4tPkEvncj9g1FM6taQH4vneVRES8A3u/AXb35EQHeIdAIqyWPe5tIiK3ssg68Zb9xI8FOgC3RhXotmq8GCOTyMxlYrzDDeT7KJ9pay/SlwwOvAyOQ0z+oyYNKslbQoZ3nFjZWzbrYun3DUBAfEkCWaU1P9I+c60VT4n6uaeWIkRD4wvs/o5xuS47Kb85jx74Ule8m6/aTEFr8fEshQ402D3USbD+cdYQCmB1KYXMs7DjxQbvAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 07:52:35 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 07:52:35 +0000
Message-ID: <0a251227-0097-aab4-b812-af4afc58fd0d@nvidia.com>
Date: Sun, 3 Sep 2023 10:52:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/5] vfio/migration: Block VFIO migration with postcopy
 migration
To: Peter Xu <peterx@redhat.com>, Tarun Gupta <targupta@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-5-avihaih@nvidia.com> <ZPIIZT6RywNN4M/9@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZPIIZT6RywNN4M/9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: f9316453-ac8b-40bc-1545-08dbac52bc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jM5LS1cN/oM+7fUQltDCb4tJ+urpca1yn5QJOyBbT2fLaHRSqc1tKW8HbCcsj26dYb5iziwg4dWgKktQFJswaWGce/uxhckiK78rWvHeQWtwyvB1daM1Jx0QGhzKRFE69nw46XSSEErKQmSGOfkdFZ5rDkMbb8mBw52Bc32m/6sHx2X8q/ChDJX6BIVPbXyexFPxWT0ZWeQ5HyGSZM1quH7R/w6mpuzHoeOrtURbEs07QQby7plrEp+aMmEiUYv2CwdtM3taWCDSP3MvIObeX3DPQ2rsIeG5RtpktUv/bel/FAXWO8EXPkEoaoPOx+hZC/A10sygIAZpeSQmclu6a6sIrlHOL9P7T6iFZrZn+X93fbcg6nmzm5F8RaWGfgTgsJH6OT4P9TxYbihshE3IYT/KhgM2E+feosSobX8cC59mIaQOGRwIQTxGrgwt8/Ku07SB49hc/hrQyw3Elb8mrSCcjio/+udRpLDuYSiGhKVOzmlXqYfyxsBemzx10p67TI5oaRAfqDDEmPQFLGcSb5c02dgdjRHry6sPz3351XdfNvnGJCIHsMgHzQWda8hxkrxS1BQFiQmgqiB7Vlg6TMSrEAM1FvR2l3F/ZPseT+qyLv6GuJ7/7GCrJWjOqdO4x9VFyhjtmFxpn0Ab22WvoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(1800799009)(186009)(451199024)(5660300002)(41300700001)(2616005)(26005)(2906002)(86362001)(31696002)(38100700002)(36756003)(4326008)(8676002)(8936002)(83380400001)(53546011)(6512007)(6506007)(6666004)(6486002)(31686004)(478600001)(316002)(6636002)(110136005)(66946007)(54906003)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azEzQkNaM2RjbXZnUWpDUU1FOEdXVnd3bTR0MDA2VFlGaUQrK1UzTUE2Ym1w?=
 =?utf-8?B?TElhcEZEUUxTb3ZQWHBma0tCb3BLaEE2eEV6WVArTjNLY09UR01qNEtqYTgy?=
 =?utf-8?B?YWhSVlhITWsvaTdzcXozd2FIRm4yRmdrY0RjVDVmSzN4c3l1K3pTSmFESHpq?=
 =?utf-8?B?RmpxZkwzbDM1L2poWU5hdXphQzN2ZmhFb1lydXVMYXNSMmtpQ1JGaVAxam5T?=
 =?utf-8?B?a1dTZXU2eDdXNWl4Rll3aG8vWitXOTd4bVVRY2NYcnpnbWtlVThLU1liU0Jo?=
 =?utf-8?B?bHNnYWMxRHFLajlsdzk2UWNKQldWKzluNE56T1FQcXZzQVcvUnZIYjA5ajE0?=
 =?utf-8?B?ckZWUHNic25NTTU4Q3lsbUNZN1lad29HaVFKcHRXL0lva3M5Z25mOURnRGta?=
 =?utf-8?B?Rmp5bTZ5V3VxUk5lcVRNTzgwOWlNZklqR1RUa0wrRjJ1YXpGa1VTa1JwaDRx?=
 =?utf-8?B?MzA4YjgyWnNJSTNNS3Rid2pRa1luZzFONkJYNTRzV3R3cTFCMnVpWlQvSE83?=
 =?utf-8?B?ajdDczBXRWE2UDlJZmIxaDF4U1NuemQzbkd4bkpXTVlHQzQwTDFuM3FiSGQv?=
 =?utf-8?B?VFR5ZkljS05IUHhNNVF5UXQ0M3ZQWTJnUU45TWVyd0ZWNTU2WkFRWlZzWm5n?=
 =?utf-8?B?cUNtMGZmWGE0RThXdGdIaVd3aHZhY1VZd1laRUpMTlV4Z2RTWFIzaGlpZ0E1?=
 =?utf-8?B?QXl1ZWcwWUlySVRGYnRFZnhwRnlEZUUwWDBKUXFhZDRGelBRdVpqRGM2WlFS?=
 =?utf-8?B?U3RZZ2VlUmVQOFY5WGtVSTA3WjlicEtsM0xRQVg2ZStodHNBRlRjQnpRQS9p?=
 =?utf-8?B?aVFvcEZ4anBUYkd2Y0oxYUhiR3IvRm11dDcxUEhKTGZ6MEozbkNzdmpqNUdw?=
 =?utf-8?B?Z29FcWZOQzJGeE4veUs3RVE0YVFvSmw5Z1d6S0JQR241ZmNEdWVVMGdsRDFU?=
 =?utf-8?B?cjhVTStyb3RacTJJLzFIRjF3ak42bkdBWUovOXc3ejlzVHllejIrTEdkRDhN?=
 =?utf-8?B?aitjSEZCOTBuWHUzcjBIRWRyb3kraHZQWTRjclZzNFdCQldpZStENGxHeHlB?=
 =?utf-8?B?QnNGVk16bFg2SDJ4STBWN05hSTd0NTlvWWxVTTdpL25pMWhIR1QxRkRqcEFp?=
 =?utf-8?B?ckk3RjUwM1ZLQlg3aHAxQ2FFS2FTeEtVTjFzMXh1TmprVVpxZEt0Z2toeGsw?=
 =?utf-8?B?U0lJcGlUbXVDVTlodktGUzc5UXl3TUVwT2RkeGtjK0YrazdzaVd1MnVkSjFB?=
 =?utf-8?B?Q0FOWmp6KzlzTHhBRGJYSUVwclR3WkZLbjk0SGd2ZzNCODA0Ym1iTHVJTE1P?=
 =?utf-8?B?Z2ZheDJWLzE5YTc5STVTMTBEVGRkdDU4RElUNG5laXFFZWhpQ2pTUTRWNzY0?=
 =?utf-8?B?QUhVcGV3Zk92NE93UlN5U3pLTHUxQXhtbWRhcDRrYVFBekFhSmxwbllqc0NM?=
 =?utf-8?B?dURuZGl5Z1VJRnpaMWVRZkt1ek92NlJvSURzV0N5WitIeWVrL2lXZENIM1lu?=
 =?utf-8?B?MExLS2xOYXV4Ylc5eDNpNlo1OUdYeU1jc0cyTEpKL0ZabVpzV25pU0d2US9I?=
 =?utf-8?B?RDEzK1JFUk1RYThSQ0xpenV2WHhqU2d3WEJCZ2VrS3Rzak8zYkxXNzVOTjRX?=
 =?utf-8?B?MXU1K1Awc1hHdGkxMmlVWkpFVkFVOGtBSElkNUsrc2k0UnRhd21VR2Zta0ZO?=
 =?utf-8?B?QzlYYWhpWlpXazVYdVhhWUdPSlpvLzJlMGt0K3o3SVhYRDFjOUFSUVFsazhS?=
 =?utf-8?B?clJTZnhTL0NxSUJhcmozdnhTL2RRU0J5UCtvUTU4NzNRNWpaaE5Xb2dHa0dR?=
 =?utf-8?B?NzNZSFdtUUdOUGlOVGd4cWN0UVpaNnllY3czbEhFM0JmMlVVOGlXaVBHOHJt?=
 =?utf-8?B?T1hSZmduY1hwODV1eG1jSzlBYW5TMGJUd0JiRVJpVGFvVHRqOGN0RWgxMllB?=
 =?utf-8?B?aXJUVGY2SHdCaHdJVGtReTNKTHM1ZERxazl0SE9uRDNHQ0lpaDluS3J3MEJ3?=
 =?utf-8?B?NllZWENhOXNZRnZ2NTYwOXJBOHpVRjZlYWRqbVJaSjhpVzh4TnladktIamQw?=
 =?utf-8?B?czhDM21FNktMV3QyT2JETGJqeVppL3QwL3RSbXZYbnRQZW5XTmxpZ2Q2WENs?=
 =?utf-8?Q?pe74KDtsOSHmHet3CaJG/xYRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9316453-ac8b-40bc-1545-08dbac52bc0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 07:52:34.7544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8SQoa5qbU/X+EoUppZHMY20bcxHTfTBKS7u6Y8rPx3KP7Rv9fimQDKugX+3pgmth0M3z05WzKDTuY2brOUIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
Received-SPF: softfail client-ip=40.107.236.41;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 01/09/2023 18:51, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Aug 31, 2023 at 03:57:01PM +0300, Avihai Horon wrote:
>> VFIO migration is not compatible with postcopy migration. A VFIO device
>> in the destination can't handle page faults for pages that have not been
>> sent yet.
>>
>> Doing such migration will cause the VM to crash in the destination:
>>
>> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
>> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>
>> To prevent this, block VFIO migration with postcopy migration.
>>
>> Reported-by: Yanghang Liu <yanghliu@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 71855468fe..20994dc1d6 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>
>>   /* ---------------------------------------------------------------------- */
>>
>> +static int vfio_save_prepare(void *opaque, Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    /*
>> +     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
>> +     */
>> +    if (runstate_check(RUN_STATE_SAVE_VM)) {
>> +        return 0;
>> +    }
> Just purely curious: will it really work to save a snapshot for the GPU
> assigned use case?

I have never tried that.
Adding Tarun, maybe he can answer that.

Thanks.

>> +
>> +    if (migrate_postcopy_ram()) {
>> +        error_setg(
>> +            errp, "%s: VFIO migration is not supported with postcopy migration",
>> +            vbasedev->name);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    return 0;
>> +}
> --
> Peter Xu
>

