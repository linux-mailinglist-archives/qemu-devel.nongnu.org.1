Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3D787E88
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNTb-0000Zl-OF; Thu, 24 Aug 2023 23:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTR-0000YX-IV
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:01 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTP-00042O-ER
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692934019; x=1724470019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gyRmDva2+YMakIHRrZ1nh0nHDhYXSzjXHjNEV/Z4Yd0=;
 b=cOQBOFN2BkKA9TiI1m/J6lHclHav7ViuxWFswFAc9LZoI8JKFSHX6YMc
 OMyg2GL8IXA6RkHI1buiyRVsH26fkEfKKAWyi4syGST2toXwf5/udMJKq
 PvPubLv0SlsCniB0+pj8uSHqLwQ90sWDvwSdBh1xUmhHPleDxbnnpGt7N
 DX1bYOTUr/zhqbxrwkoz6zyVhOLRKvMeB4ablmxoC/7LFLpVlGuDLbXKI
 epQ+YjHg5vTPGzrZRYPCsvkCZv1YrvUN8j2gcuAyLAJz66+mGBZHQHux9
 LY6fuo+xfZy3pbN+KnO4DFSihw791ZcIBitJ/wZfG55F0GuVLUnvev5rc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595727"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201601"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201601"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:26:48 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/16] tests: bios-tables-test: Extend core count2 test to
 cover general topology
Date: Fri, 25 Aug 2023 11:36:12 +0800
Message-Id: <20230825033619.2075837-10-zhao1.liu@linux.intel.com>
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

Currently, this case just covers the topology with only core and smt
levels, and doesn't consider more topology layers between socket and
core.

To cover the fixed case in the commit 196ea60a734c3 ("hw/smbios: Fix
core count in type4"), add the "die" level in "-smp" as the more
general topology case.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/qtest/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a35c753a3a00..8cba1d8126f2 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1024,10 +1024,12 @@ static void test_acpi_q35_tcg_core_count2(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_core_count = 0xFF,
-        .smbios_core_count2 = 275,
+        .smbios_core_count2 = 260,
     };
 
-    test_acpi_one("-machine smbios-entry-point-type=64 -smp 275", &data);
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp 260,dies=2,cores=130,threads=1",
+                  &data);
     free_test_data(&data);
 }
 
-- 
2.34.1


