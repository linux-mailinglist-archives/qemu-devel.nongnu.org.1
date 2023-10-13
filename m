Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102E7C7F8E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3a-0005l3-C7; Fri, 13 Oct 2023 03:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3V-0005SM-1b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:57:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3R-0006gR-65
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:57:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1941064f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183871; x=1697788671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GWEDDjpnotGgfjBWIGymqSBCTGiIkdJBZqbb3fHuwY0=;
 b=r83Armhj/Pfnxmg4JiURmW1kI9rL8nz71vWeq70IeDbpaeoJnXE5SVAnJW4yMPZwKe
 6LnrTUEgJVGscddptvyOG6ye7d6kPMCBYmTYI/ydnK2E7X5KJhsaOJB0w0BzG4iRihuO
 SJeXknyBcIULWAcX+5R3fJXB2IUb6Lo07lARJZx16KNYtPiQHzUMtR7KHN9jlZZ/e3MS
 b5Ax63gvlOlgBwI57HYEcc3YOFfPQacRCAMGEmf8e2kv8fOVDvz1LuC0z/7KRhIC/Efl
 cC75piAu/Rb+K0mc+QsVPdRQy6DlitEg0dKLqweqVQqxHpvA80mtOIdhPdBOCeVcx8wF
 cVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183871; x=1697788671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GWEDDjpnotGgfjBWIGymqSBCTGiIkdJBZqbb3fHuwY0=;
 b=aC/1bMwmFehZrJ6t6lUpNOZ54JuL7xakTzgS5pSZRQMCIUBfKwMrM7yOkoyZEgQI8W
 gU4X55nLOJ/DAon5aAgQ8H0ZrfHJVGYz2Y14WGjGJVzr4Uq0RK614xzXAdwqhXOP6zZT
 /78P86JNgQIbaWwTpxFQa4QA32HkTOVNc1fHGYcvLrhqD2RxtdwfTJxA7ltQ7BoeaNce
 1JhA3LW/JOjHsiKdPVGTuqa3zpdtpRd3BTn9F8g4VLKSe6j6CoFYEyxhL/aazXzE/I9Z
 6/fS3tW7beswRGA6bQKgWhjagC0bkHbgasbVtA9BljdoiBhehHLO2qOJwHWS/f0OaQdL
 4eaA==
X-Gm-Message-State: AOJu0YzXFAieHnLoZrlgU94IaJBA7/iQbkylOlGxTK45/68kbcb4i7PS
 k2cFlzipALsSETk6Rjp4S9yhzK0MmW9c2KluJDI=
X-Google-Smtp-Source: AGHT+IHJhu7Z+eZgDXz1TG0wi2rK1uEEenf24D0Sl+HXaYnwmS6X9cmkVilwuzEVlBtYQXVQB0EU2A==
X-Received: by 2002:a05:6000:1c6:b0:320:67:1887 with SMTP id
 t6-20020a05600001c600b0032000671887mr19228401wrx.28.1697183871002; 
 Fri, 13 Oct 2023 00:57:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:57:50 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 00/78] Strict disable implicit fallthrough
Date: Fri, 13 Oct 2023 10:56:27 +0300
Message-Id: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

/* resubmitted because git-send-email crashed with previous attempt */

Hello,

This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
back in 2019.[0]
We take one step (or two) further by increasing it to 5 which rejects
fall through comments and requires an attribute statement.

[0]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b

The line differences are not many, but they spread all over different
subsystems, architectures and devices. An attempt has been made to split
them in cohesive patches to aid post-RFC review. Part of the RFC is to
determine whether these patch divisions needs improvement.

Main questions this RFC poses
=============================

- Is this change desirable and net-positive.
- Should the `fallthrough;` pseudo-keyword be defined like in the Linux
  kernel, or use glib's G_GNUC_FALLTHROUGH, or keep the already existing
  QEMU_FALLTHROUGH macro.
- Should fallthrough comments be removed if they do not include extra
  information.

Some external resources
=======================

See the RFC discussion in the kernel:

https://lore.kernel.org/lkml/1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com/

The `fallthrough;` pseudo-keyword in the kernel source code:

https://elixir.bootlin.com/linux/latest/C/ident/fallthrough

In summary, I quote the doc comment and definition:

    /*
     * Add the pseudo keyword 'fallthrough' so case statement blocks
     * must end with any of these keywords:
     *   break;
     *   fallthrough;
     *   continue;
     *   goto <label>;
     *   return [expression];
     *
     *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
     */
    #if __has_attribute(__fallthrough__)
    # define fallthrough                    __attribute__((__fallthrough__))
    #else
    # define fallthrough                    do {} while (0)  /* fallthrough */
    #endif

