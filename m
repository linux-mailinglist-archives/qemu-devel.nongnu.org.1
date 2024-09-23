Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463B97A683
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Sep 2024 19:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFFT-00039X-2z; Mon, 16 Sep 2024 13:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFFH-00038y-Tm
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:10:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFFF-0000mN-11
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:10:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6rsZ38F3z6K9F4;
 Tue, 17 Sep 2024 01:06:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CA71140CF4;
 Tue, 17 Sep 2024 01:10:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:10:19 +0200
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v6 00/15] acpi: NUMA nodes for CXL HB as GP + complex NUMA test
Date: Mon, 16 Sep 2024 18:10:05 +0100
Message-ID: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

v6 changes:
- 2 new patches (11 and 12) to improve things in existing code after
  Igor pointed them out in the new code.
- More detailed example provided for docs for control of Generic Ports.
  This has proved a difficult concept to convey.
  Note there is one question Igor raised for Markus:
  - Is exit(1) ok for failure paths rather than error_fatal.
    Markus has acked the patch (10) but maybe this part was not his
    focus.
- Rebased.  Table data regenerated as other series touched DSDT.

Title becoming a little misleading as now this does a bunch of other
stuff as precursors, but I've kept it to maintain association with v3 and
before. A more accurate series title is probably
acpi: Rework GI affinity structure generation, add GPs + complex NUMA test.

ACPI 6.5 introduced Generic Port Affinity Structures to close a system
description gap that was a problem for CXL memory systems.
It defines an new SRAT Affinity structure (and hence allows creation of an
ACPI Proximity Node which can only be defined via an SRAT structure)
for the boundary between a discoverable fabric and a non discoverable
system interconnects etc.

The HMAT data on latency and bandwidth is combined with discoverable
information from the CXL bus (link speeds, lane counts) and CXL devices
(switch port to port characteristics and USP to memory, via CDAT tables
read from the device).  QEMU has supported the rest of the elements
of this chain for a while but now the kernel has caught up and we need
the missing element of Generic Ports (this code has been used extensively
in testing and debugging that kernel support, some resulting fixes
currently under review).

Generic Port Affinity Structures are very similar to the recently
added Generic Initiator Affinity Structures (GI) so this series
factors out and reuses much of that infrastructure for reuse
There are subtle differences (beyond the obvious structure ID change).

- The ACPI spec example (and linux kernel support) has a Generic
  Port not as associated with the CXL root port, but rather with
  the CXL Host bridge. As a result, an ACPI handle is used (rather
  than the PCI SBDF option for GIs). In QEMU the easiest way
  to get to this is to target the root bridge PCI Bus, and
  conveniently the root bridge bus number is used for the UID allowing
  us to construct an appropriate entry.

A key addition of this series is a complex NUMA topology example that
stretches the QEMU emulation code for GI, GP and nodes with just
CPUS, just memory, just hot pluggable memory, mixture of memory and CPUs.

A similar test showed up a few NUMA related bugs with fixes applied for
9.0 (note that one of these needs linux booted to identify that it
rejects the HMAT table and this test is a regression test for the
table generation only).

https://lore.kernel.org/qemu-devel/2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com/
https://lore.kernel.org/qemu-devel/74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com/


Jonathan Cameron (15):
  hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
  hw/acpi/GI: Fix trivial parameter alignment issue.
  hw/acpi: Move AML building code for Generic Initiators to aml_build.c
  hw/acpi: Rename build_all_acpi_generic_initiators() to
    build_acpi_generic_initiator()
  hw/pci: Add a busnr property to pci_props and use for acpi/gi
  acpi/pci: Move Generic Initiator object handling into acpi/pci.*
  hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
  hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
  hw/pci-host/gpex-acpi: Use acpi_uid property.
  hw/acpi: Generic Port Affinity Structure support
  hw/acpi: Make storage of node id uint32_t to reduce fragility
  hw/acpi: Generic Initiator - add missing object class property
    descriptions.
  bios-tables-test: Allow for new acpihmat-generic-x test data.
  bios-tables-test: Add complex SRAT / HMAT test for GI GP
  bios-tables-test: Add data for complex numa test (GI, GP etc)

 qapi/qom.json                                 |  41 +++
 include/hw/acpi/acpi_generic_initiator.h      |  47 ----
 include/hw/acpi/aml-build.h                   |   7 +
 include/hw/acpi/pci.h                         |   3 +
 include/hw/pci/pci_bridge.h                   |   1 +
 hw/acpi/acpi_generic_initiator.c              | 148 -----------
 hw/acpi/aml-build.c                           |  83 ++++++
 hw/acpi/pci.c                                 | 242 ++++++++++++++++++
 hw/arm/virt-acpi-build.c                      |   3 +-
 hw/i386/acpi-build.c                          |   8 +-
 hw/pci-bridge/pci_expander_bridge.c           |  14 +-
 hw/pci-host/gpex-acpi.c                       |   5 +-
 hw/pci/pci.c                                  |  14 +
 tests/qtest/bios-tables-test.c                |  97 +++++++
 hw/acpi/meson.build                           |   1 -
 .../data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 .../data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 12566 bytes
 .../data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 .../data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 20 files changed, 511 insertions(+), 203 deletions(-)
 delete mode 100644 include/hw/acpi/acpi_generic_initiator.h
 delete mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x

-- 
2.43.0


