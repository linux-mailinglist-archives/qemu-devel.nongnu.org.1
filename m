Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F6A711CC
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 09:00:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLal-0002wH-Lp; Wed, 26 Mar 2025 03:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZz-0001yx-QL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZy-0006Nf-48
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mudhjy9Q19VTHxL3q5i9hzfzkQjrAedGaNQJCQ2PAfM=;
 b=cO4bpNTGo7qcKSG19tud53q9RGgIY8wmesaNuM+igH+HnnDV3isvrYmSxJUxnDg6GNHv/P
 JOkF0zq0OilpoFH1tkdluiUSx2UkSz3SdsBjT9ZPEHLrlSqTV5E/fqmS5sY/FmAtTXmEt8
 SKMzJAPsG+AAQd/5ijzENdBmlrbQko4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Rg1GwFMdMiKL0kEpWF5yTg-1; Wed,
 26 Mar 2025 03:53:32 -0400
X-MC-Unique: Rg1GwFMdMiKL0kEpWF5yTg-1
X-Mimecast-MFC-AGG-ID: Rg1GwFMdMiKL0kEpWF5yTg_1742975611
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 232CA1956073; Wed, 26 Mar 2025 07:53:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6669119560AB; Wed, 26 Mar 2025 07:53:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 32/37] vfio: Introduce new files for VFIO
 MemoryListener
Date: Wed, 26 Mar 2025 08:51:17 +0100
Message-ID: <20250326075122.1299361-33-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

File "common.c" has been emptied of most of its definitions by the
previous changes and the only definitions left are related to the VFIO
MemoryListener handlers. Rename it to "listener.c" and introduce its
associated "vfio-listener.h" header file for the declarations.

Cleanup a little the includes while at it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-listener.h          | 14 ++++++++++++++
 include/hw/vfio/vfio-common.h    |  1 -
 hw/vfio/container.c              |  1 +
 hw/vfio/iommufd.c                |  1 +
 hw/vfio/{common.c => listener.c} |  0
 hw/vfio/meson.build              |  2 +-
 hw/vfio/trace-events             |  2 +-
 7 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 hw/vfio/vfio-listener.h
 rename hw/vfio/{common.c => listener.c} (100%)

diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
new file mode 100644
index 0000000000000000000000000000000000000000..93af6747b28955f038454a335b361787f8364a3a
--- /dev/null
+++ b/hw/vfio/vfio-listener.h
@@ -0,0 +1,14 @@
+/*
+ * VFIO MemoryListener services
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_LISTENER_H
+#define HW_VFIO_VFIO_LISTENER_H
+
+extern const MemoryListener vfio_memory_listener;
+
+#endif /* HW_VFIO_VFIO_LISTENER_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a804af9f651f0916ca06b3f4f009381eea385ba0..4ab6e18d3c798ab379b98a0a16504814ec0556b1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -131,7 +131,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
-extern const MemoryListener vfio_memory_listener;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c74e08e531a501313cab27c57728a8c940d975be..acebb53dcb1b829d31cc31d9f7f2cc9599f952eb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -35,6 +35,7 @@
 #include "hw/vfio/vfio-container.h"
 #include "vfio-helpers.h"
 #include "vfio-cpr.h"
+#include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a5bd189a86d70bd11ecb80384ac145a51979322b..7488d21215b6eee78c9c51cfb227d9c8c59c4978 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -28,6 +28,7 @@
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
 #include "vfio-cpr.h"
+#include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
diff --git a/hw/vfio/common.c b/hw/vfio/listener.c
similarity index 100%
rename from hw/vfio/common.c
rename to hw/vfio/listener.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 9c8a989db2d4578e97d864c5fd8bcba125eab66a..bccb05098ce18968caaa4d5d8dec3df0852d0398 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,6 +1,6 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
-  'common.c',
+  'listener.c',
   'container-base.c',
   'container.c',
   'helpers.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index aa0ba695fa38f7767bf506ec604046101186e7d4..ddb1bcc24a9cdc405713ca04d4ecc3d4a923ec42 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -89,7 +89,7 @@ vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
-# common.c
+# listener.c
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.49.0


