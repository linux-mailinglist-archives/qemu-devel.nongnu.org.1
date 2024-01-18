Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3839831BEC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:01:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTsh-00020G-NH; Thu, 18 Jan 2024 10:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTsZ-0001zp-H9; Thu, 18 Jan 2024 10:00:27 -0500
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTsW-0004Ys-AS; Thu, 18 Jan 2024 10:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0izB7XEOxIc0NSl0GJM6Nh1nFbWV6wTd/ywWe/nnZqquaSQIEQNZxwvns8VyEWnFlVIruFNk6Qsg7/CQlZKU64vSHRSupXoRVJWwzRw/w/gDLAiBAnX8ROrlFxnBxOZTPaSNkVafVQ1B5M3cP7mWMXUQanMz1wpfpbbbkFAgP1g+NqmOA3vNpJSsX1aJfFF8QBh75fqzpK1cutxqEK8lalKCAnbdYvvzrIUQnrjaioMPmDhvcUgAUJ8T76ZqgLq6MIAbXTWNJzMf6n97M10ldiN7n4UN+l2koCxT89vKxwO1xC4n3iPZu0mVRvVflLYr7mdOU74i60NBoE0C5urJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRhDVzf+GFJAFaXIuhG+8jtNHOL36MIfpZt1QNebE9U=;
 b=FJmv/JiMhYz2Yy5ZGxcixfvzbAjgeYmcYkiM8Lce7Tnq2AisIJixM5Tx66jOMA1QbOAsSB1299VRmOqnZdxBbn6+I0gANFkxJZn0615KEhvOuaQcpqy4WDfVYuMgAkR/nBIgUAjliOxJflwWWb6DFqVOjyoW4RUZHzVKg1CsRi3EY47CdyQoxculls2x1y+03nEdT713DYEA/1hA8pZQEL/rnY9sXGQlLzqJ+dM8S2c/T8NksdL9amfxPAkndKFiD3BZ8+TX3bhrw0bUNgIq+3lSz+rs6LEwBZftlmRaUEK8qpOt3341hjEsu5P1ZnOo0WdBr9REQL/wFHoyuLKt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRhDVzf+GFJAFaXIuhG+8jtNHOL36MIfpZt1QNebE9U=;
 b=anWJ+10IEhkY8Ewi6ipUHSs3+YCY41crerW3yVJPesIsyy8xnwC0UkdgZ+fApKfMZ0/RiTE8zHEixYdEmrEY5u6hdWjtSG5AqMXfmCsrAL2LJH/Q+ydlniSUC/IBuhk/1nlsaprWX4C82qZfZ2eOjyLlyxShVr0eoPwsp1gkr3MW9WuF1/xY2EfeeiWm2aqCL3o2Jog9ic58UdawIRE1Pa0aChKtlG9eoQZ1+ROigoGkeg+FP7fdObDT8ZiK2WPd+Bcj7IFWhhj3IXmUU87aDPOfnKBu+qzyPL1RhEwLZm/qY22nGf4h2MR92cseyq0w1uuLJh31zRHdU7UJFkauuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 15:00:20 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 15:00:20 +0000
