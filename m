Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC981F6C3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNs-0005Jr-Ki; Thu, 28 Dec 2023 05:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNm-0005Gw-VA; Thu, 28 Dec 2023 05:12:54 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNk-0000at-8v; Thu, 28 Dec 2023 05:12:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMwXFhb4ra9fcewr2WmExdRlOis3Rqr0vx00TP8DCyDw1dGFu4VeK1+gcknToGBIAgPpcjSC1sN0lqqtUR7LF84TcRADs8Y6JbByBUqCMBGVO1Pmy392VM7V+v24fTZ5uxLv3J/LB/OGeiEiANeZ4dycRhFkdWzYibjiwRjmPgXOw83h2sSs/5cJD0cbYPpDiDAPF/uu6EmIw6n9nwymbPojtpIrZcu/ayF9LzTSf+nNXK0l0YjpDhboyoXzym0kRXqoxG9FUC1OwFkgdPUaiqh/aKaMYB6KS54a2GfYXf3QseeFGDzqRsx+kzwESinVA3avmh1w+a0LnuWt61bYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiK8oZDz+rOtYNkEfWsCX0YcUHkmu5EZp+mPDs9p95Y=;
 b=AmG57QquwHLga+aZJ5B8DNtx/FeDLVh2/1PDy01V0uhvhgAAs0Q6xeCuI0BwOWX+tmEYlldJ5fnAShikberDmHUnOsFkwNsO7nve5Kz16YlG+dOdj4vQNheNRrwjsPV8936mmg/qtzZcjms0SLWtnSCUJ67OgivyGMBmTrrU3KldQevu2/UDjavrgPs82MMUduqdsKHaUsO7I/FXbZAsW53zW5kSnuaIcE+EszxnNRDIGDlfeqdp2n7G4PYhR026UEJr/ROCBxbaxjYUK9qf/zfTpJsqQxdbUxaisf1fbhEr6W+y6lSX8Hy2LEyutVThqWveBDcvslZM31GHypokwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiK8oZDz+rOtYNkEfWsCX0YcUHkmu5EZp+mPDs9p95Y=;
 b=ud5ubTymXC9SzqsWoss9xJpcKlW63lxyOAp3GrmyLHfXGy3kcVZYG5eSv/iq2e1DEowxCddwajteKDuyxaONzqW8T8CbFqSD2E7jSWP/eon8Fm3DCkClqcBRCy/5k1IGov3PcoylzY+RobXR+atJCuz3k6kWOTnyYRw9IYLHS0HlnE9qSvULhUHpmcdkrjP9iwnnRm5yeRZMJk6JAqRbC0UYuce5t20U+/gsOVEH+C5I+qd7Em/x5jGR+qTdOQ0UeV9Hw4BoO73ixnmcmR6eS2JndjialxYCwh64UQ/O02O7XGp8uND518aSEkJvqKDZrTHcKmhWIPgkmqc6BktULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:43 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:42 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 05/21] parallels: Add parallels_mark_unused() helper
