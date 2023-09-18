Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5480F7A4315
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 09:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi8tN-0004IG-Ll; Mon, 18 Sep 2023 03:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8tI-0004Hi-WE; Mon, 18 Sep 2023 03:41:57 -0400
Received: from mail-vi1eur05on2071a.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::71a]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8tG-00043l-7V; Mon, 18 Sep 2023 03:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRBYEIcOyzfm4CpF+D2/I899i4JxAnkgKloaEg/1sKOX41K2rgrEl+t6pWFQCG9rw8FnJxJnwFJJLvL2468mjEmwkFZRUrykqodGmw9x680PKJ+jMjY6aX+kJrCWTdSJ2qOPXwda7+hmn4rXKdGX/2wJrkg3CtOcWx7zOIbMSo0s9O7RPpXrILgQiN68eBArLh3GPzcmrlQwriVzNuShVT3qq7lE17CJjczjrFRvQrR4KWcWuU4ae9dAJ7oKDUk2Wc4E/4aJkD/KbZQoX7SB7VRFoir4/5gu57XLzAmyDOAQtY12k0oHCRUHwiX76FTmsDGPpmLL0bd158fNr96d8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZmPw8aTk8wUgpLSalay/AfghuiPUcqv89xQvn0OEoI=;
 b=ITr+1jsybSEJzEpzPycGpgTQdGCRXH/HD++o2e7fq6J8z6x4/yH1z/ZXx2o+fiwG1s9odGJjAM99cuERko2aujTZ5p94h8TvhcKzWLjX9L0FPVL2bT9EIqCAoLHNGRBrVbNcLHwfxOZwio7J2jKBkUUxc28c0M1QzHk30a8TRuEebb/WSe+rciDdeGlavwngD5W+bQ1JQ3XQ+eSg95A4szD7u/Iy+iCXdODWIAUwWCYPvIQySjGPTLuHCoXPGIJ9jiSK7CgNSJMKZSBTH33q6VR5BbL5AFVZbhx+C3xLDqjrY8tlrZq5e2pBlmpUo3thtHWvN6CEUp95rR07cwnwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZmPw8aTk8wUgpLSalay/AfghuiPUcqv89xQvn0OEoI=;
 b=SSDs8UFlw84ImAtLdV9SCHlIiDO1lnUy6fvcApRTxZNKp0NvTOpe5YI9R5B8x8mKG2qRNdQcJ3hyAN4b+n3XyaI6k705rFeBFlSZk+wK12Xn1Ye+Xkk0YPkKGhfBaCsoUn2OMvK0CHb9Ce3h9V1D/m5n+U1ZLdL9Ag8P6qwokb+bKXsg8VdQZA8hYMR9zdCve5J3ilRECFJpSGLWqlYylMKZdiOg+KvpeJy9RHeyQaOvjLJFTBHXUFzRyRjMV3JB50gUUfnyqBnqjvTNE+6GCb5nJbCztydDmTQrtrJv+oyTC64p9HZtddNESrJkEwwQbYKWaCCtxIM9tlu0ZG4ZMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8637.eurprd08.prod.outlook.com (2603:10a6:10:403::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 07:41:47 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 07:41:47 +0000
Message-ID: <436ff3cf-1833-8ee6-d0c3-02686d944b06@virtuozzo.com>
Date: Mon, 18 Sep 2023 09:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/21] parallels: fix formatting in bdrv_parallels
 initialization
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-2-den@openvz.org>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0037.eurprd09.prod.outlook.com
 (2603:10a6:802:1::26) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1d6009-f84f-4655-0f07-08dbb81ab631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG3WRmMrkAMpV56mXPTbthBmLNlhMLRs0dPeVZhZxzm9PkE/1fl8BMJQC5UZYnb2LqTIxlxR72r/TN2eM0mW6ln+uisYY+TuVEzIITqRpzSBycIGzWl7pXeer7qMUw9KJQhW5kzR9x8qUAPv0ihExkc9lxlukkVE6NBzwMMBMkDJxL3Ikgmt6EbnjGxHcMTwY6K1PLBdkLrBFs8r60bgPg3DN8mgHuJ9pXdJe0LzOOTEdV9VSFDJlfOxjTG3mFxva7FMkNQzW4fIdgT90sCjVN3KEJnwQalUzV3CNX2DeiH/V8P/U8eqb11gTPJDDREYRKmiGKxe5jiJASgHm5MEIc6rtPe38YftXAaDwX9/5/yVKSgi/kcIrbMN0RUwLpVm2abX9nHFdwryODtg33V7EirL4EXqJ7OtacrEVGq6/hGxg9yzRnNS0T62UzS5dAXObbUUlCYSbvOcdOOjf1c+tu6DxwP4uzIlvjF+RNpHhBN7bHv33833S5KUeEaZHSn6gxW0JfIjC050/s1Hz2j+b3YmuEX/1Yj7T2Wrk62GAVTWr8xZuSJUsx+4aANvl4tVJRYeL+9Ks0IXHgnmpmfyLXCXhwDORUMUgZcPT6NdLEFMf2GHayCR+T/eKWEpeRXi50GoDiJuLL+VyZS/GlRiwsCtaAFqktVheQ98wm6YGDISDEs7puMJf+SXoeUIVH5H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(53546011)(52116002)(86362001)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(38350700002)(31686004)(6666004)(478600001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRadkFiS04yZzEzUmMzeEdoMHJRdmRuUHltb09JNldHUkNjVmlQVXBmcDda?=
 =?utf-8?B?aUVwZzZUTkwvTFNMcE92NlFzYVR1cGkrMGxyYlJHNlJVTHk4ZENRQlhvV2xB?=
 =?utf-8?B?cTNwZU55b3gwOGJnck15L0NEbnFNeG5nNlgxenRjbURxd2FsT2FqREd0djZ6?=
 =?utf-8?B?dERkM0ovYzdzR1JDS1BsZ2Y4RC9UR1lkZWgxczRYcEN6K0xTZEZ5ZmF3V05l?=
 =?utf-8?B?YzRlZHpnVU9pbCtMNzN2ZFBLTVpCbXcrRzdHNDhxWFRYUnd1NjREY0RqQ0FI?=
 =?utf-8?B?VVlhd1BMeDBHak1mVVFvTVdqZGxjYTQ3SE1iUzNuZTBxNFJOUGk3cGkxay9y?=
 =?utf-8?B?TzQ0eVBtOU1OL08reG1LWGF1K2pLNnk0NTFUZDVtN0Y2SDdHc3kyUjRuWDJo?=
 =?utf-8?B?MVhlT1lFNGZYWnFTK0ZSU29RODh2QXRTa2xrNXB4QWFLMVVoanJTSXEyVGNh?=
 =?utf-8?B?VnZoelRwQlpIUVNDZDQyM1BUYjRVMDNoY1d1bi9abEdnYmhTbUNCU3VralpO?=
 =?utf-8?B?OU5xRTJOTzNOVGQ0TE82UWFrekcyTUpVVG9USlFOZThmQlorMkxpeGk0MWIx?=
 =?utf-8?B?WGtFNmJxVnkwZlB1RnBzYmxEM1NiZUcvQzY5b2lHZGpyaFJpMGVvSXE3OUdX?=
 =?utf-8?B?N1dIR1Bkb2FXRDdJVnduaUJrcXpkbmt1cjNNOWdiTUhjRXJwek91RnBhTkN0?=
 =?utf-8?B?WCtyWnFwdENCNG5aQy9ZS0Q5S3dJbGk4OGdPWkIxT2N2WnlubUpaTXd2TmJY?=
 =?utf-8?B?Y2JmQVhhOTNyT3ZhZmFFSi9rZEpZeHFncmE4cG9Vb2ZORWc3ZURLb25zaVBa?=
 =?utf-8?B?eitTMlozNW82Z0FLMnB0WGFYNHpydGNuT0VoVzg2WlpGdGhEMWtvQTdvTE1p?=
 =?utf-8?B?d3B1aHNsWFNhWWlsUCtyMnROalBJRGFFT3VSR3cxTlhjL2RqVDZYYlpXVUxD?=
 =?utf-8?B?MHppSTgwZ1lsMG5QV3AyalZPWG1xUkltVC92M09wN0NGdnpFL1ZwSFVRRGtu?=
 =?utf-8?B?TW1DWFhqQ29TS3d0bzdTS2xpQi9ub3ljKzNSY2ZNS1dFUFFGY1hWbk9RSkZa?=
 =?utf-8?B?VWlLcS83NEEyZFVMdDJJM2lVZHBWeVQ5QXg1VDBRRXpJa1lLUmUzS0xVb01C?=
 =?utf-8?B?UHlBZ1BJeEdrOU5zaVM0eW5kMmtINkdyc1VQNHRuRzVyQVBHU1lJb2ZROFlN?=
 =?utf-8?B?MGNlaEpBV0FUYTZMZDh6Wk00TU1mQzhuVXlmR1RUYUlXLzZEMWhTSCsrK3lq?=
 =?utf-8?B?Rm0ycUJlaXh4d3hHZHlNTnE5WkUxRnRiVXUwUUhwMjlMNTZXeTI5Q2owWUEv?=
 =?utf-8?B?V0I1aUM4bjB3VkRQcUU0SUdERUcvd1crcXFKcENWaHZKT0VkeHBPTlhQTUR1?=
 =?utf-8?B?Wit4ZmN3QmtSVzVEMWltNEZiQ0ZMVTQ4RGlzM0xEbWg2MDA3VFR3eGtaS1hY?=
 =?utf-8?B?RjR5aDdXdXdRbkVrVWxXeVBzTUgwWHJFTExlS3kyWGttMUxmaDNsdytXTTJv?=
 =?utf-8?B?ZnkwcVUxMUQ0TWh4WHFEM3cxeXA2RHIxRzZhWUYwKzRKd1NCLzVJY3ROdVoz?=
 =?utf-8?B?VjVCZmFMT2NTcWdFVkloTnkwOElkMGNhMDdmb1Y1WTh3ZTN1TzdXZjlQS0Vu?=
 =?utf-8?B?YW1nMm1vSlNDZFBhT3d3UDhabXkrSk9hUXNRMmlsNmRVOE1nVFc4dDZmVWxk?=
 =?utf-8?B?YUJZYlNJQ1p6czZDeEF2MC9ZTjJtZVFSQ1dJQnQzeXNRQnB4b3lRRmFoUW9n?=
 =?utf-8?B?Tit1N2xYKzdVdWlhdW9TaTNYeDYwSHJ1aVIvZ1VlQS9KV1pLK0d4dU4wSEpv?=
 =?utf-8?B?N2JwUFJhbTlOMDJUL2g4SzZmeFdCWjIzQUtZNUNvOHZ0OU5CZzR0VzkxY3Rw?=
 =?utf-8?B?S3RXdGlUQkVybDcwRHY4ZjBrbHk0cTdLL1NZRjE1UDI1Z0pxNUVTNlA4Z3lX?=
 =?utf-8?B?SHBqQzFlV2puSDYwbjQwd0IxVm93Y0xpOUtCU0pJZS9IekhVbGcwZXM3aFhp?=
 =?utf-8?B?ZWtPa1FzbWhxcm1UY3JiWW1aM2JaWWwxSk1rc1Fub0ZnOEVwMis2TnN0K1N3?=
 =?utf-8?B?dExHVjJ4MlVtcjlzT1VQOVNCWXVtTGlRMjEvdm1GT29XajkySGE4a08xK3lQ?=
 =?utf-8?B?czRHWVVBeUtKVTJDd25KRUZRZ1lqdjdDTU9ObDRIRWZCNmh6QUN0T2JnUjNz?=
 =?utf-8?Q?pnnd45HHrNZxIE4tkFxbLyQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1d6009-f84f-4655-0f07-08dbb81ab631
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:41:46.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxF+TkjTFHDvqXkWV/eqkiIEC3YTEYul2nfIvniL5U+oxUz5ttWHyPek2C16SDMf1WTNyX/mN7isIu5owGO1DvCKDJp1IJrIZdAUemsO058=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8637
Received-SPF: pass client-ip=2a01:111:f400:7d00::71a;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> Old code is ugly and contains tabulations. There are no functional
> changes in this patch.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 48c32d6821..2ebd8e1301 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1249,23 +1249,25 @@ static void parallels_close(BlockDriverState *bs)
>   }
>   
>   static BlockDriver bdrv_parallels = {
> -    .format_name	= "parallels",
> -    .instance_size	= sizeof(BDRVParallelsState),
> -    .bdrv_probe		= parallels_probe,
> -    .bdrv_open		= parallels_open,
> -    .bdrv_close		= parallels_close,
> -    .bdrv_child_perm          = bdrv_default_perms,
> -    .bdrv_co_block_status     = parallels_co_block_status,
> -    .bdrv_has_zero_init       = bdrv_has_zero_init_1,
> -    .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
> -    .bdrv_co_readv  = parallels_co_readv,
> -    .bdrv_co_writev = parallels_co_writev,
> -    .is_format      = true,
> -    .supports_backing = true,
> -    .bdrv_co_create      = parallels_co_create,
> -    .bdrv_co_create_opts = parallels_co_create_opts,
> -    .bdrv_co_check  = parallels_co_check,
> -    .create_opts    = &parallels_create_opts,
> +    .format_name                = "parallels",
> +    .instance_size              = sizeof(BDRVParallelsState),
> +    .create_opts                = &parallels_create_opts,
> +    .is_format                  = true,
> +    .supports_backing           = true,
> +
> +    .bdrv_has_zero_init         = bdrv_has_zero_init_1,
> +
> +    .bdrv_probe                 = parallels_probe,
> +    .bdrv_open                  = parallels_open,
> +    .bdrv_close                 = parallels_close,
> +    .bdrv_child_perm            = bdrv_default_perms,
> +    .bdrv_co_block_status       = parallels_co_block_status,
> +    .bdrv_co_flush_to_os        = parallels_co_flush_to_os,
> +    .bdrv_co_readv              = parallels_co_readv,
> +    .bdrv_co_writev             = parallels_co_writev,
> +    .bdrv_co_create             = parallels_co_create,
> +    .bdrv_co_create_opts        = parallels_co_create_opts,
> +    .bdrv_co_check              = parallels_co_check,
>   };
>   
>   static void bdrv_parallels_init(void)
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

