Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F782ACFF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNss8-0001Kp-Ai; Thu, 11 Jan 2024 06:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss4-0001Jo-7h
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss1-0004N1-Ax
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e60e1378eso3921635e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971107; x=1705575907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZopKFDeRJp/VutyIQ8gSg7+OcQt0qhn3KjzNdnO3LY0=;
 b=e6gSxpQx4BdAEqm20OEWRXIYmrW4ckTVFBUYksicSPSUriHsqUmGMtuC8DRpmZKYvo
 dsJTGFoL5jNo8piY9iZEIXGMCu+zDhxtQLAyW9HOSb5p0fogE4aJmWyiELySwwbWkf4i
 Z3o+zyH/PIsNXxHeLtRp48PQQX/JX/F9uo/jW/3fyEqkpW99AHWEpvc7tgUAj99BHhHv
 o7gqBv2NTcNIEbsLvU6wp/xdvW2Bv7Nkpq6mF8isPGMtyDC6O3nM9zr8+d/ajeTgZD1V
 eUfwHKXWEO6fvvFOkLWloXlNqGVDWloVDNTF4oKaIXyj1XWs6GyvXErIrrzE3ITDe2nl
 anRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971107; x=1705575907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZopKFDeRJp/VutyIQ8gSg7+OcQt0qhn3KjzNdnO3LY0=;
 b=kX4DK1h6wQ6Bnbby7xR7vFmHTShE98mFZ/icwZe2PtAelQFw06QI/uUJVETKhA9zuZ
 GZFdXYCih/LUoplu1uYd0JIqdYjPc/szytAdUT65ybOEvHXj0gBbVaN498CEgu+QUprr
 G/F5ELYps8/urvImFa9bCTPwK5Z9WMAj8TzmpWOiED+tVb7FRsKulEdgkvAofvP6uBPS
 pFowio0T9xdQ3ZMk8vn6LdzL48E0P6PWnkYUn865audFK+BLa+nsay+EPaVXJhqOM5av
 ySRqfrmw7BhUWq2AozOaEYFJH/t2VVrBQxjoPINoTnbK/46sG8cwnrOMeWoOd/xTp074
 tCKg==
X-Gm-Message-State: AOJu0YxtbZWPupu3ILwzOsu8C5LJ9a4iKyA++U3IGhmXHsPOskwQPaWq
 Gr1HADfERQy53zVAHFMM8WIIl3CCbVk0HTsyi15bsotV4wI=
X-Google-Smtp-Source: AGHT+IFiUJyOQg+HixpsEVhWF9HFwcnOXNknxr4FAr9RgWvo6400S2hNrqFSUt1vdmlyflxdGZUUEg==
X-Received: by 2002:a1c:720f:0:b0:40e:4179:d060 with SMTP id
 n15-20020a1c720f000000b0040e4179d060mr362752wmc.65.1704971107259; 
 Thu, 11 Jan 2024 03:05:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] target-arm queue
Date: Thu, 11 Jan 2024 11:04:24 +0000
Message-Id: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

Mostly my FEAT_NV/NV2 stuff, but some other smaller series too.

-- PMM

The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240111

for you to fetch changes up to e2862554c257e908a3833265e38365e794abd362:

  target/arm: Add FEAT_NV2 to max, neoverse-n2, neoverse-v1 CPUs (2024-01-09 14:44:45 +0000)

----------------------------------------------------------------
target-arm queue:
 * Emulate FEAT_NV, FEAT_NV2
 * add cache controller for Freescale i.MX6
 * Add minimal support for the B-L475E-IOT01A board
 * Allow SoC models to configure M-profile CPUs with correct number
   of NVIC priority bits
 * Add missing QOM parent for v7-M SoCs
 * Set CTR_EL0.{IDC,DIC} for the 'max' CPU
 * hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers

----------------------------------------------------------------
Inès Varhol (2):
      hw/arm: Add minimal support for the STM32L4x5 SoC
      hw/arm: Add minimal support for the B-L475E-IOT01A board

Nikita Ostrenkov (1):
      hw/arm: add cache controller for Freescale i.MX6

