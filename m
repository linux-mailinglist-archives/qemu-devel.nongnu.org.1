Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9D7D2E93
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurL4-0005kc-8N; Mon, 23 Oct 2023 05:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurL1-0005kT-8N
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:07 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurKy-00050v-EE
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053705; x=1729589705;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PxZ9aMEXwLxObgR4+dNITZ7cKCMTxJ8aQZEOvUAT0xY=;
 b=dTWkZ136YySg5h5GAO9igXxzj4rID9F0A8z7ZLS6qICIA31tzeKlV6CV
 ChORojVetmDTGOVhhpYG9tsolVLXpzgnXpi7qQzXhE7G+MAqJ2KIU54IX
 QY0ZGYukxZ/eH8bh/ML+IV2Tv4NIqgDpMhWajRTrv1AR6N8KCn5Zm9TMk
 e2OaGn8ChEivcpA0Bk3Gy/VYsnPUVLGwPsGcTDmHIQlLdkHufBdD6+Gkd
 RHt9a6LVZHqOf9XlOwo2KEvUxm+NxnITWmQ3cEy2BeI1P6Xq+ec2Hf7fG
 rdsg9VCxvcJH9yD3JIg80SWWRLqrgorBfAa+zclu8ufN9OwZ+xNo+p0YI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359464"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707882839"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707882839"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:34:57 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 00/16] tests: Add CPU topology related smbios test cases
Date: Mon, 23 Oct 2023 17:46:19 +0800
Message-Id: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset is the v3 which fixes the CI failure [1] reported in v2:

Number of hotpluggable cpus requested (520) exceeds the maximum cpus
supported by KVM (288)
socket_accept failed: Resource temporarily unavailable


Changes in v3
=============

v3 reduces the vCPU number from 520 to 260 to meet the CI host's
limitation (up to 288 vCPUs).

Since the binary file is pre-built, the vCPU number must be hardcoded in
the test case, and it is not possible to dynamically decide the number
of vCPUs to boot on the different Host.

Therefore, cutting the vCPU number to 260 is sufficient for CI. (Note,
the original core count2 test case picks 275 vCPUs, so 260 vCPUs could
be safe to pass the CI...)

Since v2, v3 just changes these 2 patches to fix that failure:
 * [PATCH v3 15/16] tests: bios-tables-test: Add test for smbios type4
   thread count2
 * [PATCH v3 16/16] tests: bios-tables-test: Add ACPI table binaries for
   smbios type4 thread count2 test


Introduction
============

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

With the above new cases, cover all commits of [2] in test.

[1]: https://lore.kernel.org/qemu-devel/20231022051520-mutt-send-email-mst@kernel.org/
[2]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html

Regards,
Zhao
---
Zhao Liu (16):
  tests: test-smp-parse: Add the test for cores/threads per socket
    helpers
  tests: bios-tables-test: Prepare the ACPI table change for smbios
    type4 count test
  tests: bios-tables-test: Add test for smbios type4 count
  tests: bios-tables-test: Add ACPI table binaries for smbios type4
    count test
  tests: bios-tables-test: Prepare the ACPI table change for smbios
    type4 core count test
  tests: bios-tables-test: Add test for smbios type4 core count
  tests: bios-tables-test: Add ACPI table binaries for smbios type4 core
    count test
  tests: bios-tables-test: Prepare the ACPI table change for smbios
    type4 core count2 test
  tests: bios-tables-test: Extend smbios core count2 test to cover
    general topology
  tests: bios-tables-test: Update ACPI table binaries for smbios core
    count2 test
  tests: bios-tables-test: Prepare the ACPI table change for smbios
    type4 thread count test
  tests: bios-tables-test: Add test for smbios type4 thread count
  tests: bios-tables-test: Add ACPI table binaries for smbios type4
    thread count test
  tests: bios-tables-test: Prepare the ACPI table change for smbios
    type4 thread count2 test
  tests: bios-tables-test: Add test for smbios type4 thread count2
  tests: bios-tables-test: Add ACPI table binaries for smbios type4
    thread count2 test

 tests/data/acpi/q35/APIC.core-count    | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.core-count2   | Bin 2478 -> 3238 bytes
 tests/data/acpi/q35/APIC.thread-count  | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.thread-count2 | Bin 0 -> 3238 bytes
 tests/data/acpi/q35/APIC.type4-count   | Bin 0 -> 1072 bytes
 tests/data/acpi/q35/DSDT.core-count    | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.core-count2   | Bin 32495 -> 33770 bytes
 tests/data/acpi/q35/DSDT.thread-count  | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.thread-count2 | Bin 0 -> 33770 bytes
 tests/data/acpi/q35/DSDT.type4-count   | Bin 0 -> 18589 bytes
 tests/data/acpi/q35/FACP.core-count    | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count  | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count2 | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.type4-count   | Bin 0 -> 244 bytes
 tests/qtest/bios-tables-test.c         | 116 ++++++++++++++++++++++++-
 tests/unit/test-smp-parse.c            |  67 +++++++++++---
 16 files changed, 167 insertions(+), 16 deletions(-)
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


