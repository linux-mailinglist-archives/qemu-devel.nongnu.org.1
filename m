Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A37D2EA1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurLa-0006MR-Of; Mon, 23 Oct 2023 05:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLZ-0006JO-0Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:41 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLW-0005P6-LK
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053739; x=1729589739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4BGoKnd1jrMIKcwElK4O/5OBKEiHI0ReCU0Rx3sh55Y=;
 b=S09GylOgNrYUMagUgh0gxko1WT3yVovPcxV0ci4t08pCSQHC19XXuNvr
 ZcGOd8N4Hg5RwKgQs5GxGRI3+atETxxAEISwR8ihP9EGGk9TbCQuzqs3s
 pVHoxa72hlXI47o9elansdo8gnaCXZgrxEBKLtolX7D5/rPawm+syGlaq
 sHUGZnFpCYWfiiuzlsrUTB02TV/adioF9R7SfGDl7GMha3MfKgE+zLb6Z
 WCajmYO9DUUIdqFcDGSeqNNCmmsdyMB+Ni8ZwbQFRbKkU0gdoqB0EK0hF
 x+rsm6+0IykOMhajVvKPpsN8jR2aL+Gsx7tmAZ+V0uL/ON4TaXG1XHduH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359676"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359676"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707883336"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707883336"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:34 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 12/16] tests: bios-tables-test: Add test for smbios type4
 thread count
Date: Mon, 23 Oct 2023 17:46:31 +0800
Message-Id: <20231023094635.1588282-13-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
References: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
threads in the socket is not more than 255, then smbios type4 table
encodes threads per socket into the thread count field.

So for the topology in this case, there're the following considerations:
1. threads per socket should be not more than 255 to ensure we could
   cover the thread count field.
2. The original bug was that threads per socket was miscalculated, so
   now we should configure as many topology levels as possible (multiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the threads per
   socket encoded in the thread count field is correct.
3. For the more general topology, we should also add "cpus" (presented
   threads for machine) and "maxcpus" (total threads for machine) to
   make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
   does not affect the correctness of threads per socket for thread
   count field.

Based on these considerations, select the topology as the follow:

-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3

The expected thread count = threads per socket = threads (3) * cores (3)
* dies (3) = 27.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f3af20cf2c7f..395ed7f9ff73 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -95,6 +95,7 @@ typedef struct {
     uint16_t smbios_cpu_curr_speed;
     uint8_t smbios_core_count;
     uint16_t smbios_core_count2;
+    uint8_t smbios_thread_count;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     int type4_count;
@@ -640,6 +641,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
                             SmbiosEntryPointType ep_type)
 {
     uint8_t core_count, expected_core_count = data->smbios_core_count;
+    uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
     uint16_t speed, expected_speed[2];
     uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
     int offset[2];
@@ -663,6 +665,13 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
         g_assert_cmpuint(core_count, ==, expected_core_count);
     }
 
+    thread_count = qtest_readb(data->qts,
+                       addr + offsetof(struct smbios_type_4, thread_count));
+
+    if (expected_thread_count) {
+        g_assert_cmpuint(thread_count, ==, expected_thread_count);
+    }
+
     if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         core_count2 = qtest_readw(data->qts,
                           addr + offsetof(struct smbios_type_4, core_count2));
@@ -1033,6 +1042,22 @@ static void test_acpi_q35_tcg_core_count2(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_thread_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".thread-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_thread_count = 27,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_bridge(void)
 {
     test_data data = {};
@@ -2201,6 +2226,8 @@ int main(int argc, char *argv[])
                                test_acpi_q35_tcg_core_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
+                qtest_add_func("acpi/q35/thread-count",
+                               test_acpi_q35_tcg_thread_count);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
2.34.1