Message-ID: <5d259945-b313-4906-8ccb-7cba3052412a@virtuozzo.com>
Date: Thu, 18 Jan 2024 16:00:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/21] parallels: Remove unnecessary data_end field
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-19-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-19-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0283.eurprd07.prod.outlook.com
 (2603:10a6:800:130::11) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f68a5a9-6209-428f-04fa-08dc18363070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZG9d+5EbOnuSYoHG0FxVAd9rBEgyEum7bGscidNHekjsmLQHP9P4DAgTLhmL51y3tF9ci5zOnQkIjsOHvt8B/sj02fnY4Q7LJSSnDggOnVlw0Av4aGFjKtlnwGrcZucT7G5PdHByWmGz6OJOirIuQ5UK0F7HYcxsmBW5KrwcNv2tAOYMgdOlu1zbpSYXJ+0WqLDYDPsZgzc0FBbrPW0EGZtQYYNZLA6HJRU3cNBzEdx4JKaXdrT7+ttLDatv54dbh2w0b4+gBlI8j+UTRHnLGoukao7yn0q8qa2bxDc+NyFH2wthNoyQSWfx44DbL69deoKVuev4p+wbyM2DMKpjJYoqECgCP36JdiAI/zJTKdub8yDdKfq/3BtOd2tcP6tUYv68kfuMh7/3AZzja+cvDKb2PIo0w0msrctsMqiBxdPpI1R84HpPAfM5uymt9uVWfa2FS0tAH0UwGAlRFAGXhYjEZly4CmeOughc3BNmGM78za6aE4pZdFo6CRsjaF7rk5R+jcuOzvgU+I1cxtDP3QeLBdCs0wsl5224j97MKP3vlOp9F2rK1mypXBbBRfP7cql8MEa34bTrbKCDHpiemkL+aIysUhN4NCN7uK8TE6l1/2v8iGcaarXnt8G4WlME+y1w7XqIyCkSKrKDMR4oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31696002)(38100700002)(86362001)(2906002)(6512007)(53546011)(83380400001)(6506007)(26005)(4326008)(316002)(66556008)(8676002)(8936002)(66476007)(66946007)(6486002)(478600001)(5660300002)(2616005)(41300700001)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdGL2FHR21zR2E2bk1GWEl4a3ZwYkExVFB6MUdHK211UWpKeEc5UW9uN0lw?=
 =?utf-8?B?bzVHL1crKytqVHR2UE13S1l2Si9YME9CcUsxMG96N3RnR2l4eEZMK1NVVUhF?=
 =?utf-8?B?UmpZK2lSNkVTNDZoeHhhTW9vL01HTWR1Ni9TZXhzSmlXc1hjbXh1WG80MTdI?=
 =?utf-8?B?U3dtRVpZa3lPTVY5NHVmbmliS2Q3NVNIWkZBTi9MbUFqTmtrWmpaTDU3cXRu?=
 =?utf-8?B?UnhoUlBxdWNNVlpqOGxabGgzcUpEOEpsZklyYWxScEJWb0pOQldVUEdZeEIx?=
 =?utf-8?B?VllXMzNneWl1RjF5bk95eXk3d3RCdEcwcHVrRWw4R0lLeUhOdHR5SGZzNmNa?=
 =?utf-8?B?Q0ZTVWt1ekRxTzZCTys5bWE5L2loWVlPUXZDZG9IYlBUaWk4R3ZlbGhidVQx?=
 =?utf-8?B?L1lkQW5kWDBob0lPZU1GY01DTFBSR09jaTZwc3ZNVXl2VnQ4L0lHbVRwNFRm?=
 =?utf-8?B?THBUSE55WXh3blNuWjArM3ptT09VSldGYnRvWjN6ckJHT3NnL0dUSmF3eFo5?=
 =?utf-8?B?aFV1NXM2UXpBNjV4cEIzbTQwRHVMS05FTU84Sld5dEk5R3lZWWJraXA1S0JB?=
 =?utf-8?B?SVRmSG85RnZON2V5OVZMT05yQWVqa1FCRzkzNkxpc2hSZlJZbGZJS0NDTk5V?=
 =?utf-8?B?aGZpSUFudWlLakwveVN0eUpvY0VxU2plc0ZyME9LbVR5YjQ5QnBvdEF2cE5E?=
 =?utf-8?B?Qzh0Q1NjdG1JNE90Qk1Fc0RCSUJBRi9veENxSU42R2Z2aUMvNFRPKzIycndE?=
 =?utf-8?B?OGI3cmNXaGRmNmwvcFhUT2F3VGU1YzlHSi9VR0lzczU2REEwZjhCS0U2emNM?=
 =?utf-8?B?ZGJRMmdPZWNBYWllZHduMCtLajBzek9aUFVoVE1tQ0hDaGdhemNNZ2Q2aktl?=
 =?utf-8?B?dXMwOURxWXVXZXlwbFVmZzhlUkYzTmFhOFJoeWtWZ0R4NE0rRW5pRnZSNHlv?=
 =?utf-8?B?Z25lWmVNNlE2cmlYRW5za2hUYnhaMWt2eGhXaUZocmxzeVJBdXRxbys5bHRw?=
 =?utf-8?B?WDVXd2tXeGJGc1JWZSsxTTBCY3dzNjVydWlXQWY4Sll5K1h1bEphaWQ5R3ha?=
 =?utf-8?B?MGpQN1hxR3AyUGpJZkRvOVhwd1NNcmltY05qdGl2RGlhaHZBMHVFWmFMVDNB?=
 =?utf-8?B?STNnYVpyMWJNaEZ5VDVjbDVoUDdTb1V5T0xMb0EzUFZuTnprS1BlSG9RelpD?=
 =?utf-8?B?YjJoRHk3NkJac2doZEhtelZ4cS9UVmRpMWFjK2ZNd2k4RklqU25QWEFFZjFY?=
 =?utf-8?B?aGxYYU1WczJDSzRlbTlRL2FkU1pVV2duVHNUMTNoSjF3YkpITjZmckJLcGQx?=
 =?utf-8?B?L0RDalIvWklWTDZqNlNPbFliWnFiQjBlZVpVQ01ielBESEJZMGxhWVRUdFpm?=
 =?utf-8?B?T3ptbGRxQTlORTdjSUs5OUNwYW96dnBPTHdqR1cyTzI1QjhTMFh4Snh3MTBj?=
 =?utf-8?B?OUsrdGlBVjk0NVYzaFhya0ZXWW5zMi9nTVNiWFVjbm9JN1QzSkxIODlnVFJx?=
 =?utf-8?B?VnVMMDFqcjRSd3Z1OHl3WHVERXVKL01rOWZMVlhOQ3lKSmlMVXpaTWVjeklm?=
 =?utf-8?B?Q0o1MUkxeTNTdWVNbnljc2tId2hucVphTWlJTVBWeklIN2QwNkg3THF1UFdH?=
 =?utf-8?B?cUZXTjVFRUUwYzdFYjhWd2p2UnRTSC92cjVRaWtDR3Z1L2JHTjBBM1RjR2Ft?=
 =?utf-8?B?Um1VamdoSlBuVXZmN2NyWjhCMWdOcWd3MFM0K1VlWGwrbWVRZXB2TEVLZ3Rt?=
 =?utf-8?B?NC81UnhuaTRqQkdqbGhVL1FjaFNub3Y0aXFDUFhvdXFvbWVXVnZGbU9iVDl1?=
 =?utf-8?B?TjQyY3JpZW4zbzNnV0dJZnk0OTJtRzhCN3p0OE9HNjAzeitDbVNURUZKOXpT?=
 =?utf-8?B?b0hMZ2x5YTQydGl1ekt5RG53dWd1cGMvc2FVUXlKM0hFQS9mWEpDSlZiYmcy?=
 =?utf-8?B?NDR3aExvSTNITlQ2aE5LU3ROV0M2QTA0c1E1TnphWjRGYytIaTdKTUFYcCt0?=
 =?utf-8?B?T1lLMUo3N1VIK0xrellyTU91SHJYZWpld1lVOE5ndlhweVp5eGNHM003cldh?=
 =?utf-8?B?WkR0eW9SSjgrZzB3SUh0YjdyTXZIUExoZ3VSNnE0TUZxa0t4dHYwdWFOM3Fv?=
 =?utf-8?Q?QCXsINzTEsHmNNp5sBp+PU4jk?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f68a5a9-6209-428f-04fa-08dc18363070
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 15:00:20.1105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCVq/4kwQRdlXsbL/FjaPREmvr1yfmIdOl2S3su8YNN4SNwcyYUxe+QOJPP2t1g0LyWGzxGjJUkstJ+2EfU4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> Since we have used bitmap, field data_end in BDRVParallelsState is
> redundant and can be removed.
>
> Add parallels_data_end() helper and remove data_end handling.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 33 +++++++++++++--------------------
>   block/parallels.h |  1 -
>   2 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 5ed58826bb..2803119699 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -268,6 +268,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>       s->used_bmap = NULL;
>   }
>   
> +static int64_t parallels_data_end(BDRVParallelsState *s)
> +{
> +    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
> +    data_end += s->used_bmap_size * s->cluster_size;
> +    return data_end;
> +}
> +
>   int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
>                                                         int64_t *clusters)
>   {
> @@ -279,7 +286,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
>   
>       first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>       if (first_free == s->used_bmap_size) {
> -        host_off = s->data_end * BDRV_SECTOR_SIZE;
> +        host_off = parallels_data_end(s);
>           prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
>           bytes = *clusters * s->cluster_size;
>           prealloc_bytes = prealloc_clusters * s->cluster_size;
> @@ -302,9 +309,6 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
>           s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>                                             new_usedsize);
>           s->used_bmap_size = new_usedsize;
> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
> -            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
> -        }
>       } else {
>           next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
>   
> @@ -320,8 +324,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
>            * branch. In the other case we are likely re-using hole. Preallocate
>            * the space if required by the prealloc_mode.
>            */
> -        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
This seems wrong. The check whether the offset is in a tail area
or not has been deleted. This looks incorrect.

> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
>               ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>               if (ret < 0) {
>                   return ret;
> @@ -758,13 +761,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>           }
>       }
>   
> -    if (high_off == 0) {
> -        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
> -    } else {
> -        res->image_end_offset = high_off + s->cluster_size;
> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
> -    }
> -
> +    res->image_end_offset = parallels_data_end(s);
>       return 0;
>   }
>   
> @@ -803,8 +800,6 @@ parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
>           return ret;
>       }
>   
> -    s->data_end = end_off / BDRV_SECTOR_SIZE;
> -
>       parallels_free_used_bitmap(bs);
>       ret = parallels_fill_used_bitmap(bs);
>       if (ret < 0) {
> @@ -1394,8 +1389,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>   
>       s->data_start = data_start;
> -    s->data_end = s->data_start;
> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
>           /*
>            * There is not enough unused space to fit to block align between BAT
>            * and actual data. We can't avoid read-modify-write...
> @@ -1436,11 +1430,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>       for (i = 0; i < s->bat_size; i++) {
>           sector = bat2sect(s, i);
> -        if (sector + s->tracks > s->data_end) {
> -            s->data_end = sector + s->tracks;
> +        if (sector + s->tracks > file_nb_sectors) {
> +            need_check = true;
break;
>           }
>       }
> -    need_check = need_check || s->data_end > file_nb_sectors;
>   
>       ret = parallels_fill_used_bitmap(bs);
>       if (ret == -ENOMEM) {
> diff --git a/block/parallels.h b/block/parallels.h
> index 9db4f5c908..b494d93139 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
>       unsigned int bat_size;
>   
>       int64_t  data_start;
> -    int64_t  data_end;
>       uint64_t prealloc_size;
>       ParallelsPreallocMode prealloc_mode;
>   


