Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D37D03B6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPZ-0004i2-Kh; Thu, 19 Oct 2023 17:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPO-0004fM-Oi
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPL-0003tB-9j
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4083f613272so1055535e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750297; x=1698355097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ef/nYcpZlmNsl0z+N2suVL2vH+KdkazWSU0sYmye3Vc=;
 b=WTohJj9BuZoni7QXfpII3RgtRniN8uyrbUUfG4Oz707OVm7bT1tgMgz7FL7Zolrf1y
 B6Vgl6+lF0tVCmp4XiOYXD43PlZiamp/j1LJ3vpZWzQ44ODXHoe0kQRW5EXFIUzkK20Y
 oEHEsMLknUi/DYLZw0hQwdvdFpDhkm4Rshqhs2CJjnRZOQ65UilzlnulXwzCCTS72eEy
 Do1vcLc4lps5p6Jn0EefTWHHpj1KOHwJx4lR8luF0p9UyWwhmMWg6y/mr5qhQ79h/fOH
 L5p4+VyMyDxMKREEveolVG5XhXH4VyLK4KonlAKMAzFxW767FlwHwm6htdKs/dyVDbiF
 oJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750297; x=1698355097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ef/nYcpZlmNsl0z+N2suVL2vH+KdkazWSU0sYmye3Vc=;
 b=DrUaEJuEuYAM8YB8kPc0vjtxqZnfJcMtw5++cedhgPrdXh7fELe8IBGUAM+SyqO2/P
 iSDWUg+7rRcOly7kuBAGk/8OpYISnbBOQzvEKBr7j8u+eqei4GbAIutjX1lC0wCuqvef
 h9UOOTB793DAkhdHYCutPFG5F6aRGHQ8mLqD7G7+4nwXxXMmGOOY3XAmEyTuYCSwrXBU
 jpibnqq1aSbkfJLAbPc/3wUH0S+HgD/TLSpF2C0p/WSmAohF+H+oyRkogCDTVhoxpa0H
 GE2spVP9dcP7Fu0X76tO7dfw8xe/IFprrBBQzxfySP179Upyn5DluumPOdJPGyk4vVr4
 3SLw==
X-Gm-Message-State: AOJu0YwnesZ6Nf2d1rrG7Nn0TemAYzPmwxMZftl/smAzybNV0Hv/xmgX
 D21PVSPrf1fD8uWqlHvBPRlGaRUuMalFOwtbcH8nNg==
X-Google-Smtp-Source: AGHT+IHbU7nB5d/52m+5x5jgI6QEDqDNjZ8RcdVpZ0nd02JmteMEgI8qqnnLumqJw60OIvRI7FsLeQ==
X-Received: by 2002:a7b:c3cc:0:b0:405:499a:7fc1 with SMTP id
 t12-20020a7bc3cc000000b00405499a7fc1mr26430wmj.40.1697750297415; 
 Thu, 19 Oct 2023 14:18:17 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c311000b0040651505684sm503383wmo.29.2023.10.19.14.18.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/46] Misc HW/UI patches for 2023-10-19
Date: Thu, 19 Oct 2023 23:17:25 +0200
Message-ID: <20231019211814.30576-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The following changes since commit 0d239e513e0117e66fa739fb71a43b9383a108ff:

  Merge tag 'pull-lu-20231018' of https://gitlab.com/rth7680/qemu into staging (2023-10-19 10:20:57 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20231019

for you to fetch changes up to b1be65f6436f53618408d9c6fc6959054f5afed6:

  ui/input: Constify QemuInputHandler structure (2023-10-19 23:13:28 +0200)

----------------------------------------------------------------
Misc hardware patch queue

- MAINTAINERS updates (Zoltan, Thomas)
- Fix cutils::get_relocated_path on Windows host (Akihiko)
- Housekeeping in Memory APIs (Marc-André)
- SDHCI fix for SDMA transfer (Lu, Jianxian)
- Various QOM/QDev/SysBus cleanups (Philippe)
- Constify QemuInputHandler structure (Philippe)

----------------------------------------------------------------

Akihiko Odaki (1):
  cutils: Fix get_relocated_path on Windows

BALATON Zoltan (1):
  MAINTAINERS: Split vt82c686 out of fuloong2e

Lu Gao (1):
  hw/sd/sdhci: Block Size Register bits [14:12] is lost

Luc Michel (1):
  mailmap: update email addresses for Luc Michel

Marc-André Lureau (2):
  memory: drop needless argument
  memory: follow Error API guidelines

Philippe Mathieu-Daudé (37):
  buildsys: Only display Objective-C information when Objective-C is
    used
  hw/mips/malta: Use sdram_type enum from 'hw/i2c/smbus_eeprom.h'
  hw/mips: Merge 'hw/mips/cpudevs.h' with 'target/mips/cpu.h'
  hw/misc/mips_itu: Declare itc_reconfigure() in 'hw/misc/mips_itu.h'
  hw/misc/mips_itu: Make MIPSITUState target agnostic
  hw/pci-host/sh_pcic: Declare CPU QOM types using DEFINE_TYPES() macro
  hw/pci-host/sh_pcic: Correct PCI host / devfn#0 function names
  hw/pci-host/sh_pcic: Replace magic value by proper definition
  hw/sparc64/ebus: Access memory regions via pci_address_space_io()
  hw/acpi/pcihp: Clean up global variable shadowing in acpi_pcihp_init()
  hw/pci: Clean up global variable shadowing of address_space_io
    variable
  hw/s390x: Clean up global variable shadowing in
    quiesce_powerdown_req()
  hw/intc/apic: Use ERRP_GUARD() in apic_common_realize()
  hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before accessing it
  hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
    pnv_xscom_init()
  hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
  hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
  hw/ppc/pnv: Do not use SysBus API to map local MMIO region
  hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
  hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region
  hw/audio/pcspk: Inline pcspk_init()
  hw/i386/amd_iommu: Do not use SysBus API to map local MMIO region
  hw/i386/intel_iommu: Do not use SysBus API to map local MMIO region
  hw/misc/allwinner-dramc: Move sysbus_mmio_map call from init ->
    realize
  hw/misc/allwinner-dramc: Do not use SysBus API to map local MMIO
    region
  hw/pci-host/bonito: Do not use SysBus API to map local MMIO region
  hw/acpi: Realize ACPI_GED sysbus device before accessing it
  hw/arm/virt: Realize ARM_GICV2M sysbus device before accessing it
  hw/isa: Realize ISA bridge device before accessing it
  hw/s390x/css-bridge: Realize sysbus device before accessing it
  hw/virtio/virtio-pmem: Replace impossible check by assertion
  hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE() macros
  hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
  hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
  hw/dma: Declare link using static DEFINE_PROP_LINK() macro
  hw/net: Declare link using static DEFINE_PROP_LINK() macro
  ui/input: Constify QemuInputHandler structure

