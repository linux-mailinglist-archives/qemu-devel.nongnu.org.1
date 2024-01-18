Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831F831BC2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:50:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTiD-00077c-Kt; Thu, 18 Jan 2024 09:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTi3-0006zT-D3; Thu, 18 Jan 2024 09:49:35 -0500
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTi0-0008QP-HQ; Thu, 18 Jan 2024 09:49:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceo4Qt5LgBZ7Z71isYN2rL//KKt5XRj/+EtELXjBv6wrvIqF5pmDXZt7tZpWkkFq6LMPB6QG02yDbwBKUwjfzshdIDxk/J6TNJa7XjD1ge1gKc02hac2juvtiyoRAyybJwfvVkBnH3BHrdwqkf/S3X54SXK8k2XyvP/E9QKrU7WsihpKiqSyYTxGgeqJ2u2Qq4b3DGLcXHitOV/NaZT9M2VbWS9iE4oiQ748J7vN9+8ap5XGQ5g2nUK9yhd0nW8kz+ajqJvnXuyDX7iSAQMZ8E8uxwHYv9+iXcKu0NNP2/q3MPf2q/BnL9eByWchWUYOHcbNGhc4iJWDxM1gf/JTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0fcUac+3SolacYmG80G1+TyftxbklJlw1X8qfBYMSg=;
 b=KGZ2w+ws33Jzfu0Q5WKn06chx0ph9lvWCPuJJoQKxK2HhmlF7o/ebYW+/xUG4/V2NthIzIRFTqAh0KssGZ/eGBU84Gx6d2qIzPnTGX9v51I9tWTbDvC62dQqyE+Z7SDOqXa9UAH0xa5I/D3q4GiBnD86nvqwUC/YipiIKWkTmD20MWFt6LYvrVWkS/B67c5EAggiP8Kp0SeHAS3wq84Ughi1s17evfYMWWlmCPPekUDU+dFN9y3qaVmu7wNH6iCwwaDHI2rOoznzsKiYGUaPDjWla+tN8413wdq60I+nkZ/nd+9G7Se9aajsN2xPV0wqwZQrLb+cw0AndXY9S4tkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0fcUac+3SolacYmG80G1+TyftxbklJlw1X8qfBYMSg=;
 b=IAotth6juoDRjQDGshkby4mPHdm2Lyoh1K8Om4O+Zg1NAVnS10ifQx5VgtVmjQK5qzEHSmNx0YxvciEY3oqwXRr0osBAumxUSseH8cs0cjUpUZKgGDdy5FmHUhoK1EfMoM8wmmjAEFmocSmyhhAEc+9guj7l3AsDV0FfIfs6k184muh/6/Uj1ZKHUHX5ngvD3dfIucWU/UKUdjXmvZyzz+7UzhLbQOBGAY0punpp4JRk21d8+8r92Ioi8/lT2plNRRWoBbAUVt0bXsLFmUJQkQ2bhvc1evSX1EjNda3TUwKWSb7QoLdZwIxsNLcv7aHIaTkExB/D/X9nI2/GO1k1Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB10267.eurprd08.prod.outlook.com (2603:10a6:20b:647::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:49:27 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:49:27 +0000
Message-ID: <0195a16e-8df3-4069-bb7c-6e51b739c7b3@virtuozzo.com>
Date: Thu, 18 Jan 2024 15:49:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/21] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-16-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-16-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: af2772f1-ca58-4d49-57c9-08dc1834ab91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52ubnNCScUed1GBQbTMonodRcggAFgcUhDh3ozIh/jVh/WQU5w2utudhcTF2M89KXtEbbqY8J/3mfiO3UR4amm4LWJEerkHeaFhiM9n1fpLoJLMkmX+bGAdQ8VFGL/q2u+9f1BiBaEpemplr5yfKovv/SN+VWb0ck/fvS1YLtW8onKI2RxZqSQrv4URVkfLZubd8IwgJSgF01y+OAToAQAz8nt8l4I13CjYTaM2cbiUMFDSPrOW1qgmXyK4ybX5F1LGGU4QQ89fYaHJEWtJpyc34VTumvIokbVOxYpzmud+jGAJxO7vSqkq1Mm48l/SgivtAtg9oZw5EjQzdzhO7ZKtpSe0qU7PjnTHe3lj/KSKk9f317pCqDqlerlFkgX7/wj26H6vM3MKHDLOVFOX48pXBuGZpWdrZkCdQJ08uh6tmSkRtftjjKEZUXh7pkQseC+23d+HB45pjVykYXcII7eb70vGQ+YU+5O/y9Pk9hzQ/Ij/H5M4YPtzPoiVuxuBW9fNlX/2We4r/Aer4AmqBV1f5kAJ4nN4TkOat84Zytt0/JYpkZ/NSdpFpT1yH4TbTkqi1sQkezoYd0o4FzbU4JPaTppImXOscyvf9RNT1WGcT4kvhslh35uPjU+b0HR0BG1QzZ3kfF3EGYFNP05ceLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(39850400004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(26005)(53546011)(6506007)(83380400001)(31696002)(86362001)(36756003)(8676002)(4326008)(2616005)(6512007)(38100700002)(66476007)(66946007)(316002)(5660300002)(478600001)(8936002)(6486002)(2906002)(41300700001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dNTmdseG5jSStiL1I5L3BpMnhHN3p2alNDWDFXakpYSG9ITjdjTDlUeVYw?=
 =?utf-8?B?SVNtcmVvUk1IMnMvd2RrWlZYTUVaU0g4cW56THJJQ3N3NDBxU0JVV0ZaMHls?=
 =?utf-8?B?dm9vUGpyeWpNUFFoU2RyamhVcnRJcjFwejMxVVYva1R1Uld6WjNucklVS01T?=
 =?utf-8?B?b3JvK1I4a1FnMzZ1alpDVm0ydlZUSnJzN2xkblp3M0NVU1dycHhkYkNCRjNB?=
 =?utf-8?B?ejhkTS9Ed1pNakVzYkdXN2lJMWRRd0pGSzM2cUtzWFJYZTNZUVVKK25uWHN0?=
 =?utf-8?B?dThlb1NZdGp3R29XMG41YmQyRi9TeVZhQWhGa3hzMGxQZnU4cWlSWUVDQ05E?=
 =?utf-8?B?VTYwWWlFQXZxb3VYSzdOY3BpeEsvQlB4aEFxZ2JYOWt4MHZGWmViTEV6eUtO?=
 =?utf-8?B?amhVUHA0YVl3OGgxeUhlbzhodmZMRmE5aFBvYVNrajROK0JHcDhFK0N6d1Fl?=
 =?utf-8?B?SzMrdUJtdFVwVVJJbk9ob1ROSXhtZ2FnNkdUR1VGMTVOcEZobXlpczVWRmpG?=
 =?utf-8?B?ak52anBZRzVSdzhUWU80akpFT0Z4M0hFb3FWSUtuUUwxMUVRUWtDb1RyRXI5?=
 =?utf-8?B?aXo0QXUxZHVlcXBEbHFIQzB4OURjU0RhSTBaSEV3RUhYNHdhako3R244ZzhM?=
 =?utf-8?B?cVhyNlpjaTFkcmY3N3RnVVdPVjFndTV0ZmcyS2djQ3BHQ0ZUTHVlRCtobjQ3?=
 =?utf-8?B?TjZld0FJNTk0aFNyalRZOXExZTA0bUxRRERWa1VFdGJXcVFNdGdCMkVHYjB0?=
 =?utf-8?B?L1ppQjB6RVpkZlMvQnhSSXRETFFmUnFrV1cxa1RGZy9XRzNnVURPN2pLbUpp?=
 =?utf-8?B?ZTFqWU14dmo0T3FwdDNnV00ycHBGTHBzbVFEUHg3T0F3d1hZdVV0dlljSWpR?=
 =?utf-8?B?QVR6RVV5ZzhhMjI4MnZWMG1wZ3NVMWhnUVB3OFJ3aWFKUHZBLzM5WHhOTW1j?=
 =?utf-8?B?cjhOZXR3bVdieTR2YWRBbTdjaWhOSVFyQnJuYm9QK1dtQ3FMKzY0aDl4eVRT?=
 =?utf-8?B?T3RxSU1xOHZtZkhyNGw1bmtZcklKQldIK2VFNXI4ZkVqbkJLaHJYd2dlNE94?=
 =?utf-8?B?NjZQWHE2ZXlwWkt0U3lwWUMyZDVUQnNTTGp5Y2ptNy9YdW9GT1VMa0l3SnBh?=
 =?utf-8?B?RzZVaS95K3dQckZyNGl4UTdBZ0hjbTE4b2h1M3ZhN29IR2FaNGZtOWlYcytF?=
 =?utf-8?B?Vm1kSnNuMkNMWW0xbVdQaVQ1WWNHWmJMZHFxajRLQkF5eHk3TW9MOVVQUVh0?=
 =?utf-8?B?blU1TFBQbjNwYm9WQ0o5aWRYVzJ5c0JnRWxldTBZM2FCVldCMVRrdE9QeVJk?=
 =?utf-8?B?UE5FWmowQUVHUk92dnM2Y1ArbmZIK2RRbXZ2bzE2bExuTWMyK1l0NzhlTjh3?=
 =?utf-8?B?YTZ6cUUwLzZMM1pDcGVWU0FIZTRHQkYvcUJ5czdzZWRxaWFFeXZiczZUK3dN?=
 =?utf-8?B?VUtuZHVaVmYrTHFENEhKa0xwTTNiclM0b3ljZExDZVJ5bTliVnZGNmx5blQ1?=
 =?utf-8?B?VVlrOTdjMzV1cURUMzdNOHVFRmVqMGRtUjlrZWxuT0I4RDZYNG15ZHdyamRL?=
 =?utf-8?B?ZUxZcUx6Nk9nR3AxY0k1bGZ2U2w1SWgvcXRyMW1jNFZiblNMbkVWcytLNDNV?=
 =?utf-8?B?MU5yK1dJblhuenRRbWtrOWpPZ0ltRWtBZTBPZCt1V1hUVi92T1lCWnI2YkVO?=
 =?utf-8?B?YmplL0JHNzJVTHFZSEF4c2c3TE9YeHI0dkdKMVVsVjEvd01BRUVqRW1HbXN3?=
 =?utf-8?B?YStyYTU3NFkrcFRHaVhUaGVjdXFMT1ZZVXBIbnVKNWFqU055bHhXQTAzenlv?=
 =?utf-8?B?N3dtUS9FdS93czIxanVMWFFCN3J2emZBMW5hVE9RcjkxS053Nm04VzNCVURV?=
 =?utf-8?B?VmxqRWFRMXdveTUvRXd0aVo3R2ZlNUsycFZRWnB0Sm1LUUY0alFlVkhadHdX?=
 =?utf-8?B?cVVieG95NkluOE9CamVYdE1RQ2JEd0IwTlZYSUJ0ZVBDUVdReThxWFkzN3lE?=
 =?utf-8?B?eU1nUHNESWhNbTRiU25JRVkrSWYyV0tMOWRHMGZ3RmFFS0lXTnlPTlluSWpn?=
 =?utf-8?B?TVdGRVpCaUtsZUxxWTN2WjJQbDRWVDNsTGl4MEMyVHBTT29QTTV4dzdNYlNq?=
 =?utf-8?Q?EOa1q+GA0Z7iaQygG08TaCQ5v?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2772f1-ca58-4d49-57c9-08dc1834ab91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:49:27.6987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIwmf8g7h6HMtG7lmPlPbGloHyYII1xIqO3sQ5rYU28ARLQcVoIyzkr+IadHeaQiE4+MzrsBfmM3LrMVo+nwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10267
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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
> Let the function return a success code if a file size is not bigger than
> image_end_offset. Thus we can decrease indents in the next code block.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 72 +++++++++++++++++++++++------------------------
>   1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index d5d87984cf..fb7bc5e555 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -773,7 +773,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                        BdrvCheckMode fix, bool explicit)
>   {
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t size;
> +    int64_t size, count;
>       int ret;
>   
>       size = bdrv_co_getlength(bs->file->bs);
> @@ -781,43 +781,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>           res->check_errors++;
>           return size;
>       }
> +    if (size <= res->image_end_offset) {
> +        return 0;
> +    }
> +
> +    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
> +    if (explicit) {
> +        fprintf(stderr,
> +                "%s space leaked at the end of the image %" PRId64 "\n",
> +                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> +                size - res->image_end_offset);
> +        res->leaks += count;
> +    }
> +    if (fix & BDRV_FIX_LEAKS) {
> +        Error *local_err = NULL;
> +
> +        /*
> +         * In order to really repair the image, we must shrink it.
> +         * That means we have to pass exact=true.
> +         */
> +        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
> +                               PREALLOC_MODE_OFF, 0, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            res->check_errors++;
> +            return ret;
> +        }
> +        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
> +
> +        parallels_free_used_bitmap(bs);
> +        ret = parallels_fill_used_bitmap(bs);
> +        if (ret == -ENOMEM) {
> +            res->check_errors++;
> +            return ret;
> +        }
>   
> -    if (size > res->image_end_offset) {
> -        int64_t count;
> -        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
>           if (explicit) {
> -            fprintf(stderr,
> -                    "%s space leaked at the end of the image %" PRId64 "\n",
> -                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> -                    size - res->image_end_offset);
> -            res->leaks += count;
> -        }
> -        if (fix & BDRV_FIX_LEAKS) {
> -            Error *local_err = NULL;
> -
> -            /*
> -             * In order to really repair the image, we must shrink it.
> -             * That means we have to pass exact=true.
> -             */
> -            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
> -                                   PREALLOC_MODE_OFF, 0, &local_err);
> -            if (ret < 0) {
> -                error_report_err(local_err);
> -                res->check_errors++;
> -                return ret;
> -            }
> -            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
> -
> -            parallels_free_used_bitmap(bs);
> -            ret = parallels_fill_used_bitmap(bs);
> -            if (ret == -ENOMEM) {
> -                res->check_errors++;
> -                return ret;
> -            }
> -
> -            if (explicit) {
> -                res->leaks_fixed += count;
> -            }
> +            res->leaks_fixed += count;
>           }
>       }
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

