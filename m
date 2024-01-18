Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F20C831BD0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:52:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTke-0003jX-7A; Thu, 18 Jan 2024 09:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTkb-0003cF-Pa; Thu, 18 Jan 2024 09:52:13 -0500
Received: from mail-he1eur04on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::702]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTka-0000gN-6B; Thu, 18 Jan 2024 09:52:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI5oULaLfi3JWNHker4cZ3YNXknToGjo6RlSCXOsfKrg9JyZZEpuDCe87YPSyrcNtm6xljJXuynaEzF8XbXMuylX8Q5HqvyPkuLhTdw2jvD9hMvkrDoJEehljlnasJc6xlz3KsIX08fBuDB8U4jqBfJJV/R4JtBX2hZhT59O5u0rWHlt5S2cS27N5UAYEHh9DEtqH8FN3oC1oV6sOaLW3cRaDwpy8FrkCwFKO5YiFRyIVozW40QYC3o2C/mL60pKnY2CNZgZ1Ie26YjKyj35hXkLGUvsw6BOJ+VWx3KpaZwgLdxOX9DhdlOwUscmqYKUs3837R3UDH90P/U6YJqfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3uGSySoqIxb/bn1lTnxFhOLFhWDTdvqY/berCETX2k=;
 b=BnJ4V7VaENXtaYv07QeUFtCEN7DtDqKQKZBwY4ykduhl2UsJqycKI4fhGud/kowJosT8V2hDO/FsLNJtjE+vH8z3rFZPpgRdJ3cuMLoSyL1xGTA2n/C0loYQM4tjpErIQcxREotcTeys36eSrw7f73oxDkFkFNG8qvGXA/QhaNf5M6y5//WTpzL1IYMzz0ujF9Bphc9WCGM4FMNA+lKbieUKepKRJ3oKcv1LrrNMhyROi/oo21MEyXUF5z2lpxWP1NTsFe22GbSwY5/dLJwM2DknpFBgeML2o7QsX+Y8KmviAAw815Crh01ujD1Ifnu0TMeYc+K6Xc7FpegI9quZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3uGSySoqIxb/bn1lTnxFhOLFhWDTdvqY/berCETX2k=;
 b=uaQ7LKUHx0RvoaCM2fVsLz4gw2pnGrfPvxcB3xMAg1kmyO8ZB61wePASJksa1ss5qlk9GtUoVJzdOMe8C7vA/Of/hMEgexFja/ijHkzPdHl4tab6rA4HuSs1Yz4WvS++ftPCMkc/pRkxe+qWNXta850V6sP1N5eCEngugf3GT3U2STmJ1NeILBHW3u/wOoqjoicBoR9LKTPE3+fbUN082Ca0oc+A+gaEEBLB1N4Rjh/DIl1O5Emuph0X7ldw3/dHkD3TqrChbfnhaWJHaoiOsfqbzZKQaXLciUp31VcUz2yqRGwoCOO03k+RX3lyTj4yP2b954CzTfKFjFWzAN292w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB8174.eurprd08.prod.outlook.com (2603:10a6:10:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:52:06 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:52:05 +0000
Message-ID: <41d2f436-188d-4c75-aea6-31fecc349003@virtuozzo.com>
Date: Thu, 18 Jan 2024 15:52:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/21] parallels: Truncate images on the last used
 cluster
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-17-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-17-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:802:16::25) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d3e09d-36ca-440a-fa80-08dc183509df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBzN/G/O2wITUDTDWnHWBhfwg8aXoLYPHW6tNKbJlhLaMbboztESzrm0rRJuylFhDQ6nRtPcpSem4yip9y1SzPIoSWeuPoyFU6Ur+plM78k6L10DLE633x0zgqExQkxPwyCRDLmDVZjGKpI+3CAV2fjuyBY8fzbpFcOLyXAIXZ82sq5EhujdRqqjaOUMgOe67/sj014+4ppwod39S5P2DPEpatCGA+6zdPWlJjpcW8RcKjHkPfvu4OsnFCA1d9IugJBx2cJ3OzAahqlJNudMUrhKE0V9kVdyS2Ne2LFZeDS2/FDGKix3Xdk3pfnHmQ/N1YY1acK5m3Z0A7oW1h3dH2Cj2qzXAVW5zZ39KEM3i3/UWfSUnsCGabr+eWhIRTkI1YKLcMFsocxU0Hs5Dd0Y0rzs+S1jPDt4QhnMcUh/NBPIumRHHplm8HoG1ehhgb3wIAoLtVb+CKfl9SJbeefuVEwQ5uOuHu09prHwSYBM3qEElB+dw5t9EHDdmUtvXwhUNppH+1CJ7x7zxjeHuI+qztWpUEHH33IW1X3zzo5IYIRjqZr8yaSSue+wa4SvSAhOvV7GlpSJZNORxIwe8GmNj1pGdmbDwC+dhQZIwgQvrZ3in1+U0xKDWT9mXCsqqrFqcBKKzFBhV7FxAsTRu9wd7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39840400004)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6506007)(53546011)(83380400001)(26005)(2616005)(36756003)(86362001)(31696002)(8676002)(4326008)(38100700002)(66946007)(66476007)(66556008)(316002)(478600001)(41300700001)(8936002)(6486002)(6512007)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdnTlpoUVBOZ3JwVWZ1bFAweUtuditBVWN6T3QxeDBiVEloN3dybzVubzZx?=
 =?utf-8?B?Slg3T3VzNm9sZVN0MFlwM0F0ZmVXd2t2OCtBZUhZQmVaT3B3Z1g0QmRaOUlI?=
 =?utf-8?B?SkpuUjc3dUJ5eHRXeUZzenNuOFZDMU81VEhrbmEwbktxY3E1cEhQbGFhcGJL?=
 =?utf-8?B?M0E1RmUrSkRWTWp1K0pONlpJS2JZR2FXZWc5aGM0QzVSTGNhWmFLYVVDdXFV?=
 =?utf-8?B?TFN1TWUrWDRFZzZScmhVQzFEcTQ2UGdhb1Q4Y1dRRHg1dTU5OFhFdWR1UEk2?=
 =?utf-8?B?eGx5ZUNiaDNKb3AvZCtUTHViOHNOTmczMjRlZGVoQUlIVXRKR0c3WFIwcVNj?=
 =?utf-8?B?bGs3ZFNxcGU0U3Z3WnU2RmVPWTREaEZ1VUFmWHNBb3lKTm9jTFBEQ2o0Z3BR?=
 =?utf-8?B?Um1KK3hIQi9Qc1VPUyt0SnZkQS9QcUJIMnpGcnptbHBiSEY2S0p0SEhiZ041?=
 =?utf-8?B?UjJZQUw2NlhzRCtaNVJDbnhpSUU3NDVORzNSSEh3RGhJQTFTOEZzcW1LOVgv?=
 =?utf-8?B?OEJZU2hIZVY5R0lWUjNsYUdSVzdkbUpOOHdPU1lPZVNBSFFSQUUvV2x1ald5?=
 =?utf-8?B?L2YzYVpUbUFEL2VvYnJqM0ZtYjNUUjJ1UHhUalhsMWdYQ0RZQ0Y4TG5sTXJ3?=
 =?utf-8?B?VnJJSzBNZGNjdTBkS3VNSlNDWXlLZjEwZ0lWeTh1Mi9qdmdUd2RML2dEUFcv?=
 =?utf-8?B?dEZzQ0UzQTRoZk00NnFpMmdPNVZnRlpOZzRkUHlHR1M2MG9QZnRsRmdoQ0RS?=
 =?utf-8?B?MnV1ODZiSkdXVmhyVkdsSGV6Yk1MNkdWNmlKbWEzSUV3NERSRFA1MW1LTkJj?=
 =?utf-8?B?ZU1xaDdEOTlybTk5bkgxQlFkUmJrL1JhRFdtb3FMNG5IN3NkajZpQXRhUmJH?=
 =?utf-8?B?N0pMRml3eHZuMXhXTGlJNnBuUEVJMGhaLzN0c2prTVgvbmEyd0M0ZnY4aGxr?=
 =?utf-8?B?dUtaM2tNc2RpUlVQOUs5REF2U1MreTQ0WXZpTjJoR3h2WnJreGZ2WGNITUd6?=
 =?utf-8?B?ZUszWjYwK0RHcHI2MU14QmVhbTdxVlN5UWpVdXdsdVlsa04weVl6L3RTUXpC?=
 =?utf-8?B?cjhuaUpLU2VTRzQ1Sk9ub1dLeE5vdG9nTlEvc1RsQWJWYzMvaVllNTdNc0ps?=
 =?utf-8?B?Zkt1ZzNyYzNVMGszaUNORWlkR29CdnhGY0Z3d1FpeWdvOGdUQ0ZZNmJuUE4v?=
 =?utf-8?B?QlY5UjdVOWswL3UvdWxnc1E3Ry9CSld0SkxEUHB0aEhGNFAwUU1zdjVnQzM0?=
 =?utf-8?B?cSsycnhyMVgrWGxzWUYrL0FhMk1KVE1ZR04xQ3kzNFJFTUVlS1ZteWpCYm1N?=
 =?utf-8?B?M2ticEJtMWw0T0p2M21sOTEyam9NcHZ4MTk2MWlza1ZRcUh2RWt5OFVVZWpo?=
 =?utf-8?B?SFlGRWh5a2U0clAxNTJxNUtyU2czN0VaTURVaU4xSEp2YnEwaG5uSnQweVJG?=
 =?utf-8?B?cUVZYkJGcE9seFROZW9XV1U4WmM3bUJSL0U0UG1QeXNta0RHMkI1bEc3Q21S?=
 =?utf-8?B?YXo4VUpsVE9NamVwMWVURk5MN0ZsZGVkL0xDWUQyR3E5ZUNWTTkvUWxuNVcx?=
 =?utf-8?B?Vy8yQUw0SU53aFAwMVdYbjd5R1ZOcVB0T1hrWVgzeHZGZERQUTdld0FHVEVh?=
 =?utf-8?B?eENxV1pMdWFGUS9uZ0xucHNkTDdLQW5lVnVaTTZTcWxwRFVSN3I0ZmdldWVt?=
 =?utf-8?B?SmJHWXlNZXEwaUQ4TzJvUHV6dWlibi9ObUdQTW5FeXRqYnZhVHFreHJFVGJr?=
 =?utf-8?B?Wk9lcmNwV3JRZkszbFQyelRJL1g5anBlaHlPSENKR1A1U0ptWGoyMExZL2VJ?=
 =?utf-8?B?YTAzVlZ2b3d5eWVuMldOU01kWGV5eUplT0hHa3JENDdQVzNPdW5keWZyMmxl?=
 =?utf-8?B?WmNsZFpDcnJ2R2pBWmZabktHUmNFcVppR1lRTFh3WjNkalNDTXR5Ym5oQU9U?=
 =?utf-8?B?QUxaUklWNFhQSzBYRmdUUjBkQXprZVhpV2JQRGYwR2dJQnIvcC8va2JSUzIz?=
 =?utf-8?B?ZlpJbHl4aFlvOEtWYitoNkJTZjBWa21RUVo4ZVM1Rnorbk1Fb0VzTUI4MkxM?=
 =?utf-8?B?UWxXcWdacWZnZjVLd0grNS9mM3NxbzdQa2ZUbytGWFppVkxUdEpDUTNRZDVE?=
 =?utf-8?Q?R2EmXFWfKxXs/c5Brino1kd91?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3e09d-36ca-440a-fa80-08dc183509df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:52:05.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IHT/fxRTX4rmDOeS51MIojnfvmfBkF9wh7/Y9mHiV7ppZ6qgJAKaWvKJwhOOZaxeKkb317O2i97SKLstPWm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8174
