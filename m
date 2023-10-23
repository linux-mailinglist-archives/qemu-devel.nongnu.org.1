Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84607D2F6D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurma-0001MP-5r; Mon, 23 Oct 2023 06:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qurmU-0001Lz-13; Mon, 23 Oct 2023 06:03:31 -0400
Received: from mail-vi1eur04on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::700]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qurmN-0002hQ-Pq; Mon, 23 Oct 2023 06:03:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYDwQgsIUxYRqd/zvKYdkLYwEVlFeunwG6asCrA9ZVqgso0QdgrZojRPVDxLifHh5qO69pKz7/VMpDfR/Wk4uW7wP/UJhKn12ryjFxykiLoa98FOiDb80IUAq40K9F1E4Owoaf8Ijn2xQhEmr1UQQOoec2ClFuEupOv9wDjMtbDa/Fi/gE8gLc0Ak4zdQWEqCipjnnc+cCJBbgk35ULTYP/2q1GT5CXBTNplUD6JMTgEiPCnpG4q26ESz75Wj3tuxNh9sfSdOI1nthBoN0goRDgbbvIz16NMC3wluvqb9wqWwHn+QH3l+VumoIjbIlMJekL4vZmbFW3B3V4DfoE5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mzSRWDHTN0+q/yIsi53cj1PiBR0S+V0ZLCP7cQwJ/I=;
 b=ZcAfspFmEfIInKLLNaKjbynm282nm3UWFHbPG2z/GHQWGx+VTD0p6bNxjyuHj0PR74O/8HJq0qwhTAUbXbB1azL48NHURjk0mIiA8597HPMo/eTt7DDEXECVsETlilTfpOUH2DkTC8DTCxNcteTOxxdq3CLr55tQZgIaISARCEyLbkLqoQ10Q5vsQBiJxlYpjXitjktxFMZI7Ato5RPZ+kdrKURQaWfQ/7x3xetbanDhezTzdsl1QUjy1WqKiC/2HvXYMUtKrKmxC8Cc1x2odAL0U5/RrSEUs3t0ZNrfWqZ5eXxSN+dBJud7CIzaZu+wPGEAzWCUUzj/ek0cEtX0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mzSRWDHTN0+q/yIsi53cj1PiBR0S+V0ZLCP7cQwJ/I=;
 b=N5dThZhqZFaPEg6y6y9o9V9hISssLRXAxT2p0CDjJOm6tO+9nj9dw5S5TAfXhaVy2Db9D5zb0T0+hddFKj87CptKdUEDW1R5JC+H8dgRtCrksyc7HT8VmMpUdnxT+NjDt1BwCOGingEBoAryKsrNT4a2e4H+VAohxlIhENATKUbeDEi4pwSANcqNObICzWiN/joBrBhpK9wxdXBJ4NMD/RGizwGva0EG+AKoIFp7teVgp3zO7szpnriy7gURA6GbrDgS3RVbh51Sgh73qysZKvxMluyqHHcs2HD7Gah80Y/IolhZqKFZ4gW4vnsBE9qT9H+mm7StTSnhwpZbGmxCLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB9906.eurprd08.prod.outlook.com
 (2603:10a6:20b:564::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 10:03:17 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Mon, 23 Oct 2023
 10:03:17 +0000
Message-ID: <581ac2d7-2807-443b-b1e6-58d163e0e2b4@virtuozzo.com>
Date: Mon, 23 Oct 2023 12:03:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] parallels: Add dirty bitmaps saving
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-11-alexander.ivanov@virtuozzo.com>
 <CAL77WPA8u84+-QoNHmwMOnaG-g=0natYd-R_Bo_g-suk_ZBupg@mail.gmail.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPA8u84+-QoNHmwMOnaG-g=0natYd-R_Bo_g-suk_ZBupg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0221.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::42) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 215ad292-bcb9-45e8-1dc7-08dbd3af4752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2db1kFhH3aDLoO9oaLSZqCmpGFwiDgHHH5m099mGfhGmMfRzav8gKWViegx2p2AwYr5FYB3tN8165rf6kA6cCK7pckeh4F3MAY3+YVpd4KPQ8iglVkibZfHHlgNGwdKl3b7qWMJZWNHSTiyTIK6I+iuHy8k0ZijSDc9sTAa009pJ/hdpAMMKjy3LSlGgX4l3QE0MjGUJbF3E1QephW9s+pCsleQxIzi9wfBsyTRX0FIj2sk9xTLTfmjvCXhHe3OyEFrGVoK0QuPoamzrW5JzrOYCvtP/CEXxH4cw6roBvc8lW8E5fO+O5g6Q69si5W4pjsFAdtuTdxy2hUwVYFeEAy9nWMln1nWmWaQXjOHTLxRQW8Q8oj8n5Ony93iU9yCN/qRWyE4bBeVHBj80aaBDPYzzcZA6p2Rt9MYXF6/gpM4IIndZEcwQt7KlCR5G2TckU0Lcl0JuoXp65YQeyy+gmNzaYfRhiZBL4bDL3t6Dmf86cuDfoVCPMrBOyvERBbRqu84AGXR5/7kHte4c7fJey3tkMLnYQ1LbVoDLc2mLZOPL0JAShfvaktJueh8edQdXPONoKuHP/MJMSor15seVhPcQ5gc9xtq0za443IFvqOolFs/5jU9DYD7z5N7JZyS+OtPsdGQNceiYikjj9HIwyHXwyFgkvC9jU27SsgLCMRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(31686004)(38100700002)(2906002)(41300700001)(44832011)(86362001)(31696002)(5660300002)(36756003)(8676002)(8936002)(4326008)(2616005)(478600001)(6506007)(66476007)(316002)(6666004)(66556008)(66946007)(6916009)(83380400001)(6486002)(6512007)(53546011)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkYra0ZVRXBBRStRZ1Zvd2ZsL0ZKNFlDQ2ZwcVVkdUw0OHBsZE9yZXU3cVdH?=
 =?utf-8?B?LzVTTlJtbHI0V00vR3VFbFA0akM2S0FseVhrOTVTV0FxZEM1YXFnTlpqemQx?=
 =?utf-8?B?RDdGTnVOUnVxWi9Fd1dpNHo2YjZNdTFqSWN4cDVZNE8vekp0amxkdXJCaHNI?=
 =?utf-8?B?aStBMDBsaWh3Y2xZTkdCUnpCU1hYTkozYXY3bW1pL0RnY29NVllrRENGWXpn?=
 =?utf-8?B?dUFpVmlDcWpKSVhEekFBRng5bGd1N2piazMxcG1nOHVhSlY0WFh1eXhBNDVJ?=
 =?utf-8?B?NU43ZFJzRlZYT09EQUJLck1WMHUvenpuN2NQUlIwUkVUZWhFU2VKbWloVG16?=
 =?utf-8?B?OWxSdjVrUlVzdWp1T1NVOTdyUjB6TnhIVkN5bFlsVSs5Rk8rVE5CQ3N4cE5l?=
 =?utf-8?B?MXdPVEJFV2lLbmEvK3RjdGt0UG1BcWJzbmxkNHZhQWh5d2l0cGxLRmY4Y1pJ?=
 =?utf-8?B?VmRxcms0NWYybXdzeXRkT2s0MTBSVlNZNS9jVzJPMStoRlZVcDlxcUF3V0VV?=
 =?utf-8?B?NlpZZnBRVDJwM2FrUDFWWHc0THgzV2dDQnQrVFM5czMyajZXb2FQeEh0d2h6?=
 =?utf-8?B?R0N3TnREUDM4NUx1SzJpMXQ0Z1J5b2JBTlo2QlZrTEhxRmd1UXNoL0ROREg2?=
 =?utf-8?B?ankvclpqWXVIZ0Z2ejErcjE0dW56aGRWZkJmaWg2VzZndkVld0Z1UHc5NURk?=
 =?utf-8?B?VnJJUjdCWkRpaUdCWFdEZGtOc25oemhXQmlhUDN2R21WcmJJOFdseWlpZVJO?=
 =?utf-8?B?d05lRUg1VnRLaC9lQTVOT2wzaVJtUGRFVkkvbjBCM3hPUkJOSUQrdUNzUXVK?=
 =?utf-8?B?OGdzNHNRdjJVS3VXclJrRWxiYzlIZUhKTWJnN0Qyd3V2V01WODFHVVRzZ1A1?=
 =?utf-8?B?STQvOC9OUmgvWDE4NHJjTTVOOUNCV3Z4WFNZY2VtUGJYOG9pdlN1dTVMWEFv?=
 =?utf-8?B?WlJoVDlPMDZYd1ZXUGZjejRXVk5XMHRTbGw1eWxwc2c4Sktza2xYNzBrTjZr?=
 =?utf-8?B?MGRsYlNZYUZOa2FtT1JOb2FwM1p3ZzVQOG0ya0UwRlpVa1hUNUJzVjZTaHl4?=
 =?utf-8?B?bkNPdHQvaktOMzVmT3g4MXl1bnA1bFFVSnJkY3pqdHNHaFpiYWpVR005L0NP?=
 =?utf-8?B?TWxwSUtJbkltMk1XS1c4b3U2MG5jcWFBOHoxK3Ezb2o3azljeGNCSFBCaFI1?=
 =?utf-8?B?VDkrT3ZJdE1Mc2lHQ3pMWENmYndpOHNIb3VDV2h6REpQb21DVWJ0M0dPaFBv?=
 =?utf-8?B?MUo2QlFWWWU0T1RScXJBVk1aVW1WWGRZOUN0TzNjdUgyTExmWEw2d3hIVkZH?=
 =?utf-8?B?Z3JRbFBpbHlaWnNwa2FUc1hoK3RMRWZhWTlKMlEwNm44TjdHbTVMT21keWtM?=
 =?utf-8?B?RUdwU2NHV0E0bVpQY2czRDQ0UXNoeFFaMGhEcWRTczZnckIxeEdNczcxbG9w?=
 =?utf-8?B?R05uOEpiRVVTT1RySGo2T3FqazBvM2JjVHg4aUpyakR6MTFqUkxta0dPRGp4?=
 =?utf-8?B?VFg3Z0tFYkJWTXNmMFlSWHRidkVhdW5YS082YnB5UmlkdFpCbmlQMHhtV3BU?=
 =?utf-8?B?SHNjUUUzM2RrZ3YrWkRMb0ZZbEtXR3B4YUVOU2x5ckVOdkR6V1FWOTdwa2gz?=
 =?utf-8?B?aWIxbHFocWdsL0hqcGhUKzZ6bENxdDFQRTJRVzFwa0FlT2lGYTNLSW1IcXpj?=
 =?utf-8?B?RkJUeXV2SXhPNVpZbWtBNENSR1V4eDJhMEhLWGp5VkVxQmlsNnNrcTFBQWVO?=
 =?utf-8?B?TFlzZ1RUWGsrbkxCMW5YMnFVVDNnM2pOaitPNysrVG9wQXRFcWpaTjVJeFRw?=
 =?utf-8?B?RGtjenI3WDhwR2tIMEkzQ0ZWZUdNTmllRW8yamdpaVpPV2w2akZlUEU3UE5O?=
 =?utf-8?B?d2ZLTU04T3JoR1U1eWFYVnNGVkgwaFE3cENaTUNzTllPTlBPNFFiZDJGVGEv?=
 =?utf-8?B?blFtY1hZcmpZWG5KVktKWmp4QVdqTER4d09lWlBsQ2ZrNkxSSmgvUnpkZ3Zz?=
 =?utf-8?B?Q3VCYVlpanhYQ3hsR0RJRzZuaGppM2k2R1RDNXFBZkJDejJKVGEyam5iWFY4?=
 =?utf-8?B?ZUVYWWF3T1VmSXB4RUZGSU54dk1jbWhZc3Zsd2R5allzSXkxaVNXclNtL1cz?=
 =?utf-8?B?a0Z4WW5VYkdHL0NQNlpSYUJlOW4yTE1uZks5T0tHNC9acmdLNy9FcTVPMHdx?=
 =?utf-8?Q?BFWaKid+eJNu9IB0O8Yody4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215ad292-bcb9-45e8-1dc7-08dbd3af4752
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 10:03:17.4038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmNQ3jf0bhaV6QAV1zfZHvK+LzTSL4ALZ1t/eQO4kuw9mKOeQ/WeJGYhb8QlDfwxnjkt7ymwrCOyri1wS+PdSxUUE8Od09kyLfyoXv+GoCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9906
Received-SPF: pass client-ip=2a01:111:f400:fe0e::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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



