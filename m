Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00808A99D72
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 02:57:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knp-00068U-Bd; Wed, 23 Apr 2025 20:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn7-0005ew-5g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:20 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0004Nv-Og
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:12 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so358292a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455801; x=1746060601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAfCHniCscGXxzYWNaJ01CHUmiT34IAUqdzapE82HPc=;
 b=Y5TO4bvi6HDgzVYl76TSFxbiOf54rMqs0toAizMt8ahgZJHMwrxqK76QbQ8Fxl6HBo
 +lY6j9vaZ+ekTofjCOth//DLEhLtKPy+ESP/SUx8AftI37PYdp1WsHICPeUp6hmF4CQ9
 dqZDbD4FsS1kn3plzJAzIfHTjJJEBLyICEyRgBpp3wOZEFjhgyWS09g3BX7dYTb0Wq0r
 vY94js6snxNhl4h6r+8vffYDBHM0k6+zkO271JnB/m7U6BZW5viXewfFyjyJxbhVWsa3
 vAkow0QftzxUpfqnf4k/hVYSDS/Hp4dGkTxGRMcEptAFF7J4DBn5Sh02K9mEK2lQUnIl
 ru7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455801; x=1746060601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAfCHniCscGXxzYWNaJ01CHUmiT34IAUqdzapE82HPc=;
 b=WQnex9ooHWH9Yj2XBuQD6ZzrlXUIGwUj5OPKyqKFa0M1Of67YZcxFd4nrMNKFpJmc9
 ukAmrz5NKzxw+xKo1IW5tn9TJxgAG/9fKlrh7IXPIp1TfTsTRszDtfe99Iv4bzjKedrd
 UyljqnKpMDq+kbBjXFemAOC+nIvsVg5dLsSfuJqoMLmeuACwGJB9eMfUIDupv8ykQEwK
 FXtjsfrd4sfP0FviyEhZ9wjD1u8zA4wfp6lH/M6OnKK0zR1S1Mq96xuxeA4YrPOPNslf
 Ou6qzJO+C1GT6gzkCw6vg8JxibaSPsQ88gv2msOsWlcWmpodT3wFQBZxRnavVps+sFQ5
 iBEA==
X-Gm-Message-State: AOJu0YzoCpl7T1dDJod/qF9gkvkZPQIf6BIRwNfUTZAkzK1f+X3K4xgH
 18CofUOFbhFpL3/mmt01mQQ/3564mEeYykwEVgOg56mda3B8xUL4AQzQ+GpSV1SZ+Fk5qxhngl/
 k
X-Gm-Gg: ASbGnctj/fXYirXW5d+FeG7k463GRDVpeANxpCqOj+7wE32dybyCYa2vYWuheU85XjC
 zKNZBe80FkG0XUQItfFlzZ4ejUsJf73gQxnousR1wsPIH4+W3RQVeQlY2jc7keeX+YFsL+uhvxe
 LkOTQkzFeuCRg6LPTcv5mDIS0rXseovFQ0YbD9Y9CxVE/HTyHKmwgNemOcovaTw9+9wGiMXdSRO
 VohF7P12iO4HP5wBlUj66c7hgfXCfu+pPDgqTFxXg1vel5hnOoD4lQfiOInXtjLoxYVlunIdExj
 A5LPzDhggU5pnno9peojdCAaTm0HhOpQYBeu1WGYzlKh5Igic/NyUvUJmyfGp0ZHbuDIPjn2LLE
 =
X-Google-Smtp-Source: AGHT+IFM3klkuf3iiHnRvLcdkXjonIhNloK6HrGUCOz8oDKmeHtPepugwfXSOjH0E4yvNxhnbbuCCA==
X-Received: by 2002:a05:6a21:181a:b0:1f5:9cb2:28a2 with SMTP id
 adf61e73a8af0-20444ebe192mr807994637.19.1745455800652; 
 Wed, 23 Apr 2025 17:50:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:50:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 034/148] include/system: Move exec/memory.h to system/memory.h
Date: Wed, 23 Apr 2025 17:47:39 -0700
Message-ID: <20250424004934.598783-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Convert the existing includes with

  sed -i ,exec/memory.h,system/memory.h,g

