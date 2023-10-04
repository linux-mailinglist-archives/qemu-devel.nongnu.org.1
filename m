Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50A7B7993
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsW-00023t-L6; Wed, 04 Oct 2023 04:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqm-0004lt-7D; Wed, 04 Oct 2023 04:03:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqk-0008Hk-It; Wed, 04 Oct 2023 04:03:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90A8527599;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ECC0D2CBD5;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: (nullmailer pid 2702795 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 15/45] file-posix: Fix zone update in I/O error path
Date: Wed,  4 Oct 2023 11:01:36 +0300
Message-Id: <20231004080221.2702636-15-mjt@tls.msk.ru>
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

We must check that zone information is present before running
update_zones_wp().

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2234374
Fixes: Coverity CID 1512459
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-4-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
(cherry picked from commit deab5c9a4ed74f76a713008a42527762b30a7e84)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 46e22403fe..a050682e97 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2525,7 +2525,8 @@ out:
             }
         }
     } else {
-        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+            bs->bl.zoned != BLK_Z_NONE) {
             update_zones_wp(bs, s->fd, 0, 1);
         }
     }
-- 
2.39.2