Peter Maydell (34):
      target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
      hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
      target/arm: Handle HCR_EL2 accesses for bits introduced with FEAT_NV
      target/arm: Implement HCR_EL2.AT handling
      target/arm: Enable trapping of ERET for FEAT_NV
      target/arm: Always honour HCR_EL2.TSC when HCR_EL2.NV is set
      target/arm: Allow use of upper 32 bits of TBFLAG_A64
      target/arm: Record correct opcode fields in cpreg for E2H aliases
      target/arm: *_EL12 registers should UNDEF when HCR_EL2.E2H is 0
      target/arm: Make EL2 cpreg accessfns safe for FEAT_NV EL1 accesses
      target/arm: Move FPU/SVE/SME access checks up above ARM_CP_SPECIAL_MASK check
      target/arm: Trap sysreg accesses for FEAT_NV
      target/arm: Make NV reads of CurrentEL return EL2
      target/arm: Set SPSR_EL1.M correctly when nested virt is enabled
      target/arm: Trap registers when HCR_EL2.{NV, NV1} == {1, 1}
      target/arm: Always use arm_pan_enabled() when checking if PAN is enabled
      target/arm: Don't honour PSTATE.PAN when HCR_EL2.{NV, NV1} == {1, 1}
      target/arm: Treat LDTR* and STTR* as LDR/STR when NV, NV1 is 1, 1
      target/arm: Handle FEAT_NV page table attribute changes
      target/arm: Add FEAT_NV to max, neoverse-n2, neoverse-v1 CPUs
      target/arm: Handle HCR_EL2 accesses for FEAT_NV2 bits
      target/arm: Implement VNCR_EL2 register
      target/arm: Handle FEAT_NV2 changes to when SPSR_EL1.M reports EL2
      target/arm: Handle FEAT_NV2 redirection of SPSR_EL2, ELR_EL2, ESR_EL2, FAR_EL2
      target/arm: Implement FEAT_NV2 redirection of sysregs to RAM
      target/arm: Report VNCR_EL2 based faults correctly
      target/arm: Mark up VNCR offsets (offsets 0x0..0xff)
      target/arm: Mark up VNCR offsets (offsets 0x100..0x160)
      target/arm: Mark up VNCR offsets (offsets 0x168..0x1f8)
      target/arm: Mark up VNCR offsets (offsets >= 0x200, except GIC)
      hw/intc/arm_gicv3_cpuif: Mark up VNCR offsets for GIC CPU registers
      target/arm: Report HCR_EL2.{NV,NV1,NV2} in cpu dumps
      target/arm: Enhance CPU_LOG_INT to show SPSR on AArch64 exception-entry
      target/arm: Add FEAT_NV2 to max, neoverse-n2, neoverse-v1 CPUs

Philippe Mathieu-Daudé (1):
      hw/arm: Add missing QOM parent for v7-M SoCs

Samuel Tardieu (3):
      hw/intc/armv7m_nvic: add "num-prio-bits" property
      hw/arm/armv7m: alias the NVIC "num-prio-bits" property
      hw/arm/socs: configure priority bits for existing SOCs

 MAINTAINERS                             |  15 ++
 docs/system/arm/b-l475e-iot01a.rst      |  46 +++++
 docs/system/arm/emulation.rst           |   2 +
 docs/system/arm/stm32.rst               |   6 +-
 docs/system/target-arm.rst              |   1 +
 configs/devices/arm-softmmu/default.mak |   1 +
 include/hw/arm/armv7m.h                 |   1 +
 include/hw/arm/stm32l4x5_soc.h          |  57 ++++++
 target/arm/cpregs.h                     |  54 +++++-
 target/arm/cpu-features.h               |  10 +
 target/arm/cpu.h                        |  24 ++-
 target/arm/syndrome.h                   |  20 +-
 target/arm/tcg/translate.h              |  16 +-
 hw/arm/armv7m.c                         |   2 +
 hw/arm/b-l475e-iot01a.c                 |  72 +++++++
 hw/arm/fsl-imx6.c                       |   3 +
 hw/arm/msf2-som.c                       |   1 +
 hw/arm/netduino2.c                      |   1 +
 hw/arm/netduinoplus2.c                  |   1 +
 hw/arm/olimex-stm32-h405.c              |   1 +
 hw/arm/stellaris.c                      |   2 +
 hw/arm/stm32f100_soc.c                  |   1 +
 hw/arm/stm32f205_soc.c                  |   1 +
 hw/arm/stm32f405_soc.c                  |   1 +
 hw/arm/stm32l4x5_soc.c                  | 266 ++++++++++++++++++++++++++
 hw/arm/stm32vldiscovery.c               |   1 +
 hw/intc/arm_gicv3_cpuif.c               |  28 ++-
 hw/intc/armv7m_nvic.c                   |  23 ++-
 target/arm/cpu.c                        |   8 +-
 target/arm/debug_helper.c               |  13 +-
 target/arm/helper.c                     | 326 +++++++++++++++++++++++++++++---
 target/arm/ptw.c                        |  21 ++
 target/arm/tcg/cpu64.c                  |  11 ++
 target/arm/tcg/hflags.c                 |  30 ++-
 target/arm/tcg/op_helper.c              |  16 +-
 target/arm/tcg/tlb_helper.c             |  27 ++-
 target/arm/tcg/translate-a64.c          | 160 ++++++++++++++--
 hw/arm/Kconfig                          |  12 ++
 hw/arm/meson.build                      |   2 +
 39 files changed, 1203 insertions(+), 80 deletions(-)
 create mode 100644 docs/system/arm/b-l475e-iot01a.rst
 create mode 100644 include/hw/arm/stm32l4x5_soc.h
 create mode 100644 hw/arm/b-l475e-iot01a.c
 create mode 100644 hw/arm/stm32l4x5_soc.c

