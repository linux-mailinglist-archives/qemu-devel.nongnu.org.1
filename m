Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E397CFA60
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScY-0005o9-OJ; Thu, 19 Oct 2023 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScU-0005lR-52; Thu, 19 Oct 2023 08:59:22 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScS-0002f3-G7; Thu, 19 Oct 2023 08:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJWzBTL/8RjKawIdgF0s5R06JdKrWP9Om8v8xqtVPTWq8IDTxSv72hXmSXhJoSq49JQDf+YfEyHm2viO0YCv6NxjH0AdxTTNCa6aTI4Wyird6wbNSLt4yepDV8Wngwc4evHCP0xk3PQvEZjlhyUoWVhoM2b8oEUCI3vJ2mPFssBWcixxpWgk6RGPIv6kBUbat21xE2E7pG0+YTxgqLJGbGlLlOF23DXtAXToYeaiJPkTQfIxWKk1CTVni7KY/LcGjnLJU9JdKYASo60VQovl2ZRL7wPpqFoE0o7PslQ1tIlxJB2WaZGJILwkMYMnAJtQFZQVBLCpaEopd5b0SROMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKb2aNDLw+nyj3qBLDs/krwJiCERi42BTes3pdyX/hQ=;
 b=B/tBlNAnSxKIcjQ/pBGG3tugKWUhECWTiww45sqoDNnd6pbdvsEjSzLwkGF1mvX/pscuagZD4J+Kn5nP/F4iYURXVMPXVleaWENGXlKT4Lnlrk1dOrWPTwoxY3S4o/l7wAt0gQ14dM9p2ExuJ319PDeCia1oIUDw8nJpAExtAFchr1XOreSeUjPRGE6GwpvqIO2eFFESAw0VYi9PIBreQYEzHKjHY6xSQNKlhbr9XcisMFdeF9r4k13WWZcAUY+faWL7ZzhC8rSSL3bc0dbtPKZ6XKPWfWV83z2xdQWfQ4ZmbmxSNe3nbP1TtX7W+gRrjh6kCk7DOFVuLle2j/TIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKb2aNDLw+nyj3qBLDs/krwJiCERi42BTes3pdyX/hQ=;
 b=kQDsH917rsTiNngVKYW2THlQ5tw1qfjJJFrnZ64jKpBsKhN0M6IOry8L0ZbH842IuQ0l6r2xxL7cwhRGNP0Wjwne+N9LG3JHyWDNnchldj6eojIFvA1dnDHoaMXVtucvHymL3/oyA2UVBVIcCPGf+kpTpsT16oSNCXLHCQr24m5mdVT1QPnEMbdR9EnG/nGo4k6TnOrCrjTMxXok9rqnvUHiLWPQ6ren1WYtBpBTGCuYBPMfmzT+JBHlnobnzmfeMK62YdFz0GXWg8qMI9302AnzepOtQ1KEZbJm/iMiRzYxwHA/Lv70XTSRXFtPsdq/Ivx3ZvNS7cs4cHmIASlB/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:11 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 09/20] parallels: Make mark_used() and mark_unused() global
 functions