Date: Thu, 28 Dec 2023 11:12:16 +0100
Message-Id: <20231228101232.372142-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b8de3f-1d67-4fe8-a5ad-08dc078d8757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfBzD6fvQbCCU5MfA2MP3NlwvFC/2nBTV/2mOG7qTONSGgVBvScgOD9ZZN41zuMIaFXZpavVxVQ5kO5FC29iKOCawagwaM4ansrjgdxznABkPGzVIyHDECfi1N+Q1ANpy72jXZ+GxCwBcUJDQppQTsEKp7nfCdYBirgRWKOJSzSIb/PXU2Cmg0M01hyLjJcPjD8VU8vv1NjRjoqG4hj0ds8o+vrwL5vwred2mn0mlOnVSMXWeoRNZW1F201zUVd7RQ+5VAlBp74tqH45oP381XjRfT8ByhXnlGRMp/iaO4Dd8QTv/8Heq+MOqQSBsYdGxhM4Wx68/Ukw8e0jb40F3BCAw96TBBHZcPxQJjwDgeyIjjwDhqGmg0tHM6Av2YuqbjgyPOQo9sM8TimaNdv8Sv3q2ndYEDmZzVNlbjIAoWbWy64Ol+1CG2puSeQJx78xA5znF/ySyFQMMjIv2SZKA2VU0+6NEcObD+2+6ySrz6ubMgRV7aazjavgeq7dIqUB5p1KGTSkiNxztOkYVI6H1IJQ2MoXCF0AhP1Fj/1bl77CciI5ARTmUy3kyDl1VeUNf7L93gcWYMVYcwk7AFnzhVHMrjJGGhZDLdqc2yVvbGkCSGz5jCutgs2JcVatDOTP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48U7exz5DqftcotPAKV6F3ijtvUDf9tMb5CY74DkOBn09OzNUYn0xdoT41Tt?=
 =?us-ascii?Q?c4jhn/rkV73isMmtJuTlFtU1IU8gVviTcm54tVWi6mqKe9beI7UTxbGG380f?=
 =?us-ascii?Q?Q9QUdz6yfDg/9dm7+6yJJhPEBCnSWsrFWp8yawF6fbb6K0/NqIHshFeJdsqu?=
 =?us-ascii?Q?C7hhzNp7WA9AOff0gzkn1iRnQTeX63NZYo9fbhmHPUZNRw2ik7WFutmwO9CV?=
 =?us-ascii?Q?jChaCd3qEa/nxHJRNb/vXGTVZdGSU5e/60mf0n+7Ak8vZhtHGahbNwcY8ANU?=
 =?us-ascii?Q?5Dmc6Z1locNkDtsJatP7d2NNxScJ0I29kgexX2ftR26TjIexY8bUEthNR1xl?=
 =?us-ascii?Q?YjKOBZhj7Eh0x2AcAgssmZujC9ppWMRA/dtMFlXQI7geTRUmRUXgruTShsiM?=
 =?us-ascii?Q?fpmBD3UdoN4rqZWNdxLttlWi7jvuDXZ/lv2pmAyWlB9ewFVeJl6S7IrXJ4Rc?=
 =?us-ascii?Q?QFbEEUMGfXKRGFKlkzewNywgCporio4k7LOVuq+voz1mhYu4z6lfG0s5XegD?=
 =?us-ascii?Q?ru+riEHONZKi150EEYZdjtmRzIhBmviLD1muEXcyj6J3zBLMnrNk4jc+Wa2L?=
 =?us-ascii?Q?0m6Emu7IAVZ3SQt9YmFxCJXSds9rLgfgYEIOYLmjmQPusC+GNuW3SVPYU3Ei?=
 =?us-ascii?Q?VlmVqRSgXtwUjDgHUb3tNNzsFfo9KQvHvA8C642hYHwy+zmkaNVSg713Zd0j?=
 =?us-ascii?Q?JbPxpbkj4M9H7VXDg/Nygw5LWLQawP+pRk3GS82DGMfXUqEpHIGGaPCaaL4o?=
 =?us-ascii?Q?dWwEFIW0CxzVP8tTHtmJ6v+8YYNoTbaYJYSYh6yli7VyovhvCVikoZh/L2Yv?=
 =?us-ascii?Q?tPMEllHqC2ghwnVI0MYTzJ2Nii7TJKQCXrjBvEWVSOS/icfwAOP1Ho7J/kNi?=
 =?us-ascii?Q?S36HChRWMsGBWxtpW6t0FwTN0oZ6MTTwGgCkBr3asglWCgI4byPgHyA45vvm?=
 =?us-ascii?Q?sC2Fmdh7o5nvooUUKVErDjAsWoNY3Qx6EPRveOixNRzeE6KXpTS6sjSYq4Ym?=
 =?us-ascii?Q?uTj8VQlNOOWAfBVnc2OmbHT/8C1CFixbAogE20wNow5WikD/LgitYvq8F0T6?=
 =?us-ascii?Q?QrCbu1+zzR6ww6xy7pnRJmrhLBoQwSi5PI27VpO2m0zk8wCaZLveAaResj2U?=
 =?us-ascii?Q?c65sirEn1H7y/8b9C0W1v5jr5zeSvaH3JiI3wuR/LBxPjPgsUIeZZWrE18lL?=
 =?us-ascii?Q?WWHQofzURIkKpvHVEJ/9ZAWTqdabGMU/mKb5kKkRh2+I17lbXPTAK1jIQskH?=
 =?us-ascii?Q?fMLLacG7plu6uTVc5Jk8kGAGnCdsqDZSCj+hQj/4eSukpKa0iAAcWXd0FGVi?=
 =?us-ascii?Q?NUrNZ9TlGAx4HC5a4qoFLujYSgZUqgbxqbNh7PCYWM5ItJsxcPE9t0Bm9L3o?=
 =?us-ascii?Q?gaQHx+0xE6gEoBiPnC63TIvZREQNFGl+qv9evloUL/tc87mvvltTiu0nTFl/?=
 =?us-ascii?Q?j1d6nxJ8We/j7oaLj9n8tRvjo3YJxYDJ13YO6o8KZOmT0d2Q9va8jkS1oprn?=
 =?us-ascii?Q?H9Ik9U/kJMRNB1hI9tKCua+J7GNmDH2/Ihjfz43snDr64CxjmnghdpO6n/sj?=
 =?us-ascii?Q?+pV1/tHN9uUQlFUjKpNVk5s6qJdIjzyFFho1RXw9ElecuIGV0Gd/y6Et6Djq?=
 =?us-ascii?Q?6EB6LiwhdVwMc9kEgo52BCc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b8de3f-1d67-4fe8-a5ad-08dc078d8757
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:42.3276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS4QDV2PZ6QItyVYx3IcjMmrN6rkNq1/yBC3S9QbB8A2wLhQHcigo6kWQozru2FstayZaTlBeASvk8U/ryaze+Dg/gz8FEdLQwzLYfnSJuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

Add a helper to set unused areas in the used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 18 ++++++++++++++++++
 block/parallels.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 4470519656..13726fb3d5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -196,6 +196,24 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, cluster_end, cluster_index);
+    if (next_unused < cluster_end) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
diff --git a/block/parallels.h b/block/parallels.h
index 68077416b1..02b857b4a4 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -92,6 +92,8 @@ typedef struct BDRVParallelsState {
 
 int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
 
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
-- 
2.40.1


