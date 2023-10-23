Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A892B7D2E9F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurLQ-0005xg-NZ; Mon, 23 Oct 2023 05:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLP-0005xH-9r
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:31 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLN-0005Hg-FP
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053730; x=1729589730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Dfu9ZqoPZTAoGtRyaqA9NaQufTr4E1/ifxw51jjGuI=;
 b=dDPrLY6Mpm1ttS1G6Xu8xxDM4E1pKzAh+j1d9Hwt29I2jZ1ydmi4DPLR
 viaGxTAZITei3DtEkb3W0KC5IHI2nqndhUkRg3uIwgMVJcW0NcwLL+Fis
 OtYhfNWmVrPsCXzcboK6yzeVLxWixVpTStj1VGpI5DSjKO1Rp0BPB3NWw
 WYa6EFTBVomlmxQv4bToNt4JCtk2bslPkdbUZguU2fefKR5NpbMnU4Xk3
 veVYkXIZKrFEqI0oLQkhRJhmnW932ooWyV9Al6Kg3DSu3xy3UeD8DmqdN
 VkwRLl50PGCZz25bDsvzTSe53jYrAE6a6OdVZc51zO49sMmXCAdGHZjnu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359648"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707883275"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707883275"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:25 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 09/16] tests: bios-tables-test: Extend smbios core count2
 test to cover general topology
Date: Mon, 23 Oct 2023 17:46:28 +0800
Message-Id: <20231023094635.1588282-10-zhao1.liu@linux.intel.com>
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

The commit 196ea60a734c3 ("hw/smbios: Fix core count in type4") fixed
the miscalculation of cores per socket.

The original core count2 test (with the topology configured by
"-smp 275") didn't recognize that topology-related but because it just
created a special topology with only one socket and one die by default,
ignoring the effect of more topology levels (between socket and core) on
the cores per socket calculation.

So for the topology in this case, there're the following considerations:
1. cores per socket should be more than 255 to ensure we could cover
   the core count2 field.
2. The original bug was that cores per socket was miscalculated, so now
   we should include as many topology levels as possible (multiple
   sockets or dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the cores per socket
   encoded in the core count2 field is correct.

Based on these considerations, select the topology with multiple dies:

-smp 260,dies=2,cores=130,threads=1

Note, here we doesn't configure multiple sockets to avoid the error
("kvm_init_vcpu: kvm_get_vcpu failed (*): Too many open files") if user
uses the default ulimit seeting on his machine.

And the cores per socket calculation for multiple sockets has already
been covered by the core count test case, so that only multiple dies
configuration is enough.

The expected core count2 = cores per socket = cores (130) * dies (2) =
260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c20f6f73d09e..f3af20cf2c7f 100644
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


