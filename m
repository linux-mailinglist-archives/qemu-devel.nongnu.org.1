Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112CB08A51
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 12:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLZd-0003x9-Aw; Thu, 17 Jul 2025 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLZ4-0003aY-QK
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLYz-0006JC-Ae
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752747002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGZ5rV9uZPoWCkA95uz1l+D5Wg0g3YqdHzUdpQk3EZw=;
 b=INEBhkdH13z318nRGMRx4Qu+TAXTbnsir+VFVkMXiI64YHm5pIEZV2dn4VLGQhcXnzxHRq
 6IKCVtQvRvt8cKP4U2ZyvuonR5p1SOssjZflNAHFQxE/TIAK61XEVzISxUgvCmuLRMqKls
 8TjbfCVHCzGoEpvyRcPdETSEL+WAf2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-Tod0rL9kP0WcgdYA1ygACg-1; Thu,
 17 Jul 2025 06:10:01 -0400
X-MC-Unique: Tod0rL9kP0WcgdYA1ygACg-1
X-Mimecast-MFC-AGG-ID: Tod0rL9kP0WcgdYA1ygACg_1752747000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DDC3195608E; Thu, 17 Jul 2025 10:10:00 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE0A01801AEC; Thu, 17 Jul 2025 10:09:57 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Shaoqin Huang <shahuang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
Date: Thu, 17 Jul 2025 06:09:40 -0400
Message-Id: <20250717100941.2230408-3-shahuang@redhat.com>
In-Reply-To: <20250717100941.2230408-1-shahuang@redhat.com>
References: <20250717100941.2230408-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the TYPE_* to a new file hw/vfio/types.h because the
TYPE_VFIO_PCI will be used in later patch, but directly include the
hw/vfio/pci.h can cause some compilation error when cross build the
windows version.

The hw/vfio/types.h can be included to mitigate that problem.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 hw/vfio/pci.h   | 10 +---------
 hw/vfio/types.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio/types.h

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 97319670b2..c193ba6659 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -14,6 +14,7 @@
 
 #include "system/memory.h"
 #include "hw/pci/pci_device.h"
+#include "hw/vfio/types.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-region.h"
 #include "qemu/event_notifier.h"
@@ -119,17 +120,8 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
-/*
- * TYPE_VFIO_PCI_BASE is an abstract type used to share code
- * between VFIO implementations that use a kernel driver
- * with those that use user sockets.
- */
-#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
-#define TYPE_VFIO_PCI "vfio-pci"
-/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
-
 struct VFIOPCIDevice {
     PCIDevice pdev;
     VFIODevice vbasedev;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
new file mode 100644
index 0000000000..fa20c29b9f
--- /dev/null
+++ b/hw/vfio/types.h
@@ -0,0 +1,21 @@
+/*
+ * VFIO types definition
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_VFIO_VFIO_TYPES_H
+#define HW_VFIO_VFIO_TYPES_H
+
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+
+#define TYPE_VFIO_PCI "vfio-pci"
+/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
+
+#endif /* HW_VFIO_VFIO_TYPES_H */
-- 
2.40.1


