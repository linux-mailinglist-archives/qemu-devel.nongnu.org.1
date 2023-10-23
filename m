Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E17D2E84
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurL9-0005m6-VY; Mon, 23 Oct 2023 05:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurL8-0005ly-Mj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurL6-0005D1-UA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053713; x=1729589713;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=duigBkwGN2u0TvuyTSbhMPw1jX5ZSRoTbJw4Cz9rBMo=;
 b=YSdqXRXH6pvaItq7c0sAP1gEVzyfJwFCLIGOAq2bDWvC33FALkoDnbqC
 qlyIA19LqOAPMVcQpgYRFCPy2RGQ4rFbW6plqhkV6XeGQ9Eohe5x3CAsJ
 UDHbt223FxBaSd8JVexuyl1yXLdqDAB6wGt2Dt9z+7EXZ0nYvAIYUWyC7
 pKKx+q3V2ONt7W4J+4rKonZ24q4hrbbyFbXadtmYSQSSXlMNW2ZqW/Htu
 WiDe2GEoRaBliWcc+TzpBcaDL8/QInvizGMTQ7Z+GhkICBnMIeNORuaaR
 /+GhJE1K9lRpvPygK3uZqXnDKMcYicAi0HxBNUWVg0DKOHvGZZaAQzX/R A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359543"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707883064"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707883064"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:07 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 03/16] tests: bios-tables-test: Add test for smbios type4
 count
Date: Mon, 23 Oct 2023 17:46:22 +0800
Message-Id: <20231023094635.1588282-4-zhao1.liu@linux.intel.com>
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

This tests the commit d79a284a44bb7 ("hw/smbios: Fix smbios_smp_sockets
calculation").

In smbios_get_tables() (hw/smbios/smbios.c), smbios type4 table is built
for each socket, so the count of type4 tables should be equal to the
number of sockets.

Thus for the topology in this case, there're the following considerations:
1. The topology should include multiple sockets to ensure smbios could
   create type4 tables for each socket.
2. In addition to sockets, for the more general topology, we should also
   configure as many topology levels as possible (multiple dies, no
   module since x86 hasn't supported it), to ensure that smbios is able
   to exclude the effect of other topology levels to create the type4
   tables only for sockets.
3. The original miscalculation bug also misused "smp.cpus", so it's
   necessary to configure "cpus" (presented threads for machine) and
   "maxcpus" (total threads for machine) as well to make sure that
   configuring unpluged CPUs in smp (cpus < maxcpus) does not affect
   the correctness of the count of type4 tables.

Based on these considerations, select the topology as the follow:

-smp cpus=100,maxcpus=120,sockets=5,dies=2,cores=4,threads=3

The expected count of type4 tables = sockets (5).

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 9f4bc15aaba9..cdbfb5155967 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -97,6 +97,7 @@ typedef struct {
     uint16_t smbios_core_count2;
     uint8_t *required_struct_types;
     int required_struct_types_len;
+    int type4_count;
     QTestState *qts;
 } test_data;
 
@@ -673,12 +674,21 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
     }
 }
 
+static void smbios_type4_count_test(test_data *data, int type4_count)
+{
+    int expected_type4_count = data->type4_count;
+
+    if (expected_type4_count) {
+        g_assert_cmpuint(type4_count, ==, expected_type4_count);
+    }
+}
+
 static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
 {
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
 
     SmbiosEntryPoint *ep_table = &data->smbios_ep_table;
-    int i = 0, len, max_len = 0;
+    int i = 0, len, max_len = 0, type4_count = 0;
     uint8_t type, prv, crt;
     uint64_t addr;
 
@@ -704,6 +714,7 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
 
         if (type == 4) {
             smbios_cpu_test(data, addr, ep_type);
+            type4_count++;
         }
 
         /* seek to end of unformatted string area of this struct ("\0\0") */
@@ -747,6 +758,8 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
     for (i = 0; i < data->required_struct_types_len; i++) {
         g_assert(test_bit(data->required_struct_types[i], struct_bitmap));
     }
+
+    smbios_type4_count_test(data, type4_count);
 }
 
 static void test_acpi_load_tables(test_data *data)
@@ -970,6 +983,22 @@ static void test_acpi_q35_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_type4_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".type4-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .type4_count = 5,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=100,maxcpus=120,sockets=5,"
+                  "dies=2,cores=4,threads=3", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_core_count2(void)
 {
     test_data data = {
@@ -2147,6 +2176,8 @@ int main(int argc, char *argv[])
             if (has_kvm) {
                 qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
+                qtest_add_func("acpi/q35/type4-count",
+                               test_acpi_q35_tcg_type4_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
             }
-- 
2.34.1


