Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B637063C8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCq-0003lr-3s; Wed, 17 May 2023 05:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC7-0001gR-Dx; Wed, 17 May 2023 05:11:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC4-0006V4-OF; Wed, 17 May 2023 05:11:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA61D6841;
 Wed, 17 May 2023 12:10:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5253F5F12;
 Wed, 17 May 2023 12:10:46 +0300 (MSK)
Received: (nullmailer pid 3626748 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH v7.2.3 27/30] 9pfs/xen: Fix segfault on shutdown
Date: Wed, 17 May 2023 12:10:39 +0300
Message-Id: <20230517091042.3626593-27-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

From: Jason Andryuk <jandryuk@gmail.com>

xen_9pfs_free can't use gnttabdev since it is already closed and NULL-ed
out when free is called.  Do the teardown in _disconnect().  This
matches the setup done in _connect().

trace-events are also added for the XenDevOps functions.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
[C.S.: - Remove redundant return in xen_9pfs_free().
       - Add comment to trace-events. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 92e667f6fd5806a6a705a2a43e572bd9ec6819da)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: minor context conflict in hw/9pfs/xen-9p-backend.c)
---
 hw/9pfs/trace-events     |  6 ++++++
 hw/9pfs/xen-9p-backend.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index 6c77966c0b..a12e55c165 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -48,3 +48,9 @@ v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d id %d name %s"
 v9fs_setattr(uint16_t tag, uint8_t id, int32_t fid, int32_t valid, int32_t mode, int32_t uid, int32_t gid, int64_t size, int64_t atime_sec, int64_t mtime_sec) "tag %u id %u fid %d iattr={valid %d mode %d uid %d gid %d size %"PRId64" atime=%"PRId64" mtime=%"PRId64" }"
 v9fs_setattr_return(uint16_t tag, uint8_t id) "tag %u id %u"
+
+# xen-9p-backend.c
+xen_9pfs_alloc(char *name) "name %s"
+xen_9pfs_connect(char *name) "name %s"
+xen_9pfs_disconnect(char *name) "name %s"
+xen_9pfs_free(char *name) "name %s"
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 65c4979c3c..ab1df8dd2f 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -24,6 +24,8 @@
 #include "qemu/option.h"
 #include "fsdev/qemu-fsdev.h"
 
+#include "trace.h"
+
 #define VERSIONS "1"
 #define MAX_RINGS 8
 #define MAX_RING_ORDER 9
@@ -335,6 +337,8 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
     int i;
 
+    trace_xen_9pfs_disconnect(xendev->name);
+
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
@@ -343,39 +347,40 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
                              xen_9pdev->rings[i].local_port);
             xen_9pdev->rings[i].evtchndev = NULL;
         }
-    }
-}
-
-static int xen_9pfs_free(struct XenLegacyDevice *xendev)
-{
-    Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
-    int i;
-
-    if (xen_9pdev->rings[0].evtchndev != NULL) {
-        xen_9pfs_disconnect(xendev);
-    }
-
-    for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].data != NULL) {
             xen_be_unmap_grant_refs(&xen_9pdev->xendev,
                                     xen_9pdev->rings[i].data,
                                     (1 << xen_9pdev->rings[i].ring_order));
+            xen_9pdev->rings[i].data = NULL;
         }
         if (xen_9pdev->rings[i].intf != NULL) {
             xen_be_unmap_grant_refs(&xen_9pdev->xendev,
                                     xen_9pdev->rings[i].intf,
                                     1);
+            xen_9pdev->rings[i].intf = NULL;
         }
         if (xen_9pdev->rings[i].bh != NULL) {
             qemu_bh_delete(xen_9pdev->rings[i].bh);
+            xen_9pdev->rings[i].bh = NULL;
         }
     }
 
     g_free(xen_9pdev->id);
+    xen_9pdev->id = NULL;
     g_free(xen_9pdev->tag);
+    xen_9pdev->tag = NULL;
     g_free(xen_9pdev->path);
+    xen_9pdev->path = NULL;
     g_free(xen_9pdev->security_model);
+    xen_9pdev->security_model = NULL;
     g_free(xen_9pdev->rings);
+    xen_9pdev->rings = NULL;
+}
+
+static int xen_9pfs_free(struct XenLegacyDevice *xendev)
+{
+    trace_xen_9pfs_free(xendev->name);
+
     return 0;
 }
 
@@ -387,6 +392,8 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
     V9fsState *s = &xen_9pdev->state;
     QemuOpts *fsdev;
 
+    trace_xen_9pfs_connect(xendev->name);
+
     if (xenstore_read_fe_int(&xen_9pdev->xendev, "num-rings",
                              &xen_9pdev->num_rings) == -1 ||
         xen_9pdev->num_rings > MAX_RINGS || xen_9pdev->num_rings < 1) {
@@ -494,6 +501,8 @@ out:
 
 static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
 {
+    trace_xen_9pfs_alloc(xendev->name);
+
     xenstore_write_be_str(xendev, "versions", VERSIONS);
     xenstore_write_be_int(xendev, "max-rings", MAX_RINGS);
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
-- 
2.39.2


