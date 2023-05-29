Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A4714CCC
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eau-00048X-5L; Mon, 29 May 2023 11:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3ean-00047z-OO; Mon, 29 May 2023 11:15:30 -0400
Received: from mail-dbaeur03on20705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::705]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eae-0003O3-Pl; Mon, 29 May 2023 11:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcNPc57Xog+OHRLn1/i21izF70zGbhaH3dgQny2cSRQcHbXTmCFktDzYsxZtlZpz01OMB5PPTcM7ue9Sx49Re2VqspQuonW5yO34c7xC5qaLOS0SxfdnOIX8e3XIkOV1RI9Z9qa0AnOBlqFflq7zthk/bdYkeSHh3dxmrwv1sHgmoWtelLQ6jmT9U1tgL2CCzlifVatftvbu3hBZewoEemnwO+JTz/zU/TaJ4SsvUVysNKhOBLTKTC2XKEFI1rwqB/QAFTsgwWA/PA3r3uwg2uZylV0+LQHwLXowl5P9h7/fcEvWcBbjsPflXmR7xOaJJZ1DAhXqXEoRlQDK6KF8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BolsGWBq/BsLs02RR8+MaPgxDfT29zUuVPmbEntuAiU=;
 b=HETIGVdlyvgwCjx4sKuaWzz6h6fX4umTTK4crlbaPOS/ufiDIZ5y0L+B9Irt/cY9BwD31dsyu3kOQ5PpymlOPaxneqIdNunOay4prZcv6EAmvlW8WH4HG5QC7zvhKOGd/BXN/IafRm4RoefnXsdhwnM8cYrEL8THVVDJMX+gkaCMHkTvTR5M37LasoxVc+nNXJi6y1nHMHbNXqt4Sgle6XbDL1c9WYWwdDNWjKd9qeljow9azWaRhB04ShzOE4PggFrfSEgIymtnMN8jKknipdDFHlXrrlhQj8jnhOu6vTOE9riQss+i5KbPX4K0wSzV1A3IV6t9MbTGVY/TTpy2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BolsGWBq/BsLs02RR8+MaPgxDfT29zUuVPmbEntuAiU=;
 b=rDA0Df8heZhOZrM2sJpL8ZZJdW1PbmCvfKZ8E4HOTyqoFnOR8u8GJYKJNiwvnFibRbFqpL3hmGns+5lCZ38Krwwsq9ukPWT7Z1CRuudIfJ/Qo2tn6XtcZiXPha9uWCyR6hg4TjYwEa/JZwchyGeAKWmI9rsIfsUnZj3jcJcbNwYhCnkGvHghP4+fhBWNaMyD49355y2DVqYhHpeYNqM7/mxkLalsGxMLJHjM4k3wTSYftBMYo9wyWo+eLD5odYBPHcDwy8S4tF9495VVFqP1HDZ8pNn5gX5YUlAE+ele27QVz4GWtdto705KLuMUkRS4kvlFRACz81cbWfGb8RbXOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 15:15:12 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 15:15:12 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 2/5] parallels: Split image leak handling to separate check
 and fix helpers
