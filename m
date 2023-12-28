Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19D81F662
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuO-0008Lc-Ml; Thu, 28 Dec 2023 04:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuG-0008Ee-07; Thu, 28 Dec 2023 04:42:24 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuE-0008Jv-B3; Thu, 28 Dec 2023 04:42:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRGmKrhgqi5KsmL/LqtyPHp01onm92q53z3s1ciPFERuz7/ahKuXSxs7TcLDiNjkeBWNYChRYug+2qGUAlkn/W/5moggNeTARgxAK6xPsHmXkrai0TP8qZbiy7/O+kjkuzL2SwY2cmsEoRJ2BswNXb2C/6BpDYrzrP7H/CGH5dyfWC0ekkdGdOyGXFfGIx48hRj1kfw2E5Cyf/j6+1IKG/iEKNweurTw6eOF8YhIBkY5S6D2jrFAQBaFvh/V/m+HloCvmE8EQfWyA4K41aRwvcItaSWGYovyhWi6kYJ02TCYWXh6bzWglX+UzzozPN+W2GGHIDG5pejpwdV09/8KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaAGGTbyMKywUXOYFWi8PjBTqSV5La+m5rxkBDvvPoo=;
 b=E1sOvB2Gz0P5s2bn3NC9wA8p8/SKcaPZW/YdA5oA+EcQtac0bVuvT01lXBkKGeWBp56pUP3odKg+CEspE9Nt0LsCKJJxeZKc50l34yzoTofoK/+wKO/4leaXeCzcS9ufwmBpjbTKoaAU4chvSgXBeK2sNGtYcE9pYh71ZQgpb2qK6QIrrk2bAERtnipHY/uJC2+RplbYQ3ho34afSD+2dGK/JTqeMClg2JU9K+cYnjnfLbXDarb2wt2+zroVdwcwSaTL4FEZlY2VKl6hR5/HttXUYs/+lb+5RjgfbXZMX1lz431FanM39W9efjGDC5o/PWMCnYkD9vHSQ8Z8keC14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaAGGTbyMKywUXOYFWi8PjBTqSV5La+m5rxkBDvvPoo=;
 b=X2EDjEqc3rPCqQ9mVG/HEp0nPwA6RBQUh4T/hHsL8fH+OWUPqjr1KZsiRYIMOwYbMv8xeb6PeZXKkyWEjSRfyDWJmEVfFTNxlsoXvqyUJvMrW1Mec9OeFHAiacQedepHdoP8hntuMnBK9INpgo8zyLXpnN0iXR6ODPmqauCax0pwLkxYC+squqSdrnv1IgG/33itFTEBE7SSICQG6SFX+gnvh46nC7fHe1ymuMjcrSj34ps4BKAnTuKSbeihP5zj5mxSjHQzl7DUtVr+HSjiEi0r+8kmB89sWnbf5JczNn8jAVATvLN9aHDgQqdKkMFS8qi/LwUgrr1R5gu895o09w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:06 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 18/21] parallels: Remove unnecessary data_end field
