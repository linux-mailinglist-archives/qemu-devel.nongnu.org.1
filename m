Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C87568FD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQye-0001no-EC; Mon, 17 Jul 2023 12:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQyD-0001c2-7T; Mon, 17 Jul 2023 12:21:11 -0400
Received: from mail-am6eur05on2071a.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71a]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQyB-0008Fm-2X; Mon, 17 Jul 2023 12:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgfasV3b3rKacnEFuc8GVcZJhqBNH3e48e1IVNkEDbxnjre7VyiV6DJJUcbXIPe5fjDf72KK+YOzRla20gzmwuB7kArQ89gHibAtIvODgTIk79iHGUxy97nhUvakyfqN+P1i35xMbzPb9/iZgG18sKd8YN1wDbcakxSvp3nIRjWq5L6F6AHkRA3eJ8C9i1+yJo9oGH4NDDNWgkNfF+7HPC03ygD7thI8cJ8ycIAstnZVtY1wt6CJ2yX+GQ16rf+wJaeD8e1RJumR3aCj9nD7NY8sE6snAzTqrhUx1Jk/iQE4o0gJsQBsR3VuF5+b+3mPoxFz6Cckmp57KeVO+mdYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ39tAzOPyoLOGfHTwsugeWfrncuJ14+xXpRMqa8mHY=;
 b=OKd+oHn7EH91QFUGKXJiytGGyehxkOZ7iaDDh2lA9gyoD+iFXD/PW8DCVx5K6YgbRHXuY9q1NF8wOhav+w/9ZNr6pQuQ0Yi6yCxJsQB0+jW0tRAiiUBr1k7MM6rzj0fmsnd9rQxEUiYG+DpZgT59uswQrhQgAdm/LMO/I8Wv8zcGXyQZqsuU11S4zVtMU/Uc+MXxTD68KecJDEZgmf+gmlWgcrZSVaI5xAV/hJ3nxQpk+xNx+h4ij3Pbq+x+kf+L3jYgOqfC8zgs2i1hXilOrjvRI1m/QtmilouY+aLWs5k39xW79PwW3TDp61J6i4x8UYIiXyZi6NOByMP3LWcSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ39tAzOPyoLOGfHTwsugeWfrncuJ14+xXpRMqa8mHY=;
 b=cVDFTohswSeuj8BaewX5NYum+i/Bo6vgvd+xAGw4NHgWzXeJ1NPbFV/vBepXfTDtCbW11w1rzNbB2ORaTXF2oxxL0ILNKuQaNkC3NPsgXy6cDIwZdYT9Mr1+H1zzlEd9aKQmA8L4ISSvTZdTGg5aymu8M2S2nI0z/9ssutyziNYb/7WOOAGQoUFWD0uduqQE+1kOH54UcwzkFlWLb/EAmWXsTW15ogQgSbXXi/gecZ7jSndSnRS0Exn4rH3gy46ZoOEmbdltblW+lDXzMTPeoV0xiJPGkP4TGmC2pzOeKR5+ZTEb8DJkL1lOi3B2k2XtId1fOLkNShbphFExq/3rQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB10136.eurprd08.prod.outlook.com (2603:10a6:102:34f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:21:03 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:21:03 +0000
Message-ID: <3b7226d8-8f9f-ad2d-9f38-22a0761f1213@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/8] parallels: Add data_start field to
 BDRVParallelsState
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-5-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::24) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB10136:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e36d12-e81e-4626-3481-08db86e1d100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpV1jEC9WxZ6tzgFHJZpAmTHqFQCsBOwD+NNmc6hJO+rr35MthYep7OBFrdw+NCDiFxg/B2mw0gjLjtGPtF48oJlR2wxYO2fvA6Q6SbuoXjwVy7et3FGd1aCFO6iNELrUHwbGXTXpujN9cesSWLaOAbYCbgGkz/eWfJvpzkOwupsGmZrleGG7Zy2fN2Oxdi6d6waJI0Tbri5vfUnYVSImpujdu7380MUa9DkzCfkdP6MFunN6zwppFMqycyTxarSW0C49D/jhzFa5Wb8L6KrJ+qwzfMGVynx5xe37N7HQKUpJw0ybzsZvxK6B8jPQHZuDBeQZejW4sZU+T5c2G1tKtOnKgRhqUXqeTK/5FfdAffP9vE8eHHRN/zbNcdmY5Hijp2XPYeRzLa8ReZg6LgoB0CB65yjooxkpHYPA5qs//9cRQVrCAppGE0/HMpKhNrpT7qnfa+PbiitOqtoZnGlPAXfRxuB0//iMjpyycRlU/WES1cfFVrX1JSJXDXr4cqrSSigJRyrEOe5K940F+fxKqtmGwWdhh4V+8JSL/8nlJA634W/5B006skadzSJP1ZvwKuT0L1kJFxfomTIinQMCXyPABf/8nAIVf29Hc3uX0Fc/l6E/ZYoNbIXmFYZOU1rcwidmI4wmXunnIAH4LdqgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(451199021)(31686004)(6486002)(478600001)(83380400001)(2616005)(31696002)(86362001)(2906002)(26005)(186003)(6506007)(53546011)(6512007)(38100700002)(66476007)(66946007)(66556008)(41300700001)(4326008)(316002)(8676002)(5660300002)(36756003)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czMyd3JuU3dnaEp1WTJxZkxFbUVtZmdZUDhZamtvZUxMbk83cmZVMktOM2p2?=
 =?utf-8?B?ZFRjRmZDditUMkJRNC9DSWVxZlRpeklucXZDWWJYWEhGNmhhcWlQaCthR3Vq?=
 =?utf-8?B?aVhJWHNpK3RrL0hXUFFKZzJub0Q2Z2FRZFZCbXBjR2FHK25pV0lqNHNYdWlr?=
 =?utf-8?B?SE52aDgyMzB2STlXM0lMNUd0UkdEb25ZT2FJbkxNY3NRaDZBS3k2SjZaTTQ1?=
 =?utf-8?B?N1MwTTlSTHpEREdUUGdycmZJK0tSVXNSUUNpS0dTakd4RkhOVE9LbktXSEF4?=
 =?utf-8?B?aWhncG4ybVM0NjZ0WmF4SFlyMDZyT0N2TVRtbmJpSnhJNEg4M3JPRU0vODJa?=
 =?utf-8?B?MW5MMEFZSy9CZGJUeDh6TE54TS9sYTc4VGlUdjNqS2JzSzlRcm41SVBpeExz?=
 =?utf-8?B?MFJscDNWVWpPNlJ6QnBrcFB6d2FiV2tSNm5UOVFNbkRXcWJLdUpYSkN3NXJF?=
 =?utf-8?B?S21VbjNocU5RNHBLVUUyUjQ4Z2pBWnR6OUtXK05EeUxnK1BGdkNyMFNIT1E3?=
 =?utf-8?B?b1dLOFdDakFBMU9CNWRlU3dBanMvZ2JZWXkzYm1PdTdYUm1PdmJ5NmQzQ01u?=
 =?utf-8?B?TWYxRFBTN2VreVZDY0EyV1oyazBmSElJdytBNEpDd2tONGpWMTQyRzRKOFZV?=
 =?utf-8?B?SC9SYkxzOEJUTXZ1QmsrY1J6SGNvc3R6ZXpabWFaZkZMTVdYdUU3VnIzNkRx?=
 =?utf-8?B?b0RlaHZWblpQWWJ2MHZNcW5VS2tOK3RHb2lBV2RRQWgxNlVOOXpJMzVLT0xS?=
 =?utf-8?B?VEJUWFBHSTd1SHhtRytWeXQwenErbjVheW9uYlRqb3NzelFJSmZzZWxuNGNt?=
 =?utf-8?B?cUhaTXJvb2pPMzI5dlh5SjN4M21nMFN1azVhM3BnM2JZV0toQUdwTzUvNUkv?=
 =?utf-8?B?MVMwRHZPSWhLYWdqS2lveUJEdzhZcGVDY3N4WmZOVmwvekd5RXk4MWxubmVz?=
 =?utf-8?B?Ny96ZDZ3YTNpS3hZdW9sL2RBL2gxZWNOSFFwS2VFYUNxRy92bGU3VlhNaU5R?=
 =?utf-8?B?Y2VlcFhVblJiZHM2SHAyUXJ6VnRteGgydm10TXpReWxyRXVpcFBMWGZGbGRv?=
 =?utf-8?B?d1ArMENOekFYcnJ0ci9kU0x6NVFEVEM4Qy9CL3NmbmdtK3RCUkE3UGcyc05h?=
 =?utf-8?B?MEIyMzZYREVWUFNzdWJReFhiS0cvMTNNZkhTM1VnTmpqOUM4Z01iNys0aTc1?=
 =?utf-8?B?bjhZajdhc2ExUXdTRHpFU1ZjTFNlSVVNQ2UzcWVSaFU5NHMzQXlZN3RNdkNn?=
 =?utf-8?B?RTh4b1pFaWpvRGZ5MCtwSlZHTnAwREhNSEZoV2kxWFA2aHU2ZXJodUxqVDJh?=
 =?utf-8?B?WFlVajB0RHJ4c0tpK3ZkMVl6OWZwYWMvOTBnbnVaVy9INVJUZlhLYnh5MWNV?=
 =?utf-8?B?dGtPS1VzeVpzNVRTMTRydG5NRHFjTHYzM2ZKWHRnajZaMzBzdVFoNWwvSEEz?=
 =?utf-8?B?c3JPRnhXQW1HTGh2UnN0WjRHTmN5RmFGTi9BYzQ5YzMvZ2EvaUtDV1NDRVpZ?=
 =?utf-8?B?bm1YTllDcmUrK09YTE5HVkJHYUVuQjRvSEVVVEkxdll3a2xjV3ZkTTRERzhF?=
 =?utf-8?B?U3FEMk92b21aWGtuZ2FCRTBTdUM0R1l5aGVHeWd5bU1yWWRnN2JkV3pvZHkw?=
 =?utf-8?B?a3J5c0lBbGdteGFZOHRlYjVncXk4SHQyRmNMS05EZWQwN0tqQXlLbVVmOWJ4?=
 =?utf-8?B?SFhRVEdqSG5wNHdpOHZ4anIrWG5PSGtMa1MxVlduNmZYM1RuMkNTMmJNT2JD?=
 =?utf-8?B?NEloZVFpSGNNZFBiT25EQm9JZnVTdEorSVozRkRoTHZLYlM2Mk50bzgxWTVX?=
 =?utf-8?B?ZXNzTEdsTzZXaEp0ck5GVkh2YXNtc042WUxIU2IwM3BZbFJJOWR2YzhDbllW?=
 =?utf-8?B?cjFjbnN6UFRlRGdCWlV1ck9SNTRNMmtMUy9vNEFrcHZ4TXpDdTVVdFBhQlhY?=
 =?utf-8?B?WnJyajMzTG94WEFyOXpqQUtIMlBWQ3RPNFZwTVNtM1QvQ0x3SEFKWExrekVs?=
 =?utf-8?B?Q2wxeW9Nb3cxWmI1T1gxWEpLemV1bEtER1hwemY2UWJ0ZWNuUjJoTGRBbUpF?=
 =?utf-8?B?L3lTQSszWS9VbXN4TUtMR2hQemRnNVYxSkZxaVgwUzdMay96bGhMUDVTWlk0?=
 =?utf-8?Q?tw5CF0gP0egXOH4+ZFKtC+D4M?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e36d12-e81e-4626-3481-08db86e1d100
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:21:03.6071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp/gs0GqiVBr7OmEJ1mZZwjmggyIHgm2R7kuEHg7EZrsJmwUauhmTCOtmt6m7gzi2WF7pS18r4pC5Yu+muIKOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10136
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71a;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> In the next patch we will need the offset of the data area for host cluster
> index calculation. Add this field and setting up code.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 7 ++++---
>   block/parallels.h | 1 +
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 3cff25e3a4..374c9d17eb 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -864,10 +864,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           ret = -ENOMEM;
>           goto fail;
>       }
> -    s->data_end = le32_to_cpu(ph.data_off);
> -    if (s->data_end == 0) {
> -        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
> +    s->data_start = le32_to_cpu(ph.data_off);
> +    if (s->data_start == 0) {
> +        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
>       }
> +    s->data_end = s->data_start;
>       if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
>           /* there is not enough unused space to fit to block align between BAT
>              and actual data. We can't avoid read-modify-write... */
> diff --git a/block/parallels.h b/block/parallels.h
> index f22f43f988..4e53e9572d 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -75,6 +75,7 @@ typedef struct BDRVParallelsState {
>       uint32_t *bat_bitmap;
>       unsigned int bat_size;
>   
> +    int64_t  data_start;
>       int64_t  data_end;
>       uint64_t prealloc_size;
>       ParallelsPreallocMode prealloc_mode;
Reviewed-by: Denis V. Lunev <den@openvz.org>

