Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53781F661
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuA-0008Bg-Nc; Thu, 28 Dec 2023 04:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu5-0008AJ-2H; Thu, 28 Dec 2023 04:42:14 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu2-0008Gn-DX; Thu, 28 Dec 2023 04:42:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEtS5QGxsb9EyKv1IFkSoTNxTK4qOy50ITojo+DK3cWf7JhfhcSNzx07nrKj2ddz+kdCuy/xJ2jtbYEf+s89QP7x1fUCIMhw0BtvUE0/bG4pRN0c6sUezb/FSa3QsD13YQHEwmF485ozInzlIBY4WzP69I3V4uunxmjPm2ISEqndtB35AerwY2DJMhQdxR5ghpP4qrT7EQyEbKKeFx+bJneQijT9xi6ZnA+Anr8IGtU2DYQqqiZs2q4QA65uBlxUKZHL547EfjUDBZGPpCQWF2XD3tLfxjUrDfQ/5PCFA+p7WPCfkfjk8G4u4NdwzqtUx89GLV0n3dwVWEzxDxTMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLEBTAXP1y3bSSPP0h3JqoKN2wlm3/jxIfexYA7pjcc=;
 b=NMK0FSfQwQErgXcTZP6CdcerEnU2gOpZs/Lp5jJGQWsk9wF/XPJLPOXT7Y3UadO1x9el8MEZZl3USuNt0z4xo6wT+0unk7KnUPF51CoXtWGdjJPF3LXuUh3ActO5p/38Ou+ETIacBT42CjZUYp4EyToa+vDP+utyNcIgT5ShQ5snGYuCkoKDp7bLCEx3w2lUk/1ySYGcsLRujue+MXUx/c9ZM3zl1x7UFFqVxgapScr5N1wXPjhke5sIbFMEjcFXSLjOpLz4Psl+F4IPqg+9DJP4JnkVxFFKUWNz30DjdcNFtwsFrzaBoEFfqJmYFQRu12Kf+pv90lng1qeW0AahiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLEBTAXP1y3bSSPP0h3JqoKN2wlm3/jxIfexYA7pjcc=;
 b=0SqEaj4M0vejGDYRjq6vpw4zYXqWllN86QwR3PPHThIMB+cOA6ntSqczEW8isRBVSx4w7JD5JFzDkphppBCWFaBRdRQo3G8qe82fWwpg8FfR0QBB6aMm1400ObkYS84TFx3Dd4ahX1EpSP7tfG8msyRSCmK6vB8+MyrhSila+kUqeNQLiYVE67e14giNrC/uQyUA9KKNsVrwEepD5AEQPKPwYdKzbbHuwrQOIq3lfDAAB3WqD/JYYU7IAd13o1iYEZH33v2ZapJHDMPOasT97fUn2LZfCHz57EjBLDlD9aZefK1kDQvl77nkGkbCOWx9fWgugT0/aH4KzLiD6M3ZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:02 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 06/21] parallels: Move host clusters allocation to a separate
 function
