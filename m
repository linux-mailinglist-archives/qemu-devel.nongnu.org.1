Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A147BC6B6
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 12:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp4Ot-0002nU-5g; Sat, 07 Oct 2023 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qp4Om-0002n8-GX; Sat, 07 Oct 2023 06:19:05 -0400
Received: from mail-he1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::70f]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qp4Oj-00080U-Re; Sat, 07 Oct 2023 06:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiFyLeOyrpsjhDdyaPwqBrsmGhXqCb/Yh+Q0YeymKh/03G4lfVgXMbBjjUqpFnxOoSHalHZWNdwKqRFsBa9G1SSD6ADj3gMFUQom/TmASr4wKnMFFbEYkBfNN71vOaGvALyWInxCw+E16Mln16cduNALtvmGQG+6jc/VCWCFrY+366/kuJPiA9eXjhuJQ/9c8WmX98apZ+Yuc4aTsL8NSDjwe7o56KAlN4/MafQGrccwc3MH6m1X17D7pcF0rOEzum+OCXDYPi5E8fpZsK5xmi5cGoptuc8Q6DapNGeoxx/+vjuswZfQoKlq4bv77Nhbpxes5gg4SM9yM6LUZ9HfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAyK/NeqsGhaEvKKkQqVanGC+UqBnYzr8OhH0fRtOKY=;
 b=RbnRbpm0fFePEgOLKJZ5Q5jpMCFpaMxs7x2GGWfde+jeBaxIrYV/pcovydqc0nDBgFQtHPzYkDMlkgjQhGJQfbPBY8kRBy1v3UxTuF7U7oe04Q8LtRAw9O4N2o3kwgu1eJgz0XQ6zMpVeyJOOSLBLqWDU0l5r8izBmUX3iMm0wKZ6f4nGstcJhvPMenN+6NY4l3i2UR3IDG49JGBSWMKHS0EeffOH60pAu3pMsddGN4kxJnI6EmNSYKo8I6swCQYNLTwOxsdaPa3/AsGB4Y306Zx28H1dDP4IbQf43aHqihl4bC1WTjzW6/ha0CcsKWmTEBuMdTqg4PW4NYT/ywIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAyK/NeqsGhaEvKKkQqVanGC+UqBnYzr8OhH0fRtOKY=;
 b=JBFs/ZyqAAof0/EIDpG45IHXib19kY5vhH0Y7lzSjmq3MVSOqUCs6/8xaKeV37tENhLbNiIHap2ZGPBssjXTQVms+XxBbTnPws2h+1SiqqQ+bZrH7XR8sR63rs+P9Ghveh0qFxMxUNbgYC0DcSOMvcfeZ8ckDjvtAXw25+B5c8pkOUYZuP2xqEUcwIFqmVq/NIG55liecel8wyH/nzM//h3FEPHfEnxHD2Cmk73GZbE64Z65U+vEtGLNxL3ChBQPyJZ0kp1Dt3uHa8HTEZIIUeXeTDZg5nRI9RBiPJuxb9kMRT3bSITBjTnRHD/KAuNWMf4lYZLhmgaF24CauZKReQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB5883.eurprd08.prod.outlook.com (2603:10a6:10:206::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sat, 7 Oct
 2023 10:18:55 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%10]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 10:18:54 +0000
