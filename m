Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E37DB564
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:46:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxNtU-0006wv-W4; Mon, 30 Oct 2023 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNtT-0006wa-8i; Mon, 30 Oct 2023 04:45:07 -0400
Received: from mail-he1eur04on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::720]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNtR-0005hb-2a; Mon, 30 Oct 2023 04:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzGrdDAgSmXEXHkGF7qYxgXMrQnARB1QEXCqoiun1JCv0tPWfYmKGWyyI1QReVBQTfBv8hg8zvbrEBPvuaF6PfJ/HWInmmkIIZ27xIkhsbg8jt/GNvM2GwNWiI6L67VKKsMoEum2Ubb4aLH8lCchV+MFrH6Kq3EFOXLGwHNreGlKzw03BEaiMkoubDVk52AKMNFK0fILZko/CojeGGsUbjFH5hGj/KRMUQtJG/2JVcOHxrXWy7kN7kE945QmUnOPvPxNLa/MFoQER2zdweB8Cml/0vdLnwkPVwLH6GjK82f6mb0f1SWESd8hSbL60nKrZrbZQEhG74RUjwRXBCYRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxIyRotWwUTqOMV1pTlttpI1o/58N4jkcGvzyTXpwOs=;
 b=mPbZBqXBCVX4UiQ++SUlmY58hXXWveo8IouRhYuwJjEo9ZQA8OhAXu8DXQTI5KxB7njUhaeAf981dwa+rQc4D7xljNERRlR6DBYeThB9hY+83kdv3H8PL9wwakSNysatYliS+wMQ8ubeU6iC24cexJqQmwgzKFF/6v/EwshdC47CRqU0EbfIam6D9HP7rSPQ4p2/KQXeiaJUkIPNt3S/TEqJYD5h+1FXM0kgLh9b9tIXShg5X7uXbikCNxjbSO/VnRoQEtwJJESFD3AYx9rVjodvwuCH5UBa3Pycqq8QMpHaWh6PgTJoEvpEdHC9kZDrfq64E5ZBYqBbeUuhbO35dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxIyRotWwUTqOMV1pTlttpI1o/58N4jkcGvzyTXpwOs=;
 b=g/7fsBvbsqdHjpUG/xMrzn8fzshLkM9fxpn31fwH9ETwNNdBZ87RKTjX0SE5La+Zn3nMheCV8HRsmdTcKR/uptgr3C7MtPYtFQv/yzKh+QjU7ajcycNbepDMRmqLha0KD/uvjkoYfDEcwp8JRlB6W2uhOo0Y3U0ILB4TsubWU0TlUV5wFbEY4Mpoz7Ut9Hy2Y9svnVxQHBBPFXVWg139UxsIdRUdrHI/DLidCxivlpcpOLS2TdP+dPX51cQJyDH6PFEZHLUYg/w8B35eqA10MNpY4zdmBnAKAUIEKKojc5Wnl1ETIT9l6S/nq+u/PzferCGZJ83D7FKpk8eFVDhCBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB9538.eurprd08.prod.outlook.com (2603:10a6:10:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 08:44:59 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 08:44:58 +0000
Message-ID: <5b35a3ad-ec23-47a5-8500-de62f996d1ba@virtuozzo.com>
Date: Mon, 30 Oct 2023 09:44:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/21] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-2-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231027074636.430139-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:803:64::29) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: a64e810e-5b37-4b4b-ede8-08dbd9247fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNPB1Q2qbSyp2MVKrJwAoZfFprK5q59CAnJxy+8dtIYoi5LeHZ9z6Iun9/D5/NlAMtOeLzE9SVIcJ+LjFUBBLjQPQMuYPIOcktoTAO76BDADwyNBra5Td4uvQGett6ZCV7TBaLxSZ6dMNTlMCRZSUko7ZuzABhxDxjRTS5Xf53meTH60deoUpiQFzms7LLmQAakR1/fHn3ZlVWiQc0d/jI0Q5GvJ8gPAgq3oMBt/9Z0AeBf5m1ennig0ShrMoB3vUv/dkY+Dp6uWCxdohTb0UuyERU2rUAUQwTg4tgVeA5djxm3i8ktqabJkmO7PXczMBw/Nv1oMOep88A5JFOoY6lzvmjWDmfMN0mVya1SbKDcdETIbYIBj8uHZn8+BXuqW0BY3lHeygR7Ucmp8U7Rm60TMARzCNOn8iPZZxX6OJPTUU982UTASzcnRTv6IUgYtSU5LGDLuXPvEHhw+i6etiKHxAhKdbavlr/ddCFkZ0e+rRKsseOYAibwRVbBxVcdhnc2XLSQL+q0N4BsJOFPcv9eFgKiCGwuOUm+N9W8xLbJLGbKowgj0b0GamHy4il3Gk7JHsuI/g9rWRYT1kmr6FgAT0TXsfioaZWnZgLSg6+l0InREl7ek4b+J0M7Mm5JIdABCLtVmRBriI7wWEAibxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39840400004)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(4744005)(66556008)(66946007)(66476007)(316002)(38100700002)(6506007)(53546011)(26005)(6512007)(6486002)(478600001)(83380400001)(2616005)(41300700001)(5660300002)(8936002)(8676002)(4326008)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkphWm1sNnlOZWFMSWFha3Z3U2tRNzMvQk5nVWpVVXpnR3psREdNblRONVhp?=
 =?utf-8?B?T2p0WCtLaUlVMFlPRVlHbHM2VUJpSEkyR1BVUnhUYlc3ZDZDU2prditzM09y?=
 =?utf-8?B?ZUFCaEw4cFB4dkduNmJSaWgySUdQT0V6Vmp5bjV6azFXbXowenFEV3dHMEpL?=
 =?utf-8?B?cjZXb2tJTk9zRXVjWVNNYmdvY3B4SEh3eGRQeXdGaDBaZHdDVERDVDJNREdw?=
 =?utf-8?B?cjk4bDJRai8rSTlSRjdHZ2NER0xzaVlKNVY3R2RzUFcxVUdxRGExMEt3N2M2?=
 =?utf-8?B?ZC84UFRkR3ppaTFWa1cxQklDQlhpR0FaK2VYM1BjRHBqMm1HdTVrbTZEWkFK?=
 =?utf-8?B?ekNJbWNQams3djRSL3N3a0RHN05WRnFYK1M3dkQ3T21DRUZkbTkzS2F6VDBm?=
 =?utf-8?B?ajFOVEdMZG15TU05MGZFVVZhUVFVNEtDcnVvZ0V6L2s5eFNiN3lFN1RHNGFv?=
 =?utf-8?B?bW04ZzFiNi9maWRJZWpKK3B6MS85bUd1R21LYmp4RU5mR2xYbTNjMUxHZXgr?=
 =?utf-8?B?NmljaTZiU1p0R2I4SWxWU25lRDRMbUluZUZWTzQxQjdiYVhhQVQzbVIrOWNa?=
 =?utf-8?B?aUhFK2VROGEvTFI3REVYdEtCbnorRFZHWEdZTUhNNExWZ0lUUVk2Zjd3MCtj?=
 =?utf-8?B?eTRkdG5YazZ0dG5hMjVjaWwyM1VudWFyTGQyOWpIa0M0d01rSEsrRmJPUWln?=
 =?utf-8?B?YkRtV01rc1E5N1NSTnFlZVI0a2pLampha1lpd1BYTlZ1YXcwd0duYVF5YU5n?=
 =?utf-8?B?K1dMc1hucDhUN2l0L05QOUFTUG1vSnRxOXNlT0tXVFNZK0JwU240TzJ0cTJ3?=
 =?utf-8?B?SEtwV3NvOHlhaDFkamZQQ3B3SkR0OTVCSjJQbVROWVlwTDFWT3dueTF0ZHlF?=
 =?utf-8?B?RW05SHNSd0JHNlY3dUdFVC9wV0FycHNBYXRXZzUvVkN2d0N5dTM0eVBVa21u?=
 =?utf-8?B?NVR4R0tzUlZWK2pQVGpPbG44Wm1pVTlKSE8xYWpjeEtsQTFyZzdhME1rUUtX?=
 =?utf-8?B?T1BLV0RnZnkzSnVJN1d3NklETjdpcDd3R1BsQ0oyc2dxVnNuTWFOanVPTVgr?=
 =?utf-8?B?Y1FVYTRlMDJxQnRvWGNGY25TaE4zL2dwRzJvRzF0TC95aTFMbTJPY05XbnV2?=
 =?utf-8?B?RFc1M1JjM3h6YUM5bmorc2YxaVZXSE1NTm5mMDVMakt2b2crbUZlaXFGUjAx?=
 =?utf-8?B?OU1PSEJuMytHT0VzdTFkVmNoS2p5VnFLaFp5STFOK3JQaUxIS25WYXFDM2Jh?=
 =?utf-8?B?YnlQNllOWlBLZ2hkQnV4RXhQNVg0NXVrVloxa0NwQXhHaUlxbFNOc1FaRUJY?=
 =?utf-8?B?Mkc0dDMrN0R3QjVnMHoyRnNjQWJpWU03NEJuMk1JenkyakxiWHJtVzlvRzcy?=
 =?utf-8?B?YzVwWG10MG9KelNUZDR2eDk2TFBESW02cWIreEpETTFkZ0dvZkRQZyt1d1lh?=
 =?utf-8?B?ZWhEeVNmdjVTbENOZFVDbkViWnM2bWMyNmNsREJkWVBWdERDRTBqcjZ4Y3V3?=
 =?utf-8?B?WkhScVJwVHhjdllaWWxHMkRlZ0c4NFhtSklGNDBjV3dYb05qTEU0MkREcS9J?=
 =?utf-8?B?N2dnN001QXJjbXkrNVBETEp4RHZ2SGNLRjZteFhvN0RaU0JHb3lKNVEwSzIx?=
 =?utf-8?B?MUptWGlPZVNXazAvTDRERWltVDVidHdEQmorenlISkZPeVMrRzViRGExSnRP?=
 =?utf-8?B?d2lwV2piN3FPUC9wTWZQUUwwaU44VXRoYUR5bUlJK1lVdDN5TXdUVjFGajVI?=
 =?utf-8?B?L2lXODZQTVUyazVsS3BOQ2ZrbjNKL1R2bTc5ekEzK29JeG5iOUJxSGs3VUky?=
 =?utf-8?B?aEpXU2psaTRvRm5rZTc0SmVpeU01RDJDbk1yMk0vd0dPOGI2bTdNL21ER25K?=
 =?utf-8?B?TFZZaU8vNWZYeE1JOHZaSzl3VnBrZXBwSVhWajdPWDMzTkxEUmZaV3VRVHlL?=
 =?utf-8?B?RWVBL3lUUXhDbC8ycEt5WEtwbDVlK2RnNThwbkdIcG1lU2hmUmlWZXdsaytI?=
 =?utf-8?B?ZkkxNWNrbENESXVwMU9uMVg0TFRpZllkUGxTazRJei8wT1RwQXFOMVpqUytD?=
 =?utf-8?B?cHR1ZG0vS2UrSHdhc2lHN2NPVTJnNU9sc1Q3SUZ3TzU2SmdES3ZqUHZkSG43?=
 =?utf-8?Q?y5pURhAvFjYF0+Ier9PnaVIth?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64e810e-5b37-4b4b-ede8-08dbd9247fa7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:44:58.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+Zy1R/RmnbVmxbydMbe5M1kEm/25YVjdR66sc6ozyuppwBoSPe4ntay3i9dVXsCr5HYPfSqxfm7sojcLder8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9538
Received-SPF: pass client-ip=2a01:111:f400:fe0d::720;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

On 10/27/23 09:46, Alexander Ivanov wrote:
> After used bitmap freeng s->used_bmap points to the freed memory. If we try
> to free used bitmap one more time it leads to double free error.
>
> Set s->used_bmap to NULL to exclude double free error.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 1d695ce7fb..01a61a4ebd 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>       BDRVParallelsState *s = bs->opaque;
>       s->used_bmap_size = 0;
>       g_free(s->used_bmap);
> +    s->used_bmap = NULL;
>   }
>   
>   static int64_t coroutine_fn GRAPH_RDLOCK
Reviewed-by: Denis V. Lunev <den@openvz.org>