Date: Thu, 28 Dec 2023 10:41:38 +0100
Message-Id: <20231228094153.370291-6-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c964d0dc-aa16-46d5-6ddf-08dc07893e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpYSYGYPfJ4XG2gR1ECEvZ7JYgVaB5XWfGfnZzz3InU1gENLKTXvoT2PVzdXx+W+SR+AzvwbvxT1S9KpKqy6hOMIP9iAPzteWDRtXJrKcPsgdDb6hnw0KOLifiLkdOO33dageiXRnldxOvgha5A9DXDYAkPRKe1kfmjXwSouR/surs7eRojjBtJ5964FtRGx58eNHOLipar2LnMmh5BFSfnEYC3Q64aJjfuH1zZzb09F47JGqkXyEeGhA5h9KFPskH8gU5wQfwIR2G7tDuZlY49hRVu+/slJwcGJ+wRigqewQ7HB6Zw5vW5/JbhhAYqtNdhvQwt5x5zZBJqXdBE5ga2mvVOy6SgE+jUOde2YBmK26tgH6kfgeZlq13y+oDfnCMNk8cvHdPmWddcH0D17nqyqLOboS1lcKoi7qTfvDE7d2NttrJERUD8Y1eKEt07Ze2OxyEXRzwzpTrtnwsl79IfxyM/LoqQEZX1eAvb5EniBUM5ixd30S2GCvptLycDbTdx6TOKteNml+kr3ifBL+7bkPwQjBAoe9Idz6P17UvlF48iPQLIcu1Qcb4Lpy6b768HM3544gMYQt+lK6GVReKaELJWSrVxpPaBLcB3ymHaVWrL5eApha6nTridRFUjm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ywl2zFK3ql3c4H159bp46zePsh0v53ddrMgM8biP8EivqToTuhL1xpEaMpo?=
 =?us-ascii?Q?ZFYxuMp6xmcl8LPJYmuJaZQvLTOyyltlqqJRIU9ipQ48qn7ReWI5VQZfs8t1?=
 =?us-ascii?Q?TQUluq/QCEvQSKIq7jBxziqbjUQ425t8vRXf3JkFp4q55k4SU/3EoleleMif?=
 =?us-ascii?Q?Vgj6nPPIb/Z/QjkSXh9gGaK6kPajV5hHpBgM/RnkCHyn6Wk38E9PyiuEVA3n?=
 =?us-ascii?Q?RtCvs2ySUixAHJvguMZm0grO9dlZw+CU8lU1gwzbj7H9zpDl+oUUD47qtKkj?=
 =?us-ascii?Q?RnTFyHPyA10366MnpTVZpAfds53obQhyvfuqDKgHzkH473uY5AtQkxfmjQ0T?=
 =?us-ascii?Q?XwDVnLV7Rwoxsogv72qhLARsw+5WzBzy4+UKCC0ybrRS5np1hBCRxiAI7Q2b?=
 =?us-ascii?Q?i9ZJPaXry1dX+JhfWiDwySswJpXUavEIBoJDeG711y0rMQdctDp24pf9p5Ud?=
 =?us-ascii?Q?6o6EsVmAtHXsk6VpRZLwYyPNyVPU1S1rmf0hQoxO+U5jiXIY7gh0qzxzHGOB?=
 =?us-ascii?Q?kN2IWJILw34C58Rzh0v4w5OdRi1rjKNPBl13y85P4zgVjHCd4p8zweSJPYPv?=
 =?us-ascii?Q?gwNaR7lb2VM4EBiCX0pMYUjD7kwqZ7nUAqo2YU6fNCfeAaID+HiA54kp4lNa?=
 =?us-ascii?Q?tr+cQ6C1sr2YYhji2rOnSp1TjBheZwp67YLFIu9otrUjAzo15lr/BA9TIGeA?=
 =?us-ascii?Q?qGg05QQ49V96O2Nwj0zltazY5kSuioVdTKGzBr7wd7/Y9GXqAwl48GPdt76r?=
 =?us-ascii?Q?zDuiYTZI8puGE5wJrC+1j2SOnqUSow1ji3NyaxAvoI6yS8VsvZkkS40+51Yr?=
 =?us-ascii?Q?pYUep+2tZ0ndbFNhc98SOtbJD3FFep6dSsBL/P4CA6y/ABIEfjLrHUPvra83?=
 =?us-ascii?Q?CGp8+XUJax4qkq8kX4J3W/64MMqqcA4XGsqP3dELsvK15rNWZoBwpUb44iTv?=
 =?us-ascii?Q?R9AexPeEcEc2Bj+hrPuN24ELaPpMY1RHlLnWpJiIBioFoeRc6vS80dFdouI5?=
 =?us-ascii?Q?U4qm7Y8qJHhvjwlUXxs5SioUAAIZ+lc26DFCQi/tbn8aipdzh6+csycYPiq0?=
 =?us-ascii?Q?6VTQ+455kPjvkbK2Abag3BBC0Hwkaz48FXRGPJ7FtIQLaW0fkt8x4ur8jfas?=
 =?us-ascii?Q?9SdLFl8vf02wJZE4X05SB6ryekldYhSeqGbOkRSVLUm3nk3SucKrNNW8nZAS?=
 =?us-ascii?Q?IS2Id8HAhCgFeiRJ/rUL8AonEIH7OkbXRX2OoNQu9spTlwT4hpg37yI1ny5S?=
 =?us-ascii?Q?SVVm3avZppN03SCvcrjKcrxyrtx5v7tfIqxXKgTv2mg+8NgKY6pho7bdCH1v?=
 =?us-ascii?Q?Vgmwzck/dK3cNdh20bmnqngaR675TrH8WOuIjbqEgU5+KaiR04CJh1ZSEhqa?=
 =?us-ascii?Q?DqMMQACW6WSCXY9vEGDCeFWe7OI2qIvXXfBmIdZNwYOzW69tqrtcRbq0QmgI?=
 =?us-ascii?Q?QZSEEegrUpQnsE9mGNuT7UzeA+ZGdQZDWjMDJp9yIl5+JAunXkleb08W6+S3?=
 =?us-ascii?Q?iX9Y8V2ShcufbQynxZHKk8PGIL1yz1qZVym7AP/iJiaVq81wez+kKzvQQac6?=
 =?us-ascii?Q?0rxKMO7LsZaeysEMvenDFXpjIc86tUILnUYwhXbB/4rT039I2REwDbNWP34u?=
 =?us-ascii?Q?it3W+baWHZTJLkoVIn81Pw8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c964d0dc-aa16-46d5-6ddf-08dc07893e50
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:01.8279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onL72W+FalrFTj+B4/2Uci2UN56aKa2YPHpo6ehNg3H9caN4+NOHlckRp/7rGxMtSvsK5nCyLP5rYm0F7BdctITSJ10Wv7/jblauTJbZdE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

