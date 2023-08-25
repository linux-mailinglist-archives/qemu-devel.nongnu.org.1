Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645B787E97
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNTy-0001yK-Fc; Thu, 24 Aug 2023 23:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTw-0001mq-7h
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:32 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTt-000455-Ly
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692934049; x=1724470049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uk+p3c1Up4jjIhY/1b7D5U94PpjI0HlA17/JUot3uuE=;
 b=oF1Kg1iL/P6M6LhSQBDoNssnqKSFXBR+sJEytu0JfB/NBW3/yHQ7FxiD
 JvzMkCrcimzWqXIXL9Ur5wBBDRA6XKiOu6uiwNQAd07/ky7CCeSc+Gwj3
 MsAKpnPwO1mnobblk9CswSS4/5K6YVNy124vw/ITHua+MFdDUxPnPBLRP
 gHVUVnXsygg7I8FBRkFUD4VGv+lsV2a/zkpzTqayKekIqDo2R3bw8uW8f
 uvXqvKFjRSO6tYUjYTlwME8ax/GHercmnp6TY27OrL+DmdAcj/zHJfb5L
 tmiF4UmcXf0RWNBYbYtCLq6htzjDMNrMaa/sqLQHKpJMcWnpNKktLRRUO w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595804"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201699"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201699"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:27:12 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 15/16] tests: bios-tables-test: Add test for smbios type4
 thread count2
Date: Fri, 25 Aug 2023 11:36:18 +0800
Message-Id: <20230825033619.2075837-16-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
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

Add this test to cover 2 cases:
1. Test thread count2 field with multiple sockets and multiple dies to
   confirm this field could correctly calculate threads per sockets.

2. Confirm that field calculation could correctly recognize the
   difference between "-smp maxcpus" and "-smp cpus".

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/qtest/bios-tables-test.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 26474d376633..1b0c27e95d26 100644
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
 
@@ -673,6 +675,8 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
     }
 
     if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
+        uint64_t thread_count2_addr;
+
         core_count2 = qtest_readw(data->qts,
                           addr + offsetof(struct smbios_type_4, core_count2));
 
@@ -680,6 +684,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
         if (expected_core_count == 0xFF && expected_core_count2) {
             g_assert_cmpuint(core_count2, ==, expected_core_count2);
         }
+
+        thread_count2_addr = addr +
+                             offsetof(struct smbios_type_4, thread_count2);
+        thread_count2 = qtest_readw(data->qts, thread_count2_addr);
+
+        /* Thread Count has reached its limit, checking Thread Count 2 */
+        if (expected_thread_count == 0xFF && expected_thread_count2) {
+            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
+        }
     }
 }
 
@@ -1050,6 +1063,7 @@ static void test_acpi_q35_tcg_thread_count(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_thread_count = 27,
+        .smbios_thread_count2 = 27,
     };
 
     test_acpi_one("-machine smbios-entry-point-type=64 "
@@ -1058,6 +1072,23 @@ static void test_acpi_q35_tcg_thread_count(void)
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
@@ -2216,6 +2247,8 @@ int main(int argc, char *argv[])
                                test_acpi_q35_tcg_core_count2);
                 qtest_add_func("acpi/q35/thread-count",
                                test_acpi_q35_tcg_thread_count);
+                qtest_add_func("acpi/q35/thread-count2",
+                               test_acpi_q35_tcg_thread_count2);
             }
             qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
 #ifdef CONFIG_POSIX
-- 
2.34.1


