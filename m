Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF9C81F674
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:46:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuI-0008E8-BU; Thu, 28 Dec 2023 04:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu4-0008AI-KH; Thu, 28 Dec 2023 04:42:14 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu2-0008GX-4q; Thu, 28 Dec 2023 04:42:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNVCm12gGhWFVSzaUmavAF22rq4s0qGRYHM05U+pR3iru4H3AWYNTx+IrvBFKTCq2xIExvTyAIpL/f1aIx0ksRcHlSoczwKDAjcLLzBwTGjJYqEfnNw9vkCXY4tOK7ArT7Fw9XmSmzbimCmRwu9jeooVXV2lx1fDdhPcS55yuH9tyZnV48Qc/oWJwfmeMuhVygHS2lzwzzzjlLE4uYMmkosMFIYBikT0OJPO3/8vJmAb5JyskCPTSlJ3T4liq+pBv3ea8EtGMBHANe4TOUdiQm8d9YIyXA2jX27wC4dfiRgLJkBE2payDkAZQ0xzrrU5x98rMuPnKk2uYQ1mswAaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=CcBBXf64RmeKz4LroMxqVyl4YUr23xJ3KwOrOXu06QbI8mK+4pwaxSNxjb2A6seHKrapbv2096en+HnjwhNu4Uh0bBoRXZqNMrkmsuiWI8fDM+AvuWsHNCXPlEpL5BVkhZdYnSG08KP346XY5vHzkAIF8qN/TEHvpSrU0QfI2eP6q77Qgb3vrBJP41mEVeuf0uiQ3feWsNTKRNpfWqdqQFEF47aOdfKi/MiKsWNKVjDaseSGaM0hvaiCKjXcFiO8sEot5Du7vKU1XPEV5beTvpw3WwMuUrjbSSkwYsr8vqc1oyDZJpUjoQac+6jq6dS1nTKQfFrptvwwEysLwVRYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=ESpvbZ4GWk92cxdt7sI7vb9+2TJpPpX7vyvfZLYM9vq1RQBQnz/0u4yZat76A8LWLrxOWpdwnmYnc4vCiMEROZ++quil3qXV7vzRsqGJXCVLPo7/evM6NKndzskYil2fjyQ2ABdQ1dj679FpnBUc2EZ0EFWx58LNZE20mZxaS7ckbiHuwytSGF+jqcMFfzN1Gq/hnNkGzseBjp8wP6cuO0mDuKIWr6FlzNx1084of/NYyCWgtZ24RDwr2qXlNJP6K49aFYe6bus6Y3s6dApbLWnW6lKIzoKBg7ygyJUniRBPAzn9DAEZrqRjExCoXko5uqmM3mwiL6pfdS8vJJrjNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8969.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:00 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:00 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 01/21] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Thu, 28 Dec 2023 10:41:33 +0100
Message-Id: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c78ac3-3845-43e1-155a-08dc07893d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp5uywcN20hmmufpfxY6ZI/0egf3oeAtTsyXaMLwF1YywI1A8CYTAI+4nILp0mNbJpbP5G7A+ol64Cx0i5nQG17d4ZVhAim+vZz7qTZo2A+G9J4JOt5432apqqzXDqZPrjb2Ewo7GvYua5lSFCveUqM2x+bNqTTVhDqjnw6qDFe3JuAg8SUSrjmvIhc8chFwtbWd9t+TXxA2wz/h2CdoqnF+ZqqeiHYQndz2Cr1PMtpnWdPN8vTpqeu8O5/OwMM2dmWAXICkvsKm/cq6+22FrInvINXTNbX3gAI/VR02jhflc4xqXMc3lBoDpW4WkdmyuyW7lp5m5OS3sUHmwhwrEUJrS6fAVPph0wvHYzRreDUYAjAvQUKKEyVeISqA2F7UUeaf57t65fCTWjoOAeZbOCkg/0MDI8UkID7gmxioAkSZWC4fHZuxtPpgSaXyNlSG89RmIBRWFuTT91ROrS8ZdYRV7HTYeEijPZohV/orjSUMFqwjtIp/ywQ0V+f41QZtQcGIYWMCxx8KueKFQXhCKNcf5ZDwzmV2qBO0WE24USGCPA3Iaz0Vbgz/DB+Ep6sB/FAyIxRHwomRxO7+0Q6zTg8ArkY+YjIdbwja3TZREmyY7ClVWSYnM4LAkXUfUz8t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(1076003)(26005)(38350700005)(38100700002)(83380400001)(36756003)(44832011)(66476007)(66556008)(6916009)(4326008)(66946007)(86362001)(6486002)(8936002)(8676002)(316002)(6666004)(41300700001)(6506007)(6512007)(2906002)(478600001)(5660300002)(4744005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CdlP6EjZaYfJf9/YjZqNc4Lq2qxuy88LIDiYYci/ukLCdqlLamzd7ntqctp?=
 =?us-ascii?Q?qfi7XfAC8yio05bwt0c3D4dwdnMyWDwdzeP2bWgiEIXRogOCLOeBY6rYfNH2?=
 =?us-ascii?Q?fDSoEAFBcPfW5rweZpazSFoWc/OtUWX8TvPU72Pjm6XTbFbGVjadHjMAHN28?=
 =?us-ascii?Q?MeJG5Q+sO/xMarwcPdxyVpsptfySi+9z6gxzA7amjpxFQF5dGiiBmI+nsqvk?=
 =?us-ascii?Q?ATgwIypGz4HYzedKEq2BEGoD6+3nWyo/8BR3SAfs0H2aDDwBdN/o3P8c2tVg?=
 =?us-ascii?Q?MzgV2kZw7IjHVLWIIQM3ykgIZaWyUpWGBeld+8YRuV8Z59/Km1yLiS4c5GLJ?=
 =?us-ascii?Q?LBpLLFtJ9tGq7o1BmFvLiRRpNAlX81NIs7ETtsilDXhvDyWQim65CF2QGwHw?=
 =?us-ascii?Q?uJiiB884qQ//IpIzP4vlr2SEWan3UVK2qncyi3pClaKHlTXQjQGSTljaTgTO?=
 =?us-ascii?Q?vJFBDW9moLtX4iiZWPQUtH+7WbhJ/T+WrVjd32oy5Dw8Uo56UcaTnsAgWZ5f?=
 =?us-ascii?Q?aDw6fANMo7beqxhlWjzLF0jDyLRngIAvyF2WNhkH8W/vCjwBRwlbNh/TRUlc?=
 =?us-ascii?Q?ImBCSDqJZRztiy0Q5T38wDE0dNlWgEl2/+z2+9Liio6S7CR9foCQCZczzUsx?=
 =?us-ascii?Q?M5Dd5aQCTioNlJC1VLIG6inqO4LLQkiRpBaSHPPfbT+mOu1L7Xb/T+9m5mbb?=
 =?us-ascii?Q?vL5dPA4sBBJfs3PBE04JdC14PRDTCt3PVCFRmcNGx4mAZsZFyRrUW92SklZD?=
 =?us-ascii?Q?PUjpiNMziqclPvxkHOlip1PRBgLWbrclR8T+Q/V8rFVAW5hVViQlbNCkQ2+r?=
 =?us-ascii?Q?FLPTWaHDIRsKr46YjwpvO/UFyhCLnvwxw2h2lSr6/xYLH7IV4ieuPzLpbj4Y?=
 =?us-ascii?Q?y0ic6Qfftv7tdUWcDX7jQCJl2nLFmo/30bFbgcLwG2XaQhMrNhE+JiA9DUqO?=
 =?us-ascii?Q?rO+CiBBSUF8Xfz12MPMpxvI9IQBxxM1NDDpPTEQnshGHniBIYvdyn1sKvOTm?=
 =?us-ascii?Q?+PLq1iLQ2V49swswIEpHsuR6OjM0prpmo4taxaP6O/hchaGRE98iwP6TYHFu?=
 =?us-ascii?Q?gZfLwOTC3IhJ1IB5pFqCZZHuFckc34oJvVlwG8Ga+Or97MpMFyNg4NhNCCaB?=
 =?us-ascii?Q?3PjntvxeK5cJ4ExrRclMmpv+2OImqtUdhZTwOk/P8GzKAOdkPWHARHtfn/cr?=
 =?us-ascii?Q?j8ayAjKT/xY0I3prBWs9Af79JEHxWYJLcXHOdB4ZC89qczxlPjoJUFr5PwuW?=
 =?us-ascii?Q?kPB7IGyXkobzfmB4UVvZ7smf1PUk1o7lZ2VsXwIySY7ZVil11CLQ+E/FaCPr?=
 =?us-ascii?Q?hPrOpuddFaC+dFIuAuNGXdQHl3zmkyp/5Y/dMr+5oO3M+My6fDUQrj7ilsLS?=
 =?us-ascii?Q?F455Elzx3BXNmiVHmloegqLjqL8Z9crzLb346kdMcPFidJU2HjhWpaLJtJcj?=
 =?us-ascii?Q?90QknlsahTeb4Jk5M0RDpvyPMEb62Xy5gDc32OZ6mTfCdOfBoxMmpkiJ1/Zv?=
 =?us-ascii?Q?HnVIWDiHvA5iAW9pJlzstmZ5NLAiCR7Q+Jh95zxjLrz4XLI8sMFzvy3Y+s8y?=
 =?us-ascii?Q?peA5pHz6nVO7U4ZzDzNn3FxKkWxAWl27qpk7oUEGUf9CDGU22oEOL41u9/8H?=
 =?us-ascii?Q?3SkJjSJ70b3aGVVPO2qCMDI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c78ac3-3845-43e1-155a-08dc07893d37
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:00.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfs5DmeKRIk+gXu58Vv5oiy80KrmUXAlzu7Hhn2Spf23IpSW8iR1XQkZ+eD8Czxa5w1ZuHTYYRU6JzWikqp536cQG3+KnjTocLZd5gFcRj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8969
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..072b1efd78 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.40.1