Message-ID: <f050b078-1f8d-41d1-a469-4f92d4248580@virtuozzo.com>
Date: Sat, 7 Oct 2023 12:18:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] parallels: Remove unnecessary data_end field
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
 <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
 <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::37) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3616e5-a19e-4bde-8d2a-08dbc71ecef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbp2h6iGZWSu/JaZ2mh2FNCMFGO8vCHwvHqLmaDGRqL+VGm/EELOHUgFqW5QSFUjNnUM2bZm+/VsCO5MQKwcCLNcAXkS8e5cCwXlDA4jdB6r0FCMdtmrMXs1y36zcoWrj7grYRiFfVB/X0IIMhjZrnOjuGC38/qwu2Pxndldm0WMfzdGOO8pvTo0LAIBle+WbWnYJwy+H/AKIp2cUhEeuRH9MoJPcdAwUjiyG31n/ohhmwQ5fBtsN2QSpv+Bw7SxhkUDPsXh0Qm3qEqK/g0PrhJ5hwj3QiMz+WVHUil2uwoJq8sOfsVSvxqErFOKYJ4wl67o6poEapIjmugC6175qokY7ziGjU82fX/6SuKMbVsvZa2G/QNh2H2E0a7LR8nmQaeNJ5dbAHORbv/7DdvnXJb3Qx16fquFZ11AnvT3RW3jiLEoCqk791G5e5FeKImrSSt005yQXvpayckzchH2oFWjr4MPcwkM7dzWL0LLHx1sk2yDZnp8uI/8cZgt3QpF5GCO+Kn6a6tMnH4D12wurzy2ON9SActlqnT/ploJv8piayYkWxtbm6Fi6Aq2NoYOl/qyqNeXzU9u1NK6xn3BTpvQ/rl0qHBqdwSPKa7/V0HbrNeAstipKkR+S9sN5H0ugS62PAImZai3CzCBs0hqjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39840400004)(376002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(8936002)(8676002)(31686004)(4326008)(6512007)(6506007)(6666004)(6486002)(53546011)(6916009)(316002)(41300700001)(2616005)(31696002)(86362001)(38100700002)(26005)(2906002)(36756003)(5660300002)(16799955002)(66476007)(66946007)(66556008)(83380400001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNONlFPOTNGczg0SWt0NjFrTlFpdVQ1bFR5eVJvS1J3aUNkWElHUVpEM3gw?=
 =?utf-8?B?dVd0YVZMK2x3c0xUKzJyckh2aHEydGJmMDFidW8wTUllUDVEOHJNYmQ0U3N2?=
 =?utf-8?B?NVkwOEdUSnE5L1lHU1ZJN2VHRTBzeXA1emw4czBWVXNRL2tCVmw2QU14bzFI?=
 =?utf-8?B?bFlEVFQ4V282ODMrS3dJRTRxNXNhT2prZ3R0MWVlUjhFbUFDeXNuWWgyQWhi?=
 =?utf-8?B?L1IySGswRHFQZnpBYk95ay9mUGh5bENUejR4NWtxdk9pcEptRXFydTFpSDBH?=
 =?utf-8?B?Z1pzY1dpNHZuWkRzcWI4M3JvNi9HeXVoUW5ubHpLRmNLcHBYMk5yV3hrek1C?=
 =?utf-8?B?a09vWHMrdFNNak9QZFQxaTVtUW9ScmFEWWc4RlZvanRsU29HN1hac1BqcFZ6?=
 =?utf-8?B?eEprQnhHdzFBeGREUnNJbU80ajhwbjdhTlBUSmRUN0RoR0x3REgxcDlNQzVC?=
 =?utf-8?B?cm0yeVgxUmxUOVBnK3lXUHBGOS8xQVJlcVZOUFRoRktoZ1hDSWc3VkFHWDRy?=
 =?utf-8?B?MWNTRXN4bVhsRFhxWDZKdG54eVpuUWZDWWdiMWV6dmRZcks1NG80bFVid01E?=
 =?utf-8?B?S252Wm8yNVFsWC92RjR5MzJneGJHdGJ2RmpiRTNRY1BUZHpGZUJzSW02dlJJ?=
 =?utf-8?B?eGttdVRkaDZTVnk0aGRZcVQ4VmlQMnphYjFWVXRWTUQ1YUVJWDk1NDJUZWxT?=
 =?utf-8?B?UXRNVDRnbWpVQ25TU01LcXdiSS9zOGR6TkdmaldFR3NlRDl6MHRnMnFyVk0x?=
 =?utf-8?B?OFVSYUpSNDVieDhkOGcxdmdvdGtIZjAzcWR3UThRRmQ1MW5CbkpNQjRBYzJH?=
 =?utf-8?B?OXJqM0xWNWxDUm1qOHVORmk2V2U1WjBwVWUvWnRXQjJBMEJ5RmFLUkZMd0Qr?=
 =?utf-8?B?RFNtOUl0RlBOdmd4RzdxakxlQnZOeGJ0eDFPMVpPTzAwNkFEYmFScUlQT0Z2?=
 =?utf-8?B?TzVYZFMwd1RURVZCcjRQZi9weVFvV3Z2c3Y0SWhOWmtIVXlqSCtpbDM1TThO?=
 =?utf-8?B?VXM2V0llWnlSVzE3WlRxaW15M0JiUzN2T1JQdFNDUGRpckhYUDdFcjUxNkp4?=
 =?utf-8?B?ZXJZMnBTYUZMOEgyZUlXaHNRVUxSTnhHd0F0cTR6M1BZNkFjOS9jdGtQNmZB?=
 =?utf-8?B?emRBU2QwL28xQ2hxdVo5Y0RhRFZXV2tiQWFVcHdoU3hmUWVGdHowVmE0cFBz?=
 =?utf-8?B?cEJzVi9PUHdUNFYxR01VSCtIUE83V2V6SCt1Z2FZMnAzUVlwUEhvYU5sQytn?=
 =?utf-8?B?ZFRnRHM4RXBkU2hPRjN3UHdXSHhxdDU0SGJFZjNCN1ZyK25nZkJaTys4NWVR?=
 =?utf-8?B?dnZXVlZuUW84UkdITGxXSmFMTzZrWTJXc1RyN29JbFJ5d1l5cEcwZlFCbzZX?=
 =?utf-8?B?cTZ6SHRLN2pYdUlEMWswY3FHd2J5KzVXektVVTlrc21nZUhGSEN4WThXQmZ0?=
 =?utf-8?B?Sm9McFEwb2s2Mjhjc0Z3TFlNenZoTzZsVVZaYk55THliUTNPdERabTdGb2Jo?=
 =?utf-8?B?L3RoMHlObnpxWEtJTytVdCt4TWdyWUV1RkFMZEJsZnZOMjV5MjNYSzB3OUhX?=
 =?utf-8?B?ZlFsMW5YV25kdWJINktnU1lXdnF2VE8reTBOenJjdmtuT3RRYkp6dnBHMlNk?=
 =?utf-8?B?dDgxVU9pcTVUM1NiUTk2dVgwYWhHVFlHUU0zMmdubDVWZHBUTVVrZUlwM1Bs?=
 =?utf-8?B?ZWh5NFhLeWNiQndiLzRLNnVaTmUzUVFkMEF6c0NGd3ozWDRadVBWU3UrR3o5?=
 =?utf-8?B?NkNTRlJkc1RUdHlWV0xmUGF1Q2dGK1BGM212QlMxSkdrR0VHN0VhRGZveG56?=
 =?utf-8?B?YUIrdy9wV0FIdTdvZ09qUlpLQkdkODhVY0NMVkdTZGo3NC9iQ3FyZjZjYmhN?=
 =?utf-8?B?Yzh1blVpRDVpUXpIQnplb0Y0L1crUEloandwclZJcmZEWktRTGpSdkRQN09o?=
 =?utf-8?B?SkFINnRaQjhEMWhNZXNIQkVUVUx4L05nZ1ptZUk1TVY4Y25Ka1MrdlM3bGRn?=
 =?utf-8?B?d1M1OEhyb1pJZ1NSakQrYWNBaDc5amVOcW9xc0RhQURzaCt5eENrYkNqejlq?=
 =?utf-8?B?OGJBaHh1Vldsdm9GRlB2RUNLTnpsZEhtZmhnVzlXMm1NYTA0RndKTFZ1WDFy?=
 =?utf-8?B?d3pLMDVSY29pd29qK2k4RFNmZno4WHYrd1I2TnRQMTIrWDNZcnBKcS9tNWZv?=
 =?utf-8?Q?/eGMek605f+dzHJizVNqd0A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3616e5-a19e-4bde-8d2a-08dbc71ecef8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 10:18:54.1289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq8M89MjOTw+JeealbZd99h1TDRB11jvnI6S3ufp5SlkCK+hHXMgr9ncaAIw2WIna8E/DLMLDRfSjmZ0Yv8yQlHr/fS8jHBMJhDKo9jBegg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5883
Received-SPF: pass client-ip=2a01:111:f400:fe0d::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/6/23 21:43, Mike Maslenkin wrote:
> On Mon, Oct 2, 2023 at 12:01 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com> wrote:
>> Since we have used bitmap, field data_end in BDRVParallelsState is
>> redundant and can be removed.
>>
>> Add parallels_data_end() helper and remove data_end handling.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 33 +++++++++++++--------------------
>>   block/parallels.h |  1 -
>>   2 files changed, 13 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 48ea5b3f03..80a7171b84 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>>       g_free(s->used_bmap);
>>   }
>>
>> +static int64_t parallels_data_end(BDRVParallelsState *s)
>> +{
>> +    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
>> +    data_end += s->used_bmap_size * s->cluster_size;
>> +    return data_end;
>> +}
>> +
>>   int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>                                            int64_t *clusters)
>>   {
>> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>
>>       first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>>       if (first_free == s->used_bmap_size) {
>> -        host_off = s->data_end * BDRV_SECTOR_SIZE;
>> +        host_off = parallels_data_end(s);
>>           prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
>>           bytes = prealloc_clusters * s->cluster_size;
>>
>> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>           s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>>                                             new_usedsize);
>>           s->used_bmap_size = new_usedsize;
>> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
>> -            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
>> -        }
>>       } else {
>>           next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
>>
>> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>            * branch. In the other case we are likely re-using hole. Preallocate
>>            * the space if required by the prealloc_mode.
>>            */
>> -        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
>> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
>> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
>>               ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>>               if (ret < 0) {
>>                   return ret;
>> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>>           }
>>       }
>>
>> -    if (high_off == 0) {
>> -        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
>> -    } else {
>> -        res->image_end_offset = high_off + s->cluster_size;
>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>> -    }
>> -
>> +    res->image_end_offset = parallels_data_end(s);
>>       return 0;
>>   }
>>
>> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>>               res->check_errors++;
>>               return ret;
>>           }
>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>>
>>           parallels_free_used_bitmap(bs);
>>           ret = parallels_fill_used_bitmap(bs);
>> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>       }
>>
>>       s->data_start = data_start;
>> -    s->data_end = s->data_start;
>> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
>> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
>>           /*
>>            * There is not enough unused space to fit to block align between BAT
>>            * and actual data. We can't avoid read-modify-write...
>> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>
>>       for (i = 0; i < s->bat_size; i++) {
>>           sector = bat2sect(s, i);
>> -        if (sector + s->tracks > s->data_end) {
>> -            s->data_end = sector + s->tracks;
>> +        if (sector + s->tracks > file_nb_sectors) {
>> +            need_check = true;
>>           }
>>       }
>> -    need_check = need_check || s->data_end > file_nb_sectors;
>>
>>       ret = parallels_fill_used_bitmap(bs);
>>       if (ret == -ENOMEM) {
>> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(BlockDriverState *bs)
>>           end_off = (end_off + 1) * s->cluster_size;
>>       }
>>       end_off += s->data_start * BDRV_SECTOR_SIZE;
>> -    s->data_end = end_off / BDRV_SECTOR_SIZE;
>>       return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
>>   }
>>
>> diff --git a/block/parallels.h b/block/parallels.h
>> index 18b4f8068e..a6a048d890 100644
>> --- a/block/parallels.h
>> +++ b/block/parallels.h
>> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
>>       unsigned int bat_size;
>>
>>       int64_t  data_start;
>> -    int64_t  data_end;
>>       uint64_t prealloc_size;
>>       ParallelsPreallocMode prealloc_mode;
>>
>> --
>> 2.34.1
>>
> Is it intended behavior?
>
> Run:
> 1. ./qemu-img create -f parallels $TEST_IMG 1T
> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
> 3. ./qemu-img check  $TEST_IMG
>         No errors were found on the image.
>         Image end offset: 150994944
>
> Without this patch `qemu-img check` reports:
>         ERROR space leaked at the end of the image 145752064
>
>        139 leaked clusters were found on the image.
>        This means waste of disk space, but no harm to data.
>        Image end offset: 5242880
The original intention is do nothing at this point if an image is opened as
RO. In the next patch parallels_check_leak() was rewritten to detect
unused clusters at the image end.

But there is a bug: (end_off == s->used_bmap_size) case is handled in an
incorrect way. Will fix it, thank you.
>
> Note: there is another issue caused by previous commits exists.
> g_free asserts from parallels_free_used_bitmap() because of
> s->used_bmap is NULL.
Maybe I don't understand your point, but if you meant that g_free() could be
called with NULL argument, it's not a problem. GLib Manual says:

    void g_free (/|gpointer
    <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Basic-Types.php#gpointer>
    mem|/);

    If /|mem|/ is |NULL|
    <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
    it simply returns, so there is no need to check /|mem|/ against
    |NULL|
    <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
    before calling this function.

> To reproduce this crash at revision before or without patch 15/19, run commands:
> 1. ./qemu-img create -f parallels $TEST_IMG 1T
> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
> 3. ./qemu-img check -r leaks $TEST_IMG
Sorry, but I couldn't reproduce it. Reset to 14/19, made the three steps
and had such output:

    $ ./qemu-img create -f parallels $TEST_IMG 1T
    Formatting 'test.img', fmt=parallels size=1099511627776
    cluster_size=1048576

    $ dd if=/dev/zero of=$TEST_IMG seek=12  bs=1M count=128 conv=notrunc
    128+0 records in
    128+0 records out
    134217728 bytes (134 MB, 128 MiB) copied, 0.0797576 s, 1.7 GB/s

    $ ./qemu-img check -r leaks $TEST_IMG
    Repairing space leaked at the end of the image 141557760
    The following inconsistencies were found and repaired:

    135 leaked clusters
    0 corruptions

    Double checking the fixed image now...
    No errors were found on the image.
    Image end offset: 5242880

Checked with GCC and Clang.
> Regards,
> Mike.

-- 
Best regards,
Alexander Ivanov


