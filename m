Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C364A971F6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 18:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G7O-0001Cu-72; Tue, 22 Apr 2025 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5M-0006s5-2c
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5J-00050J-NJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqYt9v5zOpxNJkisolyyo1jH3ZbJt+sqfK7k0SuRknQ=;
 b=LRi1Vk9m6IlwnFhhVWO+F+rPiDWOA0xGfKi9OeojzfyJgwvE50LEEdiX5SCvaP2ehVAuZL
 E0uKgBTIl6IPLRyN+b56r3pARcIEoGhfOdzMIB7xwZAgPTXqOw0NsXzTLuwKBqfi1Dv4RN
 xgpXhdl9oYQJfkEh11XSa4m0ooZnhyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-dELx4IpyOmWw9Cv-hgyUsQ-1; Tue,
 22 Apr 2025 12:02:54 -0400
X-MC-Unique: dELx4IpyOmWw9Cv-hgyUsQ-1
X-Mimecast-MFC-AGG-ID: dELx4IpyOmWw9Cv-hgyUsQ_1745337773
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 229371800984; Tue, 22 Apr 2025 16:02:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA82618001DA; Tue, 22 Apr 2025 16:02:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 06/37] vfio: Introduce a new header file for internal
 migration services
Date: Tue, 22 Apr 2025 18:01:53 +0200
Message-ID: <20250422160224.199714-7-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Gather all VFIO migration related declarations into
"vfio-migration-internal.h" to reduce exposure of VFIO internals in
"hw/vfio/vfio-common.h".

Cc: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-7-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-migration-internal.h | 72 +++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h     | 52 +---------------------
 hw/vfio/common.c                  |  1 +
 hw/vfio/migration-multifd.c       |  2 +-
 hw/vfio/migration.c               |  1 +
 hw/vfio/pci.c                     |  1 +
 6 files changed, 77 insertions(+), 52 deletions(-)
 create mode 100644 hw/vfio/vfio-migration-internal.h

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
new file mode 100644
index 0000000000000000000000000000000000000000..ab6a1bad9b513aa61557905e72e5c6b264372276
--- /dev/null
+++ b/hw/vfio/vfio-migration-internal.h
@@ -0,0 +1,72 @@
+/*
+ * VFIO migration
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_MIGRATION_INTERNAL_H
+#define HW_VFIO_VFIO_MIGRATION_INTERNAL_H
+
+#ifdef CONFIG_LINUX
+#include <linux/vfio.h>
+#endif
+
+#include "qemu/typedefs.h"
+#include "qemu/notify.h"
+
+/*
+ * Flags to be used as unique delimiters for VFIO devices in the migration
+ * stream. These flags are composed as:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => Magic ID, represents emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ *
+ * The beginning of state information is marked by _DEV_CONFIG_STATE,
+ * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
+ * certain state information is marked by _END_OF_STATE.
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+
+typedef struct VFIODevice VFIODevice;
+typedef struct VFIOMultifd VFIOMultifd;
+
+typedef struct VFIOMigration {
+    struct VFIODevice *vbasedev;
+    VMChangeStateEntry *vm_state;
+    NotifierWithReturn migration_state;
+    uint32_t device_state;
+    int data_fd;
+    void *data_buffer;
+    size_t data_buffer_size;
+    uint64_t mig_flags;
+    uint64_t precopy_init_size;
+    uint64_t precopy_dirty_size;
+    bool multifd_transfer;
+    VFIOMultifd *multifd;
+    bool initial_data_sent;
+
+    bool event_save_iterate_started;
+    bool event_precopy_empty_hit;
+} VFIOMigration;
+
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_exit(VFIODevice *vbasedev);
+int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
+int vfio_load_device_config_state(QEMUFile *f, void *opaque);
+
+#ifdef CONFIG_LINUX
+int vfio_migration_set_state(VFIODevice *vbasedev,
+                             enum vfio_device_mig_state new_state,
+                             enum vfio_device_mig_state recover_state,
+                             Error **errp);
+#endif
+
+void vfio_migration_add_bytes_transferred(unsigned long val);
+
+#endif /* HW_VFIO_VFIO_MIGRATION_INTERNAL_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8bb206d755adab4efee32a173c920d9aa4833685..920ad154b4f82b9c244b5b9e8da44f7583e5ead0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -23,7 +23,6 @@
 
 #include "exec/memory.h"
 #include "qemu/queue.h"
-#include "qemu/notify.h"
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
 #ifdef CONFIG_LINUX
@@ -36,23 +35,6 @@
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
-/*
- * Flags to be used as unique delimiters for VFIO devices in the migration
- * stream. These flags are composed as:
- * 0xffffffff => MSB 32-bit all 1s
- * 0xef10     => Magic ID, represents emulated (virtual) function IO
- * 0x0000     => 16-bits reserved for flags
- *
- * The beginning of state information is marked by _DEV_CONFIG_STATE,
- * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
- * certain state information is marked by _END_OF_STATE.
- */
-#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
-#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
-#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
-#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
-#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
-
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
@@ -78,27 +60,6 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
-typedef struct VFIOMultifd VFIOMultifd;
-
-typedef struct VFIOMigration {
-    struct VFIODevice *vbasedev;
-    VMChangeStateEntry *vm_state;
-    NotifierWithReturn migration_state;
-    uint32_t device_state;
-    int data_fd;
-    void *data_buffer;
-    size_t data_buffer_size;
-    uint64_t mig_flags;
-    uint64_t precopy_init_size;
-    uint64_t precopy_dirty_size;
-    bool multifd_transfer;
-    VFIOMultifd *multifd;
-    bool initial_data_sent;
-
-    bool event_save_iterate_started;
-    bool event_precopy_empty_hit;
-} VFIOMigration;
-
 struct VFIOGroup;
 
 typedef struct VFIOContainer {
@@ -136,6 +97,7 @@ typedef struct VFIOIOMMUFDContainer {
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIOMigration VFIOMigration;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -290,13 +252,9 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
-int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
-int vfio_load_device_config_state(QEMUFile *f, void *opaque);
-
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
@@ -311,16 +269,8 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
-
-int vfio_migration_set_state(VFIODevice *vbasedev,
-                             enum vfio_device_mig_state new_state,
-                             enum vfio_device_mig_state recover_state,
-                             Error **errp);
 #endif
 
-bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
-void vfio_migration_exit(VFIODevice *vbasedev);
-
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 bool vfio_devices_all_dirty_tracking_started(
     const VFIOContainerBase *bcontainer);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a4ec60e018df7dc9bbbeac27120907b0f7bf2f83..9bbd798e3e9e0b7a7620d4b1f34f1ef5e8ac42c1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,7 @@
 #include "migration/qemu-file.h"
 #include "system/tcg.h"
 #include "system/tpm.h"
+#include "vfio-migration-internal.h"
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 09aa57f5f890f37f7e36c857fd813f55b1da2fce..a3005226b9ca22ff27d9d49339d9828a43713932 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -11,7 +11,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
-#include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
@@ -22,6 +21,7 @@
 #include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
 #include "migration-multifd.h"
+#include "vfio-migration-internal.h"
 #include "trace.h"
 
 #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 96d294794bc3056baa3b0b4e23488402db5de797..2a72a8e07542096276cc7c386359ad375e7d24c8 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -31,6 +31,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "hw/hw.h"
+#include "vfio-migration-internal.h"
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..158deca06cb240622a254f5059c47873e5fcc7de 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,6 +44,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
+#include "vfio-migration-internal.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
-- 
2.49.0