Date: Mon, 29 May 2023 17:15:00 +0200
Message-Id: <20230529151503.34006-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 670cb8c0-ba5d-4875-2bcf-08db60577f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzDMm18i/N1qbvmpRAnV/ZLHXJeQDwXnGShDi1H1+jiS1TJWsdzx6BSf2Y/WnMFinzzt+56U+ewgJQg31bRboH1DLUQOu1I/LTnxL539d2xu/nUoRvWZ6nMi5hOmARADNjz5Vg3NPXM7aA4SKNuKH/4FVYAK/pyYOrt/z7XuTfBcgQy17S3dauYN9mhai28GVj3OEzLwNEqWvTO+b+spFYNoqTI3VM+vTDe9K2fhi7E9x0S2wiGizMTlAjgQdKUjwD/LfWkLqCdkMqiuSDMG2rdFLaKyxN+DPcid1G8wkEWvIQq1XeM17zQyEUidH5l+KiylvipitozZg3lFGYHLPIFJZq+BzM+L7VNiLajLNlFfBzXiMexvBsC9tmu+A/J2EFq7vnx6gyvN/7FnPkss6POTCoaZuXk5RtdFvSqHQWyBKnyJI3VKqxG+gJYPBPM4WzS1xFVtWe3FsAFSEMyQjzDq5F6yreaHLXRmEGuYSLkamK2DQ/scOqGt5oi/6mj0dZ994LSxJIpfNFnQhjYnUz9xaOpwThT2Srt+yKAy5JCKb4oSFcgID0QsA6vgFu1M2tD4CBtDEPTqC6rhLMsN8mCzJzHXpIuAYWY5n7NSojaGMNHzIgUHrp8alPFDXBwi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MUH/QaTbTJPu3alHe4w1bUfg2FQWf7t0rZ05poYReM0b7G1HtVT40L1iEWv?=
 =?us-ascii?Q?psd8jkHC+wb63BBtUWrKNMoF7fUfbSgLll9VSlKhAuGMsY8a80nvFt/m8i5K?=
 =?us-ascii?Q?sl8TjrI43Sa/o2Wy0ZSfuGQkK7ts700uImUunDzTYPwgtqEI3obUoNDxdsIY?=
 =?us-ascii?Q?aRfZdZ5dKkvtBuBllPLvxpq8ukNLKV3eCqER8BRx81fmtjyWh9oA1dogxUKc?=
 =?us-ascii?Q?6Rw+JlQbjZmwQWH+Guhf1KVJRI+QbaqbVCydeza9q6fzwBsgIwtZ3xptzGQ+?=
 =?us-ascii?Q?CTexGatLEI/9iz6j53npONjSRKiG7iALHy4JLfgjFnGsmEAnVPMioKxxkHmD?=
 =?us-ascii?Q?TCGYBzruj7jvcaaR2/K+fvJ8ih7WAXl3X7DpNB4bI7cG6VnFsUjb0icl2h3j?=
 =?us-ascii?Q?KI77Hby0gZkLcnnfIeOaz+zEC9kEegP7hfjWYWPr1/ESISs0rgkED9HZg2ti?=
 =?us-ascii?Q?tj7kU+U8fwqLtQG2a+/5DbZrw8Gul0roK8ehBFpJ/WGZGWAZfP1mPS0P9YRr?=
 =?us-ascii?Q?fM3dqoR1o2GQJaGAB6bmjRonLvYZiFL3YAYedO/tsH4b8UEo8/91ESTSsJ15?=
 =?us-ascii?Q?Ce/+QFIMY2T5WQKxLiiPZkImgjJQyTSBjP6tu7coo7gnOmnYPLKOvE9+bNPj?=
 =?us-ascii?Q?5VasloV6l1xYlphMZN/yGmIcNo6lKMalrShA5em0S22OEnPw71LOKUsrv2tP?=
 =?us-ascii?Q?o24MNXOYsbrtbLOwjz5/dpZv6RT9+y1WAKYhy1sw0yjzEDp0vCp6i4KgI1Ww?=
 =?us-ascii?Q?KCmFY2BAlN35NsC0O4FQXZjGwO1VCMkfgUfIfGdtuGPcWBTWZ488CoxXUIJ8?=
 =?us-ascii?Q?5v8L5n4fTXkpqpU8ZqP8ywdg0mCkAOJo6KMUDiCPh5o93XJt4qm5VVduXAUc?=
 =?us-ascii?Q?/Z+xxovAgoZR3vhRws6Dzu5ArBQeyAXJViQs4/ysnQ704u6HLYc3L1P7faYZ?=
 =?us-ascii?Q?jpd6hLURuJyxf4YXPxmnf3rxbwndzqGNF88w3E5jxDrzXOAJs41aOg5DfP60?=
 =?us-ascii?Q?K2AEzCQZX35f7FqcdfkHuedyTwRkCHFlNweIqkbu8kk5NFpAb2b7mt+zE2kE?=
 =?us-ascii?Q?EPDdC2ohK3wRM2D0ZqNwNCYB7D3ZP9wT/zbTGii6jEVmFsBtcRJYb8G/ivd+?=
 =?us-ascii?Q?5zHQjgjg1I4E0r5qHxkx7slx3PIqwLNZvgFGANs+QhSJKKstYDfIZODkqmqG?=
 =?us-ascii?Q?HySz9sEWEdXcs4M0oGSn36IfsBAPFYlbQEy+riJsNrRLPmk/h0VlQbHFoxGG?=
 =?us-ascii?Q?C40PLPS4VNyVKKEAuhlJMq0b+CIhZcic/oaG9Qmf25t45YRNXCJuNKLh7fgg?=
 =?us-ascii?Q?dnm/bP5voBLucfjuQn/vxSVBrZBZ4vdg3ZVER8OH+1idOixoo3B1O/gq76NK?=
 =?us-ascii?Q?aiMa5MUBRt3PYuJM1uDed8D2PfXtypss0qkGNRU9mZy9guReR2six2AkdfbD?=
 =?us-ascii?Q?mmFuaLJWZPjIpWbjEShpx5hD1/refz6KHh01ncEvnBuH2+RSnxVR2MKqLRnX?=
 =?us-ascii?Q?AICLHhqmjd/aDKWb1gmZJLqHSC81JITIl3QS0lZOjgp+muNxzjCk3TM3umdy?=
 =?us-ascii?Q?EOD35mSSQng9MtjoCshEkbjuLRfQzpI9FdJat38stq1qTLpZX0J2N8GChg4P?=
 =?us-ascii?Q?z4Z3o/mwTJZUL0vEnmzBoH8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670cb8c0-ba5d-4875-2bcf-08db60577f60
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:11.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdRl51G2hKvxAwGZZjsqrOzrMY47nJED5slhqpdjDvFRoatrmyP4wfkM3Rh3l6AmXzGgGIAB/jWsfgUZDUbDTzoamYLEQqxBQmor7Bjz3ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe1a::705;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We need to fix leak after deduplication in the next patch. Move leak
fixing to a separate helper parallels_fix_leak() and add
parallels_get_leak_size() helper wich used in parallels_fix_leak() and
parallels_check_leak().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 86 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 1ec98c722b..64850b9655 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -482,43 +482,79 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t parallels_get_leak_size(BlockDriverState *bs,
+                                       BdrvCheckResult *res)
+{
+    int64_t size;
+
+    size = bdrv_getlength(bs->file->bs);
+    if (size < 0) {
+        return size;
+    }
+
+    /*
+     * Before any usage of this function, image_end_offset has to be set to the
+     * the highest offset in the BAT, excluding out-of-image offsets.
+     */
+    assert(size >= res->image_end_offset);
+
+    return size - res->image_end_offset;
+}
+
+static int parallels_fix_leak(BlockDriverState *bs,
+                              BdrvCheckResult *res)
+{
+    Error *local_err = NULL;
+    int64_t size;
+    int ret;
+
+    size = parallels_get_leak_size(bs, res);
+    if (size <= 0) {
+        return size;
+    }
+
+    /*
+     * In order to really repair the image, we must shrink it.
+     * That means we have to pass exact=true.
+     */
+    ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
+                           PREALLOC_MODE_OFF, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    return 0;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t count, leak_size;
     int ret;
 
-    size = bdrv_getlength(bs->file->bs);
-    if (size < 0) {
+    leak_size = parallels_get_leak_size(bs, res);
+    if (leak_size < 0) {
         res->check_errors++;
-        return size;
+        return leak_size;
+    }
+    if (leak_size == 0) {
+        return 0;
     }
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
+    count = DIV_ROUND_UP(leak_size, s->cluster_size);
+    res->leaks += count;
+    fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
 
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
-            res->leaks_fixed += count;
+    if (fix & BDRV_FIX_LEAKS) {
+        ret = parallels_fix_leak(bs, res);
+        if (ret < 0) {
+            return ret;
         }
+        res->leaks_fixed += count;
     }
 
     return 0;
-- 
2.34.1


