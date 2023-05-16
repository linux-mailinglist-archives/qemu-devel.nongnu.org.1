Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D718705301
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyx84-0004mE-Fo; Tue, 16 May 2023 12:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <92e667f6fd5806a6a705a2a43e572bd9ec6819da@lizzy.crudebyte.com>)
 id 1pyx7r-0004fM-71
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:02:17 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <92e667f6fd5806a6a705a2a43e572bd9ec6819da@lizzy.crudebyte.com>)
 id 1pyx7o-0005ay-19
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=k/90AN6vIUWHooVGX72TSem9nRsu/shYh23nNeqFEJc=; b=lr9yy
 7gRJXjSz6blLg/j3Ka3stuAVxeKa1f50hkQtySLzQMaSlJKLsC6IQ/UiFuvJP0nsN2ktN+NA1DqRp
 LhVGBLZYyigfrNUs2QoKKT4RzLWrtjQDLhPpDs4Ah+v0fdHzFO85TyecvlbOqGlLz3sOa1MmyNwWx
 oZloDq9ze1LfxQsnQ8QO/9nV5nGaRw2WH7uVZmX+WL06Zu8LIXF+3jEYGg80oiwxa0CKwxY5grsQX
 1ip9L1xZfDTN46TfVNm/yAtnIFwyd7K30wSJjsZ5k+3RgLSBLFbow5EbkOpdTLh1Y/wP0TfVIrvWY
 x5H+yplpVo3o7S856ieQwk/Du9V/A==;
Message-Id: <92e667f6fd5806a6a705a2a43e572bd9ec6819da.1684250463.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 May 2023 17:21:04 +0200
Subject: [PULL 3/4] 9pfs/xen: Fix segfault on shutdown
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=92e667f6fd5806a6a705a2a43e572bd9ec6819da@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20230502143722.15613-1-jandryuk@gmail.com>
[C.S.: - Remove redundant return in xen_9pfs_free().
       - Add comment to trace-events. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
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
index 0e266c552b..4aa9c8c736 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -25,6 +25,8 @@
 #include "qemu/iov.h"
 #include "fsdev/qemu-fsdev.h"
 
+#include "trace.h"
+
 #define VERSIONS "1"
 #define MAX_RINGS 8
 #define MAX_RING_ORDER 9
@@ -337,6 +339,8 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
     int i;
 
+    trace_xen_9pfs_disconnect(xendev->name);
+
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
@@ -345,40 +349,41 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
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
                                     xen_9pdev->rings[i].intf->ref,
                                     (1 << xen_9pdev->rings[i].ring_order));
+            xen_9pdev->rings[i].data = NULL;
         }
         if (xen_9pdev->rings[i].intf != NULL) {
             xen_be_unmap_grant_ref(&xen_9pdev->xendev,
                                    xen_9pdev->rings[i].intf,
                                    xen_9pdev->rings[i].ref);
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
 
@@ -390,6 +395,8 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
     V9fsState *s = &xen_9pdev->state;
     QemuOpts *fsdev;
 
+    trace_xen_9pfs_connect(xendev->name);
+
     if (xenstore_read_fe_int(&xen_9pdev->xendev, "num-rings",
                              &xen_9pdev->num_rings) == -1 ||
         xen_9pdev->num_rings > MAX_RINGS || xen_9pdev->num_rings < 1) {
@@ -499,6 +506,8 @@ out:
 
 static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
 {
+    trace_xen_9pfs_alloc(xendev->name);
+
     xenstore_write_be_str(xendev, "versions", VERSIONS);
     xenstore_write_be_int(xendev, "max-rings", MAX_RINGS);
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
-- 
2.30.2


