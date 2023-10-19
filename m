Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC997CFA39
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScc-0005r1-FW; Thu, 19 Oct 2023 08:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScY-0005ok-Ix; Thu, 19 Oct 2023 08:59:26 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScX-0002f3-1I; Thu, 19 Oct 2023 08:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvrAVHteWwALoZSuoM5eE9/EFC6ITSOnQcFktmERqZaeDi0D8N4iBcyPsCGOrwaZCulSf1gqg4X6EPx5W3Np3T0LJXA4z7oQmYuMSwUTaZsvz5iZT1QIjNpn+/kQOKk67Mag3wLpD/BSs2+rYirWutRKZslx/A0sjDsQhbGqkZBb3SB3kcMoGDLask4wnOSmV/Okrl/DUOH72iBrf9ua/gY+e06VVNKqgyn+R7oNC3kDgd6vHxzKITjBsllhKNThNv8rbVgFdUjgTyvQGfru71A7aLR8MYoCeSwwibZwfCf28gGb9aPmC7T94OelP3Bv+R6KEl6srHJ7eAZReXQIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GriIL388nddtRLNdfJ0n50/UFtbzcBFqr715o9pZJ9o=;
 b=Z1yaUgcVcE8qwTy2vJKEqiegqDigc8EJ/0LvXJlBMjg9qM4tJhjVUEB5uXQXNaVyjtBqQC6Ofig4MewRmY86DD8NA5+W33YnIUrpCvdrnidweXe80J0KJ9Qu05icTubzgmbEMStAytJrI0VCBtYRCdWj3CcyVmhw74NuqbkgfiA8VR8RtPWVxKq+16HCWEwrdiE5Qb6WjrJxVhdHpGGJDvRjfTMhi6lcNYOSDdeQy0qRTpVUBKk0A+ohgIxAZJlizRNik72DIDiaAusNIEZQHEvdTGzgqTZvLO2h7EA4MsMME8jcJXUBzYXT41FcB/tm5vZoZu8JKn8lqoFo4ZHMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GriIL388nddtRLNdfJ0n50/UFtbzcBFqr715o9pZJ9o=;
 b=rnNFPeMPuyT38fOlkqbnZHycKxKw4HaO3/0QhxBqWtTyPnHD1LX/4XJMaqMnTbc4cgRrB/A0kugssbajnsOhJNGw4PEYrJ4fi/kuKFdTH27Dpb64U444CaDj5v6M7jRO70KP2mU+Wfls5a7GidzMacioTTaq1ya2Twf8+9AGdm5y/RR0NUIxd2EJAKGrSH2MqHT+LUqsriAs8+TFzs5kHYXY0xF2mI4g0L2XHG21DKwC3oSxRTLZ6Ono5WkXSurtAS36JOj5ix8Fyk0cx9+s3zwN6m/srxKXL6KjbYYj1AzvK/oA7r2qQcAbvxoE0g0MKLmoK/Q2hYR4s+Ohlv1XeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:15 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:15 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 14/20] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Thu, 19 Oct 2023 14:58:48 +0200
