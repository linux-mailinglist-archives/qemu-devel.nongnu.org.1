Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3E7FA535
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:51:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ds0-00047x-OH; Mon, 27 Nov 2023 10:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7drw-00045i-BD
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:49:56 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7dru-0006s1-43
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701100194; x=1732636194;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tScOKRTWyNwoZDet8u6qjATSK7fwOtXymQ1UWotw77c=;
 b=QW/7fP3hL0H41xssaMNClqPAbFmMssrM2D9CA5uM7eB3hLxlJ4crQWDY
 REVquWizABqaYT5HPwy+s4N1LD59nkcq2Ztbew4N20H2RmXvFM+Ao7RxQ
 dbNwpebRCmFCaotiyGBgl0VOgv8NzsOG6iedCLjKIqpnpejJTExd8bCRG
 FSRW5kECfia4/vBCUsxEmUsshm8YzCRI86mDGSLgdRAbgZumc5trTmJPS
 BstPRBxViMEHaJloj+XYGMml796za3k8kZCcN/dL3HmhUcwdhTSRB3Xpx
 CwLkCLh7FrqAvJ3E0pDYGS09IXzRqulrc3ukS1hDq6azySTu9Qc//ucPM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="423874301"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="423874301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 07:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797272989"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="797272989"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga008.jf.intel.com with ESMTP; 27 Nov 2023 07:49:47 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] tests: bios-tables-test: Rename smbios type 4 related test
 functions
Date: Tue, 28 Nov 2023 00:02:02 +0800
Message-Id: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In fact, type4-count, core-count, core-count2, thread-count and
thread-count2 are tested with KVM not TCG.

Rename these test functions to reflect KVM base instead of TCG.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 71af5cf69fc5..9a7e459e8ffb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1003,7 +1003,7 @@ static void test_acpi_q35_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_type4_count(void)
+static void test_acpi_q35_kvm_type4_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1019,7 +1019,7 @@ static void test_acpi_q35_tcg_type4_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_core_count(void)
+static void test_acpi_q35_kvm_core_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1036,7 +1036,7 @@ static void test_acpi_q35_tcg_core_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_core_count2(void)
+static void test_acpi_q35_kvm_core_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1053,7 +1053,7 @@ static void test_acpi_q35_tcg_core_count2(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_thread_count(void)
+static void test_acpi_q35_kvm_thread_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1070,7 +1070,7 @@ static void test_acpi_q35_tcg_thread_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_thread_count2(void)
+static void test_acpi_q35_kvm_thread_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -2250,15 +2250,15 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
                 qtest_add_func("acpi/q35/type4-count",
-                               test_acpi_q35_tcg_type4_count);
+                               test_acpi_q35_kvm_type4_count);
                 qtest_add_func("acpi/q35/core-count",
-                               test_acpi_q35_tcg_core_count);
+                               test_acpi_q35_kvm_core_count);
                 qtest_add_func("acpi/q35/core-count2",
-                               test_acpi_q35_tcg_core_count2);
+                               test_acpi_q35_kvm_core_count2);
                 qtest_add_func("acpi/q35/thread-count",
-                               test_acpi_q35_tcg_thread_count);
+                               test_acpi_q35_kvm_thread_count);
                 qtest_add_func("acpi/q35/thread-count2",
-                               test_acpi_q35_tcg_thread_count2);
+                               test_acpi_q35_kvm_thread_count2);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
2.34.1