Move the include within cpu-all.h into a !CONFIG_USER_ONLY block.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/strongarm.h                        | 2 +-
 hw/display/apple-gfx.h                    | 2 +-
 hw/display/framebuffer.h                  | 2 +-
 hw/display/vga_int.h                      | 2 +-
 hw/hyperv/hv-balloon-our_range_memslots.h | 2 +-
 hw/intc/ioapic_internal.h                 | 2 +-
 hw/net/i82596.h                           | 2 +-
 hw/net/pcnet.h                            | 2 +-
 hw/tpm/tpm_ppi.h                          | 2 +-
 hw/usb/hcd-uhci.h                         | 2 +-
 hw/vfio/pci.h                             | 2 +-
 hw/virtio/vhost-iova-tree.h               | 2 +-
 include/exec/cpu-all.h                    | 5 ++++-
 include/exec/ioport.h                     | 2 +-
 include/exec/ram_addr.h                   | 2 +-
 include/hw/acpi/acpi.h                    | 2 +-
 include/hw/acpi/ich9_tco.h                | 2 +-
 include/hw/arm/fsl-imx25.h                | 2 +-
 include/hw/arm/fsl-imx31.h                | 2 +-
 include/hw/arm/fsl-imx6.h                 | 2 +-
 include/hw/arm/fsl-imx6ul.h               | 2 +-
 include/hw/arm/omap.h                     | 2 +-
 include/hw/arm/stm32l4x5_soc.h            | 2 +-
 include/hw/boards.h                       | 2 +-
 include/hw/char/parallel.h                | 2 +-
 include/hw/char/riscv_htif.h              | 2 +-
 include/hw/char/serial-mm.h               | 2 +-
 include/hw/char/serial.h                  | 2 +-
 include/hw/display/macfb.h                | 2 +-
 include/hw/fsi/aspeed_apb2opb.h           | 2 +-
 include/hw/fsi/cfam.h                     | 2 +-
 include/hw/fsi/fsi-master.h               | 2 +-
 include/hw/fsi/fsi.h                      | 2 +-
 include/hw/fsi/lbus.h                     | 2 +-
 include/hw/gpio/npcm7xx_gpio.h            | 2 +-
 include/hw/i2c/npcm7xx_smbus.h            | 2 +-
 include/hw/i2c/pm_smbus.h                 | 2 +-
 include/hw/i386/apic_internal.h           | 2 +-
 include/hw/i386/x86.h                     | 2 +-
 include/hw/ide/ahci.h                     | 2 +-
 include/hw/ipmi/ipmi.h                    | 2 +-
 include/hw/isa/apm.h                      | 2 +-
 include/hw/isa/isa.h                      | 2 +-
 include/hw/m68k/q800.h                    | 2 +-
 include/hw/mem/npcm7xx_mc.h               | 2 +-
 include/hw/mem/pc-dimm.h                  | 2 +-
 include/hw/mips/mips.h                    | 2 +-
 include/hw/misc/auxbus.h                  | 2 +-
 include/hw/misc/ivshmem-flat.h            | 2 +-
 include/hw/misc/mac_via.h                 | 2 +-
 include/hw/misc/npcm7xx_mft.h             | 2 +-
 include/hw/misc/npcm_clk.h                | 2 +-
 include/hw/misc/npcm_gcr.h                | 2 +-
 include/hw/misc/pvpanic.h                 | 2 +-
 include/hw/net/dp8393x.h                  | 2 +-
 include/hw/net/msf2-emac.h                | 2 +-
 include/hw/nvram/mac_nvram.h              | 2 +-
 include/hw/nvram/npcm7xx_otp.h            | 2 +-
 include/hw/pci-host/fsl_imx8m_phy.h       | 2 +-
 include/hw/pci-host/pam.h                 | 2 +-
 include/hw/pci-host/remote.h              | 2 +-
 include/hw/pci/pci.h                      | 2 +-
 include/hw/pci/pcie_host.h                | 2 +-
 include/hw/pci/shpc.h                     | 2 +-
 include/hw/ppc/mac_dbdma.h                | 2 +-
 include/hw/ppc/pnv_lpc.h                  | 2 +-
 include/hw/ppc/pnv_occ.h                  | 2 +-
 include/hw/ppc/pnv_sbe.h                  | 2 +-
 include/hw/ppc/pnv_xscom.h                | 2 +-
 include/hw/ppc/ppc4xx.h                   | 2 +-
 include/hw/ppc/vof.h                      | 2 +-
 include/hw/ppc/xics.h                     | 2 +-
 include/hw/register.h                     | 2 +-
 include/hw/remote/proxy-memory-listener.h | 2 +-
 include/hw/sh4/sh_intc.h                  | 2 +-
 include/hw/southbridge/ich9.h             | 2 +-
 include/hw/sysbus.h                       | 2 +-
 include/hw/timer/npcm7xx_timer.h          | 2 +-
 include/hw/tricore/tricore.h              | 2 +-
 include/hw/usb.h                          | 2 +-
 include/hw/vfio/vfio-common.h             | 2 +-
 include/hw/vfio/vfio-container-base.h     | 2 +-
 include/hw/virtio/vhost-backend.h         | 2 +-
 include/hw/virtio/vhost.h                 | 2 +-
 include/hw/virtio/virtio.h                | 2 +-
 include/hw/xen/xen-pvh-common.h           | 2 +-
 include/hw/xtensa/mx_pic.h                | 2 +-
 include/qemu/iova-tree.h                  | 2 +-
 include/qemu/reserved-region.h            | 2 +-
 include/system/dma.h                      | 2 +-
 include/system/hostmem.h                  | 2 +-
 include/system/kvm_int.h                  | 2 +-
 include/{exec => system}/memory.h         | 8 ++------
 include/system/vhost-user-backend.h       | 2 +-
 migration/rdma.h                          | 2 +-
 rust/wrapper.h                            | 2 +-
 target/avr/cpu.h                          | 2 +-
 target/loongarch/cpu.h                    | 2 +-
 target/mips/cpu.h                         | 2 +-
 accel/kvm/kvm-all.c                       | 2 +-
 accel/tcg/cputlb.c                        | 2 +-
 backends/tpm/tpm_util.c                   | 2 +-
 block/blkio.c                             | 4 ++--
 disas/disas-mon.c                         | 2 +-
 hw/acpi/erst.c                            | 2 +-
 hw/avr/atmega.c                           | 2 +-
 hw/block/fdc-sysbus.c                     | 2 +-
 hw/core/cpu-system.c                      | 2 +-
 hw/core/loader-fit.c                      | 2 +-
 hw/core/loader.c                          | 2 +-
 hw/display/edid-region.c                  | 2 +-
 hw/hyperv/hyperv.c                        | 2 +-
 hw/i386/acpi-common.c                     | 2 +-
 hw/i386/acpi-microvm.c                    | 2 +-
 hw/i386/pc_piix.c                         | 2 +-
 hw/intc/mips_gic.c                        | 2 +-
 hw/intc/ompic.c                           | 2 +-
 hw/net/ne2000.c                           | 2 +-
 hw/pci-bridge/pci_bridge_dev.c            | 2 +-
 hw/pci-host/remote.c                      | 2 +-
 hw/ppc/pnv_homer.c                        | 2 +-
 hw/ppc/sam460ex.c                         | 2 +-
 hw/remote/iommu.c                         | 2 +-
 hw/remote/machine.c                       | 2 +-
 hw/remote/proxy-memory-listener.c         | 2 +-
 hw/remote/vfio-user-obj.c                 | 2 +-
 hw/s390x/s390-pci-inst.c                  | 2 +-
 hw/timer/sh_timer.c                       | 2 +-
 hw/vfio/common.c                          | 2 +-
 hw/vfio/container.c                       | 2 +-
 hw/vfio/platform.c                        | 2 +-
 hw/xtensa/sim.c                           | 2 +-
 hw/xtensa/virt.c                          | 2 +-
 hw/xtensa/xtensa_memory.c                 | 2 +-
 hw/xtensa/xtfpga.c                        | 2 +-
 migration/dirtyrate.c                     | 2 +-
 migration/rdma.c                          | 2 +-
 migration/savevm.c                        | 2 +-
 monitor/hmp-cmds-target.c                 | 2 +-
 stubs/ram-block.c                         | 2 +-
 system/dirtylimit.c                       | 2 +-
 system/ioport.c                           | 2 +-
 system/memory.c                           | 2 +-
 system/memory_mapping.c                   | 2 +-
 system/physmem.c                          | 2 +-
 system/qtest.c                            | 2 +-
 target/xtensa/cpu.c                       | 2 +-
 tests/qtest/fuzz/generic_fuzz.c           | 2 +-
 tests/qtest/fuzz/qos_fuzz.c               | 2 +-
 tests/unit/test-resv-mem.c                | 2 +-
 ui/console.c                              | 2 +-
 util/vfio-helpers.c                       | 2 +-
 MAINTAINERS                               | 2 +-
 docs/devel/memory.rst                     | 2 +-
 scripts/analyze-inclusions                | 2 +-
 155 files changed, 160 insertions(+), 161 deletions(-)
 rename include/{exec => system}/memory.h (99%)

diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index 192821f6aa..b11b3a3379 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -1,7 +1,7 @@
 #ifndef STRONGARM_H
 #define STRONGARM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "target/arm/cpu-qom.h"
 
 #define SA_CS0          0x00000000
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3900cdbabb..a8b1d1efc0 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -9,7 +9,7 @@
 #define QEMU_APPLE_GFX_H
 
 #include "qemu/queue.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-properties.h"
 #include "ui/surface.h"
 
diff --git a/hw/display/framebuffer.h b/hw/display/framebuffer.h
index 38fa0dcec6..29a828ce7a 100644
--- a/hw/display/framebuffer.h
+++ b/hw/display/framebuffer.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_FRAMEBUFFER_H
 #define QEMU_FRAMEBUFFER_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 /* Framebuffer device helper routines.  */
 
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index f77c1c1145..60ad26e03e 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -27,7 +27,7 @@
 
 #include "ui/console.h"
 #include "exec/ioport.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #include "hw/display/bochs-vbe.h"
 #include "hw/acpi/acpi_aml_interface.h"
diff --git a/hw/hyperv/hv-balloon-our_range_memslots.h b/hw/hyperv/hv-balloon-our_range_memslots.h
index df3b686bc7..b1f19d77da 100644
--- a/hw/hyperv/hv-balloon-our_range_memslots.h
+++ b/hw/hyperv/hv-balloon-our_range_memslots.h
@@ -11,7 +11,7 @@
 #define HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
 
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 #include "hv-balloon-page_range_tree.h"
 
diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
index 37b8565539..51205767f4 100644
--- a/hw/intc/ioapic_internal.h
+++ b/hw/intc/ioapic_internal.h
@@ -22,7 +22,7 @@
 #ifndef HW_INTC_IOAPIC_INTERNAL_H
 #define HW_INTC_IOAPIC_INTERNAL_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/intc/ioapic.h"
 #include "hw/sysbus.h"
 #include "qemu/notify.h"
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index f0bbe810eb..4bdfcaf856 100644
--- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -3,7 +3,7 @@
 
 #define I82596_IOPORT_SIZE       0x20
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 
 #define PORT_RESET              0x00    /* reset 82596 */
diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index eb7f46aab3..a94356ec30 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -7,7 +7,7 @@
 #define PCNET_LOOPTEST_CRC      1
 #define PCNET_LOOPTEST_NOCRC    2
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/irq.h"
 
 /* BUS CONFIGURATION REGISTERS */
diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index bf5d4a300f..88f316ee95 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -12,7 +12,7 @@
 #ifndef TPM_TPM_PPI_H
 #define TPM_TPM_PPI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef struct TPMPPI {
     MemoryRegion ram;
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h
index 6d26b94e92..d4664297cf 100644
--- a/hw/usb/hcd-uhci.h
+++ b/hw/usb/hcd-uhci.h
@@ -28,7 +28,7 @@
 #ifndef HW_USB_HCD_UHCI_H
 #define HW_USB_HCD_UHCI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/timer.h"
 #include "hw/pci/pci_device.h"
 #include "hw/usb.h"
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d94ecaba68..6c59300248 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -12,7 +12,7 @@
 #ifndef HW_VFIO_VFIO_PCI_H
 #define HW_VFIO_VFIO_PCI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-common.h"
 #include "qemu/event_notifier.h"
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 0c4ba5abd5..08f63b61cd 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -11,7 +11,7 @@
 #define HW_VIRTIO_VHOST_IOVA_TREE_H
 
 #include "qemu/iova-tree.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef struct VhostIOVATree VhostIOVATree;
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 33b9dc81eb..4395fd08af 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -22,11 +22,14 @@
 #include "exec/page-protection.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
