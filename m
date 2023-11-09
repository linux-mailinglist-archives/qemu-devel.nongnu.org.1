Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198A7E6CD9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16aY-00032H-2y; Thu, 09 Nov 2023 10:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r16Zw-0002b2-UV; Thu, 09 Nov 2023 10:04:22 -0500
Received: from mail-am6eur05on20708.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::708]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r16Zo-0005Rj-83; Thu, 09 Nov 2023 10:04:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boJgqsLNqDnbusNGefs3aA4VV0QA5AUFrzeIpolSGspHUc5IN3WArx+3tmS73Cigj1D1sybx0hAY4QRm+0+5FyLf/Auy5F4yd7VwLQbW7YjndHQk8mndmpCmXsmgnOW/7vWpYyD/f1FrabHbe9xhUiHfyMDSscj/inyV9nq3ecCbyY+cpySMjk655sjAF4OVsYQH+WXclmBxPz7vMWMKa/yN6Pz9b2545dIUgkbQtzSi2nwMZ9LVHx89YhmQujU0O1Mg6z/H/E506LaNrgMQcQ95qO11i0pDHj/wDnDtuhV9LV/4cO+fYzNHJPxMgsfBzq0/tB9F0iXLo/TXxFDfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/0C0PBCofv9GvWDVKf6rSy8CbItcu33Nft4EmzrntA=;
 b=Hh3WgSYcii1n0QVtUkdb9M3xM7BiGTs+wn5kMRt/hLG1EOiJ3hSsQ2gL4VoJ6Z0oCwF08Dda3IxjdcFFXAjZ5T7xWZzVg3QsdJ8AafrwG83+UZEnGTnm89KpI9SzC1c/KlQWbn3CoV7AvZhmzbdrvhBED2rKrwmzDHvAt89+SqyX94tVazXKwQvuxyaVx6SaP2Qu4aFRfWZRW/nX9tfW9iVyDlFE8rTl6eFf2d3V4gOm+yd3X49EH+UDusi6wh+XtLwMoibLmKtng/Glh/n49Fwlv8DnswzPIHrbGYCXQXfFR3z2eotuULCd8vYGt+E774mMo/Tjn+ukYNdjt6ZZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/0C0PBCofv9GvWDVKf6rSy8CbItcu33Nft4EmzrntA=;
 b=SaS/o073BY3RKm1vhwkda1/V4nkbjc/h2x8ovAaKAQMfnJx0ihxVVIimCPkQZ5+z0LH1J27fXg6VL1N4cVZZOXjKV2urIxUD6nXPeUxkLXjKsoZawneddKKqzoGwyraGXlLG4oo5u00jwe88oNERkbSJzuKaAgnMDNf78sKS4AAM6/EvK/YKjvXCc6RUoV32N5sDHocin31nMnGGV07Ab2BKoOOTRNCZ6ExfDpJU8yom//bk0CInyHaLUkpHJmZC1nUBSsGszHKGXLnEao+Z/spv3Wrf0HZrB8y+lz1w18j+BdqoYFzEv23/oqceQVoV8xG55mdJu9bpfXC0+hRTgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5650.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 15:04:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 15:04:04 +0000
