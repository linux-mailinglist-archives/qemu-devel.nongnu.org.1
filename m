Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40F7D4DCE
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEhn-0005GE-Un; Tue, 24 Oct 2023 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qvEhl-0005Ff-A7; Tue, 24 Oct 2023 06:32:09 -0400
Received: from mail-he1eur01on071c.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::71c]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qvEhf-00058E-CL; Tue, 24 Oct 2023 06:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URMif13RAPqkXNv6diZ4cOe0zDEsRVTOqvdKt6yNhs17WRZkotlS2W1DUYSAoKGBhZ/uumoVUSr5wScsPI+jFTJkYECqTLbgrPnk2wh/KslyJUcCfzlXWib33Jd11Ze2eoy8xSxBMO/XZCcx14CD7IqQii31EU7j0z+iKYrA1q49H0WrG7Rd6QRrVALkv8DnoF2RsAKzSzJVWtd12Yf8NgOttZTLwv7L/HYUh9zb5JWxviKWFOBX0p5ODg8+VDOCLyXFUlLrLF2EbP0u4ShyzI8tnp19MbrQAszbCwZIJd5XJi82six2oBoGCo4Aam7zqsYSEyybsoyn9YNF7MkiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZPhEy0dlpUCLgIvoZ2kWypHIXtH4m0sU92bJzm6ehk=;
 b=IA5APVTjg+zehpD5VN1GnAnJPnfJkh8fKyrrDkEY/yXf2R0FHiCit4+irG62fKkXhzCP+iBKcLnbBh4156aT/0lbEm5L8UFCECaYN4P5Uvnini0yxR1LoTj7OkF46PIrObP/0IcP+kU8pt7l5yqivictJ3ZVD73j4OL9UUQMApijVXmX6AkIibtQaKSerB7STtnS6K6SL0p3hV7bn7stN2Bca2RwGW3XGTjErhbJ+K5tOIK/fX/rdbcyPkOhjKMpSCnMBzzRsB0DfYsyhwUvmqzlrKSER5vJjISQ7FOn7b3gX0wIm51Nzs2c7qHV2tL92rfKMtRgp8gzQoh7BkTuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZPhEy0dlpUCLgIvoZ2kWypHIXtH4m0sU92bJzm6ehk=;
 b=uNypIVAI04rSokLWGE2SJnTkjv5bmQAGbnEx31NA0crOfc78I1XfVDfS9gBxuoLMV0TgkQCofhU0kvW6X+0DZ7s0652VwzqrAlw8j8dJ5abxAlq6cjVrJ6hsbRmXERSrCnNpKLKsPFlog0LpSVFOPHTF+eVQpSPmV8a6BKQH/nhMkx1nh+8Qf/sH/hl/4aJ64TwHW/exfZcgmdBt7FJ1qfHjTP/3I8MaNyzdj1WpVjw93juZ/V2BMdpa6otFnCDu9y1yxah2D2CWhgvSeqFYzXIekLqo0J2k2DRfT/VnTIMqkdURZ2vmiFL86r38xaEP/BNCCEWxabtznlKEKUESGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAVPR08MB9883.eurprd08.prod.outlook.com
 (2603:10a6:102:327::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 10:31:26 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Tue, 24 Oct 2023
 10:31:26 +0000
Message-ID: <27524e3b-ef3b-4187-a834-7633b4aa4289@virtuozzo.com>
Date: Tue, 24 Oct 2023 12:31:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] parallels: Make mark_used() and mark_unused()
 global functions
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-10-alexander.ivanov@virtuozzo.com>
 <CAL77WPCgQNFTiGqJ=dJNNa1qYGYZOtp2LoM7CtKj50_=UvKKQg@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPCgQNFTiGqJ=dJNNa1qYGYZOtp2LoM7CtKj50_=UvKKQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAVPR08MB9883:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a05a2-0ddd-4068-00e1-08dbd47c609a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMs6xpQjKq349OHxw/D36h86RtPoZpe1DE+U+shboAi7H80IO6qxLw08MQBH+cMcxySVS947cL1qULAZD/0ppY6eJXrx/P8X9b6wejNpqHXNNFAZiIqrqSZVHnSNYBMk+tZ2aWQGj+RwPVEJnYzezXRKFdKxroYUA0Y+3yITm1lhf53G7/z3rk6qcZflPc59UNdypprvxdeV0pX+2cICHgysYZSpgiUNPrmVcDfgmhnu5U0gEU50C1Y6m5RFwlDT6YEgT8nVIlFcAWBXSed8EHsqyAMjpDmrC2oRNcuhz7Dg4jYuASnjWDyskLHjBZLQ8Xrg59dMdZHuA+NVYjLkMARPZgbUdjtO6zzzGQoWeQwKxwNE9gH1ioGr1heVLjZtF+LthwAxcGT8AaPbflOCSzGtmw9wt0PcD332JLMF3tIbv3Jp14+AKOb7fmHQfqjAyfihS5a9h3w0sHQvDBWfUoQBmrAqdtkuT0JCaM2rz+MzK5V12HJkE6mK6s8m5i6qT4e1gbBbEiZWMMOKb9kwvs4P6SQF6guoO+XDTcsAUYdrR0vpxHQ94DTEkr5qcv3KTXkLWO01BkYMDkl4Lh5H6UtR25TrfK7y0ZIN5IaaP+YHUAuH91JsaIgl9SaCsii5voumN/HSrlJ/3AqkkJYqww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39850400004)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(44832011)(41300700001)(38100700002)(66946007)(66556008)(6916009)(66476007)(316002)(6506007)(2616005)(478600001)(6486002)(53546011)(6512007)(83380400001)(31696002)(86362001)(5660300002)(36756003)(4326008)(8936002)(8676002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBKeGFwcVRWL2NBTFFnTGRBYm50VHRDUGJnOFZ3MHpxWXlpaTl6Y1UwOUtm?=
 =?utf-8?B?cFVPUzdteUJpYVM1aTdGOUFyanhramIwTlFPa2VsOGhZWTZyZWJkOWpvTitI?=
 =?utf-8?B?Mmk5WlUzNFIwTUJjczBtbHBzZWVJVWF6Ky9TT25PMTVBSDhBVjJNNWdLYlhk?=
 =?utf-8?B?L0VvZm9mRGZNbkxadFUzZlRnVUZBYzNjRWtvZm8yZ3F0MDc5VmhpQkVWTmxk?=
 =?utf-8?B?V2dJSHkvS2RtdGtqZnJhbGJXTjVTZlZmVlVLTytlQW5qSDFkQmZid1plZmx0?=
 =?utf-8?B?eC9UZ3ROcktoekwwUmdpUUhrNTVrMkN2Q3pHKzMwMXFiQWJtUkVjR09DNE9D?=
 =?utf-8?B?VG9halJtRDZGSUw5NHdQWmx6Q2ZJWHRWcTdxdEJpQ0VxeUQxeklPRTJhT2lX?=
 =?utf-8?B?amN4azZzMlltWlB3S3FQQkV4ZEpDOG9zZ1NmdURRWWpOeFkyR0lwZ0ZhUXpB?=
 =?utf-8?B?ZllxUFhISW80UDdQeGJ2Sm42MjB5MGoxbW10Rk5JOWVYazlvVmdMUVMvSklO?=
 =?utf-8?B?dEh6TGdHaFZicUpSNTdHZEVtRTB2YlVWakpHMXFQWnNWYTRPMlFPMmZZZm1k?=
 =?utf-8?B?T0lud1orQ1ZiNEpJamQ4TU4vNDFIQlJhSTVzWTgraFA3OWV4Nk9oU0dFVG8z?=
 =?utf-8?B?Y3Q0TDJ2eVhPbmxGY05lZ2lvRjM2UVAyQVJFanZmU3NORE1LSlNoeEowdVlS?=
 =?utf-8?B?My9Gd0xxZDAvVlJySWo2a1h3Z0p4bXM3SGlOWExYYW54UCtnSVdGLzZTbExV?=
 =?utf-8?B?TnFlckhJUU5yK2dhcmJYekpGYkdxSDJJV0Rua0djMytYWjhDSGI1WTQyNFRD?=
 =?utf-8?B?SnZKVE1jMmIzbGVYK1NRTFhkNC9DV3RQblY0RjNEOGV0bWNVUDRRdmN1Uy8v?=
 =?utf-8?B?NHRIVHNhUk04ZEVxSmFPRnorSjNMd1Y5NnRkV1hrVTQvZ21sNDh2NXhxaklO?=
 =?utf-8?B?dFBmN2hFUmpFTWxwaHhGUEFxaFJVMyt5WFBNem9ZVEFGR3Fjb0JrbmRBdXJl?=
 =?utf-8?B?SWI2TjdJU2hRTXV4UHNxY3lqdzM0QXJEU1k2V082NFRmL3ZxMm85VGRocXF6?=
 =?utf-8?B?SENOalRYU1dKZmd5L0VoNHI1WUJVdVRKQ2tHQklGVksvMTZWUm9kRGJvT1ly?=
 =?utf-8?B?ejRlb3Fza1BEblY2Mk5MZmxkdnpTcWxCU1dveDE3eTR4YUNJQ09nNW5ERm9D?=
 =?utf-8?B?SThWYkJJYnFYbkhvODRzS2VUUXdpUWJIWmpTejU0NkhlZmJwMmprREhqZEJt?=
 =?utf-8?B?UW1JSExhWkpMUXgrQ0hHUnZQc25Ka3d1aWlXT3lPcjc4UHp5UHh1bjgxNFl0?=
 =?utf-8?B?QzJiblZxcHk5UVMzL1FSa1hnZlBzRkpVWWpjOEdVUlN0WnNiclhnMFZCSUlE?=
 =?utf-8?B?UHpTcDYzK0FVcWEvMWNqUGVsR1FaZ09nblg2OTVRT0hJWW9qOHRkdzRZSmls?=
 =?utf-8?B?bzhXMStTNzQ2OTh0Z1EyNEJ3dHd0TU93dWQ1Y2tNNy92dHMvNnJVRWJWUWMv?=
 =?utf-8?B?N3h1K3NUZk1ZYjRaZEVvazlESDVFd2F1a3pMVHNMTkdvMlJIdlFkODVjMXZo?=
 =?utf-8?B?cUdGeGZLd1QxUVhnVW14NnlOVFBNK3NkL2FZSjAyNDdaVWVLY1U2UjRFV2ww?=
 =?utf-8?B?SnJBcEVXV3UrZThvZ2UxekYwUVF1MWFTVnNoWlp3eWFUdUEwcHRZYUYvdXlu?=
 =?utf-8?B?YXoyVzQyQUk4UmJYcUFHdXZzZ2lnakJESkUzbHZ6aEtKNlpQRVZ3S1J6M1Vh?=
 =?utf-8?B?NkY0YWV4NUtENVJnOWZFM2JXQ3N2MUs2V3MzRXhUQUpucXh6VlhaY2c1WGxr?=
 =?utf-8?B?NHBSWStEeWZLa3NtQWRnL2R1N3IrYjB6U1Bad05aVEpaVy8yenZycWhwQXF3?=
 =?utf-8?B?OW1IY2tpYmg0OW1PcWZCL2dQSjFZSWF0d2ZuSlphYlpqTVpDbFdtZzlZVWV1?=
 =?utf-8?B?bVhkSTV3NEQ0cTFabUhRQkdvU3ZNd1M2T1RRMEZrbFdnVThmM0Z0YU9BY1dG?=
 =?utf-8?B?Q1pCQmdwQUd6ZGxYenp6bkJMbXZjY1d3TXhqYWpQVUk5Vjd4dU8rdU5JMDlB?=
 =?utf-8?B?Ly9JM0QxaTV5OXRuV0F3WDliV0dmQWhqUm03aEtUL09jMEtxZHJuem1nSmtz?=
 =?utf-8?B?czljb2t3NmlWejRSa2FRSlRJb0ZyZjNsYUI3REJwcFMrckUwTU9RcUlXaUxV?=
 =?utf-8?Q?cPE0TVkte8weRTaqNBc8b8w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a05a2-0ddd-4068-00e1-08dbd47c609a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:31:26.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMICVqzGk8dFJylPiaQWNw34zpSJ5SP/ud+RnvmBXQ8Ecrv5rAmIkuNF1hbnI/YWBI/irjvDIfTOrv0QQH4W2u7myvUh6PM6Uiu/B166nKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9883
Received-SPF: pass client-ip=2a01:111:f400:fe1e::71c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
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



On 10/21/23 15:29, Mike Maslenkin wrote:
> On Thu, Oct 19, 2023 at 5:23 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com> wrote:
>> We will need these functions in parallels-ext.c too. Let them be global
>> functions parallels_mark_used() and parallels_mark_unused().
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 22 ++++++++++++----------
>>   block/parallels.h |  5 +++++
>>   2 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index a22ab7f2fc..2ee2b42038 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
>>       bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
>>   }
>>
>> -static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
>> -                     uint32_t bitmap_size, int64_t off, uint32_t count)
>> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>> +                        uint32_t bitmap_size, int64_t off, uint32_t count)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>>       uint32_t cluster_index = host_cluster_index(s, off);
>> @@ -195,8 +195,8 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
>>       return 0;
>>   }
>>
>> -static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
>> -                       uint32_t bitmap_size, int64_t off, uint32_t count)
>> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
>> +                          uint32_t bitmap_size, int64_t off, uint32_t count)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>>       uint32_t cluster_index = host_cluster_index(s, off);
>> @@ -249,7 +249,8 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
>>               continue;
>>           }
>>
>> -        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
>> +        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
>> +                                   host_off, 1);
>>           if (err2 < 0 && err == 0) {
>>               err = err2;
>>           }
>> @@ -326,7 +327,8 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>           }
>>       }
>>
>> -    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, *clusters);
>> +    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
>> +                              host_off, *clusters);
>>       if (ret < 0) {
>>           /* Image consistency is broken. Alarm! */
>>           return ret;
>> @@ -393,8 +395,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>>
>>           qemu_vfree(buf);
>>           if (ret < 0) {
>> -            mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> -                        host_off, to_allocate);
>> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> +                                  host_off, to_allocate);
>>               return ret;
>>           }
>>       }
>> @@ -868,7 +870,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>>               continue;
>>           }
>>
>> -        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
>> +        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
>>           assert(ret != -E2BIG);
>>           if (ret == 0) {
>>               continue;
>> @@ -928,7 +930,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>>            * considered, and the bitmap size doesn't change. This specifically
>>            * means that -E2BIG is OK.
>>            */
>> -        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
>> +        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
>>           if (ret == -EBUSY) {
>>               res->check_errors++;
>>               goto out_repair_bat;
>> diff --git a/block/parallels.h b/block/parallels.h
>> index 3e4f397502..4e7aa6b80f 100644
>> --- a/block/parallels.h
>> +++ b/block/parallels.h
>> @@ -90,6 +90,11 @@ typedef struct BDRVParallelsState {
>>       Error *migration_blocker;
>>   } BDRVParallelsState;
>>
>> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>> +                        uint32_t bitmap_size, int64_t off, uint32_t count);
>> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
>> +                          uint32_t bitmap_size, int64_t off, uint32_t count);
>> +
>>   int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>                                            int64_t *clusters);
>>
>> --
>> 2.34.1
>>
>>
> Just a note: parallels_mark_unused() could be initially declared as
> global just because after patch 3/20 there can be compilation warning:
> warning: unused function 'mark_unused' [-Wunused-function]
> :)
>
> I do not have strong opinion about how to avoid such compilation
> warning in the middle of the patch series.
> The simplest and straightforward way is to declare this function as
> static in patch 4.
Will pay attention, thanks.
>
> I do not have any other objections for the series except misplaced
> NULL assignment.
>
> Regards,
> Mike.

-- 
Best regards,
Alexander Ivanov


