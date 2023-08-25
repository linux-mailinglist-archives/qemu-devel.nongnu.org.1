Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E7787E98
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNTn-0000lE-DE; Thu, 24 Aug 2023 23:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTl-0000kj-F2
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:21 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNTj-00044s-67
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692934039; x=1724470039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YHkXoNLStaIDC39a3B+yESsSwWh4m9Lk+kw1218Kgxk=;
 b=aP6dDHdhfD02O1Fmahe694RmJlqWhc6V0noq4skTB9C3HMXe1lh4slmg
 eAwUMtq9s/U1ZDIMiP+N7OKL5Jdgs/kxkFDsuMMsZXesBXx+9Uf9V0nTQ
 WcW/RKkFIbIDLn1z8INAPP8Nmj+xpM30+8VcIx/QuHG0m+GtVBodVoM2+
 SlgjnTxQlcj3dyipeh4TvE0dcGj/43wzWtl3DE7CmWqTQbS0O6XyRjv2I
 Jq2e3h9yJXN2lZ30ibGGsmi1wizVHhei5s2aPW/I6MWeVLeY9obVt8Tfg
 elF4TTII6YLM7h4Mt9jQO9ibo5TdCt7pA6dU0ljN1KM02AxjrVRoZg9WU A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595795"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201690"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201690"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:27:08 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 14/16] tests: bios-tables-test: Prepare the ACPI table change
 for type4 thread count2 test
Date: Fri, 25 Aug 2023 11:36:17 +0800
Message-Id: <20230825033619.2075837-15-zhao1.liu@linux.intel.com>
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

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be added to test the thread count2 field
of smbios type4 table.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/data/acpi/q35/APIC.thread-count2      | 0
 tests/data/acpi/q35/DSDT.thread-count2      | 0
 tests/data/acpi/q35/FACP.thread-count2      | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.thread-count2
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
 create mode 100644 tests/data/acpi/q35/FACP.thread-count2

diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/q35/APIC.thread-count2
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/q35/DSDT.thread-count2
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/q35/FACP.thread-count2 b/tests/data/acpi/q35/FACP.thread-count2
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..d17d80e21ab9 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.thread-count2",
+"tests/data/acpi/q35/DSDT.thread-count2",
+"tests/data/acpi/q35/FACP.thread-count2",
-- 
2.34.1


