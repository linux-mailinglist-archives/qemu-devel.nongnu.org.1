Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE67CD895
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38I-0000zL-I5; Wed, 18 Oct 2023 05:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt384-0000We-BQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt382-0003UD-PE
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qw52xXVz4xbs;
 Wed, 18 Oct 2023 20:46:13 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qw33V4tz4xbC;
 Wed, 18 Oct 2023 20:46:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/22] vfio/common: Store the parent container in VFIODevice
Date: Wed, 18 Oct 2023 11:45:22 +0200
Message-ID: <20231018094531.733211-14-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

let's store the parent contaienr within the VFIODevice.
This simplifies the logic in vfio_viommu_preset() and
brings the benefice to hide the group specificity which
is useful for IOMMUFD migration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/common.c              | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8ca70dd82156e25610fe96917843f334549818fe..bf12e406676e5577ad9454152aec9340666241dc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -132,6 +132,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
     struct VFIOGroup *group;
+    VFIOContainer *container;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ef9dc7c74713f113a459db61aad7a017e21cf99a..55f8a113ea82afeb9620d46286f04f85dd9e8b54 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,7 +184,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->group->container->space->as != &address_space_memory;
+    return vbasedev->container->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -2655,6 +2655,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     }
 
     container = group->container;
+    vbasedev->container = container;
     QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
 
     return ret;
@@ -2664,7 +2665,12 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
+    if (!vbasedev->container) {
+        return;
+    }
+
     QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->container = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
-- 
2.41.0


