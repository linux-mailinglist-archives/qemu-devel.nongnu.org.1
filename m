Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D9A5EA3D
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 04:49:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVx-0004ZU-AE; Wed, 12 Mar 2025 23:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0004YT-SF
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVh-0007ZY-3a
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:36 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so1038684a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837526; x=1742442326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zH6a136/g4PqT3TZDZERQZpE19MrcdSzKhuO+JzZS6I=;
 b=BWxit8bH/Mq6KPQvIihFiCMeAbfRWNNWXdrppRwMehJRjcVw69S0SgGbaBgocn3kVu
 hlKLspQHfTAkljz8wjvLsj2VrZAdOnIMNwxowEJi4FAj1hoXovIWWk57SrPUNIGE6+go
 0FxN0KvDRwWlBm1Pp+9HfOy0e0Sa4fhAq+LNfPCOQavmHmF+Q9b02hxp10zIZAw5XxUq
 lzOdrS4ZLEHIevHovxsRaIDvfQlXtzxuvskIcl2lIymFJ6fTslcRPEB3pPy+rtCmt2Nk
 f1xEcMe4yE3f9Ow1AUZLtiJ4RR5Rx64Jwwjy0xwV4XA7nteOLW2PMhCU+zQN+qPAEOds
 GR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837526; x=1742442326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zH6a136/g4PqT3TZDZERQZpE19MrcdSzKhuO+JzZS6I=;
 b=n4ucvDTxQ5ql9CMj7grb85tE6wxisCg9Ckq9EaEeVdnTfS/rJ5/uKnSWjpw2Xpe5Jy
 EpVQBx6pvOVPyCQaGkhBuPxdNwvWnBfrSlKJBRRcWUWZoVVczJuIm28OL5hVP48Uiohi
 zUnxv0iYa5DYkF3+NPhXgjlWb8yfMPJ2rHNd8RUTe44erCV0rvcuDyzBa0jcGm1hdCv+
 ZF6gK/NwLj7RlA1xwbZj7FazNqRwek6KMtf/b+LHtA1QHVZDm9Afz8NEIoGpF+/0Xuu/
 Aw8r9mjM/Z7+bx+rO67v16Sz+L9utxTirFNr6ZhSct3sMZtuMTUHfJpG7cC0LVnNZ6Ac
 a4BQ==
X-Gm-Message-State: AOJu0YxwffOggShPKNo/BZgWfkQ/Uer0FK8PkY8C++cMq0iRGa/D3wFd
 7EvpvPHdOeowCsfWUCE6fpVZ0ChicEvnSYPWghUaLeG38l9cqDVEtYokSGA85VVKmOeXpFM6PCN
 n
X-Gm-Gg: ASbGncv3/yvlldydSyp9C3UaiV6aftHLBL6B0j0oqgi+XXUNHKnEJiJffOvlYH0TW9i
 RHq6mh+PyjJWPzGL/nbnMAdaBkh/zmhMJgee5AV9qVil9kCoQMYYxM0Ts2iHXw0bi3JmIoYMyzP
 k/nMh/4s9FU7tFoP5a6V2e72MV7EjIqtpye6xFOzQDRlKPrQqatS+acHuoXP3w53YZwQ92w28v8
 lrRMP6g/06XiJnLVDI0eeZM+avrnMGHJkJzSMLEdCfvRWrN/N1ZxI2uHinFVy/JQ/UKWgeFZbSC
 TGo7QhQEqD1UUWLAHTZN5ABN2sbxnsalBi0XtfMlZVBPTCDa2mVoVXAl1iH1X8QsMwC+L+sZbY5
 o
X-Google-Smtp-Source: AGHT+IEyywW40BQ6S+iTH21PmxX378LB8vQLPYQNa+mAxwEPTC7cK0KArSpTes1RjWPEY3gl6wxa8Q==
X-Received: by 2002:a05:6a21:3941:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-1f544c7fc7fmr47809671637.36.1741837526058; 
 Wed, 12 Mar 2025 20:45:26 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 00/37] accel/tcg, codebase: Build once patches
