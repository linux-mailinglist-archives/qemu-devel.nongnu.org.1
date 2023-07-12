Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A879574FFF4
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:15:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJU2n-0005zv-3x; Wed, 12 Jul 2023 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU2W-0005xD-2K; Wed, 12 Jul 2023 03:13:32 -0400
Received: from mail-vi1eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::718]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU2T-00039V-VW; Wed, 12 Jul 2023 03:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVdVQ/2hxVymOODVHpeFXfVFVJ8cN/XELFakCrZZiH9ol/lVhDMm5kXFpD1ct1kly7rfoLMdQ1MR1KFRlUWblX8gHi913CQ5Bf2eNVh1pwA5o+Hw/2ewzbFbg3iiOmWrkM6B/QjNAiAx+DH7P0EWBgluzkfDFzg0TeFesry+n6vl5o+EFqeXVVPIANnZs2ZEqARtCr1ofvAepqnot7vzXJTkqYhhXE5UOa2A4YPMlzDXN2y3nFJ0I1yOFrHn9cI+C9rbFsuFOvIXjlkSqWxykT+88L+dHGgJFQ3oA+fC4cVO5+4/tZri4d06WjKibdTDQmQ5rQPrJLSHlu6/u62KTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+W7IOStJDDbSYOUZqQrERSo5dv9AWWHcnMrI65W3Ik=;
 b=cOxgeBKVQIR4O/2KzMBV0/8nir0WVaZffDzURojrL/TqY4idLKRKMo635ZOAZ+Dws4X4sOA9rwLAGIHksD3H9muCkH5bQYLVxBsG0Qg9t4YDjmmVZ+iMwq+xoDXBd2DaTDgaB8rGrb7epROG7vkTtQ+/H6HjyKPIVibRTrJCoVlN2bzAzFS2hh2v4w2fRUA1p1sptp8IE27MbsYJVq4u5o5vpdg7rlsZGkOFLxm7gxaafv13u5M0XQN7DYLxFRavVj0fqhbcouDyEcbKM7ZD6MCqJG6/O8ljMp8oaYUnVewXFr1FP8jR+dONrP//uPsWUXsc3pgdesvtgOUAd/LkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+W7IOStJDDbSYOUZqQrERSo5dv9AWWHcnMrI65W3Ik=;
 b=xaDZSAmtrXqGQUtCnnr7nVVh+NCXnBje7upxa0fEP4rbCedhRoGRzuhJ936vD4ucnddMTBM7KO810BTnajOhDWY1+ZiEHIVMiw21rjJBMBn1H3+Z97CzTY1LGNYSf8H3izf+rbAsgkWB+ss+qdNHoO+8MDR/H72lgVDVsG9O+qxZ85IV92rYpX9tlBhHP7ujjRnwlpuREYD3P2UpnOJiudH9aCPA/jbivUIkDTUgweIBif9t14g7Lfhu2f0WgGXPokcG7y1wpDbsZQ5hP1SnCHpASKyX2jqQ7C2erYnZ4UdHhMQlho9kMPT/Q+lV+xf3pX7a09zLLguPfPHVIw9v5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAXPR08MB7443.eurprd08.prod.outlook.com (2603:10a6:102:2b7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 07:13:24 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 07:13:24 +0000
Message-ID: <60602766-c6b0-0c88-699b-8104e88b345c@virtuozzo.com>
Date: Wed, 12 Jul 2023 09:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230706163047.128999-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:802:2::23) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAXPR08MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 61966f76-82ed-4d63-2b52-08db82a77b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gx1wDpyk7z+OsTAEwI9y3C6PFVpDQ+pn2Car3+ykrcyHCoS/59q0BeGVVsqhkunkpL5cOF2mp+J0Fo5f3w5AE9Wp4+QIqHJ3i7wbfZFdMqYpLfzqzI3yQ3dZRUDbbAk4UBHhPcsN68QvpZlh3fzJRNnkOg0eJJhMlDCyZq0Fq4IhXeeVvWbWsCT9kkRNQ+D3refwbrZsXXRwewqDaZQ5nIridSfRtUXwrhVvXVZeBnVbBt8TK6nATNi6vv7VFlemn7aMhYag7MrgMHqdC/DOhOAfjDDk/VMzhGqbZA8M6sug1j2gmWnSxFazeErdHF8queemcUIMRBdjZC4XLnwJuNBOXAyC7WWrjgwQ2FVIlVnpH1aC4Y5ZPNBeP1Q3qoyNyNxPCpu1GpRiuCATvofDOXatjav15o57T31x/xIcVpBSMS30bXRm/xw3NtHm3shYDS2Ik6Hq3Ay4vMomsz2iOlgrSwADWBWdG4la7AYoocJvP5xCGenIgB3zL+u7JRslk5oJLRUWnxqZdUi3KAab72RHrZZ/bS+v/s1DznovWVlwyY1/GT9ctFUjUboocFU7sSQWdcZFT0fM3Pw8pJkGCwKzEOQMYYxfM/b9XZB/uvIQW8Z12JatGFcJDm0ReW7//C6i6lBJRYVJuJEvqDUd1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(451199021)(8936002)(8676002)(83380400001)(2906002)(2616005)(36756003)(38100700002)(86362001)(31696002)(53546011)(6506007)(26005)(5660300002)(186003)(316002)(6486002)(66476007)(66556008)(66946007)(4326008)(478600001)(6512007)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5zazZydStRQVN5eXpZczRtODZNaCtXdnY4N2krcS9oRTFXSjNOSkd5Witu?=
 =?utf-8?B?SXhJSlovL0k4VXNwTUc2NXFnZFhoM2NsS2tuOUpSUVk4RElmNDBQUnVWbDNK?=
 =?utf-8?B?bjlIcU80amhDWHVXc3hxSEpGMityWkdhTHpXM3ZtcXBYaFRzeHJDWkVIZHF6?=
 =?utf-8?B?K3hRYlREMmFuSGZHV0R3K3dZRlVXUWJIbTJNTSt0SmtyOXUzM2pJYWsxbjk0?=
 =?utf-8?B?a0lIa3JmVG8xbzk3cHJVdWtPNVhvUW83eG1IY1JVL0J6aHIzaWJETktsY2Vh?=
 =?utf-8?B?ZE5rY2tzemZVU2xPcXRHRTVGVnlYN2UzbUZROUxWcWRnMElWMENTdENpYlRP?=
 =?utf-8?B?NGVpOUN3dWxmYmErOUVBbitpUDdDYmJDYjdzREdQWlg4bjk4V2FzUmdtMGkx?=
 =?utf-8?B?L2FINEdOOEJXa2FKbitkdjhYWXRZWUZyYURFcTdZNUFPejdBRjJicE9SeTlV?=
 =?utf-8?B?R3MrNjhFSzNycTAwWFp6MTVTZ25nb2NrdEhJTkxMVmhhS2RqQkszZGR3SjNa?=
 =?utf-8?B?eWllUjIzMnZqN2QwL1dXM2ZDZGJpZlNBVGlEUE5FYlh1R3NQSHpJWncrb1U0?=
 =?utf-8?B?OGpGbjZUWTVqR0NhRW52cm5GVU41d0d2cGJxZVFZZ2w2eUtvUDhNNk5QbzNW?=
 =?utf-8?B?akQzT2RkRXU3Z2w2OVZTa2IzLzdac0Z5Q1kvQTR5azVoM1k2SDRtdG5Ydkwr?=
 =?utf-8?B?aTdQY292RXZQa3ptS3RZUHNpcG1uaHRTbVZEWWthWlFVT3Z3WEt5K1M3MTJI?=
 =?utf-8?B?cEZmUmlFUUN0Kzk1U2pjaHBQNktXY2p1c1VPejVuT2NTSk9KWVNMQmtPUCtn?=
 =?utf-8?B?U0g0dnRzVHdTbmZqbXpEZGV2eTYwS3paTHZHVWRYbTN0UTgyeVIvNXMvYzBy?=
 =?utf-8?B?T1FoVDdzYjNac0NRZDVPRUc4NStyZ3FVSnhDem9tV2pYck5zNjhxWkVMblFN?=
 =?utf-8?B?Y2RZUDlKY2F0RGJhdnBBbnlvMWFhVFZicUdpQkU1R21xRytGUG5JMGZmRU9E?=
 =?utf-8?B?dUU4K1Rza3R3WXhIMGJjNHBQNGFrZ21CME1QTHlVYWtsL2cvSy9nOGFpbVVU?=
 =?utf-8?B?UXFlM2VxM2FuKzN6K1MwRHJQUHRPYjkrY2E5ak5zb0FjZFJ6S2hSNHoyM09C?=
 =?utf-8?B?eU92bVpNd0Zacnl3T3hwTHowTi85OTVpQTI5WHdlVTVIMVhXMHVlYkY2aXNi?=
 =?utf-8?B?b1RBR0hoeXRsZVBmSi9XcmJWMnh6ZVNxSnpFam1haHNxSk9JLzVSSFdUTHlR?=
 =?utf-8?B?akpIKzM4R09XY2JsdGdsa3ovenpnQWc1Y1NaZkhVRko4ZU9TU2F4OFdxbmJM?=
 =?utf-8?B?ZUF4RUxOeWlsaTQ1ck5lT2czb3V4bEpObGVKNVUrS21lUEZ6QjA1b1Z2WTdY?=
 =?utf-8?B?WU1GV1QveXB6Y3VpM05FeU4wWllacXlIZGcwUW9FeENpZjZOb1lGL3NhTnY3?=
 =?utf-8?B?OE1zK2hMamVwK1VqMndwZ1Y3SStIaUNNRzZsZHV1RlZ2c1ZLKytPQ0pQcGlM?=
 =?utf-8?B?aHJwM2t6aHFoMHdUbW81RWJnbHRCaWF5YWM5YWx2UnhDWUZ6TmwzY0lCaTdn?=
 =?utf-8?B?bGduYzNjaFA0L0JRZ2ZzZVluUTBBWWtpQXByU3B0OW0yajVZa0dCbEYxVmJn?=
 =?utf-8?B?RzQzelNLNEJrc1ZsMThzVzdsOG0rcVBrblVLSDVnazdBTG56dUxPYXFDUkg2?=
 =?utf-8?B?dHM4dXRGSXM5blVhbzRiRUZ1SnhhZ1JwQWVnWWtWQVI3N3EzT1Z5ZDhNYXhy?=
 =?utf-8?B?cFF4TzZKODROeUZhREZ6LzY2R3IzQWtBSEhMWnI5VWk1SkdSb3VTWUlTaGRU?=
 =?utf-8?B?ZHFTWWIwM2dVM0tXOTNWYmd3ZXpjRk5XenBEQmtSeldIT0ErRnR1aEdXTHNJ?=
 =?utf-8?B?RkpIMFZXcEgrc2FUYmpjZmppNkYxeWYyNmVuZEdLQThOYUUyTmZ5RkphbGNk?=
 =?utf-8?B?c29VMFNUUk5xQVNkZ2JoQ0tQL2V1dnJsa1RyRCtMc1UvM1hObjJPMzVZamFF?=
 =?utf-8?B?emJLYWY5cW1nWGZMb0w0VktuS0FaV25OK1pnbDVNUnNEL3NNYmFndDBGVWxy?=
 =?utf-8?B?OTEranBwWHJtRTdianVnNXRpMzlQVnVFZkQ1dFpVYi9Nd2k3S2RkMXhhYnZq?=
 =?utf-8?Q?RKJIJyQ/dR65ettzhCRBw2wJ+?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61966f76-82ed-4d63-2b52-08db82a77b34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:13:24.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wo/rhC+Url5xqWsvFk3y5dwmFQPOh2o+NG3i6ILnWU6FUVkKeoik0MjH335jwjIdIiCydT4NL9gWRmOO3b5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7443
