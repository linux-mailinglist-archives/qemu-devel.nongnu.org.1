Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7ECAE899F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Jun 2025 18:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUStJ-0001VX-UQ; Wed, 25 Jun 2025 12:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uUSt0-0001IN-B6; Wed, 25 Jun 2025 12:22:11 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uUSsv-0006Pd-VS; Wed, 25 Jun 2025 12:22:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS6Wd6t1Vz6M4ZQ;
 Thu, 26 Jun 2025 00:21:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D4A3A14044F;
 Thu, 26 Jun 2025 00:22:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Jun 2025 18:22:03 +0200
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
 <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH qemu v16 5/5] qtest/cxl: Add aarch64 virt test for CXL
Date: Wed, 25 Jun 2025 17:19:26 +0100
Message-ID: <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add a single complex case for aarch64 virt machine.
Given existing much more comprehensive tests for x86 cover the
common functionality, a single test should be enough to verify
that the aarch64 part continue to work.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v16: Update to bring improvements made to other tests (Peter Maydell).
     I'd failed to notice when rebasing this over time that the
     other tests had undergone various improvment and I should have
     updated this one as well.
---
 tests/qtest/cxl-test.c  | 58 ++++++++++++++++++++++++++++++++---------
 tests/qtest/meson.build |  1 +
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index a600331843..8fb7e58d4f 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -19,6 +19,12 @@
     "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
 
+#define QEMU_VIRT_2PXB_CMD \
+    "-machine virt,cxl=on -cpu max " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+
 #define QEMU_RP \
     "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
@@ -197,25 +203,51 @@ static void cxl_2pxb_4rp_4t3d(void)
     qtest_end();
     rmdir(tmpfs);
 }
+
+static void cxl_virt_2pxb_4rp_4t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+    rmdir(tmpfs);
+}
 #endif /* CONFIG_POSIX */
 
 int main(int argc, char **argv)
 {
-    g_test_init(&argc, &argv, NULL);
+    const char *arch = qtest_get_arch();
 
-    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
-    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
-    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
-    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
-    qtest_add_func("/pci/cxl/rp", cxl_root_port);
-    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+    g_test_init(&argc, &argv, NULL);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
+        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
+        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
+        qtest_add_func("/pci/cxl/rp", cxl_root_port);
+        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
 #ifdef CONFIG_POSIX
-    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
-    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
-    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
-    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
-    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
-    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
+        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
+        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
+        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
+        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
+        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
+        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
+                       cxl_2pxb_4rp_4t3d);
 #endif
+    } else if (strcmp(arch, "aarch64") == 0) {
+#ifdef CONFIG_POSIX
+        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
+                       cxl_virt_2pxb_4rp_4t3d);
+#endif
+    }
+
     return g_test_run();
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8ad849054f..42e927b32a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -261,6 +261,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.48.1


