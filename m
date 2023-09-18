Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99E7A488B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCYN-0002X6-JV; Mon, 18 Sep 2023 07:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCYK-0002WU-N3; Mon, 18 Sep 2023 07:36:32 -0400
Received: from mail-db8eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCYI-0002SU-0Z; Mon, 18 Sep 2023 07:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UojT+ELtWTfDHsRIWCkVmJbJpKIdtLJphoir54CpWZCnPxKaD8Wxt1sf8/AEOwRQdgSwjnexiyQHTkynZ6IS7HKmHl5kSUb3cVMkAro/LRS7okBmLtNDbh6SCDx2hQi1LBXdB06aIdBbotlQyLET6VkTMsHmedaUDbNFUq03WQRCB989aR2TXIPjoxI4uXEveNiAUmeIpSFvEeRsU3Q3lXWM0XbyiMULt+v3MiONPmyZ4CDEOzH7q+LSjZYOiJK7VCedEIXkKOwJz9OrDY/53WsGSlfRF0prqKJpQGOkRkPWQSbRKEOQgTyfOw2GfAnKJYoRD0uhGhFJo9rVF5FRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrVdrFrBg7GEMb0gjouVk+N0UqP6IqGJCdumaT1TGCM=;
 b=hVXp23JVGovmKkRX7Lh92mY7VR6mi9rfuGrk7FUard2E6GR5xq2L4doXXCY3Nl/tvL/uGAJwX5ETtGGe9u6RX2XqyPyrn/7nHX0ETCGKQDne6NRIEgXEQrRUmo60YfRYFQnpd/VV3sbYrODOpFStNJVFWh/zHy16Ahl7QMHCQaWUF0yBP2iMwWMdRnnfWI7KG3Q/LJuD8OKnpX3QiuRPu1ot4ewLr+YN/ad1YxnlZ7cwvpW3Oo566pNqNJFZ2QWMRffUCAMA99794pUENZNg2r9AmkdWvvg4ulJeMwFy/eGBAYNaEwI7hP/D2gzpUdZOMs1M+dzDxoZPBWfdCThdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrVdrFrBg7GEMb0gjouVk+N0UqP6IqGJCdumaT1TGCM=;
 b=M2R4r9wXuYpiggUy3VNuiD6CXTWDQYsQK9BxjdVAaNbjQi6SMnr5nHpc4n5S+PhjpvKW2q7gpEN0f1xMfjSTBK0PaauKsv/fHwn9XZC8FBNHpN/mpgeE+xdGDE1Jb9lG4F1r7BpsEdATeTENmEsbwYzDOSiTbgBW8yuF3ljRMnleSM3xUWW1NYDQ/fmNNvEaA3zh/WAbv/ibs+j9wOUbYsUQ7I02wqe0udvc9bSNHTjdi2X87LcHmJnmAON45QYooltfJurGQuRQdIyh63rDfvNfbkNtspH2+0Id1NFzfp+FBEHWi5uh3lzYqBEPP6RbDQVpVcYddaQSfLa70uQAew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AM8PR08MB5666.eurprd08.prod.outlook.com (2603:10a6:20b:1de::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:36:25 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:36:25 +0000
Message-ID: <f8375b26-4a02-04ca-0172-4f12a5837a75@virtuozzo.com>
Date: Mon, 18 Sep 2023 13:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/21] parallels: collect bitmap of used clusters at open
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-13-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-13-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::45) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AM8PR08MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4e626f-b23e-4a85-9558-08dbb83b7da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAMMPKySTTpuFtA7bDD8lfXtxhdQqYPxeNSNODMeP00yTiOPeO72IdiMDccKxboxr9BZmnebzU0U2LPU92ybIcdjZ5GWw21NNrsFVspW/cPr1U1wzotS9iMKxztbOXgeViCIMwPlxN845kzd13U6DFtTu8AB6mIxHL/um6QNVrayHZGX6q0A6BwF8WQH2bfuGt0dartP957qJhuUnnhR8V0E6+wNnz7GlBYcazgsks6rpQx4PMxIgAI0ik2g+OJc5RrkHGVtCRJRaSgqYujeTPeud4yQc6VMSgZ8cYEMKJY3FbHrJlbKiKE+uQrZrqKZgLBtHgcDeSibWIX4zJtdeeFz0sRw03smkah1TLW7iItMjWG6sPPAFgSfbpRW1Im2TvpuaBmXKoeSGbq2ni+RU/p6mDqsXyawDE4NDryrKqQDCOSBRfWMBQoYgSIyptCrCT9f+GV43zt3gOZiBAPuiwy9wIgY7UwW93anPGb05GqV1cxHJG0OOzCElEO4O+aEGqkGHxerlYZY1AV13eRQ32OFdMv7MLrLNWlg8/xqmdHgDu2lHRa43OR7tOiKyIRuC5lFXNB+qJGcPDly8tHSDf4l+8yLMirDaYHIVeExe1js87fDop7vuftMrHi51wREPGIVb4JzgvOTJeStFmDHYXQzj5aaijByVdaH8J5YnhAs5wHwvW9cFMiMxgyc9ajQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39850400004)(186009)(1800799009)(451199024)(2906002)(83380400001)(38350700002)(38100700002)(53546011)(52116002)(6506007)(6666004)(6512007)(6486002)(478600001)(5660300002)(4326008)(316002)(8936002)(44832011)(8676002)(66946007)(66556008)(66476007)(2616005)(41300700001)(26005)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtjNkx4Q0FmQjhGL1RadEgvYUIxT2YzV1hrMGhXNmwrL3U0VnAwSCtxU21i?=
 =?utf-8?B?bFJ0NU9yc2VOVlFpZW02V0VYRzBtcFZMaGxLbnBiYmcvUTFiQVd5all3MXpP?=
 =?utf-8?B?SmEyUnY0QklwZ25RMnRNUFNTU3h5OTg5Lyt3VGo1ZTJMUENZWWJhQXUwd2Ew?=
 =?utf-8?B?Y2YyU0owL3E4N1pJREQzTmRaQjVwcmJMMDhOZ0hQZERyS0t0K3VrNUxJTUt0?=
 =?utf-8?B?ZDJoNW5PRFBmNldtb29wUit5dFVIbURTUXNaMklBV0V4d3VTMnhQNDVIT29L?=
 =?utf-8?B?T1p0QjNpUXA2ME1jdG1aeFVSYXg3dm1UNUxEaktRdGZuVUV5aUVtTHhWc0lF?=
 =?utf-8?B?enFOWnQzdGIvN2R1cWhTZSt0aVpyQjRoSzlWYmM5MmFpTy81cFNzR3V2MDBR?=
 =?utf-8?B?OTZwUEhOV1J5dFNEemZtWWJsRkNPc1g5ZVRuRThNRDZoUlA4SHBsdUNubzJF?=
 =?utf-8?B?Yy9SZSsvZUsveVVZQjBuS3RTZmNuTSs3V1pNalZ0UXJsYWV0L1IrZlQ3YzZy?=
 =?utf-8?B?VS9mVG5yY3huRzBqN1E3OHhITVVOZXpmZnI1OEdiNzFIaWUzRlB3d05OeXh3?=
 =?utf-8?B?N1hRUlk5TzlyOEVXTndmbm11WERLS1JITkV6Z1o2T05Nc0tob0J0UHo3OEl3?=
 =?utf-8?B?VTNrVkZMUFh3a1p1ekJyRkVYWUpTLzd2WmFMSkd0S1VnSmc4WjQrMGdGVG9a?=
 =?utf-8?B?bWJHUmVTbkJkdk9SNXd0VUtQQW9aZHVGZ1hhK2hPUS9XMVJjbUlWVUUxNERh?=
 =?utf-8?B?WnJjbFd5a2tSZmRRbVhDVHZNbEhueE9KQWhaQW9FQmI2Z1p1a0VFeUxIUks4?=
 =?utf-8?B?UzhYdkx2L1N6OE1HWWFqWHZzSzhuVDB6R0pheWQxRjVSa0ZGU2d1emwrRzRz?=
 =?utf-8?B?YTRXeFBSZytWb0dkakpjQWF3Tk1FQjFlUDFWSmZ2OVZwNGgxZzFxd1JmSmFH?=
 =?utf-8?B?UnljWHZwTDNqaGRVcTl1UVU1YXVmU2dOUmtxVVE0SytZbmxYbGFscWxuVDFM?=
 =?utf-8?B?cjRFYm9tREhlazBYdFBwMzhmcEJwa1d4MDUrZVBIeUJOeVVMalRsMVBBYk42?=
 =?utf-8?B?QlJHaStTQzhhdXU2R04vd3VNOTRmTXdjLzBuNHM5aDkrdTRIaUl6RGtXZGd0?=
 =?utf-8?B?d01jRnErV2x5b3VIenhiUDhHK0E1SWpVclN5dXQvZG8xVmpBNVQ0aFdtNVZ4?=
 =?utf-8?B?amlWYnBQOWpQVzVpNlBIR3h3Z2F1VTNhQVNmOCtNZk9UNllSNVhNNUxxU3hV?=
 =?utf-8?B?RVR5bHRzRGNWTk5Kc1l0ZW0rU2VHV3pvN3pKSXBORklGOFBRS1A3ZUxUZ0tQ?=
 =?utf-8?B?U3ExNitFOExJNjNGb2MxaWJGcDdzenJoNlNlYVp6QkhUQW44N0w4Ym10NUpO?=
 =?utf-8?B?MTBiM1B3bWE3akhYcmhHVUdQRUovRUJ6ck5vS0EvOXp6N1lyQmpOWjRVZTBy?=
 =?utf-8?B?dTJnWUxKREt2VEZDT2QzalQxQU93ditoQVlCeWJDTUpTcGhMMk8yVURVVUc2?=
 =?utf-8?B?WjUvQnZ5ckFydUMveVRQUlNuWnJxdlpiaVVUN3haQ09Td3ozMERNSUpZaStS?=
 =?utf-8?B?YlhGdzJpeUZQNUVCOFZseTN0ZmJUWWs2RW9nYTdjQTZQSmkvTnJXYmFkUG9u?=
 =?utf-8?B?ZzU3SkUzZ0pnQTZvbDFvL1l1Z3R4OW1VUnFJYUJYTlorWG4wUzIyMi9UNk9J?=
 =?utf-8?B?VmJETnlPUUVkZTNsalR5Si93MHNqSi9BTEtQekxJV09FQzJHcDNCZEF0SkhV?=
 =?utf-8?B?djMwNmtMb1M2YU9YMjVHc2hLazFIQVFERU9wTTFyeWxpeU9WeDFOdldBN0V1?=
 =?utf-8?B?K08vWWZOVkU1eW4yRFgxMTVlVDFXd1g2NERFQ0JNOEVRWEpUS3BVbTN0WWth?=
 =?utf-8?B?WXNBandKWkhkY09sY1pHMm45WWUvSERVQWtiMk5lSEsyRXdCMjNqVXZ2SFhs?=
 =?utf-8?B?ZGpGN3cwSjRkWW9sekdwWVh6UTNDY0VXZXZWUmhUWlcyNGJDZXRpUmxrZzg1?=
 =?utf-8?B?YTdDaVArNFVqV1dPWnNPTllDalJiTEROeC9JbWo5WHd6TXQ4a1JQalJ3VlpS?=
 =?utf-8?B?Qmhxak96Ulg1YlZZK05OeG1sTzQ0TmpGNnBmeGEzNnRNTDMxQUNCRlJEVHUw?=
 =?utf-8?B?aDVoUStySXVNOEZMUDFPYTl5TGluMDdjQ3duM3orT0IwbitxaXFyZXVqUnNC?=
 =?utf-8?Q?LI85dGmcRxzYRL+Ae4oJB2I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e626f-b23e-4a85-9558-08dbb83b7da6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:36:25.4782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQwqSWac7uqN+sinvWYAh7mKeKZO6dTvRL/rMHiH88Wi/o/sm0SO7KV/q1ICzQUT4zTvqtsK1rVvZMdDiWxLZksqe0gI4W36W6MdagYT+ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5666
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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
> If the operation is failed, we need to check image consistency if the
> problem is not about memory allocation.
>
> Bitmap adjustments in allocate_cluster are not performed yet.
> They worth to be separate. This was proven useful during debug of this
> series. Kept as is for future bissecting.
>
> It should be specifically noted that used bitmap must be recalculated
> if data_off has been fixed during image consistency check.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>   block/parallels.h |  3 ++
>   2 files changed, 76 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index bdc4dd081b..2517f35581 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -193,6 +193,58 @@ static int mark_used(BlockDriverState *bs,
>       return 0;
>   }
>   
> +/*
> + * Collect used bitmap. The image can contain errors, we should fill the
> + * bitmap anyway, as much as we can. This information will be used for
> + * error resolution.
> + */
> +static int parallels_fill_used_bitmap(BlockDriverState *bs)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t payload_bytes;
> +    uint32_t i;
> +    int err = 0;
> +
> +    payload_bytes = bdrv_co_getlength(bs->file->bs);
> +    if (payload_bytes < 0) {
> +        return payload_bytes;
> +    }
> +    payload_bytes -= s->data_start * BDRV_SECTOR_SIZE;
> +    if (payload_bytes < 0) {
> +        return -EINVAL;
> +    }
> +
> +    s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
> +    if (s->used_bmap_size == 0) {
> +        return 0;
> +    }
> +    s->used_bmap = bitmap_try_new(s->used_bmap_size);
> +    if (s->used_bmap == NULL) {
> +        return -ENOMEM;
> +    }
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        int err2;
> +        int64_t host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
> +        if (host_off == 0) {
> +            continue;
> +        }
> +
> +        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off);
> +        if (err2 < 0 && err == 0) {
> +            err = err2;
> +        }
> +    }
> +    return err;
> +}
> +
> +static void parallels_free_used_bitmap(BlockDriverState *bs)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    s->used_bmap_size = 0;
> +    g_free(s->used_bmap);
> +}
> +
>   static int64_t coroutine_fn GRAPH_RDLOCK
>   allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>                     int nb_sectors, int *pnum)
> @@ -530,8 +582,17 @@ parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
>   
>       res->corruptions++;
>       if (fix & BDRV_FIX_ERRORS) {
> +        int err;
>           s->header->data_off = cpu_to_le32(data_off);
>           s->data_start = data_off;
> +
> +        parallels_free_used_bitmap(bs);
> +        err = parallels_fill_used_bitmap(bs);
> +        if (err == -ENOMEM) {
> +            res->check_errors++;
> +            return err;
> +        }
> +
>           res->corruptions_fixed++;
>       }
>   
> @@ -1214,6 +1275,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>       need_check = need_check || s->data_end > file_nb_sectors;
>   
> +    if (!need_check) {
> +        ret = parallels_fill_used_bitmap(bs);
> +        if (ret == -ENOMEM) {
> +            goto fail;
> +        }
> +        need_check = need_check || ret < 0; /* These are correctable errors */
> +    }
> +
>       /*
>        * We don't repair the image here if it's opened for checks. Also we don't
>        * want to change inactive images and can't change readonly images.
> @@ -1243,6 +1312,8 @@ fail:
>        * "s" object was allocated by g_malloc0 so we can safely
>        * try to free its fields even they were not allocated.
>        */
> +    parallels_free_used_bitmap(bs);
> +
>       error_free(s->migration_blocker);
>       g_free(s->bat_dirty_bmap);
>       qemu_vfree(s->header);
> @@ -1263,6 +1334,8 @@ static void parallels_close(BlockDriverState *bs)
>                         PREALLOC_MODE_OFF, 0, NULL);
>       }
>   
> +    parallels_free_used_bitmap(bs);
> +
>       g_free(s->bat_dirty_bmap);
>       qemu_vfree(s->header);
>   
> diff --git a/block/parallels.h b/block/parallels.h
> index 4e53e9572d..6b199443cf 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -72,6 +72,9 @@ typedef struct BDRVParallelsState {
>       unsigned long *bat_dirty_bmap;
>       unsigned int  bat_dirty_block;
>   
> +    unsigned long *used_bmap;
> +    unsigned long used_bmap_size;
> +
>       uint32_t *bat_bitmap;
>       unsigned int bat_size;
>   

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