For parallels images extensions we need to allocate host clusters
without any connection to BAT. Move host clusters allocation code to
parallels_allocate_host_clusters().

This function can be called not only from coroutines so all the
*_co_* functions were replaced by corresponding wrappers.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 128 ++++++++++++++++++++++++----------------------
 block/parallels.h |   3 ++
 2 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 13726fb3d5..658902ae51 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,58 +268,31 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
-static int64_t coroutine_fn GRAPH_RDLOCK
-allocate_clusters(BlockDriverState *bs, int64_t sector_num,
-                  int nb_sectors, int *pnum)
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters)
 {
-    int ret = 0;
     BDRVParallelsState *s = bs->opaque;
-    int64_t i, pos, idx, to_allocate, first_free, host_off;
-
-    pos = block_status(s, sector_num, nb_sectors, pnum);
-    if (pos > 0) {
-        return pos;
-    }
-
-    idx = sector_num / s->tracks;
-    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
-
-    /*
-     * This function is called only by parallels_co_writev(), which will never
-     * pass a sector_num at or beyond the end of the image (because the block
-     * layer never passes such a sector_num to that function). Therefore, idx
-     * is always below s->bat_size.
-     * block_status() will limit *pnum so that sector_num + *pnum will not
-     * exceed the image end. Therefore, idx + to_allocate cannot exceed
-     * s->bat_size.
-     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t.
-     */
-    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+    int64_t first_free, next_used, host_off, prealloc_clusters;
+    int64_t bytes, prealloc_bytes;
+    uint32_t new_usedsize;
+    int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        uint32_t new_usedsize;
-        int64_t bytes = to_allocate * s->cluster_size;
-        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
-
         host_off = s->data_end * BDRV_SECTOR_SIZE;
+        prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
+        bytes = *clusters * s->cluster_size;
+        prealloc_bytes = prealloc_clusters * s->cluster_size;
 
-        /*
-         * We require the expanded size to read back as zero. If the
-         * user permitted truncation, we try that; but if it fails, we
-         * force the safer-but-slower fallocate.
-         */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file, host_off + bytes,
-                                   false, PREALLOC_MODE_OFF,
-                                   BDRV_REQ_ZERO_WRITE, NULL);
+            ret = bdrv_truncate(bs->file, host_off + prealloc_bytes, false,
+                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
                 s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, prealloc_bytes, 0);
         }
         if (ret < 0) {
             return ret;
@@ -329,15 +302,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
+        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
+            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
+        }
     } else {
-        int64_t next_used;
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
         /* Not enough continuous clusters in the middle, adjust the size */
-        if (next_used - first_free < to_allocate) {
-            to_allocate = next_used - first_free;
-            *pnum = (idx + to_allocate) * s->tracks - sector_num;
-        }
+        *clusters = MIN(*clusters, next_used - first_free);
+        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
@@ -349,14 +322,59 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
                 host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
-                                        s->cluster_size * to_allocate, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
             }
         }
     }
 
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
+    if (ret < 0) {
+        /* Image consistency is broken. Alarm! */
+        return ret;
+    }
+
+    return host_off;
+}
+
+static int64_t coroutine_fn GRAPH_RDLOCK
+allocate_clusters(BlockDriverState *bs, int64_t sector_num,
+                  int nb_sectors, int *pnum)
+{
+    int ret = 0;
+    BDRVParallelsState *s = bs->opaque;
+    int64_t i, pos, idx, to_allocate, host_off;
+
+    pos = block_status(s, sector_num, nb_sectors, pnum);
+    if (pos > 0) {
+        return pos;
+    }
+
+    idx = sector_num / s->tracks;
+    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
+
+    /*
+     * This function is called only by parallels_co_writev(), which will never
+     * pass a sector_num at or beyond the end of the image (because the block
+     * layer never passes such a sector_num to that function). Therefore, idx
+     * is always below s->bat_size.
+     * block_status() will limit *pnum so that sector_num + *pnum will not
+     * exceed the image end. Therefore, idx + to_allocate cannot exceed
+     * s->bat_size.
+     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
+     * will always fit into a uint32_t.
+     */
+    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+
+    host_off = parallels_allocate_host_clusters(bs, &to_allocate);
+    if (host_off < 0) {
+        return host_off;
+    }
+
+    *pnum = MIN(*pnum, (idx + to_allocate) * s->tracks - sector_num);
+
     /*
      * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
@@ -373,33 +391,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
                             nb_cow_bytes, buf, 0);
-        if (ret < 0) {
-            qemu_vfree(buf);
-            return ret;
+        if (ret == 0) {
+            ret = bdrv_co_pwrite(bs->file, host_off, nb_cow_bytes, buf, 0);
         }
 
-        ret = bdrv_co_pwrite(bs->file, s->data_end * BDRV_SECTOR_SIZE,
-                             nb_cow_bytes, buf, 0);
         qemu_vfree(buf);
         if (ret < 0) {
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
 
-    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
-                              host_off, to_allocate);
-    if (ret < 0) {
-        /* Image consistency is broken. Alarm! */
-        return ret;
-    }
     for (i = 0; i < to_allocate; i++) {
         parallels_set_bat_entry(s, idx + i,
                 host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
         host_off += s->cluster_size;
     }
-    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = host_off / BDRV_SECTOR_SIZE;
-    }
 
     return bat2sect(s, idx) + sector_num % s->tracks;
 }
diff --git a/block/parallels.h b/block/parallels.h
index 02b857b4a4..493c89e976 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -95,6 +95,9 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
 int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
                           uint32_t bitmap_size, int64_t off, uint32_t count);
 
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.40.1