-#include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
+#ifndef CONFIG_USER_ONLY
+#include "system/memory.h"
+#endif
+
 
 CPUArchState *cpu_copy(CPUArchState *env);
 
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 4397f12f93..ecea3575bc 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -24,7 +24,7 @@
 #ifndef IOPORT_H
 #define IOPORT_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define MAX_IOPORTS     (64 * 1024)
 #define IOPORTS_MASK    (MAX_IOPORTS - 1)
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 92e8708af7..8677761af5 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -26,7 +26,7 @@
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/target_page.h"
 #include "qemu/rcu.h"
 
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index d1a4fa2af8..4b8ee094c4 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/notify.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/acpi/acpi_dev_interface.h"
 
 /*
diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 2562a7cf39..b3c3f69451 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -10,7 +10,7 @@
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "migration/vmstate.h"
 
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every tick */
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index df2f83980f..b68d4334a0 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,7 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index 40c593a5cf..41232a2237 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,7 +25,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/watchdog/wdt_imx2.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 9da32fc189..124bbd478f 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -34,7 +34,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/or-irq.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 8277b0e8b2..4e3209b25b 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -33,7 +33,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 7cb87ea89c..6185507373 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,7 +20,7 @@
 #ifndef HW_ARM_OMAP_H
 #define HW_ARM_OMAP_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index c243fb0e7f..c2fae6e23f 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -24,7 +24,7 @@
 #ifndef HW_ARM_STM32L4x5_SOC_H
 #define HW_ARM_STM32L4x5_SOC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/arm/armv7m.h"
 #include "hw/or-irq.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
diff --git a/include/hw/boards.h b/include/hw/boards.h
index bfe8643a27..8556e01e21 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -3,7 +3,7 @@
 #ifndef HW_BOARDS_H
 #define HW_BOARDS_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "system/hostmem.h"
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index cfb97cc7cc..7b04478226 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,7 +1,7 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/isa/isa.h"
 #include "hw/irq.h"
 #include "chardev/char-fe.h"
diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
index df493fdf6b..ee0ca29902 100644
--- a/include/hw/char/riscv_htif.h
+++ b/include/hw/char/riscv_htif.h
@@ -22,7 +22,7 @@
 
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define TYPE_HTIF_UART "riscv.htif.uart"
 
diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
index 62a8489d69..77abd098e0 100644
--- a/include/hw/char/serial-mm.h
+++ b/include/hw/char/serial-mm.h
@@ -27,7 +27,7 @@
 #define HW_SERIAL_MM_H
 
 #include "hw/char/serial.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "chardev/char.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 942b372df6..4bf90a46f3 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -27,7 +27,7 @@
 #define HW_SERIAL_H
 
 #include "chardev/char-fe.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
 
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 27cebefc9e..0fae1f33a6 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -13,7 +13,7 @@
 #ifndef MACFB_H
 #define MACFB_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/irq.h"
 #include "hw/nubus/nubus.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/fsi/aspeed_apb2opb.h b/include/hw/fsi/aspeed_apb2opb.h
index f6a2387abf..878619eafa 100644
--- a/include/hw/fsi/aspeed_apb2opb.h
+++ b/include/hw/fsi/aspeed_apb2opb.h
@@ -8,7 +8,7 @@
 #ifndef FSI_ASPEED_APB2OPB_H
 #define FSI_ASPEED_APB2OPB_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/fsi/fsi-master.h"
 #include "hw/sysbus.h"
 
diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
index 7abc3b287b..cceb4bd6f1 100644
--- a/include/hw/fsi/cfam.h
+++ b/include/hw/fsi/cfam.h
@@ -7,7 +7,7 @@
 #ifndef FSI_CFAM_H
 #define FSI_CFAM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/lbus.h"
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index 68e5f56db2..b634ecd393 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -7,7 +7,7 @@
 #ifndef FSI_FSI_MASTER_H
 #define FSI_FSI_MASTER_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/cfam.h"
diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
index e00f6ef078..f34765ed80 100644
--- a/include/hw/fsi/fsi.h
+++ b/include/hw/fsi/fsi.h
@@ -7,7 +7,7 @@
 #ifndef FSI_FSI_H
 #define FSI_FSI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "hw/fsi/lbus.h"
 #include "qemu/bitops.h"
diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
index 558268c013..12519073cd 100644
--- a/include/hw/fsi/lbus.h
+++ b/include/hw/fsi/lbus.h
@@ -9,7 +9,7 @@
 
 #include "hw/qdev-core.h"
 #include "qemu/units.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
 OBJECT_DECLARE_SIMPLE_TYPE(FSILBusDevice, FSI_LBUS_DEVICE)
diff --git a/include/hw/gpio/npcm7xx_gpio.h b/include/hw/gpio/npcm7xx_gpio.h
index b1d771bd77..7c0bf61a96 100644
--- a/include/hw/gpio/npcm7xx_gpio.h
+++ b/include/hw/gpio/npcm7xx_gpio.h
@@ -15,7 +15,7 @@
 #ifndef NPCM7XX_GPIO_H
 #define NPCM7XX_GPIO_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 
 /* Number of pins managed by each controller. */
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index dc45963c0e..9c544c561b 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_SMBUS_H
 #define NPCM7XX_SMBUS_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 0d74207efb..dafe0df4f6 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -1,7 +1,7 @@
 #ifndef PM_SMBUS_H
 #define PM_SMBUS_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/i2c/smbus_master.h"
 
 #define PM_SMBUS_MAX_MSG_SIZE 32
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index d6e85833da..429278da61 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -22,7 +22,7 @@
 #define QEMU_APIC_INTERNAL_H
 
 #include "cpu.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/timer.h"
 #include "target/i386/cpu-qom.h"
 #include "qom/object.h"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..258b1343a1 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -18,7 +18,7 @@
 #define HW_I386_X86_H
 
 #include "exec/hwaddr.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #include "hw/boards.h"
 #include "hw/i386/topology.h"
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index ac0292c634..cd07b87811 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -24,7 +24,7 @@
 #ifndef HW_IDE_AHCI_H
 #define HW_IDE_AHCI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef struct AHCIDevice AHCIDevice;
 
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 802a2febb0..cd581aa134 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -25,7 +25,7 @@
 #ifndef HW_IPMI_H
 #define HW_IPMI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index b6e070c00e..0834539045 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -1,7 +1,7 @@
 #ifndef APM_H
 #define APM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define APM_CNT_IOPORT  0xb2
 #define ACPI_PORT_SMI_CMD APM_CNT_IOPORT
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 40d6224a4e..1d852011b3 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -3,7 +3,7 @@
 
 /* ISA bus */
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ioport.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 34365c9860..9caaed9692 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -26,7 +26,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 #include "target/m68k/cpu-qom.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
index 7ed38be243..568cc35fdd 100644
--- a/include/hw/mem/npcm7xx_mc.h
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_MC_H
 #define NPCM7XX_MC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 
 /**
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index fe0f3ea963..e0dbdd43dc 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -16,7 +16,7 @@
 #ifndef QEMU_PC_DIMM_H
 #define QEMU_PC_DIMM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 101799f7d3..1f3672ba5f 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -7,7 +7,7 @@
 /* Kernels can be configured with 64KB pages */
 #define INITRD_PAGE_SIZE (64 * KiB)
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 /* bonito.c */
 PCIBus *bonito_init(qemu_irq *pic);
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 03cacdee42..ccd18ce209 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -25,7 +25,7 @@
 #ifndef HW_MISC_AUXBUS_H
 #define HW_MISC_AUXBUS_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 0c2b015781..09bc3abcad 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -14,7 +14,7 @@
 #include "qemu/queue.h"
 #include "qemu/event_notifier.h"
 #include "chardev/char-fe.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 #include "hw/sysbus.h"
 
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 63cdcf7c69..6a15228150 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -9,7 +9,7 @@
 #ifndef HW_MISC_MAC_VIA_H
 #define HW_MISC_MAC_VIA_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 #include "hw/misc/mos6522.h"
 #include "hw/input/adb.h"
