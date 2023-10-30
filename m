Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19D7DB567
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:47:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxNvg-0008Kx-Bf; Mon, 30 Oct 2023 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNvc-0008K5-Gc; Mon, 30 Oct 2023 04:47:21 -0400
Received: from mail-ve1eur01on070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::70d]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNvZ-0006DJ-VC; Mon, 30 Oct 2023 04:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiekVlHWNR4N/8ROHqnQ6EC7+7mAcaN46knh5dRZqczHk8VBxE+KWVr0Glm41KkHIGXjgDhEe82oIM9CBSxaTVbP9SDXNtgZelPnf7LmvwmXxS5XFBo4bv0Y1+D6WFA6QEVIectKt3Wpdvcxvt6U3KLhGdquJ6d56KO37G9KVyuAph4zbQ91GC76Ds7dI4Q5m2OT2pBiwQpWsnp5DTGfaKGlZ/XzVRyFhIHRPhv79yI8xHu8BaWSEv2vuJ1Tcjc0zFwsy8Z7IuFDYEt8gN48SX6Avec0ez+ch47vLIR5sD9MopvmT9CB1KX09nr1XMuJ2QGsBUuN+MisvhZHoQ1QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DPs8Fhq0lxWYh3Kl0j6RJTg2qY+SGud5gC/QGx0UuA=;
 b=UaFpEROOVIICZdEEr1+KfBHt6Lm9C79Bzhy+ZkApmxX5DwKc6gofsFnbEXk9yShnMpt4nnxhefioNuOQZiBqYIiR/ThQgfbVcqy74ae1CBamgeJ3TU1pPRs1ix2oF6Vk8KQAvGGUWi3wI3rZfO4ilRmGIai6n95rfsnkjDoZshG1WS7r1wlCBQv0K+A0EUe193Vc+4b39aQK3LGbuEmuznvq9FgS7PWKncM7ucOnCe4pmmSz+wagJVZcLSvo6kDNmSii4eTIjUZmPbHV9QyXkCeIcNmV8kfSJTSdbzC4HA+Gf7auhM7y3RJJdjgSt61un6an6yl2Ft1cXcCZZCTbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DPs8Fhq0lxWYh3Kl0j6RJTg2qY+SGud5gC/QGx0UuA=;
 b=eWb7x19n6z6bj2N2Xiey2vOME7Y6Y82Nn5VMtRnizEtDNN0eol2CBF6lKjptIkc2HrOf5xrsVKmVc0H9MGXkA3vLJbfqwwqgeNz/aumiG1FjgXTe+WJP3cCsUW+yQgxJZVjBOOPVNuuc3tItxFg0Upm9FsFFXRRZr082G74kSng9aphNDwayBCHC5LRWEWoQalbLX90MSULz2bEfBdd0Zw7+dlcnaL4CqCMq6WeWt5ucSrIIr453cIE02N4qdZsE2SI+T4NEqF6h8oTaTFYLg7yCBezyH5bfMYWzdNCrPOpZ2D1OJaRBVUsMMUTZQp6SUqf6upX03hMbqhgyRbaMyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by VI1PR08MB10200.eurprd08.prod.outlook.com (2603:10a6:800:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 08:47:13 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 08:47:13 +0000
Message-ID: <8cd50d1e-e3db-46f1-8cdf-b8241cd9c52f@virtuozzo.com>
Date: Mon, 30 Oct 2023 09:47:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/21] parallels: Make mark_used() a global function
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-4-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231027074636.430139-4-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:803:64::29) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|VI1PR08MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dce6389-0930-4ec9-464c-08dbd924d01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8J+NLelpttLQDgBhVuzthQaq6hfnTt0Mnv9bTSgnEyGQXAb2U2A4Zq4IBfsiVcTZ3QZzXm2ZsIY/826OpyisWe/veK0Wa7PlEiuUjwXQmRz1O8Jq98B2Iz6yXjMHCXkD+2r+0bVgmRRtoA9dy4smUe13GuhhNXiDOyL12/avNtVOxTyv1a6c2SvgLBlHN0zdShIwUIo/Ho+IsLPTMU5jvkw5fQE59w8At2COcN9ZcmA3jKK+INBkXh4A0S9JCT7aSWvgKKuSeEkSSp6Vnk0xnt1kNPcx4/6LDDQA8O1GtVFBCDaWAjdWtnqCfsOEt8JLwihr9pwChPPlLvWR+mOO86kPreZ0UqHnq4G4UIBJ/Sb3C6TacQ3KF6vwcaBfFrO58ep2bBFLeU4OO+DE+0pebChOn7LCBhaDXwSCRpORGM1R7vrgdRsIzVMmXaRXGTI+siOMrMGGZH5UyS4u0huQoQKqexE9ZJ5sDKoeYQxxf2mMPul63FRjg59ziN1AiAvGGKNv0JF/8v1OnX5und7ndDp/WcwZDoLZYIHdToWnN/kD4yvoV6O/0I55ij2BFJBv1/H6odGRSqS2RcvANk8GlOD+SupMjKHjVAvCHpFtwLqw49kujOgRPyeyOlQMS3xfOu4BGZCx01FkFBFWPc/mfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39830400003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(5660300002)(316002)(66476007)(66556008)(66946007)(26005)(2616005)(41300700001)(83380400001)(8676002)(8936002)(38100700002)(4326008)(53546011)(6512007)(478600001)(6486002)(2906002)(6506007)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9rR3l2ZVF4S3ZlODlxbGdlQms4M3kwWlFsOCs3a21pZXhxRHhNcXN0NTZV?=
 =?utf-8?B?T0RqRDdqU3l5YjRWcGVJckJ0c1U0WjF0dzEyRDZ2bW1GMnAzaHR5T0tFcXhy?=
 =?utf-8?B?OHZ2RzRoekVRTlZEK1RqMzI4NEY0eHhZQ3pKTHVxdEx4YnJwZ0h2Z1BLQWtH?=
 =?utf-8?B?VWREd2tFRUFDcEN2SVZwS1g3WWZ5UTI1eHlreEdOMHZrSkkwMmNsdDBQbG5Y?=
 =?utf-8?B?SmxqT0U1OVFqcS9kdXEzYk9qZmxpbWhnbFYwS3hUcVJHRDhDOW5HWXc4MDRk?=
 =?utf-8?B?S3NDTzl4M3BpcFFxTFhGR2tZSk5TSDVsck00RzN2OTFudVlJL0U2MzN1aDFt?=
 =?utf-8?B?aVJNdnRUUHdXV0dHMUg0a3FQUmpzdm5lSEhPZWRvNi9PSFpvR2I3cnl2SkRM?=
 =?utf-8?B?QWw1QzBzd2VjcGVjVC96UDlkNWRIZkRKdStYVVJpSkkwZjB4ZXlLOVJSejA0?=
 =?utf-8?B?ZWdVQ2lFOG96OFN2SGxIcXViZFdmRFNqMVA1WDB1MEdyUzdUNUkwTVFsT2lL?=
 =?utf-8?B?cEZCZjlxNlpIQXlya1ppRS9rN2dPUlBVZ0ZGcFgzKzJ2Y3NCS2F2dGpucDFv?=
 =?utf-8?B?ak1jeEM2UjNCVHlNMlZYZTUwMTFrcjQ0Z3RYTnBuV0htbWhUREFFSjV6aHBa?=
 =?utf-8?B?bFIxeXBobXhheXVLS05iWk4yZVlQNTQ5M3NOMHJRNnlvQVRZMjBuWHh5Rks2?=
 =?utf-8?B?WG1McnUrU202YmI4dVFYV1owb1ZqSmRpaEI2Uy9ucmpkVWIxc08wTy9vcWZM?=
 =?utf-8?B?NGhIZEYxTkRiYjNaZXpkQklRQU9PKzhvdHBLaVdnbE9vbFM1cjlleFJiWFJY?=
 =?utf-8?B?RUE1dkJPUVAzU2ZKRDBZblFBc1lNSlNONEpjNm5WY3BLSVI1ZUd3b1BuRnJU?=
 =?utf-8?B?VDQ0ekUxcEJUSG1DemlGSGczRGV2bHZGVEtPMnIvTDRxcjU0cUNONW9hRHFs?=
 =?utf-8?B?ZTRqY1o5OTcrVlNaaGVIRTVzRmlsaks2dFlaWURENUFHZ0huZkZKLzVHWElP?=
 =?utf-8?B?cGVvaEYvbmpQNjFONTlvTy90NEMzZUFxeHlabEkxN0NiTEJRNlZWZVFwMHRu?=
 =?utf-8?B?dXByZVBMdGVvdVZJeW5HUUtZNWhRSmJSMVNpUTVQd2VLb0hDQS9nNzYxckxr?=
 =?utf-8?B?ODNGMWZta2pubjhqZHAwZ0IvOVlFb1FlYjRQblFaL0FiSVRLZU5XVlRFenVY?=
 =?utf-8?B?clFkb3c2R2ZFNjMrMmNPZExvWngvYjBtQ3I3cEpkUVNJKzg0ZjlucHlITGg2?=
 =?utf-8?B?ZlFvdnVXdFhuc09OeW5mdTY2U0EwTEt2MXVqT0p3WFFBNytZeTNGTDNuckl1?=
 =?utf-8?B?TWpKajNDYkdjMnRMOTJOOFZVK3V6dkNidGJFTS84aGZDR3owOU9PaDZ5cEhN?=
 =?utf-8?B?U013SC9vTldXL1ZHK2NQWlN2UWxTR0J4Z2RxMkZwcVkveUQ5c3FrS3FRVGty?=
 =?utf-8?B?MjViZE5kWTJnWVhuQXhaNlZFVWZZcW5sQWdQZUxXRGFtUWVjODNKcy90a2lK?=
 =?utf-8?B?LzRPZWt5byt3QzlqVXhvUFJlV3ZlR0hSL3NHNFBWdkJpWStDWmh2QzUvT2l5?=
 =?utf-8?B?U3dERmJGTU1VZnZza2U4L2xETmY2NVdScW4vS2g1Vmg1NzErcFlDS0dtT0o4?=
 =?utf-8?B?eFF0L2RydTE4bkxraE5WNlNBcFVhbUZFbTFidGRjYXJrdWJEYVE2T3VKVzFs?=
 =?utf-8?B?YzFnb1FJaGdZUHRyL3NZQUZzcWIzM0ZkN2ZsM2NyWThheXVwaVhtWDZuUVRu?=
 =?utf-8?B?bFZ1NHpqZ1cyU3g1UEc0K1hGU2pObjRRY01HZjZPQUpUNjM0c1E5WVI0aW1F?=
 =?utf-8?B?dTdRaFlDZVloMU1JUUZWRC9yRThHeHdhbC9vRkM4am1nY2ZkMDg4ODMySm9T?=
 =?utf-8?B?Z3dtZ2t0ZFZlUERXSjA0SkNEb2o4MlZSZUh2aldaV0o5MDhxR05Id3ZQZkNE?=
 =?utf-8?B?OG5sdU1hSnlidUQvRlgxdkNlNnN4NDNHL2NKU25PSVpyOWtySEYvVllSd2VQ?=
 =?utf-8?B?TEU1U3JBTTR5L3JDNlN5blFJZklMcm4zWEFjSkoraW5ZZTVYRExOZ1FwTWMz?=
 =?utf-8?B?ZDVxeUZnZllkQ1lCNVp6Uk1kQ1VCYkNsbHdlTVRGZ3ZrZUtCbmJ6MnhZWlFQ?=
 =?utf-8?Q?GLIPlC/Sg/SyAwedpp8G6+waJ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dce6389-0930-4ec9-464c-08dbd924d01d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:47:13.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77XdLxsNywbWunwC4vJ1DKHCbyrxA4mcas6PjlyFgX5R+kwDWikInASsgn3ynxuQcCkNpecrI3KHfwmSowVwPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200
