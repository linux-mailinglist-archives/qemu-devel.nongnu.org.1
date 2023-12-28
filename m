Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3F81F6C6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNt-0005KZ-Mh; Thu, 28 Dec 2023 05:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNr-0005Jc-Du; Thu, 28 Dec 2023 05:12:59 -0500
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNp-0000ek-7R; Thu, 28 Dec 2023 05:12:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvVenub4zFTItxNprG5XJLsszW5JpLsDSOkp0T3QijLP19u5W3aljGszF6VhJza/0vvVwGD8iVTUE3Uq8N/OjUFJ5ctOUVs8ZW/g6VHkDp2pb5uJy+EytZooWwMXx5ybGtNRSvMRKAbD9qgTD6la/ULVFcFiYg1PQ6rlMovb45hmlq7xjVqFm/xEGnCaaByHct/q9ETK+06DiaM3Hd+LkwITcrKMgdEVgdhjTkARtMLa5/cMcQ5xEUnKyfw9hOnhy+4DSLcQuXeV5MQccC+uJf7hg0Nv4xOYNIA2gQuRndU/u3qTXDYDVGHQM0ZsCQmvcw/vTDkigfd/clqh376XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7P+uRNFOiA3jbxt02/V9W2Df0T3Qf9rsJ8x0mN78yo=;
 b=bedRk4XyC4VXa6WPBbgI7Vr77gjnd/NKXEQiIkulafjLdtMm0GladRozigcpEnKzIZsbce7qi9IrEdPg+hAbk0iH3U1qLxkkScnURQMZ84gO3nRp+YY4pfDjm0Nb/SAt713kIVySfALu/4kwAIzeTFGrL0ySiDuoO5//xTibT3GKdMTWrFA5Kr9j0aKiV7lxvXLm8OnTtAyBvfSS8EOaOqY+u76Q31R+Gdat8FZR8vOZjjAWmX8QFvzKexG7ccRJVpbcu9LW6o/oaa2Yd8ImqRCuFYfdd8j0G9fZ4UpRY21boGN59xK80+6lvPzHv7hTgfnI1Q5DZMHjNMye+PprFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7P+uRNFOiA3jbxt02/V9W2Df0T3Qf9rsJ8x0mN78yo=;
 b=nHdjYwaFP1uqT2TH0PSzJcoVIONZdq4M0f6hJLcX49eRDNIbPl3dlmazggd0CWsMj+CFbX2w2vGlEysDTu2Us7+Q8jtay0ntrlkRLizsMx9h42dE/KCuYNKDBu8oK4KpWd+2bnbpzM2Qh7UorI4WhSE9nCZx7521da0G2iyRipAa+bQNJ39Q3J0ua0XgXLBZIHZCu1OZcAZvM72Fqt//o1jQfjKyjAFqznPTewm6C14SZzBe+fHFr0p2pZPzqZecmDVLZTlbU/1W0u33NGwtIT0Fb3/Ntx1RSm6mlBp84kqHLt5HjlLTBAaGa8QcZv64I2XKWHl73qgsd25jKtX+ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:50 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 17/21] parallels: Check unused clusters in
 parallels_check_leak()
