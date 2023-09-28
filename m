Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFF7B1CFC
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqS7-0005Gv-Jq; Thu, 28 Sep 2023 08:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqS4-0005GY-Tt
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:08 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqS3-0006dr-24
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695905347; x=1727441347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+CQdA1RBYrxFcOS9IjpUq3co2TUpIXnPAkbWhEt+8kI=;
 b=WU9U3kO3MqxoXtT1eO+26lLmWbEBkzX1Iug8bYBl+qMG2225ShYyWP9R
 gX/cBWakdwy/+sdGyMp4c9WoZmsk0WViLWramS2ojwYfl9RtrPAuiKa25
 UAr+nyRnTmtNZEbwt9Cdp0dtjAESJU8TctQBPcyiwZqggrK1pJWRmlcXL
 ngsBRx7EJW9MBmLYC7nzcLP0aZGWKebgSevYRhjm40VaEVTEJ783bQV02
 o+n+Gk0MbA8Noh2AWe0jjC6PgRdd46Bp8GtVU5dJL0zQARRq7g7bycOp5
 0mhIg59dKjKurwdodD78BN6t5pj6ihtD1k9cZUb/tonq3DpZdnGXzD+RL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361420049"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="361420049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2023 05:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="893001555"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="893001555"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 05:47:49 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/16] tests: bios-tables-test: Add test for smbios type4
 count
Date: Thu, 28 Sep 2023 20:59:30 +0800
Message-Id: <20230928125943.1816922-4-zhao1.liu@linux.intel.com>
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
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d1b80149f294..e14ca136e8ed 100644
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
@@ -2135,6 +2164,8 @@ int main(int argc, char *argv[])
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


