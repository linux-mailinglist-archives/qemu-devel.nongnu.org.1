Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0B7A490C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCud-00034F-Jt; Mon, 18 Sep 2023 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCuV-00033G-Ry; Mon, 18 Sep 2023 07:59:27 -0400
Received: from mail-am6eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::725]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCuT-0007Qk-Uf; Mon, 18 Sep 2023 07:59:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDcWT62Sy2z7gI9IYN1fM9fI6k12f3xYURfp7dywqNKy4KatiuW7lYE2hfx29KDSOQjl2tCXtSM2PaO04vfSts13yUUPGiWW9+FLGI5zqv3INamALfZEKjgtfFotTxhpKfYFlhjvvREkFkv5EnBgJTf9ouoIvtneGW3UhPrXXP4kN/zZ8TLQhPdRuZnU/1GOEPfbfXwrslZm6DyVnHi3OcoIALbqmgJHZLTeIfoby0sjT52Kh42wDcBUXnWBiHrVyEwP2OceL40rmBSq/vrig472NRHfE1m+ayh2bAZRGg6Gcu2FGZVgMfFJPHGYK4q0TvojQ8YQljS6GV1AcM4wsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGdoYDRnAcZv+x7WJxLviqlxjrMG+csjt/KSeTcZCp0=;
 b=AAd1NApRSQQkuQZ5Vi/G/pzhLvBLeIqMqOjjNFL8yGUig/2gB1HNisJq8YLJMHsKW1ygYlpypto12PH0k/6VXUnHbsy52ctYDZzeMbHz4gk7lxciFvCbCV6CeF20AfFvI4ok702gyCBHEX1vOM/LWamKVrzMu5p4LKlSqprUSJA1/pPpQCwEO23QxQRpBL08s3VISWKXpUkVAg5FMOO30cSXCFP9i02hn9YT+QPO041pEnWSOGEkiyNGNkojZVFibBfuFZtgwussuEHGSqcA38fTrA/WdmMmqMl1XMmfvFV8LZ23m32Kmik9bfgxrXwPJF5gJIpIWJaPqkWIspJyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGdoYDRnAcZv+x7WJxLviqlxjrMG+csjt/KSeTcZCp0=;
 b=ML33NxNPfJCejl8xvi5FFtawdocpDpJ+8B+YXadBjgqIotUvrMGEWav/kxPxqtGRZVdJ+fVQrf/U1mU8inlknnYERnDpVv2nc+fdbQ6yOZa+UbseRMhyy0D5n061H9UEfJxHNepMKRXKkWdGciqwYqdwEoTq6olmv8SzILPGn+lUy35OnxTO2Uvss3GJgIDEI3cKaeU4UzDXUPzgn468WNiBZczTqso114+AN7Bxk24ld012ZiBQxjdglw8g3zOtqOr6bRaGSmVvgXLLLpNaLLPe1RkHI1QVrY5Q1F8Y3PCK4cz2pZW5qQnT9euTt5bGgQSYpT1Od/9bWUg5W0Z1qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DB9PR08MB10380.eurprd08.prod.outlook.com (2603:10a6:10:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 11:59:21 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:59:21 +0000
Message-ID: <a258e15d-c760-9068-6188-41a7581c190b@virtuozzo.com>
Date: Mon, 18 Sep 2023 13:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 15/21] parallels: update used bitmap in allocate_cluster
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-18-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-18-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0180.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DB9PR08MB10380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7814f98f-4294-4e3d-ecd9-08dbb83eb1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec4EHGTLKbG18M7i0tbZwcn/Z1QFJe48mHnBtyUN72WsP75TgGYGaH6A8Pg317dO6cVc9u6yO4KuNGnRf75wnLqzB8gmF5HNoqzsL+bHWX8m8PKfrkO6iZ7jjJxsie4KYs85OIeUc44ibbv7qHsGhX23NrQNMsLLKpap8PPrZOSrfVJytq3x1TGW2gzBj0X8FElIIt1s+Et+aWG2MWZkM7rrs7d7XBsmStA2sm4NL4vDZQHo6hSbEGPGHiE6m1f3UtFmL3O7hxZozJfJjnULqVRW54JezkcSj4TrmjZgfcH7xgQlJZwu6ZTmuj04tdk6B+3mLsOS0HK1maEU+GmNcHNu/YEa65c3DYAOG5h+ZgvlU6FL3a74oo0zyXQ8wc2R2pXhq1SzW5ZQvA/LwPwz77UJLpKkz/nMiyupwbjJrhGgnXsCs5zkOI0n3UhQW+G4EZgtWy+dwpJFStS/wWZM+82qFHikXwbe45P5X2zHoPGDb9E4kmpUxnnFcRT0NDtaYjFSjp/Muh95l/drxRv0ZNhTrpf4A1ROB/lhIoyKgU/QAd09Zr5gMN0aEcwL8E5tUoFvKBeMT8hn7TnC3/bkwx6AK/teXql+DoZZK7YCREbuYvAhkHukd6UBPHVolsATp0m4dABPBsqRIlULS049LS5S7pye5jJgUKrfvvBLUHti/dFaFzjaTOxrrWBsL3pm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(1800799009)(451199024)(186009)(31686004)(36756003)(38350700002)(38100700002)(86362001)(31696002)(53546011)(52116002)(478600001)(6506007)(2906002)(5660300002)(66476007)(4326008)(8676002)(6666004)(44832011)(66556008)(66946007)(6486002)(83380400001)(6512007)(8936002)(41300700001)(316002)(2616005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFQNVFsT1FLbVFTYkpMYUFkU1NXL1UySUJuOEFRUWQwT0dkeWhYQzVIRHk1?=
 =?utf-8?B?TjFVZUJRNmk4cVpIK3Ficzh2dWZOOGdrSS9xbUFuZzNYVXEwckNFZWdkSXg4?=
 =?utf-8?B?Q1MvcmZ3YXRvZTBjR3FZTW5PcDdZVVdveWZucTNGbi8vMjl3S1gwait2T2N0?=
 =?utf-8?B?dEd2MW56TGtHbUtZKzRNSGZEc0x4NG5keUc3MnlFWGlzNWU3K002cktJRFVK?=
 =?utf-8?B?RVdyZ3ZxYmhrN25NTHlkY1pRak5vM09MYkFNRTIwamozdUkvQmlYN0JrN3J6?=
 =?utf-8?B?R3BFMnpXUUI0UVViQnhwNlBPYUpjeEFOOGRkYkhjVmlYWjlFYUJPZDloYXNL?=
 =?utf-8?B?Wi9BOWpXMVdtYnVpN3BwL3Zhdmc3SnAyODdZejlqSU1iL3RRYU1EeDJzbkNs?=
 =?utf-8?B?K09EL0s2c1Z4Mm5WTGdpVXFtNlZMME5PTXBzR3Rjb2daK29zNXNTVVZITlZL?=
 =?utf-8?B?Uy9jMWY5b1JQTE10WUlndmo4R3did1NrZUJXb3NPQkFNakdkYVRQYXN6djhJ?=
 =?utf-8?B?L1pMcmVGNnA3M3hsY1ZpZDlXMDNRcGJPclJoOEpWWnBMU1QranZmRHBLRGNw?=
 =?utf-8?B?L2FlSWZLeGFyemJxMUlQSlZESWR1NElReHBwbjQyZFpKbzBlTEFWeWZZblNT?=
 =?utf-8?B?Mldub2duNVEzSjBIa1FCWlZvcFE5VXB1QklWN05TU2tLS05wZmNBd1dWbVk0?=
 =?utf-8?B?QXJmdmNobC9NZ2hGbVBadlNXQ0E0eGE2WDZoVzlxbWkwNXAzRUwvUlFDVjNl?=
 =?utf-8?B?dXhMY1dhaDk4WkI2RlhhTElaS3pHaXg5YW1kbCtmZ1NVNTdZYnprSk9memw4?=
 =?utf-8?B?QStRMEZsYldrYmsvTjFzZTN3bmMxWFVrd0lRUXRGQktmdk1lT242NHgwZkRU?=
 =?utf-8?B?RGw2aEl3MkF3akc1K05YeTdQakRvVGRQY3lxcVpKUGR0WWNyNGRNdG1COFpZ?=
 =?utf-8?B?UTcrZWpwdEp6WFZacEFnczlOcERDdW9VYjRoVC9sWWxNbng0UlJsS0djbFRH?=
 =?utf-8?B?N0xSc2dsYTJxSXROWEhkdmxjWVBGMWNlN205M3BhNzlETGp6TjFRcmhabjNC?=
 =?utf-8?B?b2tQVmlXYmlzNmozNEd1T2VxYzVQeDNoZzRMK0llK3pRV25IMFpObXg5Rmgz?=
 =?utf-8?B?bTU4cW5ua29mbUhOZEk5ekhzbS9iMHArRDRNaTkxMUZ1SlVOK01HOEdMOUVi?=
 =?utf-8?B?Z2dESzVKNmdBYnJoNGgxYThtYXV6cEhrcHZNYVhCL1U3Mm05ZFc4L2FnZzJU?=
 =?utf-8?B?OFJ6SUtEeXVmcmZzZENsbmpra1NPZ2tOTzZIbTdaRDBiS3JzdWJNbnNwWGUv?=
 =?utf-8?B?aUlzMEVPNkJmWFNzK2tiZUlVd0ZmRjc3YWZYYkhHTXhITG9zeTFsK1pDYmhK?=
 =?utf-8?B?eEozVno1ODkxYXVtcU9QSUlMSTNqdWpFNHFLKzhObTc0RjFTMVZGQTRDMU1W?=
 =?utf-8?B?UlU3ZS9lUGNUYzhHakpVVzdPdWdnWUovdlJ1d1JwOGM4cnM1UDFQdGFmRjlF?=
 =?utf-8?B?anh0L0xDZmtvQkRrQ01zclZoeTZXUUNxdURNVGRudUROT1A0MUF6aS9MRUhr?=
 =?utf-8?B?cGNydDhrOTJPTUpkMU45cXRFWFN1Z1dXYTRpK1NqS2lHUGo1RUExNXdXNVBG?=
 =?utf-8?B?UkhOcmdid3VwTnQvMHBva3RyQkRNRmRoT0dWUEx5eWNkQ3F1S0hITDZNdnVY?=
 =?utf-8?B?MkQyOXIwT0tOeEVwUlMzR0Vtc3hOdEptd0ptSXNFYitib0h2RUNBeTNxLzlD?=
 =?utf-8?B?NnBhMWYyZ2h1Umdvd25DaDMzMmQxT2ZldFIvZFNDbVJKYVdtRGFxR3VIUUQr?=
 =?utf-8?B?OFZLcGtyNWcrbEN2TlRwNTIwTDBmRFQ2c2JvTTM5V095YUt1TTRuQmpmOUU3?=
 =?utf-8?B?Y09WeUF5R0RwT0hEVjM4R09EYnVFZlBYTWkwRGY0ZE9tbHVPQkF3akh6RUth?=
 =?utf-8?B?R2dLT2Z0SDE1djFSNHZaZ1BMV0pIVHVoRVcwb2ZCWjZEZytOaUR6RVNncWV2?=
 =?utf-8?B?K2FsV21lUFZNMkFNc05SVE5HQ21XUHVDbWQzWXVCRklxQTRoNHlMY0NFQkhF?=
 =?utf-8?B?NWlMMXhoaHI4dDdQNlo4RzgyTk1vUEpWaldjeXV3bUlqTkpjbzVUWkhDcUh3?=
 =?utf-8?B?cWdEK1RGOXpUcTRKSWh4M2phQVpuall0aU5ZbDhTRGx6KzA0dGE1a0RFTGVS?=
 =?utf-8?Q?cS7vWvT5254T0xZpYgZIcuY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7814f98f-4294-4e3d-ecd9-08dbb83eb1f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:59:21.7062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfmVJO6ar5T/KRezj3KMHu0tlBXf43Reo2JGxk8GNgjcpnfT+FZnJQeWSr8EkQD72LwlVHAZgIFV9SYO6vXH5LJsuUATNfSOJ3y+wJr6jN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10380
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



On 9/15/23 20:41, Denis V. Lunev wrote:
> We should extend the bitmap ff the file is extended and set the bit in
Typo: ff -> if.
> the image used bitmap once the cluster is allocated. Sanity check at
> that moment also looks like a good idea.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index a2ba5a9353..a6d2f05863 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -282,6 +282,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           return len;
>       }
>       if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
> +        uint32_t new_usedsize;
> +
>           space += s->prealloc_size;
>           /*
>            * We require the expanded size to read back as zero. If the
> @@ -305,6 +307,12 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           if (ret < 0) {
>               return ret;
>           }
> +
> +        new_usedsize = s->used_bmap_size +
> +                       (space << BDRV_SECTOR_BITS) / s->cluster_size;
> +        s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
> +                                          new_usedsize);
> +        s->used_bmap_size = new_usedsize;
>       }
>   
>       /*
> @@ -336,6 +344,12 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           }
>       }
>   
> +    ret = mark_used(bs, s->used_bmap, s->used_bmap_size,
> +                    s->data_end << BDRV_SECTOR_BITS, to_allocate);
> +    if (ret < 0) {
> +        /* Image consistency is broken. Alarm! */
> +        return ret;
> +    }
>       for (i = 0; i < to_allocate; i++) {
>           parallels_set_bat_entry(s, idx + i, s->data_end / s->off_multiplier);
>           s->data_end += s->tracks;

Otherwise the typo, LGTM.

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

