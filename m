Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C282F0CD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:46:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkho-00050F-Dr; Tue, 16 Jan 2024 09:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkhf-0004xm-CV; Tue, 16 Jan 2024 09:46:11 -0500
Received: from mail-vi1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::713]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkhb-0007im-0i; Tue, 16 Jan 2024 09:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swor2qu84M9SaDa+vs8e4SKbv2j30F0tl9qUjXVJCT6hN/ATkYvewKrqFw7nIw4vBeYdj5HmfKoBtk3Xpx3NYx5Equ+UjUGD4/rQxPoRzP7maFOyy95w/tpvX3z7hoqiqG4CgfrLfI0z2g+yfo6xfi0sWMwWNx6ilgtZXXKS4wu9soZJzB+CQbS+j8PXyVCvN/VwRJh2I3mfvHv2+2Jr6jVfOzN633dY50IZ+OzSmPu/6t0db74TEV44TKWc36Dotcl4I39cvsSMCCYSyOMK7T1MFybmQXlBlxq2Ub7FhGLKlZmXbx9ePxlEh+tW+ORv77UYS/sQJHjv8WawUfVKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bM1/wZJNud4yk+kU6vLkjwq02tCNy6HWVn6atsHsAs=;
 b=Y6Z68Cfld3dhAo3T1qlD2P/KycymkzfxeiWIhIZD8nQatUzkF90TFkkjzbCW5N3wGnr9EO0pwkFWxbzXrudqIlr69ngVge6yLef7U8zV4gRQdiwTqjmNgG9mnK/ZUChWIM1tEoDC9mtMYYYpc1qrsi/sJeil0p61pFaZGD/dIDlZCK/vUXyaJ+KkWMTRXKdQgBrb3UveufbA/Ht1TLrp68B2lPn0crD5/2UuNlJIbUM1Km/FXooAg3lQuB7ZX/4sPjesYS8q3UePVT/cFg5uprtRASJnd0gPTv1r//n0sZ+5x29+qi22+bp2yTLtrH8/IHwpury9eqWDbo9aETpJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bM1/wZJNud4yk+kU6vLkjwq02tCNy6HWVn6atsHsAs=;
 b=w6jA18Bieu9ezbf/bj+JXxMmHvnDEzQp7scXEcMiBsvJjd0YJ2xZTyQOiy0jTtiUgCSoO0jQLPZsKIC4m0VBiZBNExGR06JzxNc7TmgvyhMcEmH1L+G1G3mN7Z40JJj2yyrV5T4Ymc/45Wn7wMfSHhQdoMZ5nE9ZAvQSowmttkwBUidty88FUSCEI5mNGsYh2Jz/g2PZA7U56x/WQpXIsKeBQ9/LcbZWZAylYVcOD8KuzgknYr3JmmF8sLLpZ1dEa4KWZQja5AKeO24BLEJLHJXKqoC6fIMvLuGoIWjq8sBpsy1HegcifEjMevfut9R//kuwAkay0hz/ATJ1Ls38Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB7661.eurprd08.prod.outlook.com (2603:10a6:10:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:46:01 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:46:01 +0000
