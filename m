Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EE74FFF5
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJU3u-0006Eu-8n; Wed, 12 Jul 2023 03:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU3c-00066g-IJ; Wed, 12 Jul 2023 03:14:40 -0400
Received: from mail-vi1eur03on20727.outbound.protection.outlook.com
 ([2a01:111:f400:fe1b::727]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJU3a-0003GW-Kt; Wed, 12 Jul 2023 03:14:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLwYf2Ayfaqbim7niOkKHTuZu/ok2sObTayGgZwBVXqZykBYaczjKw0wIZsTN+VmTyxbFoQWhd9p1gXmxWBokkNfM/Z4Fd/cdCI/83iNRnBhxfWXRO19SV/JBh3ntou7nhdF7uKYd/i8vveQHeegKvjz519ioDG7yjZ2GlF6dYyPb2UfHkBD6IU7zCLJ8C9IZlLBUD0uxgCNu1wD5aQZZKRBT1e3YPfZptaAe8ZyD1LVX8hIojX3LtiPmVlYPTjaJmnZqNfMd73Xtd0+JitoWuvL0NrZTPfj7Sb7/EBo779DtDInkbuK1J8sXKplTJL2bHsVub+SmaXiN8MXddIevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HArQvn2kQCAMG4sQOlwbeafQ8oIQKyZe/tvOT16F5OA=;
 b=T6jZ2GSA0dXvi1NjxC+LQ2jmlCKU4H40O7odzNwzOGZzvtxRetSFG/mYPSqxcS11B0StOdkRVna/FxYH4p+FFVeI7fLmibDt4hez0GsHkjSt0a21pYsU4FZE6TAq2Bz5Bwum5otu02ckDa021JAsfukGWWoj4foWVY4+HSo47MZlzPK7VaycHTdf7HMiodXiRCQ7sD3ji7lifV0xzpnLVf7H2+UYkTsrkl8lGENEz6iPZnvCX4QFP/UugNM3eH/Dr27v5WsjsOyU+ax0bjXKF3Ff60eI20CQ0PnU/gnuw22QFaCLYKD6LVTow/M+Ru+LbkHbI/4i9snamsqYJnDsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HArQvn2kQCAMG4sQOlwbeafQ8oIQKyZe/tvOT16F5OA=;
 b=egGvWVD2H7OEX9q/jsDdX4N441McPKmrEDi/YfhklEUXvu6MlWjLczQHQspBXAdOINgSKyDw8+xBJpWOUYf7mxpGGw9UkjgU5uyyn5HCopnqvh60Ck+1APurXUPNbBfF+3SGN/d7TZJMCUDP17pcuZ6Rdn/e2wT+XX3SDWpcbRQyZ030oRKxh7O5wO2/OsSEt0eg15zrMuQEwDw5lxAzuOD/I+ame4SIS9MKZfAS5C7gkOFbrHyhQ2SXuHsFj1t0Nc42HDcrD10tiaK0lgAN7GgMPPeKNsPQjGAhfmJEhy4uAFcltyU1JjClY3JJK/H0Y2KfRgGknmMC1uUBXghfjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB9119.eurprd08.prod.outlook.com (2603:10a6:20b:5b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 07:14:33 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 07:14:33 +0000
Message-ID: <4dab2416-2b45-cfd3-8d85-b811891af683@virtuozzo.com>
Date: Wed, 12 Jul 2023 09:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:802:2::49) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 49061244-2a69-40c5-753d-08db82a7a431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcGRxT/6oObAkor3EA6OZ5A1DnS8A0Bv/0JApMbjSHVpdGoEKgv2mdathBo/tai+clsXRKxREpN6NWmz0EbW92A/g7VCS8vzl42hmNajnFSOSpRkOvU9wM0rLRpDmHoUdwctQgUqevPhO7oqFbXDpvkAkjdimQHzpXTPiRXf04ulUj5qThcttO3VRy1Tg+BTHHv4d/Do6tOFvHDfS7P41ctO4hvm8H71sUeVJQ8YUssZViI6MiPVK/1AZDhuBuuUaPH0+31oV4nmUA7Hh+yqsgkXuqOMwDjG39PIsq5mUzBPaajvk65gIpukqhWzZY2Mrj2ADs7XdkNEaf4oZqWyQ9VG02YY9cg/ms7FC+XunAeaJY5FLOwc71Hpojhcf7TrW0n1pPS3xYVr3Qw7i3CRT9my4MI9SHSOvgL0qTgsismMBEEOtkFlkNXt+0oayECXdgIWxFBnCGMARxEWV9vxhQKh3HgVTnGHfomIrcMHtUqyybRHeA7qwPM8b1ZNOSSJBSmQKK71LR3gBeHRqRSJnZGCQFwPxjeiyFbEu5HoXQahS2FBoGJH2VgpzupxxDI6ONLIDL6dYT0VFlH1Nevl0y6r5zwenSgKooxWc9urIQPmIIJwjaGBUP0mmh1RWrh5ZxWTK2QmARk4mJf46vmNSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199021)(31686004)(6486002)(478600001)(83380400001)(36756003)(86362001)(31696002)(2616005)(2906002)(6506007)(26005)(186003)(66946007)(6512007)(53546011)(8676002)(8936002)(38100700002)(5660300002)(66476007)(316002)(66556008)(41300700001)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtSbTlPYiswbmdEb2E1eTBpRVM0cGk1d3ptRURXM0dpSEhXYWxJVVBBYkNU?=
 =?utf-8?B?ZStLL2FmcHZxTFJLU3ErNUZOR3ZacUJlMWxWaTVpY2M5dFdwZ3B6dEI0QUtH?=
 =?utf-8?B?VHpFeHpJZEJ3UVdUWTQzb001dU5WQUdXNDVybXNmNVVIanFVOEgwcWVGeE5t?=
 =?utf-8?B?Skc4d0hqZVlycHo5NEZyRnZxNTloQ0oxdFNWVUhYSFJPaTM3Z01iQ0djVi9B?=
 =?utf-8?B?NmxHOXdzWnJFL2taMVpzTEFtNnBCbWhsTFMveHY5VHBkd3dHbmhnYjFlOXh1?=
 =?utf-8?B?WitEWmNPVHhjcW4yaHgySTRhRmNvYnNsNTVpZi81YnhWaTdkK1NlNmZXTE83?=
 =?utf-8?B?NU9yeHdIZ1dPYTVFRzJyRXlwQldwZ1l3d0dGZ0lPY2pUd2tFZ1ZYSkxRVmhM?=
 =?utf-8?B?MVphOWlxeE5FZmIwU3lSWmVMbkJmakw0dk5WYUlPUmx5bWRIVFcySmk2MTY3?=
 =?utf-8?B?MmpuNmpISXdXa3dEanI5SThiQk4wSEJ4U05yelcyRWdNbGd6Q2F4dDc2bmND?=
 =?utf-8?B?RU9nZE9DNUdtdUhuSHJSM2RvZmFJalhPT0RhOW1nOE90UUVxbFNzUW5mVGxt?=
 =?utf-8?B?enJVRkJWUlF2YzhiSG5iYjJVTVJnbTRyZjZZczc4eXRJcjhoNEpYU1NSOVFV?=
 =?utf-8?B?cExMZFdjZXlKUmpHNnZiNlc4QUdubGU4MlJwTVJYY1cyMGRtN2hKRCsvTHM4?=
 =?utf-8?B?bDhsRmhqU01kMHNqcUJ3MWxBMDFFUC8rQTdCSU9ucWJKTTA1aCthU0JnUTRp?=
 =?utf-8?B?cnprS3ViVGsxbC9Mb2sxeGk4RDFkWktjTUF1TWZYSkhOemVlYjcxU3B1elhV?=
 =?utf-8?B?YWRJZjVkTXRQbzhCYmdMejRPcXlSdUhBOUgvSVEzaVh5MXNDVnhsT1ZTUk1B?=
 =?utf-8?B?MjloUEFQREZNVnhzYmQwUENpc2lwdWlrcDBIRmxTUzhEVEY0YWFmK2lDK2ps?=
 =?utf-8?B?Ym9Ra3pxYUo3akI5OEhGbmkzZStvV1FkTHFFNHRGVGhUc2VpNGdRS0ZUdmNP?=
 =?utf-8?B?b1BVbVJpMEJocHBqMFM5Umswc3VzNGdHbFNNSHo2a2t0Wk95bVVxMzh6RHF6?=
 =?utf-8?B?R1JvampZL2NNRjlzTU9SeHhXY0JpcTg1U3hSQU00aXplUjZERlNzeDdOeUVk?=
 =?utf-8?B?bENDcWVaYUVtMEpUbjJkMmZHdG1sSXZBblJIZElJV1Z1dkdDSDFpSTZETm1j?=
 =?utf-8?B?NUphSVpVcnJpTEVWSmRpbGpjK3FSSmlNa1NXcG5kOE14WCsyZ3p4T1NmTTRr?=
 =?utf-8?B?UjFweVFXeElzUU5Sc3YzdUZIOTN0ZzFmMFFFM1JwU2tZODVFQVI1eHRjTU5a?=
 =?utf-8?B?Q0p6MkJuQzRFcHFITXhPUkhmQkNXbmVnK3JFbXROMmsyWDhxWllRUzd0eHRa?=
 =?utf-8?B?YmpZZ1ZTczh2MEprRU5UUjlTOG9uU0dlRzJJUEk3UHY5MEs0ckJxODFYWVZo?=
 =?utf-8?B?dGMzaGgwdE94WGFQZVBrc0ptbDVkV3NGcFZwVjFBaGNteHBhTEtCQkdoaE1F?=
 =?utf-8?B?M2dUeWx1UVhxNlJESUo1V2VEZXBKM3VQKzBFZGtJMENWdjJ3VkYwNTVEWlVC?=
 =?utf-8?B?L2c4ck9lVGVWZkx4VFAxNDBJWDEyTldENUhXemN3R1oyRlptd3VNOXpvbkt1?=
 =?utf-8?B?UFRqZ0VldnNxNWlLUDU2WFlIYXBNT3hyc2p2aEtxV05EcmlkMTh5VHJOdHdH?=
 =?utf-8?B?RGxhSFJVU3kwcHJGNHg5R2lXSGkzb1JkcU9iNVVLTVFVdGp2ellYZnp0TlRC?=
 =?utf-8?B?dVZZTkpBOFI5aEl4WUVnSXJKQ2JxNElSZ01HbUI0Q0tNbmpoL1JnTkhhYlNx?=
 =?utf-8?B?OEhWMlFJdDNXWlNuMFNnYitNeFRGZVJuREVyNEhxYjhWb2tUQTF0VG5IclhZ?=
 =?utf-8?B?cnVsOUtZOURwTzVXVDVwRTlGOXRSUmlLYUVvRTYremFFL0x4czZlcmI3RDVl?=
 =?utf-8?B?VGVPYS9TbFFMV0RMV05XcmVScjUxM3Y5Rk84Y1Vab3JsK0FYWTNQODB5U244?=
 =?utf-8?B?bW44K2w2VkRYZ0V1MWJZTGI4Wm9ya040aElxSzcyNTJaUTF3UE12c1VRYjVM?=
 =?utf-8?B?NllKTG1RYlgyNFZUOStzY0hXQm9hVTQ3ekgyZXFrVWpoL3RhS2l4NmE5SjNa?=
 =?utf-8?Q?Mhp+vT5lmbs31RlwPcXJ373X1?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49061244-2a69-40c5-753d-08db82a7a431
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:14:33.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxuhEEa3yy0lqdiMkaC9gjn1pGjBjdVn0zNYERMWWP+/x4faP+kEkU0P4VhK6HcbdYu/QzYHhSaZzUD5xdoITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9119
Received-SPF: pass client-ip=2a01:111:f400:fe1b::727;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
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
> Right now "qemu-img map" reports compressed blocks as containing data
> but having no host offset.  This is not very informative.  Instead,
> let's add another boolean field named "compressed" in case JSON output
> mode is specified.  This is achieved by utilizing new allocation status
> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qapi/block-core.json |  7 +++++--
>   qemu-img.c           | 16 +++++++++++++---
>   2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5dd5f7e4b0..b263d2cd30 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -409,6 +409,9 @@
>   #
>   # @zero: whether the virtual blocks read as zeroes
>   #
> +# @compressed: true indicates that data is stored compressed.  Optional,
> +#     only valid for the formats whith support compression
> +#
>   # @depth: number of layers (0 = top image, 1 = top image's backing
>   #     file, ..., n - 1 = bottom image (where n is the number of images
>   #     in the chain)) before reaching one for which the range is
> @@ -426,8 +429,8 @@
>   ##
>   { 'struct': 'MapEntry',
>     'data': {'start': 'int', 'length': 'int', 'data': 'bool',
> -           'zero': 'bool', 'depth': 'int', 'present': 'bool',
> -           '*offset': 'int', '*filename': 'str' } }
> +           'zero': 'bool', '*compressed': 'bool', 'depth': 'int',
> +           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
>   
>   ##
>   # @BlockdevCacheInfo:
> diff --git a/qemu-img.c b/qemu-img.c
> index 27f48051b0..9bb69f58f6 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3083,7 +3083,7 @@ static int img_info(int argc, char **argv)
>   }
>   
>   static int dump_map_entry(OutputFormat output_format, MapEntry *e,
> -                          MapEntry *next)
> +                          MapEntry *next, bool can_compress)
>   {
>       switch (output_format) {
>       case OFORMAT_HUMAN:
> @@ -3112,6 +3112,9 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
>                  e->present ? "true" : "false",
>                  e->zero ? "true" : "false",
>                  e->data ? "true" : "false");
> +        if (can_compress) {
> +            printf(", \"compressed\": %s", e->compressed ? "true" : "false");
> +        }
>           if (e->has_offset) {
>               printf(", \"offset\": %"PRId64"", e->offset);
>           }
> @@ -3172,6 +3175,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
>           .length = bytes,
>           .data = !!(ret & BDRV_BLOCK_DATA),
>           .zero = !!(ret & BDRV_BLOCK_ZERO),
> +        .compressed = !!(ret & BDRV_BLOCK_COMPRESSED),
>           .offset = map,
>           .has_offset = has_offset,
>           .depth = depth,
> @@ -3189,6 +3193,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
>       }
>       if (curr->zero != next->zero ||
>           curr->data != next->data ||
> +        curr->compressed != next->compressed ||
>           curr->depth != next->depth ||
>           curr->present != next->present ||
>           !curr->filename != !next->filename ||
> @@ -3218,6 +3223,7 @@ static int img_map(int argc, char **argv)
>       bool force_share = false;
>       int64_t start_offset = 0;
>       int64_t max_length = -1;
> +    bool can_compress = false;
>   
>       fmt = NULL;
>       output = NULL;
> @@ -3313,6 +3319,10 @@ static int img_map(int argc, char **argv)
>           length = MIN(start_offset + max_length, length);
>       }
>   
> +    if (output_format == OFORMAT_JSON) {
> +        can_compress = block_driver_can_compress(bs->drv);
> +    }
> +
>       curr.start = start_offset;
>       while (curr.start + curr.length < length) {
>           int64_t offset = curr.start + curr.length;
> @@ -3330,7 +3340,7 @@ static int img_map(int argc, char **argv)
>           }
>   
>           if (curr.length > 0) {
> -            ret = dump_map_entry(output_format, &curr, &next);
> +            ret = dump_map_entry(output_format, &curr, &next, can_compress);
>               if (ret < 0) {
>                   goto out;
>               }
> @@ -3338,7 +3348,7 @@ static int img_map(int argc, char **argv)
>           curr = next;
>       }
>   
> -    ret = dump_map_entry(output_format, &curr, NULL);
> +    ret = dump_map_entry(output_format, &curr, NULL, can_compress);
>       if (output_format == OFORMAT_JSON) {
>           puts("]");
>       }
Reviewed-by: Denis V. Lunev <den@openvz.org>

