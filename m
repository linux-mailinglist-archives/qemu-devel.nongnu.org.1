Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88E7B1CFE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqTa-0006Mw-KZ; Thu, 28 Sep 2023 08:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqTJ-0005vN-Cc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:50:25 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqTC-00070i-22
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695905418; x=1727441418;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tc9wINH2FCBsTJ+y+LugkZw1d7SW4yI0Gn2fxU1Zhn4=;
 b=GguvOwD6AAx3fNkUDsbSV81cRJYCyjBhGAlRwsDbXeRALKLs/mj9cOh0
 XHdvQtE3oxuzsUI+NSqqsArVH2QYRh2ODNPLqPbastCzKICkKGoV+moDt
 Hv1sSSvudN4xSE+opaQAOY+GjOkQqMP8+ZPjGtmg92kdYR6z7lRQsy0FP
 s7Ja2gBZ7pD/SLVhd1iFt/0wNIPm0J60LlQ+d2jzpuB+q1VKdrt2Y0gUt
 bLy/6dTFljN4VXOHJE9THLTFk8iCqvmqHjP9tIBC6jgWBTvE1cVqPI4hH
 gu+MmZWxpfGEdxnHF0iI5cXLpJIBJ21EjpjAYwAhGm14McHmdtpmWp75v A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361420430"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="361420430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2023 05:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="893002123"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="893002123"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 05:48:32 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 15/16] tests: bios-tables-test: Add test for smbios type4
 thread count2
Date: Thu, 28 Sep 2023 20:59:42 +0800
Message-Id: <20230928125943.1816922-16-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
References: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
type4").

In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
threads in the socket is more than 255, then smbios type4 table encodes
threads per socket into the thread count2 field.

So for the topology in this case, there're the following considerations:
1. threads per socket should be more than 255 to ensure we could cover
   the thread count2 field.
2. The original bug was that threads per socket was miscalculated, so
   now we should configure as many topology levels as possible (mutiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the threads per
   socket encoded in the thread count2 field is correct.
3. For the more general topology, we should also add "cpus" (presented
   threads for machine) and "maxcpus" (total threads for machine) to
   make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
   does not affect the correctness of threads per socket for thread
   count2 field.

Based on these considerations, select the topology as the follow:

-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2

The expected thread count2 = threads per socket = threads (2)
* cores (65) * dies (2) = 260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Dropped the extra variable: uint64_t thread_count2_addr. (Igor)
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f8e3e349e09f..58119d8979c6 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -96,6 +96,7 @@ typedef struct {
     uint8_t smbios_core_count;
     uint16_t smbios_core_count2;
     uint8_t smbios_thread_count;
+    uint16_t smbios_thread_count2;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     int type4_count;
@@ -644,6 +645,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
     uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
     uint16_t speed, expected_speed[2];
     uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
+    uint16_t thread_count2, expected_thread_count2 = data->smbios_thread_count2;
     int offset[2];
     int i;
 
@@ -680,6 +682,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
         if (expected_core_count == 0xFF && expected_core_count2) {
             g_assert_cmpuint(core_count2, ==, expected_core_count2);
         }
+
+        thread_count2 = qtest_readw(data->qts,
+                            addr + offsetof(struct smbios_type_4,
+                            thread_count2));
+
+        /* Thread Count has reached its limit, checking Thread Count 2 */
+        if (expected_thread_count == 0xFF && expected_thread_count2) {
+            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
+        }
     }
 }
 
@@ -1050,6 +1061,7 @@ static void test_acpi_q35_tcg_thread_count(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_thread_count = 27,
+        .smbios_thread_count2 = 27,
     };
 
     test_acpi_one("-machine smbios-entry-point-type=64 "
@@ -1058,6 +1070,23 @@ static void test_acpi_q35_tcg_thread_count(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_thread_count2(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".thread-count2",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_thread_count = 0xFF,
+        .smbios_thread_count2 = 260,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_bridge(void)
 {
     test_data data = {};
@@ -2216,6 +2245,8 @@ int main(int argc, char *argv[])
                                test_acpi_q35_tcg_core_count2);
                 qtest_add_func("acpi/q35/thread-count",
                                test_acpi_q35_tcg_thread_count);
+                qtest_add_func("acpi/q35/thread-count2",
+                               test_acpi_q35_tcg_thread_count2);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
2.34.1