Date: Thu, 19 Oct 2023 14:58:43 +0200
Message-Id: <20231019125854.390385-10-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c30cd856-055f-4def-541e-08dbd0a33058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rwjIYVRzibYwJCFpT4QQ6y/mmKITd3JOdpQdr7TXzPckJodc3TtrBFL4SbkwJzmDjAsKZDz5DDEYmS9aRbsH49LvRpgFzm5gsqiG4ps1hytdypq3sQyf0snEOwAfXwGafZeBByrI37Z5A2awHnqn59jmai4ZxXQ8iWpFzVWDXWdliXWtSA2Q2D+rGa2mU0zGr6G5QGiroSRpOrfhhfLh0ylVvdWEU9Jhwf7latzlSR6Kda48RGmG3flNLIxjBoU6YlFefj/PAlNKmJPtRZv13tB1Asbqo5zdT7ULs20rAxJZ2D+T+S7b6lYFxmXum9pE8178bp+z26lUeTqyJaq8J2Sjq0gPr/j++9/zO7rfBQMlEH2mVk7I0VZoGo6iEns1tHK0GMtfreLZMgZKxdpMq1DiWnZBP0NPeDMKIwigsAC+37eCK4X1rETLa2op5wZqks+dCNwwgQ3jglI4D1fY20IJ8fcIvT31WjktZQMsYFFti0iIi55Sh0pXs+4oQwdU23z8IznajLMABbBLFX5wxAhQ+OIPShT69+zO5cL+1QBCs7XXPSx8M6UipaZpfgtde9R2xay03hAsgPb77rUM0eG6po6jdE0aWdBdmZI5Id4aexfCo66QbPfvwcLombn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaAAvWPxLflZutlGGX357QTsbIh/Ww7/ORF4qo7ThHFJWCAS931QMxcp7uXG?=
 =?us-ascii?Q?eVpTOkMPwuqbNNZBj65u2C/Pq5HZYwretVlCz6Z3g/efOxXuGDFPnDJJnYK2?=
 =?us-ascii?Q?eFPZtpu1wdZeuTqKM73PirQv2DipJZ/P/dYWsDYcfjjurImZHeDj2Fm+dR1i?=
 =?us-ascii?Q?KoNOkLFj5mgYtFmeucR//yFof3Z1Ge3zfQHVX7dT8Qa5SEDJr7OIdcCOJLWB?=
 =?us-ascii?Q?yAWttJOb8OHBNZCjKfyrd3zTAa/4J+pLnM3L8OCj5Qm+g17QaWHvj0va2eqA?=
 =?us-ascii?Q?ada7SWkI5YqnEN2wN+Bgm2lLeRuQQw5z31mG5B/QJ26Nc2rv7VZzhDopMnvL?=
 =?us-ascii?Q?yibUNOPHPUizMxk6AWZtGLnGrSEpBQe2Qihk2z9qXCdI0DYoabjzr+TbCYDf?=
 =?us-ascii?Q?C+dhxxIPxbH3RFopmHUGB70PH5pbFtIbL5nw+8HQGU1GMyc+FLRqcKBseAHn?=
 =?us-ascii?Q?cwNyh7UZAG3ttg8bLa0KJ0sHFd1PmUlJfY0+hQpS92PvnWnGSf2T/NYFK3md?=
 =?us-ascii?Q?WtOwaXFk91aWHHw2vh6QYd3CITabaoYy6Y8dOYqM1H6D8VcWB3I+FCXWujjk?=
 =?us-ascii?Q?JzyE4qy1NgjIpDU/6p/BqdTSMWmMJr2H0m383fSRZsHWCnuElu87mUKNG1GL?=
 =?us-ascii?Q?BeP1Eincj6bFaVW0tCREMZ2F4Q+zsYByYRc+7HHidhTWrphxWky+M4Fa/0nT?=
 =?us-ascii?Q?noOxwcSYfsGSHE9hZBMbzpzE11zdBkvaMWzf560sC7YrHJJ038XkcndEBkb0?=
 =?us-ascii?Q?+U5Z0kV8IyAnKYUUk0N9KC1HJz9pDaPJUm4Ni39PD1mU7VkdCc8r7NkyXDBF?=
 =?us-ascii?Q?f8PoWnyRvJM7GxxCNo9NhGJxgxYRQJQatxIJmFlisxtGj8tB46oYnlCOOxxo?=
 =?us-ascii?Q?aB12CprBRkld/gMlyCSba7ujSZ04C55foI1nILQAFea6fmOcxQQVKr5Xc63D?=
 =?us-ascii?Q?alnS1F7WB+KZ02J1+DgA//sEBqmHD2g6YQ5mAdWHeCCl1pwoj0myQhBG30W3?=
 =?us-ascii?Q?vXH8GlZzQ1VZC3LdA7FNM83n3nMw8mmm+9Q2rmxp5MtlwuPTaAwpxKyDjJxd?=
 =?us-ascii?Q?Cy9X7JUSZcMshsKy4l2apdbv3Kh5AuaTjxB5splNgYpdYd89nZnAbnmqslls?=
 =?us-ascii?Q?ztdVFCaBAjvnU5nkhud4JbZrNpjBBovD+w+IAeaFG+OMfJHChicJCZpbxyWj?=
 =?us-ascii?Q?cA/WpOZmO0rJcazpQr1ZQi+B0C+zNtMFW9IU+Xra4eLW8uQMTYBkD12gXVe7?=
 =?us-ascii?Q?AP2ez2dYx/GXZ2OY8tfNIVh0eyo3Qp9vLRTG0wnxo0d9oz4aBE+ijho8e/RL?=
 =?us-ascii?Q?XzH1oIOKlGPawbv5X56LJh49LtgofOGdcy6cdld6TVUuXfy9dACRu3izNkMx?=
 =?us-ascii?Q?MfIr/14PF1hw2KejDBGxceK8k/R5MgULVJ0Jw3Sh0swmrye2773DF87/uuXL?=
 =?us-ascii?Q?9er5k3XxYK3wI3V3fBxfZqZwRuBWX/rscIH2ghPmU9zzihL3wIf8NjuBd+qx?=
 =?us-ascii?Q?lw4/cil4y3xTC6RhhU9gTAQZ7QXkEiorvDjs/NE07oTJLg4Z5gwKybvyc2rH?=
 =?us-ascii?Q?L8zolmTlpfWfPZEYepWXRshtz3lKODTemmHZkP61jyAxQbNIr3v3nHA0DqXH?=
 =?us-ascii?Q?xvZ/c+RZEyipgDPQTJEqMtc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30cd856-055f-4def-541e-08dbd0a33058
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:11.3969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hax1YSk968A7k3bLq6HtWjKo8MDn80zsfv3EPpM3M9UbIxaN0D69ExPhXRQMgnMXn7XYkD+t4C4A+VI6WyzEpc3llsAc5A2awppfrf9n8uo=
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

We will need these functions in parallels-ext.c too. Let them be global
functions parallels_mark_used() and parallels_mark_unused().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 22 ++++++++++++----------
 block/parallels.h |  5 +++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a22ab7f2fc..2ee2b42038 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -195,8 +195,8 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
-static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
-                       uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -249,7 +249,8 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -326,7 +327,8 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, *clusters);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -393,8 +395,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         qemu_vfree(buf);
         if (ret < 0) {
-            mark_unused(bs, s->used_bmap, s->used_bmap_size,
-                        host_off, to_allocate);
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
@@ -868,7 +870,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -928,7 +930,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 3e4f397502..4e7aa6b80f 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,11 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
                                          int64_t *clusters);
 
-- 
2.34.1


