Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B137B1CF3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqTe-0006dR-U3; Thu, 28 Sep 2023 08:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqTE-0005tR-8p
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:50:24 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qlqTC-00071O-20
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695905418; x=1727441418;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YHkXoNLStaIDC39a3B+yESsSwWh4m9Lk+kw1218Kgxk=;
 b=Pvx7Fh2y7IWR8OlHal5x6ksoz2lozoXHQCGSBNKCNWVJXpCI7hbKbyz3
 wJy96D8JtTItkLKcggjCfgX+D/zGMPzraJdxRHoBmCF3Hs3t1nZd/4U/E
 9SHofXcj14XxQyo+lWRMo1ir3zouaISgS4fexxxj+iGeQpBIrMRwUU57m
 3VJoP+N48VP4v8si6Or2WFI7lm5sF+Y2unLNxZJkitEuzur9mSaf4Gxpa
 kkTFXpatjZit8i7HMunEdPkVlp+orI3bZuCEr22aDFTUB7Q+kKW687kQf
 5Re81XZIVtlU9SlOAHfqq6FxNhbi1lc1tFKMyJsab+lWMHV4UTMISe/c3 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361420412"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="361420412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2023 05:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="893002046"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; d="scan'208";a="893002046"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 05:48:28 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 14/16] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 thread count2 test
Date: Thu, 28 Sep 2023 20:59:41 +0800
Message-Id: <20230928125943.1816922-15-zhao1.liu@linux.intel.com>
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


