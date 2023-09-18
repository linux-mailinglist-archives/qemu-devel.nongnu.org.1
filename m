Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C37A4A86
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiE6N-0006A8-2s; Mon, 18 Sep 2023 09:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE60-000648-T3; Mon, 18 Sep 2023 09:15:30 -0400
Received: from mail-vi1eur04on072c.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72c]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiE5y-0000je-PO; Mon, 18 Sep 2023 09:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZF1db/ElGRBfui1KqPBeMjNyQpbFIbMP0LKajQBSvPFWoL39YIAhUt7qLYX1o+zPaWwvmCWwN9ZGI50MgiOYMoUvRSoH5PvAOUAfN43FNPk297KI+KI9DdDQsf7eJOKUWY4/vLfIRPXRR/VJbTTtdvG9z1Hz1KbKHWA8Zz1LJA/tsPDaitw8B7aDVoRENmtAbHEtr1YKjsNp0sgL/OrZO34KBVedJGRDA89y9Ov3PUSsbdfGdnpsRYn2JuzR4KFkSlmXDCFynCRCUIjTaUhYfUByQAKUNOJbiGE8vgqB6Z9mi8Jo6IV0bjLu5LD7TVwN1gOerFspsTDEBRl2AS1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dldCrIrMt9zNuMAQmMGc0OxVfofiRX1CiQtfA/9xjio=;
 b=J/BPCA5cu9TjGFwsAGLaWuMbiDw0woumjt+t2hCa/kIZCc9SwB6RqchE7hx7mluFehJk2XLraIglf/vjyO9LRUlJo/zPbk5HfscQDBEXcqWSPdtFLeOJfyGMV7VdbDaNkgHvBLIEoVwiyYwTdCJA5XcpFN6pwMulF/tf55dxEoNrf1i2iajWWvrF68YLrLRSQtEY6k3q+mWa6HFyUGV/IsLQtrSkmYg71X3te735doegVnHVy/bsvNakeapFoPjxqL+RQCoVgWMFZ2bCYMNwkh65/szevCDzmfzwYleswEYB5+4lTbbY7vHxLRzf+i15EtAqkXD4YTGG+SoHtF9KOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dldCrIrMt9zNuMAQmMGc0OxVfofiRX1CiQtfA/9xjio=;
 b=NuG2PrKzq0xGjwx20ftLAJSiCWWk1h9Nr8B6fpME9EcL06ZPbFUJFJkqSQ/WEtv1nc6beAs4jJV62k92BSfwGDbZmObCxM+B4AOgtx5amlVntVaXDVXyF0zNbA9ZxhhBPrrCaW4lZHJYqaOqlaJ2CXmvM8Kk0EMXijyQRfje7RTFgCcijaDk1BLdQDnskPn4U7kHW5UI5UsDfKjybdgBlI/V/xDTV7El5DicOJzKZ8LEbK6PDH1M5a3rbFr4gCbSArUNXwuGSxyH+m7P1RC13c6264ZZaUN4uH18Sh2mSZPBtV/Z3Ubx5GLosVPoDlxOf+KRY39fJZ4ZyoiGHxDgJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6735.eurprd08.prod.outlook.com (2603:10a6:102:138::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 13:15:19 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:15:18 +0000
Message-ID: <0853ba01-e9f5-78ad-7bee-cf086b130dfa@virtuozzo.com>
Date: Mon, 18 Sep 2023 15:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 17/21] parallels: improve readability of allocate_clusters
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-20-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-20-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::17) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea52367-2c9e-445d-2877-08dbb8494e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2YxZE6Xzm/JB+I6UK2rG4D4mvTR9Ou8UkzmqVXdzgux5XWANY3nFFqlVeXnAQb267OQIZmIkefqA4q5PnbFDTgjh1gNejdMIpNsukuFMkninXEq70VQAA2nFoiTjLa4EjyPGU3+wocI+XNhY2IYKcRiY5Ft0PlQ/dcraOimmw/MDkWqHuzTdln6SRpz15Exzs311LMwRi9k2/9ftp15TMbuz8Mj59rgBdCkJOWQyCfC6w25MoP+Bbu/A+2GASZrr0z8rBRvYCfNSi/EU4vb+AWW6IUva5TZeA6jVXHach0sd98nE9jaC3TNyCRWKuzGBrNBHmLT6lvJsummujFMk4aMpLITIYYkiszmanxgpLAKe1N2n9jLtOalFXfEOy7RfjCFd9g09xUbT1KBkByLnUokoENKxwsjTpA59I7Xvfds2lF9ZlAvKirwPz62U/XrdQ37hOOU5YO/MOItlFqwTq/o3qJ1qgRKEMt4jG7KyGH2qxsJcMVFJkc51dpQBMQQsRWlqhAk046eo4WDqAMq2XKMgwAvuJdQejcxYcamiLToBsrfsrSXmjLIFv0lq4s8DLUqYaZXzDP/oNXooosKvgkDuTJ2wORDi9IHUY+DY9WkKrnwC2EmFh+plHkJkCqZQ54jKfv5JCwbubU34vZoVZoIl8PGWS3olfm00JEt3AhQB/5GuABodiV/Bwgmq6qD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39850400004)(451199024)(1800799009)(186009)(66946007)(66476007)(66556008)(53546011)(52116002)(44832011)(6486002)(6506007)(41300700001)(6666004)(316002)(6512007)(478600001)(31686004)(4326008)(8676002)(8936002)(2616005)(26005)(5660300002)(38350700002)(38100700002)(36756003)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQvVVpiZGVlMmh5UExvRkwzTDNrSlBxOFgyOGtqOXVNMjNHYWNGdGJwMEo1?=
 =?utf-8?B?WVpFYVNhSmhZcmtPV0Mrb0UwVGJvNEZLbVd3aDNxeXBPS1JNcGZoZExnVVVM?=
 =?utf-8?B?dzVmcXNOYVRSK3NubGxiejJYSU5OS3ZpOStIVUtVSkRwYTM5SmZlcG84SUln?=
 =?utf-8?B?ZUVCc3FpRzRkS01ybjdSemZETDV1eDdSbENESGdndkU0YW1TUzR6RGlmclBR?=
 =?utf-8?B?UlhPR1FwYitiMkFSYklCYnpMTlNnMG03YzYrb3B3dmdnZXV2d1kvZFY1UGVl?=
 =?utf-8?B?N1pQeHpWYWdNbXhBOTlqenFndkhybkJMdGs4dGlRc2h6Y2dCajVleS9ZU1NV?=
 =?utf-8?B?eldlY0NNNDZ5ZjdGMXYvQlFqUXpEWFduVFFwTERLbENPQlI5Mml3S096NTlZ?=
 =?utf-8?B?dlI4M2xXVy9Ya0FTaGpUNW9haEFIYlU3eXQwdkp6QXl5ZlVsZnlyMUFtaGlv?=
 =?utf-8?B?RU1nc2ZKUmdVYlQxZ3pJWkVPdWNzVTAwSzRveGt2bEo2RDIzVkJ0VHhYWFR3?=
 =?utf-8?B?UFFlQWxoaDVqRjdxV1NObXlyQnlOOVNrMmUzcy9FQUV3WFJxWUtERXZ3RkVh?=
 =?utf-8?B?bENWNzFoWHlZQzFCWDEvYUlxajFPS1drZ2s4WmswMEtHTjJjT1FJeitDYUJR?=
 =?utf-8?B?Q2hLcW8wbDdEQ2VUU0xGZmNKd2pqSXVMZTdDY1dDS3Y2Mzc4UldsMW4vblF3?=
 =?utf-8?B?Yk1SbFZFVnZibkZGeEkxQ245RW9STityNXAxbXhIY3hPc2t6TTd0RGhoZmh3?=
 =?utf-8?B?ZGR3UDRnZWZXaFlCenVaeGVEZkU0WTlLTDJyazJ1M3dGQWJUbmYxSHFsOTV0?=
 =?utf-8?B?azBNcFVkN3pmcE1Ga1p5UHRHU1pZdTNEU0ttblZhYXNSUkpHaER5RXlqWExQ?=
 =?utf-8?B?ZlNoUjNZY05UbjlmTHJLc3MxdU5PbjBEYmFzYjFRYmRYRmc2OTg2MXB3b3NT?=
 =?utf-8?B?MnZJNjdxclVSWWsveEVpQkEwTDljc1lRRjVidVNRa2Z4YTU1YVYvZG5tWFJ6?=
 =?utf-8?B?OHJNVnRscGhrWm9MYlZrWVNIR0UvZC80QllkMnRKRldzaW50MTJVM3ZpbmNZ?=
 =?utf-8?B?NFB1aTY5WmZPU2sxSnl2WWd3cHBKb0FlQ283TkpVNEl4TUMvNlhCWG9hTFFx?=
 =?utf-8?B?QXhUL0ZCcC95RENVbWJPVW1sWSs1TE1BYk44RFVmUnhTSm9ab3BQQVBFKzVO?=
 =?utf-8?B?bWxWSklqNWVlYmdpTnRSd1hGT3VpekF4N1V3ZEMzUVE1T2hPWVdsd2tUNElW?=
 =?utf-8?B?bkZBSFBoVm5kNVhaZVBuNzV5ZWRpZS9pSHd6dkE1MDFwUDA4Y0NBTWIzOU1j?=
 =?utf-8?B?bHZjbjBwdlpNenFDMXNCMGd2NStsZ3l2UFlZemtsc1g0b1BiZHdMRFJ6M2xl?=
 =?utf-8?B?aEc4V3lDdC9EdE0xc3FLSmF1Znd3blJpUVZLTWw4NTdXZS9yV0wrbEUwWStE?=
 =?utf-8?B?TnRnQUR0UzJBTjk0OENvdnhKc2J3TlMxWW1JL2hEQzFwWWx5MWlaMVM5ZExl?=
 =?utf-8?B?TEN5eHhLVzlFVit2dWZoaXJHRGRWa3lSSllXek13VDVrc2pBMFZBdUdkbVRU?=
 =?utf-8?B?bWgvSHc3ZU1pbnNxUk5YV2tlUGNJOEl4ZWdWYzE3YWFRZFN0QVRXbDB5N0s4?=
 =?utf-8?B?eStYNVAyUU0vNjZRMVhpVEpMNzFmRkkreHhvcU1IOExKMmVVK0VFTGdKUDFB?=
 =?utf-8?B?YTA3TXIxL2ExelJVUElqZG9HRml4aWdKNGNYRTlFaDBwVTY3dnRDTThRSFNv?=
 =?utf-8?B?ZHg4c0xhSnFXTEVEZHZYczJYNjdDTVc3NjM1K0Y3TmNOQkRwN0R3NjE4dUt1?=
 =?utf-8?B?Tm92WWxQTjRnMlRGUFA3UnRmcENyOUFvZzlPam1SSWRmQ3JVQXVoOUFzamxx?=
 =?utf-8?B?NGNMTXNDUVZLdmRlb0RQMlNqOURQak1NaVpXNHZScGNuVUx4dm5GdTdXQVVh?=
 =?utf-8?B?d04vTG1Ja2NFdzI3KzFkemcrblhVbWlCSWZGTjRHellXLzM5QzZoTk1QWSts?=
 =?utf-8?B?dml2S3k0ei9SaVVZUEU3TG5PSm1ueW8wSmM2OHNUdzEzMHIwMWJhcmtJSHZv?=
 =?utf-8?B?dk5sQnhwYWRxcFlralhPMTVIRERFakQzdzQyZ3Exa01RQkVZbWdYZlQ0Zm1H?=
 =?utf-8?B?ek1JcmlXdVlEWjl3SVdIRlRWbnFEdVQ4TmV1ODJqWGJ4SFVSZzZHcGN2aURQ?=
 =?utf-8?Q?Jnc7Wt4BkUYtCUVn1g3xxMM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea52367-2c9e-445d-2877-08dbb8494e48
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:15:18.9496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+eZn8S6If8+iPMaBgXG/a6bQEhDexax49/r1T0PcsRI6qiAIn++q/Yj8sGLosnlcC8WDbGPqyVM3mb1WQded/3MarKfhB5PpjaSayQ6e5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6735
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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
> Replace 'space' representing the amount of data to preallocate with
> 'bytes'.
>
> Rationale:
> * 'space' at each place is converted to bytes
> * the unit is more close to the variable name
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 2efa578e21..76aedfd7c4 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -279,7 +279,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>       first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>       if (first_free == s->used_bmap_size) {
>           uint32_t new_usedsize;
> -        int64_t space = to_allocate * s->tracks + s->prealloc_size;
> +        int64_t bytes = to_allocate * s->cluster_size;
> +        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
>   
>           host_off = s->data_end * BDRV_SECTOR_SIZE;
>   
> @@ -289,8 +290,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>            * force the safer-but-slower fallocate.
>            */
>           if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
> -            ret = bdrv_co_truncate(bs->file,
> -                                   (s->data_end + space) << BDRV_SECTOR_BITS,
> +            ret = bdrv_co_truncate(bs->file, host_off + bytes,
>                                      false, PREALLOC_MODE_OFF,
>                                      BDRV_REQ_ZERO_WRITE, NULL);
>               if (ret == -ENOTSUP) {
> @@ -298,16 +298,13 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>               }
>           }
>           if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
> -            ret = bdrv_co_pwrite_zeroes(bs->file,
> -                                        s->data_end << BDRV_SECTOR_BITS,
> -                                        space << BDRV_SECTOR_BITS, 0);
> +            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
>           }
>           if (ret < 0) {
>               return ret;
>           }
>   
> -        new_usedsize = s->used_bmap_size +
> -                       (space << BDRV_SECTOR_BITS) / s->cluster_size;
> +        new_usedsize = s->used_bmap_size + bytes / s->cluster_size;
>           s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>                                             new_usedsize);
>           s->used_bmap_size = new_usedsize;

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

