Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA3831FD8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYJQ-0005BL-EG; Thu, 18 Jan 2024 14:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQYJM-0005Ai-AF
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:44:24 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQYJJ-0006ts-OC
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705607061; x=1737143061;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2UPpxnTEyYA2/VUwlWfzLPKZxXkBAJPp0CRd+0fb7AQ=;
 b=PyI9Ju4HntQgufE0YjNt2wVqD2r5QBtWzo2zClrEBwf5IL9XaEMy37No
 F9KH3MfXhVnjEqrxr9pOrXPzfcX6SMdOji52UPnj7aqWoerRaMq3ylKX+
 voEV8zUq93RjTn8jq4ReNy8X9cjrjA5aK2uMXHlBEOIJkbceOocLI+jSp
 qucz5+QKqCSVr0dpSn8Br4CrXQHNJ8ghsRzY3Ud+H9HhzjI+z4d3x8at+
 ZosVT8dwrgxxq6Mt24/J08X00Mp8mSU6sQPqpOea1LXXe2y0yculFmNz0
 RlWnLtSJqab3cFDQ0wHybybZ59sOUzmmct7ei8/nCnZ4jzH2D3dF7Rmg9 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="399427644"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="399427644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 11:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="903924572"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="903924572"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 11:44:16 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Date: Thu, 18 Jan 2024 11:20:49 -0800
Message-Id: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Recent updates in OVMF and Seabios have resulted in MMIO regions
being placed at the upper end of the physical address space. As a
result, when a Host device is assigned to the Guest via VFIO, the
following mapping failures occur when VFIO tries to map the MMIO
regions of the device:
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
Cc: Cédric Le Goater <clg@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

---
v2:
- Replace the term passthrough with assigned (Laszlo)
- Update the commit message to note that both OVMF and Seabios
  guests are affected (Cédric)
- Update the subject to indicate what is done in the patch
---
 target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 92ecb7254b..5c9fcd7dc2 100644
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
+     * Check if the user requested VFIO device assignment. We don't have
+     * to limit phys_bits if there are no valid assigned devices.
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


