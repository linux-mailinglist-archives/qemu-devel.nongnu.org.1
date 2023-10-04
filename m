Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5277B7976
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwrD-00069D-2y; Wed, 04 Oct 2023 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqj-0004ko-7e; Wed, 04 Oct 2023 04:03:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqf-0008AU-UP; Wed, 04 Oct 2023 04:03:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 342F527597;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 812142CBD3;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: (nullmailer pid 2702789 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 13/45] file-posix: Clear bs->bl.zoned on error
Date: Wed,  4 Oct 2023 11:01:34 +0300
Message-Id: <20231004080221.2702636-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

bs->bl.zoned is what indicates whether the zone information is present
and valid; it is the only thing that raw_refresh_zoned_limits() sets if
CONFIG_BLKZONED is not defined, and it is also the only thing that it
sets if CONFIG_BLKZONED is defined, but there are no zones.

Make sure that it is always set to BLK_Z_NONE if there is an error
anywhere in raw_refresh_zoned_limits() so that we do not accidentally
announce zones while our information is incomplete or invalid.

This also fixes a memory leak in the last error path in
raw_refresh_zoned_limits().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-2-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
(cherry picked from commit 56d1a022a77ea2125564913665eeadf3e303a671)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..2b88b9eefa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1412,11 +1412,9 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     BlockZoneModel zoned;
     int ret;
 
-    bs->bl.zoned = BLK_Z_NONE;
-
     ret = get_sysfs_zoned_model(st, &zoned);
     if (ret < 0 || zoned == BLK_Z_NONE) {
-        return;
+        goto no_zoned;
     }
     bs->bl.zoned = zoned;
 
@@ -1437,10 +1435,10 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Unable to read chunk_sectors "
                                      "sysfs attribute");
-        return;
+        goto no_zoned;
     } else if (!ret) {
         error_setg(errp, "Read 0 from chunk_sectors sysfs attribute");
-        return;
+        goto no_zoned;
     }
     bs->bl.zone_size = ret << BDRV_SECTOR_BITS;
 
@@ -1448,10 +1446,10 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Unable to read nr_zones "
                                      "sysfs attribute");
-        return;
+        goto no_zoned;
     } else if (!ret) {
         error_setg(errp, "Read 0 from nr_zones sysfs attribute");
-        return;
+        goto no_zoned;
     }
     bs->bl.nr_zones = ret;
 
@@ -1472,10 +1470,15 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     ret = get_zones_wp(bs, s->fd, 0, bs->bl.nr_zones, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "report wps failed");
-        bs->wps = NULL;
-        return;
+        goto no_zoned;
     }
     qemu_co_mutex_init(&bs->wps->colock);
+    return;
+
+no_zoned:
+    bs->bl.zoned = BLK_Z_NONE;
+    g_free(bs->wps);
+    bs->wps = NULL;
 }
 #else /* !defined(CONFIG_BLKZONED) */
 static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
-- 
2.39.2


