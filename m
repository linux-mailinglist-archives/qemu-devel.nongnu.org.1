Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F5A9A517
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 09:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rUZ-0001Hm-Ti; Thu, 24 Apr 2025 03:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7rUW-0001Gk-HR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7rUU-0007XI-Fs
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745481563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hFnJ+X0vpxrA4VC1p999qnoHFFaTEDT6dHS4zd0OhLU=;
 b=TnJIBjvm7gzc7AYbutt7vPxPJzKnRbj+5LgR8Uckr2ncQLc/MqCTFkFH781+RHkn+YoEWx
 IUdE+UnzadXBiXXGQX5MYfgJHJRUQ9ipW7684tyIaZMzUgRBiR//JVIqPIda++LYbKr64Q
 QDfXq0NATv3u6e3Ml34pC0H3w7fUIqM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-4lNrQYoHOny10OrmoiOU0Q-1; Thu,
 24 Apr 2025 03:59:21 -0400
X-MC-Unique: 4lNrQYoHOny10OrmoiOU0Q-1
X-Mimecast-MFC-AGG-ID: 4lNrQYoHOny10OrmoiOU0Q_1745481561
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EC4B180036E
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:59:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9381C180045B
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E550321E66C3; Thu, 24 Apr 2025 09:59:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/3] Miscellaneous patches for 2025-04-24
Date: Thu, 24 Apr 2025 09:59:13 +0200
Message-ID: <20250424075916.1522767-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 91d0d16b44c93fa82cf76ae12990ce3aa96096c9:

  Merge tag 'pull-avr-20250422' of https://gitlab.com/rth7680/qemu into staging (2025-04-23 09:29:33 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-misc-2025-04-24

