Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FD81F689
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIn59-0006Sm-A4; Thu, 28 Dec 2023 04:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rIn57-0006SX-5f; Thu, 28 Dec 2023 04:53:38 -0500
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rIn55-0003QE-Ay; Thu, 28 Dec 2023 04:53:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO/FMTmOkEYZx9w6xctlYgrLLRLeB/PU2vtghsZgCz8bQi1AVg44Sm134eIC4YDDOQLhZJuHUwfaR8dUS2KDuB1Sugp//SogMkDA0vLxqSCzzvTLz3tnFImp7shfTPHRf2d3G8kshthdaTvC9PDG3390MxC/RaNnRPv4MTy8b4LcBZphqs/79qhla8/x1OlBHfrHtGmbTTq7BWyq/LL8ndGrCMHEUs7HmydT33CpImx3V/bXHSABU3Or9pGoapec9WGxGWFx6b5nC14vUPo/tUMX3/ExselXXS2woB/5zoo4Ydmfw2zR4rIZJGf7vXAeaAC/onm8Sv262Yke2XkrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwSoSCKg82ZO+jshNVcby1EOA+R6oxEw7b6OavVdGd8=;
 b=FpCvLrw1RMAqBuILqlEI/JaFQL44tRDCX84NJ4wlImlbCeNdzsI26E2jHYHhUvg2jsz2r30L2oEhY7tN9kCjESpq4U4Q0pcpPSPs20t0kqU7VfGdhgq68EfBOlQYjemKkHx6c6eR9e9QlZYJJAGMcoBHpkD00RwqNfVNK0y+3H75cW9YA0Nm+0Rv+zNaLLlAAdIYcFyP++V/6GaEss6gUJMIWBLUpXQGpKQOU0eJ8zzb94vgI4PGk3ocPTI3iDryu/kcUmA+k8BRwWrv5Wn100DWdkSeoypMeLOQoS9qBpCXuNt5fof8x3sA3Hn+yL6IVzTgfHUGUtoCYwSIWKo4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwSoSCKg82ZO+jshNVcby1EOA+R6oxEw7b6OavVdGd8=;
 b=mTV5VNz9Ko8M6UKNtJHuvmOMAfUSatmWi2H1RJpWyQ7v4wUjjdo7b5yYg826tADpsWdnVnHkilwMuVxlhF0yHV0V17mioDRS2rto/QPPmyE8ixnAFM/WOB+PAK/yRNxpTSeRa27cIYPHEaWI1QvL1Sr9Z6zxnPpYGkVhmaZv+de+X5sg8IyHoP+XUf92PQ0DaO9vcSLYwdoaqRoK75sKLpvJwMV1Kcf2Lon16yqwbnlLWrifSo2yg/e169FIeBE7y+oRUYQrAyunJFQutAoe6tENsYHa1vMgGW9DiCDuLcXhMn/XMf4l+eb5gTy6gE3U+zhmJb84Hn97X8IBob6oAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DBAPR08MB5637.eurprd08.prod.outlook.com
 (2603:10a6:10:1b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:53:30 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:53:30 +0000
Message-ID: <f25ec369-f0b3-4c07-97eb-86babaa7546c@virtuozzo.com>
Date: Thu, 28 Dec 2023 10:53:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DBAPR08MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f5a102-cf5e-4183-65c1-08dc078ad896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP2AIfyk4kZxIcz/zo9hp/yKvwQJPLJG6W7OxDPaqJ0HTi7450/aKOk0O7vn+rJKSm5POZ2SpNCw+26LIPewD5/AmKANFxuaQ8ULU4Q8kEiGDySoFTZ+BxRDrWpjNOarh3+knkTRLI844kQcTt/L1aaPWMBVN1w50tT3NqjMsWMh2SA5q0kEBZKWKrzsttmt9+clCmqxmeiRTsWPRheUML1vngDlepm+9NOCFoRMZ4XtSQWFaWta/MIR8ecJkvTuLgaw1fYoX6DyeKBhw0pXdDXFPQzprqPvXTPFYxiN5HiATmNUd5xhZ/260WI2HzRuJHYeMDgEglOimx8PLpFrRZMA0tmeJCNCakpMtCwLQ7joPeaEDf/Z03BfsBJMOGVfAxvPsIbkEv2K87no97+j0kGZf4M0qQTB53uA0a1Hpeie0Jm9J8FTQklhXe+nGbBoXsK3+rGFMqsZi3LIecWzGNxlEIx/JKz0DDczW4aNpi+6wCoz330sA3LKJQW+PF8oqrv3E4ZWwOPkKgcpltWZBHaFww49uU5SEglzWrR+DhqH3nZFfQOZd4R+y3NKuxf62rxHJtnMyf1yz7MK5VhnYso3XBvCG3mTlLkRMPiSq25yGbvIneS0beAp2iXckbHRpGXUmi5H+7tK+PLm39x+HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(376002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(83380400001)(478600001)(6512007)(6506007)(53546011)(6666004)(8676002)(4744005)(5660300002)(2906002)(41300700001)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djgzNWdYRXBkekpYL29yVnhmV2ZuKzlSVnUwNkZ6b2t5NklIblRXVWV0L3Zq?=
 =?utf-8?B?TkpqcFZXWWdUZllaYVZUS0lnOTdvYXR3ZUJhejRlSUp1eE9weTR4SEowZURz?=
 =?utf-8?B?VjM4VmJiRjZZU3hDOWs3dU5yWExEV0NyV0dkYlF2R1dxbnh3dk82UktIOUVy?=
 =?utf-8?B?VTBPTlkyOXZ0ZnpzWmxHdDdPM3RESUc5NVRMMFRMWmUwWTd1QmsxaWkraUsv?=
 =?utf-8?B?YUxNMThHM1dKY0IybWZ6MzRQWmxOUE1kZVRXNEJkUjFHUlY0S1UxbFdyeUpw?=
 =?utf-8?B?d0tsbWZIVUd6NHhnUXQrdG1Ld0V1b3FQWEp3T2hvZlNxRzRhK0pWSm5ZK1I2?=
 =?utf-8?B?U2FMdGl1WXEzZFhubVZXdjEyY2dqWUtDQ3B2a3U0WkxTWmI2SnlvQzc4azlu?=
 =?utf-8?B?N0R3RUNhdTJ4d0U0ZysxS1JuZHVKQmhyWUczSzM3WS9oMHFwcExuNHhrZWVN?=
 =?utf-8?B?WUc4Si9kblRRUlZhYmNVQWlqb1Q2bHBPY3QvNm10MXE2MXBldk5UdFlGeHJt?=
 =?utf-8?B?VSs5cUVrV1JLd0l0Wmg2RVBDQlZYTzdjTTdLdGdmR1pENkhMMEtlWUE4ZDZX?=
 =?utf-8?B?dEZoSnFVUjhsNVpSOEYvWTR2dXZUVTVNMFNmVlFkRmRVYjFVbGpwLy9NTjY2?=
 =?utf-8?B?ZXQ1b2tzNHEvc0tpclpTbk1tTkFVbnE4MERidE1UNFBNenhDdjNkTExCcXpm?=
 =?utf-8?B?VTNjdThxOEdBaHU5Zkh3REwzQWJzV3c5ZDdiU1VaNHZZTGN4R2JQUWM3cGZa?=
 =?utf-8?B?bzBjTlF1R3NCa2hiM0ZzNkdhRmNJT0R3NXV6Wk44d0hyY0dNcGp2VnBocHRU?=
 =?utf-8?B?RktYM2hQcGF5Q0JKRUlDejdZZnl1SFZ6bVZOblBkKzhpMjVlbHF6c2Z2eTUv?=
 =?utf-8?B?QzdUaGdRcDNIZWkxMzdvQmNYeHg0Zm1SbEtBaFRsVmJmOGU0NTRLME1wcC9s?=
 =?utf-8?B?SHdZRkNBa0k2NjZwdFVkYW9NY2NQb1lDalYyR2xoRFBRTExRUWRxMUg4QjNN?=
 =?utf-8?B?VlVjNGd3YkMzQjJPN3pFNFcxODVvWFpEaWFldFVXZUE3ZGhNZXVDQ2dRcDFI?=
 =?utf-8?B?dGhhMmNmR3NYSHNmdE5neDBzeXFYZmNUK3RleFFieGMzOWo0U0Y3Zi9aMG5Y?=
 =?utf-8?B?TE02bGhpVlJzVzFwVVZ6a0JTVTQrUTdyaWM5emlEL1BRSzQrN005U244QjUr?=
 =?utf-8?B?bW5CcTlDUjBmOXArTmFmZW9pUlJucHpsQ0JldGtpZ1owMFBEMVhXdG82ZEdH?=
 =?utf-8?B?M3BIbjdOUWRWemRrTVNjN3J6YXViZE1RcG5HelRWRW4rRnFGRnJMVDF5Y2F4?=
 =?utf-8?B?NkJTM0F5eml1ZTJFS1JHbmRyU2xnMGQ5eDJmNDEyek1SNEtzVlRzaVdXSElw?=
 =?utf-8?B?OEVXVnFQcjlacTlRQkFGbktwNXBaaEtqNyswRE9EaXU1dGpNcVdGb0ptWlFx?=
 =?utf-8?B?VEtDeU1NWEpHM1dxL0xXR2ZTVk0xckFkZHU2WUovZVFFV0ZNSFF6S2FVeWdv?=
 =?utf-8?B?MW5ZaG8wSnZjUEMreTI1MTNVYlVkTGU0Ynd4RlZta2NKeGhVUTdsYkdncjBM?=
 =?utf-8?B?WDhobytxaXNNU1JQV2lNNHJQRHhudU1hR2VxL2dJSFFSWitIdmFMb0NSVzFV?=
 =?utf-8?B?akNPNm1SeGVxZE44TktBcXRGejlEN1Zaa0svVlBTc1NtejFXMUZ4cGdjNEE2?=
 =?utf-8?B?SGlxSWZ1aWFiZDZYQmQ4c2U0WWNTc2R6YU5raDVrT2FBR3A5aWJjN1g0UEdG?=
 =?utf-8?B?SVVka014VFlXVzlTeHhnRW9TZFF1OTNQR2c4RzhHRzNrMWluR2ExTFpSSFZ4?=
 =?utf-8?B?M2xPTFlHbVJqTVByeC9jaldIQVlrY2NEL0taQ1ZkMUgvalJXTC8xd2pDZWxh?=
 =?utf-8?B?YkZtRG9RdDJYOHJQRVlkekxZTzB2Mjh4Nm5aTG5ZbU9XTWp6ZXBtTDJIT3Y3?=
 =?utf-8?B?QkdIWkhMUDZyb3BDWW9mMlM3Z2NTbkVNT3VnYUlXK1pvYTdxbTl4RG9IRmY4?=
 =?utf-8?B?L085OHRNYVFYVGw4YjVwZldWZ3dBR2FJSzY3dnl1SDNweTRFT1ZvMmVFVGFz?=
 =?utf-8?B?b0d6dGxqY3FyUURXTmZPdkgyT0RaWnhIWWk1UURiZDZPbjBoQldyT2xJNitr?=
 =?utf-8?B?YXFkRVFIaTFwUjYzWFkrVElKdnlGWmc0ZWp4VHQzSStrWG1neTg1TVllaW54?=
 =?utf-8?Q?OX81IAp2nbpBeFadCg9xCkw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f5a102-cf5e-4183-65c1-08dc078ad896
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:53:30.1453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfQ4kn9pAHqPcb0z4gFywJeCq20aBDfGTSKH2QpE+j2gcCMRUAMnEeok2/0YT9jkZqrjU4YGCQD1Y1mINHlJfauxziu8UPLKJpiDOBGLNV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5637
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
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

Sorry, incorrect patch set, please ignore.

On 12/28/23 10:41, Alexander Ivanov wrote:
> After used bitmap freeng s->used_bmap points to the freed memory. If we try
> to free used bitmap one more time it leads to double free error.
>
> Set s->used_bmap to NULL to exclude double free error.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 9205a0864f..072b1efd78 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>       BDRVParallelsState *s = bs->opaque;
>       s->used_bmap_size = 0;
>       g_free(s->used_bmap);
> +    s->used_bmap = NULL;
>   }
>   
>   static int64_t coroutine_fn GRAPH_RDLOCK

-- 
Best regards,
Alexander Ivanov