Message-ID: <33411116-4c77-4a90-965c-a05c12e75d69@virtuozzo.com>
Date: Thu, 9 Nov 2023 17:05:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
 <8a85f4f5-35fb-4fbb-98c6-c1f2b9f11a8a@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <8a85f4f5-35fb-4fbb-98c6-c1f2b9f11a8a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d296f40-9047-445c-684b-08dbe1351d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbY62QtONs52F1Q+n7RZWMI1H0dgCdvVNtxq51FklEFw6Cl/ILT36Sm46TsCbTqYhqvg8WmgnamLbyzsc5uG3zCAf3D4yfbY8mvGH2LjvVzFBp5U0QLap/U3uKi/too2+hxf9wPOgnHJLjjX4wB9FVVE3Oy3lC/rcKNAKzazzfN8g0dkhr2Lm7BQI8VKOAEn0TCDaAsESiwfkOtmTdeJ0q2I8QjEiJRhpKSWK1sdUJwun3aL8X4X6vsS6mjc5pybwo78UAuozCn1UBMuEygRkyXxZaofK784xnZ5PdbRForvZXYxqdzRj1APNNQb+msI3nGFNtsq9Zc5NZ0F7OW8jbiJSMInO9D2XKoMo6dBh6qsZmT00tFohQ4duvI82aMZBTwHoRcLc8fGX5g8yUAZldMlkZL8Y19zQ2iCyW4BfM+6eOzmevMonCPCfBqftHYq6C0GwOEPTa/RgBHTf8gSu5bYjGLsAg8RarEo355sa0LWi2Oc7E7BbpcYopvPSy4mSQohOIhJHZ0azjJT/Iyc7D/nnttsvI3H6ovB7z1NxoHcwWMP7tuYiGTUXV47q8pSdfNqgL8MBahllRCrs+K3pUE9tROmlSpl3qvR0s0PonJd9a2HDF4ZDSp/DsiLO9dNOaNzjn7gYpEvPsOQ0axggg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(83380400001)(8936002)(4326008)(8676002)(6512007)(55236004)(6486002)(2616005)(31686004)(53546011)(6666004)(26005)(44832011)(478600001)(316002)(66946007)(66556008)(66476007)(107886003)(5660300002)(38100700002)(41300700001)(2906002)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJ5UWoycWVtUUtYaDVycTlhVmpHODJKR1gwT3dRRnRYc0Y0VXlZbWNIMXc5?=
 =?utf-8?B?YnJjV0FYZ2lsSld3bGQyNVN2K2k1VEZXTVphUi9tT0Mzai91UEI1S1dKWWgw?=
 =?utf-8?B?eVFYK3NKT3Rwd05Jc0RYVUNINEZMa2hwMTNweVJwZmYwVXpoQnc4TDdXM1Jj?=
 =?utf-8?B?Uy8zQmhkelhvckFkZWhIakN1QVh3N3ZmWm5vRU1qcEQrSTVCVU9QTkZBVjBF?=
 =?utf-8?B?dHlqOE5TZDd5TmZJWG1NZUVkVTdUWHZFd1V6Sm16YjdYQXpTeTB2eGQ1L0c4?=
 =?utf-8?B?QlpkTlVVM3luOTRtanZBTklFanhWRnREWER6VFNsVndFbTB2YlEzeGoxS2Vw?=
 =?utf-8?B?MjRCNVFENjQvSzc2Q1RMSERtclBBcXYvbi9peTNPaEQ2S014QXJTNHYxbXNi?=
 =?utf-8?B?c0FuTlBzYUhSbUd3R1paK2lQVjVyMTZ2YlQ3NlUyL0Ftd0U3dVBScnk2MThl?=
 =?utf-8?B?SHorMUNvSEp5RDJPYnc2bkZSNlFnR1RGSDVLTTVNQ3FSZytrOFFVSmJ2VlNM?=
 =?utf-8?B?NE5RaGJVYmE4VG9saCs4eWRHMFY5KzJTaVZlcVdRRW1LeU5zSjdHeGl2cjkv?=
 =?utf-8?B?YmdMMTJCd25ka2QwME5wM25iWDFwUDZoSytXaUNaY1dVRkZndm0zeUFuaERo?=
 =?utf-8?B?NXVZeEhqNi9tNWdOdnBDemxyUWhZYTZOZW5VU0pPaFlhamorQXRlanNzTjhl?=
 =?utf-8?B?NUxLVXF3SzByMGJFVjdscVQvSGVQOVZhWUVZeS96MSt5S2l5WlN6V2Z0dFZD?=
 =?utf-8?B?bjdSaTgwdHVVR1JNYmFKNEIyU3ZpeXdUV04rWE5pdVlIWnRyWmlpR2ZOL2FE?=
 =?utf-8?B?c0VmUUUxSHVNNVdMdnFXWnVwY3ArT1pYVUJJZ1BvUW1MbnIzTkVSSjh3SXpo?=
 =?utf-8?B?c3EzRGJGNy80TzhRT1FwYkFFcE9BV0pZUUhNcmJnUDVWQmdidjN2WlltM0lu?=
 =?utf-8?B?YTM3enpBaFJyOUtmRHhCMENNTjh0UTE4bjRZWVpoSC83UXJJKy9VcmcvVkhr?=
 =?utf-8?B?citsb0hxaDRHTDlycTdoNjEwVUM4WVo1VGh4bWcxMnFuUHJOSk8rdVlFVVhk?=
 =?utf-8?B?Y01KZmhhb2Rld3pxTmNxdU9rQzRnNTB1QUNuaFBmcGFBWTVBNERhSlJGSTYy?=
 =?utf-8?B?V1V4YzZUM0FnVHR5N0lLQys2VExjMTNiekVhUmNCcU5KOXdKYjAwUStFTmRo?=
 =?utf-8?B?YjJXZlREOFFtRDFvVEFvbHMvSVFadG1pODJLcDZzcnRTR1M4NHhNdWVOeU5a?=
 =?utf-8?B?UmRGa0NiUTk1UVFJWmpFRWtMNDltWTdNa05OYU5CaXBQUmwzV1VWT3NrOHQ0?=
 =?utf-8?B?alBQVUp1VW5CaS9rV1hMeWUzR3QzQXoxMFVpOGVIY2QwbVFDRG5weGNyeHpX?=
 =?utf-8?B?TUNTMVBXalNzOGlFYk5nQkJjNGlXYWdkcGhRMG5FcjdLQ1hJUjdvT05ZRjNs?=
 =?utf-8?B?TXNtUTF6NysyR2xQUzRoTlZ3eFFUSi80dFBib1pIUWd4Z3NSZFZPV2hWcUZu?=
 =?utf-8?B?QURyUzFkOHh6RmpZVXpBTW5QZm9mR2dUUGI5cHVneVJ2eG4vSEZZTEwycXRO?=
 =?utf-8?B?OUdTY0JvQTBYV0ZPdEk1VW9BeWxLeHV5c2J4dmNQaVVuclBUMTVDaDZFVHhS?=
 =?utf-8?B?S3VMYUdOcW1vV3g4b1p4THQ3OGVXWHlwWHFyUldmTktLVk4wRjJ6NndYQ2lk?=
 =?utf-8?B?K1crNDJKanFaa3Y0cmIrdU9RbEJGcFZ4dUltemY0M2dlZTdNOTF1dFdiNkJU?=
 =?utf-8?B?cFZWdXJTOE93Qzd3Nlh6TjZkaS9CY1JvN21zMzdBY1p0a01KLzBwMi9LS01z?=
 =?utf-8?B?MmF3NDNtbU1NdjJ0d1hBbVFyUjJ3emJ3eFhUdldxSGtZODI1emlNVFlab3Yw?=
 =?utf-8?B?QWFUTUJVaXBlWHVrNzloaE83bjFuUkJuQk5yUWJMdmNMcTdLOVIyTGNJdGJn?=
 =?utf-8?B?WFdFUEdPSXhkVnFwK0F4N2Q2ek85VzFaOGhVZjJaVWg1TlFkTENKSFVtRk05?=
 =?utf-8?B?bVFkKzBBRytOL1lvYnFKM0tkYjgzcFJKWjFQNjVnOXpXQjJMSU9VRU5EMkhR?=
 =?utf-8?B?Z3Jnd0l2UWxrTWFTb1RKNy9vRVR4Y09hU29jejNCbnJnL0N3N0t1MEtxTmMw?=
 =?utf-8?B?dE14S2FOeFpoVFJ4cHN2aHFwczhSa2VoMzdLZzZOQ01zUFh3Y29IUW5SSWpa?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d296f40-9047-445c-684b-08dbe1351d4e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:04:04.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8ZeZZbLNYqvuwmW1q33yc2ws3r7ghtF3hcfGVBrvciwKmtzZoJNnLQ6B814uKyGQrvO7ZaRn4yun+7G2fCv2ZGQxkxknwRV7cJ1/OO1l8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5650
