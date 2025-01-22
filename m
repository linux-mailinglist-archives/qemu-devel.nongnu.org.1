Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC2A18DAB
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 09:39:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWF1-0006Gh-CS; Wed, 22 Jan 2025 03:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1taWEc-0006DW-9b; Wed, 22 Jan 2025 03:37:14 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1taWEY-0000be-QC; Wed, 22 Jan 2025 03:37:13 -0500
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 50M8aXLO018563
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 16:36:33 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 22 Jan 2025
 16:36:33 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v10 0/8] Support RISC-V IOPMP
Date: Wed, 22 Jan 2025 16:36:09 +0800
Message-ID: <20250122083617.3940240-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 50M8aXLO018563
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When IOPMP is enabled, memory access to system memory from devices and
the CPU will be checked by the IOPMP.

The issue of CPU access to non-CPU address space via IOMMU was previously
mentioned by Jim Shu, who provided a patch[1] to fix it. IOPMP also requires
this patch.

You can use a customized QEMU[2] to run bare-metal demo[3] to show IOPMP
functionality. The modifications involve applying patch[1] and adding a simple
DMA device along with a second IOPMP device to the virt machine. These
additional devices are intended to demonstrate more complex scenarios for IOPMP.

[1] accel/tcg: Store section pointer in CPUTLBEntryFull
    https://patchew.org/QEMU/20240612081416.29704-1-jim.shu@sifive.com/20240612081416.29704-2-jim.shu@sifive.com/
[2] https://github.com/zhanyangch/qemu/tree/iopmp_patch_test
[3] https://github.com/zhanyangch/iopmp-test

Changes for v10:

  - Fix a build error for iopmp_dispatcher
  - The mmio size of IOPMP device is calculated based on properties, rather
    than relying on a fixed value

Changes for v9:

  - Change the specification version to v0.9.2 RC3
  - Remove API for configuration CPU IOPMP property (Alistair)
  - Add a dispatcher device to forward iopmp transaction information

Changes for v8:

  - Support transactions from CPU
  - Add an API to set up IOPMP protection for system memory
  - Add an API to configure the RISCV CPU to support IOPMP and specify the
    CPU's RRID
  - Add an API for DMA operation with IOPMP support
  - Add SPDX license identifiers to new files (Stefan W.)
  - Remove IOPMP PCI interface(pci_setup_iommu) (Zhiwei)

Changes for v7:

  - Change the specification version to v0.9.1
  - Remove the sps extension
  - Remove stall support, transaction information which need requestor device
    support.
  - Remove iopmp_cascade option for virt machine
  - Refine 'addr' range checks switch case (Daniel)

Ethan Chen (8):
  hw/core: Add config stream
  memory: Introduce memory region fetch operation
  system/physmem: Support IOMMU granularity smaller than TARGET_PAGE
    size
  target/riscv: Add support for IOPMP
  hw/misc/riscv_iopmp_txn_info: Add struct for transaction infomation
  hw/misc/riscv_iopmp: Add RISC-V IOPMP device
  hw/misc/riscv_iopmp_dispatcher: Device for redirect IOPMP transaction
    infomation
  hw/riscv/virt: Add IOPMP support

 accel/tcg/cputlb.c                       |   29 +-
 docs/system/riscv/virt.rst               |    7 +
 hw/Kconfig                               |    1 +
 hw/core/Kconfig                          |    3 +
 hw/core/meson.build                      |    2 +-
 hw/misc/Kconfig                          |    4 +
 hw/misc/meson.build                      |    2 +
 hw/misc/riscv_iopmp.c                    | 2182 ++++++++++++++++++++++
 hw/misc/riscv_iopmp_dispatcher.c         |  136 ++
 hw/misc/trace-events                     |    4 +
 hw/riscv/Kconfig                         |    1 +
 hw/riscv/virt.c                          |   75 +
 include/exec/memory.h                    |   27 +
 include/hw/misc/riscv_iopmp.h            |  191 ++
 include/hw/misc/riscv_iopmp_dispatcher.h |   61 +
 include/hw/misc/riscv_iopmp_txn_info.h   |   38 +
 include/hw/riscv/virt.h                  |    4 +
 system/memory.c                          |  104 ++
 system/physmem.c                         |    4 +
 system/trace-events                      |    2 +
 target/riscv/cpu.c                       |    3 +
 target/riscv/cpu_cfg.h                   |    2 +
 target/riscv/cpu_helper.c                |   18 +-
 23 files changed, 2890 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 hw/misc/riscv_iopmp_dispatcher.c
 create mode 100644 include/hw/misc/riscv_iopmp.h
 create mode 100644 include/hw/misc/riscv_iopmp_dispatcher.h
 create mode 100644 include/hw/misc/riscv_iopmp_txn_info.h

-- 
2.34.1