Message-Id: <20231019125854.390385-15-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7481e3dd-7e1d-40e9-5579-08dbd0a332ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssMyTVFcUJvJilLva/CtDFYtviAnx55cQjVKHv4F/S/5+XeZxzeqYRqSopvUA6Bnjeb4YMurs/vaCwADMPE7j+RHPlW2qNDREYI1OmFVbgr9RLyNDkA2MD+n/Bgm55/aPktiiTwZfQcdJeYouYrG6wzmEGrOhr2qlIguPfrSv7j+0YiPY6qv54EaUe0EY6YM7zTZ80ta56C3FMU3f21x4lANDwNx07dfairhyzzWEzDsLfEDqZEN9Cqckg0oTXqkiVKIm9Q9qJxQ/HmSbI3JLmmaLX/kg6tYeEEesbPZpEnI1ELHQgU5afn32SvvdhnmiW6kIhDtYtOdkFUNB/uuG2GxlnvhwLOEV1yyxvausblReH0MTVOxVMDGhUaTrQWADzMCpcJo+ByRqptODBleJLxlrUXO1OGvQ0XGAQZ8YRqgexCPDtt4VZUjRSMOp/QYUSXzjQpTJ3lKo8T3NCXCIuOPUmpnYpY8E2NkhfFhq0JsKo9Fh1TyqCyQisNRGQ/CQTeSZDtm9Mlgxqi3Q/LVYNKiYn3iGAOzRXBHrHn+phD1utBKokJKSQAGuZoCLIZMRZ0ocDh2B/QSUfzD1OYxnfg4UkkPKA/TQSC24TO1uMDgNvSsk22RtV4UvHnT68ct
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Siljvwmg1lVAI9defYdo2HA3f+WOvxKdJZkZj6tdmNOmMVcPfGu6CL/EPkP3?=
 =?us-ascii?Q?9cQ8AxipGRFxXhkP0d35VbBCShDecw2cNOv8EhkzqDtB12jjPkAkjQyJ4uNg?=
 =?us-ascii?Q?ZgiKq3xRXzwoXZjzYBgwa3DZIUAOF2z2QD51oBFNIuPaJhGpQoPOk4goMziy?=
 =?us-ascii?Q?Dif4xRRcqCA6UsNa+oiAr95u332DWv1OiaRj9zQd6oQ5irJ0SdSOG2z5G/4d?=
 =?us-ascii?Q?uBEBGEYMyPeD8v5xVrvK/5Xzfn1wFdrZeu8i/2JWNRh4copxVyZ8pAHzASTp?=
 =?us-ascii?Q?p7cO5gl4RSNJnumdzQhQ0MxKdrZe/k7ai3rk9hlDs5PW6hEcWFfIhK4tTwRP?=
 =?us-ascii?Q?/RZik9MgfmnmFO1pJXoKxy8rbPHfxTMVtvwItPzJiwpeLfdXSq+KQY9QUXuo?=
 =?us-ascii?Q?CjMnIU6xZFJ9VbOiT8CBhK4qGj8Oq7IMDey4OWKqtQIv+rZykImS2bslsdpb?=
 =?us-ascii?Q?gS1KX/xwzbm9ZtIDpyUzJu9nh53jDpnPvyY91xmNllqGNACpRAKbkh7KGIdD?=
 =?us-ascii?Q?jcI+37s+M3GpmUJaW8Y7m6WAf6nAis+xQXzLgSBay0oIRDgq57CrGVJwybGq?=
 =?us-ascii?Q?yR4yefj4QZmA4/cb4fkUSrjZKBtQeMAZrUKU+pM19CbponrdYB0U2mCP5j95?=
 =?us-ascii?Q?V/kaY7idqOss+l08ePN6Ydz90Dt3nmm6hRqPLRPadD2HxSX+hKQ9ctMkWtrn?=
 =?us-ascii?Q?gXW1dnV/OxDT7wtKObK87nnF++V5dAoJMIXHPIxXQp2cWwSEeXvzpf8jEHZW?=
 =?us-ascii?Q?RnQqezzUTx3buzdbr8yWxSe3iTimlct/+a4deKIxDQ3+173r4OKG6O53TNQq?=
 =?us-ascii?Q?dHS/FsZbGYuUKL0O8ZR/kPcwmqvsroTgXpM4QEh4VQ1ABNorOvXGzsUm1oBv?=
 =?us-ascii?Q?TsUlKOupEaYIrPJmtHgtRtmB7ppUJ5r8bb014HLTBjFrQJYtnG/hZIwqJKwx?=
 =?us-ascii?Q?aZ6WKaCRLZbHcXIuxwWMhheIu2lO0pZnPU/nxVeF6aGZjA21C+/b+d5wZYZX?=
 =?us-ascii?Q?rmf8ffDG273EW4PhlOXtOatAlFJrlBRjlwif0Cm+z2/NmGfUq/YwFpzMRkBq?=
 =?us-ascii?Q?FkDxEUhEsaHmdgfUOLlg2PQ+L7FVXSTWtZDsng+Qh6/tAorJej5P71DpPab0?=
 =?us-ascii?Q?MfnF0H0NNq6KsGBG2r0o7HOLOzLFWBeKtAzDSZCQalHR7SYbdqK1o+k+lPOn?=
 =?us-ascii?Q?+wXqn4na3LmmTqHJaBUbbwWq09hfbI4K/GTwSabCUp9fDp//CGBQKywIQHvL?=
 =?us-ascii?Q?zstPX82+MwzUtC1rMdiL2ov4wgEqRjxkWzYEwMPBoKEmJREU9ho7N5cdCEWc?=
 =?us-ascii?Q?a81ZAx14dZ04fUYc3DTmNOwo/aAXHU0lftv9rmgNw8TNT09ZWA7RQ0SyzEIc?=
 =?us-ascii?Q?Ah3LX/tn5EW/d78WZooqk2DPjpYr+Qi1t+LC1BL4h38D1HOqciaRhOc9hlzT?=
 =?us-ascii?Q?PxuMSgOv2XcduNBVrKS+cONvYRCk8qxF+6vCxAv7j+IrEy/uOpSQbExyilsQ?=
 =?us-ascii?Q?1zbGYIiKLcxnoIya8Br0/GfBE3lXSmD+cJXOjQJcB6R3xVI08wnQMik68Lzo?=
 =?us-ascii?Q?tpzftCknQUMnIjvI0LP2aF0hsrURHcP3B82SzFWIMnjWlYK6lQ7k9NOm4idM?=
 =?us-ascii?Q?QqC1mIwXHjdV3Ypt254jODc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7481e3dd-7e1d-40e9-5579-08dbd0a332ac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:15.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D10kw7Z2tSUUE3jFLfbNM/KNwC/Y8ZQU5Zny404sfeb11DtFbd35Ev/lSzmTOM6iIZnuIvKKo9fgO6pMnQa7Wsx6HUj8aXYlq64TE5NhIc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2198eff21e..2d54459087 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -775,7 +775,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -783,43 +783,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
         res->check_errors++;
         return size;
     }
