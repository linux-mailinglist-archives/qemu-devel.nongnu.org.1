Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA547A4A85
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiE5e-0005y9-OV; Mon, 18 Sep 2023 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiE5d-0005xc-2z; Mon, 18 Sep 2023 09:15:01 -0400
Received: from mail-vi1eur04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72e]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiE5b-0000UU-0F; Mon, 18 Sep 2023 09:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSjgJsA8MEaJ06+1JTqr4E1TeNeYywRB4om5iBxBKc9DiLrm13WSFgXCLf9KpEj7Hkz0LS5vyP/1UiutmIfzO1iYEMQn6kfF3PmzUSN4SpKdyoW97UwvXLKT2+K5xbVPv28aRPwDnOBWyAK+3HIUsrcZ9qM0Apw+fj3Rjrl7O625QnZ8VkZ40ukbboJcZ3DiZnRzCDBqMTA5lcH0EH7M7XUzlto3o4tXQOvauhzwj+jKq+Zb+SbvJblXZXXOTQrPa4mbCpYLmSqzDUctq0bjjebiXijwNrQi05hV3LIQ6DahjXyui78pb6PdoKk+zcFI4/kXi9/dcU6a5qM/5MioyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98G2yJJf57KBuYbnx+Uk5T5ImDJF3AcQYhUBEtm0GM0=;
 b=X/R2//jvMtQZ3yMF2Jw/E5WFxcH/M11XQsdsBkahO29z9/8I26g3OaSLMsOgzKCchurovvoyai2JvUZDcFHLOy9Uj+dNcr85RBTL53FsxTxY9Y8sd32HZ1GQjdyACJYOaQo5iZiwZMog8oYF4SjKEsu+unMyude1XSHd0sy4V3uLsbGBsIUekhXMvHQhqot+H3T8kQt48vQSJjrfFQoRCqQqOFBYjRUgAU2e5RC9IuocGinWbQwoynf+QpRugGhFAcG5SJ88S3Uurq/o198M8b8deoP1HoJp+PXLu6uKsBjLsk08dhuLJbIm8Kqs8V6B5usXl0RFvA1eM49AudJgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98G2yJJf57KBuYbnx+Uk5T5ImDJF3AcQYhUBEtm0GM0=;
 b=aBpM/aLw2uf/tJ4xrlHAyM1rHIqeB7AAhmjX8DZTD19/iq/Mtj2ot0KX9I1tGk5umbJT/VjRyxY1hXuIxJalrWsvm3u9yRCNWAC5l1bgBQScA9QgZ15P/xt7zFj9RYrOIIPrgyAb/mDk1RJ0TkREOavgy/fFoihqX76JcUM5+3+Cl1jopj4bYmTUdo5yL6PgyN8VQ8nhWQTjY72ZC2zQZZaPYuf81O4mT2+1WlPfQdSg5PcGlHf9ilnxTtnGkwcW2cSgQv/c0rUD+i1n/HTDV/5VUkrx+SQl/eJ5+2uJhjX7BCjM3XF7NBeZwgEUdEMx9yPUtu+TQhrlz3z+Sv/Knw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9414.eurprd08.prod.outlook.com (2603:10a6:20b:596::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 13:14:53 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:14:53 +0000
Message-ID: <9bfb91aa-d972-70cc-fd4b-e9d02f2698f4@virtuozzo.com>
Date: Mon, 18 Sep 2023 15:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/21] parallels: naive implementation of
 allocate_clusters with used bitmap
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-19-den@openvz.org>
 <30261650-cf9b-7420-e9fe-7825ea151890@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <30261650-cf9b-7420-e9fe-7825ea151890@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:803:14::21) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: de199a99-fef2-4e65-89aa-08dbb8493ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkofMnCsErYsGv3O3EoNxYs21L5yIQMHzkGEB0Wfpbn3bLM4lsBpqGxtozmsZ9+bLxtag95gHj4AN0xchix7XdgDY0Hluvo/Mnod2nHKkNFL6JrbfXVeo828Rbu21bnKjS7ab5IWqZYFKZVR5H6ffNXPeSBL4oR2uhEQKHnXT5vMZLZlPw4rriQhxT8Q/5OOoNFZH7WEdHQoUe4iLvkKVE2oOO+voioW3Ibqqbtmae7vdgX/w8N8CfL+T8HBqNAJhjy3G6nEud+aGyQMaYXBTjIXT3w+Kw4kHfg8kAtNo38rtzarDycH0IMogkHfcO1e2YSakCX/sJRNZRjVHafgkXdw+ETk3kpktnIwZcVNo1I90Kym5gDu9V34qLrpQkw3JQyYnHxnwT0PLu0dKeuV8yerYie5ywrxhDwzK/0aFTDTfHCqaVBcp/94p28gY6BkgCaYHpNWl4crH1SvGAkjx+GtTAewbXATs2t14dtBBGYQUf27O8E7XNnCqoepOKDeDDNIf82o2ezTIU09et9iHuFnGwbo8O6fKjT32x+yk91QjwKVBSwNVeFVcyCxQcdfuKHR8mQWorIDL1z+ZL0VWycg4GpyC8g4RGL9orRr3rGEC7N0nypwc72JAnlw2SEhvgu/y1+PIa7+ZbTvJFb0lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(39850400004)(346002)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(53546011)(86362001)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(31686004)(478600001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhpdEk2Wnh3cHY2bTJrMEVSOVFQZ3NMYWpEL2ZHa1JidytYR0FYblhDeXlJ?=
 =?utf-8?B?RkRXU2Z3NFlaTDFBamZ3dVRuV21xMmVkbk1tSlRjQUtCNCtCOTJVSnRPaSs3?=
 =?utf-8?B?TUFDZFI1RE5xZUVtK2hvOHRVQXI0bExJWEp1VjUyNmtxWUZ0N2pXSk1aZmFX?=
 =?utf-8?B?Ukl3TytSZTY0OVdmQTdjMk1rVzV6bjRUYktUaE95aEM2VXJaNEdoOVFhanBC?=
 =?utf-8?B?WU5FaStlK1NqdTAyOWxieDRmdlFodmVGZnZYUGszcHFvWWhjTVVFUlluTnpl?=
 =?utf-8?B?N3NkeWVoUXROck1MQmJrTUY0dmNWVVRmVU5ZeUxpZEF5MzNwZnpDOVMzZDNv?=
 =?utf-8?B?aU43REEwSGkrVU9wNXVsVUg5Nnc0c1p5OGFDTldjMDBnZlpiWTRIaDJCYnJ3?=
 =?utf-8?B?dWhxQWo4Y2NtcnExU0NIbHVyc3JGVjZtMjBSMGpPYkpCOFo4RnFVKzI2S1Nw?=
 =?utf-8?B?NFMzOVpwb04wRElqYVMwVVgrWk9BZ3RjU05HN210MDUxN29rTm1iblVuSUFX?=
 =?utf-8?B?czA1V2k2ZVhtZ1ZpRmN2bmt3RDRhby80K0ZFMVR2MlEwT1ZQMmJhSUFEYWxC?=
 =?utf-8?B?OGJlTkxyNUJsY3c3Wm96eE8zcml0bEhoRE0vMzkwSFdheUZabTFsVGQ5eG1i?=
 =?utf-8?B?VUh0QzVFaEV4ZXJ4UW9EZUpyQ0FIek1HOFdvRUR3T2xGYjF5Y3kyaW1jVHJF?=
 =?utf-8?B?U0djTjlNRWFYQXpPNFRNVlQ5dzNJQXdBRkY2WlhiRVRzRXRtMitDbVdUVE1w?=
 =?utf-8?B?Zy84MnRTdmtDY2pkU2tuRnpPOUNlNlAza1Ftd0E0UzNNWG9yUG1yd1RRd2RZ?=
 =?utf-8?B?VGVqK1RTY29LV0I2aUJxdVVsa0lUd1JpLzZrTHF3M1hUS29WZExlVk5NWXJC?=
 =?utf-8?B?dVdNQUxTTVd0eTdxdGpEMEtwTWpkbHBBR0VrcFZJRDNtbHg4OHNQYjUxVWF6?=
 =?utf-8?B?ZVcyRVQrcmVFeVlmVWRJbFJobGNtdTRnSWlUMHRvM2hDdnRGOThlYzQ1TFp6?=
 =?utf-8?B?TUw0SWNVMFVTdXMyZVRwbitCUTl2WERtNXd5YnBuVmlxNWxyb3JabmtjUURm?=
 =?utf-8?B?MU90NDMxZ0Mzby8zaWNmQTNUT1J5V1pTb2RVdGJjMnVFcjdBbktsV3hLbUJ1?=
 =?utf-8?B?eHh5UUgxaXRGNEZlNDdyRm44a050cTJMUGFGVDBKWVMyRE5NWUIvSnczdzBq?=
 =?utf-8?B?Rzlmd2NtT1o5WHdpQ0RZOEJRTHFBSXJCRlh4Q2UycHJkdmczRHJnOE1vUzFj?=
 =?utf-8?B?bklwRkZvYXdhZnp2bUthVFJLd2lEdXdTYko3Y2krUjhBMkJLWUVTKzFsU1FF?=
 =?utf-8?B?R2JzVkNMcXFQSFdiS0M3MFphdkdZYW15V0xHM1JXMGJaTUhoakIwQzM4aUFX?=
 =?utf-8?B?VkNDNVhSUWpFbjd3cERyZm5CaEhVTGJSMk1LRUJhZmZsN2Y5aU03NzIvck0y?=
 =?utf-8?B?MVlaeEpDTjBJVG1nbVlJMjRnWEVsY2N1ZU0zRGtCM0lNaXk3ZkFMRU82UWlG?=
 =?utf-8?B?a2gwSEU2WkNRM2xoblBHSzNnVGIzc1cyVUxqZ3Jlb1BYNFJLR3JuTjUvQVdJ?=
 =?utf-8?B?VUlIWmtnWmdDTmJFUkd3elBTQS9HblJXYUEwSFdRVlJjUDVoMERsekp1SUQz?=
 =?utf-8?B?Um9nVWNhbUxRQ2EyVFVYQVRjUUlYRUxJTkdiZ1BSWUxDSzFqMS9PRVl1cDhl?=
 =?utf-8?B?d2EwanlLVjdCZHZYb2xDcEhDWTNoS09rOGFPTjNjQS9DdUlFZklYaE4zZVBP?=
 =?utf-8?B?citoZnQ5VldqRUVscDJ5bDRHMnVUZndWTndOK3BOakMxak55a1IxbmNZdVZi?=
 =?utf-8?B?aXBKZThtM28rNXVXd05rWlNGS0xjZklUYkdQcGF6WU9aSzhnQkV3R0ZUYXBn?=
 =?utf-8?B?ZytEcDNiNGxwUm5mNVZGQ1lwdjFrV0JKam93L2wxUjMyd1lTZGljL2tHeXBw?=
 =?utf-8?B?TTdscUhOaFR2dkdrLzhhWmpyLzQ3aDNiSUtKWC9WUDhYVWJiNUNhd2hhZmZE?=
 =?utf-8?B?K3JnUm1RK0o3eE1Fc1YwU1RzTThaTENmSE04ZUczWVhmSVg1Y1NseUtqSTRU?=
 =?utf-8?B?MWhtYjRkOStxOXp3K3J5Umd0OWxQaXpCYkMxMGFlYlZFM3RBc1NLbi83b1hj?=
 =?utf-8?Q?vS++BJIG/A7NBR0kmJrJz/0Ax?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de199a99-fef2-4e65-89aa-08dbb8493ee4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:14:53.1606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZFjz2CclCbxECt77w91KQ91nS7IbjExIv+5xBmQYWejf6hFYRXCHuyEL7IlWHDrLcbrfVZeL73kH0pRH2Yg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9414
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72e;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/18/23 15:09, Alexander Ivanov wrote:
>
>
> On 9/15/23 20:41, Denis V. Lunev wrote:
>> The access to the bitmap is not optimized completely.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 51 ++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index a6d2f05863..2efa578e21 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -253,7 +253,7 @@ allocate_clusters(BlockDriverState *bs, int64_t 
>> sector_num,
>>   {
>>       int ret = 0;
>>       BDRVParallelsState *s = bs->opaque;
>> -    int64_t pos, space, idx, to_allocate, i, len;
>> +    int64_t i, pos, idx, to_allocate, first_free, host_off;
>>         pos = block_status(s, sector_num, nb_sectors, pnum);
>>       if (pos > 0) {
>> @@ -276,15 +276,13 @@ allocate_clusters(BlockDriverState *bs, int64_t 
>> sector_num,
>>        */
>>       assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
>>   -    space = to_allocate * s->tracks;
>> -    len = bdrv_co_getlength(bs->file->bs);
>> -    if (len < 0) {
>> -        return len;
>> -    }
>> -    if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
>> +    first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>> +    if (first_free == s->used_bmap_size) {
>>           uint32_t new_usedsize;
>> +        int64_t space = to_allocate * s->tracks + s->prealloc_size;
>> +
>> +        host_off = s->data_end * BDRV_SECTOR_SIZE;
>>   -        space += s->prealloc_size;
>>           /*
>>            * We require the expanded size to read back as zero. If the
>>            * user permitted truncation, we try that; but if it fails, we
>> @@ -313,6 +311,32 @@ allocate_clusters(BlockDriverState *bs, int64_t 
>> sector_num,
>>           s->used_bmap = bitmap_zero_extend(s->used_bmap, 
>> s->used_bmap_size,
>>                                             new_usedsize);
>>           s->used_bmap_size = new_usedsize;
>> +    } else {
>> +        int64_t next_used;
>> +        next_used = find_next_bit(s->used_bmap, s->used_bmap_size, 
>> first_free);
>> +
>> +        /* Not enough continuous clusters in the middle, adjust the 
>> size */
>> +        if (next_used - first_free < to_allocate) {
>> +            to_allocate = next_used - first_free;
>> +            *pnum = (idx + to_allocate) * s->tracks - sector_num;
> It looks, we can write this simplier:
>     *pnum = to_allocate * s->tracks;
> because idx and sector_num aren't changed from idx calculation:
>     idx = sector_num / s->tracks;

absolutely NO! sector_num can be unaligned. Here we get to the
situation when the end of the operation is aligned to cluster
and is calculated above.

Den

