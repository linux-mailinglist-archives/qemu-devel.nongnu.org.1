Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B77A4BE2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiG4p-00045S-Mh; Mon, 18 Sep 2023 11:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiG4n-00045A-OD; Mon, 18 Sep 2023 11:22:17 -0400
Received: from mail-db8eur05on2070a.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70a]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiG4i-0002w4-7c; Mon, 18 Sep 2023 11:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+ZCIQcw6u5ZzUhtrDAn1+L/L4tCpnPYhabY67QIb/BDJqqcn4Mt84RyujOe+AmZg8K+RQ+C35GGyLiuhDOvdgb6y+NOBFvWvZoVufbMQ1qlfgUgLvVCXdKc/yDvlDYitX8lWORX3f6Ct2or/TyGl6D/Mnu1GQWAJYGT4B7VQMkapatwn4Zh5+ftyYIph7pcpxkSicDMHidBbvJ35YxIoZje/vtzWIYAK30ody6OfZS6CTe4S9oju+vbhkujUqjTe297Ved6C+3rbBLnGRKL7B6LXpZ58fPaqYFwQ6LEAJIYvgKV3a6vnc3XHA/YzWHtEoz7TGDQzJiMbnelFHh+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrKJfXa6rg0SYLuWj+UAqIqGuahgxU1lnDjt7VfEUNE=;
 b=KSPG8lvv3VK7sooj4Hy285XSh744rmZs7/NqgkRJbVWJ+VgaGic6J+iktb3KgmfzGQEGmvLKOdClfE5eXZnDt2OR7rJsfFySrJ3HwtpK+YH0obgnpIWkEwVYEVOc/zscmjExhBoz/h1DrIWE7/cBRplMDQpU5grzpqCwcotJPClwNqANkdptKAP+fQxR7Sn4tkxxmOwaP5f5Kp3g8wch0N50E3WT3aYgMapSgTK0wiJPag/C8gmPUnhrZyIzB6wwXbsKNh1XsqsJznPJRGDWMa+6K1fQRLDCgziw7uCiikuEHwJvBjZ4RCMURa8gJPN212i+Bz8bG/ZoAhibt2c8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrKJfXa6rg0SYLuWj+UAqIqGuahgxU1lnDjt7VfEUNE=;
 b=O/43uj71O8Fhrg5lP8+UHwrfugR/2XOX4/Wg9q+408VXpY7iIQ46ODrMg3zan/dDyfCTqrOB8zHMrStEfBWb9O1jx2UR1hBx83wXX9amO/RJZtHkR8on5KjLc2Rp4u/aGPWoTebb9GYHFNItZvdZ3nYKk3TMGby8JAivbq8L3p/GImxUBW8KzQYTuuupJTjGQBGVZ5x3NVtX/OB3SY2movF6vh9EXfLauCwt30tw87uMjUCUOp/y/9+UsCWw8GOM7XpsyYKofqDlyTSG7/5nOkvvFYlqaAKktAzflyVnBieI37G2uza6xCyx7RV8A4S6ldnUxGm8xE2j05Xk/ASBXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:22:07 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:22:07 +0000
