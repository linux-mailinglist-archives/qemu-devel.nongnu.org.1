Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404E7B7997
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsP-0001e4-2n; Wed, 04 Oct 2023 04:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqk-0004li-VC; Wed, 04 Oct 2023 04:03:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqj-0008HQ-9h; Wed, 04 Oct 2023 04:03:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 713BF27598;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AFEBC2CBD4;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: (nullmailer pid 2702792 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 14/45] file-posix: Check bs->bl.zoned for zone info
Date: Wed,  4 Oct 2023 11:01:35 +0300
Message-Id: <20231004080221.2702636-14-mjt@tls.msk.ru>
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

Instead of checking bs->wps or bs->bl.zone_size for whether zone
information is present, check bs->bl.zoned.  That is the flag that
raw_refresh_zoned_limits() reliably sets to indicate zone support.  If
it is set to something other than BLK_Z_NONE, other values and objects
like bs->wps and bs->bl.zone_size must be non-null/zero and valid; if it
is not, we cannot rely on their validity.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-3-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
(cherry picked from commit 4b5d80f3d02096a9bb1f651f6b3401ba40877159)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 2b88b9eefa..46e22403fe 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2455,9 +2455,10 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     if (fd_open(bs) < 0)
         return -EIO;
 #if defined(CONFIG_BLKZONED)
-    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wps) {
+    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+        bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
-        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
+        if (type & QEMU_AIO_ZONE_APPEND) {
             int index = offset / bs->bl.zone_size;
             offset = bs->wps->wp[index];
         }
@@ -2508,8 +2509,8 @@ out:
 {
     BlockZoneWps *wps = bs->wps;
     if (ret == 0) {
-        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
-            && wps && bs->bl.zone_size) {
+        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+            bs->bl.zoned != BLK_Z_NONE) {
             uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
@@ -2529,7 +2530,8 @@ out:
         }
     }
 
-    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && wps) {
+    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+        bs->blk.zoned != BLK_Z_NONE) {
         qemu_co_mutex_unlock(&wps->colock);
     }
 }
-- 
2.39.2


