Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F2A44F4F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 22:54:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn2rZ-00085A-Tr; Tue, 25 Feb 2025 16:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tn2rW-000843-AH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tn2rU-0006TS-DX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740520387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fq1FAbNulZQYGxVJXwEFjS3D9TMxkXkGQaljILjEBM=;
 b=FuTw8Ldtw54OhGMsSQrZHMm0S2cD9l2alpy5EEfwn1lt/inUc260Gj8TgSP7AwVIy5k0/l
 dxPfUynhmFuVU2+booCsWIYutEESI253V4BYKDRnPpNMwayEex5OldmWbY7G430Ht9F4Gi
 YYAs5xsl2qMkt291uP3EgLSjucol4Rg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-gLYftw_dOUi6w5ciN3sezg-1; Tue,
 25 Feb 2025 16:53:04 -0500
X-MC-Unique: gLYftw_dOUi6w5ciN3sezg-1
X-Mimecast-MFC-AGG-ID: gLYftw_dOUi6w5ciN3sezg_1740520382
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A26518EB2C3; Tue, 25 Feb 2025 21:53:01 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D98A300018D; Tue, 25 Feb 2025 21:52:56 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v2 2/5] pci: Use PCI PM capability initializer
Date: Tue, 25 Feb 2025 14:52:26 -0700
Message-ID: <20250225215237.3314011-3-alex.williamson@redhat.com>
In-Reply-To: <20250225215237.3314011-1-alex.williamson@redhat.com>
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Switch callers directly initializing the PCI PM capability with
pci_add_capability() to use pci_pm_init().

Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/net/e1000e.c                 | 3 +--
 hw/net/eepro100.c               | 4 +---
 hw/net/igb.c                    | 3 +--
 hw/nvme/ctrl.c                  | 3 +--
 hw/pci-bridge/pcie_pci_bridge.c | 2 +-
 hw/vfio/pci.c                   | 7 ++++++-
 hw/virtio/virtio-pci.c          | 3 +--
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f637853073e2..b72cbab7e889 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -372,8 +372,7 @@ static int
 e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     Error *local_err = NULL;
-    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
-                                 PCI_PM_SIZEOF, &local_err);
+    int ret = pci_pm_init(pdev, offset, &local_err);
 
     if (local_err) {
         error_report_err(local_err);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 6d853229aec2..29a39865a608 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -551,9 +551,7 @@ static void e100_pci_reset(EEPRO100State *s, Error **errp)
     if (info->power_management) {
         /* Power Management Capabilities */
         int cfg_offset = 0xdc;
-        int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
-                                   cfg_offset, PCI_PM_SIZEOF,
-                                   errp);
+        int r = pci_pm_init(&s->dev, cfg_offset, errp);
         if (r < 0) {
             return;
         }
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 4d93ce629f95..700dbc746d3d 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -356,8 +356,7 @@ static int
 igb_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     Error *local_err = NULL;
-    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
-                                 PCI_PM_SIZEOF, &local_err);
+    int ret = pci_pm_init(pdev, offset, &local_err);
 
     if (local_err) {
         error_report_err(local_err);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 68903d1d7067..1faea3d2b85b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8503,8 +8503,7 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     Error *err = NULL;
     int ret;
 
-    ret = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
-                             PCI_PM_SIZEOF, &err);
+    ret = pci_pm_init(pci_dev, offset, &err);
     if (err) {
         error_report_err(err);
         return ret;
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fd4514a595ce..9fa656b43b42 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -52,7 +52,7 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
         goto cap_error;
     }
 
-    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp);
+    pos = pci_pm_init(d, 0, errp);
     if (pos < 0) {
         goto pm_error;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89d900e9cf0c..1a4a0b4b15b4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2216,7 +2216,12 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
         vdev->pm_cap = pos;
-        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
+        ret = pci_pm_init(pdev, pos, errp) >= 0;
+        /*
+         * PCI-core config space emulation needs write access to the power
+         * state enabled for tracking BAR mapping relative to PM state.
+         */
+        pci_set_word(pdev->wmask + pos + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
         break;
     case PCI_CAP_ID_AF:
         vfio_check_af_flr(vdev, pos);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c773a9130c7e..afe8b5551c5c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2204,8 +2204,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
 
-        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0,
-                                 PCI_PM_SIZEOF, errp);
+        pos = pci_pm_init(pci_dev, 0, errp);
         if (pos < 0) {
             return;
         }
-- 
2.48.1


