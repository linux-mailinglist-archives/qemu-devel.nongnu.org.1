Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325F7B2E63
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DQ-0004xO-8u; Fri, 29 Sep 2023 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DF-0004w6-4L
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9D8-0005aq-Ok
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LBtRIoAz01OX1cpwN9YeeEe7Nyne8NSkK54j1Sp+4Rk=;
 b=EDR3WZB/6zvpkHMr3gaPx9PAzXqtWqq9GwflsDBYv1Cel7wuftDqErcT0EXsTbIFEVgkZ0
 9IW9C9rrxoI0Fn0i8J5ss6hDy/r58oO3LhrMBK18xz8BVnwN/RPKRP4/dR1Aen9+1tU+Au
 cG6FlmO8fyfvXFPnVZyKtydXVLTEqGs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-5alpG97DN4qwfDNY8IdEkA-1; Fri, 29 Sep 2023 04:50:54 -0400
X-MC-Unique: 5alpG97DN4qwfDNY8IdEkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CFA21C05149
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1D414171B6
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 511FE21E6904; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/56] -Wshadow=local patches patches for 2023-09-29
Date: Fri, 29 Sep 2023 10:49:57 +0200
Message-ID: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-shadow-2023-09-29

for you to fetch changes up to 4dba9141f97e66fdd920df37c4aa7b2ffe0d6a4a:

  disas/m68k: clean up local variable shadowing (2023-09-29 10:07:21 +0200)

----------------------------------------------------------------
-Wshadow=local patches patches for 2023-09-29

----------------------------------------------------------------
Alberto Garcia (1):
      test-throttle: don't shadow 'index' variable in do_test_accounting()

Alistair Francis (4):
      hw/riscv: opentitan: Fixup local variables shadowing
      target/riscv: cpu: Fixup local variables shadowing
      target/riscv: vector_helper: Fixup local variables shadowing
      softmmu/device_tree: Fixup local variables shadowing

Ani Sinha (1):
      hw/acpi: changes towards enabling -Wshadow=local

Cédric Le Goater (12):
      hw/ppc: Clean up local variable shadowing in _FDT helper routine
      pnv/psi: Clean up local variable shadowing
      spapr: Clean up local variable shadowing in spapr_dt_cpus()
      spapr: Clean up local variable shadowing in spapr_init_cpus()
      spapr: Clean up local variable shadowing in spapr_get_fw_dev_path()
      spapr/drc: Clean up local variable shadowing in rtas_ibm_configure_connector()
      spapr/pci: Clean up local variable shadowing in spapr_phb_realize()
      spapr/drc: Clean up local variable shadowing in prop_get_fdt()
      aspeed/i2c: Clean up local variable shadowing
      aspeed: Clean up local variable shadowing
      aspeed/i3c: Rename variable shadowing a local
      aspeed/timer: Clean up local variable shadowing

Daniel P. Berrangé (2):
      crypto: remove shadowed 'ret' variable
      seccomp: avoid shadowing of 'action' variable

Eric Blake (1):
      qemu-nbd: changes towards enabling -Wshadow=local

Klaus Jensen (1):
      hw/nvme: Clean up local variable shadowing in nvme_ns_init()

Laurent Vivier (1):
      disas/m68k: clean up local variable shadowing

Markus Armbruster (7):
      migration/rdma: Fix save_page method to fail on polling error
      migration: Clean up local variable shadowing
      ui: Clean up local variable shadowing
      block/dirty-bitmap: Clean up local variable shadowing
      block/vdi: Clean up local variable shadowing
      block: Clean up local variable shadowing
      qobject atomics osdep: Make a few macros more hygienic

Peter Maydell (4):
      hw/intc/arm_gicv3_its: Avoid shadowing variable in do_process_its_cmd()
      hw/misc/arm_sysctl.c: Avoid shadowing local variable
      hw/arm/smmuv3.c: Avoid shadowing variable
      hw/arm/smmuv3-internal.h: Don't use locals in statement macros

Peter Xu (1):
      intel_iommu: Fix shadow local variables on "size"

