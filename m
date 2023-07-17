Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 722757568FC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQxQ-0001FU-4u; Mon, 17 Jul 2023 12:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQxH-0001FC-A5; Mon, 17 Jul 2023 12:20:11 -0400
Received: from mail-am6eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::707]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQxE-0007xm-7S; Mon, 17 Jul 2023 12:20:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBtUd5ChxuQNxSDOv7FC3qht0geSdhggtRiEU6Davvfnxv0IAcZOnDynbPK4ctY2XrMzHe6a8rhf4KWzO0Sp2kBYR0uX8w9lZJR0tO90rCm8YPMAW4AlONyUCvIAjBnv2D4qJKp2k2IEDjJcBBagsFZtyCWme61VzcqCqoCW1su1OCCGK53wkwH2qfb+FR+YGGmKQogJ2LNPaJXakQGfSvulbLKsKuIZ8WYRYxDs1FuFpd6PBhXi9+j4xUl0CGDxA3N0f9XONJYGSOgpEoedTOgfYK06c6S3zrSXTpeW9p/Pqb9XhA56HLSo3KrWO6/W7GFXf4fMxt00ajDdJnTMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dnOf02kWLCknwpkBSVnrVlNXP5N7BX6MfOPs+z7TB8=;
 b=Ag3TWCcit/t/ymYWfPoO/9Y6eNxiAu2CqDSfhoimngU9/JVvPT44ci9DNxDtDDlGC4+5DlrOXAjTlBQZ3JVegQAU3yyKtUFbcLNpouBzt1hU2ag5r+ietnRNmX5/Sgau90MWiiiZGiGuhjkkWv49xCTsD/7GN4iViOzypdRl7S+l4A0FkppuHVy20RA/OvTNqviOB9Umr78gtcV0d0ghzmj5Wo8Rze9EWrwXq9YO0QKVwOSGAeqgk/JLR+9fM6SSpJ7GTj7OJOPic9IFeotFCVVphFQVP5x7qfdW2zgxrMZS7nMy9gXKxiVajUErCL/LgjtuDb11rqSE3T6KkC6pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dnOf02kWLCknwpkBSVnrVlNXP5N7BX6MfOPs+z7TB8=;
 b=ymF9XqVPNl6gzeRGfYlKO2dgCIdE6tR2NAPuP6ZNCpPH36WTe/8pVyFqbf/EUtzUTethZHLgHNmISkZ7OLUZ8EBtnlZ9V+d5R7AcMbsEc/3qhEnXSm47zKrjUKqWqWlgBfbRvmLNVBbIimUBjhtI0LiAvCqYQ3hy8ZgLtGerkabUI889Jv4k+vHOTRS9BKgOBAagjowVpXaxzc9ylRmW82l0q9PBB7dybmJBF1jbnWMvpBzYUch017VHD8bvGoVKssgcA6YYq+FP7uL2fg+4mj/Vr0nflGOx0xqsFTd2R7Dd9EzLfUAetDzdbiWR1tL1ErpNc6cteGkftWM8Y2tVgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB10136.eurprd08.prod.outlook.com (2603:10a6:102:34f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:20:03 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:20:02 +0000
Message-ID: <3cbf33a4-2dfe-8245-7217-066dd9b37191@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/8] parallels: Check if data_end greater than the file
 size
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-3-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-3-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB10136:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f39e9f-0a38-406e-7d10-08db86e1acbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zxtn6cPFu3sTFxod2DLgQ48F7EO+S3Ir1PNgYhvXRUW/IsfJGWUsp85iO+KQ3jxX0w+Nb8zIMw4RQtD+TjvTmlDSW6OhSqEr/8oglZLIVbJE6qzQa+/x/vsaiwx+XX12a2uBgK3PuL28pad0Eq5lEjFVzcFCkHHr5pnNzBHzagLcmzWr+sdKGP4UlJUz6kzVtIS6WNTf8KHkjvsLh3rruw/uMlCWPsPfP5MkCPHQYZ/jyQGV8PzXBWTyxbDt46OXc9Q7r3fB1MWHDd77KuCGRkwLilQc8dgT0u4EWu3NAuO3/MNA8lElXAiXvIDu+52aAs5D//hPjjYfeoy8CLYE0KLMTyQS7XWmIwiDx1UiVw+GYiT+g87SXqw5NVkIxwA4ZOM73TJYt7zGxVFqZ0CQYzAqwxjLQP0xW7c3BYpPoFRK3O5tiG7tc9Kcu6los1Y1iEfWkuMa9NaHxnC3YaU0wRun2/wicBuiMxJItP2OsgFlDZxngIMeCb120XsG/kGMyM/Cco8vwK6TeEvME52CvtfDpeatd5wFvhJ7S0RUwhGNQJm/o3e4u0kF0hZUV0Ugzuzf92iLneWELVY5YahqxGrJBrPMev7P26ysmJrVJSRSGU6EtVX/Iij7QUWflRheg4f+bT+JrzW6XNMkWs3emw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(451199021)(31686004)(6486002)(478600001)(83380400001)(2616005)(31696002)(86362001)(4744005)(2906002)(26005)(186003)(6506007)(53546011)(6512007)(38100700002)(66476007)(66946007)(66556008)(41300700001)(4326008)(316002)(8676002)(5660300002)(36756003)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDVBSmtaVStYdTRNSTczajhxRGtQVk5DQ0FJNGc0YlU1R3hReWdOTGZVODE2?=
 =?utf-8?B?ekpoWVlnN05WWXlKa05RM29SdklYRTlxajAvcUZVY1ZOVEhiVFdZOWZRY0Zk?=
 =?utf-8?B?cjhOTEIzaHp4TENSanZqa2FEMER2U2NnMVcxL3ZkTTdaY1ZrNUllR291OUVx?=
 =?utf-8?B?TTZ5dUIxSlVLcDNLRDE1b0dHSEFHVDBrdUVIOUMrckpqYzJ0cHVrY3EvRktP?=
 =?utf-8?B?S2RXQWN1MlYveVh3WTdxSHk5YlBaNkVRNm53WXpNdTdWeFBZdFhHZVBLZGRC?=
 =?utf-8?B?eUpoWFUwN01hdE9ob2UvdmtwVUNyR1RQdCtDWVB3Q0VjNWZHOTJWYjhiVXRn?=
 =?utf-8?B?LzE1WmdYWTQzMHlqRUZ5Q3FINlIxYXVJSWdFdlRZWjVRQzRUTnRsM2FCUDNB?=
 =?utf-8?B?ME1DYWVpa3llKzVZQzFmYTIwWjZMYnBWN1RweWdVR1REd1dEN1Y4MTNaNFB3?=
 =?utf-8?B?RXYwNGxOMlIzR0hjcGdRSzhtNGJPOUlXVmJWbmtYV1VsSzEvK2RBRTUzbzcz?=
 =?utf-8?B?QXlPeHN6TjFyN0IxQzhoeHNzWEZNYUlmOVhldVJaNzZuNDNtQUxHcUxKRXJ6?=
 =?utf-8?B?d1N4cHMrZEc3eS9CVnI2d2VkY2dvWThjYks1VGE3d1VTcjBpSnJZa0Y3Nzdq?=
 =?utf-8?B?SXg3WGtlSFYzc0NGb3gzVzZucmdNeU1NZlpZSkZGS05VWEltQ1o0Wmh1UTQw?=
 =?utf-8?B?MUVWQ2IvdjJrUDZPNzlkT2N4RlpidUFsRTBrTHJEWUdMa0cxMThVdm45dThD?=
 =?utf-8?B?MkVNL2FYVnBFTXVzRWlhdjczWmNBNi9Vd1NqMGVBandkckNoZ3JRbHIxOWpW?=
 =?utf-8?B?UWVoOVRybVNaaGlsamtGQUlWK0k1TStHZ3VsR1JOL29EbzJMOEhGaW5FZDNq?=
 =?utf-8?B?NWFpWDFQU2VHZmd4ZEpBdGJ1QkpJbVJESWw3UXNzRU44dG9iWWJrM3JmZSsr?=
 =?utf-8?B?SmNwN1d5ZFBmaFd1YWNiRnRMRmN2S1pzYUl5bkNWb0RVR2p0a3BZWjNTMVI3?=
 =?utf-8?B?dHhlclNqejlaRjczY3NKUVZsZVlTRkIySGVTTE8vdlpqcFZKenpMOGtYVXFu?=
 =?utf-8?B?VThmaFFJWEErNWpISHFQaWhGR0dqd3h5alIwWkttdGloNzk4Q3liZDg3cVM2?=
 =?utf-8?B?b3FJemd3aGh5TlFNR1VIdElTMlVJaUdQZXV2Wk43WHp1QTQ0K3ZqclVlVTBZ?=
 =?utf-8?B?WDY1dWI3NnB4bzB3Yk1aRnJmeTRDaFNCcWlCS3ZkOVNDa3U5Ri95aCtUTms0?=
 =?utf-8?B?RnZlcGJ0eXp3UlJpbTJSSVBqK0F6Z2IwdWpXbVNBQjBvZmxLOVdmRW5oZlVB?=
 =?utf-8?B?UmdWN2dKKytGMkppOHZYR241SXNJVnRvR0VVWWNVQ2drbnQ1cWc4cnRvQ3Q1?=
 =?utf-8?B?bUVHTjhaSGdPZGwvc2cyZGxJQXdYZnZBNXpVREpTaUdPTmVjcDlXSXJPbFY3?=
 =?utf-8?B?eGxvTExzN25xNXI0NGNMck80aEZHM1kxTjgrY2VqZExKZlIvWVhzVmxJUTAr?=
 =?utf-8?B?RWtUcUJkZUNxZnFYbitBQjhSdDNuMnVhTFlqT3lqNXVaNU1oU0ZndCtzTks1?=
 =?utf-8?B?czBxK1g5OVhraEZqZ2N1YXFrSENTWWx0UlVKWG94MnFKaWxlZFRFSVlrZktS?=
 =?utf-8?B?VWlVV1VIR0szZDJvU0J1V3E1TmptcWY3OGpVZ0pmWjdoTWlNUy9nZi9KVXdS?=
 =?utf-8?B?ZmJmb3dPUFdWQ1kwWVpIcjk1MjhCajJyOUl3cUlKNC84TUJaNUt3cGxrYVJh?=
 =?utf-8?B?K3BBcGZ0bzArQ2wwY0RjME10TC9nRmNnRG1jWDhxOHRZekROdlkraVZVaS9p?=
 =?utf-8?B?enhSN2M5V1VlT3FOcVlDOUxsOXo5cVdvd0pqRjFNZ2VGdWVLc0oyTzJPb1Fs?=
 =?utf-8?B?UXdBUkN4RWhwdzhoby9JTWdQZ3g4U0NvVzllZWR4ZTBqVmE1Sno5UFRiZ2Y1?=
 =?utf-8?B?SE9vcnZwaTViRC9GMTFHM1djRjFoeUFIZGhGeDVVQllWV0hYYXl2WlhNMmM2?=
 =?utf-8?B?UHdwSjArTm1ySmFyeTVVWXNrUU9Td29jK2d3bm1OU3JmTC9TY2tqODRrSno0?=
 =?utf-8?B?VHh3S1M5OVduQXJmZGhMaEN5d3Y0N1dQZmNNZlNqbjl5NGhFT0x3djE4TEdU?=
 =?utf-8?Q?67m4NVAdjxle3gLBo2Q5iFY9Q?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f39e9f-0a38-406e-7d10-08db86e1acbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:20:02.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAh6LSVTUOxX5aF8wAbIvoX4Ng5x2Z1Mt8G+FT6zclV5+lIGxtm1vB+A99wEuQIQenUEK57AvAZUQiF2lj7C0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10136
Received-SPF: pass client-ip=2a01:111:f400:7e1b::707;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> Initially data_end is set to the data_off image header field and must not be
should be truncated to 74 symbols

> greater than the file size.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 86bc3bfcb8..40a26908db 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -868,6 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>              and actual data. We can't avoid read-modify-write... */
>           s->header_size = size;
>       }
> +    if (s->data_end > file_nb_sectors) {
> +        error_setg(errp, "Invalid image: incorrect data_off field");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
>   
>       ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
>       if (ret < 0) {
With comment line truncated to 74 chars:

Reviewed-by: Denis V. Lunev <den@openvz.org>

