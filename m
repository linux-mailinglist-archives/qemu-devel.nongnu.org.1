Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B637DF907
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyben-0003Fd-Vt; Thu, 02 Nov 2023 13:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeU-00038M-S7
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeQ-0002gy-SE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso8812835e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946717; x=1699551517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oJYaKaW0K8dIbaugO4wx8grWssAr0pEnNmdnnPhUOJg=;
 b=skMxmFStTzGxdYq/boqpL4UWRQGkn4W/lHnr1gBMCznsD4NUc5CsMqwRJpHS9VHNd+
 xiuctvRs+C/OJsdk3NskuM0eBrPclvdqwtWyWk3OzENRCOgQTsJK40Yg6T92rui4gWMy
 wXDzXuCsohdMCNfk/159SOIQ4A7CvlUzfNuPVn4Kb+HaOZxHgHWjT8Hw0+vpKTfKIqqK
 HklA4ZuNwWIH26B+EntqbgGNiQj+N3YALp83UtspLAYRD3lho9ZUUCMVpsyFPM/+9Q+6
 Yj2JOhSMgZmGo8HR9YFyrsmrDToSonai9smjgMWskqSHXx7wI1SZyLNHKbr4/mFbeY0N
 5huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946717; x=1699551517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oJYaKaW0K8dIbaugO4wx8grWssAr0pEnNmdnnPhUOJg=;
 b=Vp3dSh1LGkgJTLJsUxfJLlbGnjGPE97IugymG6rOce9yzvi8Q8C8i4gfWsYEFt9WJk
 GHIh2javT8Mm5ADKvbth4lhm/6elbwLx8xDGRGuU+eIS00YUkKGrt8IG9mSvYSxmTzcY
 5gASe6R5aIkVVqqVOI15NCqizmFQzpcvQ4HmodmU9M69L3M/oduPnSB8muK/WBuV7xH6
 ZnJaoaYYqWuMr8Ry5UncmduDNna9QcCcKJG+ghpje9Es6qyRb6FWCTOop6vKuB5fKQTC
 59+7qqaRdUgqDAqE+20TuN5RFUTKR5+CajK5OqAhai+PR1OcOCIAbsKgwgxuywIbhgyt
 kJ0w==
X-Gm-Message-State: AOJu0YxddG2c0wxEaLvc1f/VyM3TONpFuCoAHd3cwKrHD1m87PGqtm3h
 hrlvGTZkw3/lYu7WZuY57snOqW/pUZwZlBM3lc0=
X-Google-Smtp-Source: AGHT+IEq6DodLHEeWF2o1BA2puUQDNUvbxPH7t9WABFcPvO9rFZIrw3vt3KhO5DGtLnLbVU1Iulcxg==
X-Received: by 2002:a5d:65d2:0:b0:32d:9b32:8a7e with SMTP id
 e18-20020a5d65d2000000b0032d9b328a7emr12575114wrw.71.1698946716667; 
 Thu, 02 Nov 2023 10:38:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] target-arm queue
Date: Thu,  2 Nov 2023 17:38:02 +0000
Message-Id: <20231102173835.609985-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi; here's the latest target-arm pull request. Nothing too
exciting, just an accumulation of refactorings, minor features
and bugfixes. (I checked that the tag has propagated to all
the git.linaro.org mirrors.)

thanks
-- PMM

The following changes since commit 6c9ae1ce82b65faa3f266fd103729878cf11e07e:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2023-11-01 06:58:11 +0900)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231102

for you to fetch changes up to 1c98a821a2b3620c516f3da0d74719ed6f33bced:

  tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device (2023-11-02 14:42:03 +0000)

----------------------------------------------------------------
target-arm queue:
 * linux-user/elfload: Add missing arm64 hwcap values
 * stellaris-gamepad: Convert to qdev
 * docs/specs: Convert various txt docs to rST
 * MAINTAINERS: Make sure that gicv3_internal.h is covered, too
 * hw/arm/pxa2xx_gpio: Pass CPU using QOM link property
 * hw/watchdog/wdt_imx2: Trace MMIO access and timer activity
 * hw/misc/imx7_snvs: Trace MMIO access
 * hw/misc/imx6_ccm: Convert DPRINTF to trace events
 * hw/i2c/pm_smbus: Convert DPRINTF to trace events
 * target/arm: Enable FEAT_MOPS insns in user-mode emulation
 * linux-user: Report AArch64 hwcap2 fields above bit 31
 * target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR correctly
 * target/arm: Fix SVE STR increment
 * hw/char/stm32f2xx_usart: implement TX interrupts
 * target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage walk
 * xlnx-versal-virt: Add AMD/Xilinx TRNG device

----------------------------------------------------------------
Bernhard Beschow (5):
      hw/watchdog/wdt_imx2: Trace MMIO access
      hw/watchdog/wdt_imx2: Trace timer activity
      hw/misc/imx7_snvs: Trace MMIO access
      hw/misc/imx6_ccm: Convert DPRINTF to trace events
      hw/i2c/pm_smbus: Convert DPRINTF to trace events

Hans-Erik Floryd (3):
      hw/char/stm32f2xx_usart: Extract common IRQ update code to update_irq()
      hw/char/stm32f2xx_usart: Update IRQ when DR is written
      hw/char/stm32f2xx_usart: Add more definitions for CR1 register

Kevin Wolf (1):
      qdev: Add qdev_prop_set_array()

Marielle Novastrider (1):
      linux-user/elfload: Add missing arm64 hwcap values

