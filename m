Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451509F6782
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 14:43:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKP-0001Dw-Sy; Wed, 18 Dec 2024 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKJ-0001Cw-Ds
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:42:59 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKG-0005dD-5S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:42:58 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eba347aa6fso3482812b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529374; x=1735134174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ALF/SvRMsLBGnVXgKA6VpMekxZmH5nN1KzP0SrmAjY=;
 b=GqtbUp29wQ2VgmHDjwqG8F0uWFw2FWdCD7LRYbSAyrxx3Ek3WsskiadZD1BhPFlv8Q
 KbLR3r1QP5Np6TL9rDcvP+ABZRr+aTQzye/6+JELQbHXEnPSghmOhnDpVbhmcrVQ36rs
 6qDJsHbXeKBshOBg1OeydM6lE0G5XiYc1PwGomaSWcSAfmF6v/o28pB2Vl0r/PKGuFP6
 TGvVhHdFB5qrdQ0qZtQpgrvmGkPFZTnY7It3l/62MxvZxr16WEqYb2GHvBhKynssaNmI
 UZaCbMQzV1VK5V4DQNfKlJOid7wTqqCzDkfZR590MzN6PvJIZgiv8ZdF+oLYqixEmnnR
 bdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529374; x=1735134174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ALF/SvRMsLBGnVXgKA6VpMekxZmH5nN1KzP0SrmAjY=;
 b=uVxJgQsZGTuaEetAedMy+RHKSMwrqQIhCVLqx/q/lFuPf0pA7yhr0Kqqvx8fYTbu0I
 78jGPEbe1cg+HuUjtQtkAbasqlkvZiJi8dEZFKmV4exPf7KKiiJuJUIxl2VtSZ4uGvgh
 HWAOO7RuDpqjMkxZIUJLewEhsPHBxK6c66TzX4UyhHHJWi50MfI3tXtc2/T5h2RZ903E
 uCE6Ypp9C1M6Hb/XsDOIGw7WNNhMWTtdfSyUhOjS+ZuPlj6KJH8EJDvx0fb/sj/iT5fI
 f/I8Bn881n6axC7eizgwEt5cp+5KWUsWdMrg6D0dyKRFWGfPX0HcraH2cX2jONDBU1oa
 KY4Q==
X-Gm-Message-State: AOJu0Yx+eXUgLkXK7PS0IUJVLgpnXOurHunsSM17DghO3chVx0j6wTLm
 ENTz5V86utU5jsE1offxXW4RfhaE21VuN6x0o8bpnVGRT/6a7LcNPP15/Y/saoMG1o0b+RrirxN
 7TpOBooBz
X-Gm-Gg: ASbGncsZlUGqp2DCTytOgrsi8belDRoZmMUYmwHjn4WZ+qj7nLq8EWOq6MVfQqWuwb1
 d1evPWuY5wkxn/5azGdpUCEyyegsai4H6FU5EYCDafj7X/YrZomsTgvddxPWG9KYT7JkYD8dGiZ
 VCVlilWctIzRnYqWGr9azRpzW7jMU5qf6vOwvULZs33BoA/+ARFqvfY0FVGLdFkG1L+nQUCBFlJ
 j5o+8hTBd/48WmRCu6xqN4ygSzTiAIAeYquXLKurK7tUyvDCAGvVUpmywil6Yes
X-Google-Smtp-Source: AGHT+IGfrtngZYs3Zw5lfvPZsZ6fCvcoYoizgeLOECTeNbTL7fYa8uadqCxfTr3qCD1ottpFMKXlpA==
X-Received: by 2002:a05:6808:2dcb:b0:3eb:5d3a:5b20 with SMTP id
 5614622812f47-3eccbf2e62fmr2185817b6e.4.1734529374136; 
 Wed, 18 Dec 2024 05:42:54 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 00/24] More Property cleanups
Date: Wed, 18 Dec 2024 07:42:27 -0600
Message-ID: <20241218134251.4724-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

- Missed constifying two arrays.
- Eliminate all empty Property lists.
- Detect both of these cases during the build.
- Count the elements in the property list and eliminate
  DEFINE_PROP_END_OF_LIST.

Changes for v2:
  - Fix two bisection errors (BALATON)

r~

