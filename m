Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BAABD8F2
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 15:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMbr-0003Ny-Mv; Tue, 20 May 2025 09:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uHMbg-00030N-Gu
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uHMbd-0002Np-5n
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:08 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx22pKfSxoaW7zAA--.31055S3;
 Tue, 20 May 2025 21:02:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx_cZGfSxoW1bjAA--.62430S7;
 Tue, 20 May 2025 21:02:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] tests/qtest/bios-tables-test: Add basic testing for
 LoongArch
Date: Tue, 20 May 2025 21:01:55 +0800
Message-Id: <20250520130158.767083-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250520130158.767083-1-maobibo@loongson.cn>
References: <20250520130158.767083-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZGfSxoW1bjAA--.62430S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Add basic ACPI table test case for LoongArch, including cpu topology,
numa memory, memory hotplug and oem-id test cases.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/qtest/bios-tables-test.c | 79 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 2 files changed, 80 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d..d057cd90db 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2420,6 +2420,74 @@ static void test_acpi_aarch64_virt_oem_fields(void)
     g_free(args);
 }
 
+#define LOONGARCH64_INIT_TEST_DATA(data)                          \
+    test_data data = {                                            \
+        .machine = "virt",                                        \
+        .arch    = "loongarch64",                                 \
+        .tcg_only = true,                                         \
+        .uefi_fl1 = "pc-bios/edk2-loongarch64-code.fd",           \
+        .uefi_fl2 = "pc-bios/edk2-loongarch64-vars.fd",           \
+        .cd = "tests/data/uefi-boot-images/"                      \
+              "bios-tables-test.loongarch64.iso.qcow2",           \
+        .ram_start = 0,                                           \
+        .scan_len = 128ULL * MiB,                                 \
+    }
+
+static void test_acpi_loongarch64_virt(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    test_acpi_one("-cpu la464 ", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_topology(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".topology";
+    test_acpi_one("-cpu la464 -smp sockets=1,cores=4,threads=2", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_numamem(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".numamem";
+    test_acpi_one(" -cpu la464 -m 128"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_memhp(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".memhp";
+    test_acpi_one(" -cpu la464 -m 128,slots=2,maxmem=256M"
+                  " -object memory-backend-ram,id=ram0,size=128M",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_oem_fields(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+    char *args;
+
+    args = test_acpi_create_args(&data, "-cpu la464 "OEM_TEST_ARGS);
+    data.qts = qtest_init(args);
+    test_acpi_load_tables(&data);
+    test_oem_fields(&data);
+    qtest_quit(data.qts);
+    free_test_data(&data);
+    g_free(args);
+}
 
 int main(int argc, char *argv[])
 {
@@ -2593,6 +2661,17 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_riscv64_virt_tcg_numamem);
         }
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        if (has_tcg) {
+            qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
+            qtest_add_func("acpi/virt/topology",
+                           test_acpi_loongarch64_virt_topology);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_loongarch64_virt_numamem);
+            qtest_add_func("acpi/virt/memhp", test_acpi_loongarch64_virt_memhp);
+            qtest_add_func("acpi/virt/oem-fields",
+                           test_acpi_loongarch64_virt_oem_fields);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 7daf619845..481b0ab2ed 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -148,6 +148,7 @@ qtests_hppa = \
 
 qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
+  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   ['boot-serial-test',
    'cpu-plug-test']
 
-- 
2.41.0


