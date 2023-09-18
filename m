Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD417A4316
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 09:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi8tw-0004Qc-90; Mon, 18 Sep 2023 03:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8tu-0004QL-D2; Mon, 18 Sep 2023 03:42:34 -0400
Received: from mail-vi1eur05on20723.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::723]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8tr-0004F3-HL; Mon, 18 Sep 2023 03:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMhbz4dpwrYGfVIQe03Pp246Jk/BNQwMEX7ZNnMNlE6p3K18XpkNoSrftHpwiYeWpV4fvjmi6e3MZIfRkJiYx0f5pwlkWFSunSOL7YXxNRPGy9BpdicO2bKPH4mJi/2KnGb+fhKQbpI25AkzzAJKaDqc4Z+Niju6Z1L0d4ubE6udhI5YFn2Ni28VXr+QcTKz/xkYpkvMJsgk0qQjTdlRzyHXFAZsdDbVFaE1MeH/USZmQDsA2ZZ0tGeMmyZLR8KMIYTQLJruaxPOwuNqVajgO9s70mkpJ0rrnIXyW4/8haGaGiIxFq1zTfsW0GqQeKTbYKQldT6KevZSyGtABNcJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZmPw8aTk8wUgpLSalay/AfghuiPUcqv89xQvn0OEoI=;
 b=iYKTU1rbqJs72wymibRGH1nGgc9iUDydM/pRjF9Z6PAFJ+agwZaNGy2NgI81q9kGwS5wArpfXOQhlb2VaQFv2Bob3tIIkx9P9yV6ZEd2ENt2wTKCWTyUQ92heAjzICJLg50EdbAeO7FHLdeZPMkFdlus+td9zu56Y122VE0oCPeSiYTRo6xGgMLQ6elkpPUA/BoMrmAWNUObN7FRRS2+1PS8wjJXvpHwPzmeenRxX0EtB+fl9WmBO7EjkhptRNJTlU+S6VOyr4Xus/r4LW1+ryKBE7DGvDaZLir92OEnZ33n4LNFNqiKWk2HtUDATvWquH5nmBOOml0jxpxWXgFVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZmPw8aTk8wUgpLSalay/AfghuiPUcqv89xQvn0OEoI=;
 b=PFDi8eKGGZvD2XGMLofQ/TMaO1SYC/MqO84t566oNzciD+Mh97SvLdUQdM/Qbc+judvIyES23KX2r9ZdZvzh6D+SzC/fJDLOQAROxafDZyZ8As3lPQ8rkAuJkl1E+7o4S4uzPS9USPoyN+jhUyzcRMoUS1fLdEeB1K0S3RHsvx6GNDpsplvbVBhVVQufRlB3YuByPXJWHaUk3MFdEx1qdszzAJV/zHkyfdFrOYhjnxd2jRq/O5aLlaqKVHQbHJDwvJZs6UP5ZY1KTdM1KBsXLKzKlyqjPujDzS3i7W4uAwLLwLUo3n2s37UYFCiDfjVesgLVd6WEuzQOx27B33XwyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8637.eurprd08.prod.outlook.com (2603:10a6:10:403::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 07:42:27 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 07:42:27 +0000
Message-ID: <2028b4ba-e840-2508-213b-b90d59c09429@virtuozzo.com>
Date: Mon, 18 Sep 2023 09:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/21] parallels: fix formatting in bdrv_parallels
 initialization
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-2-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:802:1::27) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: ed35df0e-a450-443f-c87d-08dbb81ace85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKbgWM9PeREr0wVSqOPan9JSw0evFLlRP/6DHLBZaTT3IXm27Tc/eIb0LgGYnLfiihTfLlnwKgvhkRTrC2iSsKobOD16jruQKesZlvWZpiHBzudyS2FsNMTo5EwNQIdtNy73ykp3xXTEC0gi8oyD7znaGK1LwNXaPK4VtEbtgNOXfrc+I1cYSqUrM9rsEgK+a+vx0wrYL0Du4VldQ+8NZy2wXuLs3jB/MVECRmAd/6FYkkOhN5kaNijlzJ1uTIfmwLXdV3DYPPIaaA+hkejhAz8Iw20vcdbzw64UlRSvGAiWJj9HUTbSg7HW9+xLxQnZgZTRssYzKFFifPZ6QFCls4KdX5PvGEC2faqynWHtlkdKcIKeZKBJkkfHgITle+M4gKsMkNwqgU73svKTe3a5YRgN3sSwPwfWUJxlkOQSd2LkS9sV+H8U6Gp9MBJJsdc5KY2KWtas7SNB1HXYKdfAlbCE5u591so0Awnfn0awkkMAJkfFQDLaO5rOuwd8TlmJy5bzhpNGw8R8m0LO6ZmALhs5yEfwqRR34/Ege0neknmvxg2J6QtBVMP7/QXRAdRpKHA+gLGZ5G1z5E2KmZnpJmWEbjJ5wI0rGHeT+TJ2aK83s2w67dIafsegf5uJL6x2DhmNvouVUUssWOyylJvbAeOxxnoWPi2Zoo2bDxTvawlVbgcoDXZYkZi+XaZhG4Et
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(53546011)(52116002)(86362001)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(38350700002)(31686004)(6666004)(478600001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldzbnBIai9nc1dmWmVFU2hyL21uejRWUk5rRndQWHdMSWNoanNtUXlFZDBo?=
 =?utf-8?B?OE1xT2pvNmZ4S3c2ZVUwU3E0clZ1WGhPUHo3UnRxaUsrODg0WTBmZlo5RUJG?=
 =?utf-8?B?cXJuUXZMbW8vZW5Ba2hBc25iNnJWOVVsVDl2Ukd6eWJGNGhKdlIwbjhrS0Nv?=
 =?utf-8?B?UDhON3FDaHpUaXhTWU5XNnkreXArRmFmaUZiMVkvbTI1SUFyOVNsaVVHNGtY?=
 =?utf-8?B?d3NFZC9LV3FXekMwNUsyUVFudFBLWE54UHlVWGlGMzh2aWxBZHpKaVFMb3dQ?=
 =?utf-8?B?Mk82NEFDaTQrdkVSc1pxZURucUU0VGFOZ3ArZXVxNmZ5OUkyNEdyNFUvUFB0?=
 =?utf-8?B?aWZ6V3ovVU5HWEVPd3cybGxGeWZlc3JnejZaUGMyVWViTmhnaFdDNHloR29i?=
 =?utf-8?B?SnpIWXVkcXZibVJWSGNBUkpmSjRGZElqYW95TnN6d2kzK0ZFN21zWERxekdp?=
 =?utf-8?B?cHhGREtCaXVpdlRxZGhtb0hlQWpGdGF0Y1pHenBERElYaExBRnI3NVVhMWVM?=
 =?utf-8?B?eVlLL2lySmJvdHI4SGFlWTRQZ1F0dm1SWWVKNkpUNmc1RXJWTHFWVGs5NS9X?=
 =?utf-8?B?ejNZYXZrSnd6RU9TcHliSGdMR1hIYkpza0orQ3RsM1RUVlVIVXhIcXpHSkVP?=
 =?utf-8?B?VDRONFZOK2hya21TdVQwaGhpeCt1WE92akUvREJleEduTUZZSVIvYUxZWVdm?=
 =?utf-8?B?aWVOYnAzeUUzOTVaQkk1ZXJoYkh1S1RMVmpxSFRlOWpIbGlZUklkVFV2Q1VK?=
 =?utf-8?B?NDNITndYaDRsTTlGQWgxbjdTNC9UdWxrYkRROHJvVVJlUllaNERvMDNrd1dW?=
 =?utf-8?B?K0RuQWdWTFlQcDNyV1lMZlZqYWhVczRESC8rZlFFdm5XSDlQZ3AwRnY1NW1t?=
 =?utf-8?B?elhYRm1aOUdLZllzeTJBS2ZyOUJWLzU1UDB0Tmg0Y2pHMUx4dVBlV3JGc092?=
 =?utf-8?B?Y1RmNHRtaGdJam53eFl2aExGcUx0dTZ0QUZlSXJlRzUvVDJ0QThBcHloZTJS?=
 =?utf-8?B?Snpjb01BQjExdUlLZ0Z1c2pGYlhyY2pKaktrdVYvaFZMM0pDam9uMmJQRnZN?=
 =?utf-8?B?SEduZmxNQWdsK0c1YU44VWx1UWoyQ0tScU9RUmpmZGppS29YMWhITGFkNys5?=
 =?utf-8?B?cEtXTTkwZ0NyeFZMaGVtY0V4UHlZeWRycFpzUUJZaGxLVnBwbG8wMWE2OEkw?=
 =?utf-8?B?Z2xZMnQvVjVxblJWNDNpOGZ1TVczYkRPUFZjY3ZFOWFGbnVkR1R4dm03ejQ2?=
 =?utf-8?B?T2RXaG1DWUJzSTIwZlBUelI4U0JpQ0ZGZnUrOXlNTDdqeElQOW5sZkFhcTZZ?=
 =?utf-8?B?eE9tdEx2MS8ySTcxOVNjKzhNQkVTK0NOak9vL3BjMk9QbUdYWk5MODZhTHFM?=
 =?utf-8?B?NDBTcU9Vb2t2dG9xUlo5MGJ0REZtRk96MUw5cU5KQWVZVnQ2VjFWcmVlZ2ZL?=
 =?utf-8?B?RUN2SVo5SmNsL294aUJVeUg2ajFEd2owWnZmeWMrK2hzYlhjK05yQXJXdTJN?=
 =?utf-8?B?MWEybkZzenpWWHVGZkRaV1UvRUhLMEMyUTF3VXhFZDlBOXpBOTJCaTgrS3Zh?=
 =?utf-8?B?S3hhSGRIakJIWExRY0RvRnpQSTRKRTAzd3ZTbk1QZWdveHZqckt5YlRqdDhR?=
 =?utf-8?B?NW9YSUJjeFZFMngyNXhlQlE0SkRQZFo5Qi82UE9HM24xc0ZsN2VBTFc2T3RF?=
 =?utf-8?B?RkJPMnJkd0ZMb3lyOVJLL1lEN3RSOTNrOVhVdC8zTTVkMERoYUVmNjNSMmIz?=
 =?utf-8?B?UWR0ZC9oR0JLZUZnMzZQem1QS01tWnpLT3FEZGRFcnUydm95ZEU0dngvVTFm?=
 =?utf-8?B?cFowS2VTeG9yOEJwN3RsMlZqSkQveTRucGttZ0NLNEI3c2NFOEVWN2tUSW4r?=
 =?utf-8?B?MVQ0Z2xTejZCeUFlbWx2MW1OeFpJTGxxbXRJdE8xOG54LytiaVpZZmlLdVlz?=
 =?utf-8?B?WnllVXp6UnZxTlNhK2ZHWjB6b2hrS1BDSG13ODM5dkZhZ201NEtrblh5cUVF?=
 =?utf-8?B?ZURQK1piRzNvTEFuQmhudFo1UDgvV3pzTWtuZ1MvWU5LQ3IxUXpERzdoY3JZ?=
 =?utf-8?B?QzVKNnRiOWhXYkk2Tit4MXVWeVlML2t1UnZHNzRSYUQyMDN0cVhid1ErV2Zu?=
 =?utf-8?B?YjRaRGtIb3ZGT0VJVUp3WEJjcXowWksvYTlWNFJyOXJMelBKMkxrTEN5VFhF?=
 =?utf-8?Q?e9yNrK9mT8mSDMEEy0HW6UA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed35df0e-a450-443f-c87d-08dbb81ace85
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:42:27.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amoRnZl9XvOejdXLQynNmWlmWrHzLA4Fo8HlpdsYGC/mzVxn04C+tmJYL5yyLKUPJM6WPMnESGYl6wkM0sMcuTokchmVvkV0de5QABdPQZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8637
Received-SPF: pass client-ip=2a01:111:f400:7d00::723;
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

