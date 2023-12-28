Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B806D81F6B6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNz-0005Ms-UL; Thu, 28 Dec 2023 05:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNo-0005HV-P8; Thu, 28 Dec 2023 05:12:56 -0500
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNn-0000fc-4w; Thu, 28 Dec 2023 05:12:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK46IuqAOdGcSExQsSqAjsXvyOii4FJbpn9/8r2QUZ3YAnx/fNOnXgh/v+S0ltK9R4RUV9m98J/QAhAKgC8UZ11Ae3qLtlCgun1RaCxBUyLw4dCb3a6LkpVUFf21vewJxFmc9eodWai3+bku1cUSwDntfRMVjA2cKJ23wIZoYHvciEL+uCoFNvS9tXe63FPGxPR8CLFF2Et/K9xPIkBsg4cAl4oagsFYmTB6CvQ7NmZ8mZDM5CWQaXwFWq1dj2Kd91upKLBV/6K/Efj0lP8vDIAzb9QBB/VvW+yafuwOz6uvw7LGfwKZ+T8FtKzEzDehrG6QlmeVNQoesDoXLkD1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z84wjcZERYFHoLxhiNvThUkhuyvf/sVU/2uyo8YF85o=;
 b=cqTGt3VpoylRnP9AagUnairz5v/Z13ZeH9qDkcRGJbMoPRjSyRRM5nQjMjDD/Tfs84qvQclXe8sa+I9ZnssHNVlman0Gj9yQmlIUEixihhHHPZA1uCynyUlfSN99PCRzamngEh88S0o/QtdGzTj/QYHCgH2K/5HjK815RYSPv7500BbaIHVsByeTjUB9eU+UTsCoSuafRLQ1fTL8Btkw+gCx3NrRrURc87Gjc76hKH39cMGiwK61ETOSnCTYaBVXfuW8Z7Z33COt9kSSI7dzv5BYyS5wN/ojy0cRcF9p4hx0Y1lPDJUYpKxkLvIVhvyf/1zytq2qOI6ctfigbLsKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84wjcZERYFHoLxhiNvThUkhuyvf/sVU/2uyo8YF85o=;
 b=pz5lFzJT2ItQjtu8Xppf0jSPwzDYafBLBKoNocT7FdsC9ckF0o+zQ2pp2qpPaXyNO5x+BEwLdgolLiV3qCoPhjFBei94q44FgsQ8FP04CojE5Pv7UIeTMVD+LMrY9rwBr6kRUnWlTOZusUgMS4ghQ4qGIuhwvIzMfw09OaYo2L9+4Iv4wdjVLbDLauBaAmL4GB4vWxCT6DSE0TvqRHPj98CDXx6+uMKIZjXptcIrVNfoRHs81V2RlHqLm8NBNcohwtxvUHNVQ5rF4INWG/ACCWQEAVyR4QVrPYHjd7fix0eoE3u5eb6zTi4GfsiI8qUHOl2Ed4SxrHt1sQzjj8ahqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:48 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 15/21] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Thu, 28 Dec 2023 11:12:26 +0100
