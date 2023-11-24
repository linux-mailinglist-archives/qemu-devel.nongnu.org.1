Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A37F6DA8
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:07:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6RDc-0007vF-Im; Fri, 24 Nov 2023 03:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=BZsm=HF=redhat.com=clg@ozlabs.org>)
 id 1r6RDZ-0007uZ-Du; Fri, 24 Nov 2023 03:07:17 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=BZsm=HF=redhat.com=clg@ozlabs.org>)
 id 1r6RDX-0008WI-KA; Fri, 24 Nov 2023 03:07:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc6yf6KZwz4wcj;
 Fri, 24 Nov 2023 19:07:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc6yb1nzBz4x2N;
 Fri, 24 Nov 2023 19:07:02 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/ppc/Kconfig: Imply VFIO_PCI
Date: Fri, 24 Nov 2023 09:06:58 +0100
Message-ID: <20231124080658.893770-1-clg@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=BZsm=HF=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

When the legacy and iommufd backends were introduced, a set of common
vfio-pci routines were exported in pci.c for both backends to use :

  vfio_pci_pre_reset
  vfio_pci_get_pci_hot_reset_info
  vfio_pci_host_match
  vfio_pci_post_reset

This introduced a build failure on PPC when --without-default-devices
is use because VFIO is always selected in ppc/Kconfig but VFIO_PCI is
not.

Use an 'imply VFIO_PCI' in ppc/Kconfig and bypass compilation of the
VFIO EEH hooks routines defined in hw/ppc/spapr_pci_vfio.c with
CONFIG_VFIO_PCI.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ppc/spapr_pci_vfio.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/ppc/Kconfig          |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index d1d07bec4644da4ae6a99d3357d6d17ff66264de..76b2a3487b5d6f21528e9c301341eb27bc8fec1d 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -26,10 +26,12 @@
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-common.h"
 #include "qemu/error-report.h"
+#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
 /*
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
+#ifdef CONFIG_VFIO_PCI
 static bool vfio_eeh_container_ok(VFIOContainer *container)
 {
     /*
@@ -314,3 +316,37 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
 
     return RTAS_OUT_SUCCESS;
 }
+
+#else
+
+bool spapr_phb_eeh_available(SpaprPhbState *sphb)
+{
+    return false;
+}
+
+void spapr_phb_vfio_reset(DeviceState *qdev)
+{
+}
+
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
+                                  unsigned int addr, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+#endif /* CONFIG_VFIO_PCI */
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 56f0475a8e2e46e433d9df02460aec65e26d77a5..44263a58c4d3202afbe8bb44c67701bded855a57 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -3,11 +3,11 @@ config PSERIES
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
+    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
     select NVDIMM
     select DIMM
     select PCI
     select SPAPR_VSCSI
-    select VFIO if LINUX   # needed by spapr_pci_vfio.c
     select XICS
     select XIVE
     select MSI_NONBROKEN
-- 
2.42.0


