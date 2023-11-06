Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44F7E1A93
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:59:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZF-0004PL-Q4; Mon, 06 Nov 2023 01:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZB-0004OH-Pr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:34 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZ8-0001Ll-Oy
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:33 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so27839665ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253909; x=1699858709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KeMYJHQM7/ImjVKKy4m76NTcCqcWL1+gslhKwwgmT2c=;
 b=sxxlnIuLWzk2hRwB8kUN5irBKpWcS5lMvPKyuKf7H1AeHPLlRRE+lFPONFZQnRR3/F
 uehxoNRO4UYJryeONRo9aqXBrO5HTT685mY8eGwmL9p6cMFj18cjO21FG/J1xRLoQXBL
 FXr+Q+Kw8HfaGeaQ6a/+JYlcYxCzfJTjdwkUKy9/re7Q+gucUzUI0diUSRcn8/sfaD+8
 x255G/r3xTTc4q19gx2EQB/JO8HNxlHa3Oc7tLMTeogYswn57Ra2+L2AgdkB7Md9ceyj
 /ShBCAEpN+on6/FP53pVsArUnyjGOqHXCWoiaKddeSOA0rfr5MIw4a3xvn9h2jRjdilq
 EeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253909; x=1699858709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KeMYJHQM7/ImjVKKy4m76NTcCqcWL1+gslhKwwgmT2c=;
 b=EbuNr2IwC9KpwM60bBqo9q6NfEkMxxagQsck6cFXq00CCoLuRZTJopECKD370gq9cs
 SULXaB8oOxmx+ho2lwgxkZcJeG+/LsvKtI21jFjvnasaj2TYp+jm8fNJRtV75kZEpRKy
 Pa3kvRH3we0cEFVALYfww4S9u/FX+1Kwd81MTiSyn3Ye24zZ3NnkxgPrXdkW518Z3bEz
 fk8VxmxOq7PUSV2O3cwpuemvWN25y8KAzQxXDkL2EHf8erWrApiAzhK1UzA4X0tY810b
 mxRi69y0IV/DPspCRAU88DbWjHAf8qVOPZrcei606qWYqz5Uvw2I6UHJvR9B2fz//rhe
 0MpQ==
X-Gm-Message-State: AOJu0YwLuFIdiTu0B6UNT5RJ2lrUo0pQbgx8sye5RVdOGVkeG5lqAFPk
 8LFyJxWG3xFHExc9v8JBKt1g5jSpZFShg8Gn1WA=
X-Google-Smtp-Source: AGHT+IHP751KNg42sMTVWYfBwHstN+LTv8sX1yH2xBBFBKx5rUHn/RGd2fjLPjsJ8T/mnSamT6d1wg==
X-Received: by 2002:a17:902:7fcf:b0:1cc:1efb:1bab with SMTP id
 t15-20020a1709027fcf00b001cc1efb1babmr20866476plb.38.1699253908987; 
 Sun, 05 Nov 2023 22:58:28 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 00/71] *: Constify VMState
Date: Sun,  5 Nov 2023 22:57:16 -0800
Message-Id: <20231106065827.543129-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Most of this can be done without the first patch.
But with it, we get to constify subsections as well.

For qemu-system-aarch64, this moves 472k from .data to
.data.ro and/or .rodata (mostly depending on -fpie).

For qemu-system-x86_64, 272k.
For qemu-system-ppc64, 267k.


r~


