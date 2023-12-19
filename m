Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21D819048
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:05:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIs-0003qN-Iy; Tue, 19 Dec 2023 13:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIW-0003XK-Rt
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIH-0007AK-DD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDR2vXjz4xQj;
 Wed, 20 Dec 2023 05:58:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDL5YWyz4xCp;
 Wed, 20 Dec 2023 05:58:10 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/47] vfio/container: Implement attach/detach_device
Date: Tue, 19 Dec 2023 19:56:11 +0100
Message-ID: <20231219185643.725448-16-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c    | 16 ++++++++++++++++
 hw/vfio/container.c | 12 +++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8ef2e7967d6572e3ad3d53d6d5b5d3d0c95301ae..483ba820890460cba0ec7a4ecfed72d66433d41e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1498,3 +1498,19 @@ retry:
 
     return info;
 }
+
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
+
+    return ops->attach_device(name, vbasedev, as, errp);
+}
+
+void vfio_detach_device(VFIODevice *vbasedev)
+{
+    if (!vbasedev->bcontainer) {
+        return;
+    }
+    vbasedev->bcontainer->ops->detach_device(vbasedev);
+}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 721c0d7375bd1e07f04e33558e8ca3b3f234412d..6bacf38222ad9d95e05897572995e925e46b54dc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -873,8 +873,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
  * @name and @vbasedev->name are likely to be different depending
  * on the type of the device, hence the need for passing @name
  */
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp)
+static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
+                                     AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
@@ -914,14 +914,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     return ret;
 }
 
-void vfio_detach_device(VFIODevice *vbasedev)
+static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    if (!vbasedev->bcontainer) {
-        return;
-    }
-
     QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
@@ -933,6 +929,8 @@ void vfio_detach_device(VFIODevice *vbasedev)
 const VFIOIOMMUOps vfio_legacy_ops = {
     .dma_map = vfio_legacy_dma_map,
     .dma_unmap = vfio_legacy_dma_unmap,
+    .attach_device = vfio_legacy_attach_device,
+    .detach_device = vfio_legacy_detach_device,
     .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
     .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
 };
-- 
2.43.0


