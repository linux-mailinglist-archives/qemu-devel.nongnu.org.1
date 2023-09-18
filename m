Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B567A4AF1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:59:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiElX-00083s-56; Mon, 18 Sep 2023 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiElA-00077n-Hx; Mon, 18 Sep 2023 09:57:58 -0400
Received: from mail-ve1eur01on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::727]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiEl1-0001tT-3q; Mon, 18 Sep 2023 09:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6w8SIox31nBYN62555BqesnVbxvQ43Q8PbouGFoWNZv6Lu6fouRducDZdlRtdvWtafSlgZZcLunvTdwoRvZL8TXLriuUOSD47M2M+GdRW/qom7gQbzpraWcpekhPPhAzowmWDcNCpnsfO0fKGQjsMWcUEzN4JPd0itJX8qcotMxk5tgJnxL/9smciy0OsLWGgLO46yfQNrpeivaxYY0EDp3B/wMWE4MvViqiv82q2HPRsFD6wZpB281OkfRLRGRCdUoNhZ/fvMJ5lsd5BMcBjRhKVny+Jt1XL9hWXG/yRdK+WEtowcwWo1eEaYmy+3MV7WjRlXwh96NTz7cV4DUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBiDcN/D+3dko2qybvhR2/uxX7EDxSLVHi0vI8T+yds=;
 b=VCPo7Bmr0gklJINqH/cnB942GN+amSSPtaiPYb4/m25vi3xM05bZwsV4YsxnMR+XDRxnp2ePj8E7rc7rM640JlV87INtKxD3VCmT1poLaoX1hP01neUGwaRlEIldF+xt4Bua5UyzBKesKM0gcVEDh5af3qdDF1DXfjT1N/40BsyQlXUvHS1Ioz/wyiOgQXk1IvTTkcLA+1RWkUQJaTiG8dgGezKv1IsZJONVi2C+9ovztFeOYt+Jhx1HHfyvg7emyLzpPd6v/VfptMMEZ5r3Cj5hAVFAaHCapSQLNMTZt/BZaxM6f97AjhBc1f4CIxtTZ9TFcawJfbv3MVZFcdqrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBiDcN/D+3dko2qybvhR2/uxX7EDxSLVHi0vI8T+yds=;
 b=B3dDz4md16LHe8Gtj7vbvG2zFlQvqsUh92cd8VEO0S51GqXTSuvl3BVzk8Q5cRPoF5SefGKkjETSpWOjK4PuQAr/NQhtzo4EHYs+fLP1mH6CoZBUDIoENn5OeVict5LcR98GrDYhPvE8RvnebkEoDlXWcCAgVROLd3t9cJ07SC15vSUu4uyf7lNBWK/12zhPQNdDYJ6Kf13hEq4ZmuDiFOn7gFyoFzEVlDuhOsdHbKjDYfKBP18E9YnaJRb3Vt/B8IK2s5MaxSeXGfgmfoFXJlc95f7Tv1AmClN8WLcy7yVlM3cOBWpcydvCUq5vHpZy+TNo3KEO/A+sfyLuAxoqlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AM8PR08MB5651.eurprd08.prod.outlook.com (2603:10a6:20b:1c4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 13:57:39 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:57:39 +0000
Message-ID: <d32c69b7-097a-89a8-356a-8a8eba326e65@virtuozzo.com>
Date: Mon, 18 Sep 2023 15:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 18/21] parallels: naive implementation of
 parallels_co_pdiscard
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-21-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-21-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0265.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::32) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AM8PR08MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8cef4a-3f81-4cc8-4d8e-08dbb84f3872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiDUSK3FBQls9OYqMhuiIhjJWxwUPPLk2KnvEzwewnkzBVwHNMpIZ6MnEtHgKqWoZcYvSy9RahXosMZRhov2iNxVOWrvAUruWahLBURCWDKchl4R01y2kyE9I+B+01zZTYXzKL1tEdHzhpjxT6HQBcqZsEs9hQom+b0+o86Og8BLRV+AWCSClULk1HVXjlo49UbGWBnNthk6RHWuBn3HwpvYAF/or57C2yoV5d+N5OP4qMpmYhRKVRRt/oKY+NZtXdt06mpc68nZT+VQGvM0ZmVUzIkdlcOIyxYdE08FKDTn0Gw8qDqSUQakJruTZH/6g/WamnNUXP6LQRRq0Fq80n09g8z9iy7+sbRyH8W+sO/aDPOQSBtIX4Ecrf9JvoMtGLaDxEdHwJppXLWQh3oYd6YlzvBzgVBLR26JQ/OyCkG0HxQJmQ1ctRbQ2exWlnkG0WfhqCivyL3qrp1F84Tva0AnCPwU8Yynsk01sPntydSkbxxVUzFl9P5EE0SO8fOLu0i1ULoP71qa6jXZAm3W4p4w38VAItZaone4ooUYxY5iZHYzUyNDBk0L1fe64nGHTDw2bRL2vfC0NyEggQVhxRggXRwmhG6MyeU55FenIokHmXnYJmIXjszzuCRvXuOwtd0TQxUjs82jxyFgO2gwkx6AMw/DooFNtReQjqT2AUOD0VwKSEn0heSMcbhu85c7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39850400004)(136003)(366004)(1800799009)(186009)(451199024)(6512007)(53546011)(52116002)(6486002)(6506007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(38350700002)(26005)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(44832011)(8676002)(4326008)(8936002)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVPSzVhL2pkN0RReG1SWFJMbmxIR0Z3empQNERFUmxzRk9ZMVBNMFlUeDB1?=
 =?utf-8?B?N0YvUW9tVjJldHJnTGFHaVNUL1poN3JOZ2FIT1ROTzZ3aVNkMHZUVDA2TXp3?=
 =?utf-8?B?elZOY3RpOGt4NFBrb2xiMGZXbE5SV2JWcmduS0U4VEZJRGZmTEx4TFR6NU56?=
 =?utf-8?B?ejNLbnRFckNubWdkOHJDVis4aVVlVWErb2JNZUNLZmR1WmxKaEVJdGVxU2t2?=
 =?utf-8?B?MkdxcHBLMUpFZ1dSZnIrZXhJeWdFMGFVMHdhOVBucmp6S3M5dzJWYVl4VXlz?=
 =?utf-8?B?SU0xOGVESloxVlBtV3kvRk5ET3B2Y3BqSHB1d096MUx4K1JMMkRqZFB0VXhy?=
 =?utf-8?B?TG5SWUFDZE9rOEVxRVB6MUhaRUk2RHlOdXBwQTBCN29rNDlmZ3h1bldxU2VB?=
 =?utf-8?B?VWdHY28vakRocGNpUXU1dzFxdWNWUkc2bGJBV05aNTh1dHR1K3dqTWxST0dF?=
 =?utf-8?B?N2svRmtJTVNnN201RHVINzIxQVVQVzhvckZlcHRic2REall4RHQ0Nzc0K0s0?=
 =?utf-8?B?MjY3STZ1TWNOWEFFbkxJRjlMaWUwTVFOSUJscHg3UElWZTA2ZFVTQ0NPZWlR?=
 =?utf-8?B?UjJVTkorVG82cWtoNmxhRFJBWkZMdklQT3Nwa1Zuck5IamhkUzVISHdKZDd1?=
 =?utf-8?B?eCtUZ2ZudGFUT3Q2dldrYkx5V1lUU1lDNEVYalZLZ0JTdSt1S1N3VDBSMHhO?=
 =?utf-8?B?SE5iMThiRUgrSnBHdlpTZ0Yzb1NwcndpZFhSd1l0OE5sZmZaYng4NmNzWkQw?=
 =?utf-8?B?aWNRMWd6MmxsRWdrZmxQaVlCYTRJL1hKNUYyaU1UNmh1bE5GSFBvY05wYkdS?=
 =?utf-8?B?UFA0MzZ1UkxJOFZwWU5FTGlxbUxhQjlmOElpNWFMVWdDa0NhS1czS29PZktM?=
 =?utf-8?B?WmRHZyt1aTBCOGcxa2FNdnZ1NDE2clREZEVPc3dCb0xnTy91cCtSMnFOcktG?=
 =?utf-8?B?R3EwYmVaTWRlU0lkT0ZqNDdydStBZ2N2Vkh5SzVCeFhkZTdCSzNEVUt4cllR?=
 =?utf-8?B?Qk5OMzFVbEM2N0FGQ0NXdmJya1puZzV2T01FVUlrSzRucnZGRTdtMWkwTkZR?=
 =?utf-8?B?THVuOFlqaS9IYUFyL3k4U1FBNXo3MkREOGdqQ05sQnU3WGU0Ri93RXpPWnBa?=
 =?utf-8?B?MnRQcU01cENMS3hrZ2J6aHAwYnYyZi9KcEIxRXpMQzZXRlNveDJFTnhwdnJj?=
 =?utf-8?B?ZWxwOVZkZ2dqaW9rS2hNWC9jUTFFQ244bjBDeWZtRys1RmFBbVZ3S0R5dlkr?=
 =?utf-8?B?Q2ZZa29ETlE0WmEwVlBiYU5IZjl3cmRjdkxhZEdNYjVCbzNBN0g1YUJIVE5m?=
 =?utf-8?B?VFgrWTFzUkhxdGx5Qi9vZ2NLYk9lOUdReTBBU3ppQjJWSzY0K1FZdTBYellM?=
 =?utf-8?B?QVZYem9lcFIrWllWUE0vQjlRWVh2S01vZnBja3lSa3p2L3VaUUU4anUyZkdi?=
 =?utf-8?B?NHpHUU5TL1c2REhRZFlHUkd4a0FRdTNnWVRkb3FGeFFxRnI4TEpzOWxjUDhL?=
 =?utf-8?B?SytUek5HZERLTURRdHRnTTQvM0ZRZDZjbVd3b2g4TTA5RkZLQWs4MTRXSXli?=
 =?utf-8?B?YWhwZkoreEZ1dkJDK3VFUWQxcWVFekNBelpXbVljZU1iUFVXRW1EMVNkcytK?=
 =?utf-8?B?ZU0wNHVmSytVaXNMSzRZT1ZVeUNtclZXZmFQTW5qVW9OMUtiSngzc1A2TEsw?=
 =?utf-8?B?Wkt5V1RuMndFREoxK2xuYVZDMzdlRlJ1MlNTM0hTVUkyTytFdGxvTUZHekFq?=
 =?utf-8?B?bUFCaTZQNlh0bEx0SERaR0NpTEVCemZ5cVd1R2FJdVNuVE1xOWJ6OVlBRjhn?=
 =?utf-8?B?Y1hMMEg3eEUwSXdHWHhZWGJ0ODdkNU4wbTR0aW5CanNOZFplbVExM2lRZjVO?=
 =?utf-8?B?bjdBTWl1dXJ2c3F3NklVeGQwdUJPQjZqbGU2OFh1SWN2U1RHU2ppTXY4S05a?=
 =?utf-8?B?dVIrbzFKOVRkM1lHMmZac1NFSFRxSEdKVWxrVmYxbUc0VXZKeENjMzVBSVVj?=
 =?utf-8?B?eUhnbFJpQnU3NmRiSkwwdCs2ZC9ITjFSZW4wVUtQdnh0b09HekhLUUU3MHBr?=
 =?utf-8?B?SnJIUUJnZFROOFRNVFpQd0lmM1BLcENMdTVyOHlVb3UyU0ZKK0NTTjlNKzBu?=
 =?utf-8?B?dXFveHlZSElNdUh4cUQ0T3JrZEdiZ3lhbU1JNzV5aFJvUUdJQlJYb0c2bWVr?=
 =?utf-8?Q?M8oqKja8yC7yCicK0vqIskA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8cef4a-3f81-4cc8-4d8e-08dbb84f3872
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:57:39.3077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXE+cVcNBamU8k6U+Py1adoC1Tu2dHJvHADnJNgP+H6QE37v74t+a4MD6Zubeuf6cHOKx8BsVawKAlqZCU6F3ANObyc8jxfRH2Xc8aneZGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5651
Received-SPF: pass client-ip=2a01:111:f400:fe1f::727;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> * Discarding with backing stores is not supported by the format.
> * There is no buffering/queueing of the discard operation.
> * Only operations aligned to the cluster are supported.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 76aedfd7c4..83cb8d6722 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -537,6 +537,52 @@ parallels_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
>       return ret;
>   }
>   
> +
> +static int coroutine_fn GRAPH_RDLOCK_PTR
> +parallels_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
> +{
> +    int ret = 0;
> +    uint32_t cluster, count;
> +    BDRVParallelsState *s = bs->opaque;
> +
> +    /*
> +     * The image does not support ZERO mark inside the BAT, which means that
> +     * stale data could be exposed from the backing file.
> +     */
> +    if (bs->backing) {
> +        return -ENOTSUP;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(offset, s->cluster_size)) {
> +        return -ENOTSUP;
> +    } else if (!QEMU_IS_ALIGNED(bytes, s->cluster_size)) {
> +        return -ENOTSUP;
> +    }
> +
> +    cluster = offset / s->cluster_size;
> +    count = bytes / s->cluster_size;
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    for (; count > 0; cluster++, count--) {
> +        int64_t host_off = bat2sect(s, cluster) << BDRV_SECTOR_BITS;
> +        if (host_off == 0) {
> +            continue;
> +        }
> +
> +        ret = bdrv_co_pdiscard(bs->file, cluster * s->cluster_size,
> +                               s->cluster_size);
It seems, bdrv_co_pdiscard() should be called with a host offset, but 
there is a guest one.
> +        if (ret < 0) {
> +            goto done;
> +        }
> +
> +        parallels_set_bat_entry(s, cluster, 0);
> +        bitmap_clear(s->used_bmap, host_cluster_index(s, host_off), 1);
> +    }
> +done:
> +    qemu_co_mutex_unlock(&s->lock);
> +    return ret;
> +}
> +
>   static void parallels_check_unclean(BlockDriverState *bs,
>                                       BdrvCheckResult *res,
>                                       BdrvCheckMode fix)
> @@ -1409,6 +1455,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_co_create             = parallels_co_create,
>       .bdrv_co_create_opts        = parallels_co_create_opts,
>       .bdrv_co_check              = parallels_co_check,
> +    .bdrv_co_pdiscard           = parallels_co_pdiscard,
>   };
>   
>   static void bdrv_parallels_init(void)

-- 
Best regards,
Alexander Ivanov