On 10/21/23 12:40, Mike Maslenkin wrote:
> On Thu, Oct 19, 2023 at 4:05 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com> wrote:
>> Now dirty bitmaps can be loaded but there is no their saving. Add code for
>> dirty bitmap storage.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels-ext.c | 167 ++++++++++++++++++++++++++++++++++++++++++
>>   block/parallels.c     |  16 +++-
>>   block/parallels.h     |   5 ++
>>   3 files changed, 186 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>> index 8a109f005a..0a632a2331 100644
>> --- a/block/parallels-ext.c
>> +++ b/block/parallels-ext.c
>> @@ -24,6 +24,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "qapi/error.h"
>>   #include "block/block-io.h"
>>   #include "block/block_int.h"
>> @@ -301,3 +302,169 @@ out:
>>
>>       return ret;
>>   }
>> +
>> +static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>> +                                  uint8_t **buf, int *buf_size)
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    ParallelsFeatureHeader *fh;
>> +    ParallelsDirtyBitmapFeature *bh;
>> +    uint64_t *l1_table, l1_size, granularity, limit;
>> +    int64_t bm_size, ser_size, offset, buf_used;
>> +    int64_t alloc_size = 1;
>> +    const char *name;
>> +    uint8_t *bm_buf;
>> +    QemuUUID uuid;
>> +    int ret = 0;
>> +
>> +    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
>> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
>> +        return;
>> +    }
>> +
>> +    bm_size = bdrv_dirty_bitmap_size(bitmap);
>> +    granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> +    limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
>> +    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
>> +    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
>> +
>> +    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
>> +    /* Check if there is enough space for the final section */
>> +    if (*buf_size - buf_used < sizeof(*fh)) {
>> +        return;
>> +    }
>> +
>> +    name = bdrv_dirty_bitmap_name(bitmap);
>> +    ret = qemu_uuid_parse(name, &uuid);
>> +    if (ret < 0) {
>> +        error_report("Can't save dirty bitmap: ID parsing error: '%s'", name);
>> +        return;
>> +    }
>> +
>> +    fh = (ParallelsFeatureHeader *)*buf;
>> +    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
>> +    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
>> +
>> +    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
>> +    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
>> +
>> +    bh->l1_size = cpu_to_le32(l1_size);
>> +    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
>> +    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
>> +    memcpy(bh->id, &uuid, sizeof(uuid));
>> +
>> +    bm_buf = qemu_blockalign(bs, s->cluster_size);
>> +
>> +    offset = 0;
>> +    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
>> +        uint64_t idx = offset / limit;
>> +        int64_t cluster_off, end, write_size;
>> +
>> +        offset = QEMU_ALIGN_DOWN(offset, limit);
>> +        end = MIN(bm_size, offset + limit);
>> +        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
>> +                                                          end - offset);
>> +        assert(write_size <= s->cluster_size);
>> +
>> +        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
>> +        if (write_size < s->cluster_size) {
>> +            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
>> +        }
>> +
>> +        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
>> +        if (cluster_off <= 0) {
>> +            goto end;
>> +        }
>> +
>> +        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
>> +        if (ret < 0) {
>> +            memset(&fh->magic, 0, sizeof(fh->magic));
>> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> +                                  cluster_off, 1);
>> +            goto end;
>> +        }
>> +
>> +        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
>> +        offset = end;
>> +    }
>> +
>> +    *buf_size -= buf_used;
>> +    *buf += buf_used;
>> +
>> +end:
>> +    qemu_vfree(bm_buf);
>> +}
>> +
>> +void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>> +                                              Error **errp)
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    BdrvDirtyBitmap *bitmap;
>> +    ParallelsFormatExtensionHeader *eh;
>> +    int remaining = s->cluster_size;
>> +    uint8_t *buf, *pos;
>> +    int64_t header_off, alloc_size = 1;
>> +    g_autofree uint8_t *hash = NULL;
>> +    size_t hash_len = 0;
>> +    int ret;
>> +
>> +    s->header->ext_off = 0;
>> +
>> +    if (!bdrv_has_named_bitmaps(bs)) {
>> +        return;
>> +    }
>> +
>> +    buf = qemu_blockalign0(bs, s->cluster_size);
>> +
>> +    eh = (ParallelsFormatExtensionHeader *)buf;
>> +    pos = buf + sizeof(*eh);
>> +
>> +    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
>> +
>> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>> +        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
>> +    }
>> +
>> +    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
>> +    if (header_off < 0) {
>> +        error_report("Can't save dirty bitmap: cluster allocation error");
>> +        ret = header_off;
>> +        goto end;
>> +    }
>> +
>> +    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
>> +                             (const char *)(buf + sizeof(*eh)),
>> +                             s->cluster_size - sizeof(*eh),
>> +                             &hash, &hash_len, errp);
>> +    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
>> +        error_report("Can't save dirty bitmap: hash error");
>> +        ret = -EINVAL;
>> +        goto end;
>> +    }
>> +    memcpy(eh->check_sum, hash, hash_len);
>> +
>> +    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
>> +    if (ret < 0) {
>> +        error_report("Can't save dirty bitmap: IO error");
>> +        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> +                              header_off, 1);
>> +        goto end;
>> +    }
>> +
>> +    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
>> +end:
>> +    qemu_vfree(buf);
>> +}
>> +
>> +bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>> +                                                          const char *name,
>> +                                                          uint32_t granularity,
>> +                                                          Error **errp)
>> +{
>> +    if (bdrv_find_dirty_bitmap(bs, name)) {
>> +        error_setg(errp, "Bitmap already exists: %s", name);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 2ee2b42038..bb1e765ec8 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1470,14 +1470,25 @@ fail:
>>   static int parallels_inactivate(BlockDriverState *bs)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>> +    Error *err = NULL;
>>       int ret;
>>
>> +    parallels_store_persistent_dirty_bitmaps(bs, &err);
>> +    if (err != NULL) {
>> +        error_reportf_err(err, "Lost persistent bitmaps during "
>> +                          "inactivation of node '%s': ",
>> +                          bdrv_get_device_or_node_name(bs));
>> +    }
>> +
>>       s->header->inuse = 0;
>>       parallels_update_header(bs);
>>
> Recently bdrv_get_device_or_node_name() calls were guarded by
> bdrv_graph_rd{,un}lock_main_loop.
> There are no annotations for parallels_close() or
> parallels_inactivate(), so may be it should be done in the same way?

Thank you, will take a look.

-- 
Best regards,
Alexander Ivanov