Date: Thu, 28 Dec 2023 11:12:28 +0100
Message-Id: <20231228101232.372142-18-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42eb0291-afa8-4d5c-96dd-08dc078d8be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+X6EhB9xZsT2q8nSyGR7Zj+XXWpkvA6ascFr3OvGuQxPa7r9OPE56f0si69iGQbKkrG6D5rl1Ztr46hMR+J7V39T1Wbk19ncnYyAkKh0VH/9I/Cg7lPzpclxRofypnSuvURjotsRb8uQlT5BwArOlzA4ouIvzm8Q82VHRKltLJjDBNvs9/2RbwMHwxWTmyTAIGCwNA5oXJfJm5Woh9ntG3nkIaoRZPUAzVGFlyIq+AKGe6ZSMo1RjDC5vKtS4rJRKYbxi03K2UwjRcQk/SsS9mhunFgNQOV5/iwlI24vztlEud9mzJE4OfbfFhnlBXXfq0hGFBMGCWL9BCstQ+/hMZbqS0KVW4WdgAQuiLCxAAeORPiTgN1HGMLVlmeIgMuFL5+6OJBQMZm3XB0b/FIxNqmHHRGwVn+egS8sX32rUUyMRQGIhbvNm+Stl9KSp4Ko2OpeyrS5hYFq2ARactAKRrSkr/Etj43eB4OoTCmj9ORdMbkOnz8IL4jCv5qBbK4hWFi2qXcEhH3UR+k7sLopgMXG4AFUY0A7D7B1O2Lkg21KX/wXpDpgghFNJpbSDGVq9IfKV0aZAuIWJUT2zLVDrdulYtlp+zQmw+yyTIFpssFRvwqi4mvgxY4JbP9fJ0+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmCN45ShMAWWjEyE6O1GK79PNRDNUOC7Whw8GaAxfzGK2D7fV9BPzgfW6L9I?=
 =?us-ascii?Q?rvWPAeIzeGLmdWgPTeAKxY/hBmTkKwJfTtgJvz9SLsmsQXe291N5A4COsFPf?=
 =?us-ascii?Q?UEQI3YaBbo34bUw7kw0quUrrovtuH66JLbVySm0m8IarA5vWTABADtXUmf6v?=
 =?us-ascii?Q?nCeHd6PJOyE3F5rIcUz0ZcHFBRlXWJoOO3c/FSEt31E42zWAWWhegoNhZGLb?=
 =?us-ascii?Q?pp09pwdw28PVX16N7XBWSIuidqQSxle3kBG4fnEMN4/3Mi5uS2It1KYM3SKy?=
 =?us-ascii?Q?44CTXSrLVtrOtDOeHBpHQD0PjfGnX8h5E1jgUcEt0C8qC7geqkc6LQpAbLUa?=
 =?us-ascii?Q?cPcIUfHOen798TOOGAud3DznOoZKLbZ04ISeWJ+UGkP/MdOJ3kY7Gxmx6ydu?=
 =?us-ascii?Q?vFB0oQcIi6keJ4JbwyExfido1YhCiFM1geJoTzsPwdq5uK2hafl7c2s9EzzY?=
 =?us-ascii?Q?V267bIiPmvJJi4htQYSMAs8QCRKTwQpQK0yR9nIKyrJmdd6Ls3m/hUcBz4YI?=
 =?us-ascii?Q?oHLAvmxlcFHabSgRbhQleFdQiVhSEYaCvB+Q002Dmrp3mW/Rj91XTmzGZ4w6?=
 =?us-ascii?Q?zrNQBeU51OhgyXZ40/GD6if2PzOYathFAw9CTz+RjXFKtv6c0xLX4EG8xcCh?=
 =?us-ascii?Q?ocuK3Pe+rQ6HUn2XP0ADNUD1MaO9FG8Ibbfgi8yBdNB++okk7Dl9WQ1Cqoqx?=
 =?us-ascii?Q?9bYPjtrRwpoqbjAolUPDyPXLzRTR55LEL6/HWHT5Qag1XzmUuSULjcjnZZNy?=
 =?us-ascii?Q?JJuKSJtvXLT8H8m4HRevDToUd6ae5JlF6OeCwxABX28YLvhqsdn6IVb14W3n?=
 =?us-ascii?Q?zT/z1VpoYZopfAbBTURkmf8mv9GP761Siz3MI0WqmKEcaenT5l7GmW7JnT7m?=
 =?us-ascii?Q?CmRHSo2xc74Rex9Smy/07CeqFpfxeLDQSzpRrik0ShzYQSeKOcknTmc7FlrT?=
 =?us-ascii?Q?fkC4H08dIhomh/bg5G73P/qSU1x1VAtambiUsUt3WN4Kodxaw/3N52ugj3M7?=
 =?us-ascii?Q?U5Xvs4jLFJz7VYh7ugfPllhXR+jRFceBRFhWMZ68Wqfdxbnpegh7/wIIB8JV?=
 =?us-ascii?Q?Q12g0lo4XmfYsQ7UsSBS8wVXhzA3F0LxPTBuAVBxFmq8bXqn3LQorBmPG31g?=
 =?us-ascii?Q?J3gU4VOf1bVMWlbpDe0eARQSdfkCM7dpBjAELPnRkoNgeaqk+b+JubSU3pmd?=
 =?us-ascii?Q?8WVhvKpX0akynZWe2fgQ8rYvkcGjCokm/Tl3taYeJOxx+B94OuUzUO1HVxLm?=
 =?us-ascii?Q?TwEqnVe/m5qfjULBNHi1fjDHswBpxG3LgGldzR7flGjCCV5/fD2hGthBrOVs?=
 =?us-ascii?Q?uUZI7l7lFi88bIEhtwSAbYs2O1L84a4ztsct3DgPFS3r/yu3Zh0Cn5D1/92K?=
 =?us-ascii?Q?lCYVG5mh5CI5ZhSPPOtN2OmOTssXccMItOFRu/52q6zgRNn3eUm7q/JTXOYC?=
 =?us-ascii?Q?XvRwpbR9DDWIMwFhskxDfahT0+pdnR0hinfo7O/iysD5UtQSo+XGXfEFaI2m?=
 =?us-ascii?Q?cRXi9niXsMCZIafuU30fc3kzPNStlCENet3uKeVXlPUW56/3+xsgU+7WELya?=
 =?us-ascii?Q?n9LfsmG0Ugg9MluImarSYfztvoKVW+zKwWjVXZLNRy3VsVpt8hjPwEgYIbX9?=
 =?us-ascii?Q?lxumvEHh0VWsT8qEYs+S1Gw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb0291-afa8-4d5c-96dd-08dc078d8be5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:50.0032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWilVy2OISNY2yqaJD47dTMGRPSKyvJQ3yTO4vG9q52lEIWDhQskGAjnpRGTJ4/3HPujC+4UXVhVlXxnn+ZW7HAlpPT3oSEHIaXPALrm+BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since we have used bitmap, leak check is useless. Transform
