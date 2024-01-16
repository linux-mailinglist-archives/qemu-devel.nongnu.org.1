Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09682F00C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:55:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPjtV-0006lA-Ll; Tue, 16 Jan 2024 08:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPjtM-0006j1-4D; Tue, 16 Jan 2024 08:54:12 -0500
Received: from mail-db5eur01on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::718]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPjtJ-0001QD-4b; Tue, 16 Jan 2024 08:54:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPtSZnR/Xr4w2mnBkCJk4z4b9mVP+4mYPIyqgoMofC1YnsEiFjazs6ihbOfXMQmHY5fHP92Aho3YZ3y8vhGBCPJ+uAjFFabpZ8Enj9Ia5o06TXwegPzGTfrGzQBir3yhaVjUfyjAfFZnkmvyQQj+4AFFyPBAEcvV7YTScEdZToI8cG8TZ5zQhX9Al26kaUCCbDTN9gVRtjpx30krc1HM0iZqothkM7RhLvPrsNFX2DlKwHM4KPCH2oNfNUAFvR7aN5nnr7PooL8Egqi91b9wMtxUK6lu4mgE4JEaUUrpTSUhqg9aS31rP7vkFKZ61HBuj1XnMoU+KDvsCHVJmj3fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHGwoDGcjUnhAEg5aUaFp7K/8AaMZfvsavT4aDAVK7U=;
 b=cB7dUd5RmeYBGU/5XBLRG8DBUygNHl+72AfC74JVucBPx1RoE3FfRbFJhxXERYyAgHd8cnE2rFmJH5bu9ZNc/i3tuilOJxgTFG7kRUnEVtWDa5uUhmDxALp+sgqmpBwqo0NhBBOmltvxNDOKm45GYjhI4sWWtRTFyhBcVf0H57pKaOJn2p8/inm5SUsHuRAL+mIMHp2gQGrL9FDjCyDT95wqmKN0gKu0o7ncqtpoOln2CGEyjFtcp1OimkcdHxh8qrktcZX338gQziJhFwBt01e9J0cTvmxgMuwJKzJOWErvvLXxwQOmXgUon7d0E+roQAiXMTMpIjeyAYoni41GMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHGwoDGcjUnhAEg5aUaFp7K/8AaMZfvsavT4aDAVK7U=;
 b=PHsnYRbS17lGGwWnA17LNI08niV6Q38Si/q19twS2wKxt0OPxg/UiG/PKImUTgOcMvRUVOkNT2FkCIKEqjFhZwBsRUe6U+MeXSgKpdIIBri/+8bOHTtFXeQNWfV9qhLAOh/HYxGkBoR5X7ytkrxwpXt6knPzH96tcNXcI7MLob880/1wXMOiLZVIOTT90fdLDJFwNq2FobhPS2lhAQ/1x1sTKytmIPQTdn7bL7Z18DOAiMrrYOVmZEF8EqVWszQLv/3I+4pI6v45itfPS4EuOPuxZxuNfr3Yje+mev8aGcYDfKpBADHpy12bjldMDCvHOGYG2OfrA0V1HOen76DdoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB5PR08MB10021.eurprd08.prod.outlook.com (2603:10a6:10:48e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 13:54:05 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 13:54:05 +0000
Message-ID: <f7541793-40f6-4140-92c9-79073e7b253b@virtuozzo.com>
Date: Tue, 16 Jan 2024 14:54:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] parallels: Add parallels_mark_unused() helper
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-6-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-6-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB5PR08MB10021:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ffb7ed-869a-4d43-8e5d-08dc169a9a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhjvjI64DRra9YIs8WsQ6HwdvGWl3TT4iNdLcquU8p9pooLCGR8g7ZK6HaNh8ymdQByEcFYdfViCM/VOdTN3kPDRTed9NtIwcGG91BIslUvPNfjdUSX51IgBOvhcT5fCyE+FJ6kJ/f99lo58FctMXEcdExWpq+mvsMNowR8WLXISTk0q5CMa+zFIr/GZACXy1VGhDQmyn2uEEQXpfctHI4ynbBobXqVap4azZGrOJkuVhy7fznko2gZydS3fpaY353BmGrniog88QYcLQgYxUTJU/9B21wmhpP+OWK68NMGp3CKZGD++CDQP1byyN008oGMHLl9a27B3Yv1uIjRM+SaCwkh86agXfuYi8Mo+4U23FnZ0aS1zQt2BMXtPXyFp9vCh24iI+AYzE3UdQk4yfEdFaUQOrXkvYjCA3k6Vow43IJ11bslcisQubcJKY/w17Z5/NZjnaWgP0XPMxrNb3H5bjJwIPupUqqxtrfeGUNZgMMcKFa49hIKdnMY7yRtP/0bLdvQyuzPrAl9YLnMCUbnfa6ORmvg8jJL7R1CViNtW5X4nxm9eARtUJqcrbl/2LMAsUqLfX6Kwr2UkcpHlMG8LXZGHVlKghFDOH3WgzP6pY+5gTKqRMO1/lP5qehWOs0wUUKw0KaLV140EB4Mzrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6506007)(26005)(53546011)(2616005)(6512007)(31696002)(86362001)(36756003)(38100700002)(2906002)(41300700001)(4326008)(83380400001)(6486002)(8676002)(5660300002)(8936002)(478600001)(66946007)(66476007)(66556008)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxDanNnN2lxOWQ2VTlyMk9nS05xNTBrL0JKY3ZOMmx4a2ZEQTR5MFFYQlUw?=
 =?utf-8?B?RDRVT3RXR1IyMzBIQnNBUHpGZlNzVXc2eVpnYUk5a3VaUHovRFBXQXU4eHY5?=
 =?utf-8?B?NVJiaCtRYU5mR1JzakY5elgvWW1haHhNam9iQjVQZ3JLMjgrbExLcjg4czhJ?=
 =?utf-8?B?L3dZQ05JSGJYbXk0bWFLSC9XcTU3STRsN0NXU2dqL3k1Q2E4anNlbS83ZmRC?=
 =?utf-8?B?bjZxS1lma2ZXbmg5WXlGK0xVRm9ob0duK0owUHNoZXp6dDUxMVR1RDgzMkdY?=
 =?utf-8?B?MkRRVVVjQjVWWmtlT1JKS0YwZGs5TjZrc0RiUkxqcWs4bTJNYkhUK0NCdVBh?=
 =?utf-8?B?MFRORWtoOEc3eW5vMXdPZ2oxcndyYWtSd3Bqc2oyZkY0NnNDVFBCWGh6UFVS?=
 =?utf-8?B?Tm4rYmMyUEhmT0JpaTVoNjZUUlIwSWtOcnF0YUlRUk52cERJUVpFUVVpYUlU?=
 =?utf-8?B?Uitic2dmM3hFNi9jZ1FDNEVLbkQyTi8ydjQvRkx4RU9lOUdLY1VqeE5OQngy?=
 =?utf-8?B?NExMTzhiV1FSM2xoaWx2VmhOZndYMWxkRytXZ0ppV3B6Qmh4bTIyNE1vQ05Y?=
 =?utf-8?B?UHBNZ3NWUkZZQ25TTU9KTGhhS3B2UG40VEl5VExkNFlubmpYQ0F6UWtwVmhs?=
 =?utf-8?B?QWxJWGRzSTEzS1pKdGJoNzdMMmZDZDhaeURwVzY5dndHbnhzQjY2UFVOTEgr?=
 =?utf-8?B?bStEeVhxRDVxOW5UR2lEUTY0MngvQjQvMFV4ZXRhM1g3YTFZR200QngxSlhB?=
 =?utf-8?B?dk5KV29kT3lLWnRqZldUbktsb0tzL3hwd0czUTFiMnZuV0xxemJ6NDNodWFQ?=
 =?utf-8?B?ei9uZFpCdjU4WTdIWStkeW4vUm1TaUN5Rm9jdG1zTDRaUGJrYVloZjBDUkx0?=
 =?utf-8?B?aHM0UWM3U2VKT0RueWZYamswbnl2U3JTWW9TaVQ2RENFcjQ3SStkMzZ0NkdV?=
 =?utf-8?B?VW1zVXFVU3IzU0E5MzY3SDVudkRSWHBtbzRpRllXRFcxcDlmcURNb2M4TkFx?=
 =?utf-8?B?ZWFRVDNkY1M1YytLejlOYUdBZTJHMEo0NVJWUHFXSm5ldnNTM0RYU1FsQ0ZJ?=
 =?utf-8?B?WW8yNUVoUEdYU2t2YmdqdkVLS0E4a1ZXT0FJMWIvQUEwblAzTjlDUjBGTXZp?=
 =?utf-8?B?R3dHMXRxUmt1a24va1Y4RU1HMjdOSWx3dmxnaGR2YXVZY3F1cG92c25KT2ZE?=
 =?utf-8?B?VGNNeGlneE0wQ291OVlDd29sZnpKZDNFem5PWll0aEN2RlBEL1BmMlhqVjRV?=
 =?utf-8?B?Y2tiYjlwZldSaHpud0xhODZrZWtabHBjTjlKU2hrVFBPbCtoejhGMmFLSXRh?=
 =?utf-8?B?bWwrbkdobmswamhQb3BMNnJ4NkYrY2xjSzZlZXppMlJpWWtkWFIzT1ZQbWVZ?=
 =?utf-8?B?U1FmVitiRTZ2V3h5b3pPTWU5VkhzajM5bmhMcFo5Y3hmcXdDTFJLMVlkQ0FF?=
 =?utf-8?B?cEI3bmhlaXo4S2hYN0dIcEI1UDczZHhJV3NURUlnVloxOVc4UzdFbnoyb0xo?=
 =?utf-8?B?ajdZeXJmZlgrR1dwOWkwNE1HNnRad3VGZG9NVGR0Kzd5MWprZFBDUVZiaFpQ?=
 =?utf-8?B?OU5JK0dBTmswVnVuL2s5RWVYcm5GUk1sWWNxdWFJQmNHQldFaWZxRHJ1RlRP?=
 =?utf-8?B?WnVQOGtzbjk2ZEpzUWl0THpBMC9ZR0tScGNZUlYxNjRkbkg5ZG05SS91YUlR?=
 =?utf-8?B?QmFaaHNSNWRiSUJuM1lRZ0l1VWxqVDVOMEN6bVV5T3VUdVRuV2trV0tLM2d5?=
 =?utf-8?B?dFpaNURRRWJQTGhya0xYeE1KazVBSnkwYU9jZDltZG9nK0MyZEFITUd2V3lJ?=
 =?utf-8?B?VmRpcVpFZmh4MTZ5TmxGM2JsUUw4N3BWL29qVSt0bzI5UFVQcGoxaWFmNHps?=
 =?utf-8?B?dU55L2xRUlFzNHlaTENGVmRpeUdaY21FU3doWlNaSDRaWXRZZ3VSLzJnbEJX?=
 =?utf-8?B?dEhGL1g1cnN6VTVBVDV1RlowV3BIRWJ5YU1teWxmL2tMRTVUQ3h0QktHUlB6?=
 =?utf-8?B?aFZxK1Q4YUNUWWZaSTlneHgwYStDUTQ0SHR4WWlYRUpZZ0tOcUlpVjNUMWt1?=
 =?utf-8?B?UStSbnRnOGlkeG0zNmVoc0lZUVoybFY0QjIvdnhiQy91YXpBNUZXMTk0b0k4?=
 =?utf-8?Q?TSfjR8A6nDdCp+7qAUnbmsk+4?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ffb7ed-869a-4d43-8e5d-08dc169a9a77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:54:05.3219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z9mc4rFS6Ig7I50ze/eco/izIg77CjLquJ4zBuB0FdKzN7111VhqIlMjcH3QEeViRsKPf9Ak4bnD7vQsDcn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10021
