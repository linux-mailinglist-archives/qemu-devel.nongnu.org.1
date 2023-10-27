Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796027D9BC7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO07-0007CF-PU; Fri, 27 Oct 2023 10:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO05-0007Bc-Hb
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO01-00086S-W2
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32f760cbff3so215153f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417584; x=1699022384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCnb9R/BNoPKGhd7zm/zleKRa/0S5ZgjhrfWOlCX0jQ=;
 b=qLpto7ZP+KzhL0Baqk8JPY4wDs27W2WQKw72/+m2aawWWUiTkdNzUnQzHXTQhC8TA2
 fylWSLP4eyW4FUR8r9/+TUG5Ajzfs0Mz3ZO52xJkQ0RXlpbQODWYRA3DfSRvDfFFEQ8H
 QkN6cIcIxgwJE1ExXQKKfSgik4JuxQmpM00GfrFq0LsZOJwx2JPvZC/8eeEwk+K5ZF7C
 EKNVxVq3pNtnaNShhAYzg96imrSGLxRBPkk4GG7N+7QUppYpKnpC/r8uYAUFL9S73HF9
 TmC51TPv2FpxOhYZetiuv3iDiggyFXWPZhNrB2HlZsrE0BcaDT8lMDiuSGOBTLQEVt19
 04eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417584; x=1699022384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VCnb9R/BNoPKGhd7zm/zleKRa/0S5ZgjhrfWOlCX0jQ=;
 b=qM+I4saEa1anReV+E0VdreWvaV1rgxRI3acaorvGgzyuBv8N4mkTKfrqQavj2iqgY9
 tkoyGi/EUJsXYCJO05VikbeHzJKG2NVKC6m0xwpA/cygIrCJP09NjcYGbuVbC4v5jvCR
 tnYgDHHjNMvISlW75gmRbXSveYUdbTBXUm5FztG9vTr/KFN/JMSoaS+hMJWRUVFI5bgl
 iv8cd73R9QYZG1WgHth7rbYcOtAEBCQowLOs6JC1GmMjTVtaMwWSNH05hvGY1z2u7TVz
 xw9uHep8quUwX9ZEgMplOGFTgRClmPPw9iDN7HabYfCX2Qm26XXiKl6XnsWlT/sOTtq1
 Gz0Q==
X-Gm-Message-State: AOJu0Ywj4Oe5RezCdTEaGY6jT4IAwXY7sYDY0a8QnpbOAlS73piw/SuV
 cvJA7e2a689zBLX4XsavkUGBuHuw8FnCpuznnAc=
X-Google-Smtp-Source: AGHT+IFRgnErITfDQDtbC6MyrtSDDxbKhlF8dVRbcup10DOVtdtF5nha8q6MOwTn4OzcoBiL9kVNqA==
X-Received: by 2002:adf:e411:0:b0:327:e073:d604 with SMTP id
 g17-20020adfe411000000b00327e073d604mr2263349wrm.45.1698417583740; 
 Fri, 27 Oct 2023 07:39:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] target-arm queue
Date: Fri, 27 Oct 2023 15:39:01 +0100
Message-Id: <20231027143942.3413881-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi; here's the latest target-arm queue. Mostly this is refactoring
and cleanup type patches.

thanks
-- PMM

The following changes since commit c60be6e3e38cb36dc66129e757ec4b34152232be:

  Merge tag 'pull-sp-20231025' of https://gitlab.com/rth7680/qemu into staging (2023-10-27 09:43:53 +0900)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231027

for you to fetch changes up to df93de987f423a0ed918c425f5dbd9a25d3c6229:

  hw/net/cadence_gem: enforce 32 bits variable size for CRC (2023-10-27 15:27:06 +0100)

----------------------------------------------------------------
target-arm queue:
 * Correct minor errors in Cortex-A710 definition
 * Implement Neoverse N2 CPU model
 * Refactor feature test functions out into separate header
 * Fix syndrome for FGT traps on ERET
 * Remove 'hw/arm/boot.h' includes from various header files
 * pxa2xx: Refactoring/cleanup
 * Avoid using 'first_cpu' when first ARM CPU is reachable
 * misc/led: LED state is set opposite of what is expected
 * hw/net/cadence_gen: clean up to use FIELD macros
 * hw/net/cadence_gem: perform PHY access on write only
 * hw/net/cadence_gem: enforce 32 bits variable size for CRC

----------------------------------------------------------------
Glenn Miles (1):
      misc/led: LED state is set opposite of what is expected

Luc Michel (11):
      hw/net/cadence_gem: use REG32 macro for register definitions
      hw/net/cadence_gem: use FIELD for screening registers
      hw/net/cadence_gem: use FIELD to describe NWCTRL register fields
      hw/net/cadence_gem: use FIELD to describe NWCFG register fields
      hw/net/cadence_gem: use FIELD to describe DMACFG register fields
      hw/net/cadence_gem: use FIELD to describe [TX|RX]STATUS register fields
      hw/net/cadence_gem: use FIELD to describe IRQ register fields
      hw/net/cadence_gem: use FIELD to describe DESCONF6 register fields
      hw/net/cadence_gem: use FIELD to describe PHYMNTNC register fields
      hw/net/cadence_gem: perform PHY access on write only
      hw/net/cadence_gem: enforce 32 bits variable size for CRC