diff --git a/include/hw/misc/npcm7xx_mft.h b/include/hw/misc/npcm7xx_mft.h
index d6384382ce..e4b997a6ad 100644
--- a/include/hw/misc/npcm7xx_mft.h
+++ b/include/hw/misc/npcm7xx_mft.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_MFT_H
 #define NPCM7XX_MFT_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/clock.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index 8fa1e14bdd..52e972f460 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -16,7 +16,7 @@
 #ifndef NPCM_CLK_H
 #define NPCM_CLK_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/clock.h"
 #include "hw/sysbus.h"
 
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index d81bb9afb2..702e7fddb1 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -16,7 +16,7 @@
 #ifndef NPCM_GCR_H
 #define NPCM_GCR_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 049a94c112..5098693437 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -15,7 +15,7 @@
 #ifndef HW_MISC_PVPANIC_H
 #define HW_MISC_PVPANIC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 
 #include "standard-headers/misc/pvpanic.h"
diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
index 4a3f7478be..24273dc1f4 100644
--- a/include/hw/net/dp8393x.h
+++ b/include/hw/net/dp8393x.h
@@ -22,7 +22,7 @@
 
 #include "hw/sysbus.h"
 #include "net/net.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define SONIC_REG_COUNT  0x40
 
diff --git a/include/hw/net/msf2-emac.h b/include/hw/net/msf2-emac.h
index 846ba6e6dc..b5d9127e46 100644
--- a/include/hw/net/msf2-emac.h
+++ b/include/hw/net/msf2-emac.h
@@ -23,7 +23,7 @@
  */
 
 #include "hw/sysbus.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "qom/object.h"
diff --git a/include/hw/nvram/mac_nvram.h b/include/hw/nvram/mac_nvram.h
index 0c4dfaeff6..e9d8398f84 100644
--- a/include/hw/nvram/mac_nvram.h
+++ b/include/hw/nvram/mac_nvram.h
@@ -26,7 +26,7 @@
 #ifndef MAC_NVRAM_H
 #define MAC_NVRAM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 
 #define MACIO_NVRAM_SIZE 0x2000
diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
index ea4b5d0731..77b05f8b82 100644
--- a/include/hw/nvram/npcm7xx_otp.h
+++ b/include/hw/nvram/npcm7xx_otp.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_OTP_H
 #define NPCM7XX_OTP_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 
 /* Each OTP module holds 8192 bits of one-time programmable storage */
diff --git a/include/hw/pci-host/fsl_imx8m_phy.h b/include/hw/pci-host/fsl_imx8m_phy.h
index 4f4875b37d..5f1b212fd9 100644
--- a/include/hw/pci-host/fsl_imx8m_phy.h
+++ b/include/hw/pci-host/fsl_imx8m_phy.h
@@ -11,7 +11,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define TYPE_FSL_IMX8M_PCIE_PHY "fsl-imx8m-pcie-phy"
 OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mPciePhyState, FSL_IMX8M_PCIE_PHY)
diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index 005916f826..44f3908160 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -50,7 +50,7 @@
  * 0xf0000 - 0xfffff System BIOS Area Memory Segments
  */
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define SMRAM_C_BASE    0xa0000
 #define SMRAM_C_END     0xc0000
diff --git a/include/hw/pci-host/remote.h b/include/hw/pci-host/remote.h
index 690a01f0fe..5264c35936 100644
--- a/include/hw/pci-host/remote.h
+++ b/include/hw/pci-host/remote.h
@@ -11,7 +11,7 @@
 #ifndef PCI_HOST_REMOTE_H
 #define PCI_HOST_REMOTE_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/pci/pcie_host.h"
 
 #define TYPE_REMOTE_PCIHOST "remote-pcihost"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 822fbacdf0..c2fe6caa2c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_PCI_H
 #define QEMU_PCI_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "system/dma.h"
 #include "system/host_iommu_device.h"
 
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index 82d92177da..f09de76bfe 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -22,7 +22,7 @@
 #define PCIE_HOST_H
 
 #include "hw/pci/pci_host.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 
 #define TYPE_PCIE_HOST_BRIDGE "pcie-host-bridge"
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index a0789df153..ad1089567a 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -1,7 +1,7 @@
 #ifndef SHPC_H
 #define SHPC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/hotplug.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 672c2be471..896ee4a2b1 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -23,7 +23,7 @@
 #ifndef HW_MAC_DBDMA_H
 #define HW_MAC_DBDMA_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/iov.h"
 #include "system/dma.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 174add4c53..266d56214f 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_LPC_H
 #define PPC_PNV_LPC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/ppc/pnv.h"
 #include "hw/qdev-core.h"
 #include "hw/isa/isa.h" /* For ISA_NUM_IRQS */
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 3ec42de0ff..013ea2e53e 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_OCC_H
 #define PPC_PNV_OCC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 
 #define TYPE_PNV_OCC "pnv-occ"
diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
index b6b378ad14..48a8b86a80 100644
--- a/include/hw/ppc/pnv_sbe.h
+++ b/include/hw/ppc/pnv_sbe.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_SBE_H
 #define PPC_PNV_SBE_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 
 #define TYPE_PNV_SBE "pnv-sbe"
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index a927aea1c0..b14549db70 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_XSCOM_H
 #define PPC_PNV_XSCOM_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef struct PnvXScomInterface PnvXScomInterface;
 typedef struct PnvChip PnvChip;
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 1bd9b8821b..2e94b00673 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -26,7 +26,7 @@
 #define PPC4XX_H
 
 #include "hw/ppc/ppc.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 
 /*
diff --git a/include/hw/ppc/vof.h b/include/hw/ppc/vof.h
index d3f293da8b..2918aaab12 100644
--- a/include/hw/ppc/vof.h
+++ b/include/hw/ppc/vof.h
@@ -8,7 +8,7 @@
 
 #include "qom/object.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/cpu-defs.h"
 
 typedef struct Vof {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e94d53405f..097fcdf00f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -28,7 +28,7 @@
 #ifndef XICS_H
 #define XICS_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
diff --git a/include/hw/register.h b/include/hw/register.h
index 6a076cfcdf..a913c52aee 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -12,7 +12,7 @@
 #define REGISTER_H
 
 #include "hw/qdev-core.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/registerfields.h"
 #include "qom/object.h"
 
diff --git a/include/hw/remote/proxy-memory-listener.h b/include/hw/remote/proxy-memory-listener.h
index c4f3efb928..ec516d8267 100644
--- a/include/hw/remote/proxy-memory-listener.h
+++ b/include/hw/remote/proxy-memory-listener.h
@@ -9,7 +9,7 @@
 #ifndef PROXY_MEMORY_LISTENER_H
 #define PROXY_MEMORY_LISTENER_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "io/channel.h"
 
 typedef struct ProxyMemoryListener {
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index f62d5c5e13..94f183121e 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,7 +1,7 @@
 #ifndef SH_INTC_H
 #define SH_INTC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef unsigned char intc_enum;
 
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 6c60017024..1e231e89c9 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -7,7 +7,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
 
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 81bbda10d3..7dc88aaa27 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -4,7 +4,7 @@
 /* Devices attached directly to the main system bus.  */
 
 #include "hw/qdev-core.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 
 #define QDEV_MAX_MMIO 32
diff --git a/include/hw/timer/npcm7xx_timer.h b/include/hw/timer/npcm7xx_timer.h
index d45c051b56..e287375dce 100644
--- a/include/hw/timer/npcm7xx_timer.h
+++ b/include/hw/timer/npcm7xx_timer.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_TIMER_H
 #define NPCM7XX_TIMER_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 
diff --git a/include/hw/tricore/tricore.h b/include/hw/tricore/tricore.h
index c19ed3f013..4ffc0fe1d6 100644
--- a/include/hw/tricore/tricore.h
+++ b/include/hw/tricore/tricore.h
@@ -1,7 +1,7 @@
 #ifndef HW_TRICORE_H
 #define HW_TRICORE_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 struct tricore_boot_info {
     uint64_t ram_size;
diff --git a/include/hw/usb.h b/include/hw/usb.h
index e410693d0c..26a9f3ecde 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -25,7 +25,7 @@
  * THE SOFTWARE.
  */
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 04b123a6c9..f5b3f45a43 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -21,7 +21,7 @@
 #ifndef HW_VFIO_VFIO_COMMON_H
 #define HW_VFIO_VFIO_COMMON_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/queue.h"
 #include "qemu/notify.h"
 #include "ui/console.h"
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab..6aca02fb3d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -13,7 +13,7 @@
 #ifndef HW_VFIO_VFIO_CONTAINER_BASE_H
 #define HW_VFIO_VFIO_CONTAINER_BASE_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOIOMMUClass VFIOIOMMUClass;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 70c2e8ffee..d6df209a2f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -11,7 +11,7 @@
 #ifndef VHOST_BACKEND_H
 #define VHOST_BACKEND_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE = 0,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a9469d50bc..bb4b58e115 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,7 +3,7 @@
 
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #define VHOST_F_DEVICE_IOTLB 63
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6386910280..7e0c471ea4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_VIRTIO_H
 #define QEMU_VIRTIO_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 17c5a58a5a..5db83d88ec 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -9,7 +9,7 @@
 #ifndef XEN_PVH_COMMON_H__
 #define XEN_PVH_COMMON_H__
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 #include "hw/boards.h"
 #include "hw/pci-host/gpex.h"
diff --git a/include/hw/xtensa/mx_pic.h b/include/hw/xtensa/mx_pic.h
index 500424c8d3..cd316d86eb 100644
--- a/include/hw/xtensa/mx_pic.h
+++ b/include/hw/xtensa/mx_pic.h
@@ -28,7 +28,7 @@
 #ifndef XTENSA_MX_PIC_H
 #define XTENSA_MX_PIC_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 struct XtensaMxPic;
 typedef struct XtensaMxPic XtensaMxPic;
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 16d354a814..14e82a22d5 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -23,7 +23,7 @@
  * for the thread safety issue.
  */
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/hwaddr.h"
 
 #define  IOVA_OK           (0)
diff --git a/include/qemu/reserved-region.h b/include/qemu/reserved-region.h
index 8e6f0a97e2..9026cf08fd 100644
--- a/include/qemu/reserved-region.h
+++ b/include/qemu/reserved-region.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_RESERVED_REGION_H
 #define QEMU_RESERVED_REGION_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 /*
  * Insert a new region into a sorted list of reserved regions. In case