Background - Motivation
=======================

The C switch statement allows you to conditionally goto different labels
depending on a value. A break; statement conveniently goto's the end of
the switch. If a "case" does not end in a break, we say that the control
flow falls through the next case label, if any, implicitly. This can
lead to bugs and QEMU uses the GCC warning -Wimplicit-fallthrough to
prevent this.

Currently, QEMU is built with -Wimplicit-fallthrough=2. This makes GCC's
static analyzer check for a case-insensitive matches of the .*falls?[
\t-]*thr(ough|u).* regular expression. This means the following list of
comments taken from QEMU all disable the implicit fallthrough warning:

- /* FALLTHRU */
- /* fall through */
- /* Fall through.  */
- /* Fall through... */
- /* fall through if hEventTimeout is signaled */
- /* FALL THROUGH */

To keep a constistent code style, this commit adds a macro `fallthrough`
that looks like a C keyword but expands to an attribute statement in
supported compilers (GCC at the moment).

Note: there was already such a macro, QEMU_FALLTHROUGH, and it was used
only around 7 times in the code base. The first commit replaces it.

Emmanouil Pitsidianakis (78):
  include/qemu/compiler.h: replace QEMU_FALLTHROUGH with fallthrough
  block: add fallthrough pseudo-keyword
  fpu/softfloat: add fallthrough pseudo-keyword
  qapi/opts-visitor: add fallthrough pseudo-keyword
  qobject/json: add fallthrough pseudo-keyword
  tcg: add fallthrough pseudo-keyword
  hw/virtio/virtio-balloon.c: add fallthrough pseudo-keyword
  hw/block: add fallthrough pseudo-keyword
  hw/acpi/aml-build.c: add fallthrough pseudo-keyword
  hw/ide/atapi.c: add fallthrough pseudo-keyword
  hw/timer: add fallthrough pseudo-keyword
  hw/usb: add fallthrough pseudo-keyword
  hw/adc: add fallthrough pseudo-keyword
  util/error-report.c: add fallthrough pseudo-keyword
  accel/tcg: add fallthrough pseudo-keyword
  audio: add fallthrough pseudo-keyword
  ui/sdl2.c: add fallthrough pseudo-keyword
  ui/win32-kbd-hook.c: add fallthrough pseudo-keyword
  target/hppa: add fallthrough pseudo-keyword
  target/mips: add fallthrough pseudo-keyword
  target/sparc: add fallthrough pseudo-keyword
  target/ppc: add fallthrough pseudo-keyword
  target/arm: add fallthrough pseudo-keyword
  target/alpha: add fallthrough pseudo-keyword
  target/i386: add fallthrough pseudo-keyword
  target/s390x: add fallthrough pseudo-keyword
  target/riscv: add fallthrough pseudo-keyword
  target/avr: add fallthrough pseudo-keyword
  target/cris: add fallthrough pseudo-keyword
  target/nios2: add fallthrough pseudo-keyword
  target/xtensa: add fallthrough pseudo-keyword
  target/m68k: add fallthrough pseudo-keyword
  target/rx: add fallthrough pseudo-keyword
  target/tricore: add fallthrough pseudo-keyword
  target/sh4: add fallthrough pseudo-keyword
  target/openrisc: add fallthrough pseudo-keyword
  target/hexagon: add fallthrough pseudo-keyword
  system/rtc.c: add fallthrough pseudo-keyword
  hw/scsi: add fallthrough pseudo-keyword
  hw/sd/sdhci.c: add fallthrough pseudo-keyword
  linux-user: add fallthrough pseudo-keyword
  hw/i386: add fallthrough pseudo-keyword
  hw/misc: add fallthrough pseudo-keyword
  hw/m68k/mcf_intc.c: add fallthrough pseudo-keyword
  hw/dma: add fallthrough pseudo-keyword
  disas: add fallthrough pseudo-keyword
  contrib/rdmacm-mux: add fallthrough pseudo-keyword
  contrib/vhost-user-scsi: add fallthrough pseudo-keyword
  hw/arm: add fallthrough pseudo-keyword
  hw/audio: add fallthrough pseudo-keyword
  chardev: add fallthrough pseudo-keyword
  hw/char: add fallthrough pseudo-keyword
  nbd: add fallthrough pseudo-keyword
  hw/core: add fallthrough pseudo-keyword
  hw/display: add fallthrough pseudo-keyword
  hw/input: add fallthrough pseudo-keyword
  hw/net: add fallthrough pseudo-keyword
  hw/ppc: add fallthrough pseudo-keyword
  hw/intc: add fallthrough pseudo-keyword
  qga: add fallthrough pseudo-keyword
  semihosting: add fallthrough pseudo-keyword
  hw/gpio: add fallthrough pseudo-keyword
  hw/ipmi: add fallthrough pseudo-keyword
  hw/mips: add fallthrough pseudo-keyword
  hw/nvme: add fallthrough pseudo-keyword
  hw/nvram/eeprom_at24c.c: add fallthrough pseudo-keyword
  hw/pci-host/pnv_phb3.c: add fallthrough pseudo-keyword
  hw/pci: add fallthrough pseudo-keyword
  hw/rdma/rdma_backend.c: add fallthrough pseudo-keyword
  hw/rtc: add fallthrough pseudo-keyword
  hw/s390x: add fallthrough pseudo-keyword
  hw/ssi: add fallthrough pseudo-keyword
  hw/watchdog/wdt_diag288.c: add fallthrough pseudo-keyword
  hw/cxl/cxl-device-utils.c: add fallthrough pseudo-keyword
  migration: add fallthrough pseudo-keyword
  qemu-img.c: add fallthrough pseudo-keyword
  tests/unit/test-char.c: add fallthrough pseudo-keyword
  meson.build: increase -Wimplicit-fallthrough to 5

 accel/tcg/cputlb.c                          |  4 +-
 accel/tcg/ldst_atomicity.c.inc              |  2 +-
 accel/tcg/plugin-gen.c                      |  2 +-
 audio/audio.c                               | 16 ++--
 audio/jackaudio.c                           |  4 +-
 audio/pwaudio.c                             | 12 +--
 block/block-copy.c                          |  1 +
 block/file-posix.c                          |  1 +
 block/io.c                                  |  1 +
 block/iscsi.c                               |  1 +
 block/qcow2-cluster.c                       |  5 +-
 block/vhdx.c                                | 17 +++-
 chardev/char-socket.c                       |  2 +-
 contrib/rdmacm-mux/main.c                   | 10 +--
 contrib/vhost-user-scsi/vhost-user-scsi.c   |  3 +-
 disas/hppa.c                                |  4 +-
 disas/m68k.c                                |  2 +-
 disas/sh4.c                                 |  6 +-
 disas/sparc.c                               |  2 +-
 docs/devel/style.rst                        | 23 +++++
 fpu/softfloat-parts.c.inc                   |  8 +-
 fpu/softfloat.c                             |  7 +-
 hw/acpi/aml-build.c                         |  6 +-
 hw/adc/aspeed_adc.c                         | 12 +--
 hw/adc/zynq-xadc.c                          |  2 +-
 hw/arm/omap1.c                              |  8 +-
 hw/arm/pxa2xx.c                             |  6 +-
 hw/arm/smmuv3.c                             |  2 +-
 hw/arm/stellaris.c                          |  1 +
 hw/audio/asc.c                              |  2 +-
 hw/audio/cs4231a.c                          |  2 +-
 hw/audio/gusemu_hal.c                       |  2 +-
 hw/block/dataplane/xen-block.c              |  4 +-
 hw/block/m25p80.c                           |  2 +-
 hw/block/onenand.c                          |  2 +-
 hw/block/pflash_cfi01.c                     |  1 +
 hw/block/pflash_cfi02.c                     |  6 +-
 hw/char/nrf51_uart.c                        |  4 +-
 hw/core/loader.c                            |  2 +-
 hw/cxl/cxl-device-utils.c                   |  4 +-
 hw/display/cg3.c                            |  2 +-
 hw/display/cirrus_vga.c                     |  2 +-
 hw/display/tcx.c                            |  4 +-
 hw/dma/omap_dma.c                           | 32 +++----
 hw/dma/pxa2xx_dma.c                         |  4 +-
 hw/dma/sparc32_dma.c                        |  2 +-
 hw/gpio/omap_gpio.c                         |  2 +-
 hw/i2c/bitbang_i2c.c                        |  2 +-
 hw/i386/intel_iommu.c                       |  4 +-
 hw/i386/kvm/xen_evtchn.c                    |  2 +-
 hw/i386/x86.c                               |  2 +-
 hw/ide/atapi.c                              |  1 +
 hw/input/hid.c                              |  3 +-
 hw/input/tsc2005.c                          |  4 +-
 hw/input/tsc210x.c                          |  2 +-
 hw/intc/apic.c                              |  2 +-
 hw/intc/arm_gicv3_kvm.c                     | 16 ++--
 hw/intc/armv7m_nvic.c                       | 12 +--
 hw/intc/xilinx_intc.c                       |  2 +-
 hw/ipmi/ipmi_bmc_extern.c                   |  2 +-
 hw/ipmi/smbus_ipmi.c                        |  4 +-
 hw/m68k/mcf_intc.c                          |  2 +-
 hw/mips/boston.c                            | 12 +--
 hw/misc/a9scu.c                             |  2 +
 hw/misc/aspeed_scu.c                        |  2 +-
 hw/misc/bcm2835_property.c                  | 12 +--
 hw/misc/mos6522.c                           |  4 +-
 hw/net/cadence_gem.c                        |  4 +-
 hw/net/can/can_sja1000.c                    |  4 +-
 hw/net/igb_core.c                           |  2 +-
 hw/net/igbvf.c                              |  2 +-
 hw/net/imx_fec.c                            |  2 +-
 hw/net/net_rx_pkt.c                         |  2 +-
 hw/net/pcnet.c                              |  2 +-
 hw/net/rtl8139.c                            |  6 +-
 hw/net/xilinx_ethlite.c                     |  2 +-
 hw/nvme/ctrl.c                              | 24 +++---
 hw/nvme/dif.c                               |  4 +-
 hw/nvram/eeprom_at24c.c                     |  2 +-
 hw/pci-host/pnv_phb3.c                      |  2 +-
 hw/pci/pcie_aer.c                           |  3 +-
 hw/pci/pcie_doe.c                           |  2 +-
 hw/ppc/pnv_bmc.c                            |  2 +-
 hw/ppc/spapr_events.c                       |  1 +
 hw/rdma/rdma_backend.c                      |  2 +-
 hw/rtc/aspeed_rtc.c                         |  4 +-
 hw/rtc/mc146818rtc.c                        |  4 +-
 hw/s390x/ipl.c                              |  1 +
 hw/s390x/s390-pci-inst.c                    |  4 +-
 hw/s390x/sclp.c                             |  4 +-
 hw/scsi/esp.c                               |  2 +-
 hw/scsi/megasas.c                           |  2 +-
 hw/scsi/scsi-bus.c                          |  4 +-
 hw/scsi/scsi-disk.c                         |  2 +-
 hw/sd/sdhci.c                               |  8 +-
 hw/ssi/npcm7xx_fiu.c                        | 14 +--
 hw/ssi/omap_spi.c                           | 48 +++++------
 hw/timer/a9gtimer.c                         |  8 +-
 hw/timer/aspeed_timer.c                     |  1 +
 hw/timer/pxa2xx_timer.c                     | 94 ++++++++++-----------
 hw/timer/renesas_tmr.c                      |  2 +-
 hw/timer/sh_timer.c                         |  8 +-
 hw/usb/dev-mtp.c                            |  2 +-
 hw/usb/dev-wacom.c                          |  2 +-
 hw/usb/hcd-ehci.c                           |  4 +-
 hw/usb/hcd-xhci.c                           |  4 +-
 hw/usb/redirect.c                           |  4 +-
 hw/usb/tusb6010.c                           |  2 +-
 hw/virtio/virtio-balloon.c                  |  1 +
 hw/watchdog/wdt_diag288.c                   |  2 +-
 include/qemu/compiler.h                     | 30 +++++--
 include/qemu/osdep.h                        |  4 +-
 linux-user/mips/cpu_loop.c                  |  8 +-
 linux-user/mmap.c                           |  2 +-
 linux-user/syscall.c                        |  2 +-
 meson.build                                 |  2 +-
 migration/migration.c                       |  2 +-
 nbd/client.c                                |  4 +-
 nbd/common.c                                |  2 +-
 qapi/opts-visitor.c                         |  1 +
 qapi/string-input-visitor.c                 |  4 +-
 qemu-img.c                                  |  2 +-
 qemu-nbd.c                                  |  4 +-
 qga/main.c                                  |  2 +-
 qga/vss-win32/requester.cpp                 |  1 +
 qobject/json-lexer.c                        |  4 +-
 qobject/json-parser.c                       |  5 +-
 semihosting/arm-compat-semi.c               |  2 +-
 system/rtc.c                                |  2 +-
 target/alpha/helper.c                       |  6 +-
 target/alpha/translate.c                    |  4 +-
 target/arm/helper.c                         | 34 ++++----
 target/arm/ptw.c                            | 10 +--
 target/arm/tcg/psci.c                       |  2 +-
 target/arm/tcg/translate-a64.c              | 76 ++++++++---------
 target/arm/tcg/translate-m-nocp.c           |  2 +-
 target/arm/tcg/translate-vfp.c              |  2 +-
 target/arm/tcg/translate.c                  |  8 +-
 target/avr/translate.c                      |  4 +-
 target/cris/translate.c                     |  4 +-
 target/hexagon/idef-parser/parser-helpers.c |  5 +-
 target/hppa/translate.c                     | 10 +--
 target/i386/cpu.c                           |  2 +-
 target/i386/hvf/x86_decode.c                |  1 +
 target/i386/kvm/kvm.c                       |  4 +-
 target/i386/tcg/decode-new.c.inc            |  6 +-
 target/i386/tcg/emit.c.inc                  |  2 +-
 target/i386/tcg/translate.c                 | 11 +--
 target/loongarch/cpu.c                      |  4 +-
 target/loongarch/translate.c                |  2 +-
 target/m68k/op_helper.c                     |  3 +-
 target/m68k/translate.c                     | 10 +--
 target/mips/sysemu/physaddr.c               |  2 +-
 target/mips/tcg/micromips_translate.c.inc   |  4 +-
 target/mips/tcg/mips16e_translate.c.inc     | 30 +++----
 target/mips/tcg/mxu_translate.c             |  8 +-
 target/mips/tcg/nanomips_translate.c.inc    |  4 +-
 target/mips/tcg/op_helper.c                 |  2 +-
 target/mips/tcg/translate.c                 | 79 ++++++++---------
 target/nios2/helper.c                       |  6 +-
 target/nios2/translate.c                    |  2 +-
 target/openrisc/mmu.c                       |  2 +-
 target/openrisc/translate.c                 |  2 +-
 target/ppc/cpu_init.c                       |  8 +-
 target/ppc/excp_helper.c                    |  6 +-
 target/ppc/mmu-radix64.c                    |  6 +-
 target/ppc/mmu_common.c                     | 12 +--
 target/ppc/translate.c                      |  6 +-
 target/riscv/insn_trans/trans_rvi.c.inc     |  2 +-
 target/riscv/insn_trans/trans_rvzce.c.inc   | 22 ++---
 target/riscv/translate.c                    |  4 +-
 target/rx/translate.c                       |  2 +-
 target/s390x/cpu.c                          |  4 +-
 target/s390x/kvm/kvm.c                      |  2 +-
 target/s390x/mmu_helper.c                   |  6 +-
 target/s390x/tcg/translate.c                | 18 ++--
 target/s390x/tcg/translate_vx.c.inc         |  2 +-
 target/sh4/helper.c                         |  2 +-
 target/sparc/ldst_helper.c                  |  4 +-
 target/sparc/mmu_helper.c                   |  6 +-
 target/sparc/translate.c                    |  3 +-
 target/sparc/win_helper.c                   |  1 +
 target/tricore/translate.c                  |  4 +-
 target/xtensa/op_helper.c                   |  8 +-
 target/xtensa/translate.c                   |  2 +-
 tcg/aarch64/tcg-target.c.inc                | 15 +++-
 tcg/arm/tcg-target.c.inc                    |  5 +-
 tcg/i386/tcg-target.c.inc                   | 20 +++--
 tcg/loongarch64/tcg-target.c.inc            |  4 +-
 tcg/mips/tcg-target.c.inc                   |  8 +-
 tcg/optimize.c                              |  8 +-
 tcg/ppc/tcg-target.c.inc                    | 19 +++--
 tcg/riscv/tcg-target.c.inc                  |  5 +-
 tcg/s390x/tcg-target.c.inc                  |  8 +-
 tcg/tcg-op-gvec.c                           | 24 +++---
 tcg/tcg-op-ldst.c                           |  2 +-
 tcg/tcg.c                                   | 24 +++---
 tcg/tci.c                                   |  2 +-
 tcg/tci/tcg-target.c.inc                    |  2 +-
 tests/unit/test-char.c                      |  2 +-
 ui/sdl2.c                                   |  2 +-
 ui/win32-kbd-hook.c                         |  7 --
 util/error-report.c                         |  2 +-
 203 files changed, 747 insertions(+), 618 deletions(-)


base-commit: cea3ea670fe265421131aad90c36fbb87bc4d206
-- 
2.39.2