Date: Wed, 12 Mar 2025 20:44:40 -0700
Message-ID: <20250313034524.3069690-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All this is working toward building accel/tcg/translator.c once,
but it got late and I decided to stop at a convenient milestone.

In the process, I discovered that we have already added files to
common_ss which indirectly depend on CONFIG_USER_ONLY.  Sometimes
this is harmless, and sometimes it really is not.  For instance,
plugin/api.c is affected by different translation-block.h layout.

The only solution I can see is to poison CONFIG_USER_ONLY outside
of specific contexts.  I hoisted some existing magic in tcg/ and
gdbstub/ to build separate shared_libraries for user and system,
as that's the only way to add extra command-line -Defines.

Ideally, we would reuse the existing user_ss and system_ss source
sets for these new static_libraries.  But in order for that to work,
we'd need to construct the configuration_data sets to apply, and it
wasn't immediately obvious what the correct sets would be.  Getting
that wrong would silently omit files from the build, which could be
hard to diagnose.  I thought it would be quicker and safer to create
new source sets with only unconditional files.

I know there is overlap with other in-flight patches, but it
seemed easiest to just start from master.


r~


Richard Henderson (37):
  accel/tcg: Build user-exec-stub.c once
  accel/tcg: Build plugin-gen.c once
  include/exec: Use vaddr for *_mmu guest memory access routines
  include/exec: Split out cpu-ldst-common.h
  include/exec: Inline *_mmuidx_ra memory operations
  include/exec: Inline *_data_ra memory operations
  include/exec: Inline *_data memory operations
  include/exec: Inline *_code memory operations
  accel/tcg: Perform aligned atomic reads in translator_ld
  accel/tcg: Use cpu_ld*_code_mmu in translator.c
  accel/tcg: Implement translator_ld*_end
  accel/tcg: Remove mmap_lock/unlock from watchpoint.c
  include/exec: Split out mmap-lock.h
  include/system: Move exec/memory.h to system/memory.h
  include/system: Move exec/address-spaces.h to system/address-spaces.h
  include/system: Move exec/ioport.h to system/ioport.h
  meson: Introduce top-level libuser_ss and libsystem_ss
  gdbstub: Move syscalls.c out of common_ss
  accel/tcg: Use libuser_ss and libsystem_ss
  target/mips: Protect semihosting call with CONFIG_SEMIHOSTING
  target/xtensa: Protect semihosting call with CONFIG_SEMIHOSTING
  semihosting: Move user-only implementation out-of-line
  include/system: Move exec/ram_addr.h to system/ram_addr.h
  include/system: Move exec/ramblock.h to system/ramblock.h
  common-user: Split out watchpoint-stub.c
  hw/core: Move unconditional files to libsystem_ss, libuser_ss
  system: Move watchpoint.c to libsystem_ss
  plugins: Move api.c, core.c to libuser_ss, libsystem_ss
  include/exec: Split out cpu-mmu-index.h
  include/exec: Drop ifndef CONFIG_USER_ONLY from cpu-common.h
  include/hw/core: Drop ifndef CONFIG_USER_ONLY from cpu.h
  include/hw/intc: Remove ifndef CONFIG_USER_ONLY from armv7m_nvic.h
  include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in css.h
  include/system: Remove ifndef CONFIG_USER_ONLY
  include/qemu: Remove ifndef CONFIG_USER_ONLY from accel.h
  target/riscv: Remove ifndef CONFIG_USER_ONLY from cpu_cfg.h
  meson: Only allow CONFIG_USER_ONLY from certain source sets

 accel/tcg/atomic_template.h                 |  16 +-
 accel/tcg/internal-target.h                 |   1 +
 hw/arm/strongarm.h                          |   2 +-
 hw/display/apple-gfx.h                      |   2 +-
 hw/display/framebuffer.h                    |   2 +-
 hw/display/vga_int.h                        |   4 +-
 hw/hyperv/hv-balloon-our_range_memslots.h   |   2 +-
 hw/intc/ioapic_internal.h                   |   2 +-
 hw/net/i82596.h                             |   4 +-
 hw/net/pcnet.h                              |   2 +-
 hw/s390x/ipl.h                              |   2 +-
 hw/tpm/tpm_ppi.h                            |   2 +-
 hw/usb/hcd-uhci.h                           |   2 +-
 hw/vfio/pci.h                               |   2 +-
 hw/virtio/vhost-iova-tree.h                 |   2 +-
 include/exec/cpu-all.h                      |   9 +-
 include/exec/cpu-common.h                   |  26 -
 include/exec/cpu-ldst-common.h              | 122 +++++
 include/exec/cpu-mmu-index.h                |  33 ++
 include/exec/cpu_ldst.h                     | 540 +++++++++++++-------
 include/exec/mmap-lock.h                    |  33 ++
 include/exec/page-protection.h              |  22 -
 include/exec/poison.h                       |   5 +
 include/exec/translator.h                   |  50 +-
 include/hw/acpi/acpi.h                      |   2 +-
 include/hw/acpi/ich9_tco.h                  |   2 +-
 include/hw/arm/fsl-imx25.h                  |   2 +-
 include/hw/arm/fsl-imx31.h                  |   2 +-
 include/hw/arm/fsl-imx6.h                   |   2 +-
 include/hw/arm/fsl-imx6ul.h                 |   2 +-
 include/hw/arm/omap.h                       |   2 +-
 include/hw/arm/stm32l4x5_soc.h              |   2 +-
 include/hw/boards.h                         |   2 +-
 include/hw/char/parallel-isa.h              |   2 +-
 include/hw/char/parallel.h                  |   2 +-
 include/hw/char/riscv_htif.h                |   2 +-
 include/hw/char/serial-mm.h                 |   2 +-
 include/hw/char/serial.h                    |   2 +-
 include/hw/core/cpu.h                       |  33 --
 include/hw/display/macfb.h                  |   2 +-
 include/hw/dma/i8257.h                      |   2 +-
 include/hw/fsi/aspeed_apb2opb.h             |   2 +-
 include/hw/fsi/cfam.h                       |   2 +-
 include/hw/fsi/fsi-master.h                 |   2 +-
 include/hw/fsi/fsi.h                        |   2 +-
 include/hw/fsi/lbus.h                       |   2 +-
 include/hw/gpio/npcm7xx_gpio.h              |   2 +-
 include/hw/hw.h                             |   4 -
 include/hw/i2c/npcm7xx_smbus.h              |   2 +-
 include/hw/i2c/pm_smbus.h                   |   2 +-
 include/hw/i386/apic_internal.h             |   2 +-
 include/hw/i386/x86.h                       |   2 +-
 include/hw/ide/ahci.h                       |   2 +-
 include/hw/ide/ide-bus.h                    |   2 +-
 include/hw/intc/armv7m_nvic.h               |  14 -
 include/hw/ipmi/ipmi.h                      |   2 +-
 include/hw/isa/apm.h                        |   2 +-
 include/hw/isa/isa.h                        |   4 +-
 include/hw/m68k/q800.h                      |   2 +-
 include/hw/mem/npcm7xx_mc.h                 |   2 +-
 include/hw/mem/pc-dimm.h                    |   2 +-
 include/hw/mips/mips.h                      |   2 +-
 include/hw/misc/auxbus.h                    |   2 +-
 include/hw/misc/ivshmem-flat.h              |   2 +-
 include/hw/misc/lasi.h                      |   2 +-
 include/hw/misc/mac_via.h                   |   2 +-
 include/hw/misc/npcm7xx_mft.h               |   2 +-
 include/hw/misc/npcm_clk.h                  |   2 +-
 include/hw/misc/npcm_gcr.h                  |   2 +-
 include/hw/misc/pvpanic.h                   |   2 +-
 include/hw/net/dp8393x.h                    |   2 +-
 include/hw/net/msf2-emac.h                  |   2 +-
 include/hw/nubus/nubus.h                    |   2 +-
 include/hw/nvram/mac_nvram.h                |   2 +-
 include/hw/nvram/npcm7xx_otp.h              |   2 +-
 include/hw/pci-host/fsl_imx8m_phy.h         |   2 +-
 include/hw/pci-host/pam.h                   |   2 +-
 include/hw/pci-host/remote.h                |   2 +-
 include/hw/pci/pci.h                        |   2 +-
 include/hw/pci/pcie_host.h                  |   2 +-
 include/hw/pci/shpc.h                       |   2 +-
 include/hw/ppc/mac_dbdma.h                  |   2 +-
 include/hw/ppc/pnv_lpc.h                    |   2 +-
 include/hw/ppc/pnv_occ.h                    |   2 +-
 include/hw/ppc/pnv_sbe.h                    |   2 +-
 include/hw/ppc/pnv_xscom.h                  |   2 +-
 include/hw/ppc/ppc4xx.h                     |   2 +-
 include/hw/ppc/vof.h                        |   4 +-
 include/hw/ppc/xics.h                       |   2 +-
 include/hw/register.h                       |   2 +-
 include/hw/remote/proxy-memory-listener.h   |   2 +-
 include/hw/s390x/css.h                      |   2 -
 include/hw/sh4/sh_intc.h                    |   2 +-
 include/hw/southbridge/ich9.h               |   2 +-
 include/hw/sysbus.h                         |   2 +-
 include/hw/timer/npcm7xx_timer.h            |   2 +-
 include/hw/tricore/triboard.h               |   2 +-
 include/hw/tricore/tricore.h                |   2 +-
 include/hw/usb.h                            |   2 +-
 include/hw/vfio/vfio-common.h               |   2 +-
 include/hw/vfio/vfio-container-base.h       |   2 +-
 include/hw/virtio/vhost-backend.h           |   2 +-
 include/hw/virtio/vhost.h                   |   2 +-
 include/hw/virtio/virtio.h                  |   2 +-
 include/hw/xen/xen-pvh-common.h             |   2 +-
 include/hw/xtensa/mx_pic.h                  |   2 +-
 include/qemu/accel.h                        |  10 +-
 include/qemu/iova-tree.h                    |   2 +-
 include/qemu/reserved-region.h              |   2 +-
 include/semihosting/semihost.h              |  29 +-
 include/{exec => system}/address-spaces.h   |   8 +-
 include/system/confidential-guest-support.h |   4 -
 include/system/cpu-timers.h                 |   2 +-
 include/system/dma.h                        |   4 +-
 include/system/hostmem.h                    |   2 +-
 include/{exec => system}/ioport.h           |   8 +-
 include/system/kvm_int.h                    |   2 +-
 include/{exec => system}/memory.h           |   8 +-
 include/system/qtest.h                      |   2 -
 include/{exec => system}/ram_addr.h         |   9 +-
 include/{exec => system}/ramblock.h         |   9 +-
 include/system/replay.h                     |   4 -
 include/system/vhost-user-backend.h         |   2 +-
 include/system/xen.h                        |   4 -
 migration/rdma.h                            |   2 +-
 rust/wrapper.h                              |   4 +-
 target/i386/hvf/vmx.h                       |   2 +-
 target/loongarch/cpu.h                      |   2 +-
 target/mips/cpu.h                           |   2 +-
 target/riscv/cpu_cfg.h                      |   2 -
 accel/hvf/hvf-accel-ops.c                   |   2 +-
 accel/kvm/kvm-all.c                         |   4 +-
 accel/tcg/cpu-exec.c                        |   1 +
 accel/tcg/cputlb.c                          |  40 +-
 accel/tcg/plugin-gen.c                      |  13 +-
 accel/tcg/tb-maint.c                        |   1 +
 accel/tcg/translate-all.c                   |   3 +-
 accel/tcg/translator.c                      | 120 +++--
 accel/tcg/user-exec.c                       |  48 +-
 accel/tcg/watchpoint.c                      |   3 -
 backends/tpm/tpm_util.c                     |   2 +-
 block/blkio.c                               |   4 +-
 common-user/watchpoint-stub.c               |  28 +
 disas/disas-mon.c                           |   2 +-
 hw/acpi/erst.c                              |   4 +-
 hw/arm/aspeed_ast10x0.c                     |   2 +-
 hw/arm/bananapi_m2u.c                       |   2 +-
 hw/arm/collie.c                             |   2 +-
 hw/arm/exynos4_boards.c                     |   2 +-
 hw/arm/fsl-imx31.c                          |   2 +-
 hw/arm/fsl-imx8mp.c                         |   2 +-
 hw/arm/imx8mp-evk.c                         |   2 +-
 hw/arm/integratorcp.c                       |   2 +-
 hw/arm/kzm.c                                |   2 +-
 hw/arm/microbit.c                           |   2 +-
 hw/arm/mps2-tz.c                            |   2 +-
 hw/arm/mps2.c                               |   2 +-
 hw/arm/mps3r.c                              |   2 +-
 hw/arm/msf2-soc.c                           |   2 +-
 hw/arm/msf2-som.c                           |   2 +-
 hw/arm/musca.c                              |   2 +-
 hw/arm/omap1.c                              |   2 +-
 hw/arm/omap_sx1.c                           |   2 +-
 hw/arm/orangepi.c                           |   2 +-
 hw/arm/stellaris.c                          |   2 +-
 hw/arm/stm32f100_soc.c                      |   2 +-
 hw/arm/stm32f205_soc.c                      |   2 +-
 hw/arm/stm32f405_soc.c                      |   2 +-
 hw/arm/stm32l4x5_soc.c                      |   2 +-
 hw/avr/atmega.c                             |   4 +-
 hw/block/fdc-isa.c                          |   2 +-
 hw/block/fdc-sysbus.c                       |   2 +-
 hw/char/goldfish_tty.c                      |   2 +-
 hw/char/omap_uart.c                         |   2 +-
 hw/char/riscv_htif.c                        |   2 +-
 hw/core/cpu-system.c                        |   4 +-
 hw/core/loader-fit.c                        |   2 +-
 hw/core/loader.c                            |   2 +-
 hw/core/null-machine.c                      |   2 +-
 hw/core/sysbus.c                            |   2 +-
 hw/display/edid-region.c                    |   2 +-
 hw/display/virtio-gpu-udmabuf.c             |   2 +-
 hw/dma/rc4030.c                             |   2 +-
 hw/hyperv/hv-balloon.c                      |   4 +-
 hw/hyperv/hyperv.c                          |   4 +-
 hw/i386/acpi-common.c                       |   2 +-
 hw/i386/acpi-microvm.c                      |   2 +-
 hw/i386/kvm/xen_evtchn.c                    |   2 +-
 hw/i386/kvm/xen_gnttab.c                    |   2 +-
 hw/i386/kvm/xen_overlay.c                   |   2 +-
 hw/i386/pc_piix.c                           |   2 +-
 hw/i386/sgx-epc.c                           |   2 +-
 hw/i386/sgx.c                               |   2 +-
 hw/i386/vapic.c                             |   2 +-
 hw/ide/ahci-sysbus.c                        |   2 +-
 hw/input/lasips2.c                          |   2 +-
 hw/intc/loongarch_extioi.c                  |   2 +-
 hw/intc/mips_gic.c                          |   2 +-
 hw/intc/ompic.c                             |   2 +-
 hw/intc/riscv_aplic.c                       |   2 +-
 hw/intc/riscv_imsic.c                       |   2 +-
 hw/loongarch/virt.c                         |   2 +-
 hw/mem/memory-device.c                      |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c         |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c    |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c             |   2 +-
 hw/mips/mipssim.c                           |   2 +-
 hw/misc/allwinner-h3-dramc.c                |   2 +-
 hw/misc/allwinner-r40-dramc.c               |   2 +-
 hw/misc/ivshmem-flat.c                      |   2 +-
 hw/misc/mac_via.c                           |   2 +-
 hw/net/i82596.c                             |   2 +-
 hw/net/ne2000.c                             |   2 +-
 hw/nvram/fw_cfg.c                           |   2 +-
 hw/openrisc/openrisc_sim.c                  |   2 +-
 hw/openrisc/virt.c                          |   2 +-
 hw/pci-bridge/pci_bridge_dev.c              |   2 +-
 hw/pci-host/mv64361.c                       |   2 +-
 hw/pci-host/remote.c                        |   2 +-
 hw/ppc/pegasos2.c                           |   2 +-
 hw/ppc/pnv_homer.c                          |   2 +-
 hw/ppc/pnv_psi.c                            |   2 +-
 hw/ppc/ppc405_uc.c                          |   2 +-
 hw/ppc/ppc4xx_sdram.c                       |   2 +-
 hw/ppc/prep_systemio.c                      |   2 +-
 hw/ppc/rs6000_mc.c                          |   2 +-
 hw/ppc/sam460ex.c                           |   2 +-
 hw/ppc/spapr.c                              |   2 +-
 hw/ppc/spapr_caps.c                         |   2 +-
 hw/ppc/spapr_ovec.c                         |   2 +-
 hw/ppc/spapr_pci.c                          |   2 +-
 hw/ppc/vof.c                                |   2 +-
 hw/remote/iommu.c                           |   4 +-
 hw/remote/machine.c                         |   2 +-
 hw/remote/memory.c                          |   2 +-
 hw/remote/proxy-memory-listener.c           |   4 +-
 hw/remote/vfio-user-obj.c                   |   2 +-
 hw/riscv/microblaze-v-generic.c             |   2 +-
 hw/riscv/opentitan.c                        |   2 +-
 hw/riscv/shakti_c.c                         |   2 +-
 hw/s390x/css.c                              |   2 +-
 hw/s390x/s390-pci-inst.c                    |   2 +-
 hw/s390x/s390-skeys.c                       |   2 +-
 hw/s390x/s390-stattrib-kvm.c                |   2 +-
 hw/s390x/s390-stattrib.c                    |   2 +-
 hw/s390x/s390-virtio-ccw.c                  |   2 +-
 hw/s390x/virtio-ccw.c                       |   2 +-
 hw/sparc/sun4m_iommu.c                      |   2 +-
 hw/sparc64/sun4u_iommu.c                    |   2 +-
 hw/timer/hpet.c                             |   2 +-
 hw/timer/sh_timer.c                         |   2 +-
 hw/tpm/tpm_crb.c                            |   2 +-
 hw/vfio/ap.c                                |   2 +-
 hw/vfio/ccw.c                               |   2 +-
 hw/vfio/common.c                            |   6 +-
 hw/vfio/container.c                         |   6 +-
 hw/vfio/iommufd.c                           |   2 +-
 hw/vfio/migration.c                         |   2 +-
 hw/vfio/platform.c                          |   4 +-
 hw/vfio/spapr.c                             |   4 +-
 hw/virtio/vhost-user.c                      |   2 +-
 hw/virtio/vhost-vdpa.c                      |   2 +-
 hw/virtio/virtio-balloon.c                  |   2 +-
 hw/virtio/virtio-bus.c                      |   2 +-
 hw/virtio/virtio-mem.c                      |   2 +-
 hw/xtensa/sim.c                             |   2 +-
 hw/xtensa/virt.c                            |   2 +-
 hw/xtensa/xtensa_memory.c                   |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 linux-user/arm/cpu_loop.c                   |   1 +
 linux-user/elfload.c                        |   1 +
 linux-user/flatload.c                       |   1 +
 linux-user/mmap.c                           |   1 +
 linux-user/syscall.c                        |   1 +
 migration/dirtyrate.c                       |   4 +-
 migration/file.c                            |   2 +-
 migration/multifd-nocomp.c                  |   2 +-
 migration/multifd-qatzip.c                  |   2 +-
 migration/multifd-qpl.c                     |   2 +-
 migration/multifd-uadk.c                    |   2 +-
 migration/multifd-zero-page.c               |   2 +-
 migration/multifd-zlib.c                    |   2 +-
 migration/multifd-zstd.c                    |   2 +-
 migration/multifd.c                         |   2 +-
 migration/postcopy-ram.c                    |   2 +-
 migration/ram.c                             |   2 +-
 migration/rdma.c                            |   2 +-
 migration/savevm.c                          |   2 +-
 monitor/hmp-cmds-target.c                   |   4 +-
 monitor/hmp-cmds.c                          |   4 +-
 semihosting/uaccess.c                       |   1 +
 semihosting/user.c                          |  30 ++
 stubs/ram-block.c                           |   2 +-
 system/dirtylimit.c                         |   2 +-
 system/ioport.c                             |   6 +-
 system/memory.c                             |   6 +-
 system/memory_mapping.c                     |   4 +-
 system/physmem.c                            |   6 +-
 system/qtest.c                              |   4 +-
 target/arm/gdbstub64.c                      |   3 +
 target/arm/helper.c                         |   1 +
 target/arm/hvf/hvf.c                        |   2 +-
 target/arm/kvm.c                            |   2 +-
 target/arm/tcg/mte_helper.c                 |   2 +-
 target/avr/helper.c                         |   2 +-
 target/hppa/mem_helper.c                    |   1 +
 target/i386/cpu-apic.c                      |   2 +-
 target/i386/cpu.c                           |   2 +-
 target/i386/kvm/xen-emu.c                   |   2 +-
 target/i386/nvmm/nvmm-all.c                 |   4 +-
 target/i386/sev.c                           |   2 +-
 target/i386/tcg/system/misc_helper.c        |   2 +-
 target/i386/tcg/system/tcg-cpu.c            |   2 +-
 target/i386/tcg/translate.c                 |   1 +
 target/i386/whpx/whpx-all.c                 |   4 +-
 target/loongarch/cpu_helper.c               |   1 +
 target/loongarch/kvm/kvm.c                  |   2 +-
 target/microblaze/helper.c                  |   1 +
 target/microblaze/mmu.c                     |   1 +
 target/mips/cpu.c                           |   3 +-
 target/openrisc/translate.c                 |   1 +
 target/ppc/kvm.c                            |   2 +-
 target/riscv/kvm/kvm-cpu.c                  |   2 +-
 target/s390x/kvm/kvm.c                      |   2 +-
 target/s390x/mmu_helper.c                   |   2 +-
 target/s390x/sigp.c                         |   2 +-
 target/s390x/tcg/excp_helper.c              |   2 +-
 target/sparc/cpu.c                          |   1 +
 target/sparc/mmu_helper.c                   |   1 +
 target/tricore/helper.c                     |   1 +
 target/xtensa/cpu.c                         |   2 +-
 target/xtensa/dbg_helper.c                  |   2 +-
 target/xtensa/mmu_helper.c                  |   1 +
 target/xtensa/translate.c                   |  13 +-
 tests/qtest/fuzz/generic_fuzz.c             |   4 +-
 tests/qtest/fuzz/qos_fuzz.c                 |   2 +-
 tests/qtest/fuzz/qtest_wrappers.c           |   2 +-
 tests/unit/test-resv-mem.c                  |   2 +-
 ui/console.c                                |   2 +-
 util/vfio-helpers.c                         |   2 +-
 MAINTAINERS                                 |   8 +-
 accel/tcg/ldst_common.c.inc                 | 335 +-----------
 accel/tcg/meson.build                       |  25 +-
 common-user/meson.build                     |   1 +
 docs/devel/memory.rst                       |   2 +-
 gdbstub/meson.build                         |  36 +-
 hw/core/meson.build                         |   4 +-
 hw/display/apple-gfx.m                      |   2 +-
 meson.build                                 |  24 +
 plugins/meson.build                         |   5 +-
 scripts/analyze-inclusions                  |   2 +-
 semihosting/meson.build                     |   2 +
 system/meson.build                          |   5 +-
 tcg/meson.build                             |  23 +-
 354 files changed, 1211 insertions(+), 1229 deletions(-)
 create mode 100644 include/exec/cpu-ldst-common.h
 create mode 100644 include/exec/cpu-mmu-index.h
 create mode 100644 include/exec/mmap-lock.h
 rename include/{exec => system}/address-spaces.h (89%)
 rename include/{exec => system}/ioport.h (96%)
 rename include/{exec => system}/memory.h (99%)
 rename include/{exec => system}/ram_addr.h (99%)
 rename include/{exec => system}/ramblock.h (96%)
 create mode 100644 common-user/watchpoint-stub.c
 create mode 100644 semihosting/user.c

-- 
2.43.0