Philippe Mathieu-Daudé (21):
      tcg: Clean up local variable shadowing
      target/arm/tcg: Clean up local variable shadowing
      target/arm/hvf: Clean up local variable shadowing
      target/mips: Clean up local variable shadowing
      target/m68k: Clean up local variable shadowing
      target/tricore: Clean up local variable shadowing
      hw/arm/armv7m: Clean up local variable shadowing
      hw/arm/virt: Clean up local variable shadowing
      hw/arm/allwinner: Clean up local variable shadowing
      hw/m68k: Clean up local variable shadowing
      hw/microblaze: Clean up local variable shadowing
      hw/nios2: Clean up local variable shadowing
      net/eth: Clean up local variable shadowing
      crypto/cipher-gnutls.c: Clean up local variable shadowing
      util/vhost-user-server: Clean up local variable shadowing
      linux-user/strace: Clean up local variable shadowing
      sysemu/device_tree: Clean up local variable shadowing
      softmmu/memory: Clean up local variable shadowing
      softmmu/physmem: Clean up local variable shadowing
      hw/core/machine: Clean up local variable shadowing
      hw/intc/openpic: Clean up local variable shadowing

 hw/arm/smmuv3-internal.h                 | 41 ++++++++++---------------------
 hw/m68k/bootinfo.h                       | 10 +++-----
 include/hw/ppc/fdt.h                     |  8 +++---
 include/qapi/qmp/qobject.h               | 10 ++++++--
 include/qemu/atomic.h                    | 17 +++++++++----
 include/qemu/compiler.h                  |  3 +++
 include/qemu/osdep.h                     | 27 ++++++++++++++------
 include/sysemu/device_tree.h             |  6 ++---
 accel/tcg/tb-maint.c                     |  3 +--
 block.c                                  |  9 ++++---
 block/monitor/bitmap-qmp-cmds.c          | 19 ++++++++-------
 block/qcow2-bitmap.c                     |  3 +--
 block/rbd.c                              |  2 +-
 block/stream.c                           |  1 -
 block/vdi.c                              |  7 +++---
 block/vvfat.c                            | 35 +++++++++++++-------------
 crypto/tls-cipher-suites.c               |  1 -
 disas/m68k.c                             |  8 +++---
 hw/acpi/cpu_hotplug.c                    | 25 ++++++++++---------
 hw/arm/allwinner-r40.c                   |  7 +++---
 hw/arm/armsse.c                          | 16 +++++-------
 hw/arm/armv7m.c                          |  2 +-
 hw/arm/aspeed_ast2600.c                  | 10 ++++----
 hw/arm/smmuv3.c                          |  4 +--
 hw/arm/virt.c                            |  3 +--
 hw/block/xen-block.c                     |  6 ++---
 hw/core/machine.c                        |  2 --
 hw/i2c/aspeed_i2c.c                      |  1 -
 hw/i386/acpi-build.c                     | 24 +++++++++---------
 hw/i386/intel_iommu.c                    |  8 +++---
 hw/intc/arm_gicv3_its.c                  |  6 ++---
 hw/intc/openpic.c                        |  7 ++----
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/misc/arm_sysctl.c                     |  6 ++---
 hw/misc/aspeed_i3c.c                     |  6 ++---
 hw/nios2/10m50_devboard.c                |  4 +--
 hw/nvme/ns.c                             |  4 +--
 hw/ppc/pnv_psi.c                         |  5 ++--
 hw/ppc/spapr.c                           | 42 +++++++++++++++++---------------
 hw/ppc/spapr_drc.c                       | 12 ++++-----
 hw/ppc/spapr_pci.c                       |  6 ++---
 hw/riscv/opentitan.c                     |  2 +-
 hw/smbios/smbios.c                       | 37 ++++++++++++++--------------
 hw/timer/aspeed_timer.c                  |  2 +-
 linux-user/strace.c                      |  1 -
 migration/block.c                        |  4 +--
 migration/ram.c                          |  8 +++---
 migration/rdma.c                         | 14 +++++++----
 migration/vmstate.c                      |  2 +-
 net/eth.c                                |  2 --
 qemu-nbd.c                               |  9 +++----
 softmmu/device_tree.c                    |  6 ++---
 softmmu/memory.c                         |  1 -
 softmmu/physmem.c                        | 10 ++++----
 softmmu/qemu-seccomp.c                   |  4 +--
 target/arm/hvf/hvf.c                     |  8 +++---
 target/arm/tcg/mve_helper.c              | 16 ++++++------
 target/arm/tcg/translate-m-nocp.c        |  2 +-
 target/m68k/translate.c                  |  2 +-
 target/mips/tcg/msa_helper.c             |  8 +++---
 target/mips/tcg/translate.c              |  8 +++---
 target/riscv/cpu.c                       |  4 +--
 target/riscv/vector_helper.c             |  7 +++---
 target/tricore/translate.c               |  6 ++---
 tcg/tcg.c                                | 16 ++++++------
 tests/unit/test-throttle.c               |  2 +-
 ui/gtk.c                                 | 14 +++++------
 ui/spice-display.c                       |  9 ++++---
 ui/vnc-palette.c                         |  2 --
 ui/vnc.c                                 | 12 ++++-----
 util/vhost-user-server.c                 |  2 +-
 crypto/cipher-gnutls.c.inc               |  4 +--
 target/mips/tcg/nanomips_translate.c.inc |  6 ++---
 ui/vnc-enc-zrle.c.inc                    |  9 +++----
 74 files changed, 326 insertions(+), 331 deletions(-)

-- 
2.41.0


