Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF0AA9053
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 11:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsXi-0003mD-Ip; Mon, 05 May 2025 05:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com>)
 id 1uBsXI-0003ZL-Lk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com>)
 id 1uBsXG-0005Iy-SI
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Mp2Eg6CkyW+uhuWyA5G7O36YvvWOJfgQ0Dp3mofC4KE=; b=vY3uq
 BLNH9KOHm/heySeau1nJ67ntbJMwz/9cgmMziVNP08x72HB9emvYtmKvNsHcXdTyV8HJkocKYB4xD
 OJDSt9CQ0IU63UyWrjtIcej+TEshECgbWI1Wf04ET8exPVJ/YAjR60PfUfp/dhwJwdzETcwWCPZuT
 V006yoBkDc+9PPQf9mWpvJxsVv4SaE9EcIyammQr37pXD6sDq7u92xnbLuR3nt0j1iZINvvut7a0U
 1k8NDEANm5iodLKIn32DpUHSUhJkW8hUY68Crh/sQhNbMjfHs3wjFf1Wm0CCFeS1V48m5nzLUNG5P
 MBBNl9wx6MUX5CshSaJDJ1+Wxiid/Bz26QL13BARy7A3IaiZCFgf0PCFtboNhHT/FXvHCyMpaCLRK
 1T6aP8jE9BGh1JwRriIg63CJuiugiqA7DcogVw16PfWPZ5+t7yT0Xfr5w5jl5Sst8TVLa5ndWinog
 wOnUg+qTfWXSCEVUChSsPbj/HrcEyz1myjx+2Y8bilUpv8DVUMmCYFqi5R2y7XDqjGlP+XlRMAxLg
 bFuNPomU+OA1MXDuRPJWQm42AG5UMxvMssGm7qED+yyHc9XNEPtkd/8Aiy7jqxoLjncQL22CswOu+
 eN6pv/+qrgBw8Fin67Y8Tz9lPWW5vatf/tanTWjh9uNOZIuoT97BR1VHrVjgy4=;
Message-Id: <cdafeda35709ddf8cd982a7eb653c2a5028c8074.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 9/9] 9pfs: fix 'total_open_fd' decrementation
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=cdafeda35709ddf8cd982a7eb653c2a5028c8074@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to 'man 2 close' errors returned by close() should only be used
for either diagnostic purposes or for catching data loss due to a previous
write error, as an error result of close() usually indicates a deferred
error of a previous write operation.

Therefore not decrementing 'total_open_fd' on a close() error is wrong
and would yield in a higher open file descriptor count than actually the
case, leading to 9p server reclaiming open file descriptors too soon.

Based-on: <20250312152933.383967-7-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
---
 hw/9pfs/9p.c     | 10 +++++++++-
 hw/9pfs/codir.c  |  7 ++++++-
 hw/9pfs/cofile.c |  7 ++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b22df3aa2b..8b001b9112 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -510,7 +510,15 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
             err = (f->fid_type == P9_FID_DIR) ?
                 s->ops->closedir(&s->ctx, &f->fs_reclaim) :
                 s->ops->close(&s->ctx, &f->fs_reclaim);
-            if (!err) {
+
+            /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+            if (unlikely(err && errno == EBADF)) {
+                /*
+                 * unexpected case as FIDs were picked above by having a valid
+                 * file descriptor
+                 */
+                error_report("9pfs: v9fs_reclaim_fd() WARNING: close() failed with EBADF");
+            } else {
                 /* total_open_fd must only be mutated on main thread */
                 nclosed++;
             }
diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 2068a4779d..bce7dd96e9 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -20,6 +20,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "coth.h"
 #include "9p-xattr.h"
 #include "9p-util.h"
@@ -353,7 +354,11 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
                 err = -errno;
             }
         });
-    if (!err) {
+    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+    if (unlikely(err && errno == EBADF)) {
+        /* unexpected case as we should have checked for a valid file handle */
+        error_report("9pfs: WARNING: v9fs_co_closedir() failed with EBADF");
+    } else {
         total_open_fd--;
     }
     return err;
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 71174c3e4a..6e775c8e41 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -20,6 +20,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "coth.h"
 
 int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t st_mode,
@@ -197,7 +198,11 @@ int coroutine_fn v9fs_co_close(V9fsPDU *pdu, V9fsFidOpenState *fs)
                 err = -errno;
             }
         });
-    if (!err) {
+    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
+    if (unlikely(err && errno == EBADF)) {
+        /* unexpected case as we should have checked for a valid file handle */
+        error_report("9pfs: WARNING: v9fs_co_close() failed with EBADF");
+    } else {
         total_open_fd--;
     }
     return err;
-- 
2.30.2