Received-SPF: pass client-ip=2a01:111:f400:fe0e::718;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

On 7/6/23 18:30, Andrey Drobyshev wrote:
> Functions qcow2_get_host_offset(), get_cluster_offset(),
> vmdk_co_block_status() explicitly report compressed cluster types when data
> is compressed.  However, this information is never passed further.  Let's
> make use of it by adding new BDRV_BLOCK_COMPRESSED flag for
> bdrv_block_status(), so that caller may know that the data range is
> compressed.  In particular, we're going to use this flag to tweak
> "qemu-img map" output.
>
> This new flag is only being utilized by qcow, qcow2 and vmdk formats, as only
> those support compression.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow.c                 | 5 ++++-
>   block/qcow2.c                | 3 +++
>   block/vmdk.c                 | 2 ++
>   include/block/block-common.h | 3 +++
>   4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow.c b/block/qcow.c
> index 577bd70324..d56d24ab6d 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -549,7 +549,10 @@ qcow_co_block_status(BlockDriverState *bs, bool want_zero,
>       if (!cluster_offset) {
>           return 0;
>       }
> -    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
> +    if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_COMPRESSED;
> +    }
> +    if (s->crypto) {
>           return BDRV_BLOCK_DATA;
>       }
>       *map = cluster_offset | index_in_cluster;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c51388e99d..77885fe27c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2162,6 +2162,9 @@ qcow2_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
>       {
>           status |= BDRV_BLOCK_RECURSE;
>       }
> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
> +        status |= BDRV_BLOCK_COMPRESSED;
> +    }
>       return status;
>   }
>   
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 70066c2b01..56b3d5151d 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1770,6 +1770,8 @@ vmdk_co_block_status(BlockDriverState *bs, bool want_zero,
>               if (extent->flat) {
>                   ret |= BDRV_BLOCK_RECURSE;
>               }
> +        } else {
> +            ret |= BDRV_BLOCK_COMPRESSED;
>           }
>           *file = extent->file->bs;
>           break;
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index e15395f2cb..f7a4e7d4db 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -282,6 +282,8 @@ typedef enum {
>    *                       layer rather than any backing, set by block layer
>    * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
>    *                 layer, set by block layer
> + * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only valid for
> + *                        the formats supporting compression: qcow, qcow2
>    *
>    * Internal flags:
>    * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
> @@ -317,6 +319,7 @@ typedef enum {
>   #define BDRV_BLOCK_ALLOCATED    0x10
>   #define BDRV_BLOCK_EOF          0x20
>   #define BDRV_BLOCK_RECURSE      0x40
> +#define BDRV_BLOCK_COMPRESSED   0x80
>   
>   typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

