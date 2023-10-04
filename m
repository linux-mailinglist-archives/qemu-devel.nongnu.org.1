Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468F7B7984
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsJ-00016h-Ov; Wed, 04 Oct 2023 04:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqn-0004m0-TK; Wed, 04 Oct 2023 04:03:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqm-0008Hx-C1; Wed, 04 Oct 2023 04:03:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C25BC2759A;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1865F2CBD6;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: (nullmailer pid 2702798 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 16/45] file-posix: Simplify raw_co_prw's 'out' zone code
Date: Wed,  4 Oct 2023 11:01:37 +0300
Message-Id: <20231004080221.2702636-16-mjt@tls.msk.ru>
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

We duplicate the same condition three times here, pull it out to the top
level.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-5-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
(cherry picked from commit d31b50a15dd25a560749b25fc40b6484fd1a57b7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index a050682e97..aa89789737 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2506,11 +2506,10 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
 
 out:
 #if defined(CONFIG_BLKZONED)
-{
-    BlockZoneWps *wps = bs->wps;
-    if (ret == 0) {
-        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
-            bs->bl.zoned != BLK_Z_NONE) {
+    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+        bs->bl.zoned != BLK_Z_NONE) {
+        BlockZoneWps *wps = bs->wps;
+        if (ret == 0) {
             uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
@@ -2523,19 +2522,12 @@ out:
                     *wp = offset + bytes;
                 }
             }
-        }
-    } else {
-        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
-            bs->bl.zoned != BLK_Z_NONE) {
+        } else {
             update_zones_wp(bs, s->fd, 0, 1);
         }
-    }
 
-    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
-        bs->blk.zoned != BLK_Z_NONE) {
         qemu_co_mutex_unlock(&wps->colock);
     }
-}
 #endif
     return ret;
 }
-- 
2.39.2