Richard Henderson (24):
  migration: Constify migration_properties
  hw/ide: Constify sysbus_ahci_properties
  target/ppc: Remove empty property list
  target/s390x: Use s390x_cpu_properties for system mode only
  hw/pci-host/astro: Remove empty Property list
  hw/ppc: Only register spapr_nvdimm_properties if CONFIG_LIBPMEM
  hw/tricore: Remove empty Property lists
  hw/s390x: Remove empty Property lists
  hw/xen: Remove empty Property lists
  hw/sparc: Remove empty Property lists
  hw/virtio: Remove empty Property lists
  include/hw/qdev-core: Detect most empty Property lists at compile time
  hw/core: Introduce device_class_set_props_n
  migration: Use device_class_set_props_n
  hw/scsi/megasas: Use device_class_set_props_n
  hw/arm/armsse: Use device_class_set_props_n
  rust/qemu-api: Use device_class_set_props_n
  hw/core: Remove device_class_set_props function
  target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
  include/hw/qdev-properties: Remove DEFINE_PROP_END_OF_LIST
  include/hw/qdev-properties: Shrink struct Property
  hw/core/qdev-properties: Constify Property argument to
    object_field_prop_ptr
  hw/core/qdev-properties: Constify Property argument to
    PropertyInfo.print
  Constify all opaque Property pointers

 include/hw/qdev-core.h                 |  35 +++++++-
 include/hw/qdev-properties.h           |  15 ++--
 migration/options.h                    |   3 +-
 backends/tpm/tpm_util.c                |   4 +-
 cpu-target.c                           |   1 -
 hw/9pfs/virtio-9p-device.c             |   1 -
 hw/acpi/erst.c                         |   1 -
 hw/acpi/generic_event_device.c         |   1 -
 hw/acpi/piix4.c                        |   1 -
 hw/acpi/vmgenid.c                      |   1 -
 hw/adc/aspeed_adc.c                    |   1 -
 hw/adc/npcm7xx_adc.c                   |   1 -
 hw/arm/armsse.c                        |   9 ++-
 hw/arm/armv7m.c                        |   2 -
 hw/arm/aspeed_soc_common.c             |   1 -
 hw/arm/fsl-imx25.c                     |   1 -
 hw/arm/fsl-imx6.c                      |   1 -
 hw/arm/fsl-imx6ul.c                    |   1 -
 hw/arm/fsl-imx7.c                      |   1 -
 hw/arm/integratorcp.c                  |   1 -
 hw/arm/msf2-soc.c                      |   1 -
 hw/arm/npcm7xx.c                       |   1 -
 hw/arm/nrf51_soc.c                     |   1 -
 hw/arm/smmu-common.c                   |   1 -
 hw/arm/smmuv3.c                        |   1 -
 hw/arm/stellaris.c                     |   1 -
 hw/arm/strongarm.c                     |   1 -
 hw/arm/xlnx-versal.c                   |   1 -
 hw/arm/xlnx-zynqmp.c                   |   1 -
 hw/audio/ac97.c                        |   1 -
 hw/audio/adlib.c                       |   1 -
 hw/audio/asc.c                         |   1 -
 hw/audio/cs4231a.c                     |   1 -
 hw/audio/es1370.c                      |   1 -
 hw/audio/gus.c                         |   1 -
 hw/audio/hda-codec.c                   |   1 -
 hw/audio/intel-hda.c                   |   2 -
 hw/audio/pcspk.c                       |   1 -
 hw/audio/pl041.c                       |   1 -
 hw/audio/sb16.c                        |   1 -
 hw/audio/via-ac97.c                    |   1 -
 hw/audio/virtio-snd-pci.c              |   1 -
 hw/audio/virtio-snd.c                  |   1 -
 hw/audio/wm8750.c                      |   1 -
 hw/avr/atmega.c                        |   1 -
 hw/block/fdc-isa.c                     |   1 -
 hw/block/fdc-sysbus.c                  |   2 -
 hw/block/fdc.c                         |   1 -
 hw/block/m25p80.c                      |   1 -
 hw/block/nand.c                        |   1 -
 hw/block/pflash_cfi01.c                |   1 -
 hw/block/pflash_cfi02.c                |   1 -
 hw/block/swim.c                        |   1 -
 hw/block/vhost-user-blk.c              |   1 -
 hw/block/virtio-blk.c                  |   1 -
 hw/block/xen-block.c                   |   5 +-
 hw/char/avr_usart.c                    |   1 -
 hw/char/bcm2835_aux.c                  |   1 -
 hw/char/cadence_uart.c                 |   1 -
 hw/char/cmsdk-apb-uart.c               |   1 -
 hw/char/debugcon.c                     |   1 -
 hw/char/digic-uart.c                   |   1 -
 hw/char/escc.c                         |   1 -
 hw/char/exynos4210_uart.c              |   1 -
 hw/char/goldfish_tty.c                 |   1 -
 hw/char/grlib_apbuart.c                |   1 -
 hw/char/ibex_uart.c                    |   1 -
 hw/char/imx_serial.c                   |   1 -
 hw/char/ipoctal232.c                   |   1 -
 hw/char/mcf_uart.c                     |   1 -
 hw/char/nrf51_uart.c                   |   1 -
 hw/char/parallel.c                     |   1 -
 hw/char/pl011.c                        |   1 -
 hw/char/renesas_sci.c                  |   1 -
 hw/char/sclpconsole-lm.c               |   1 -
 hw/char/sclpconsole.c                  |   1 -
 hw/char/serial-isa.c                   |   1 -
 hw/char/serial-mm.c                    |   1 -
 hw/char/serial-pci-multi.c             |   2 -
 hw/char/serial-pci.c                   |   1 -
 hw/char/serial.c                       |   1 -
 hw/char/sh_serial.c                    |   1 -
 hw/char/shakti_uart.c                  |   1 -
 hw/char/sifive_uart.c                  |   1 -
 hw/char/spapr_vty.c                    |   1 -
 hw/char/stm32f2xx_usart.c              |   1 -
 hw/char/stm32l4x5_usart.c              |   1 -
 hw/char/terminal3270.c                 |   1 -
 hw/char/virtio-console.c               |   1 -
 hw/char/virtio-serial-bus.c            |   2 -
 hw/char/xen_console.c                  |   1 -
 hw/char/xilinx_uartlite.c              |   1 -
 hw/core/generic-loader.c               |   1 -
 hw/core/guest-loader.c                 |   1 -
 hw/core/or-irq.c                       |   1 -
 hw/core/platform-bus.c                 |   1 -
 hw/core/qdev-properties-system.c       |  50 ++++++------
 hw/core/qdev-properties.c              | 107 +++++++++++++------------
 hw/core/qdev.c                         |   1 +
 hw/core/split-irq.c                    |   1 -
 hw/cpu/a15mpcore.c                     |   1 -
 hw/cpu/a9mpcore.c                      |   1 -
 hw/cpu/arm11mpcore.c                   |   1 -
 hw/cpu/cluster.c                       |   1 -
 hw/cpu/realview_mpcore.c               |   1 -
 hw/cxl/switch-mailbox-cci.c            |   1 -
 hw/display/artist.c                    |   1 -
 hw/display/ati.c                       |   1 -
 hw/display/bcm2835_fb.c                |   1 -
 hw/display/bochs-display.c             |   1 -
 hw/display/cg3.c                       |   1 -
 hw/display/cirrus_vga.c                |   1 -
 hw/display/cirrus_vga_isa.c            |   1 -
 hw/display/exynos4210_fimd.c           |   1 -
 hw/display/g364fb.c                    |   1 -
 hw/display/i2c-ddc.c                   |   1 -
 hw/display/macfb.c                     |   2 -
 hw/display/pl110.c                     |   1 -
 hw/display/qxl.c                       |   1 -
 hw/display/ramfb-standalone.c          |   1 -
 hw/display/sm501.c                     |   2 -
 hw/display/tcx.c                       |   1 -
 hw/display/vga-isa.c                   |   1 -
 hw/display/vga-mmio.c                  |   1 -
 hw/display/vga-pci.c                   |   2 -
 hw/display/vhost-user-gpu.c            |   1 -
 hw/display/virtio-gpu-gl.c             |   1 -
 hw/display/virtio-gpu-pci.c            |   1 -
 hw/display/virtio-gpu-rutabaga.c       |   1 -
 hw/display/virtio-gpu.c                |   1 -
 hw/display/virtio-vga.c                |   1 -
 hw/display/vmware_vga.c                |   1 -
 hw/display/xlnx_dp.c                   |   1 -
 hw/dma/i82374.c                        |   1 -
 hw/dma/i8257.c                         |   1 -
 hw/dma/pl080.c                         |   1 -
 hw/dma/pl330.c                         |   2 -
 hw/dma/xilinx_axidma.c                 |   1 -
 hw/dma/xlnx-zdma.c                     |   1 -
 hw/dma/xlnx_csu_dma.c                  |   1 -
 hw/gpio/imx_gpio.c                     |   1 -
 hw/gpio/npcm7xx_gpio.c                 |   1 -
 hw/gpio/omap_gpio.c                    |   1 -
 hw/gpio/pca9552.c                      |   1 -
 hw/gpio/pca9554.c                      |   1 -
 hw/gpio/pl061.c                        |   1 -
 hw/gpio/sifive_gpio.c                  |   1 -
 hw/gpio/stm32l4x5_gpio.c               |   1 -
 hw/hyperv/hv-balloon.c                 |   2 -
 hw/hyperv/syndbg.c                     |   1 -
 hw/hyperv/vmbus.c                      |   2 -
 hw/i2c/aspeed_i2c.c                    |   2 -
 hw/i2c/core.c                          |   1 -
 hw/i2c/i2c_mux_pca954x.c               |   1 -
 hw/i2c/omap_i2c.c                      |   1 -
 hw/i386/amd_iommu.c                    |   1 -
 hw/i386/intel_iommu.c                  |   1 -
 hw/i386/kvm/clock.c                    |   1 -
 hw/i386/kvm/i8254.c                    |   1 -
 hw/i386/kvm/ioapic.c                   |   1 -
 hw/i386/sgx-epc.c                      |   1 -
 hw/i386/vmmouse.c                      |   1 -
 hw/i386/vmport.c                       |   2 -
 hw/i386/x86-iommu.c                    |   1 -
 hw/i386/xen/xen_pvdevice.c             |   1 -
 hw/ide/ahci-sysbus.c                   |   3 +-
 hw/ide/cf.c                            |   1 -
 hw/ide/cmd646.c                        |   1 -
 hw/ide/ide-dev.c                       |   3 -
 hw/ide/isa.c                           |   1 -
 hw/ide/macio.c                         |   1 -
 hw/ide/mmio.c                          |   1 -
 hw/input/pckbd.c                       |   2 -
 hw/input/stellaris_gamepad.c           |   1 -
 hw/input/virtio-input-hid.c            |   3 -
 hw/input/virtio-input-host.c           |   1 -
 hw/input/virtio-input.c                |   1 -
 hw/intc/apic_common.c                  |   1 -
 hw/intc/arm_gic_common.c               |   1 -
 hw/intc/arm_gicv2m.c                   |   1 -
 hw/intc/arm_gicv3_common.c             |   1 -
 hw/intc/arm_gicv3_its.c                |   1 -
 hw/intc/arm_gicv3_its_kvm.c            |   1 -
 hw/intc/armv7m_nvic.c                  |   1 -
 hw/intc/exynos4210_combiner.c          |   1 -
 hw/intc/exynos4210_gic.c               |   1 -
 hw/intc/goldfish_pic.c                 |   1 -
 hw/intc/grlib_irqmp.c                  |   1 -
 hw/intc/i8259_common.c                 |   1 -
 hw/intc/ioapic.c                       |   1 -
 hw/intc/loongarch_extioi.c             |   1 -
 hw/intc/loongarch_pch_msi.c            |   1 -
 hw/intc/loongarch_pch_pic.c            |   1 -
 hw/intc/loongson_ipi_common.c          |   1 -
 hw/intc/m68k_irqc.c                    |   1 -
 hw/intc/mips_gic.c                     |   1 -
 hw/intc/omap_intc.c                    |   1 -
 hw/intc/ompic.c                        |   1 -
 hw/intc/openpic.c                      |   1 -
 hw/intc/openpic_kvm.c                  |   1 -
 hw/intc/pnv_xive.c                     |   1 -
 hw/intc/pnv_xive2.c                    |   1 -
 hw/intc/ppc-uic.c                      |   1 -
 hw/intc/riscv_aclint.c                 |   2 -
 hw/intc/riscv_aplic.c                  |   1 -
 hw/intc/riscv_imsic.c                  |   1 -
 hw/intc/rx_icu.c                       |   1 -
 hw/intc/s390_flic.c                    |   2 -
 hw/intc/sifive_plic.c                  |   1 -
 hw/intc/spapr_xive.c                   |   1 -
 hw/intc/xics.c                         |   2 -
 hw/intc/xilinx_intc.c                  |   1 -
 hw/intc/xive.c                         |   4 -
 hw/intc/xive2.c                        |   2 -
 hw/intc/xlnx-pmu-iomod-intc.c          |   1 -
 hw/ipack/ipack.c                       |   1 -
 hw/ipmi/ipmi.c                         |   1 -
 hw/ipmi/ipmi_bmc_extern.c              |   1 -
 hw/ipmi/ipmi_bmc_sim.c                 |   1 -
 hw/ipmi/isa_ipmi_bt.c                  |   1 -
 hw/ipmi/isa_ipmi_kcs.c                 |   1 -
 hw/isa/lpc_ich9.c                      |   1 -
 hw/isa/pc87312.c                       |   1 -
 hw/isa/piix.c                          |   1 -
 hw/m68k/mcf5206.c                      |   1 -
 hw/m68k/mcf_intc.c                     |   1 -
 hw/m68k/next-cube.c                    |   1 -
 hw/m68k/q800-glue.c                    |   1 -
 hw/mem/cxl_type3.c                     |   1 -
 hw/mem/nvdimm.c                        |   1 -
 hw/mem/pc-dimm.c                       |   1 -
 hw/mem/sparse-mem.c                    |   1 -
 hw/mips/cps.c                          |   1 -
 hw/misc/a9scu.c                        |   1 -
 hw/misc/allwinner-h3-dramc.c           |   1 -
 hw/misc/allwinner-r40-dramc.c          |   1 -
 hw/misc/allwinner-sid.c                |   1 -
 hw/misc/applesmc.c                     |   1 -
 hw/misc/arm11scu.c                     |   1 -
 hw/misc/arm_l2x0.c                     |   1 -
 hw/misc/arm_sysctl.c                   |   1 -
 hw/misc/armsse-cpuid.c                 |   1 -
 hw/misc/aspeed_hace.c                  |   1 -
 hw/misc/aspeed_i3c.c                   |   1 -
 hw/misc/aspeed_lpc.c                   |   1 -
 hw/misc/aspeed_sbc.c                   |   1 -
 hw/misc/aspeed_scu.c                   |   1 -
 hw/misc/aspeed_sdmc.c                  |   1 -
 hw/misc/bcm2835_cprman.c               |   1 -
 hw/misc/bcm2835_property.c             |   1 -
 hw/misc/debugexit.c                    |   1 -
 hw/misc/eccmemctl.c                    |   1 -
 hw/misc/empty_slot.c                   |   1 -
 hw/misc/iotkit-secctl.c                |   1 -
 hw/misc/iotkit-sysctl.c                |   1 -
 hw/misc/iotkit-sysinfo.c               |   1 -
 hw/misc/ivshmem.c                      |   2 -
 hw/misc/led.c                          |   1 -
 hw/misc/mac_via.c                      |   1 -
 hw/misc/macio/cuda.c                   |   1 -
 hw/misc/macio/macio.c                  |   2 -
 hw/misc/macio/pmu.c                    |   1 -
 hw/misc/mips_cmgcr.c                   |   1 -
 hw/misc/mips_cpc.c                     |   1 -
 hw/misc/mips_itu.c                     |   1 -
 hw/misc/mos6522.c                      |   1 -
 hw/misc/mps2-fpgaio.c                  |   1 -
 hw/misc/mps2-scc.c                     |   1 -
 hw/misc/msf2-sysreg.c                  |   1 -
 hw/misc/npcm7xx_gcr.c                  |   1 -
 hw/misc/nrf51_rng.c                    |   1 -
 hw/misc/pci-testdev.c                  |   1 -
 hw/misc/pvpanic-isa.c                  |   1 -
 hw/misc/pvpanic-pci.c                  |   1 -
 hw/misc/sifive_e_aon.c                 |   1 -
 hw/misc/sifive_u_otp.c                 |   1 -
 hw/misc/stm32l4x5_rcc.c                |   1 -
 hw/misc/tz-mpc.c                       |   1 -
 hw/misc/tz-msc.c                       |   1 -
 hw/misc/tz-ppc.c                       |   1 -
 hw/misc/unimp.c                        |   1 -
 hw/misc/xlnx-versal-cframe-reg.c       |   2 -
 hw/misc/xlnx-versal-cfu.c              |   2 -
 hw/misc/xlnx-versal-trng.c             |   4 +-
 hw/misc/xlnx-versal-xramc.c            |   1 -
 hw/misc/zynq_slcr.c                    |   1 -
 hw/net/allwinner-sun8i-emac.c          |   1 -
 hw/net/allwinner_emac.c                |   1 -
 hw/net/cadence_gem.c                   |   1 -
 hw/net/can/xlnx-versal-canfd.c         |   1 -
 hw/net/can/xlnx-zynqmp-can.c           |   1 -
 hw/net/dp8393x.c                       |   1 -
 hw/net/e1000.c                         |   1 -
 hw/net/e1000e.c                        |   1 -
 hw/net/eepro100.c                      |   1 -
 hw/net/fsl_etsec/etsec.c               |   1 -
 hw/net/ftgmac100.c                     |   2 -
 hw/net/igb.c                           |   1 -
 hw/net/imx_fec.c                       |   1 -
 hw/net/lan9118.c                       |   1 -
 hw/net/lance.c                         |   1 -
 hw/net/lasi_i82596.c                   |   1 -
 hw/net/mcf_fec.c                       |   1 -
 hw/net/mipsnet.c                       |   1 -
 hw/net/msf2-emac.c                     |   1 -
 hw/net/mv88w8618_eth.c                 |   1 -
 hw/net/ne2000-isa.c                    |   1 -
 hw/net/ne2000-pci.c                    |   1 -
 hw/net/npcm7xx_emc.c                   |   1 -
 hw/net/npcm_gmac.c                     |   1 -
 hw/net/opencores_eth.c                 |   1 -
 hw/net/pcnet-pci.c                     |   1 -
 hw/net/rocker/rocker.c                 |   1 -
 hw/net/rtl8139.c                       |   1 -
 hw/net/smc91c111.c                     |   1 -
 hw/net/spapr_llan.c                    |   1 -
 hw/net/stellaris_enet.c                |   1 -
 hw/net/sungem.c                        |   1 -
 hw/net/sunhme.c                        |   1 -
 hw/net/tulip.c                         |   1 -
 hw/net/virtio-net.c                    |   1 -
 hw/net/vmxnet3.c                       |   1 -
 hw/net/xen_nic.c                       |   1 -
 hw/net/xgmac.c                         |   1 -
 hw/net/xilinx_axienet.c                |   1 -
 hw/net/xilinx_ethlite.c                |   1 -
 hw/nubus/nubus-bridge.c                |   1 -
 hw/nubus/nubus-device.c                |   1 -
 hw/nvme/ctrl.c                         |   1 -
 hw/nvme/nguid.c                        |   4 +-
 hw/nvme/ns.c                           |   1 -
 hw/nvme/subsys.c                       |   1 -
 hw/nvram/ds1225y.c                     |   1 -
 hw/nvram/eeprom_at24c.c                |   1 -
 hw/nvram/fw_cfg.c                      |   3 -
 hw/nvram/mac_nvram.c                   |   1 -
 hw/nvram/nrf51_nvm.c                   |   1 -
 hw/nvram/spapr_nvram.c                 |   1 -
 hw/nvram/xlnx-bbram.c                  |   1 -
 hw/nvram/xlnx-efuse.c                  |   1 -
 hw/nvram/xlnx-versal-efuse-cache.c     |   2 -
 hw/nvram/xlnx-versal-efuse-ctrl.c      |   2 -
 hw/nvram/xlnx-zynqmp-efuse.c           |   2 -
 hw/pci-bridge/cxl_downstream.c         |   1 -
 hw/pci-bridge/cxl_root_port.c          |   1 -
 hw/pci-bridge/cxl_upstream.c           |   1 -
 hw/pci-bridge/gen_pcie_root_port.c     |   1 -
 hw/pci-bridge/pci_bridge_dev.c         |   1 -
 hw/pci-bridge/pci_expander_bridge.c    |   2 -
 hw/pci-bridge/pcie_pci_bridge.c        |   1 -
 hw/pci-bridge/pcie_root_port.c         |   1 -
 hw/pci-bridge/xio3130_downstream.c     |   1 -
 hw/pci-host/astro.c                    |   5 --
 hw/pci-host/dino.c                     |   1 -
 hw/pci-host/gpex.c                     |   1 -
 hw/pci-host/grackle.c                  |   1 -
 hw/pci-host/gt64120.c                  |   1 -
 hw/pci-host/i440fx.c                   |   1 -
 hw/pci-host/mv64361.c                  |   1 -
 hw/pci-host/pnv_phb.c                  |   4 -
 hw/pci-host/pnv_phb3.c                 |   1 -
 hw/pci-host/pnv_phb4.c                 |   1 -
 hw/pci-host/pnv_phb4_pec.c             |   1 -
 hw/pci-host/ppce500.c                  |   1 -
 hw/pci-host/q35.c                      |   2 -
 hw/pci-host/raven.c                    |   1 -
 hw/pci-host/sabre.c                    |   1 -
 hw/pci-host/uninorth.c                 |   1 -
 hw/pci-host/versatile.c                |   1 -
 hw/pci-host/xilinx-pcie.c              |   1 -
 hw/pci/pci.c                           |   1 -
 hw/pci/pci_bridge.c                    |   1 -
 hw/pci/pci_host.c                      |   1 -
 hw/pci/pcie_port.c                     |   2 -
 hw/ppc/pnv.c                           |   1 -
 hw/ppc/pnv_adu.c                       |   1 -
 hw/ppc/pnv_chiptod.c                   |   1 -
 hw/ppc/pnv_core.c                      |   2 -
 hw/ppc/pnv_homer.c                     |   1 -
 hw/ppc/pnv_i2c.c                       |   1 -
 hw/ppc/pnv_lpc.c                       |   1 -
 hw/ppc/pnv_pnor.c                      |   1 -
 hw/ppc/pnv_psi.c                       |   1 -
 hw/ppc/ppc405_uc.c                     |   1 -
 hw/ppc/ppc440_uc.c                     |   1 -
 hw/ppc/ppc4xx_devs.c                   |   2 -
 hw/ppc/ppc4xx_sdram.c                  |   2 -
 hw/ppc/prep_systemio.c                 |   1 -
 hw/ppc/rs6000_mc.c                     |   1 -
 hw/ppc/spapr_cpu_core.c                |   1 -
 hw/ppc/spapr_nvdimm.c                  |  10 +--
 hw/ppc/spapr_pci.c                     |   1 -
 hw/ppc/spapr_rng.c                     |   1 -
 hw/ppc/spapr_tpm_proxy.c               |   1 -
 hw/remote/proxy.c                      |   1 -
 hw/riscv/opentitan.c                   |   1 -
 hw/riscv/riscv-iommu-pci.c             |   1 -
 hw/riscv/riscv-iommu.c                 |   1 -
 hw/riscv/riscv_hart.c                  |   1 -
 hw/riscv/sifive_u.c                    |   1 -
 hw/rtc/allwinner-rtc.c                 |   1 -
 hw/rtc/goldfish_rtc.c                  |   1 -
 hw/rtc/m48t59-isa.c                    |   1 -
 hw/rtc/m48t59.c                        |   1 -
 hw/rtc/mc146818rtc.c                   |   1 -
 hw/rtc/pl031.c                         |   1 -
 hw/rx/rx62n.c                          |   1 -
 hw/s390x/3270-ccw.c                    |   5 --
 hw/s390x/ccw-device.c                  |   1 -
 hw/s390x/css-bridge.c                  |   1 -
 hw/s390x/css.c                         |   4 +-
 hw/s390x/ipl.c                         |   1 -
 hw/s390x/s390-pci-bus.c                |   5 +-
 hw/s390x/s390-skeys.c                  |   1 -
 hw/s390x/s390-stattrib.c               |   1 -
 hw/s390x/vhost-scsi-ccw.c              |   1 -
 hw/s390x/vhost-user-fs-ccw.c           |   1 -
 hw/s390x/vhost-vsock-ccw.c             |   1 -
 hw/s390x/virtio-ccw-9p.c               |   1 -
 hw/s390x/virtio-ccw-balloon.c          |   1 -
 hw/s390x/virtio-ccw-blk.c              |   1 -
 hw/s390x/virtio-ccw-crypto.c           |   1 -
 hw/s390x/virtio-ccw-gpu.c              |   1 -
 hw/s390x/virtio-ccw-input.c            |   1 -
 hw/s390x/virtio-ccw-net.c              |   1 -
 hw/s390x/virtio-ccw-rng.c              |   1 -
 hw/s390x/virtio-ccw-scsi.c             |   1 -
 hw/s390x/virtio-ccw-serial.c           |   1 -
 hw/scsi/megasas.c                      |   7 +-
 hw/scsi/mptsas.c                       |   1 -
 hw/scsi/scsi-bus.c                     |   1 -
 hw/scsi/scsi-disk.c                    |   3 -
 hw/scsi/scsi-generic.c                 |   1 -
 hw/scsi/spapr_vscsi.c                  |   1 -
 hw/scsi/vhost-scsi.c                   |   1 -
 hw/scsi/vhost-user-scsi.c              |   1 -
 hw/scsi/virtio-scsi.c                  |   1 -
 hw/scsi/vmw_pvscsi.c                   |   1 -
 hw/sd/allwinner-sdhost.c               |   1 -
 hw/sd/aspeed_sdhci.c                   |   1 -
 hw/sd/sd.c                             |   3 -
 hw/sd/sdhci-pci.c                      |   1 -
 hw/sd/sdhci.c                          |   1 -
 hw/sparc/sun4m.c                       |   5 --
 hw/sparc/sun4m_iommu.c                 |   1 -
 hw/sparc64/sun4u.c                     |   7 --
 hw/ssi/aspeed_smc.c                    |   2 -
 hw/ssi/ibex_spi_host.c                 |   1 -
 hw/ssi/npcm7xx_fiu.c                   |   1 -
 hw/ssi/pnv_spi.c                       |   1 -
 hw/ssi/sifive_spi.c                    |   1 -
 hw/ssi/ssi.c                           |   1 -
 hw/ssi/xilinx_spi.c                    |   1 -
 hw/ssi/xilinx_spips.c                  |   2 -
 hw/ssi/xlnx-versal-ospi.c              |   1 -
 hw/timer/a9gtimer.c                    |   1 -
 hw/timer/allwinner-a10-pit.c           |   1 -
 hw/timer/arm_mptimer.c                 |   1 -
 hw/timer/arm_timer.c                   |   1 -
 hw/timer/aspeed_timer.c                |   1 -
 hw/timer/avr_timer16.c                 |   1 -
 hw/timer/grlib_gptimer.c               |   1 -
 hw/timer/hpet.c                        |   1 -
 hw/timer/i8254_common.c                |   1 -
 hw/timer/ibex_timer.c                  |   1 -
 hw/timer/mss-timer.c                   |   1 -
 hw/timer/nrf51_timer.c                 |   1 -
 hw/timer/pxa2xx_timer.c                |   1 -
 hw/timer/renesas_cmt.c                 |   1 -
 hw/timer/renesas_tmr.c                 |   1 -
 hw/timer/sifive_pwm.c                  |   1 -
 hw/timer/slavio_timer.c                |   1 -
 hw/timer/sse-timer.c                   |   1 -
 hw/timer/stm32f2xx_timer.c             |   1 -
 hw/timer/xilinx_timer.c                |   1 -
 hw/tpm/tpm_crb.c                       |   1 -
 hw/tpm/tpm_spapr.c                     |   1 -
 hw/tpm/tpm_tis_i2c.c                   |   1 -
 hw/tpm/tpm_tis_isa.c                   |   1 -
 hw/tpm/tpm_tis_sysbus.c                |   1 -
 hw/tricore/tc27x_soc.c                 |   5 --
 hw/tricore/tricore_testdevice.c        |   5 --
 hw/ufs/lu.c                            |   1 -
 hw/ufs/ufs.c                           |   1 -
 hw/usb/bus.c                           |   1 -
 hw/usb/canokey.c                       |   1 -
 hw/usb/ccid-card-emulated.c            |   1 -
 hw/usb/ccid-card-passthru.c            |   1 -
 hw/usb/dev-audio.c                     |   1 -
 hw/usb/dev-hid.c                       |   3 -
 hw/usb/dev-hub.c                       |   1 -
 hw/usb/dev-mtp.c                       |   1 -
 hw/usb/dev-network.c                   |   1 -
 hw/usb/dev-serial.c                    |   2 -
 hw/usb/dev-smartcard-reader.c          |   2 -
 hw/usb/dev-storage-classic.c           |   1 -
 hw/usb/dev-uas.c                       |   1 -
 hw/usb/hcd-dwc2.c                      |   1 -
 hw/usb/hcd-dwc3.c                      |   1 -
 hw/usb/hcd-ehci-pci.c                  |   1 -
 hw/usb/hcd-ehci-sysbus.c               |   1 -
 hw/usb/hcd-ohci-pci.c                  |   1 -
 hw/usb/hcd-ohci-sysbus.c               |   1 -
 hw/usb/hcd-uhci.c                      |   2 -
 hw/usb/hcd-xhci-nec.c                  |   1 -
 hw/usb/hcd-xhci-sysbus.c               |   1 -
 hw/usb/hcd-xhci.c                      |   1 -
 hw/usb/host-libusb.c                   |   1 -
 hw/usb/redirect.c                      |   1 -
 hw/usb/u2f-emulated.c                  |   1 -
 hw/usb/u2f-passthru.c                  |   1 -
 hw/vfio/ap.c                           |   1 -
 hw/vfio/ccw.c                          |   1 -
 hw/vfio/pci-quirks.c                   |   4 +-
 hw/vfio/pci.c                          |   2 -
 hw/vfio/platform.c                     |   1 -
 hw/virtio/vdpa-dev-pci.c               |   5 --
 hw/virtio/vdpa-dev.c                   |   1 -
 hw/virtio/vhost-scsi-pci.c             |   1 -
 hw/virtio/vhost-user-blk-pci.c         |   1 -
 hw/virtio/vhost-user-device.c          |   1 -
 hw/virtio/vhost-user-fs-pci.c          |   1 -
 hw/virtio/vhost-user-fs.c              |   1 -
 hw/virtio/vhost-user-gpio.c            |   1 -
 hw/virtio/vhost-user-i2c.c             |   1 -
 hw/virtio/vhost-user-input.c           |   1 -
 hw/virtio/vhost-user-rng-pci.c         |   1 -
 hw/virtio/vhost-user-rng.c             |   1 -
 hw/virtio/vhost-user-scmi.c            |   1 -
 hw/virtio/vhost-user-scsi-pci.c        |   1 -
 hw/virtio/vhost-user-snd-pci.c         |   5 --
 hw/virtio/vhost-user-snd.c             |   1 -
 hw/virtio/vhost-user-vsock-pci.c       |   1 -
 hw/virtio/vhost-user-vsock.c           |   1 -
 hw/virtio/vhost-vsock-common.c         |   1 -
 hw/virtio/vhost-vsock-pci.c            |   1 -
 hw/virtio/vhost-vsock.c                |   1 -
 hw/virtio/virtio-9p-pci.c              |   1 -
 hw/virtio/virtio-balloon.c             |   1 -
 hw/virtio/virtio-blk-pci.c             |   1 -
 hw/virtio/virtio-crypto-pci.c          |   1 -
 hw/virtio/virtio-crypto.c              |   1 -
 hw/virtio/virtio-input-pci.c           |   1 -
 hw/virtio/virtio-iommu-pci.c           |   1 -
 hw/virtio/virtio-iommu.c               |   1 -
 hw/virtio/virtio-mem.c                 |   1 -
 hw/virtio/virtio-mmio.c                |   1 -
 hw/virtio/virtio-net-pci.c             |   1 -
 hw/virtio/virtio-nsm.c                 |   1 -
 hw/virtio/virtio-pci.c                 |   2 -
 hw/virtio/virtio-pmem.c                |   1 -
 hw/virtio/virtio-rng-pci.c             |   1 -
 hw/virtio/virtio-rng.c                 |   1 -
 hw/virtio/virtio-scsi-pci.c            |   1 -
 hw/virtio/virtio-serial-pci.c          |   1 -
 hw/virtio/virtio.c                     |   1 -
 hw/watchdog/sbsa_gwdt.c                |   1 -
 hw/watchdog/wdt_aspeed.c               |   1 -
 hw/watchdog/wdt_imx2.c                 |   1 -
 hw/xen/xen-bus.c                       |   1 -
 hw/xen/xen-legacy-backend.c            |  17 ----
 hw/xen/xen_pt.c                        |   1 -
 migration/migration.c                  |   3 +-
 migration/options.c                    |   4 +-
 system/qdev-monitor.c                  |  15 ++--
 target/arm/cpu.c                       |   1 -
 target/avr/cpu.c                       |   1 -
 target/hexagon/cpu.c                   |   1 -
 target/i386/cpu.c                      |   2 -
 target/microblaze/cpu.c                |   1 -
 target/mips/cpu.c                      |   1 -
 target/ppc/cpu_init.c                  |   6 --
 target/riscv/cpu.c                     |  13 ++-
 target/s390x/cpu.c                     |   7 +-
 target/sparc/cpu.c                     |   1 -
 tests/unit/test-qdev-global-props.c    |   1 -
 docs/devel/migration/compatibility.rst |   1 -
 docs/devel/virtio-backends.rst         |   1 -
 rust/qemu-api/src/device_class.rs      |  11 +--
 579 files changed, 176 insertions(+), 816 deletions(-)

-- 
2.43.0