Message-ID: <a9791fbd-e07a-4757-bb54-b4283bd7f4ad@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:45:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:803:118::43) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ee2019-cb03-4358-0a2d-08dc16a1dbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8TrgIgyngLGuu/v7igj8nHQwbKUzlbrREJqgrjmAZjTkmoaWOkg9dgIS02mxywymxAI9uQ7pnT1Eb1iiRQ9kAiGK1FGPczwrjMHFgHCu5Jp3vh58AbLdcARf86rcTZIw093NX6eLb/Yw8jYK7S4PT4e/s24hgegaiUFMm6dTEAQIR7jie6aWWj2p/7zNgu5chDv8Fa5QYNfiE/Shp0t6We8NpqESA6oxU+Ovr55piXX0fffilgikyXA8x8rcGYrq4NRodK/3jV85vPoEzM7shWQ5nvnnipN9rmp5a5NdX5+9gpxQNsC958aKEsQgimr5WxuALkHYUWLanqoh91tLTRpMbUoLy5ymCRbH3NqvSgVgT+hUq4Oro89k1sMM6r03gxd+VhgO/MnE1FnNFLtkfmkEQ56pC6hFVJXOiH6IO4LURsuJTJbIzimHRCBc/JA3EBgI4ReOeIb622Y33W7Y4DH9w3ItkwfG1Nbf7I7rBytfisMA+JLOZNZ8sVIcsOSzgPaDbrn0MaW2HLy5wSQNDexB8/49VNCn9BdmRPGlBbu04JC+D2Wu7Le13gsqYr04E76HTxnOI3UEHgYxqW4SNPuwx0VT1YlnKtCzdj8NL4q6ZFHXvb5llwQPq+N62pmzSUDhdjpOEKMUZtd/VJgu5KRf/0NtN0RwvoarTvT5sSPhAkIOobrZo7cmGQkUJJa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39850400004)(396003)(366004)(346002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(2906002)(5660300002)(36756003)(83380400001)(86362001)(31696002)(316002)(6506007)(53546011)(6512007)(478600001)(26005)(6486002)(66946007)(66556008)(66476007)(2616005)(38100700002)(8676002)(4326008)(31686004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZyVXBUSncwbzNqTG5TUXE0TkNmQWpBZUNJdUVuRUk5eVJ5Y0dwUGNNU3E3?=
 =?utf-8?B?MXdqc0tFWnA5Y0phbVRIdS94L2FDM0Z5anNrRnVid1JvSVRsRkNBWDd5MlhC?=
 =?utf-8?B?M2dscXlIMWpVTm5aOTJtWVFIV25VWTl3S3BoNU5LQWl1a2JsYUg1MEU4RjlD?=
 =?utf-8?B?WmtQU3EwK0h3Ri94czBqZU9oS3lJeFdYcVBCdDRTYTFyMWJCL3RUVDJUUmdY?=
 =?utf-8?B?WlBrWG16MWVTZkd3MlE0d2Nzb0xGdjJ5QVhCMjNLeEgzREYyeDRTNU5pN2pL?=
 =?utf-8?B?YThUS2RPbGV3dXN1RytWWVQ5UTc3N0JMamZxLzY0a0dIN05DbUZpbUJQcVJR?=
 =?utf-8?B?bWZYM1p3YlBvWk9Zb1owQ2hISnBWUHIwUHU2NEdOdHZWRGJMQ1lnL1MyYkxJ?=
 =?utf-8?B?WXZxRGJyZ2tpR0V1T2tGME5HNTY4dWY0WStHVWNTMmZPYUZDcmJoV3I5dlkx?=
 =?utf-8?B?dTdoN3cxVkxzTlhFUjRCTTBtdkNKa1VHUHlOTzVyczZRUmRSWUZ2TnpWWG1V?=
 =?utf-8?B?QXRGUklrbTFTSFlwR1BacWRuZVlmNGRxeUx5M0NFUWlaa21GMFRIb3VzRCts?=
 =?utf-8?B?UGFZMFlSb1EzWWt1TkRZNkVPT0ZUZzFZUjhRNk1UNGRUZktWeG1LTGdZTlAv?=
 =?utf-8?B?NGZGdWJaM21idzgwbVQyNFF4N0owSWgrZDBaeVkzck9SOTRod2NHRFBLWU9C?=
 =?utf-8?B?U1VSNGN2dWJqV3Rnd0RvMDJRTllGM0M4TFdZS2IwRkxnTlVHM3V4YmpYSzly?=
 =?utf-8?B?eFFPOHBBWkVmSXVFMmUyUE1GU2M0NHQ4YXBZZlVhNkQ3Nk1mdm9tQ3BzeXY2?=
 =?utf-8?B?Ly9LOTNDV1cvZkxjMVExVndlUG84Wm9pRWw0K0ljaWZaM0p0c2FEeWIySkZs?=
 =?utf-8?B?YTZEdW9BVUpiSGdpWlBSNjZhYUczSmhzN0N2a2JzL3FYanFaTHplbEhCOTBr?=
 =?utf-8?B?SHZrNzFnUC9tNGVldXN5UFdjWXVMQWFBSEU4RnBIYlJ3T0RHVkRwL0J2V3RG?=
 =?utf-8?B?ZmRkVC9FRGl1d2M5VFNEUDdubGxRRDgydVBlOEVZK21Dclc0REJBcXJJWXdp?=
 =?utf-8?B?anZ2QWF6ZG54Z2NSaVVUNzUwTVFNd1htallRYTFiZlRiMWQ2OUl5UjJYT2JF?=
 =?utf-8?B?RC9XZ0xXZ3VnVGtwODFiM0cwY2V2b0cxT3VNNW55NnBCbzB0cEpHNUlhYTVI?=
 =?utf-8?B?Umw2RXc3SndUdlN0WEF4eEpXVWplQ3lSUXNlUnp4WVh5WHZxbXhiTUFXOXV0?=
 =?utf-8?B?eDF0YldKWU43ODZmSWZuZXJha2pSejFDcWI2bHlDSWRlUWp2dHR4cDlYLzdV?=
 =?utf-8?B?dFFORlBrYUVvT0hKRFdIbDM2R0M2TWpndExQWDliU3E4M0U1L2Z2OVZIdVhz?=
 =?utf-8?B?SzQ0cjFRcTFYVGhoaXVQNmdrTTlmcksvSU9ZcGp4ZWdFUldBbnRmNHI0dVhy?=
 =?utf-8?B?bFcyeHVIN0lvcXU5aU94cGRmVXhwVHdvbDBlUmhsSDA1R01GbUUyNXQ1b3Mv?=
 =?utf-8?B?ZW9mbFp6RnRUQWRzVStyVFc5bnRyN2tLekphVmZGbjhCcGJQWlRybHA2YVow?=
 =?utf-8?B?RW1Vb3hiM1MrbE1FYmFQdDY3UlorUGh2bjMyVGpXcCszMzhkVW1CNlRkcFhu?=
 =?utf-8?B?ZnJpZXkzY0x2SnlQOHdhSEZJYnJuS3ZUQ08renUwWkVkZGFZbGhJWGdOYU5t?=
 =?utf-8?B?WmVJMHBicllRa1NrZGhnYXpTRENBWlJoOVZjZGdFcURTekx6Q2c4UG9tZy8y?=
 =?utf-8?B?MlZBcE1IeHpIbnhxU091ZVo0bmxYekUvWSswY3AwS0E4WFdNUmF6QzBTYUZS?=
 =?utf-8?B?akpTR3B0aUFta1NtWXFRdkI1VW1nQVpqNmYwUGFCaGhzQ2xOUW1UOWJQa080?=
 =?utf-8?B?eTBEaEZXM0pvZXdMMjRTUy9MYjhFd0JWTXltMExCcFY0aGJSL3VuTGJHZklr?=
 =?utf-8?B?MzJsV2NYVHVLMVhjb0VWSE02c25XUmltR1d1aVROeDUxb2NQYitUK3Fsa2da?=
 =?utf-8?B?ZFBrZnVRUFdadmFWb3pyeXVsRnRlRUxUZng1a01mN1dzNUxpaFNGS0kzb1pB?=
 =?utf-8?B?dUdvZUIrN0dsV2JldWE4cjRRMjFvMVBtR1QrTUhqWFFFcGFRb253ajg4S1RI?=
 =?utf-8?Q?X0HzfVoJXRb45iVJ8C43JmY28?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ee2019-cb03-4358-0a2d-08dc16a1dbc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:46:01.3927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaLJ65A2gtEaYiwgWSZJA5Z+QkAPdZQxGP1wzGhm5HnbqaFMND+u3PGtSLohd+YftRNC3ICZiZDNmpJh/BOAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7661
Received-SPF: pass client-ip=2a01:111:f400:fe0e::713;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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
> Now we support extensions saving and can let to work with them in
> read-write mode.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels-ext.c |  4 ----
>   block/parallels.c     | 17 ++++-------------
>   2 files changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index c83d1ea393..195b01b109 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
>           return NULL;
>       }
>   
> -    /* We support format extension only for RO parallels images. */
> -    assert(!(bs->open_flags & BDRV_O_RDWR));
> -    bdrv_dirty_bitmap_set_readonly(bitmap, true);
> -
>       return bitmap;
>   }
>   
> diff --git a/block/parallels.c b/block/parallels.c
> index a49922c6a7..d5d87984cf 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>   
>       if (ph.ext_off) {
> -        if (flags & BDRV_O_RDWR) {
> -            /*
> -             * It's unsafe to open image RW if there is an extension (as we
> -             * don't support it). But parallels driver in QEMU historically
> -             * ignores the extension, so print warning and don't care.
> -             */
> -            warn_report("Format Extension ignored in RW mode");
> -        } else {
> -            ret = parallels_read_format_extension(
> -                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
> -            if (ret < 0) {
> -                goto fail;
> -            }
> +        ret = parallels_read_format_extension(
> +                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
> +        if (ret < 0) {
> +            goto fail;
>           }
>       }
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