Richard Henderson (71):
  migration: Make VMStateDescription.subsections const
  target/arm: Constify VMState in machine.c
  targt/arm: Constify hvf/hvf.c
  target/alpha: Constify VMState in machine.c
  target/avr: Constify VMState in machine.c
  target/cris: Constify VMState in machine.c
  target/hppa: Constify VMState in machine.c
  target/i386: Constify VMState in machine.c
  target/loongarch: Constify VMState in machine.c
  target/m68k: Constify VMState in machine.c
  target/microblaze: Constify VMState in machine.c
  target/mips: Constify VMState in machine.c
  target/openrisc: Constify VMState in machine.c
  target/ppc: Constify VMState in machine.c
  target/riscv: Constify VMState in machine.c
  target/s390x: Constify VMState in machine.c
  target/sparc: Constify VMState in machine.c
  hw/arm: Constify VMState
  hw/core: Constify VMState
  hw/9pfs: Constify VMState
  hw/acpi: Constify VMState
  hw/adc: Constify VMState
  hw/audio: Constify VMState
  hw/block: Constify VMState
  hw/char: Constify VMState
  hw/display: Constify VMState
  hw/dma: Constify VMState
  hw/gpio: Constify VMState
  hw/hyperv: Constify VMState
  hw/i2c: Constify VMState
  hw/i386: Constify VMState
  hw/ide: Constify VMState
  hw/input: Constify VMState
  hw/intc: Constify VMState
  hw/ipack: Constify VMState
  hw/ipmi: Constify VMState
  hw/isa: Constify VMState
  hw/loongarch: Constify VMState
  hw/m68k: Constify VMState
  hw/misc: Constify VMState
  hw/net: Constify VMState
  hw/nvram: Constify VMState
  hw/openrisc: Constify VMState
  hw/pci: Constify VMState
  hw/pci-bridge: Constify VMState
  hw/pci-host: Constify VMState
  hw/ppc: Constify VMState
  hw/riscv: Constify VMState
  hw/rtc: Constify VMState
  hw/s390x: Constify VMState
  hw/scsi: Constify VMState
  hw/sd: Constify VMState
  hw/sensor: Constify VMState
  hw/sparc: Constify VMState
  hw/ssi: Constify VMState
  hw/timer: Constify VMState
  hw/tpm: Constify VMState
  hw/usb: Constify VMState
  hw/vfio: Constify VMState
  hw/virtio: Constify VMState
  hw/watchdog: Constify VMState
  hw/misc/macio: Constify VMState
  audio: Constify VMState
  backends: Constify VMState
  cpu-target: Constify VMState
  migration: Constify VMState
  system: Constify VMState
  replay: Constify VMState
  util/fifo8: Constify VMState
  tests/unit/test-vmstate: Constify VMState
  docs: Constify VMstate in examples

 docs/devel/clocks.rst               |   2 +-
 docs/devel/migration.rst            |   8 +-
 include/hw/pci/shpc.h               |   2 +-
 include/migration/vmstate.h         |   2 +-
 audio/audio.c                       |   2 +-
 backends/dbus-vmstate.c             |   2 +-
 backends/tpm/tpm_emulator.c         |   2 +-
 cpu-target.c                        |   8 +-
 hw/9pfs/virtio-9p-device.c          |   2 +-
 hw/acpi/cpu.c                       |   4 +-
 hw/acpi/erst.c                      |   2 +-
 hw/acpi/generic_event_device.c      |  12 +--
 hw/acpi/ich9.c                      |  12 +--
 hw/acpi/ich9_tco.c                  |   2 +-
 hw/acpi/memory_hotplug.c            |   4 +-
 hw/acpi/pcihp.c                     |   2 +-
 hw/acpi/piix4.c                     |  12 +--
 hw/acpi/vmgenid.c                   |   2 +-
 hw/adc/aspeed_adc.c                 |   2 +-
 hw/adc/max111x.c                    |   2 +-
 hw/adc/npcm7xx_adc.c                |   2 +-
 hw/adc/stm32f2xx_adc.c              |   2 +-
 hw/adc/zynq-xadc.c                  |   2 +-
 hw/arm/armsse.c                     |   2 +-
 hw/arm/armv7m.c                     |   2 +-
 hw/arm/highbank.c                   |   2 +-
 hw/arm/integratorcp.c               |   6 +-
 hw/arm/musicpal.c                   |  14 +--
 hw/arm/pxa2xx.c                     |  18 ++--
 hw/arm/pxa2xx_gpio.c                |   2 +-
 hw/arm/pxa2xx_pic.c                 |   2 +-
 hw/arm/smmuv3.c                     |   8 +-
 hw/arm/spitz.c                      |   8 +-
 hw/arm/stellaris.c                  |   6 +-
 hw/arm/strongarm.c                  |  12 +--
 hw/arm/versatilepb.c                |   2 +-
 hw/arm/virt-acpi-build.c            |   2 +-
 hw/arm/z2.c                         |   4 +-
 hw/audio/ac97.c                     |   4 +-
 hw/audio/asc.c                      |   4 +-
 hw/audio/cs4231.c                   |   2 +-
 hw/audio/cs4231a.c                  |   2 +-
 hw/audio/es1370.c                   |   4 +-
 hw/audio/gus.c                      |   2 +-
 hw/audio/hda-codec.c                |   8 +-
 hw/audio/intel-hda.c                |   4 +-
 hw/audio/lm4549.c                   |   2 +-
 hw/audio/marvell_88w8618.c          |   2 +-
 hw/audio/pcspk.c                    |   2 +-
 hw/audio/pl041.c                    |   8 +-
 hw/audio/sb16.c                     |   2 +-
 hw/audio/wm8750.c                   |   2 +-
 hw/block/ecc.c                      |   2 +-
 hw/block/fdc-isa.c                  |   2 +-
 hw/block/fdc-sysbus.c               |   2 +-
 hw/block/fdc.c                      |  20 ++---
 hw/block/m25p80.c                   |  12 +--
 hw/block/nand.c                     |   2 +-
 hw/block/onenand.c                  |   2 +-
 hw/block/pflash_cfi01.c             |   2 +-
 hw/block/swim.c                     |   6 +-
 hw/block/vhost-user-blk.c           |   2 +-
 hw/block/virtio-blk.c               |   2 +-
 hw/char/bcm2835_aux.c               |   2 +-
 hw/char/cadence_uart.c              |   2 +-
 hw/char/cmsdk-apb-uart.c            |   2 +-
 hw/char/digic-uart.c                |   2 +-
 hw/char/escc.c                      |   4 +-
 hw/char/exynos4210_uart.c           |   4 +-
 hw/char/goldfish_tty.c              |   2 +-
 hw/char/ibex_uart.c                 |   2 +-
 hw/char/imx_serial.c                |   2 +-
 hw/char/ipoctal232.c                |   6 +-
 hw/char/mchp_pfsoc_mmuart.c         |   2 +-
 hw/char/nrf51_uart.c                |   2 +-
 hw/char/parallel.c                  |   2 +-
 hw/char/pl011.c                     |   6 +-
 hw/char/renesas_sci.c               |   2 +-
 hw/char/sclpconsole-lm.c            |   2 +-
 hw/char/sclpconsole.c               |   2 +-
 hw/char/serial-isa.c                |   2 +-
 hw/char/serial-pci-multi.c          |   2 +-
 hw/char/serial-pci.c                |   2 +-
 hw/char/serial.c                    |  20 ++---
 hw/char/sifive_uart.c               |   2 +-
 hw/char/spapr_vty.c                 |   2 +-
 hw/char/virtio-serial-bus.c         |   2 +-
 hw/core/clock-vmstate.c             |   6 +-
 hw/core/or-irq.c                    |   6 +-
 hw/core/ptimer.c                    |   2 +-
 hw/display/artist.c                 |   2 +-
 hw/display/bcm2835_fb.c             |   2 +-
 hw/display/bochs-display.c          |   2 +-
 hw/display/cg3.c                    |   2 +-
 hw/display/cirrus_vga.c             |   4 +-
 hw/display/dpcd.c                   |   2 +-
 hw/display/exynos4210_fimd.c        |   4 +-
 hw/display/g364fb.c                 |   4 +-
 hw/display/i2c-ddc.c                |   2 +-
 hw/display/jazz_led.c               |   2 +-
 hw/display/macfb.c                  |   6 +-
 hw/display/pl110.c                  |   2 +-
 hw/display/pxa2xx_lcd.c             |   4 +-
 hw/display/qxl.c                    |  10 +--
 hw/display/ramfb-standalone.c       |   2 +-
 hw/display/ramfb.c                  |   2 +-
 hw/display/sii9022.c                |   2 +-
 hw/display/sm501.c                  |   6 +-
 hw/display/ssd0303.c                |   2 +-
 hw/display/ssd0323.c                |   2 +-
 hw/display/tcx.c                    |   2 +-
 hw/display/vga-pci.c                |   2 +-
 hw/display/vga.c                    |   6 +-
 hw/display/virtio-gpu.c             |   6 +-
 hw/display/virtio-vga.c             |   2 +-
 hw/display/vmware_vga.c             |   4 +-
 hw/display/xlnx_dp.c                |   2 +-
 hw/dma/bcm2835_dma.c                |   4 +-
 hw/dma/i82374.c                     |   2 +-
 hw/dma/i8257.c                      |   4 +-
 hw/dma/pl080.c                      |   4 +-
 hw/dma/pl330.c                      |  10 +--
 hw/dma/pxa2xx_dma.c                 |   4 +-
 hw/dma/rc4030.c                     |   2 +-
 hw/dma/sparc32_dma.c                |   2 +-
 hw/dma/xlnx-zdma.c                  |   2 +-
 hw/dma/xlnx-zynq-devcfg.c           |   4 +-
 hw/dma/xlnx_csu_dma.c               |   2 +-
 hw/dma/xlnx_dpdma.c                 |   2 +-
 hw/gpio/aspeed_gpio.c               |   4 +-
 hw/gpio/bcm2835_gpio.c              |   2 +-
 hw/gpio/gpio_key.c                  |   2 +-
 hw/gpio/imx_gpio.c                  |   2 +-
 hw/gpio/max7310.c                   |   2 +-
 hw/gpio/mpc8xxx.c                   |   2 +-
 hw/gpio/npcm7xx_gpio.c              |   2 +-
 hw/gpio/nrf51_gpio.c                |   2 +-
 hw/gpio/pl061.c                     |   2 +-
 hw/gpio/sifive_gpio.c               |   2 +-
 hw/gpio/zaurus.c                    |   2 +-
 hw/hyperv/vmbus.c                   |  16 ++--
 hw/i2c/allwinner-i2c.c              |   2 +-
 hw/i2c/aspeed_i2c.c                 |   4 +-
 hw/i2c/core.c                       |   4 +-
 hw/i2c/exynos4210_i2c.c             |   2 +-
 hw/i2c/imx_i2c.c                    |   2 +-
 hw/i2c/microbit_i2c.c               |   2 +-
 hw/i2c/mpc_i2c.c                    |   2 +-
 hw/i2c/npcm7xx_smbus.c              |   2 +-
 hw/i2c/pm_smbus.c                   |   2 +-
 hw/i2c/pmbus_device.c               |   2 +-
 hw/i2c/smbus_eeprom.c               |   2 +-
 hw/i2c/smbus_ich9.c                 |   2 +-
 hw/i2c/smbus_slave.c                |   2 +-
 hw/i386/acpi-build.c                |   2 +-
 hw/i386/intel_iommu.c               |   2 +-
 hw/i386/kvm/clock.c                 |   6 +-
 hw/i386/kvm/xen_evtchn.c            |   4 +-
 hw/i386/kvm/xen_gnttab.c            |   2 +-
 hw/i386/kvm/xen_overlay.c           |   2 +-
 hw/i386/kvm/xen_xenstore.c          |   2 +-
 hw/i386/kvmvapic.c                  |   6 +-
 hw/i386/port92.c                    |   2 +-
 hw/i386/vmmouse.c                   |   2 +-
 hw/i386/xen/xen_platform.c          |   2 +-
 hw/i386/xen/xen_pvdevice.c          |   2 +-
 hw/ide/ahci-allwinner.c             |   2 +-
 hw/ide/ahci.c                       |   8 +-
 hw/ide/core.c                       |  16 ++--
 hw/ide/ich.c                        |   2 +-
 hw/ide/isa.c                        |   2 +-
 hw/ide/macio.c                      |   2 +-
 hw/ide/microdrive.c                 |   2 +-
 hw/ide/mmio.c                       |   2 +-
 hw/ide/pci.c                        |  10 +--
 hw/input/adb-kbd.c                  |   2 +-
 hw/input/adb-mouse.c                |   2 +-
 hw/input/adb.c                      |   4 +-
 hw/input/ads7846.c                  |   2 +-
 hw/input/hid.c                      |   6 +-
 hw/input/lasips2.c                  |   4 +-
 hw/input/lm832x.c                   |   2 +-
 hw/input/pckbd.c                    |  12 +--
 hw/input/pl050.c                    |   2 +-
 hw/input/ps2.c                      |  14 +--
 hw/input/pxa2xx_keypad.c            |   2 +-
 hw/input/stellaris_gamepad.c        |   2 +-
 hw/input/tsc2005.c                  |   2 +-
 hw/input/tsc210x.c                  |   2 +-
 hw/input/virtio-input.c             |   2 +-
 hw/intc/allwinner-a10-pic.c         |   2 +-
 hw/intc/apic_common.c               |   6 +-
 hw/intc/arm_gic_common.c            |   8 +-
 hw/intc/arm_gicv3_common.c          |  16 ++--
 hw/intc/arm_gicv3_its_common.c      |   2 +-
 hw/intc/armv7m_nvic.c               |   8 +-
 hw/intc/aspeed_vic.c                |   2 +-
 hw/intc/bcm2835_ic.c                |   2 +-
 hw/intc/bcm2836_control.c           |   2 +-
 hw/intc/exynos4210_combiner.c       |   4 +-
 hw/intc/goldfish_pic.c              |   2 +-
 hw/intc/heathrow_pic.c              |   4 +-
 hw/intc/i8259_common.c              |   6 +-
 hw/intc/imx_avic.c                  |   2 +-
 hw/intc/imx_gpcv2.c                 |   2 +-
 hw/intc/ioapic_common.c             |   2 +-
 hw/intc/loongarch_extioi.c          |   2 +-
 hw/intc/loongarch_ipi.c             |   4 +-
 hw/intc/loongarch_pch_pic.c         |   2 +-
 hw/intc/m68k_irqc.c                 |   2 +-
 hw/intc/nios2_vic.c                 |   2 +-
 hw/intc/ompic.c                     |   4 +-
 hw/intc/openpic.c                   |  12 +--
 hw/intc/pl190.c                     |   2 +-
 hw/intc/ppc-uic.c                   |   2 +-
 hw/intc/riscv_aclint.c              |   2 +-
 hw/intc/riscv_aplic.c               |   2 +-
 hw/intc/riscv_imsic.c               |   2 +-
 hw/intc/rx_icu.c                    |   2 +-
 hw/intc/s390_flic.c                 |  10 +--
 hw/intc/s390_flic_kvm.c             |   8 +-
 hw/intc/sifive_plic.c               |   2 +-
 hw/intc/slavio_intctl.c             |   4 +-
 hw/intc/spapr_xive.c                |   6 +-
 hw/intc/xics.c                      |   6 +-
 hw/intc/xive.c                      |   4 +-
 hw/intc/xlnx-pmu-iomod-intc.c       |   2 +-
 hw/intc/xlnx-zynqmp-ipi.c           |   2 +-
 hw/ipack/ipack.c                    |   2 +-
 hw/ipack/tpci200.c                  |   2 +-
 hw/ipmi/ipmi_bmc_extern.c           |   2 +-
 hw/ipmi/ipmi_bmc_sim.c              |   2 +-
 hw/ipmi/ipmi_bt.c                   |   2 +-
 hw/ipmi/ipmi_kcs.c                  |   2 +-
 hw/ipmi/isa_ipmi_bt.c               |   2 +-
 hw/ipmi/isa_ipmi_kcs.c              |   2 +-
 hw/ipmi/pci_ipmi_bt.c               |   2 +-
 hw/ipmi/pci_ipmi_kcs.c              |   2 +-
 hw/ipmi/smbus_ipmi.c                |   2 +-
 hw/isa/apm.c                        |   2 +-
 hw/isa/i82378.c                     |   2 +-
 hw/isa/lpc_ich9.c                   |   8 +-
 hw/isa/pc87312.c                    |   2 +-
 hw/isa/piix.c                       |   8 +-
 hw/isa/vt82c686.c                   |   4 +-
 hw/loongarch/acpi-build.c           |   2 +-
 hw/m68k/next-cube.c                 |   4 +-
 hw/m68k/q800-glue.c                 |   2 +-
 hw/misc/a9scu.c                     |   2 +-
 hw/misc/allwinner-a10-ccm.c         |   2 +-
 hw/misc/allwinner-a10-dramc.c       |   2 +-
 hw/misc/allwinner-cpucfg.c          |   2 +-
 hw/misc/allwinner-h3-ccu.c          |   2 +-
 hw/misc/allwinner-h3-dramc.c        |   2 +-
 hw/misc/allwinner-h3-sysctrl.c      |   2 +-
 hw/misc/allwinner-r40-ccu.c         |   2 +-
 hw/misc/allwinner-r40-dramc.c       |   2 +-
 hw/misc/allwinner-sid.c             |   2 +-
 hw/misc/allwinner-sramc.c           |   2 +-
 hw/misc/arm_l2x0.c                  |   2 +-
 hw/misc/arm_sysctl.c                |   2 +-
 hw/misc/armsse-cpu-pwrctrl.c        |   2 +-
 hw/misc/armsse-mhu.c                |   2 +-
 hw/misc/aspeed_hace.c               |   2 +-
 hw/misc/aspeed_i3c.c                |   4 +-
 hw/misc/aspeed_lpc.c                |   2 +-
 hw/misc/aspeed_sbc.c                |   2 +-
 hw/misc/aspeed_scu.c                |   2 +-
 hw/misc/aspeed_sdmc.c               |   2 +-
 hw/misc/aspeed_xdma.c               |   2 +-
 hw/misc/axp2xx.c                    |   2 +-
 hw/misc/bcm2835_cprman.c            |  10 +--
 hw/misc/bcm2835_mbox.c              |   4 +-
 hw/misc/bcm2835_mphi.c              |   2 +-
 hw/misc/bcm2835_powermgt.c          |   2 +-
 hw/misc/bcm2835_property.c          |   2 +-
 hw/misc/bcm2835_rng.c               |   2 +-
 hw/misc/bcm2835_thermal.c           |   2 +-
 hw/misc/djmemc.c                    |   2 +-
 hw/misc/eccmemctl.c                 |   2 +-
 hw/misc/exynos4210_clk.c            |   2 +-
 hw/misc/exynos4210_pmu.c            |   2 +-
 hw/misc/exynos4210_rng.c            |   2 +-
 hw/misc/imx25_ccm.c                 |   2 +-
 hw/misc/imx31_ccm.c                 |   2 +-
 hw/misc/imx6_ccm.c                  |   2 +-
 hw/misc/imx6_src.c                  |   2 +-
 hw/misc/imx6ul_ccm.c                |   2 +-
 hw/misc/imx7_ccm.c                  |   4 +-
 hw/misc/imx7_src.c                  |   2 +-
 hw/misc/imx_rngc.c                  |   2 +-
 hw/misc/iosb.c                      |   2 +-
 hw/misc/iotkit-secctl.c             |  10 +--
 hw/misc/iotkit-sysctl.c             |   8 +-
 hw/misc/ivshmem.c                   |   4 +-
 hw/misc/lasi.c                      |   2 +-
 hw/misc/led.c                       |   2 +-
 hw/misc/mac_via.c                   |   4 +-
 hw/misc/macio/cuda.c                |   2 +-
 hw/misc/macio/gpio.c                |   2 +-
 hw/misc/macio/mac_dbdma.c           |   8 +-
 hw/misc/macio/macio.c               |   4 +-
 hw/misc/macio/pmu.c                 |   6 +-
 hw/misc/mips_cmgcr.c                |   2 +-
 hw/misc/mips_cpc.c                  |   2 +-
 hw/misc/mos6522.c                   |   4 +-
 hw/misc/mps2-fpgaio.c               |   2 +-
 hw/misc/mps2-scc.c                  |   2 +-
 hw/misc/msf2-sysreg.c               |   2 +-
 hw/misc/mst_fpga.c                  |   2 +-
 hw/misc/npcm7xx_clk.c               |   8 +-
 hw/misc/npcm7xx_gcr.c               |   2 +-
 hw/misc/npcm7xx_mft.c               |   2 +-
 hw/misc/npcm7xx_pwm.c               |   4 +-
 hw/misc/npcm7xx_rng.c               |   2 +-
 hw/misc/nrf51_rng.c                 |   2 +-
 hw/misc/pca9552.c                   |   2 +-
 hw/misc/pvpanic-pci.c               |   2 +-
 hw/misc/slavio_misc.c               |   2 +-
 hw/misc/stm32f4xx_exti.c            |   2 +-
 hw/misc/stm32f4xx_syscfg.c          |   2 +-
 hw/misc/tz-mpc.c                    |   2 +-
 hw/misc/tz-msc.c                    |   2 +-
 hw/misc/tz-ppc.c                    |   2 +-
 hw/misc/virt_ctrl.c                 |   2 +-
 hw/misc/vmcoreinfo.c                |   2 +-
 hw/misc/xlnx-versal-cframe-reg.c    |   6 +-
 hw/misc/xlnx-versal-cfu.c           |   6 +-
 hw/misc/xlnx-versal-crl.c           |   2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c  |   2 +-
 hw/misc/xlnx-versal-trng.c          |   2 +-
 hw/misc/xlnx-versal-xramc.c         |   2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c      |   2 +-
 hw/misc/xlnx-zynqmp-crf.c           |   2 +-
 hw/misc/zynq_slcr.c                 |   2 +-
 hw/net/allwinner-sun8i-emac.c       |   2 +-
 hw/net/allwinner_emac.c             |   4 +-
 hw/net/cadence_gem.c                |   2 +-
 hw/net/can/can_kvaser_pci.c         |   2 +-
 hw/net/can/can_mioe3680_pci.c       |   2 +-
 hw/net/can/can_pcm3680_pci.c        |   2 +-
 hw/net/can/can_sja1000.c            |   4 +-
 hw/net/can/ctucan_core.c            |   4 +-
 hw/net/can/ctucan_pci.c             |   2 +-
 hw/net/can/xlnx-versal-canfd.c      |   2 +-
 hw/net/can/xlnx-zynqmp-can.c        |   2 +-
 hw/net/dp8393x.c                    |   2 +-
 hw/net/e1000.c                      |  10 +--
 hw/net/e1000e.c                     |   6 +-
 hw/net/eepro100.c                   |   2 +-
 hw/net/ftgmac100.c                  |   4 +-
 hw/net/i82596.c                     |   2 +-
 hw/net/igb.c                        |   8 +-
 hw/net/imx_fec.c                    |   6 +-
 hw/net/lan9118.c                    |   4 +-
 hw/net/lance.c                      |   2 +-
 hw/net/lasi_i82596.c                |   2 +-
 hw/net/mipsnet.c                    |   2 +-
 hw/net/msf2-emac.c                  |   2 +-
 hw/net/mv88w8618_eth.c              |   2 +-
 hw/net/ne2000-isa.c                 |   2 +-
 hw/net/ne2000-pci.c                 |   2 +-
 hw/net/ne2000.c                     |   2 +-
 hw/net/npcm7xx_emc.c                |   2 +-
 hw/net/pcnet-pci.c                  |   2 +-
 hw/net/pcnet.c                      |   2 +-
 hw/net/rtl8139.c                    |   6 +-
 hw/net/smc91c111.c                  |   2 +-
 hw/net/spapr_llan.c                 |   8 +-
 hw/net/stellaris_enet.c             |   4 +-
 hw/net/sungem.c                     |   2 +-
 hw/net/sunhme.c                     |   2 +-
 hw/net/tulip.c                      |   2 +-
 hw/net/virtio-net.c                 |  18 ++--
 hw/net/vmxnet3.c                    |  18 ++--
 hw/net/xgmac.c                      |   4 +-
 hw/nvram/ds1225y.c                  |   2 +-
 hw/nvram/eeprom93xx.c               |   2 +-
 hw/nvram/fw_cfg.c                   |   8 +-
 hw/nvram/mac_nvram.c                |   2 +-
 hw/nvram/npcm7xx_otp.c              |   2 +-
 hw/nvram/nrf51_nvm.c                |   2 +-
 hw/nvram/spapr_nvram.c              |   2 +-
 hw/nvram/xlnx-bbram.c               |   2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c   |   2 +-
 hw/nvram/xlnx-zynqmp-efuse.c        |   2 +-
 hw/openrisc/cputimer.c              |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c  |   2 +-
 hw/pci-bridge/i82801b11.c           |   2 +-
 hw/pci-bridge/ioh3420.c             |   2 +-
 hw/pci-bridge/pci_bridge_dev.c      |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c     |   2 +-
 hw/pci-bridge/xio3130_downstream.c  |   2 +-
 hw/pci-bridge/xio3130_upstream.c    |   2 +-
 hw/pci-host/astro.c                 |   4 +-
 hw/pci-host/bonito.c                |   2 +-
 hw/pci-host/designware.c            |  10 +--
 hw/pci-host/dino.c                  |   2 +-
 hw/pci-host/gpex.c                  |   2 +-
 hw/pci-host/gt64120.c               |   2 +-
 hw/pci-host/i440fx.c                |   2 +-
 hw/pci-host/ppce500.c               |   6 +-
 hw/pci-host/q35.c                   |   2 +-
 hw/pci-host/raven.c                 |   2 +-
 hw/pci-host/versatile.c             |   2 +-
 hw/pci/msix.c                       |   4 +-
 hw/pci/pci.c                        |   8 +-
 hw/pci/pci_host.c                   |   2 +-
 hw/pci/pcie_aer.c                   |   4 +-
 hw/pci/shpc.c                       |   2 +-
 hw/ppc/ppc.c                        |   2 +-
 hw/ppc/ppc4xx_pci.c                 |   6 +-
 hw/ppc/prep_systemio.c              |   2 +-
 hw/ppc/rs6000_mc.c                  |   2 +-
 hw/ppc/spapr.c                      |  20 ++---
 hw/ppc/spapr_caps.c                 |   2 +-
 hw/ppc/spapr_cpu_core.c             |  12 +--
 hw/ppc/spapr_drc.c                  |   8 +-
 hw/ppc/spapr_iommu.c                |   6 +-
 hw/ppc/spapr_nvdimm.c               |   4 +-
 hw/ppc/spapr_ovec.c                 |   2 +-
 hw/ppc/spapr_pci.c                  |   6 +-
 hw/ppc/spapr_rtc.c                  |   2 +-
 hw/ppc/spapr_vio.c                  |   2 +-
 hw/riscv/virt-acpi-build.c          |   2 +-
 hw/rtc/allwinner-rtc.c              |   2 +-
 hw/rtc/aspeed_rtc.c                 |   2 +-
 hw/rtc/ds1338.c                     |   2 +-
 hw/rtc/exynos4210_rtc.c             |   2 +-
 hw/rtc/goldfish_rtc.c               |   2 +-
 hw/rtc/ls7a_rtc.c                   |   2 +-
 hw/rtc/m48t59.c                     |   2 +-
 hw/rtc/mc146818rtc.c                |   6 +-
 hw/rtc/pl031.c                      |   6 +-
 hw/rtc/twl92230.c                   |   4 +-
 hw/rtc/xlnx-zynqmp-rtc.c            |   2 +-
 hw/s390x/ccw-device.c               |   2 +-
 hw/s390x/css.c                      |  36 ++++----
 hw/s390x/event-facility.c           |   8 +-
 hw/s390x/ipl.c                      |   8 +-
 hw/s390x/sclpquiesce.c              |   2 +-
 hw/s390x/virtio-ccw.c               |   4 +-
 hw/scsi/esp-pci.c                   |   2 +-
 hw/scsi/esp.c                       |   8 +-
 hw/scsi/lsi53c895a.c                |   2 +-
 hw/scsi/megasas.c                   |   4 +-
 hw/scsi/mptsas.c                    |   2 +-
 hw/scsi/scsi-bus.c                  |   6 +-
 hw/scsi/scsi-disk.c                 |   2 +-
 hw/scsi/spapr_vscsi.c               |   4 +-
 hw/scsi/vhost-scsi.c                |   2 +-
 hw/scsi/vhost-user-scsi.c           |   2 +-
 hw/scsi/virtio-scsi.c               |   2 +-
 hw/scsi/vmw_pvscsi.c                |   6 +-
 hw/sd/allwinner-sdhost.c            |   2 +-
 hw/sd/aspeed_sdhci.c                |   2 +-
 hw/sd/bcm2835_sdhost.c              |   2 +-
 hw/sd/cadence_sdhci.c               |   2 +-
 hw/sd/npcm7xx_sdhci.c               |   2 +-
 hw/sd/pl181.c                       |   2 +-
 hw/sd/pxa2xx_mmci.c                 |   2 +-
 hw/sd/sd.c                          |   6 +-
 hw/sd/sdhci.c                       |   6 +-
 hw/sd/ssi-sd.c                      |   2 +-
 hw/sensor/adm1272.c                 |   2 +-
 hw/sensor/dps310.c                  |   2 +-
 hw/sensor/emc141x.c                 |   2 +-
 hw/sensor/lsm303dlhc_mag.c          |   2 +-
 hw/sensor/max31785.c                |   2 +-
 hw/sensor/max34451.c                |   2 +-
 hw/sensor/tmp105.c                  |   6 +-
 hw/sensor/tmp421.c                  |   2 +-
 hw/sparc/sun4m_iommu.c              |   2 +-
 hw/ssi/aspeed_smc.c                 |   2 +-
 hw/ssi/ibex_spi_host.c              |   2 +-
 hw/ssi/imx_spi.c                    |   2 +-
 hw/ssi/mss-spi.c                    |   2 +-
 hw/ssi/npcm7xx_fiu.c                |   2 +-
 hw/ssi/npcm_pspi.c                  |   2 +-
 hw/ssi/pl022.c                      |   2 +-
 hw/ssi/ssi.c                        |   2 +-
 hw/ssi/stm32f2xx_spi.c              |   2 +-
 hw/ssi/xilinx_spi.c                 |   2 +-
 hw/ssi/xilinx_spips.c               |   6 +-
 hw/ssi/xlnx-versal-ospi.c           |   4 +-
 hw/timer/a9gtimer.c                 |   8 +-
 hw/timer/allwinner-a10-pit.c        |   2 +-
 hw/timer/arm_mptimer.c              |   4 +-
 hw/timer/arm_timer.c                |   4 +-
 hw/timer/armv7m_systick.c           |   2 +-
 hw/timer/aspeed_timer.c             |   4 +-
 hw/timer/bcm2835_systmr.c           |   2 +-
 hw/timer/cadence_ttc.c              |   4 +-
 hw/timer/cmsdk-apb-dualtimer.c      |   4 +-
 hw/timer/cmsdk-apb-timer.c          |   2 +-
 hw/timer/digic-timer.c              |   2 +-
 hw/timer/etraxfs_timer.c            |   2 +-
 hw/timer/exynos4210_mct.c           |  12 +--
 hw/timer/exynos4210_pwm.c           |   4 +-
 hw/timer/hpet.c                     |  10 +--
 hw/timer/i8254_common.c             |   4 +-
 hw/timer/ibex_timer.c               |   2 +-
 hw/timer/imx_epit.c                 |   2 +-
 hw/timer/imx_gpt.c                  |   2 +-
 hw/timer/mss-timer.c                |   4 +-
 hw/timer/npcm7xx_timer.c            |   8 +-
 hw/timer/nrf51_timer.c              |   2 +-
 hw/timer/pxa2xx_timer.c             |   6 +-
 hw/timer/renesas_cmt.c              |   2 +-
 hw/timer/renesas_tmr.c              |   2 +-
 hw/timer/sifive_pwm.c               |   2 +-
 hw/timer/slavio_timer.c             |   4 +-
 hw/timer/sse-counter.c              |   2 +-
 hw/timer/sse-timer.c                |   2 +-
 hw/timer/stellaris-gptm.c           |   2 +-
 hw/timer/stm32f2xx_timer.c          |   2 +-
 hw/tpm/tpm_crb.c                    |   2 +-
 hw/tpm/tpm_spapr.c                  |   2 +-
 hw/tpm/tpm_tis_common.c             |   2 +-
 hw/tpm/tpm_tis_i2c.c                |   2 +-
 hw/tpm/tpm_tis_isa.c                |   2 +-
 hw/tpm/tpm_tis_sysbus.c             |   2 +-
 hw/usb/bus.c                        |   2 +-
 hw/usb/ccid-card-passthru.c         |   2 +-
 hw/usb/dev-hid.c                    |   4 +-
 hw/usb/dev-hub.c                    |   8 +-
 hw/usb/dev-mtp.c                    |   2 +-
 hw/usb/dev-smartcard-reader.c       |   8 +-
 hw/usb/dev-storage.c                |   2 +-
 hw/usb/dev-uas.c                    |   2 +-
 hw/usb/hcd-dwc2.c                   |   4 +-
 hw/usb/hcd-dwc3.c                   |   2 +-
 hw/usb/hcd-ehci-pci.c               |   2 +-
 hw/usb/hcd-ehci-sysbus.c            |   2 +-
 hw/usb/hcd-ehci.c                   |   2 +-
 hw/usb/hcd-ohci-pci.c               |   2 +-
 hw/usb/hcd-ohci.c                   |   8 +-
 hw/usb/hcd-uhci.c                   |   4 +-
 hw/usb/hcd-xhci-pci.c               |   2 +-
 hw/usb/hcd-xhci-sysbus.c            |   2 +-
 hw/usb/hcd-xhci.c                   |  12 +--
 hw/usb/host-libusb.c                |   2 +-
 hw/usb/imx-usb-phy.c                |   2 +-
 hw/usb/redirect.c                   |  16 ++--
 hw/usb/u2f-passthru.c               |   2 +-
 hw/usb/u2f.c                        |   2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c |   2 +-
 hw/vfio/display.c                   |   2 +-
 hw/vfio/pci.c                       |   6 +-
 hw/virtio/vdpa-dev.c                |   2 +-
 hw/virtio/vhost-vsock.c             |   2 +-
 hw/virtio/virtio-balloon.c          |  10 +--
 hw/virtio/virtio-crypto.c           |   2 +-
 hw/virtio/virtio-iommu.c            |  12 +--
 hw/virtio/virtio-mem.c              |   8 +-
 hw/virtio/virtio-mmio.c             |   8 +-
 hw/virtio/virtio-pci.c              |   8 +-
 hw/virtio/virtio-rng.c              |   2 +-
 hw/virtio/virtio.c                  |  28 +++---
 hw/watchdog/allwinner-wdt.c         |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c    |   2 +-
 hw/watchdog/sbsa_gwdt.c             |   2 +-
 hw/watchdog/spapr_watchdog.c        |   2 +-
 hw/watchdog/wdt_aspeed.c            |   2 +-
 hw/watchdog/wdt_diag288.c           |   2 +-
 hw/watchdog/wdt_i6300esb.c          |   2 +-
 hw/watchdog/wdt_ib700.c             |   2 +-
 hw/watchdog/wdt_imx2.c              |   2 +-
 migration/global_state.c            |   2 +-
 migration/savevm.c                  |  22 ++---
 migration/vmstate.c                 |  15 ++--
 replay/replay-snapshot.c            |   2 +-
 system/cpu-timers.c                 |  14 +--
 target/alpha/machine.c              |   4 +-
 target/arm/hvf/hvf.c                |  13 +--
 target/arm/machine.c                |  54 ++++++------
 target/avr/machine.c                |   2 +-
 target/cris/machine.c               |   6 +-
 target/hppa/machine.c               |   4 +-
 target/i386/machine.c               | 128 ++++++++++++++--------------
 target/loongarch/machine.c          |  18 ++--
 target/m68k/cpu.c                   |  16 ++--
 target/microblaze/machine.c         |   6 +-
 target/mips/sysemu/machine.c        |  26 +++---
 target/openrisc/machine.c           |   8 +-
 target/ppc/machine.c                |  32 +++----
 target/riscv/machine.c              |  28 +++---
 target/s390x/machine.c              |  32 +++----
 target/sparc/machine.c              |   8 +-
 tests/unit/test-vmstate.c           |  36 ++++----
 util/fifo8.c                        |   2 +-
 591 files changed, 1264 insertions(+), 1258 deletions(-)

-- 
2.34.1


