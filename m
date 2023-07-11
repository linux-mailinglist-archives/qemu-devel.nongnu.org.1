Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8274F68B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGnr-0004t2-9J; Tue, 11 Jul 2023 13:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGno-0004rN-Mv; Tue, 11 Jul 2023 13:05:28 -0400
Received: from mail-db3eur04on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::702]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGnl-0002M2-Hq; Tue, 11 Jul 2023 13:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPU7azb2rcaXXoxRq26ALt7OU8jcApE1n6KyjUbNEGzZo4KykMWVaRb0Z5VLdrV0x7ew8h9Ye/xMwVESLrfKITu04MgFFjzEGvgX57SRDEhX3G7nmhLCk7RcLwnV4n7WNZxWykis1/DWlAOtru/8u8cNBMmFFgN6jF5BxgfVShzQz7NEKOGc941mK6l4wxBHzF6WQwlz9tAbyKoGDfCirmywUfV1tXOGwA3vRRCcRXdFAbBHqleHBLqvK+EedeRU2zxaVmpXAwQrAc+hjhc/Z7ZPuCG80nMg54wYas1ZiJULM6TQTinYj1f8a533HTXm6wClvCnJFK6iu0ZDhf3Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSOfdxLZb/CP+2rFTFDNnGtMa9O3ARZ5dnStsQcoRgQ=;
 b=ZAsIfeK7MThCpwo0Tdnj0qQirrrb7gDMuQXCZI7x7vbBAnZyGQDBPs/qyI9v8jAJXenO3S963PfmA6YgQpI0pYaax5KDoeL/llrmOHMD/Z7f4OrEZZERbtD5EgHFAO0p2tSpI9TkAC8lFkf9LieUsL4momDI5sbxjP/j/VBZ27s107GnLtlvsRB6OqeXNK0eFP8Y/7K7AtPxkWk1fyJOLdXSbsQabA5TOCPldUX6gVMX3X+xah/6AHIVVUwET+pEV4H36bmmN1igRY2DG8DIK4UfmoxxoeMTMVsggJz+9b4PCybmj0XlEI5TF/aWOY5UytFkK99lVWfgiFlwXDQgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSOfdxLZb/CP+2rFTFDNnGtMa9O3ARZ5dnStsQcoRgQ=;
 b=Wx8863MtTSvDDNzQaMHdkuRgNbJQYJ2dgLYO4cRvAtGxroJiaoiVeEeQhX+MnTK3N3oSJNum5R4nK6nugBiUsc/Ss6BgWLR86HdFYIdndYU98OVT3Q1pXXlZO0Of3FZM2xkACPNOYTXN+HanujwOUwnERh9fxmLN0uQXg44Eov1eVmX0g82qdYhLLwg2CmAotEAwZ2myOqyiR20/5myjQGm7bnfnQk5YLzAqS2+cryJGFfnXMkmF/1zS64Qm+IxN4yoBJGPAszYLVBeBB2V4ohkWHC3fsuEMZa8T7jwfyBoetkCweZr9phpayJWv/O81Rn+QDdGrb7rT8U/Fw1RRmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM9PR08MB6147.eurprd08.prod.outlook.com (2603:10a6:20b:2da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:05:19 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:05:19 +0000
Message-ID: <cf240abb-2a40-259a-e6f3-2e4ef69c2d25@virtuozzo.com>
Date: Tue, 11 Jul 2023 19:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] block/io: align requests to subcluster_size
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-3-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230626160834.696680-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM9PR08MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb3e2ee-0475-498e-e308-08db82310170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+MYqLvzjadrlnJJVUNpPg0eptQRJnxGtjbD8oZ9/gSgczlfDiHP0oD9hhPvWuHXCeGu+L19DJDn43PkwLbhd4VrBw/gV/kS94TnQXiwlnEOlyOQr8OyuR5+c7Xldl++27N5BUxCW2auYLVpKWOFwKqLSN1PhaHOZUMPByQGKVKc+3qABUkbWbJS1Oci7UT1l4g41k2/jsLLNuy6NSCVhzHc1evmRDEkrb7Z3+HU7nNvTWMKO9w+rlBz3kBzAcbd1LWZ8PHUUka5v0/uNA8L+DAU3j1ITGu9h23GStzhFHpimYDjunjuEgxq61JViVpKn1krNAILeqgpLyyYPnRcmemX02aoYM6qMgFQrK1Sk8jD3DkKZVitJ7avdwsDF71zfhRpufLndiSbj3Ol3190b/b4M2rMzpIODhhBswdBq8Wj7BPod9eS39ogfNLA2R03SU5UEc/gXgoTI2ga4jRAqA89VIwpd8y5DCKS4CFNlvKfVRKtsMm4IPsgNMj2Pr5QIeLubeWx1XaGrQOQvCt9Ys2MVXYYfiqL87lFMBne1FOWFdXDKmsU5xeiSlSrrk0PGw8207OG1bU3c/Qj3Z8+9NlzpRtiYz16TZU22gvQFJ5NcEd37G5J8t9W6T9swxPnPupg0dlWBM24KtBbO+yx3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(451199021)(2616005)(2906002)(83380400001)(36756003)(31696002)(86362001)(38100700002)(41300700001)(4326008)(6486002)(6512007)(316002)(5660300002)(8676002)(8936002)(478600001)(66946007)(6666004)(66476007)(31686004)(66556008)(186003)(6506007)(53546011)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFKL2NicEI3QVgyTGMzcHhBZlFOK1l6T2xMVnI2QkhnaFdEdnNldUE2UWpw?=
 =?utf-8?B?TDB4WnFMOFUyQ1BWTzNsMlBUVG1zSU9QNE9hRTA1a2M2SS9jYjV5ODhEVEdS?=
 =?utf-8?B?QUlPbFZReDRHN0hxZDkrUjhiSFF3dnB2aEhtNFFQMHpuOFF6OStqZGM2UEx1?=
 =?utf-8?B?bHNoTDJXTmVXM1h2cWoyTzUySzNnU29VajBSSkRoR1lDMjRITzB1eXZCNEpx?=
 =?utf-8?B?MkErR0lJWXlobGp2UnhZaW9CUVdJdnJOeG1ablVmbG4yRVJtLzg0L2JwVlE0?=
 =?utf-8?B?ckRTYW9oc2pOek9Qb0c3ZVp5aHlyWG5uMTQ4YTVCbzFJNG5GODdPbXhkVE5X?=
 =?utf-8?B?ODVWMlF6TkxVOE9VaGJLM0paZ1MvN0Y5Y3JTZ2dKUEZpVUhEQVA3YWRaa1BW?=
 =?utf-8?B?RXYrLzJVZlFRbmgramwwcEZqOXVuaHlCL2pXUk5oKytzM21ubm4wbTFnRmRj?=
 =?utf-8?B?eU02Y2x2K1ZkVU5DMU1SRjhLWXFyT0hHamJYU21lVWZrZ3Z6K0ZIRm9zYUFQ?=
 =?utf-8?B?QzF5bGMvbGFmZ3lmc1QzRUlPbnhWYnBpcU13aVV1UWpYOWQvVEs5RkcvQW1O?=
 =?utf-8?B?bE5uK0hCelZMaGRmcDhtTktnSk0wUlFXS0Nnbk51NEQ3YnlLV2RoOXBOUFJI?=
 =?utf-8?B?ODdvVU5Eb2Q1R0xZUkdvenA1QzVwekZuOHJkT055UG9od1RDdjdjeE1ZcHF5?=
 =?utf-8?B?ZE5weVk0WmlHY3E0elliV01wWFYvYnBHT1QyTlZqdHl4WlVUQzltcnU0QTBt?=
 =?utf-8?B?cmlTdm1UZDdLWEhkUzNwVURwVlZaYnRpNHVpT1dhVS9BZ0JvRG9WT2dsYzF0?=
 =?utf-8?B?UVZqaGpMVU9aQWUzNFJXQWFMeW0vbndSdGVZS0p5TkdQSjVuWEQ2VlJDMnNM?=
 =?utf-8?B?R1BRc25Gd1ZHV01YYmlHcUQ4UDRqcHJrdmhmQThwRFNmMUxJWUd4Ryt1dUll?=
 =?utf-8?B?VG9aQ1pkdmZRbkRJOTFOSkdrdnVzVTVyNzE5bXRWV3Z0K0RLUHdLSmRPNmpm?=
 =?utf-8?B?QWRxWUU2aHVKMmk2aXhtZ1pSQkYyWDRnYmQ3WVRXSkZOR0JKd0txb1kvM0ha?=
 =?utf-8?B?OGRCRmFvSzNEbVJXVVQ3aHc4M1JYbVVrMDVKU3BBREZZZEZGRDNGdnhSTVBi?=
 =?utf-8?B?eXllQWRhTDJER1ZvVy9aME5UNDBkYm5FdVJWRTlKSnpMN21WOFNiREQyMlpR?=
 =?utf-8?B?QXcwRnlOV0RBV2YyTS8zMGMvdHdjVmdBRGlFOGswa09rUU1hdExnYzhnYTJI?=
 =?utf-8?B?eGFnZmh6ZEEyY2tZWThHdWlnUlArQkYrTU9TcTdzdm5iN1FLVmNMaTU0c0Mw?=
 =?utf-8?B?TW5rdE9MWUsrMmZzQjhBeHNLNmNFV2dXTFMvejhDV3JKZ2lxUWE2ZlVkMTR0?=
 =?utf-8?B?OFRZcUs3RGNuQ0liYkNWTTRQdTkvTWVyaVBMektZM2ZaWFBpdVhCbVNwQURR?=
 =?utf-8?B?Zk9YYWxBUExoNlZSUlhFOWxiQlZsRGtPeEd4ajk4UHlhUS80WWo0alJ0aVhn?=
 =?utf-8?B?YlRWM1ZNVk1uYTBhTWhLcTJiZlF3Z2YzL2lTVlhWa2x1T1N5VHZTUUlPTzAv?=
 =?utf-8?B?R1hzMXc0OHpuVGdWYVFiZDcvU3FxeGlIWjlpMGJUY2dCOXl5V09GODZUWnVR?=
 =?utf-8?B?WmF4ZWV0REdvNlZoaXZVK0hhNTBZUTNPSHl0T29TOVBpZGwvemtkYWpNMmRq?=
 =?utf-8?B?NHJody94dmZYOTJZU2JqV0xmZWRXZnZWalJoenJsemtiZnl6dmJFR3c2M1dZ?=
 =?utf-8?B?OFMzL0xQa0p3RHJuRlE0bWxtTlRZeFJoNWV1L0hHU09hS0dnT3dSS2ZvVlEy?=
 =?utf-8?B?cWhXZnUwcmJZVnoxQUlldklxYUVQWEs1WXdNVE5DeVMzTjc4cEdqN3dRMUg0?=
 =?utf-8?B?YTNRZk5iSHlKTWpianJNclJaWFZueWkrcTl4WEZqWEw2TVVCZGpZbnFxcFpW?=
 =?utf-8?B?d1ErZXFHbFdhdG1TanVoN2xNUTZBRlVVc0NROW1rSlNCRlFvcFF2L050SFpS?=
 =?utf-8?B?SWJZUk1oby9aN0x6VEVNL3QweGxweDNhVTd4TzhFanlWRnkxM25JVG02RVZ0?=
 =?utf-8?B?ODQ4S2w3Nm5XY29KMXVtM1RHeEtKV3UvNTU2SWRrYWR4SWZYbkF2SGdXbTJi?=
 =?utf-8?Q?OixGmZ/tQR/9ebm+U2zRLCIIb?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3e2ee-0475-498e-e308-08db82310170
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:05:19.3292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWmTLbgETeqSd8rqkWoDu2xJpHSSbwd2HyL/L7F1lLohOoVVRQ8PVzoU0Y2xa85F/Y+5JDw3LHAWZWNx3/N17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6147
Received-SPF: pass client-ip=2a01:111:f400:fe0c::702;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 18:08, Andrey Drobyshev wrote:
> When target image is using subclusters, and we align the request during
> copy-on-read, it makes sense to align to subcluster_size rather than
> cluster_size.  Otherwise we end up with unnecessary allocations.
>
> This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
> and utilizes subcluster_size field of BlockDriverInfo to make necessary
> alignments.  It affects copy-on-read as well as mirror job (which is
> using bdrv_round_to_clusters()).
>
> This change also fixes the following bug with failing assert (covered by
> the test in the subsequent commit):
>
> qemu-img create -f qcow2 base.qcow2 64K
> qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
> qemu-io -c "write -P 0xaa 0 2K" img.qcow2
> qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2
>
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/io.c               | 50 ++++++++++++++++++++--------------------
>   block/mirror.c           |  8 +++----
>   include/block/block-io.h |  2 +-
>   3 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index 30748f0b59..f1f8fad409 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -728,21 +728,21 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
>   }
>   
>   /**
> - * Round a region to cluster boundaries
> + * Round a region to subcluster (if supported) or cluster boundaries
>    */
>   void coroutine_fn GRAPH_RDLOCK
> -bdrv_round_to_clusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
> -                       int64_t *cluster_offset, int64_t *cluster_bytes)
> +bdrv_round_to_subclusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
> +                          int64_t *align_offset, int64_t *align_bytes)
>   {
>       BlockDriverInfo bdi;
>       IO_CODE();
> -    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.cluster_size == 0) {
> -        *cluster_offset = offset;
> -        *cluster_bytes = bytes;
> +    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.subcluster_size == 0) {
> +        *align_offset = offset;
> +        *align_bytes = bytes;
>       } else {
> -        int64_t c = bdi.cluster_size;
> -        *cluster_offset = QEMU_ALIGN_DOWN(offset, c);
> -        *cluster_bytes = QEMU_ALIGN_UP(offset - *cluster_offset + bytes, c);
> +        int64_t c = bdi.subcluster_size;
> +        *align_offset = QEMU_ALIGN_DOWN(offset, c);
> +        *align_bytes = QEMU_ALIGN_UP(offset - *align_offset + bytes, c);
>       }
>   }
>   
> @@ -1168,8 +1168,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>       void *bounce_buffer = NULL;
>   
>       BlockDriver *drv = bs->drv;
> -    int64_t cluster_offset;
> -    int64_t cluster_bytes;
> +    int64_t align_offset;
> +    int64_t align_bytes;
>       int64_t skip_bytes;
>       int ret;
>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
> @@ -1203,28 +1203,28 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>        * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
>        * is one reason we loop rather than doing it all at once.
>        */
> -    bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
> -    skip_bytes = offset - cluster_offset;
> +    bdrv_round_to_subclusters(bs, offset, bytes, &align_offset, &align_bytes);
> +    skip_bytes = offset - align_offset;
>   
>       trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
> -                                   cluster_offset, cluster_bytes);
> +                                   align_offset, align_bytes);
>   
> -    while (cluster_bytes) {
> +    while (align_bytes) {
>           int64_t pnum;
>   
>           if (skip_write) {
>               ret = 1; /* "already allocated", so nothing will be copied */
> -            pnum = MIN(cluster_bytes, max_transfer);
> +            pnum = MIN(align_bytes, max_transfer);
>           } else {
> -            ret = bdrv_is_allocated(bs, cluster_offset,
> -                                    MIN(cluster_bytes, max_transfer), &pnum);
> +            ret = bdrv_is_allocated(bs, align_offset,
> +                                    MIN(align_bytes, max_transfer), &pnum);
>               if (ret < 0) {
>                   /*
>                    * Safe to treat errors in querying allocation as if
>                    * unallocated; we'll probably fail again soon on the
>                    * read, but at least that will set a decent errno.
>                    */
> -                pnum = MIN(cluster_bytes, max_transfer);
> +                pnum = MIN(align_bytes, max_transfer);
>               }
>   
>               /* Stop at EOF if the image ends in the middle of the cluster */
> @@ -1242,7 +1242,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>               /* Must copy-on-read; use the bounce buffer */
>               pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
>               if (!bounce_buffer) {
> -                int64_t max_we_need = MAX(pnum, cluster_bytes - pnum);
> +                int64_t max_we_need = MAX(pnum, align_bytes - pnum);
>                   int64_t max_allowed = MIN(max_transfer, MAX_BOUNCE_BUFFER);
>                   int64_t bounce_buffer_len = MIN(max_we_need, max_allowed);
>   
> @@ -1254,7 +1254,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>               }
>               qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
>   
> -            ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
> +            ret = bdrv_driver_preadv(bs, align_offset, pnum,
>                                        &local_qiov, 0, 0);
>               if (ret < 0) {
>                   goto err;
> @@ -1266,13 +1266,13 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>                   /* FIXME: Should we (perhaps conditionally) be setting
>                    * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
>                    * that still correctly reads as zero? */
> -                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum,
> +                ret = bdrv_co_do_pwrite_zeroes(bs, align_offset, pnum,
>                                                  BDRV_REQ_WRITE_UNCHANGED);
>               } else {
>                   /* This does not change the data on the disk, it is not
>                    * necessary to flush even in cache=writethrough mode.
>                    */
> -                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
> +                ret = bdrv_driver_pwritev(bs, align_offset, pnum,
>                                             &local_qiov, 0,
>                                             BDRV_REQ_WRITE_UNCHANGED);
>               }
> @@ -1301,8 +1301,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
>               }
>           }
>   
> -        cluster_offset += pnum;
> -        cluster_bytes -= pnum;
> +        align_offset += pnum;
> +        align_bytes -= pnum;
>           progress += pnum - skip_bytes;
>           skip_bytes = 0;
>       }
> diff --git a/block/mirror.c b/block/mirror.c
> index d3cacd1708..e213a892db 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -283,8 +283,8 @@ static int coroutine_fn mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
>       need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
>                             s->cow_bitmap);
>       if (need_cow) {
> -        bdrv_round_to_clusters(blk_bs(s->target), *offset, *bytes,
> -                               &align_offset, &align_bytes);
> +        bdrv_round_to_subclusters(blk_bs(s->target), *offset, *bytes,
> +                                  &align_offset, &align_bytes);
>       }
>   
>       if (align_bytes > max_bytes) {
> @@ -576,8 +576,8 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
>               int64_t target_offset;
>               int64_t target_bytes;
>               WITH_GRAPH_RDLOCK_GUARD() {
> -                bdrv_round_to_clusters(blk_bs(s->target), offset, io_bytes,
> -                                       &target_offset, &target_bytes);
> +                bdrv_round_to_subclusters(blk_bs(s->target), offset, io_bytes,
> +                                          &target_offset, &target_bytes);
>               }
>               if (target_offset == offset &&
>                   target_bytes == io_bytes) {
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index 43af816d75..1311bec5e2 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -189,7 +189,7 @@ bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
>   ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
>                                             Error **errp);
>   BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
> -void bdrv_round_to_clusters(BlockDriverState *bs,
> +void bdrv_round_to_subclusters(BlockDriverState *bs,
>                               int64_t offset, int64_t bytes,
>                               int64_t *cluster_offset,
>                               int64_t *cluster_bytes);
Reviewed-by: Denis V. Lunev <den@openvz.org>

