Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A58706234
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6f-0002e1-7g; Wed, 17 May 2023 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6O-00023q-C7; Wed, 17 May 2023 04:01:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6L-0000b3-AX; Wed, 17 May 2023 04:01:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 055BA675F;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6759B5E17;
 Wed, 17 May 2023 11:00:59 +0300 (MSK)
Received: (nullmailer pid 3624145 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v8.0.1 22/36] block: Consistently call bdrv_activate() outside
 coroutine
Date: Wed, 17 May 2023 11:00:42 +0300
Message-Id: <20230517080056.3623993-22-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

Migration code can call bdrv_activate() in coroutine context, whereas
other callers call it outside of coroutines. As it calls other code that
is not supposed to run in coroutines, standardise on running outside of
coroutines.

This adds a no_co_wrapper to switch to the main loop before calling
bdrv_activate().

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230504115750.54437-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit da4afaff074e56b0fa0d25abf865784148018895)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/block-backend.c              | 10 +++++++++-
 include/block/block-global-state.h |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 55efc735b4..d59f759daf 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2018,7 +2018,15 @@ void blk_activate(BlockBackend *blk, Error **errp)
         return;
     }
 
-    bdrv_activate(bs, errp);
+    /*
+     * Migration code can call this function in coroutine context, so leave
+     * coroutine context if necessary.
+     */
+    if (qemu_in_coroutine()) {
+        bdrv_co_activate(bs, errp);
+    } else {
+        bdrv_activate(bs, errp);
+    }
 }
 
 bool coroutine_fn blk_co_is_inserted(BlockBackend *blk)
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 399200a9a3..2c312cc774 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -166,7 +166,11 @@ int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **errp);
 
-int bdrv_activate(BlockDriverState *bs, Error **errp);
+int no_coroutine_fn bdrv_activate(BlockDriverState *bs, Error **errp);
+
+int coroutine_fn no_co_wrapper
+bdrv_co_activate(BlockDriverState *bs, Error **errp);
+
 void bdrv_activate_all(Error **errp);
 int bdrv_inactivate_all(void);
 
-- 
2.39.2