parallels_truncate_unused_clusters() to parallels_check_unused_clusters()
helper and use it in leak check.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 121 +++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 136865d53e..5ed58826bb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -768,57 +768,87 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t GRAPH_RDLOCK
+parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    leak = file_size - end_off;
+    if (leak < 0) {
+        return -EINVAL;
+    }
+    if (!truncate || leak == 0) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, count;
-    int ret;
+    int64_t leak, count, size;
+
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
-    if (size <= res->image_end_offset) {
+    res->image_end_offset = size;
+
+    if (!explicit) {
         return 0;
     }
 
-    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-    if (explicit) {
-        fprintf(stderr,
-                "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-    }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
     if (fix & BDRV_FIX_LEAKS) {
-        Error *local_err = NULL;
-
-        /*
-         * In order to really repair the image, we must shrink it.
-         * That means we have to pass exact=true.
-         */
-        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                               PREALLOC_MODE_OFF, 0, &local_err);
-        if (ret < 0) {
-            error_report_err(local_err);
-            res->check_errors++;
-            return ret;
-        }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-        parallels_free_used_bitmap(bs);
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            res->check_errors++;
-            return ret;
-        }
-
-        if (explicit) {
-            res->leaks_fixed += count;
-        }
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -1454,23 +1484,6 @@ fail:
     return ret;
 }
 
-static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    uint64_t end_off = 0;
-    if (s->used_bmap_size > 0) {
-        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
-        if (end_off == s->used_bmap_size) {
-            end_off = 0;
-        } else {
-            end_off = (end_off + 1) * s->cluster_size;
-        }
-    }
-    end_off += s->data_start * BDRV_SECTOR_SIZE;
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
-}
-
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1488,7 +1501,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = parallels_truncate_unused_clusters(bs);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.40.1


