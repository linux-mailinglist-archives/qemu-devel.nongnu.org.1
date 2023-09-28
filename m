Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0C7B1CF2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:51:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqSB-0005J4-9z; Thu, 28 Sep 2023 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqS9-0005HY-1U
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:13 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqS6-0006dr-Pa
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695905350; x=1727441350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TF0KD5NFzgLoBgn5roQmqq1EmcaM1OBDB/pWEJP2Gc8=;
 b=g5iZaOV66xpT1p40sZkYzjSaqTstSXaOKrYCAJjj/eG5oda4tri69aG3
 itTvNHXcfGV4j91UGVr0nHRiNmROPUx/cOmx8hZNkl8TgsbqDMcHyxNKB
 QOWODMweSZxRUe+0DGRx28y3JSx6dWCbLLAeilVZywISa3NmaodDQfiHI
 l3ojU1vf/MtyBPZ10PB/I9BHpcRGdiK1M63eVkvHBNCW2FSZhrXx4hk2O
 UpLwllvdBf6YX29yZEbu3fuPQiSafK7ZUyS6CkZytQrASDAARTUKkz7oI
 57NHeF8daX65GP/2kFs7N8jU4VldtcZsA+4Phnqxqrg5w7CQFgHyYlVfJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361420102"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="361420102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2023 05:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="893001637"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="893001637"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 05:47:57 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/16] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 core count test
Date: Thu, 28 Sep 2023 20:59:32 +0800
Message-Id: <20230928125943.1816922-6-zhao1.liu@linux.intel.com>
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

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be added to test the type 4 core count
field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/data/acpi/q35/APIC.core-count         | 0
 tests/data/acpi/q35/DSDT.core-count         | 0
 tests/data/acpi/q35/FACP.core-count         | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.core-count
 create mode 100644 tests/data/acpi/q35/DSDT.core-count
 create mode 100644 tests/data/acpi/q35/FACP.core-count

diff --git a/tests/data/acpi/q35/APIC.core-count b/tests/data/acpi/q35/APIC.core-count
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/q35/DSDT.core-count b/tests/data/acpi/q35/DSDT.core-count
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/q35/FACP.core-count b/tests/data/acpi/q35/FACP.core-count
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..b9bc1961309a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.core-count",
+"tests/data/acpi/q35/DSDT.core-count",
+"tests/data/acpi/q35/FACP.core-count",
-- 
2.34.1