+    if (size <= res->image_end_offset) {
+        return 0;
+    }
+
+    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
+    if (explicit) {
+        fprintf(stderr,
+                "%s space leaked at the end of the image %" PRId64 "\n",
+                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                size - res->image_end_offset);
+        res->leaks += count;
+    }
+    if (fix & BDRV_FIX_LEAKS) {
+        Error *local_err = NULL;
+
+        /*
+         * In order to really repair the image, we must shrink it.
+         * That means we have to pass exact=true.
+         */
+        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
+                               PREALLOC_MODE_OFF, 0, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            res->check_errors++;
+            return ret;
+        }
+        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+        parallels_free_used_bitmap(bs);
+        ret = parallels_fill_used_bitmap(bs);
+        if (ret == -ENOMEM) {
+            res->check_errors++;
+            return ret;
+        }
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
         if (explicit) {
-            fprintf(stderr,
-                    "%s space leaked at the end of the image %" PRId64 "\n",
-                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                    size - res->image_end_offset);
-            res->leaks += count;
-        }
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
-
-            /*
-             * In order to really repair the image, we must shrink it.
-             * That means we have to pass exact=true.
-             */
-            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                                   PREALLOC_MODE_OFF, 0, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                res->check_errors++;
-                return ret;
-            }
-            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-            parallels_free_used_bitmap(bs);
-            ret = parallels_fill_used_bitmap(bs);
-            if (ret == -ENOMEM) {
-                res->check_errors++;
-                return ret;
-            }
-
-            if (explicit) {
-                res->leaks_fixed += count;
-            }
+            res->leaks_fixed += count;
         }
     }
 
-- 
2.34.1