diff --git a/include/system/dma.h b/include/system/dma.h
index e142f7efa6..aaa03b9711 100644
--- a/include/system/dma.h
+++ b/include/system/dma.h
@@ -10,7 +10,7 @@
 #ifndef DMA_H
 #define DMA_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "block/block.h"
 #include "block/accounting.h"
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 62642e602c..88fa791ac7 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -16,7 +16,7 @@
 #include "system/numa.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/bitmap.h"
 #include "qemu/thread-context.h"
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 4de6106869..756a3c0a25 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
 #include "qemu/queue.h"
diff --git a/include/exec/memory.h b/include/system/memory.h
similarity index 99%
rename from include/exec/memory.h
rename to include/system/memory.h
index 2f84a7cfed..fbbf4cf911 100644
--- a/include/exec/memory.h
+++ b/include/system/memory.h
@@ -11,10 +11,8 @@
  *
  */
 
-#ifndef MEMORY_H
-#define MEMORY_H
-
-#ifndef CONFIG_USER_ONLY
+#ifndef SYSTEM_MEMORY_H
+#define SYSTEM_MEMORY_H
 
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
@@ -3197,5 +3195,3 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
 void ram_block_del_cpr_blocker(RAMBlock *rb);
 
 #endif
-
-#endif
diff --git a/include/system/vhost-user-backend.h b/include/system/vhost-user-backend.h
index 327b0b84f1..5ed953cd53 100644
--- a/include/system/vhost-user-backend.h
+++ b/include/system/vhost-user-backend.h
@@ -13,7 +13,7 @@
 #define QEMU_VHOST_USER_BACKEND_H
 
 #include "qom/object.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/option.h"
 #include "qemu/bitmap.h"
 #include "hw/virtio/vhost.h"
diff --git a/migration/rdma.h b/migration/rdma.h
index f55f28bbed..4d3386b84a 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -19,7 +19,7 @@
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
 
-#include "exec/memory.h"
+#include "system/memory.h"
 
 void rdma_start_outgoing_migration(void *opaque, InetSocketAddress *host_port,
                                    Error **errp);