for you to fetch changes up to abb55b1abaaa8521e93d8202dd67b9e70a4ca1a2:

  cleanup: Drop pointless label at end of function (2025-04-24 09:34:53 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2025-04-24

----------------------------------------------------------------
Markus Armbruster (3):
      cleanup: Re-run return_directly.cocci
      cleanup: Drop pointless return at end of function
      cleanup: Drop pointless label at end of function

 include/system/os-win32.h             |  1 -
 target/ppc/kvm_ppc.h                  |  3 ---
 accel/tcg/cpu-exec.c                  |  1 -
 block/gluster.c                       |  4 ----
 block/rbd.c                           |  1 -
 block/replication.c                   |  1 -
 block/throttle-groups.c               |  1 -
 bsd-user/signal.c                     |  1 -
 dump/win_dump.c                       |  2 --
 event-loop-base.c                     |  2 --
 hw/acpi/acpi-cpu-hotplug-stub.c       |  8 --------
 hw/acpi/acpi-mem-hotplug-stub.c       |  5 -----
 hw/acpi/acpi-nvdimm-stub.c            |  1 -
 hw/acpi/acpi-pci-hotplug-stub.c       |  6 ------
 hw/arm/exynos4210.c                   |  1 -
 hw/arm/smmu-common.c                  |  1 -
 hw/arm/xen-stubs.c                    |  1 -
 hw/audio/asc.c                        |  1 -
 hw/core/qdev-properties-system.c      |  1 -
 hw/cxl/cxl-host.c                     |  2 --
 hw/display/macfb.c                    |  1 -
 hw/display/tcx.c                      |  1 -
 hw/display/virtio-gpu-base.c          |  1 -
 hw/dma/sifive_pdma.c                  |  1 -
 hw/gpio/aspeed_gpio.c                 |  5 -----
 hw/gpio/bcm2838_gpio.c                |  1 -
 hw/gpio/imx_gpio.c                    |  2 --
 hw/gpio/pca9554.c                     |  5 +----
 hw/gpio/pl061.c                       |  1 -
 hw/hyperv/vmbus.c                     |  1 -
 hw/i2c/pm_smbus.c                     |  1 -
 hw/i386/intel_iommu.c                 |  2 --
 hw/i386/kvm/xen_xenstore.c            |  4 +---
 hw/i386/nitro_enclave.c               |  1 -
 hw/i386/xen/xen-hvm.c                 |  2 --
 hw/input/virtio-input-host.c          |  1 -
 hw/intc/arm_gicv3_cpuif.c             |  1 -
 hw/intc/aspeed_intc.c                 |  4 ----
 hw/intc/mips_gic.c                    |  1 -
 hw/ipmi/ipmi_bmc_extern.c             |  6 +-----
 hw/ipmi/ipmi_bmc_sim.c                |  9 ++-------
 hw/ipmi/ipmi_bt.c                     |  8 +++-----
 hw/ipmi/ipmi_kcs.c                    |  4 +---
 hw/loongarch/virt.c                   |  2 --
 hw/m68k/next-cube.c                   |  1 -
 hw/m68k/q800.c                        |  2 --
 hw/mem/cxl_type3.c                    |  4 ----
 hw/mem/sparse-mem.c                   |  1 -
 hw/misc/i2c-echo.c                    |  2 --
 hw/misc/ivshmem-flat.c                |  2 --
 hw/misc/mips_cpc.c                    |  2 --
 hw/net/can/ctucan_core.c              |  2 --
 hw/net/can/xlnx-versal-canfd.c        |  2 --
 hw/net/imx_fec.c                      |  1 -
 hw/net/vmxnet3.c                      |  1 -
 hw/nvram/xlnx-versal-efuse-ctrl.c     |  1 -
 hw/ppc/mac_newworld.c                 |  2 --
 hw/ppc/pnv_occ.c                      |  1 -
 hw/ppc/spapr_hcall.c                  |  1 -
 hw/ppc/spapr_nested.c                 |  1 -
 hw/ppc/spapr_nvdimm.c                 |  2 --
 hw/riscv/virt.c                       | 25 ++++++++++---------------
 hw/s390x/s390-pci-bus.c               |  1 -
 hw/s390x/s390-pci-vfio.c              |  2 --
 hw/scsi/esp.c                         |  5 +----
 hw/scsi/megasas.c                     |  1 -
 hw/scsi/vhost-scsi.c                  |  1 -
 hw/ssi/ibex_spi_host.c                |  1 -
 hw/ssi/pnv_spi.c                      |  2 --
 hw/tpm/tpm_tis_i2c.c                  |  4 ----
 hw/usb/dev-mtp.c                      |  2 --
 hw/usb/dev-serial.c                   |  2 --
 hw/usb/dev-smartcard-reader.c         |  1 -
 hw/usb/dev-uas.c                      |  1 -
 hw/vfio/common.c                      |  7 ++-----
 hw/vfio/display.c                     |  1 -
 hw/vfio/pci.c                         |  1 -
 hw/vfio/platform.c                    |  1 -
 hw/virtio/vhost-user-fs.c             |  1 -
 hw/virtio/vhost-user-scmi.c           |  2 --
 hw/virtio/vhost-user-vsock.c          |  1 -
 hw/virtio/vhost-user.c                |  2 --
 hw/virtio/vhost-vdpa.c                |  2 --
 hw/virtio/vhost.c                     |  1 -
 hw/virtio/virtio-nsm.c                |  1 -
 hw/virtio/virtio.c                    |  2 --
 hw/watchdog/sbsa_gwdt.c               |  1 -
 hw/watchdog/wdt_aspeed.c              |  1 -
 linux-user/xtensa/signal.c            |  1 -
 migration/multifd-nocomp.c            |  1 -
 migration/qemu-file.c                 |  2 --
 migration/ram.c                       |  2 --
 net/colo-compare.c                    |  2 --
 plugins/api.c                         |  4 +---
 qemu-keymap.c                         |  1 -
 qga/commands-win32.c                  |  4 ----
 system/dirtylimit.c                   |  2 --
 target/arm/tcg/helper-a64.c           |  2 --
 target/i386/kvm/vmsr_energy.c         |  1 -
 target/i386/tcg/translate.c           |  1 -
 target/i386/whpx/whpx-all.c           | 11 -----------
 target/m68k/helper.c                  |  1 -
 target/mips/tcg/system/mips-semi.c    |  1 -
 target/ppc/kvm.c                      |  1 -
 target/ppc/translate.c                |  1 -
 target/riscv/debug.c                  |  6 ------
 target/s390x/cpu_models.c             |  1 -
 target/sh4/translate.c                |  1 -
 tests/qtest/ahci-test.c               |  1 -
 tests/qtest/cmsdk-apb-watchdog-test.c |  6 +-----
 tests/qtest/fuzz/generic_fuzz.c       |  1 -
 tests/qtest/libqos/libqos-malloc.c    |  1 -
 tests/qtest/libqtest.c                |  1 -
 tests/qtest/pnv-host-i2c-test.c       |  4 +---
 tests/qtest/stm32l4x5_usart-test.c    |  6 +-----
 tests/qtest/test-x86-cpuid-compat.c   |  1 -
 tests/unit/socket-helpers.c           |  1 -
 tests/unit/test-qgraph.c              |  1 -
 tools/i386/qemu-vmsr-helper.c         |  5 +----
 ui/input-linux.c                      |  1 -
 ui/vnc.c                              |  2 --
 util/main-loop.c                      |  1 -
 util/qht.c                            |  1 -
 123 files changed, 27 insertions(+), 261 deletions(-)

-- 
2.48.1