Received-SPF: pass client-ip=2a01:111:f400:7e1b::708;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 10/31/23 18:32, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> This commit makes the discard operation work on the subcluster level
>> rather than cluster level.  It introduces discard_l2_subclusters()
>> function and makes use of it in qcow2 discard implementation, much like
>> it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
>> changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
>> way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
>> operation and free host disk space.
>>
>> This feature will let us gain additional disk space on guest
>> TRIM/discard requests, especially when using large enough clusters
>> (1M, 2M) with subclusters enabled.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/qcow2-cluster.c | 100 ++++++++++++++++++++++++++++++++++++++++--
>>   block/qcow2.c         |   8 ++--
>>   2 files changed, 101 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 7c6fa5524c..cf40f2dc12 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
> 
> [...]
> 
>> +    if (scri.l2_bitmap != new_l2_bitmap) {
>> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
>> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
>> +    }
>> +
>> +    if (s->discard_passthrough[type]) {
>> +        qcow2_queue_discard(bs, (scri.l2_entry & L2E_OFFSET_MASK) +
>> +                            offset_into_cluster(s, offset),
>> +                            nb_subclusters * s->subcluster_size);
> 
> Are we sure that the cluster is allocated, i.e. that scri.l2_entry &
> L2E_OFFSET_MASK != 0?
> 

I think it must be illegal to mark the entire cluster as unallocated and
yet mark some of the subclusters as allocated.  So in the case you
describe we should detect it earlier in the '!(new_l2_bitmap &
QCOW_L2_BITMAP_ALL_ALLOC)' condition and fall back to discard_in_l2_slice().

