Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA2738E4B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2KJ-0007AY-SC; Wed, 21 Jun 2023 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2KH-0007A6-UQ; Wed, 21 Jun 2023 14:13:05 -0400
Received: from mail-db3eur04on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::714]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2KG-0001Ze-22; Wed, 21 Jun 2023 14:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQVQ4CPNhFlEu92IrQsUXDI/gwDCDmkbdeNwmCeppPK84czDsxARmpTyKxpt+y+V7yIRYtwI78Oftn8CJqS4k1BLYBRzMkUUr17YvCacH/csQeI/HQZFysXdFLfpuDddy59dfhnGB10a4jGGuCkn0Da8MdfmRC/hZj9nTrA3CnEIHXMksy6urVO2vsYxlTfRnwhVMnPxvEUoaGmqCZzQU3qxMCeKkOKiEm2uHBw14qgAHXQj+JpXP6XbXwf9F7Y+tsWQ6zmGzds20uSL6msJesNl0cpPSQ8VteJ9EEfRHLMWglP0uW+wDlEGiukiNy7bigT/JSDW4hJjU4DnCf3KBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9rK2mTPtaCCXVD9SQYj8MgfvDvpBvlurCAwjVw80Fo=;
 b=bdvczKLBt6hQ9LKHv/45FmbkdY//wq0TBz8KqloBeo0T8r00eXEGWNQX2KYP/IfrjEURmQAHzdRdR6LRTlZl8ixBWp/lr/bys+jBD5BfsbnViMMoPuUeH1T1HPVXH2wp9+7SNwokLGgd8ZCauFrUcEL6veaBwnN4DQ1bz1E81vjmanTqoQP+xkbbr7jmE1/GIYxogWST/JOhMzBtKW+oUrRC83dr0bjpxNXsqGRlQLxv0kAG8eK3Snirl70MH9FZri96lz7xDX0QCEozPFEOmS81hrJPO4vCaidK4tm7mfREamo+3aAO7tETJ5UunA1rPCnBjrqcIi3hNJTqX0o14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9rK2mTPtaCCXVD9SQYj8MgfvDvpBvlurCAwjVw80Fo=;
 b=j52WtKOx1GBQyMbDGn7U1avhA75htFjfMxVsIHWcuKjlJ5ahupD8ypIMDrbsyKY9FlUFelyE+Mz92PS5iIaApyjynlTArRdxDMGG4+UctHSWph7dPYGzswMiygeAsLAw6BHNtS8mCg/rMLN3VUkmM44YojiHd9X6YXa0yGPBi7QCjZtlwbyGi0h2jyHA74lGk4ZVEtoOGM2nByta4vhmBfcpv9uH9tnP3iKZYiLLSX62gC1EIChjrn+mT8HdoIbB7LJTe8dDBSJschJm4fB9mdBxwG3xGBQR3fc2XMWYCm7A9NtYPfdrup3vkesxIZ7L0FRELUMmZQMGTjeduwsWDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM8PR08MB5747.eurprd08.prod.outlook.com (2603:10a6:20b:1c7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:12:58 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 18:12:57 +0000
Message-ID: <0398442b-50aa-fe28-0379-3b57ef749564@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-3-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230607152627.468786-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM8PR08MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 3993b9f9-9707-4547-8d8c-08db72832442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfMX6RQHoyqDSOxadFjeisIf8VaJF3LX8/e4NAWYrnAS5SC6h58LFUjm1v136KCagB87BxgfWRYGipB6NLSSuk0FB2Y1vUGZCR0wO+pIxHADoobNXguyGjdKt0kGeZ6mDrryRRlXYv1TQ0w9/giXjYl+qObfSYEk5aKl3xmflmB+k3sd/sQZCV82a7KVP2IIzWQ34zD0Zp2tyTdmnEE/Rn1oZqha2STJmtCO7blZFC1Rlm9yY5Gd/HBDqSHE7cpFoC8qBJfJsuw8NQ4sHi5LJje9rd2qF4OXj5ReuwK8Ai+evTBs35mGS0EF9XalpbJKd2gNTI1pmeFGAxvZYHAde6EKS5ZobkYOu5l6IRVfG+C22XQRI9VWJ4fYIsEws3ttzlx/UEGFGJ+2hmkvAHmDWz9BTeNeAdAl673LkWzXursVUkgOf4Pm3GJPh7NNrwbpdIgPamiLH5TAefVVqbS4mohHToeJKupu6i3tBB6LF7xXopFODKADL1S2RVgQf3LWGm6xAmq1NjWd2D6uM+blEWOEUNySc5KzE5Taet1M8Txg9kUD31F6Fpym2vwk2ZmlmA98EG6jiv2zrT6UgKaPWjYAJeyqluIFYOlEjbqHqhw8Dh6GOL5fnq7CjoTTaSne0DTaKsK9r3OJCsLYYS/0pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(346002)(396003)(136003)(376002)(366004)(451199021)(8936002)(41300700001)(8676002)(53546011)(38100700002)(2616005)(83380400001)(6512007)(186003)(6506007)(26005)(6486002)(478600001)(31696002)(86362001)(316002)(36756003)(4326008)(66946007)(66556008)(66476007)(5660300002)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGU0ZTV2WC9tRm5CMngzK1dxY1dsMTlDT29tRGViZThEMHFQSnUwaHZpcHg0?=
 =?utf-8?B?L2gvdmFqMys2czNDM3RJckpBQ2IvS3l0ak5YY2NyQzZaNUUyS2pDK2c3UVdv?=
 =?utf-8?B?MGdOL3ZCRDZocTRubTRLaldaNGFZaFlhZ2tnVHY5OElxQ1p1bGVkdGZLUWxt?=
 =?utf-8?B?ajdLRXhvWk9CTzIxKytRNDF5Qnk2WU84bGpsR2tDWEJmdUpSR2loWm8wUXU5?=
 =?utf-8?B?OFZTQWlMdzZvTFF6MU1jRTZndWlNUUdUWVV2K01kZFl2dFNKeU9UN3hha2VE?=
 =?utf-8?B?cm81dXFQSG9NRmttR1VSWklnRTFocDR2Yk5Zd3JOZlNRaWpRTlU3NFVnbmhS?=
 =?utf-8?B?c0ozTEFKZkNDdXlKUUk5THhIMTBuOFJXL1czdGRnK0d0QUlMNTJZY2c2Umlu?=
 =?utf-8?B?VkxTKzB0Y1ZPa1Z4MWNySFZIcFFWSXV5MFFjYmVUTllNL0k0RDFLZWdpZXVS?=
 =?utf-8?B?Q0JPT05JNFJYRVpkVDYwRUxIK1NqbE9mL2FyaXNlYmdTVnJ5NVFIMzFjMTVF?=
 =?utf-8?B?UEh1RzJyczVsd3Zad0NoZEJMemo2dzdvVUQzbnA5bCtaOU9MaDViUG5qTEp6?=
 =?utf-8?B?U21lUE05U0xFTDVrU1RRZ1N1RUc4MzlFbjcwY0puWTNDQkl4ZEtVVEk3TTNp?=
 =?utf-8?B?SHBtY0t5TittVDhLR3pMeGc4S3dCS3FJejlWWUlFVkI4c3lRU25HMnZPWnlY?=
 =?utf-8?B?MGdLTllVdWhORldGTmpOdHgyTFI2OGFuTTZ3bC9OVmN0YjhuaG43QW9PTmxi?=
 =?utf-8?B?WnQ4V0lBc1o2eEVOaU83bDlOUzZUcExzUS9hM2VPNmdBNUs1SWhDZEIrZDNE?=
 =?utf-8?B?dVhQYXB1blFYQUNVM0s4bVhsSFg1YUFLK3VxZkc5Nmh2aWtPRlJSMHVWRnk3?=
 =?utf-8?B?ZWJaQWNyVkFVQVdLckdFeG95dm1LR3R5WmpmQ25kaWhrK2hDTmgzSXBnUHlR?=
 =?utf-8?B?MVU5NHdIcWFkcHVZN2N1TWlwK0xkYnNZQ2RPdFJFQTBuRzA2QWJIVnhzcFN0?=
 =?utf-8?B?YkFqb2EvSDk5ejlkZElUazhaRE9XRmJGRnJjNFBiRWkraHRRU2Q2cVowRWtx?=
 =?utf-8?B?RVlOQjhnblFhWklEWksvVjY1WGdIdHVPNGJPNGlZeTFlU21XWkh0MGsyejVY?=
 =?utf-8?B?TUhwL2QrTXd5VVZRMmgybDIzUi9OdzRpN0d1eHdQdlhWSkJvQ0pPMEZrcS95?=
 =?utf-8?B?ZENlcWN3RDdFUUE5OGJpT1d3T0tRWG5KeGtiOEVlRHhITDRBVVlacDFFdUly?=
 =?utf-8?B?T3BnekwrbnltQmcyK0JSeU9ESkp5WHNnZ2lzS0IwdGROSXN4REdQYjBKb1Y1?=
 =?utf-8?B?RlJMUHRlUTkyQjN6M3JxN3g3WVRYMU9MZ1lJdWlmS3dOMzhRcFlkK3FkMzZE?=
 =?utf-8?B?OTljWk12NWdOOUU4bGZYYXR1SmhWVUxzQnNheEdYV2JTRW4ycnpRZW92SnR4?=
 =?utf-8?B?L1d2YVhUc0tjY0pOMEhGVDFQbDhibXlRVGdlZFU4bCtmU0lKckxwZy9RWmtL?=
 =?utf-8?B?TDlkYkowSFNLNm52VEFmWml0Z2ZjOTVjZUpaeFZYZC94YXZwdkluU0s3MGxG?=
 =?utf-8?B?cGQzdGlJMGlONi8zSGkybzVBZUJTc0NDd3JIcFVNRTVBTktpQTVQQkVkK1NJ?=
 =?utf-8?B?TDE1dEV6YXJPbHJKeGFMejQzKytxU1BwSFpHYzd1cmMzU2Jkb3hwVFZvdmFZ?=
 =?utf-8?B?dUdsYzJHRnhuZmJNRHd6RStHa044cmt1bXhLNWxVeUw2N0FXSU9TZmFXQmxi?=
 =?utf-8?B?aXNrOU9SQy9wVXJzZkpxSEgrSEo1ditZYmNOUU9hbDhEK2ozR2Vhb1ZLTExP?=
 =?utf-8?B?NWQ1ajVEeW5ZSnZiRUZzNGxTU1NrODNjTE42eC9nVlJhKzFVbUtZOEJKRVcx?=
 =?utf-8?B?bnBnUS9XejYrRlQvVzRuZ1ZVQ2V0SHJnejBGZmM2SmdMTU85N21hOWVsZWhv?=
 =?utf-8?B?MUVpcTNYcHNIYW9zQ1B2VU9RRVUvVGVEbGNNb0pVR2tMWUtJMEhuNlFJZjJJ?=
 =?utf-8?B?TktmelV2RVpVUGQ3NUZnekhabHVlZ3U1SDZhZ1J3Ym1uNjBhd0pKWGVNcVU5?=
 =?utf-8?B?TGJYK01acHZuSmE3RlV4QzZJSW83TUZmc1RCaFFhQ0JUUXNNNFAzdUFjMWMy?=
 =?utf-8?Q?2qnEp+/aIIpS/qoHuIHXqqdFb?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3993b9f9-9707-4547-8d8c-08db72832442
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:12:57.8860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfmQ+bNEgiJtuHP6RUht3lHzQCXtlye88Vhf2/gsPUxzevQcZB98j79lxbJBAhENp4PtokFcyuRSHr+M5SMfnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5747
Received-SPF: pass client-ip=2a01:111:f400:fe0c::714;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/7/23 17:26, Andrey Drobyshev wrote:
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
> index 5dd5f7e4b0..bc6653e5d6 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -409,6 +409,9 @@
>   #
>   # @zero: whether the virtual blocks read as zeroes
>   #
> +# @compressed: true indicates that data is stored compressed (the target
> +#     format must support compression)
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
> +           'zero': 'bool', 'compressed': 'bool', 'depth': 'int',
> +           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
after some thoughts I would say that for compatibility reasons it
would be beneficial to have compressed field optional.
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
If compressed field is optional, then it would be reasonable to skip
filling this field for non-compressed clusters. In that case we
will not need 'can_compress' parameter of the call.

Ha! More importantly. The field (according to the metadata) is
mandatory while it is reported conditionally, i.e. the field is
optional in reality. There is a problem in a this or that way.

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


