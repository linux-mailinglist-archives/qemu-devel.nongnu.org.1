Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A817E9725
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 08:58:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ro7-000748-G3; Mon, 13 Nov 2023 02:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1r2Ro2-00073f-Td
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:56:27 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1r2Rnq-0001vH-2q
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699862174; x=1731398174;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/cdj4fgMPBfc2f8sdspMnb5jdiIkKkHgL9CQDAJtbhI=;
 b=XIzaLbZCLrU2gOnnmSYiEfhdo4x0P8qwnp2cJLnmmZhRAA90DrZgbyab
 lIJ0p4oWq6t1gRSFZfEoac/pGVSScv5KMYoHVGFUHR6srIAQ5ww113ycx
 823a7inRHmHwgbxysIBgCMxJ8JOviQpqbYgbQuJtgK/pRKeWNl6jiOc4F
 chQuxeW83teRbILIW3Qmov+7bPUg8qdcd8sVqvD+9TbXmiqu4j3DkZGCU
 LbPYxlyyL+hNckIHvOsVXDBplDzT/QapflKw9R3UioemriYUm/gEq978z
 DPGMK9uVnYWqqFBRCnJm3xhdP0wfkCI/qPOHqUoQ6hjaGBJZFbi/3QSO/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="370592710"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="370592710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2023 23:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="887870680"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="887870680"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2023 23:56:06 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for passthrough
 devices on Intel platforms
Date: Sun, 12 Nov 2023 23:32:39 -0800
Message-Id: <20231113073239.270591-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A recent OVMF update has resulted in MMIO regions being placed at
the upper end of the physical address space. As a result, when a
Host device is passthrough'd to the Guest via VFIO, the following
mapping failures occur when VFIO tries to map the MMIO regions of
the device:
VFIO_MAP_DMA failed: Invalid argument
vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000) = -22 (Invalid argument)

The above failures are mainly seen on some Intel platforms where
the physical address width is larger than the Host's IOMMU
address width. In these cases, VFIO fails to map the MMIO regions
because the IOVAs would be larger than the IOMMU aperture regions.

Therefore, one way to solve this problem would be to ensure that
cpu->phys_bits = <IOMMU phys_bits>
This can be done by parsing the IOMMU caps value from sysfs and
extracting the address width and using it to override the
phys_bits value as shown in this patch.

Previous attempt at solving this issue in OVMF:
https://edk2.groups.io/g/devel/topic/102359124

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 92ecb7254b..8326ec95bc 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -12,6 +12,8 @@
 #include "host-cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "sysemu/sysemu.h"
 
 /* Note: Only safe for use on x86(-64) hosts */
@@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
     env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
 }
 
+static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **errp)
+{
+    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
+    const char *driver = qemu_opt_get(opts, "driver");
+    const char *device = qemu_opt_get(opts, "host");
+    uint32_t *iommu_phys_bits = opaque;
+    struct stat st;
+    uint64_t iommu_caps;
+
+    /*
+     * Check if the user is passthroughing any devices via VFIO. We don't
+     * have to limit phys_bits if there are no valid passthrough devices.
+     */
+    if (g_strcmp0(driver, "vfio-pci") || !device) {
+        return 0;
+    }
+
+    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
+    if (stat(dev_path, &st) < 0) {
+        return 0;
+    }
+
+    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap", dev_path);
+    if (stat(iommu_path, &st) < 0) {
+        return 0;
+    }
+
+    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
+        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
+            return 0;
+        }
+        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
+    }
+
+    return 0;
+}
+
+static uint32_t host_iommu_phys_bits(void)
+{
+    uint32_t iommu_phys_bits = 0;
+
+    qemu_opts_foreach(qemu_find_opts("device"),
+                      intel_iommu_check, &iommu_phys_bits, NULL);
+    return iommu_phys_bits;
+}
+
 static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
+    uint32_t iommu_phys_bits = host_iommu_phys_bits();
     uint32_t phys_bits = cpu->phys_bits;
-    static bool warned;
+    static bool warned, warned2;
 
     /*
      * Print a warning if the user set it to a value that's not the
@@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
         }
     }
 
+    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
+        phys_bits = iommu_phys_bits;
+        if (!warned2) {
+            warn_report("Using physical bits (%u)"
+                        " to prevent VFIO mapping failures",
+                        iommu_phys_bits);
+            warned2 = true;
+        }
+    }
+
     return phys_bits;
 }
 
-- 
2.39.2