Received-SPF: pass client-ip=2a01:111:f400:fe1f::70d;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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
> We will need this function and a function for marking unused clusters (will
> be added in the next patch) in parallels-ext.c too. Let it be a global
> function parallels_mark_used().
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 14 ++++++++------
>   block/parallels.h |  3 +++
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8962bc9fe5..e9a8cbe430 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
>       bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
>   }
>   
> -static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
> -                     uint32_t bitmap_size, int64_t off, uint32_t count)
> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
> +                        uint32_t bitmap_size, int64_t off, uint32_t count)
>   {
>       BDRVParallelsState *s = bs->opaque;
>       uint32_t cluster_index = host_cluster_index(s, off);
> @@ -232,7 +232,8 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
>               continue;
>           }
>   
> -        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
> +        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
> +                                   host_off, 1);
>           if (err2 < 0 && err == 0) {
>               err = err2;
>           }
> @@ -366,7 +367,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           }
>       }
>   
> -    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
> +    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
> +                              host_off, to_allocate);
>       if (ret < 0) {
>           /* Image consistency is broken. Alarm! */
>           return ret;
> @@ -831,7 +833,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>               continue;
>           }
>   
> -        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
> +        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
>           assert(ret != -E2BIG);
>           if (ret == 0) {
>               continue;
> @@ -891,7 +893,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>            * considered, and the bitmap size doesn't change. This specifically
>            * means that -E2BIG is OK.
>            */
> -        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
> +        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
>           if (ret == -EBUSY) {
>               res->check_errors++;
>               goto out_repair_bat;
> diff --git a/block/parallels.h b/block/parallels.h
> index 6b199443cf..bb18ee0527 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
>       Error *migration_blocker;
>   } BDRVParallelsState;
>   
> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
> +                        uint32_t bitmap_size, int64_t off, uint32_t count);
> +
>   int parallels_read_format_extension(BlockDriverState *bs,
>                                       int64_t ext_off, Error **errp);
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