diff --git a/rust/wrapper.h b/rust/wrapper.h
index d4fec54657..94866b7e32 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -52,7 +52,7 @@ typedef enum memory_order {
 #include "qemu-io.h"
 #include "system/system.h"
 #include "hw/sysbus.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "chardev/char-fe.h"
 #include "hw/clock.h"
 #include "hw/qdev-clock.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 9862705c6a..b0518a1f60 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,7 +23,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 #ifdef CONFIG_USER_ONLY
 #error "AVR 8-bit does not support user mode"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 254e4fbdcd..02ef6ddecb 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -14,7 +14,7 @@
 #include "hw/registerfields.h"
 #include "qemu/timer.h"
 #ifndef CONFIG_USER_ONLY
-#include "exec/memory.h"
+#include "system/memory.h"
 #endif
 #include "cpu-csr.h"
 #include "cpu-qom.h"
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..9ef72a95d7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -4,7 +4,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #ifndef CONFIG_USER_ONLY
-#include "exec/memory.h"
+#include "system/memory.h"
 #endif
 #include "fpu/softfloat-types.h"
 #include "hw/clock.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 951e8214e0..9e06a95f75 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -33,7 +33,7 @@
 #include "system/cpus.h"
 #include "system/accel-blocker.h"
 #include "qemu/bswap.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ram_addr.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2817c9dbdd..6f0ea9067b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -22,7 +22,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index f07a2656ce..f2d1739e33 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "tpm_int.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/qdev-properties.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
diff --git a/block/blkio.c b/block/blkio.c
index 5f4fce2b1b..4142673984 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include <blkio.h>
 #include "block/block_int.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/cpu-common.h" /* for qemu_ram_get_fd() */
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
@@ -19,7 +19,7 @@
 #include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "system/block-backend.h"
-#include "exec/memory.h" /* for ram_block_discard_disable() */
+#include "system/memory.h" /* for ram_block_discard_disable() */
 
 #include "block/block-io.h"
 
diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 37bf16ac79..9c693618c2 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "disas-internal.h"
 #include "disas/disas.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/core/cpu.h"
 #include "monitor/monitor.h"
 
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index ec64f92893..5c4c1dc638 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/qdev-core.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
 #include "qom/object_interfaces.h"
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 11fab184de..cb721c96b7 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "system/system.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 381b492aec..4955e478cd 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/sysbus.h"
 #include "hw/block/fdc.h"
 #include "migration/vmstate.h"
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index aed5076ec7..5ef8c24b5b 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "exec/cputlb.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/tb-flush.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 6eb66406b0..2dea485ae0 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
 #include "qemu/cutils.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2e35f0aa90..a3aa62d132 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -59,7 +59,7 @@
 #include "uboot_image.h"
 #include "hw/loader.h"
 #include "hw/nvram/fw_cfg.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
 #include "system/runstate.h"
diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
index 675429dc18..f1596fba9a 100644
--- a/hw/display/edid-region.c
+++ b/hw/display/edid-region.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/display/edid.h"
 
 static uint64_t edid_region_read(void *ptr, hwaddr addr, unsigned size)
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 831e04f214..382c62d668 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "system/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 0cc2919bb8..7bd08067a7 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 279da6b4aa..bc6571778c 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -24,7 +24,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/acpi/aml-build.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dbb59df64f..0dce512f18 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -47,7 +47,7 @@
 #include "hw/i386/kvm/clock.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/acpi/acpi.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 5e3cbeabec..12d3908938 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "kvm_mips.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 42af4567c6..169baf2ded 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -13,7 +13,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 
 #define TYPE_OR1K_OMPIC "or1k-ompic"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index b482c5f3af..b1923c8c3e 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qemu/module.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 0a91a8ae6c..4931ea24f6 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -28,7 +28,7 @@
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
 #include "hw/qdev-properties.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/hotplug.h"
 #include "qom/object.h"
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index bfb25ef6af..be077d075e 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -28,7 +28,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/remote.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 static const char *remote_pcihost_root_bus_path(PCIHostState *host_bridge,
                                                 PCIBus *rootbus)
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 18a53a80c1..0521f9a428 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "system/cpus.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7dc3b309c8..a070de23cf 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -24,7 +24,7 @@
 #include "exec/page-protection.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "ppc440.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
index 7c56aad0fc..ec845d1f58 100644
--- a/hw/remote/iommu.c
+++ b/hw/remote/iommu.c
@@ -13,7 +13,7 @@
 #include "hw/remote/iommu.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fdc6c441bb..d4616025e8 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/remote/machine.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_host.h"
 #include "hw/remote/iohub.h"
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index a926f61ebe..ce7f5b9bfb 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -10,7 +10,7 @@
 
 #include "qemu/int128.h"
 #include "qemu/range.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/cpu-common.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 6e51a92856..9bdd0a465b 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -57,7 +57,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "qemu/timer.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/remote/vfio-user-obj.h"
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8cdeb6cb7f..b4e003c19c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/memop.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
 #include "hw/boards.h"
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 7788939766..d4fa32c9d6 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1a0d9290f8..989c6ee83d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -28,7 +28,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7c57bdd27b..1d1c5f9a77 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -24,7 +24,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 67bc57409c..96c6bf5654 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 1cea29c66d..49d17e7bb2 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -32,7 +32,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b08404fc17..b10866ccd8 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -33,7 +33,7 @@
 #include "hw/pci-host/gpex.h"
 #include "net/net.h"
 #include "elf.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
index 2c1095f017..13a6077d86 100644
--- a/hw/xtensa/xtensa_memory.c
+++ b/hw/xtensa/xtensa_memory.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
 
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3f3677f1c9..3bd0ef8268 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -34,7 +34,7 @@
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/tswap.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 4cd14779d6..09caf92f87 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -27,7 +27,7 @@
 #include "qobject/qdict.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/xxhash.h"
 #include "migration.h"
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb034923..d9603ab603 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -30,7 +30,7 @@
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
 #include <arpa/inet.h>
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..c33200a33f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -48,7 +48,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/error-report.h"
 #include "system/cpus.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/iov.h"
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 239c2a61a4..6654d31406 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "disas/disas.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index 108197683b..e88fab31a5 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 
 void *qemu_ram_get_host_addr(RAMBlock *rb)
 {
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 7dedef8dd4..30cd09f3d1 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -19,7 +19,7 @@
 #include "system/dirtylimit.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/target_page.h"
 #include "hw/boards.h"
 #include "system/kvm.h"
diff --git a/system/ioport.c b/system/ioport.c
index 89daae9d60..2291739039 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/ioport.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 
diff --git a/system/memory.c b/system/memory.c
index eddd21a6cd..2865d0deb1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index 37d3325f77..8538a8241e 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 
 #include "system/memory_mapping.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
 
diff --git a/system/physmem.c b/system/physmem.c
index 333a5eb94d..e61fea41b5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -50,7 +50,7 @@
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "qemu/memfd.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ioport.h"
 #include "system/dma.h"
 #include "system/hostmem.h"
diff --git a/system/qtest.c b/system/qtest.c
index 12152efbcd..5407289154 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -17,7 +17,7 @@
 #include "system/runstate.h"
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
 #include "hw/irq.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7663b62d01..ec6a0a8b66 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -36,7 +36,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-clock.h"
 #ifndef CONFIG_USER_ONLY
-#include "exec/memory.h"
+#include "system/memory.h"
 #endif
 
 
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index d107a496da..239be9372d 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -20,7 +20,7 @@
 #include "tests/qtest/libqos/pci-pc.h"
 #include "fuzz.h"
 #include "string.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "exec/ramblock.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index d3839bf999..9afe8bf6d8 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/main-loop.h"
 
 #include "tests/qtest/libqtest.h"
diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
index cd8f7318cc..4de2d042d1 100644
--- a/tests/unit/test-resv-mem.c
+++ b/tests/unit/test-resv-mem.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/range.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qemu/reserved-region.h"
 
 #define DEBUG 0
diff --git a/ui/console.c b/ui/console.c
index 6456e8dd90..6cd122cf40 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -35,7 +35,7 @@
 #include "qemu/option.h"
 #include "chardev/char.h"
 #include "trace.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "qom/object.h"
 #include "qemu/memfd.h"
 
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index f8bab46c68..fdff042ab4 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
-#include "exec/memory.h"
+#include "system/memory.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "standard-headers/linux/pci_regs.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 04573e2934..5d391cfaa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3120,7 +3120,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/exec/ioport.h
 F: include/exec/memop.h
-F: include/exec/memory.h
+F: include/system/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
 F: include/system/memory_mapping.h
diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 69c5e3f914..57fb2aec76 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -369,4 +369,4 @@ callbacks are called:
 API Reference
 -------------
 
-.. kernel-doc:: include/exec/memory.h
+.. kernel-doc:: include/system/memory.h
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index b6280f25c8..d2c566667d 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -53,7 +53,7 @@ echo $(grep_include -F 'trace/generated-tracers.h') files include generated-trac
 echo $(grep_include -F 'qapi/error.h') files include qapi/error.h
 echo $(grep_include -F 'qom/object.h') files include qom/object.h
 echo $(grep_include -F 'block/aio.h') files include block/aio.h
-echo $(grep_include -F 'exec/memory.h') files include exec/memory.h
+echo $(grep_include -F 'system/memory.h') files include system/memory.h
 echo $(grep_include -F 'fpu/softfloat.h') files include fpu/softfloat.h
 echo $(grep_include -F 'qemu/bswap.h') files include qemu/bswap.h
 echo
-- 
2.43.0