Received-SPF: pass client-ip=2a01:111:f400:fe02::718;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
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
> Add a helper to set unused areas in the used bitmap.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 18 ++++++++++++++++++
>   block/parallels.h |  2 ++
>   2 files changed, 20 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 4470519656..13726fb3d5 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -196,6 +196,24 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>       return 0;
>   }
>   
> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> +                          uint32_t bitmap_size, int64_t off, uint32_t count)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
> +    unsigned long next_unused;
> +    cluster_end = cluster_index + count;
> +    if (cluster_end > bitmap_size) {
> +        return -E2BIG;
> +    }
> +    next_unused = find_next_zero_bit(bitmap, cluster_end, cluster_index);
> +    if (next_unused < cluster_end) {
> +        return -EINVAL;
> +    }
> +    bitmap_clear(bitmap, cluster_index, count);
> +    return 0;
> +}
> +
>   /*
>    * Collect used bitmap. The image can contain errors, we should fill the
>    * bitmap anyway, as much as we can. This information will be used for
> diff --git a/block/parallels.h b/block/parallels.h
> index 68077416b1..02b857b4a4 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -92,6 +92,8 @@ typedef struct BDRVParallelsState {
>   
>   int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>                           uint32_t bitmap_size, int64_t off, uint32_t count);
> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> +                          uint32_t bitmap_size, int64_t off, uint32_t count);
>   
>   int GRAPH_RDLOCK
>   parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
Reviewed-by: Denis V. Lunev <den@openvz.org>