Message-ID: <eb6ae1e5-5645-4a9e-8428-6a989a1f3a64@virtuozzo.com>
Date: Mon, 18 Sep 2023 17:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/21] parallels: invent parallels_opts_prealloc() helper
 to parse prealloc opts
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-5-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-5-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV2PR08MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: a726ade2-5263-4b6b-4f01-08dbb85b058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PPCW6XdjfsHtMDWjGV0WuLUvJE3TD9umI3cpNlXN4lkWoP+4M4JsI5B8TTZ6QMOzztuOGvXOOchQq8yg7Ja/JFzYMgHoIySUmHtiShvf1tdPnlGGhe1cgkkNjEnburWHx4YggrYCePY540rWEH5bVZFoGeJL2nODYnYGnDpXRfKH0/bh1ZIu4XQcqMB6+aGX+76D9ThFR7nrjH7uIddZWuEpVb8CC+sJGF4FPYBoS/f/YehZIOHdWYbw3/BLCMyhZOXHg+2QvFanZ8VR/EVHryCv5j2EZZMksHlhZiZgq8Bj0u9afKEF7hLiH6XVxLJzacTTM5X094Dgx/eNVMFM/nh5QqE6LDa8tfJUpLyCLX0mwpE6BGWqKVQuXk21yPxrJVfJ6Gmi1vQZVZtOL0KzPljA0Ku1mmmkJGRTkLF7C2jRXFiD3K9TwH9GflZgvLlcTxBepzrYVFTObVkYsYScRXAoIHXj2wchHxh6c0i2ebn+Xk6gvYXTaynqWT8FsekcQD26vwxpFiPqq16yalih8b/VO43W4pM1o9uUoFlN/+AocDBpcSvoF7C5O8wa4mFjL8S8WIURh+J9St4md5BM18cL2gLFPN/CZBSVJOXt8Ay9O23LEYlUPV6ICXbLy8AvLlTRWmgXiUbdNmq6njFNRwO4XbApXdJFNzQ9NrpfDdLwNlfvXhlQia3WNVd6wh7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(346002)(396003)(136003)(1800799009)(186009)(451199024)(31686004)(36756003)(38350700002)(38100700002)(86362001)(31696002)(6506007)(6486002)(53546011)(52116002)(478600001)(66946007)(5660300002)(66476007)(66556008)(2906002)(6666004)(8676002)(8936002)(4326008)(44832011)(6512007)(83380400001)(41300700001)(316002)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BMQ1ptTnN4NkFDaEtiT3BYNnBaRCs1MzhPT1VFUmEydklSajBQS0hCWExm?=
 =?utf-8?B?ODBHN3N0TVA0T3VpSjhzUVFxUmwybjF1bjRJYUxOZU1zYTlQM0RmSU5hSXBZ?=
 =?utf-8?B?dWhZT2lVM2tKUTZwVXM3NmRaUHBKZTUvOXJ2RmQyeTdsSUxVU3p5UlZIem9P?=
 =?utf-8?B?TnpLdTNmQXVsWVpHQVk1NFZrKzNMZ25RYVlBZmp6M1pTa1ZSVmpPb21MRnRr?=
 =?utf-8?B?eWlKc2IzWG9TbFdxWnRoeDcvVHcxaXpRbDlXaFF0OUxURzNXT0RhUmNlMnlY?=
 =?utf-8?B?T2xqaE9KVFZVR1p1NHh5NzNCSmJRMEU5TC8yYXp1ZGVPSHgvb3lza2FTM29n?=
 =?utf-8?B?a2ZtM0cwcXFCRFg5YXcrcWZwUVJ6clJaS1BCdklnM2RteFpjaFNqd0EvT2V5?=
 =?utf-8?B?Qjk1OStlU2JNSzRVRmZzMEM5K1l1Y0ZXWnEwQ1pnNmkwL3JVT3pGSGkwajBz?=
 =?utf-8?B?T0pZZlkwTkFzdkpYNUE4WkVCemdWbUtwVExJd2dmb2xzeXFZMUtOZ2N2amlY?=
 =?utf-8?B?OWwrS3AzbXBURkZsdjNXc0dxR2lHZW5BV1BZaFp6VDdoT2V1WnRaM21QcUMx?=
 =?utf-8?B?bll4MlRIU2hZeHlyTTVRc05LalJkRm4zZm54UUE1ZERhYUlHQmNwT2FQK1RT?=
 =?utf-8?B?ZWhUb2VURDlTNkhsLzZQWGxEZE5VNnRCQ3BKQ0UyZklGZXhXMC9ENzcxNHN6?=
 =?utf-8?B?R1ROc0FRTWxjVjhHZklsOUhESENDWWVaeitlMHhEK3N5amtKeTRMLzJ2WXRX?=
 =?utf-8?B?V29aM2svTzlSTDZKMEZkU3Mvamlybmc3bVI5YjdtdUR6eld5U3I4TmhSZzFR?=
 =?utf-8?B?MTJDaHczRzZxWUgxTFFFaTV6SFBNSS9yQ2h2R1lIWk9aTHhZT1ZHWDB5QVYw?=
 =?utf-8?B?SGdkbWZEeHVsZmdzUHZKMlJ3dGdjZDU2d3pvVUphTmloYm8wdTliaVJVbHdU?=
 =?utf-8?B?RE00OHlYQ0k4aHM3c3R6czhlb0twTnBEYXVqY3l6MHBycThzMzRscXJRY1hl?=
 =?utf-8?B?Si8zeS83a1FPMyt3L2tsNjdpRHpBRUtOSk5EQXl2SVJ4NlFWeGo1RHdjRFFk?=
 =?utf-8?B?R0VxdFpZMWtNL3VZZlM2WHNWRE1VWHo4M3ZsRmVOL2dBYU5RVTlJSTRBaE81?=
 =?utf-8?B?S1F1bm9rb2ZLendMQlRFdW5DeEcvaDZjMjNURVNYM0NUTkU3ZHVDc3Q3ZTVh?=
 =?utf-8?B?dWpoK2dBSUY3NENvMDVBQUFwcWwrY2VMRFdMQ2hrcmhQbmxLcTE4K3hwcGJG?=
 =?utf-8?B?Z2ZrL1pPNDNBWHBBb3JqNU1UbXpDNkZQbC81VG1qU3paVjFYZzV0S3V3ZzRG?=
 =?utf-8?B?Mi9JVWRNSG03MkpOYXZTVHJ2YkNnRFZrTytPcGMwU2VFR3l6VGFOeWJQS1R4?=
 =?utf-8?B?RDhvU1V4S1h4bEs1N1NPV01qbmZxbWlGbU9xY3Q2YytXdDh5WkVrRlFwK203?=
 =?utf-8?B?Qm83N0ZCTkg1OFIvOWtzV2gvZEZMekdwQW1GN2FYK2tvSXhYdlZxdjVueGdO?=
 =?utf-8?B?U3h3OGc1cFhGdWJmUnNFbE9yUEpGKzRpWmIwMk14cUlyR3g2ZlhzK2lZb3ZE?=
 =?utf-8?B?Y0ZueHA5T3J0dDJNWjF0UHVkeE5QdkdkMEVCb2t5N3dqYmFnckc3NHFQZDJE?=
 =?utf-8?B?YTZvZVpUZ1R5TmxNU1lxVE9tbHFyenZUa0o1QmlWZ0p6OEkycFRKSUFZcDNi?=
 =?utf-8?B?aW53UEF4Ulk0NUp3ck5qZmd2b3NadjV1Q3Iycmlmd2xBRXF5TWVaRElQOWhz?=
 =?utf-8?B?eWtUM2JZYVd3R0JTUjFXODBDK3g4RzZ2QWhLL3JkZ0ZqdHdSc2k0aG5DOXFZ?=
 =?utf-8?B?T3N3SlE0Z2hHVUVYYUk5WHFURmJrUjJyL0ZMS05LUTEzVklCTEltaWk5NXBL?=
 =?utf-8?B?ZWJHZDg3aElOWDlFMmI4TDY2NVd5Q0JRenRESmNSeS94UGlsSHRZLys0Z0Zq?=
 =?utf-8?B?cnlnYXVKZXlPZUcyalNrVkl6TUR1ajE3K243MnJVOHMzNTh3QVRxLzFQZy9U?=
 =?utf-8?B?ME1DM2gvblZMS1BuR244VEJ6bWU3ZkdMc0FUNUkyRmlUSEJGVlRRcG1oYWlT?=
 =?utf-8?B?MGd3U25OdkN0R1hzODJQc0lCTWtKZVdyQzlHeDJ4TU9uNE85YzgxZ2VDekdM?=
 =?utf-8?B?T1NET28wWWJVYnFaaGhqeElYemIvOEMyUS9iMjNDZ1RrVkhHWlY4ZG9CeU9O?=
 =?utf-8?Q?Wh9xuHusBxmusVOflhv3h5Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a726ade2-5263-4b6b-4f01-08dbb85b058d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:22:07.8876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNTHDKAUSS2q2yWaYR/lLj7XOrjHotuv3ahZ8zXL2zmIh+RiHWB9A+R79yvOXQkdXCOzJeAqX/A3bqsoH7t/BmR/xM29QjZ/RBlTZcGyrQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9277
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70a;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> This patch creates above mentioned helper and moves its usage to the
> beginning of parallels_open(). This simplifies parallels_open() a bit.
>
> The patch also ensures that we store prealloc_size on block driver state
> always in sectors. This makes code cleaner and avoids wrong opinion at
> the assignment that the value is in bytes.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 65 +++++++++++++++++++++++++++--------------------
>   1 file changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 428f72de1c..1d5409f2ba 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1025,6 +1025,38 @@ static int parallels_update_header(BlockDriverState *bs)
>       return bdrv_pwrite_sync(bs->file, 0, size, s->header, 0);
>   }
>   
> +
> +static int parallels_opts_prealloc(BlockDriverState *bs, QDict *options,
> +                                   Error **errp)
> +{
> +    char *buf;
> +    int64_t bytes;
> +    BDRVParallelsState *s = bs->opaque;
> +    Error *local_err = NULL;
> +    QemuOpts *opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> +    if (!opts) {
> +        return -ENOMEM;
> +    }
> +
> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    bytes = qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
> +    s->prealloc_size = bytes >> BDRV_SECTOR_BITS;
> +    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
> +    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                       PRL_PREALLOC_MODE_FALLOCATE,
> +                                       &local_err);
> +    g_free(buf);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
>   static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                             Error **errp)
>   {
> @@ -1033,11 +1065,13 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       int ret, size, i;
>       int64_t file_nb_sectors, sector;
>       uint32_t data_start;
> -    QemuOpts *opts = NULL;
> -    Error *local_err = NULL;
> -    char *buf;
>       bool data_off_is_correct;
>   
> +    ret = parallels_opts_prealloc(bs, options, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>       ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
>       if (ret < 0) {
>           return ret;
> @@ -1078,6 +1112,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           ret = -EFBIG;
>           goto fail;
>       }
> +    s->prealloc_size = MAX(s->tracks, s->prealloc_size);
>       s->cluster_size = s->tracks << BDRV_SECTOR_BITS;
>   
>       s->bat_size = le32_to_cpu(ph.bat_entries);
> @@ -1117,29 +1152,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           s->header_size = size;
>       }
>   
> -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> -    if (!opts) {
> -        goto fail_options;
> -    }
> -
> -    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> -        goto fail_options;
> -    }
> -
> -    s->prealloc_size =
> -        qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
> -    s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
> -    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> -    /* prealloc_mode can be downgraded later during allocate_clusters */
> -    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> -                                       PRL_PREALLOC_MODE_FALLOCATE,
> -                                       &local_err);
> -    g_free(buf);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        goto fail_options;
> -    }
> -
>       if (ph.ext_off) {
>           if (flags & BDRV_O_RDWR) {
>               /*
> @@ -1214,7 +1226,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>   fail_format:
>       error_setg(errp, "Image not in Parallels format");
> -fail_options:
>       ret = -EINVAL;
>   fail:
>       /*

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


