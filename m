Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45297A4A8E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiE9G-00088A-VV; Mon, 18 Sep 2023 09:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE9E-00087V-Jn; Mon, 18 Sep 2023 09:18:44 -0400
Received: from mail-am6eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::725]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE9C-0001H0-LJ; Mon, 18 Sep 2023 09:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2EzObtp5cHtbmljIeYKhECgwKqteU3sv6M8LHuxd2qRD4uBhUZSEEOwZR89b0lWffw3wy49ahra8eOKlgmbdIof14pOudsialcROzXBsTlc8e/FUhnEjJem+u7DSZMHpGN8wRkPTJnw8cXDbjtl4aWr1j6Z7CaqWtzT4dC8etSi6aR8vlvP0XoxktDerh3VSb/hvAB9NhUk5alyBA1U3bTbnIrYuJCc68L4lMPxZ0WFr+CEsUWXk9QeYRCwrrteO4fFboe5x+88smHxemecO2SEeTesEcFtpyw61mbbRaEdjC84S7eX0E7RU6OLqwZsgdjKevhYfqrGDf+DeASyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qtv87Rq0DCwrvHpfxFGaLLpHxy/MyhajLcjNlvoajw=;
 b=Dg63N+H8VkM6GOoTkMv0YGA2E7aKaFvtEvEPnt/bM/ov8jOO0UJS/erel/WweYCGUC4gdqNDYBWTaCU/d02mrQtSdjmAcd+jnlEWZVcTmK6wNp8050q+d1U7k75SOewJjzrn4tO2Mhz/S8Z1eRE0IigAPQNNSkTi5HRRycQDt960sKXtd/BN7oYLu0byVgXdDYBQb/XPWRAO+TiXt8OQyXPXY7/hG9leIB6yV867wMWdc8eRYTbGL/B3krSdFtAJBlhwjMqOxBH6gg4rSq+DTsBA5ABN3dVY5fLo6GdbnBpHZvRIvf5CER60CYPbEBBVmCtkCwiJ3Ov1tmX42TpLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qtv87Rq0DCwrvHpfxFGaLLpHxy/MyhajLcjNlvoajw=;
 b=ca9/MEgaVBOmg3P2msKH8kPtFknHqawzEFDhfbKY5F1J8uROV0TfRJjt0GqjUKyAglqBT5XdYfZ3LRNucqKA/uzy+zIhCFYi5IEbc3F8yzXTqlhaME6KqH7RcTkch2s4ML8ow54fZg7Ezt65xz2FQyYIrCrZgTIWT9PCWbxnkWDGnGtRuXhdnEN4ZW57llCOerQV0VXpw8uL4dP6XWamWQuxRfg5t+3QGiv4lDpnag7q247/lCmVoJp3iWyY1x01rdBBETYwwJjxx6moh0HXy/cRW4lg0H8Tij3I4WV6lLzygUR0t9GUWa61GpVTHLXVw58T8bw8GPPGO3fjy5bCSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB9439.eurprd08.prod.outlook.com (2603:10a6:10:42d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 18 Sep
 2023 13:18:38 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:18:38 +0000
Message-ID: <b2499961-c980-6342-d513-9e19572034ff@virtuozzo.com>
Date: Mon, 18 Sep 2023 15:18:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/21] parallels: naive implementation of
 allocate_clusters with used bitmap
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-19-den@openvz.org>
 <30261650-cf9b-7420-e9fe-7825ea151890@virtuozzo.com>
 <9bfb91aa-d972-70cc-fd4b-e9d02f2698f4@virtuozzo.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <9bfb91aa-d972-70cc-fd4b-e9d02f2698f4@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 10644e8c-49dd-4264-550b-08dbb849c4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh9qx9sfTF4J03nQQ4ItOLxdUMi/qRmxADVxNcAZ/3cDcqlSAM+8hI1sbPiNRpNhCcntDdSgz53cBk8X8TGE3IvJEbv8XJa9tSydhV/IvMrVeNVhnrly3ZX+DJbQPCw3cQ3VKeXfRESbPXOBvOzfglzTEWQZtaZpZIcN6R7LwIib7lSTCyyfdcQK6JqwWjukTl4x3FKoDGWNnfWHW2tBf2BR43Puys6IYvjENno1+QSXwBcMWnpuB+K4W0m7cTiw/ZGdhIB6ttog5DwHeDt++DC4QRDghPEBn9Vkum9EgXQudQiqOT3LTrFi1A3FuT+IpHHPA7hR+pIqw3QFt8kRW/vMxZzz7uJlxtZKWIHOCu8CfwnOCQ7yecyI/FcOAIILq6urdL/1G3AAxDfSp8LsSeheLzvb15S8vbdzcjxJizVuwP+oYgRachvHsxRw0LagXia9qz6+kOEBUk5UHmvnnFaqtC0sMQhkGvSeuTlFFXflFjbxao4JKE5Mk5PXjCq9wx7PLc6neJmH0XRD4tA1klDrtxMegxzQ4qeuBL/xCUNlYIvkT96fGlVGle3rwT9Ol1i9xT11S5tHWtQn7lXoUydnvCOLNhNG+xspslyf/ZDRijYIRJW+K4+0kMhELTzEEqqHMymNTHXVxA3jV51JMM95OG4kjx7kFzjXt+gIF1HZ9ra7d4t7nAsUmG+6x3W2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39850400004)(396003)(346002)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(6666004)(52116002)(53546011)(44832011)(83380400001)(38350700002)(38100700002)(31696002)(36756003)(86362001)(5660300002)(2616005)(26005)(2906002)(31686004)(41300700001)(8676002)(8936002)(4326008)(66556008)(66476007)(110136005)(66946007)(316002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndPMmowak14RXl1RDdRbGdHVGNZblcxMTR0d0lmUXArL1cxczhHcVlNYlFE?=
 =?utf-8?B?ZUYxdHVEZkJWSWgzL2IyTFdHdTM3MWxFRUFnMjR4K3ZBK1Z2UFBjcmplREhr?=
 =?utf-8?B?UGVzS0k4R0JUSFJIcmpmNmphTFA2QnFZZ3NTaTVmNU50SnJVVHptRUNPZVFQ?=
 =?utf-8?B?ZnNnWkJwYklCU2ROa3ZSUXdQZVVlanlvdlFSUFVmOUJTczQ2Yks4WENNTkN4?=
 =?utf-8?B?RCszRVhVVU1zQ0hjN20yZXJGNCsxbklNdlV2Tm54dXY0d2x1VTRGRHExSmov?=
 =?utf-8?B?T05qTFA3L0FKKzlwNnFnelZ3S3N1TmdFRW14aTl6YVRURTZQS0tOcGpWTlJh?=
 =?utf-8?B?RnF2RGtBRDhBZmpRdzZqUFpNYlQrdGVENXdpYU5hcGpaUk9vbkxlTllpVDVJ?=
 =?utf-8?B?SzFYejg2QVNrV0NaNTRVcGlOUnA1NmpoVkdTUExmMWRFU3RRTGRJWEhUdm40?=
 =?utf-8?B?ZDdVVHI0YWhQRUZnZzQwU1hkUUZkb1BYcER4Z1V1UStXMFRsVERUSHY1dW92?=
 =?utf-8?B?N04vdC9XMzl4aFVkTlg3SUFDYmVNVmZoS0pWVVk0aW4zb1ZOUC9hMndpWTBw?=
 =?utf-8?B?ekNJLzVxR2krZWtPcUFZWGovM3FEZFdpVjd2MEtEbjN4STAyd2oyd0pidCs2?=
 =?utf-8?B?VE9lNFhPRVQvVjJ2dXpTR09EemVtRFhtOC92QU54QVBJRzJKN3Z2QlNRYkox?=
 =?utf-8?B?SVVOd1dMK1hwNSt1V3QvWDRVc05aa0Uya3JpMUNaUGQ4cUdFK0Y2VGl0Lzdq?=
 =?utf-8?B?VVhaZ2pPbjZXcjBFY21COVdvWmg2VFo0MU5aMDFwTW5mVnVpcDhpcHQwS1U2?=
 =?utf-8?B?NldsaUJlSGw0Vnp4c21JREFtRnVyemVVaHAxMTNjUmk0cGdKbUdLakhkUFdK?=
 =?utf-8?B?bGl0aFk3K3dnUzZwQk5ZK290K0pPSXRzaW9hL1pZUER2VzRScUg4RmdsbFk0?=
 =?utf-8?B?SWMxT3lvS1NhNzJveHY3TzZRN0RJWElTalUzb2JybGtxWkxwajdOekp2d2Vo?=
 =?utf-8?B?Yi82S1JwVk1Pc3habHpWUGtQajdMQjdFZDZuVnZ0dlJKcTU4RnNJOUc4bm4w?=
 =?utf-8?B?RzRYbEttelFQZktJTUxDbjJwMThhQU83bTgyNDBsZmpWY200Y2xQcWYxTE4z?=
 =?utf-8?B?NTlRYjdQT1lRZEY0d0J3U3ZmSnZSb0JidGxmWGJpck1EVWhMa2VFMDBVVlMv?=
 =?utf-8?B?L0dEVkk3a1lSaWpKUllVVWFYY1Ezc2ZBdndJSTVYZ0RFUkdZd0NZY3VVdUwz?=
 =?utf-8?B?RFFKRkQ0M0lCV0FmV2Z3Zmo1SDFnM1I3RVNEMVd1Mk9YU1RIS2E1Y1NaM3VM?=
 =?utf-8?B?R3h2NnlYaTF4MEE2QThCTXg3WFYweTFCQ2hrckUrbGtScU5kMURNdWlGSE95?=
 =?utf-8?B?cGh3c1MzOTRXNzlnL1pkdEFjME5OSTBGMFYzV0hiZjhlRXZjbFQ1SC9EQm5Y?=
 =?utf-8?B?R1Nmc3V4YVlJUjhEY1ZXOHdCdkltV1RTTkZlbEpOVVYweERWQmlzR0Q4akxt?=
 =?utf-8?B?eFFnZ2pEVi90a00xaDJxdzBya09kb3RuTWNmb3BLMEtSSlhreVEwNi9Fc2Zm?=
 =?utf-8?B?K1FLdUxwN1c5NlZ5N3IrOWg3bElxRmdHWDNvWk1Yd1pCbTYwQ2dtYjZMU0Ju?=
 =?utf-8?B?VEJpeWNKYjR2M3BKMDRZenhMZkV2M3p2NEFVRkxQeHc3N1NQU2krUW1qeS9J?=
 =?utf-8?B?Y1Jjc3lMTVBSYUoxK2VyTVJqcXcwSE1lN2ttMENmejZ3WksxVklUbmZNczhx?=
 =?utf-8?B?NWVXOUh3RFo0WmZRTVluQThqZ1NLbnpKQUprd1RocWkyVjJvSWV3bzRYREVN?=
 =?utf-8?B?ankvUFRqbkJJUzlTQUxCRVdHVlNBK3pmSTAzK0dDRFMxTlUwU29KRXk2V25V?=
 =?utf-8?B?bEtFT2xVUHExU1hUU1B2TVdLSW9PRE5rbUpYNjJpdWpJdllPdGhBNzFuMDFW?=
 =?utf-8?B?US9OOFJoaHpteGF2eUcvbVJvN2d3RjZkbThuZHVneXFKa1BzRzgvWEJLNWpZ?=
 =?utf-8?B?VGVTVlo0bUExYnBSWU5RRVJ1bUQ1Yzhvc1JaTzRqSzJJT1hMUlhuTGtaM1Jr?=
 =?utf-8?B?V2tUL3BXaWdjME1TSEUzbkdWSkVOTkZQekJhOXdGMGRTVEFEOW9kM2ZTNVFF?=
 =?utf-8?B?WHZ2b1FMaWxNeUg2SUw3OVJad0VYZG5tRUV4ZTU2MktCOG9GWXpGa3NRZjhq?=
 =?utf-8?Q?/sZnd7GF5Szsz4Shb9VUGSc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10644e8c-49dd-4264-550b-08dbb849c4fc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:18:38.1260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/tY0oA42nqTTZmVcho0uPg6V/r9mOoZHZ7pu9TshFvbTMyHrrR7CCzm38OQ4qRa76UGWBHw81aRgSIYbc5s4nERFGh4NcR8yupiuIKIc8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9439
Received-SPF: pass client-ip=2a01:111:f400:7e1b::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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



On 9/18/23 15:14, Denis V. Lunev wrote:
> On 9/18/23 15:09, Alexander Ivanov wrote:
>>
>>
>> On 9/15/23 20:41, Denis V. Lunev wrote:
>>> The access to the bitmap is not optimized completely.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> ---
>>>   block/parallels.c | 51 
>>> ++++++++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 39 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/parallels.c b/block/parallels.c
>>> index a6d2f05863..2efa578e21 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>> @@ -253,7 +253,7 @@ allocate_clusters(BlockDriverState *bs, int64_t 
>>> sector_num,
>>>   {
>>>       int ret = 0;
>>>       BDRVParallelsState *s = bs->opaque;
>>> -    int64_t pos, space, idx, to_allocate, i, len;
>>> +    int64_t i, pos, idx, to_allocate, first_free, host_off;
>>>         pos = block_status(s, sector_num, nb_sectors, pnum);
>>>       if (pos > 0) {
>>> @@ -276,15 +276,13 @@ allocate_clusters(BlockDriverState *bs, 
>>> int64_t sector_num,
>>>        */
>>>       assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
>>>   -    space = to_allocate * s->tracks;
>>> -    len = bdrv_co_getlength(bs->file->bs);
>>> -    if (len < 0) {
>>> -        return len;
>>> -    }
>>> -    if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
>>> +    first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>>> +    if (first_free == s->used_bmap_size) {
>>>           uint32_t new_usedsize;
>>> +        int64_t space = to_allocate * s->tracks + s->prealloc_size;
>>> +
>>> +        host_off = s->data_end * BDRV_SECTOR_SIZE;
>>>   -        space += s->prealloc_size;
>>>           /*
>>>            * We require the expanded size to read back as zero. If the
>>>            * user permitted truncation, we try that; but if it 
>>> fails, we
>>> @@ -313,6 +311,32 @@ allocate_clusters(BlockDriverState *bs, int64_t 
>>> sector_num,
>>>           s->used_bmap = bitmap_zero_extend(s->used_bmap, 
>>> s->used_bmap_size,
>>>                                             new_usedsize);
>>>           s->used_bmap_size = new_usedsize;
>>> +    } else {
>>> +        int64_t next_used;
>>> +        next_used = find_next_bit(s->used_bmap, s->used_bmap_size, 
>>> first_free);
>>> +
>>> +        /* Not enough continuous clusters in the middle, adjust the 
>>> size */
>>> +        if (next_used - first_free < to_allocate) {
>>> +            to_allocate = next_used - first_free;
>>> +            *pnum = (idx + to_allocate) * s->tracks - sector_num;
>> It looks, we can write this simplier:
>>     *pnum = to_allocate * s->tracks;
>> because idx and sector_num aren't changed from idx calculation:
>>     idx = sector_num / s->tracks;
>
> absolutely NO! sector_num can be unaligned. Here we get to the
> situation when the end of the operation is aligned to cluster
> and is calculated above.
>
> Den

OK, now I got the idea.

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>


