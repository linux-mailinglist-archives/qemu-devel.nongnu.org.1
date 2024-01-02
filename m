Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2158821BAE
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:33:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdwj-0003Lh-Rq; Tue, 02 Jan 2024 07:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sWZB=IM=redhat.com=clg@ozlabs.org>)
 id 1rKdwh-0003L4-Do
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:32:35 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sWZB=IM=redhat.com=clg@ozlabs.org>)
 id 1rKdwb-0006Q8-Lg
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:32:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T4C0k5dgnz4x5k;
 Tue,  2 Jan 2024 23:32:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4C0j0DSpz4x2P;
 Tue,  2 Jan 2024 23:32:20 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] backends/iommufd: Remove mutex
Date: Tue,  2 Jan 2024 13:32:10 +0100
Message-ID: <20240102123210.1184293-3-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102123210.1184293-1-clg@redhat.com>
References: <20240102123210.1184293-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sWZB=IM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Coverity reports a concurrent data access violation because be->users
is being accessed in iommufd_backend_can_be_deleted() without holding
the mutex.

However, these routines are called from the QEMU main thread when a
device is created. In this case, the code paths should be protected by
the BQL lock and it should be safe to drop the IOMMUFD backend mutex.
Simply remove it.

Fixes: CID 1531550
Fixes: CID 1531549
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/iommufd.h | 2 --
 backends/iommufd.c       | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9c5524b0ed15ef5f81be159415bc216572a283d8..9af27ebd6ccb78ca8e16aa3c62629aab9f7f31e4 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -2,7 +2,6 @@
 #define SYSEMU_IOMMUFD_H
 
 #include "qom/object.h"
-#include "qemu/thread.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
 
@@ -19,7 +18,6 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
-    QemuMutex lock;
     uint32_t users;
 
     /*< public >*/
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 393c0d9a3719e3de1a6b51a8ff2e75e184badc82..1ef683c7b080e688af46c5b98e61eafa73e39895 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -29,7 +29,6 @@ static void iommufd_backend_init(Object *obj)
     be->fd = -1;
     be->users = 0;
     be->owned = true;
-    qemu_mutex_init(&be->lock);
 }
 
 static void iommufd_backend_finalize(Object *obj)
@@ -52,10 +51,8 @@ static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
         error_prepend(errp, "Could not parse remote object fd %s:", str);
         return;
     }
-    qemu_mutex_lock(&be->lock);
     be->fd = fd;
     be->owned = false;
-    qemu_mutex_unlock(&be->lock);
     trace_iommu_backend_set_fd(be->fd);
 }
 
@@ -79,7 +76,6 @@ int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
     int fd, ret = 0;
 
-    qemu_mutex_lock(&be->lock);
     if (be->owned && !be->users) {
         fd = qemu_open_old("/dev/iommu", O_RDWR);
         if (fd < 0) {
@@ -93,13 +89,11 @@ int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 out:
     trace_iommufd_backend_connect(be->fd, be->owned,
                                   be->users, ret);
-    qemu_mutex_unlock(&be->lock);
     return ret;
 }
 
 void iommufd_backend_disconnect(IOMMUFDBackend *be)
 {
-    qemu_mutex_lock(&be->lock);
     if (!be->users) {
         goto out;
     }
@@ -110,7 +104,6 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
     }
 out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
-    qemu_mutex_unlock(&be->lock);
 }
 
 int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
-- 
2.43.0


