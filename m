Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA3787E87
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNSm-0000J9-Dz; Thu, 24 Aug 2023 23:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSi-0000Is-Vz
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:17 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qZNSf-0003uw-4a
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 23:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692933973; x=1724469973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pcEK4/lRvgEF9oRdjOo71Zd1MjWpCVA+CKDaEAC+NIE=;
 b=LmLxEV1wewucQUqWMCGAwQv+oSnHLdacqhVUT0YZoKD81M6gQMY4GX2I
 4KzY997bjoKvqX/Zy7o1FL0drY0idnLh56ZaP5R/Dt7gvFtNhOGA1Kaiz
 EiPzRJcXevcqT0u1EaNUUgVjSz18VMVTYnwd7IDz55dI++KH4w3IXNTvz
 WRHiaZqTDLQUasIsn7rSGtCICybO7Lbnw1STpCd1BgUuXby5cEUxoe/m/
 0if6fvJbnmtHyJdLaCk3TrMTG1dGNpLDpld6KHYjWuZCt5XtNjwUUvrlB
 vOPgv/LKM1YrnNflmVYKq1k6ThBYOeTozW7x/DgwxjHgsZQ5avko6M4To A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374595573"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="374595573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714201453"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="714201453"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 20:26:03 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Date: Fri, 25 Aug 2023 11:36:03 +0800
Message-Id: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset is the follow up tests of previous topology fixes in
smbios [1].

In this patchset, add these test cases:

1. Add the case to test 2 newly added topology helpers (patch 1):
   * machine_topo_get_cores_per_socket()
   * machine_topo_get_threads_per_socket()

2. Add the cases in bios-tables-test.c to:
   * test smbios type4 table count (patch 2-4).
   * test smbios type4 core count field (patch 5-7).
   * update the test of smbios type4 core count2 field (patch 8-10).
   * test smbios type4 thread count (patch 11-13).
   * test smbios type4 thread count2 (patch 14-16).

With the above new cases, cover all commits of [1] in test.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html

Regards,
Zhao
---
Zhao Liu (16):
  tests: test-smp-parse: Add the test for cores/threads per socket
    helpers
  tests: bios-tables-test: Prepare the ACPI table change for type4 count
    test
  tests: bios-tables-test: Add test for smbios type4 count
  tests: bios-tables-test: Add ACPI table binaries for type4 count test
  tests: bios-tables-test: Prepare the ACPI table change for type4 core
    count test
  tests: bios-tables-test: Add test for smbios type4 core count
  tests: bios-tables-test: Add ACPI table binaries for type4 core count
    test
  tests: bios-tables-test: Prepare the ACPI table change for type4 core
    count2 test
  tests: bios-tables-test: Extend core count2 test to cover general
    topology
  tests: bios-tables-test: Update ACPI table binaries for core count2
    test
  tests: bios-tables-test: Prepare the ACPI table change for type4
    thread count test
  tests: bios-tables-test: Add test for smbios type4 thread count
  tests: bios-tables-test: Add ACPI table binaries for type4 thread
    count test
  tests: bios-tables-test: Prepare the ACPI table change for type4
    thread count2 test
  tests: bios-tables-test: Add test for smbios type4 thread count2
  tests: bios-tables-test: Add ACPI table binaries for type4 thread
    count2 test

 tests/data/acpi/q35/APIC.core-count    | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.core-count2   | Bin 2478 -> 3238 bytes
 tests/data/acpi/q35/APIC.thread-count  | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.thread-count2 | Bin 0 -> 7398 bytes
 tests/data/acpi/q35/APIC.type4-count   | Bin 0 -> 1072 bytes
 tests/data/acpi/q35/DSDT.core-count    | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.core-count2   | Bin 32495 -> 33770 bytes
 tests/data/acpi/q35/DSDT.thread-count  | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.thread-count2 | Bin 0 -> 63671 bytes
 tests/data/acpi/q35/DSDT.type4-count   | Bin 0 -> 18589 bytes
 tests/data/acpi/q35/FACP.core-count    | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count  | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count2 | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.type4-count   | Bin 0 -> 244 bytes
 tests/qtest/bios-tables-test.c         | 118 ++++++++++++++++++++++++-
 tests/unit/test-smp-parse.c            |  67 +++++++++++---
 16 files changed, 169 insertions(+), 16 deletions(-)
 create mode 100644 tests/data/acpi/q35/APIC.core-count
 create mode 100644 tests/data/acpi/q35/APIC.thread-count
 create mode 100644 tests/data/acpi/q35/APIC.thread-count2
 create mode 100644 tests/data/acpi/q35/APIC.type4-count
 create mode 100644 tests/data/acpi/q35/DSDT.core-count
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
 create mode 100644 tests/data/acpi/q35/DSDT.type4-count
 create mode 100644 tests/data/acpi/q35/FACP.core-count
 create mode 100644 tests/data/acpi/q35/FACP.thread-count
 create mode 100644 tests/data/acpi/q35/FACP.thread-count2
 create mode 100644 tests/data/acpi/q35/FACP.type4-count

-- 
2.34.1