Thomas Huth (3):
  MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine section
  MAINTAINERS: Add include/hw/intc/loongson_liointc.h to the Loongson-3
    virt section
  MAINTAINERS: Add include/hw/openrisc/ to the OpenRISC section

 MAINTAINERS                         | 16 ++++++--
 meson.build                         |  6 ++-
 include/hw/acpi/pcihp.h             |  2 +-
 include/hw/audio/pcspk.h            | 10 -----
 include/hw/core/cpu.h               |  4 +-
 include/hw/core/sysemu-cpu-ops.h    |  2 +-
 include/hw/mips/cpudevs.h           | 14 -------
 include/hw/misc/mips_itu.h          |  4 +-
 include/hw/pci/pci.h                |  9 ++---
 include/hw/ppc/pnv_xscom.h          |  2 +-
 include/hw/virtio/virtio-input.h    |  2 +-
 include/sysemu/memory_mapping.h     |  2 +-
 include/ui/input.h                  |  2 +-
 target/i386/cpu.h                   |  2 +-
 target/mips/cpu.h                   |  7 ++--
 chardev/msmouse.c                   |  2 +-
 chardev/wctablet.c                  |  2 +-
 hw/acpi/pcihp.c                     |  5 +--
 hw/arm/virt.c                       |  5 +--
 hw/block/vhost-user-blk.c           |  4 +-
 hw/char/escc.c                      |  2 +-
 hw/core/cpu-sysemu.c                |  6 +--
 hw/display/virtio-gpu.c             |  2 +-
 hw/display/xenfb.c                  |  6 +--
 hw/dma/xilinx_axidma.c              |  6 +--
 hw/dma/xlnx-zdma.c                  |  7 +---
 hw/dma/xlnx_csu_dma.c               | 13 ++-----
 hw/i386/amd_iommu.c                 |  5 +--
 hw/i386/intel_iommu.c               |  5 +--
 hw/i386/microvm.c                   |  2 +-
 hw/i386/pc.c                        |  4 +-
 hw/input/adb-kbd.c                  |  2 +-
 hw/input/hid.c                      |  6 +--
 hw/input/ps2.c                      |  4 +-
 hw/input/virtio-input-hid.c         |  8 ++--
 hw/intc/apic_common.c               |  4 ++
 hw/intc/spapr_xive.c                | 12 +++---
 hw/isa/i82378.c                     |  5 ++-
 hw/isa/isa-bus.c                    | 11 +++++-
 hw/loongarch/virt.c                 |  2 +-
 hw/mips/cps.c                       |  1 -
 hw/mips/fuloong2e.c                 |  1 -
 hw/mips/jazz.c                      |  6 ++-
 hw/mips/loongson3_virt.c            |  1 -
 hw/mips/malta.c                     |  3 +-
 hw/mips/mips_int.c                  |  1 -
 hw/mips/mipssim.c                   |  1 -
 hw/misc/allwinner-r40-dramc.c       | 20 +++++-----
 hw/misc/mips_itu.c                  |  4 +-
 hw/net/cadence_gem.c                |  7 +---
 hw/pci-host/bonito.c                | 30 +++++++--------
 hw/pci-host/sh_pci.c                | 57 +++++++++++++----------------
 hw/pci/pci.c                        | 25 +++++--------
 hw/ppc/pnv.c                        | 26 +++----------
 hw/ppc/pnv_xscom.c                  |  5 +--
 hw/ppc/spapr_vio.c                  |  3 +-
 hw/s390x/css-bridge.c               |  7 ++--
 hw/s390x/sclpquiesce.c              |  8 ++--
 hw/scsi/virtio-scsi.c               |  2 +-
 hw/sd/sdhci.c                       | 15 ++++++--
 hw/sparc64/sun4u.c                  |  8 ++--
 hw/virtio/virtio-pmem.c             |  5 +--
 system/memory_mapping.c             | 17 ++++-----
 target/i386/arch_memory_mapping.c   |  6 ++-
 target/mips/sysemu/cp0_timer.c      |  1 -
 target/mips/tcg/sysemu/cp0_helper.c |  1 +
 target/mips/tcg/sysemu/tlb_helper.c |  1 -
 ui/input-legacy.c                   |  2 +-
 ui/input.c                          |  4 +-
 ui/vdagent.c                        |  2 +-
 util/cutils.c                       | 18 +++++----
 .mailmap                            |  3 ++
 72 files changed, 232 insertions(+), 273 deletions(-)
 delete mode 100644 include/hw/mips/cpudevs.h

-- 
2.41.0


