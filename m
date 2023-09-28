Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B028D7B1D00
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqST-0005Rm-P4; Thu, 28 Sep 2023 08:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqSR-0005PV-Ak
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:31 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqSP-0006kL-2U
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695905369; x=1727441369;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=29wG2dRePcizh0JTRMMABZTpCaaLGnEGJd8czSeiP/Y=;
 b=dzE8xDEzKzSQ1y+CAUtjaxHmgVGcw5rfzgtCjLWavHSlArjYUWwZX0US
 pQ7N5HWvC2xEAIxg+bdBfjJ3QdsK8LRRXd1VxXDDnV43YW0yJCop9D8R1
 k1r6c4bn4TVwFYoyw6j41980Heqo/XV7V11thnZf6UkO0mrCRFRIfADgD
 WA76tfgudGxxyR7xpFVndjnTpOha1J5ZxSzPW/FRnRYtV2nSGQFHKrkJt
 urlzRBqw+EYluKmhHjyDiqte6jK8G6fyJlFMYMj6E3X0Y1+mCVuPgqexz
 j3izAzc5YtOAB2n203dJLyrNu7htvK6if12qmEqifcwBKUAyta98b8hFt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361420256"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="361420256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2023 05:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="893001788"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="893001788"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 05:48:10 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/16] tests: bios-tables-test: Extend smbios core count2
 test to cover general topology
Date: Thu, 28 Sep 2023 20:59:36 +0800
Message-Id: <20230928125943.1816922-10-zhao1.liu@linux.intel.com>
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
   we should include as many topology levels as possible (mutiple
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
---
Changes since v1:
 * Added description of the consideration for topology selection of this
   case in commit message. (Igor)
---
 tests/qtest/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 57143ad875a2..d9ae716d918f 100644
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