Received-SPF: pass client-ip=2a01:111:f400:fe0d::702;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> On an image closing there can be unused clusters in the end of the image.
> Truncate these clusters and update data_end field.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index fb7bc5e555..136865d53e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1454,6 +1454,23 @@ fail:
>       return ret;
>   }
>   
> +static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    uint64_t end_off = 0;
> +    if (s->used_bmap_size > 0) {
> +        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
> +        if (end_off == s->used_bmap_size) {
> +            end_off = 0;
> +        } else {
> +            end_off = (end_off + 1) * s->cluster_size;
> +        }
> +    }
> +    end_off += s->data_start * BDRV_SECTOR_SIZE;
> +    s->data_end = end_off / BDRV_SECTOR_SIZE;
> +    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
> +}
> +
>   static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>   {
>       BDRVParallelsState *s = bs->opaque;
> @@ -1471,8 +1488,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>       parallels_update_header(bs);
>   
>       /* errors are ignored, so we might as well pass exact=true */
> -    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
> -                        true, PREALLOC_MODE_OFF, 0, NULL);
> +    ret = parallels_truncate_unused_clusters(bs);
>       if (ret < 0) {
>           error_report("Failed to truncate image: %s", strerror(-ret));
>       }
Reviewed-by: Denis V. Lunev <den@openvz.org>

