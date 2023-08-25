Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CD787E96
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:28:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNSv-0000KR-JR; Thu, 24 Aug 2023 23:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSt-0000KG-OJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:27 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSr-0003xB-F7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692933985; x=1724469985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ObQGvIElalcU6D+A4r4VnixN9YLi5eYWKH2jkpoEjzE=;
 b=Nf+qf/KNtb5Z+9xVgO40rFDkWJ3LnW+OLBQABQ8eqNo2C+AykLlIGCVx
 MAMZaDVvBuJ1rehtq+xEz4DE/wTs7HtCgWWh0aodGihO8IbppLZUh9WIk
 7djE4U7Kb/g8fO1Pe3sKZVrMg1E1Zzc03za7+DNyoU2FXXtQazjyv73WY
 Nop9nOKZbJxa1mNscheSoqYuMh42bD+Xuzfbb5XmjhfuS48HFBFQYJh9c
 KMyyEHHFX3ja2h4oqzLVgjpTu11iyQFwoHA7DIdIYKw151gtiem4bWc9y
 et74OJ2yTZxktEkArQbMcDureywNnu05gYguu+UZK49Mi70Ofy37y71ii Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595629"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595629"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201495"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201495"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:26:21 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/16] tests: bios-tables-test: Add test for smbios type4 count
Date: Fri, 25 Aug 2023 11:36:06 +0800
Message-Id: <20230825033619.2075837-4-zhao1.liu@linux.intel.com>
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

This tests the commit d79a284a44bb7 ("hw/smbios: Fix smbios_smp_sockets
calculation").

Test the count of type4 tables for multiple sockets case.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/qtest/bios-tables-test.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 47ba20b9579b..8679255449cf 100644
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


