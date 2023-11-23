Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2687F5800
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 07:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r62nv-0002ku-OA; Thu, 23 Nov 2023 01:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r62nr-0002dF-Am; Thu, 23 Nov 2023 01:03:08 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r62np-00005N-A9; Thu, 23 Nov 2023 01:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700719385; x=1732255385;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XiDgQsyO8IfBEOqRpZwGMATykEtrpSFdKJ11FmST9aU=;
 b=AbFV6hOl4ZHBH0uCDkkiErRmkaH2c6QHFsBem9gefO7DP+9QVm5tkja5
 YiczyyV11SoqIH3S4HwEXpTdnE2gDXrZrz6SdsYJtb01ztAllapFU3BUN
 abLchGOBN/MO6giv1WjysTbAjZgSR06WzEsFyrRmyo6gTCG3wLf57ac5t
 3p5lOX7RivueuKmueFAhP7jGFu1ndHO4DolLYqa1l/Xww+yskKE9pN2Zi
 6ORH7A062X2+jcQJZ61osItRnIG40DMEo+PuRkAlRT2BTzJz3MWpozmJZ
 qqq7Vpo0JS6B71WebQ5mWdNVUWPPb2ZYQCJ8KU+K5dW2cff6cHxMYnbhE A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382604288"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; d="scan'208";a="382604288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2023 22:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="858024149"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; d="scan'208";a="858024149"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2023 22:02:56 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH] hw/ppc: Improve build for PPC VFIO
Date: Thu, 23 Nov 2023 14:01:09 +0800
Message-Id: <20231123060109.131904-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

VFIO is not a required subsystem for the pseries machine but it's
force enabled currently. When --without-default-devices is used
to drop some default devices including vfio-pci, vfio core code
is still kept which is unnecessary.

Introduce a stub file to hold stub functions of VFIO EEH hooks,
then vfio core could be compiled out.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
Based on vfio-next/vfio-8.2

 hw/ppc/spapr_pci_vfio_stub.c | 33 +++++++++++++++++++++++++++++++++
 hw/ppc/Kconfig               |  2 +-
 hw/ppc/meson.build           |  6 +++---
 3 files changed, 37 insertions(+), 4 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_vfio_stub.c

diff --git a/hw/ppc/spapr_pci_vfio_stub.c b/hw/ppc/spapr_pci_vfio_stub.c
new file mode 100644
index 0000000000..adb3fb5e35
--- /dev/null
+++ b/hw/ppc/spapr_pci_vfio_stub.c
@@ -0,0 +1,33 @@
+#include "qemu/osdep.h"
+#include "hw/pci-host/spapr.h"
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
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index edc6d2d139..b8dabdbfbe 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -3,11 +3,11 @@ config PSERIES
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
+    imply VFIO if LINUX   # needed by spapr_pci_vfio.c
     select NVDIMM
     select DIMM
     select PCI
     select SPAPR_VSCSI
-    select VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
     select XICS
     select XIVE
     select MSI_NONBROKEN
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ea44856d43..2df5db2eef 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -34,9 +34,9 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
   'spapr_softmmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
-ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
-  'spapr_pci_vfio.c',
-))
+ppc_ss.add(when: [ 'CONFIG_VFIO_PCI', 'CONFIG_PSERIES', 'CONFIG_LINUX'],
+           if_true: files('spapr_pci_vfio.c'),
+           if_false: files('spapr_pci_vfio_stub.c'))
 
 # IBM PowerNV
 ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
-- 
2.34.1


