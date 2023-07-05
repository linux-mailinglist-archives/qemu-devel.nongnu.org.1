Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0E747CF8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 08:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvtG-0001bs-Fv; Wed, 05 Jul 2023 02:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGvtD-0001bT-Rm
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:21:24 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com
 ([40.107.243.50] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGvtA-0007Ho-H7
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:21:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0kdpNj4/Wo0e1xFISYpjmKHvGjojDDIUtKafQOEMapWi5tOV6nRexUgOC5TvbomHrhEFl3kJ4vSe/8jKA1b42prBKNuH7pLPW9gw7hOHBW+P/RbzzcYMHwiibfTagjSyD0hw0qJgMiJrUpAe+mVTv5XtTc9Ks8knSHOvYcH3j01wJTMHm8GjV8c9gXA8kt5qCD71idIgWVwliHw72uYNNt0JkEQWWiIaSqb5VRCbS3v2TXGUwXV8XvlW87+0bKKsdyKKTbnP04CWqt/0sDFlNQWWROafL6Ceqop8x5s4oh9u+LKGDQ1I3uhh98SJswYF8kcrlGl9HeVt5cnu3v+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w4nJY6LlZDfGkplh7lTtc4pIOEptdwHzOrmO2F4c+k=;
 b=eVq72+yt5hMXxEG8mNjpaWwMqgoGNAWCPKSBUj6Fgg6Hl7LiNT3GUd6wYwfVp1g5effQvX/23pFrfMzLtyXjbqGE7+VScnFYFuMHJTa7GIz5RpN4q9PLDWFyCLITyoEtTcNkBMzI0eTth2CdzLh4eHwHZYKTucG25Rb6IGAVV8Y/VwGd0adqet8EMFXBxGHun8pKcTk/AJ/70lDiKBMoD8SNVN6LdGx29VT5eEctMbvF2uE4Te5iJZgXNscWtWxON9RHa2KjdOCOQPQJJDa83ws7mdrzgKL9nTj1qhNDpUahxeJyqooZEe6dKRoJFJYeHwhp8g0TAW9upWHywzt0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w4nJY6LlZDfGkplh7lTtc4pIOEptdwHzOrmO2F4c+k=;
 b=kFLRxz4CnvaPWkJTXRgk50fXSqOWHmY6NgsDd3jjCr7roJn6RHzJTa6lHuAIvRA0ua3T6rwKyIv9opVL5b1hi867EQXAyii8+vnUnOxva1l0LSxQyHhQNRsQOUZqnNdVXZITl9xV27kSOECXyd0amQiyjiNPHSZLSks+jENTFVhBsRUBpfF/4Ih4lAzp6Hw4tk9lK1P01S3P/w/WXo7UT9I+99DZsu14vjoAN7P6nm/A8RkOUX1/EoZFwgIrFCuJCqKJtp9XVxD2FSk6+5liXnb7PWxUNVyZre9NUIv/cvH2rw/ThxK6HOnAv4Mt1hJyGocL0COtGwqlMAv9ISa7RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:16:14 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:16:14 +0000
Message-ID: <3be3c6a8-d160-3357-0643-9b741aa7e660@nvidia.com>
Date: Wed, 5 Jul 2023 09:16:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230704133927.24677-1-avihaih@nvidia.com>
 <4795eb6d-7409-0e1b-9c17-ad31718e3170@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4795eb6d-7409-0e1b-9c17-ad31718e3170@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4739f65a-e153-42b9-8ff2-08db7d1f55ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqr7zE0YnoNQB7Q3V88y+/uuP8xCf/c9mF3v4kywNd9d31jsS02FHWvNhQTZY9C44DEMx8tBqDYU5u/zNNpjCWL+YbFHSbvyRs82M+bRvy6vGT+5PQepJRHWigjVbwFBL8RkDWGbBjyJ5kRH7+feTcFizp7pBPdynz5qFMUfx2q4H86xnqK2F/Nl69iBDpOfAa0NBgqv7KCca1KXM3YUDEBif4EeBkFuJ81D6Vu+IfG/hhqnA0Nyakku1PuQDneUhNPJgJjW2VvD+k7q5bMyqCSp2Dgg8Ss1Imj9EimADgllu9NYJboRiBtXyEEzVYoCBP6T1D6jOoGrmhW91Nod4/n1iP2ZBnAX3+m6RhcfKKCaxcWADqsyfgidtfXk1zs6LdNwwr8e/hT9dtai8dfIV1JCUmHdHrKDLh6kZyRMPWxvWxmRiYLJTeyu+w1ndb9Lx/fAHdhIWWwse0WfE5fnKxz3bf+hm/TNLl0S5IIztfyEzTBDIybHmtduCA0l8792vnXN/MCUGrCSUdaihxw2BMatl4Ky9Y806N6E5tYLR3hdDwC34xo2RfE9IRzakCrMoa7jEWzzOx/ff/iw9h2lRaaa65p1xFPHh8cVplD4NU9FSO+pV8ZJPrBhc82OdpRqMIXYNBIWFIjeYDr6YhTG/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(26005)(31686004)(478600001)(6666004)(6506007)(6512007)(31696002)(86362001)(2616005)(186003)(53546011)(66556008)(38100700002)(54906003)(66476007)(4326008)(66946007)(66574015)(83380400001)(6486002)(316002)(8676002)(8936002)(41300700001)(2906002)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdtbE52aXA5cVZzS01OYnlJM09aYndtMGpSSk5SS1pna3B3L2VTakJ4RTJx?=
 =?utf-8?B?TEZBZC9sN2Z3cXYzb2JlVWNrdzMyRTNXcENlZldSemw3WUJPTXMvbkIzbUZu?=
 =?utf-8?B?NG1MWEZZd2loSU90Z3kwK0xYdnhqVFBhaFJZMVVwMU5od0lPeGNmQVVkS0Rv?=
 =?utf-8?B?Z1ZBSjh5U0Rrb0xmU3VXdTFZazAwVG1jRjFPVXYyYTNCa0FaYVBFTHgrejZX?=
 =?utf-8?B?MDVqQVVzLzJIU0luWW80elExY29ZM0ZMbDBadGxnVFZhaVZzVEt2UU4xMlhS?=
 =?utf-8?B?bW4rMThnaDVUQXY2clBLVlM3bmFhamFxS3N3bEFDRzJJWDh1TFZBRWxpK2hU?=
 =?utf-8?B?VG5FeU5mU1ErZmZES1NwbXJzMzdhRVpMbW5TT1UxSHh4VTdXcWVRVVZhZjlP?=
 =?utf-8?B?QkVwckZ2aVlwdXUrUVlSVmprQ0oveXlvS3ovZDh6SFJmT05OYWE4UHlISTha?=
 =?utf-8?B?NXBraUZMQVZqdnc2b2tiNHVoMUQyeE5Xc3ZhL2xuVDl3Yzk2RFg0ejlQMHR5?=
 =?utf-8?B?bU81WTJOalNXanBWeHEwNzJTN3JEM2Q3S2VNMWJJN1loeWZ2NGFZUDV1QmxN?=
 =?utf-8?B?TnNKdFdzcTB5OFowTklxd1JoMlFxSUhCVU0xUGNOZDkwK1BGelJWZzQyVnFQ?=
 =?utf-8?B?VXBUWWhEZ2VBRjF3NUlJYmNJS1paNm9YRXBUUTR1OEgwZ2lIczE5UG1qcHkw?=
 =?utf-8?B?bUZydndGT1I1VXZiOHBma3RkN29lcUhoRXNDZnh2ZzBUWHJTZm92MFR0b0Yz?=
 =?utf-8?B?WXY0TjRWbFJQcllBNTM0K2NaQW14QlhRWkpXSnl4bnliS1ZaWmtTdTZIRVcy?=
 =?utf-8?B?T1B0eTBtdEo4dmF3S3RUVVBWdDdIdDdPQkUxbFJ4Z3F6RC9GanVYRkNTOG5K?=
 =?utf-8?B?Q2h6aFY1OXhlMEtuZGREWmwyRUswd2F2VHJyVGQ3UU9XZTRnMDFwS0h0NmNi?=
 =?utf-8?B?Vlh3bENoNlRHYXdFb3dVWnY3YnhEL2NFcjZxSlJmY092VkczUFQwcEtydFpJ?=
 =?utf-8?B?bkpKL1VvaEREYjZDNC9IQ0J0aHdIRk1NVXYzL21OSVBXelgraHNNakdQTC9t?=
 =?utf-8?B?VlVQb2doWTJjS1FnZ3UvSldSM0NSVC9xRklpV2JUUGVoL0hIcU55OXJCWXdY?=
 =?utf-8?B?czNwbkZ6bFFUR0I3dlRPemJhV2tySWZMSmhxbzhlL0xDUFUySVh5TVVVeE5m?=
 =?utf-8?B?UjNndG9hWmk5OWNHbU4rZnFhZEhsMzhjMHhzUG5kTFhhaDZxSWZBZ2xIZ1VQ?=
 =?utf-8?B?WnFkRFR5ZDkzNDdPK01hSkdhV2FKR1ZEZm5XNVFTZ1Nqanp2NEtyMk5kK0lv?=
 =?utf-8?B?enBWNnhLdHJaaXBYRXF6WEhuV1ZESjI4VDlOODl5c3Vjc0hqRWJJSXR3VFZM?=
 =?utf-8?B?RGFYcnN2ekIxTkhaTXYrSDRRMGxaRGdrTHBLM1oxR0JNd083WkhQcXU4MVFD?=
 =?utf-8?B?eWx1d2xzUlQyQ3IwNE9IeDNSazVSYjgzazZDNzZFN0ZCZHJTdWRZUERoMmZT?=
 =?utf-8?B?UExTd0NOVG5hWDEzN0NRcmJmTW04NTIrQlZ6ZEdmOEw2THE5ZWNwdTlvOFJF?=
 =?utf-8?B?eEdBQXIrL3RlaUFvZDdGQXQ5MnFlTVBlL1NoWnhHR2p5ajY3SlhhUFNsYXV0?=
 =?utf-8?B?Ny8xY29YUW9qSUZXRXBMQjd0NUEzTWVKK0VGVXlPTi9pU3VpSDBObzNTbU92?=
 =?utf-8?B?OERtQkRaSkVUTm1wUTVxL2ZZUjVUazZxZTNGbDE2ZnlqWU5wSGdFV2tJUHE5?=
 =?utf-8?B?WU5Ua2l5ejVnaWZNcno1UWJIdThxaDNnR0tjY0xIeHJ5UHpldkVSQTZSbEdH?=
 =?utf-8?B?SXlDTmtLSGdlbW9ya2xKbkxvNFROMHR4eHZ2RlJzUzFTd3pVRHBybng1WDFF?=
 =?utf-8?B?dDE5RmZkQVZabHRNcVVmRk9ub0loNmwrZWZGd0tHQ2MrYVBLd3pmMzBHL3NU?=
 =?utf-8?B?QWwrN2x3THdqVlZ2VldpTnFFOHFwWW9yRVh2cm9tRUVCRUg5QlFiZGRFRzhI?=
 =?utf-8?B?VDVCR21IMnVOVU9rUy92M2xMSzhLN28zbHhZV3owWTlZaHd3eVp6UkV1bjlq?=
 =?utf-8?B?SE91L3YzTFYxRzFoSTh3VFk3WU5YMEU3S1Y4Tm1GTnBLSTQ2d1N4dFhDa2ta?=
 =?utf-8?Q?k/nh5lDRQHOUeN6iW6E8/eA/m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4739f65a-e153-42b9-8ff2-08db7d1f55ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:16:14.4389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wlvnPPUR0btRw9VBwJraew/la/y9AXfiLQELB3dCMsjxtKZSaytlm6F2v0/lG7PpEAf6S0tphGwzwM1FbIe/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Received-SPF: softfail client-ip=40.107.243.50;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 04/07/2023 18:54, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai
>
> On 7/4/23 15:39, Avihai Horon wrote:
>> vfio_realize() has the following flow:
>> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
>> 2. msix_early_setup().
>> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
>>
>> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
>> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
>> allocated.
>>
>> In this case, vfio_bars_finalize() is called as part of the error flow
>> to free the bars' resources. However, vfio_bars_finalize() calls
>> object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
>> thus we get a null pointer dereference.
>>
>> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
>
> Did you see the issue by reading the code or did you actually crash
> QEMU with a test case ?

I actually got a segmentation fault after msix_early_setup() failed (due 
to some other misconfiguration from my side).

>
>>
>> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
>> ---
>>
>>   Changes from v1:
>>   * Assert VFIOBAR->size and set VFIOBAR->mr to NULL to make the code
>>     more accurate. (Philippe)
>>   * Small reword in the last paragraph of the commit message.
>>
>>   hw/vfio/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ab6645ba60..bc98791cbb 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1752,9 +1752,11 @@ static void vfio_bars_finalize(VFIOPCIDevice 
>> *vdev)
>>
>>           vfio_bar_quirk_finalize(vdev, i);
>>           vfio_region_finalize(&bar->region);
>> -        if (bar->size) {
>> +        if (bar->mr) {
>> +            assert(bar->size);
>>               object_unparent(OBJECT(bar->mr));
>>               g_free(bar->mr);
>> +            bar->mr = NULL;
>>           }
>>       }
>>
>