Message-Id: <20231228101232.372142-16-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 768e745a-ada8-4c28-9d3f-08dc078d8b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNxT14SaWpsVIqbj7xi0SCLN5w0PWPfffNwO90UYjpOsNkmN0lD5119+7vnBZUjrUAFTMuDliY2CoMzlSM8IG9nQlL5mGQq8IBObOPF8b0iJ0Ug0vNTOSCt4DUCuZNXl2fwFbNkV68kv2uKUrRxmKWhA5THgw3fMIwBDO94jQ7d2vB0xaRzNXiYso5fsS47YEaXIaq7VvP0YkAzXb864bp+F+QsY6PFu8YDcpKv8xGDDaTnb/mvIWGIzLx/QhaLcn06es6gaHFEBw48sRam0+LMAytZheojmWeWJYnInh7hhyYfzJDtZbNYB5yCkonLJmDaNTDOP6GSfA+nviQ2jXB5tbd85tsqpcura/K8D0gmwBH5Zr8RyXFYPQJolyVg4JgjGoR5hCjuzA8wkMzhOBpCU6s3xi7UCAX0QeNNQWvhGRsTklVZ8GxlhRfmWLKxQ/Fj3jjUgP7Euh8JpaJJPVpjMwTAqwj7qUBlIRLzGK95LLLy2A7sQlLSZt2Y6nbHO1SX8cKXNkLTgkSm+pUESnHcUDhYg2LCUkEu7s4p73JpybFUo7wgkKWZVTpBfuJQYB2UH0K1tGW7FGgBmxgSe+IwZdlirFbT7Ne82hSvnLqmxNkJCAY7QOj+wAdsWFlv2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKG3TZk+y53ne7XEhW1XPSeA5sj2sJP0d1GwCyXC323V9elFXzDu9YtmXLoR?=
 =?us-ascii?Q?TJX4ZdpeFbNGP6nLOwKQ+278xzpa7Z/AzIC8lxC7SFz/ckKBCRtWMRMJgPPX?=
 =?us-ascii?Q?laBobSbBoP2ih9NNB4hIT14Pd3KDZgXXoVHu/MuEgp2LU5xPCL8A1lKuERuf?=
 =?us-ascii?Q?4RQemX7TVuYmh5hm9MB1U1hLAk7/dffi5+E4znz2RrfsOzJ5vsdQCwd791dx?=
 =?us-ascii?Q?4N4jvCQE+EFdYT4ei9KP4fBVnznmVlYpln8DLYseMI8fn1HefXXPUcOyCbIe?=
 =?us-ascii?Q?fDmeYOE+O3QT+AJaGrB21spONAPkJoCCUg1Ff94kuPiBziIPIQt2KI5z47ES?=
 =?us-ascii?Q?6FdTxfbTk2JnDzljBpggdoBJ8r3Zt2v790JtLXH/RtHOk2vK095SBEcc/UiE?=
 =?us-ascii?Q?SvojTE3PsM7JZUhBf40vn6A9qzsjrQOOFxuJFudIaBbwT62m63qjCUvu+Ic2?=
 =?us-ascii?Q?LbZihoEpIgoo4pVLPm7Rbepg1ePnlAeDH54rEzyPcLyGOJ1lk9QiN04aY0R7?=
 =?us-ascii?Q?jEOGadtGXeM1TLANHDfY38o9KbrTAjoVAfj0C7XvuHeWh3VjqPR4XqJFec3h?=
 =?us-ascii?Q?C5/Ptddpu9WCmFaYsX+Vn7YDcVPuxlMAZMNcLccMIzxrT54HE6R3vwf/lmlp?=
 =?us-ascii?Q?99+a9NRgWeCCUDWW9rkxiXyfrgyrWZDGqlQGlW7a/CN0lhcrhyzfzdQyBs89?=
 =?us-ascii?Q?q/n/DC6T5NPqUpvYBQ119wzZKb8d0vDBcN9W6B/9RPLlPqu+SHqyzmopEVhJ?=
 =?us-ascii?Q?EtKl4QsoDYKkPXObT9xLAj1QBFDOJE6DlYc2/UcKtouLm0S1PLJjuwLIemJG?=
 =?us-ascii?Q?q1DjmcHXuF9A+4WdpKFWkSyuWbs1LPhEF9IMrklhFWjmOUvIfmF4fDMR77Lx?=
 =?us-ascii?Q?yLtWDB8KvKq9b/xVZAx231Fpeprj8sUBcgtYDsEek850INH2BTxACN9j47Ds?=
 =?us-ascii?Q?1pER9XO48/vH+91nTmx/WwdaRhW3ZucseE04B64Y5A2noQv9qx5uw0fz7l6P?=
 =?us-ascii?Q?Zqjd4fXf0givC+0EKuJJd4ScGguou4UvZmUsaApFpOn78dNxalC3r3ZODPJp?=
 =?us-ascii?Q?0wNl3esBYyEhT2j38k05sl8gTlGc9pwL6RMONU671cHLrkktCFpzWOs6KJso?=
 =?us-ascii?Q?g6BuGtsJibMFWglsOVGEr6exs7D1bnIAIq2T4tMLZTvzuThRZ9NZZhCahtwf?=
 =?us-ascii?Q?YWfye7Miq+USTQnwLXtoCImSbo9zMHvCVUIVzt8BIN2P9TOyfUtyWEaCSyeo?=
 =?us-ascii?Q?FqilNbTZgMU3KdMtKw+Wtzoe9mey3jR+qK8uviCkGmuT5hZboLyInR1jOsRs?=
 =?us-ascii?Q?lXNaID/ViGKu9hW0jMMnrqsGnfh8scL3fpO0OcRKHCINo6484EO6hP1BeiBX?=
 =?us-ascii?Q?46rLyWK0BS+TkoEV6rcxhnZUw2XG7gY+/GdQCkFMJcEZLWHPt/FeT9Nbd1jw?=
 =?us-ascii?Q?eMssxdiVVek2szNf36jpAWYQRXqSfMRgLfduIzZMQ0KUu0k8CMnGVsWbqxo/?=
 =?us-ascii?Q?PVkWV0G37fnXu4crAqJRWGETt2DZ6NmAoEvlGdLDQh9Vc+yXSmT2Jgznp0bL?=
 =?us-ascii?Q?X0lvcObADuKdSJ3UTK6SR7rd6lKqepGe8xIn6rJu38FGwdl92CEiE0oZmdK+?=
 =?us-ascii?Q?NbfYSvIRlPM1ZZMykW42BPY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e745a-ada8-4c28-9d3f-08dc078d8b0c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:48.5606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxqry+wfSUFSPyJiVRtAe358H9AyVxTT/Wi62XjVxZWLVqkvZFAGyGcrhQBcrDcz/klUzQBMBcu72x1+hSGdUrC4NtQElDaX8UO0cVXlnNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f400:fe0e::727;
 envelope-from=alexander.ivanov@virtuozzo.com;
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d5d87984cf..fb7bc5e555 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -773,7 +773,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -781,43 +781,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
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
2.40.1


