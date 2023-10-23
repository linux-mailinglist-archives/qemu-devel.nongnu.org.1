Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B81717D2E91
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurLI-0005ts-S7; Mon, 23 Oct 2023 05:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLG-0005tU-M4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:22 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLE-0005D1-Ug
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053721; x=1729589721;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DMrGDHV8au5Ua0y3CZ6ipFw2AiHlhTyp79T9DSb+Jhw=;
 b=jYzV+1v2/Rskmx+Y/zkh+5TGBb1vcMUFKFfRC1j+I9ocTpgCVxn64QJ0
 k6dZjOEOMIdapm0153r64zXKdQcmP8a6xX7eBBrwmCohAQDTymUqiwrqj
 FHIgU7mU2UIGYoZk3VHKjveyIU1xz4/0rrZwj+hI1MsiK11yXG4Q3eZWz
 rhiXWzUKZNuwXpfSpXXK5nB8VCzV/UJnLxJ/yL6cwus03cUQNOFa9H146
 /HxfSK98M63vr6Z+G8rB00gobcesrjZKZuxfzvEUdstsplMZaYkGN4m9Q
 GSFNZ5TsY0968ZrXunU6RV1JoAnBkCcr3SDEa4H271CPXevxV21v28dWC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359623"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707883179"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707883179"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:17 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 06/16] tests: bios-tables-test: Add test for smbios type4
 core count
Date: Mon, 23 Oct 2023 17:46:25 +0800
Message-Id: <20231023094635.1588282-7-zhao1.liu@linux.intel.com>
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

This tests the commit 196ea60a734c3 ("hw/smbios: Fix core count in
type4").

In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
cores in the socket is not more than 255, then smbios type4 table
encodes cores per socket into the core count field.

So for the topology in this case, there're the following considerations:
1. cores per socket should be not more than 255 to ensure we could cover
   the core count field.
2. The original bug was that cores per socket was miscalculated, so now
   we should include as many topology levels as possible (mutiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the cores per socket
   encoded in the core count field is correct.

Based on these considerations, select the topology with multiple sockets
and dies:

-smp 54,sockets=2,dies=3,cores=3,threads=3

The expected core count = cores per socket = cores (3) * dies (3) = 9.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index cdbfb5155967..c20f6f73d09e 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -999,6 +999,23 @@ static void test_acpi_q35_tcg_type4_count(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_core_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".core-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_core_count = 9,
+        .smbios_core_count2 = 9,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp 54,sockets=2,dies=3,cores=3,threads=3",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_core_count2(void)
 {
     test_data data = {
@@ -2178,6 +2195,8 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
                 qtest_add_func("acpi/q35/type4-count",
                                test_acpi_q35_tcg_type4_count);
+                qtest_add_func("acpi/q35/core-count",
+                               test_acpi_q35_tcg_core_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
             }
-- 
2.34.1