Peter Maydell (9):
      target/arm: Correct minor errors in Cortex-A710 definition
      target/arm: Implement Neoverse N2 CPU model
      target/arm: Move feature test functions to their own header
      target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests together
      target/arm: Move ID_AA64MMFR0 tests up to before MMFR1 and MMFR2
      target/arm: Move ID_AA64ISAR* test functions together
      target/arm: Move ID_AA64PFR* tests together
      target/arm: Move ID_AA64DFR* feature tests together
      target/arm: Fix syndrome for FGT traps on ERET

Philippe Mathieu-Daudé (20):
      hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
      hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
      hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
      hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
      hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
      hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
      hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
      hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
      hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
      hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header
      hw/sd/pxa2xx: Realize sysbus device before accessing it
      hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
      hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
      hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
      hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
      hw/intc/pxa2xx: Convert to Resettable interface
      hw/intc/pxa2xx: Pass CPU reference using QOM link property
      hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init()
      hw/arm/pxa2xx: Realize PXA2XX_I2C device before accessing it
      hw/arm: Avoid using 'first_cpu' when first ARM CPU is reachable

 docs/system/arm/virt.rst          |   1 +
 bsd-user/arm/target_arch.h        |   1 +
 include/hw/arm/allwinner-a10.h    |   1 -
 include/hw/arm/allwinner-h3.h     |   1 -
 include/hw/arm/allwinner-r40.h    |   1 -
 include/hw/arm/fsl-imx25.h        |   1 -
 include/hw/arm/fsl-imx31.h        |   1 -
 include/hw/arm/fsl-imx6.h         |   1 -
 include/hw/arm/fsl-imx6ul.h       |   1 -
 include/hw/arm/fsl-imx7.h         |   1 -
 include/hw/arm/pxa.h              |   2 -
 include/hw/arm/xlnx-versal.h      |   1 -
 include/hw/arm/xlnx-zynqmp.h      |   1 -
 linux-user/aarch64/target_prctl.h |   2 +
 target/arm/cpu-features.h         | 994 ++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h                  | 971 -------------------------------------
 target/arm/internals.h            |   1 +
 target/arm/tcg/translate.h        |   2 +-
 hw/arm/armv7m.c                   |   1 +
 hw/arm/bananapi_m2u.c             |   3 +-
 hw/arm/cubieboard.c               |   1 +
 hw/arm/exynos4_boards.c           |   7 +-
 hw/arm/imx25_pdk.c                |   1 +
 hw/arm/kzm.c                      |   1 +
 hw/arm/mcimx6ul-evk.c             |   1 +
 hw/arm/mcimx7d-sabre.c            |   1 +
 hw/arm/orangepi.c                 |   3 +-
 hw/arm/pxa2xx.c                   |  17 +-
 hw/arm/pxa2xx_pic.c               |  38 +-
 hw/arm/realview.c                 |   2 +-
 hw/arm/sabrelite.c                |   1 +
 hw/arm/sbsa-ref.c                 |   1 +
 hw/arm/virt.c                     |   1 +
 hw/arm/xilinx_zynq.c              |   2 +-
 hw/arm/xlnx-versal-virt.c         |   1 +
 hw/arm/xlnx-zcu102.c              |   1 +
 hw/intc/armv7m_nvic.c             |   1 +
 hw/misc/led.c                     |   2 +-
 hw/net/cadence_gem.c              | 884 ++++++++++++++++++---------------
 hw/pcmcia/pxa2xx.c                |  15 -
 hw/sd/pxa2xx_mmci.c               |   7 +-
 linux-user/aarch64/cpu_loop.c     |   1 +
 linux-user/aarch64/signal.c       |   1 +
 linux-user/arm/signal.c           |   1 +
 linux-user/elfload.c              |   4 +
 linux-user/mmap.c                 |   4 +
 target/arm/arch_dump.c            |   1 +
 target/arm/cpu.c                  |   1 +
 target/arm/cpu64.c                |   1 +
 target/arm/debug_helper.c         |   1 +
 target/arm/gdbstub.c              |   1 +
 target/arm/helper.c               |   1 +
 target/arm/kvm64.c                |   1 +
 target/arm/machine.c              |   1 +
 target/arm/ptw.c                  |   1 +
 target/arm/tcg/cpu64.c            | 115 ++++-
 target/arm/tcg/hflags.c           |   1 +
 target/arm/tcg/m_helper.c         |   1 +
 target/arm/tcg/op_helper.c        |   1 +
 target/arm/tcg/pauth_helper.c     |   1 +
 target/arm/tcg/tlb_helper.c       |   1 +
 target/arm/tcg/translate-a64.c    |   4 +-
 target/arm/vfp_helper.c           |   1 +
 63 files changed, 1702 insertions(+), 1419 deletions(-)
 create mode 100644 target/arm/cpu-features.h