Peter Maydell (17):
      hw/input/stellaris_input: Rename to stellaris_gamepad
      hw/input/stellaris_gamepad: Rename structs to our usual convention
      hw/input/stellaris_gamepad: Remove StellarisGamepadButton struct
      hw/input/stellaris_input: Convert to qdev
      hw/input/stellaris_gamepad: Convert to qemu_input_handler_register()
      docs/specs/vmw_pvscsi-spec: Convert to rST
      docs/specs/edu: Convert to rST
      docs/specs/ivshmem-spec: Convert to rST
      docs/specs/pvpanic: Convert to rST
      docs/specs/standard-vga: Convert to rST
      docs/specs/virt-ctlr: Convert to rST
      docs/specs/vmcoreinfo: Convert to rST
      docs/specs/vmgenid: Convert to rST
      target/arm: Enable FEAT_MOPS insns in user-mode emulation
      linux-user: Report AArch64 hwcap2 fields above bit 31
      target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR correctly
      target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage walk

Philippe Mathieu-Daudé (1):
      hw/arm/pxa2xx_gpio: Pass CPU using QOM link property

Richard Henderson (1):
      target/arm: Fix SVE STR increment

Thomas Huth (1):
      MAINTAINERS: Make sure that gicv3_internal.h is covered, too

Tong Ho (3):
      hw/misc: Introduce AMD/Xilix Versal TRNG device
      hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
      tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device

 MAINTAINERS                                       |   9 +-
 docs/specs/{edu.txt => edu.rst}                   |  84 ++-
 docs/specs/index.rst                              |   8 +
 docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} |  63 +-
 docs/specs/pci-ids.rst                            |   2 +-
 docs/specs/{pvpanic.txt => pvpanic.rst}           |  41 +-
 docs/specs/standard-vga.rst                       |  94 +++
 docs/specs/standard-vga.txt                       |  81 ---
 docs/specs/{virt-ctlr.txt => virt-ctlr.rst}       |  12 +-
 docs/specs/vmcoreinfo.rst                         |  54 ++
 docs/specs/vmcoreinfo.txt                         |  53 --
 docs/specs/vmgenid.rst                            | 246 ++++++++
 docs/specs/vmgenid.txt                            | 245 --------
 docs/specs/vmw_pvscsi-spec.rst                    | 115 ++++
 docs/specs/vmw_pvscsi-spec.txt                    |  92 ---
 docs/system/devices/ivshmem.rst                   |   2 +-
 include/hw/arm/xlnx-versal.h                      |   5 +
 include/hw/char/stm32f2xx_usart.h                 |  10 +-
 include/hw/input/gamepad.h                        |  18 -
 include/hw/input/stellaris_gamepad.h              |  37 ++
 include/hw/misc/xlnx-versal-trng.h                |  58 ++
 include/hw/qdev-properties.h                      |   3 +
 linux-user/loader.h                               |   2 +-
 target/arm/cpu-features.h                         |   5 +
 target/arm/internals.h                            |   1 -
 hw/arm/pxa2xx_gpio.c                              |   8 +-
 hw/arm/stellaris.c                                |  34 +-
 hw/arm/xlnx-versal.c                              |  16 +
 hw/char/stm32f2xx_usart.c                         |  29 +-
 hw/core/qdev-properties.c                         |  21 +
 hw/display/vga-isa.c                              |   2 +-
 hw/display/vga-pci.c                              |   2 +-
 hw/i2c/pm_smbus.c                                 |  18 +-
 hw/input/stellaris_gamepad.c                      |  99 +++
 hw/input/stellaris_input.c                        |  93 ---
 hw/misc/imx6_ccm.c                                |  41 +-
 hw/misc/imx7_snvs.c                               |   5 +
 hw/misc/xlnx-versal-trng.c                        | 717 ++++++++++++++++++++++
 hw/watchdog/wdt_imx2.c                            |  28 +-
 linux-user/elfload.c                              |  11 +-
 target/arm/cpu.c                                  |   2 +
 target/arm/ptw.c                                  |   7 +-
 target/arm/tcg/helper-a64.c                       |  15 +-
 target/arm/tcg/translate-sve.c                    |   5 +-
 tests/qtest/xlnx-versal-trng-test.c               | 485 +++++++++++++++
 tests/tcg/aarch64/sve-str.c                       |  49 ++
 hw/arm/Kconfig                                    |   3 +-
 hw/i2c/trace-events                               |   6 +
 hw/input/Kconfig                                  |   2 +-
 hw/input/meson.build                              |   2 +-
 hw/misc/Kconfig                                   |   3 +
 hw/misc/meson.build                               |   3 +
 hw/misc/trace-events                              |  19 +
 hw/watchdog/trace-events                          |   6 +
 tests/qtest/meson.build                           |   2 +-
 tests/tcg/aarch64/Makefile.target                 |   6 +-
 56 files changed, 2302 insertions(+), 777 deletions(-)
 rename docs/specs/{edu.txt => edu.rst} (64%)
 rename docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} (88%)
 rename docs/specs/{pvpanic.txt => pvpanic.rst} (64%)
 create mode 100644 docs/specs/standard-vga.rst
 delete mode 100644 docs/specs/standard-vga.txt
 rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)
 create mode 100644 docs/specs/vmcoreinfo.rst
 delete mode 100644 docs/specs/vmcoreinfo.txt
 create mode 100644 docs/specs/vmgenid.rst
 delete mode 100644 docs/specs/vmgenid.txt
 create mode 100644 docs/specs/vmw_pvscsi-spec.rst
 delete mode 100644 docs/specs/vmw_pvscsi-spec.txt
 delete mode 100644 include/hw/input/gamepad.h
 create mode 100644 include/hw/input/stellaris_gamepad.h
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 hw/input/stellaris_gamepad.c
 delete mode 100644 hw/input/stellaris_input.c
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c
 create mode 100644 tests/tcg/aarch64/sve-str.c