Date: Thu, 28 Dec 2023 10:41:50 +0100
Message-Id: <20231228094153.370291-18-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6d86fd-e60e-4fd6-f396-08dc078940f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2H7PlP9DMqgWnWh1lpFxxLbY+nyTHGTAIwv0b6D4doPdzkYbNM0kCHQSxJgUliuOVTjJMy//CIXK4yNYLUlsk+6baNXieCfcyeu6sov1TuuqI8ZQEMmt8LTQyDihq3twW5qAlTCdd7RTzySibgqcG43vU68GvniyAs8z7qb6iMRULCFVo6KCLMWASdXUHw99XjYiuwHVEcTX44IjNkblhSlGbuRDnDnrfaCLTG3lF6f/DftuuR8LR6fe6klmxFpYW55UlYlUkIunM17HoOK9Mf7TtQaWgxCVHrKSA/pZCKIF00QjHHUaUKcpUs2tsO5gXCxcia5ckhfoVw0X8Ewrnecz/sXMjOMRan0f/D8hOnYuzZomUd5VekRsKvF3JgfXOERAZRO+nACtfxyXtzAxEmO/fsrbDhIJtlWI9MCBfWPVR0toll+6SyUqnBw6oT29HczJagTHUqCUOVsAy0C5Od4fZP/zgHDxx66ZYG2eyLuMn1/waNNs++XtaaM616QkALC2NG4YaS5oB53dyH5ZXhA0+g2yURp79kGkJPj+ouHapG4W4fp1c8SXPgmXdSWjE9SC1AT1XwTs0hmwC7ybuqFDFEbEvzQ7g/vVno2BSPWWvRVUzGryuTPXcSefbXbc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?irFCFfTQ5sJanuX4VaE1kbTL7NQidYiHEhTXSwD2tGJfqm6qEEEmWOFMt6e6?=
 =?us-ascii?Q?ts+nd8HC6euQAcj/srHdMtjwN9FGWLXQLJoYrB3qMKhdt9+wRTL73bnFP0DL?=
 =?us-ascii?Q?rRSuxSjwYGsF3KHNCbqATxap8kKl6PhS7C1zRL6lEb9sxW8AueDr/R0olafx?=
 =?us-ascii?Q?19/xYZ5cL6KRLxj36VrcWUbXC4NCAcD+wJ9A+i8RHNcvsV/BQo+VziyzJdAv?=
 =?us-ascii?Q?YJZiXeaJ+2Vyc+JoJY1U8bFKPeXFRMWL0cApg0u3PVxknFWtpgFljACJW27w?=
 =?us-ascii?Q?kWmrsjzO9R4STzSk1L0tXH6W290JXq6dtQ63o7r7qIY2l7zhMF5E93rN/xa1?=
 =?us-ascii?Q?1e04leD6Q4vc+hDkI6N++Dih8bDOmuyj1nuHfUbEjb2C28dy8gRhrdzGlEq1?=
 =?us-ascii?Q?LaS/gDdBP3zKw9opPKibCMKUGRJMi8PKwyI3RG5pCxjlfStiuNf0X2ZrmvYy?=
 =?us-ascii?Q?BN7G75g60btY/8mDg0vZk3qNLACns4L/Md6ei2F2MC2KKS2heRzwSMxBZZig?=
 =?us-ascii?Q?RcICi5Z6A/RyhMLDFo2ITy1d4Qel0oe12pGlcCdZAWmXq9cdR5HNPFE9jl92?=
 =?us-ascii?Q?lpYfqVxVASswMzNBmx7D17GrLpn4znnnEYrw9074uLVkPnLwRuo79nvxMf5H?=
 =?us-ascii?Q?lsPh7Epj20uvpY1siy1kYcEyk01ZAn3BUe20/Pne++cw0ZCc8B04M/IDVfiF?=
 =?us-ascii?Q?mw35JrFR/4ApwUJTRwhlMz3qhs3mRjXYLlGTR9fQgYLxYzRwrzYOebfggqgO?=
 =?us-ascii?Q?CVUh+Khu/HUXoYRavHhrKyaUGP75A1ZINQPVfCAxM+R6HPAzLOUP2ay4Zc8V?=
 =?us-ascii?Q?CuW7jGeWr4OlHyQyE+WVTxCiS7jy0GOlPoxYS1IrIj280zWmnuD371QbB28v?=
 =?us-ascii?Q?dZM56PJRkW2B4YKrfWpnfQB/waFy0r9wzuewgcLJ/jjvHZacuZTiPzeAX7e5?=
 =?us-ascii?Q?WipCBKfcIB+GGPYeAklqwcRBK7h8RLWmdpJQXkYO/A1Ol18GgbDkkAhRrw6+?=
 =?us-ascii?Q?qvBbVk/7D5HU+yKS2Y6GgynK+IdlGFNcDBZcmpBG+XmrsLGRD48Eqev2/k5j?=
 =?us-ascii?Q?wTL/xIkneLzDv01U8SXwcSyglJTP2krlEvJhrKS4JtQM971PALm2VqX1+Tn8?=
 =?us-ascii?Q?ituYybu3tlTyjCrs2JNPBo8b2XyoQPtbZOgLwt3VsoUMyk7fzpz18GGjC2ZJ?=
 =?us-ascii?Q?lenov2o/MQ1ddOXyKiDKbg3yHfjl9xAmLj0SzKVC5zRYUWDc0HEd8HkW6o9d?=
 =?us-ascii?Q?g764AASjnmI+SapJkmThBL02yLkQwddOZflT1RgjibpPErXTx4t1Qql7jxdr?=
 =?us-ascii?Q?GU9BJHReh1KGHO1+5hRnxUxXoYZvz2TN8azB2dhEZW4CN909iJ1v0IkZgBt3?=
 =?us-ascii?Q?BwO4Q9lQKXkQ9PTxBB6Q6j8nYUO2LsKucj6rezBTSMprvvpJ6nhqE8hTb+3n?=
 =?us-ascii?Q?fSDQ1crZ6dP4qyMYZIZha1YYTEpXWgVSIarmk7dtSqLqWTWQ1uOu8INiJHjE?=
 =?us-ascii?Q?hGKrGp7cXG/8Z8rajhxEFLV3r9rPGlS8WBhI0ciUiZi+sMgBo5yj7Ly9qyZ5?=
 =?us-ascii?Q?l+ajb7U90t3BEdVufXHiEhyTCbAl/u/7hokCc4KG6NyaY8yclY11AiuXGFon?=
 =?us-ascii?Q?P6a6M3jIMWpxfa62W71wfA0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d86fd-e60e-4fd6-f396-08dc078940f7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:06.2874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A71pjuCg8zqj14QYu4hyS7ncQBFrzMUzshhPBu517NoWofwn+uuSWUxDR4D38TmSv7HUGUJlVXcF8NXhtn2G9HGienxGMoEOmZIv4ZidUHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 33 +++++++++++++--------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 5ed58826bb..2803119699 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,6 +268,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
                                                       int64_t *clusters)
 {
@@ -279,7 +286,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
@@ -302,9 +309,6 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
@@ -320,8 +324,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
          * branch. In the other case we are likely re-using hole. Preallocate
          * the space if required by the prealloc_mode.
          */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
@@ -758,13 +761,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -803,8 +800,6 @@ parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
         return ret;
     }
 
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-
     parallels_free_used_bitmap(bs);
     ret = parallels_fill_used_bitmap(bs);
     if (ret < 0) {
@@ -1394,8 +1389,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1436,11 +1430,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+        if (sector + s->tracks > file_nb_sectors) {
+            need_check = true;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     ret = parallels_fill_used_bitmap(bs);
     if (ret == -ENOMEM) {
diff --git a/block/parallels.h b/block/parallels.h
index 9db4f5c908..b494d93139 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.40.1


