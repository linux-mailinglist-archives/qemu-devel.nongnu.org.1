Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BE7A4A81
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiE0p-0004JE-AB; Mon, 18 Sep 2023 09:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE0g-0004EF-MQ; Mon, 18 Sep 2023 09:09:56 -0400
Received: from mail-he1eur04on072b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::72b]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE0e-0007zH-K6; Mon, 18 Sep 2023 09:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCZ6cVaXLR8pXG2OgTLiaml/nuEi1KawvalwHj1hDgYTzFyeJiHy4rlE/OeabLla6spwdLHVOI0oWU4hpyEVdje5J5fybKRmj+gKd/PisGdO5a6Y12+ypi2S3UJAg4Q30tvJrvL+D3KwOVWMMgsxJUYBksT73W6VATlbfFVHzcFg3eQSizxc35pJJ1Kl6PecNKZg7zHunWJhOIJFSe0orpR+S8P7dXjSc+8k1vGnx30ocBBrbhJM83Qc0Xzys8fxd632jEfF3AhBUk6Y2NdjSQTPYiWU9zXPPmW42sTSavJe3DhUe1Y/ULiUeVdhwVpDavm7szIUei9/HkI4eQAolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nzGxf7j3RjfykLiuzo+Hq1MCVSELC+b8b7QuwvIzf0=;
 b=efrCTzX6Ey7EUUf8d9Z7hDTr1DfBd84RLHWLWdayujG0uAOfU4ZSaTL1s76KkGtYhJ7HJupR8ejOn3aI8zSwtcAs7o2HGDiIC9cJW8I7f+dqkwe5ylqkMbl2E4HbScP2+zm5DdfUyq3vxu1N967AImV4Q7sYeZM3J6Rb8nZr0rweczT1ftNSPXqNUHX+O/ZN8n64VFjO9EZC+Z8N5TIxiEheIRK3AqG55p8QaVNY3eYUZ33MhkCz10Alakkjgv53xavthy/vncOlkcm240JzSOZqKMH4hAcL9v/kBDlNlSGUBYTU6qPXe+tNvjAlis2kF7G/wP5wuMbNLzHmQwb0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzGxf7j3RjfykLiuzo+Hq1MCVSELC+b8b7QuwvIzf0=;
 b=j44YLiToawkl6Haz/nMSKka2c6h+aPlDUTdKqaiQiYavR6iPHPQJs90o4EmviWn9zohHX5IpgaBjA0NDrGWD76SKcRp/+R2cDbwmrf+XJBeYh0MMWkf7PJX5b7laoADnIHbmVJevrVR3QD549RD6f9Vt0jG5h6yUaAPcOd71u3eDINUaaDZzUbFM5mgq86CHSfzee1gUY/PvOV3zdLwOiHYNWXUIfGodrRXo2I4e9I6bvZhRso1WMMc3IMJzjMili+O5E1FE+oWcuC8vMb71jANW2rS1IQP8pr6fNmlBrqYpBkVGdwArX5ekKxTc9a+wwkjA4Xsos/8pBSQF6Gbupg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB7713.eurprd08.prod.outlook.com (2603:10a6:10:3bf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 13:09:48 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:09:48 +0000
Message-ID: <30261650-cf9b-7420-e9fe-7825ea151890@virtuozzo.com>
Date: Mon, 18 Sep 2023 15:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/21] parallels: naive implementation of
 allocate_clusters with used bitmap
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-19-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-19-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: d048693e-70c3-483a-31b0-08dbb848892c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/slyLDjZFXxM/c6AcI9CQNPdEHyjkjNz5gCWpNAx0lhsXfdKs0VbSgLSPOjuE46nA9C10PNrfKT6NggmDx4lS966wnGbWpCHMR4+AWQgek4ZRu5zn2+EJJKGlouuGohUJp5/4Tv6TThWuEiZ7sTXOtjiP/sTrE1gkOpp4DCF0LA8F8ZuQPiFyhGtcILwGmOVKwXhANA1IPbeYaP4grvqoJnMF8zlD8ll1EUKTG5LoXcpjXN5fEZUNnd+SRA1UWZLuuD/DagOrtIUMO9aQ1BqxW0UzxrYvxKjbl1qJWTk5UrZGy8chzkNhZ3LbKq9nfAgZb6yPthyOa9IzdAZoqo4kB/2oOSqWLTzqk8UuQnDmgPJcC49fJiiZAyLXqncf4gAOxJlab2duhL4ddlMmzsOFRWLYKjxV4f0MJUoRgofs77TTEPlvu+G6JlGu/P1KBeJDM+i2bZsYh/MJV0cYMTjL0JLjYKatnGrabMQOnHh6iIKIxHvXFe9y2yXxiOD3JB/ExfGQIJT/iErOW9DvecRomaqcPPSyAFuawhoBgj+T+itrR4TzOEMnWoUjPTU6xI1zmGwAHsWzQTUSlQQzz+xXBXbb1V1ROWWn2ujN7EiagwpkuvC+lP64o9ITpJYO0j9gthoUXUF2xm+n9gQYuQV1Q2+Bq0hv2zx7mIh6/VJHYGEo2tCyJVMNNKeEoe8wCT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39850400004)(186009)(1800799009)(451199024)(66476007)(478600001)(316002)(66946007)(66556008)(26005)(53546011)(6486002)(6506007)(6512007)(2616005)(6666004)(52116002)(8936002)(8676002)(44832011)(41300700001)(5660300002)(2906002)(4326008)(38350700002)(38100700002)(31696002)(86362001)(83380400001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1DYWVPRkVrbituVFZhSEwrOW1GQ09paG93c0QzOHNEdzFIR3BpdmE2UUkw?=
 =?utf-8?B?RjIxaFErOUVVU1h4OFB6K3AxdVB2MHVlc3RackhJSnpNYUxaSnBMcVlPa2ll?=
 =?utf-8?B?YVhHOGFQZEdnUXVmdWRpSnB2Q1phQWxrSzlRZG9sRzE5SUlDUlVKM0h3dUp2?=
 =?utf-8?B?RVJ5bTNMQXBqWkNIcG9JaG9jQ05rZU8vYWpzNFR0dkkrLzRkZjIzUzBsRHFH?=
 =?utf-8?B?TEt0cVc5RExZUlo3c0c1OUMvMXhna3YwOXc0ZFVRQVFsWXBXSUhmWjlkb01t?=
 =?utf-8?B?TUpZYjhwOGMxU2FUMno4c24vMU4zalZhWU03VGh2Mjl3UWtRdy9DQi9CbGRi?=
 =?utf-8?B?aXF6d2ZxTU91TFlPNDM1VVJIVlI0dFhwL0FwOTZtN0tiZVJkUDd6SHdyeEJh?=
 =?utf-8?B?OFhsSFNwWU4vbkFUTTRKTCs4algyWTdiZ1J0R3hOUUk1OVZnU2t1SllOWE5F?=
 =?utf-8?B?eFVVeWRqa0F6ZXRpQ1dQbTZKWUdwR1RHYzVoRTkxQmZUaGpnYmNtbHZDcjVa?=
 =?utf-8?B?alBnZFNtUUU0ZlYvNlVoVENFRlc4SURYNnNzUnJHaEdsdjdOay9XcnltemM3?=
 =?utf-8?B?c2Frekl0ZTc4MkZ1ZUhWaXBjWUFPUUtxdzhCeC9SRk1Sb0pRZVpjVDFaL0R6?=
 =?utf-8?B?RHU4ZFpodWRqenZUbTlKNTNrZHVmR093MUN5R2w4UTVDOGoreGF5SG9KMWNx?=
 =?utf-8?B?YmRQUmhGb1NuQ2x4TFdLQVVjNEZ1akNEU2FMamlheEtONkJmTVZGVjBvMDZ0?=
 =?utf-8?B?QnljM3MvYUpqTExiU1lvQldLclRsMndTanJFaURRV2FZckhOenB3c09pejNP?=
 =?utf-8?B?RXpDeG1uUTNSam5iZVhOOE8rYnJJQjNWa1V6MVJVVU5OdTdia3ZBNDl4bDBy?=
 =?utf-8?B?RUZZc1hKM0NUMkFLcHZ2QmtyVVRSOU0wRFdXZGdvZ1ZxYmk4VExGb1JzZzV1?=
 =?utf-8?B?SFhWYXR2RG5GSk43b2hkdEV0VTVhK1BkWHZvNkhzSXZFZjdQRUJWbERNVHVt?=
 =?utf-8?B?VWlDVUg0WWYzUDlrRjkzR1krNUZUR01FUldaMklsS0orU25kK09TRTZSVSty?=
 =?utf-8?B?UWtzNk9SWXF6NHU2cFdtSFRBWGFycGJ4K1YwRHFqejBmUUIwS05kUUV1amJi?=
 =?utf-8?B?NklpcG5kTEY2QUlPdzJtRWo4clppM3dVT3NkdldiY0FzUHZOb2JjMktDa0Jx?=
 =?utf-8?B?OFVQQnB5TEtXWVN0VnZUbWFLM0szZDV0UmQzYUNQaWRJcTg4T04vSkVJTlJU?=
 =?utf-8?B?c3BjcVY0SldPazRadTJJaEhPbTFwL211Rzd0Rm5IQmQwS2VSb3I0c20zdkNh?=
 =?utf-8?B?cUtrNUVnUUl4dDg2czlTdDc1aGNyUlBlUlphMzhFQlMwUFJEcFN5T0IrVmpM?=
 =?utf-8?B?SjQzYmdQTlhJVzVxcTFmMVBVUEhjdkdYRFJybFd3SE9MQmdJQ21iU1ZhdG9z?=
 =?utf-8?B?aUh0NExzZ3RZQnVHQm5ySUVpK1VwSVFrUU82VzFXZlJoSWNjOW85bDhQVC9F?=
 =?utf-8?B?aGExWm41VHppMlJlS2ViVUFLRGVtMXAyZXU3SWhQVy9XdngrSGlRaU9WdlFm?=
 =?utf-8?B?MWdaT1ZIUmVxazhqd2VBVlYwdWNpRGJnQzFPOWlJdkJwOXduL1NwdWk5WWFv?=
 =?utf-8?B?b0orT2FkWlppUDRMUENHT0llL08wM2JQYXhrdkNVNWRTMytNNXNRYldiRjBl?=
 =?utf-8?B?WWtZZnZDODFwVGJFaTFDR2tHSi9lTndWMmw4N0hqUm9Oa1c1ajZFNUtlQ2Vs?=
 =?utf-8?B?eUIra0hmeERuOTdIQnhjYWpvUkdEeWVaekZmdnNIdURQV0VyVTBJWGtaLzBP?=
 =?utf-8?B?S3RPSFlMODFETkUzSkVoZTI4T1BBcjlJcm5nUzBVSTY4dEhjSlZVL3dGOVpB?=
 =?utf-8?B?alNVVm95bmpkd0MwU3RMclJsNnJ4TXF1NGNMcTBZOGIxOG9PeTNMYzByTndV?=
 =?utf-8?B?MmIvKzhsS1VQdjZvTWx1eno5RFdsb040ZHFIZlhBM1BzbW4zTWwrdEM2aUZi?=
 =?utf-8?B?Q2l3VktGS1BBaW95Mk9EQ2p2UDBjSkNrY1l5aEVwNU1VNTVKUmNJN0xpMWQr?=
 =?utf-8?B?bEhmNzhRWmpldlJ2Z2QwTUk4emllcEY4NThLNHR5TlhhejN5elIzVDJlWVIx?=
 =?utf-8?B?NEJEdWljbE9JOXFKSkREVFFyQzFQVUh1S1V5VFBETFZ5RlE5RHN1dnJldjE4?=
 =?utf-8?Q?WNMc64pV51hw1cGgTigagHk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d048693e-70c3-483a-31b0-08dbb848892c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:09:48.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEBneJzaCxoq/G2JFLg+PuTYfECzFHFBbVCblIJO1B35d9kJU+kq0Lbm1hrD2X3dlketkXs+660LXIo9hHxkrG5z33+aTx3dPjjYHy/Yx6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7713
Received-SPF: pass client-ip=2a01:111:f400:fe0d::72b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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
> The access to the bitmap is not optimized completely.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 51 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index a6d2f05863..2efa578e21 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -253,7 +253,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>   {
>       int ret = 0;
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t pos, space, idx, to_allocate, i, len;
> +    int64_t i, pos, idx, to_allocate, first_free, host_off;
>   
>       pos = block_status(s, sector_num, nb_sectors, pnum);
>       if (pos > 0) {
> @@ -276,15 +276,13 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>        */
>       assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
>   
> -    space = to_allocate * s->tracks;
> -    len = bdrv_co_getlength(bs->file->bs);
> -    if (len < 0) {
> -        return len;
> -    }
> -    if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
> +    first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
> +    if (first_free == s->used_bmap_size) {
>           uint32_t new_usedsize;
> +        int64_t space = to_allocate * s->tracks + s->prealloc_size;
> +
> +        host_off = s->data_end * BDRV_SECTOR_SIZE;
>   
> -        space += s->prealloc_size;
>           /*
>            * We require the expanded size to read back as zero. If the
>            * user permitted truncation, we try that; but if it fails, we
> @@ -313,6 +311,32 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>                                             new_usedsize);
>           s->used_bmap_size = new_usedsize;
> +    } else {
> +        int64_t next_used;
> +        next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
> +
> +        /* Not enough continuous clusters in the middle, adjust the size */
> +        if (next_used - first_free < to_allocate) {
> +            to_allocate = next_used - first_free;
> +            *pnum = (idx + to_allocate) * s->tracks - sector_num;
It looks, we can write this simplier:
     *pnum = to_allocate * s->tracks;
because idx and sector_num aren't changed from idx calculation:
     idx = sector_num / s->tracks;
> +        }
> +
> +        host_off = s->data_start * BDRV_SECTOR_SIZE;
> +        host_off += first_free * s->cluster_size;
> +
> +        /*
> +         * No need to preallocate if we are using tail area from the above
> +         * branch. In the other case we are likely re-using hole. Preallocate
> +         * the space if required by the prealloc_mode.
> +         */
> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
> +                host_off < s->data_end * BDRV_SECTOR_SIZE) {
> +            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
> +                                        s->cluster_size * to_allocate, 0);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
>       }
>   
>       /*
> @@ -344,15 +368,18 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           }
>       }
>   
> -    ret = mark_used(bs, s->used_bmap, s->used_bmap_size,
> -                    s->data_end << BDRV_SECTOR_BITS, to_allocate);
> +    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
>       if (ret < 0) {
>           /* Image consistency is broken. Alarm! */
>           return ret;
>       }
>       for (i = 0; i < to_allocate; i++) {
> -        parallels_set_bat_entry(s, idx + i, s->data_end / s->off_multiplier);
> -        s->data_end += s->tracks;
> +        parallels_set_bat_entry(s, idx + i,
> +                host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
> +        host_off += s->cluster_size;
> +    }
> +    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
> +        s->data_end = host_off / BDRV_SECTOR_SIZE;
>       }
>   
>       return bat2sect(s, idx) + sector_num % s->tracks;

-- 
Best regards,
Alexander Ivanov