> As a side note, I guess discard_in_l2_slice() should also use
> qcow2_queue_discard() instead of bdrv_pdiscard() then.
> 

Yes, looks like it.  I'll  make it a separate patch then.

>> +    }
>> +
>> +    ret = 0;
>> +out:
>> +    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
>> +
>> +    return ret;
>> +}
>> +
>>   int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>>                             uint64_t bytes, enum qcow2_discard_type type,
>>                             bool full_discard)
>> @@ -2049,19 +2117,36 @@ int qcow2_cluster_discard(BlockDriverState
>> *bs, uint64_t offset,
>>       BDRVQcow2State *s = bs->opaque;
>>       uint64_t end_offset = offset + bytes;
>>       uint64_t nb_clusters;
>> +    unsigned head, tail;
>>       int64_t cleared;
>>       int ret;
>>         /* Caller must pass aligned values, except at image end */
>> -    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>> -    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
>> +    assert(QEMU_IS_ALIGNED(offset, s->subcluster_size));
>> +    assert(QEMU_IS_ALIGNED(end_offset, s->subcluster_size) ||
>>              end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
>>   -    nb_clusters = size_to_clusters(s, bytes);
>> +    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
>> +    offset += head;
>> +
>> +    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
>> +           end_offset - MAX(offset, start_of_cluster(s, end_offset));
>> +    end_offset -= tail;
>>         s->cache_discards = true;
>>   +    if (head) {
>> +        ret = discard_l2_subclusters(bs, offset - head,
>> +                                     size_to_subclusters(s, head), type,
>> +                                     full_discard, NULL);
>> +        if (ret < 0) {
>> +            goto fail;
>> +        }
>> +    }
>> +
>>       /* Each L2 slice is handled by its own loop iteration */
>> +    nb_clusters = size_to_clusters(s, end_offset - offset);
>> +
>>       while (nb_clusters > 0) {
> 
> I think the comment should stay attached to the `while`.
> 

Agreed.

> Hanna
> 
>>           cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
>>                                         full_discard);
> 


