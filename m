Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02A82F120
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:13:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7D-0006am-Gl; Tue, 16 Jan 2024 10:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7B-0006aL-G4
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:33 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl79-0005p9-Gm
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e86c86a6fso2982865e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417949; x=1706022749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vyUbBSpNnCe8m6tRHkH5YL3FPZ/VO35JWub2GSJKW1o=;
 b=VFFD+O4NFAexFj4OmbDPsmDhBkGLcYaox8rsUaleZJ4PNTdxX8zQ/jMcGNPeUb5B2r
 Tsu3OtqaEnQHNBhy09wuu8cZl30U4c8+nGF1/wN8BwBPn4/oBcmkC9Lw9DJVlK3W0KS5
 9E8wF6elsMZGZ7qlX/MbZ5mKUCb5WXWmZI1QvB0Mr60qzzSUzGGK1jDM4kb52CHYxFjP
 vYN8DGbtT9QIpemKNDyI8VUlp0gPshIkkn+ultfw+hKrxpjhG5ONQTigG20DbWS8gOKc
 VjyKD/PkVJb1jJos8YOaSCPU741y9i2pTUbEslp8gct0MbYEdU3leU/VgJo/H25xatmd
 43Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417949; x=1706022749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyUbBSpNnCe8m6tRHkH5YL3FPZ/VO35JWub2GSJKW1o=;
 b=IklJpMPFwTOb/MlPcf05S6udP5bVxI10uF1c5HV5iv6avvXlzrpGIkNlh3HByWvXYh
 fhB22dE85G+9BhEQpFKv6IFsPIx93Ht41mohJWEN5ie1bx5TMwdUn1D7Vk40ooKorVBI
 HZPkCySOaNLS9hhApOt6wwLBrIriaYFTBiKkV3h6vhijZgFyfWus69uzT24h0Ou/edFh
 VjmK9A6wx1Eo+ZfIPncq0GurP5qHSrQIJWTe8pTnK0oooGBiMXwNDUa0vzZWRGsb/3fu
 VXSt1Pk8C60nGiCiPYC3PQMz0owKtg0KNrbBhVBtPSQ5aDYcQI8kHInOTI0VWxfBD1St
 lv+w==
X-Gm-Message-State: AOJu0YzjTXE42HS76NKiYzhJ+HIPQTyWpD8k7zml4tTXLM9V3TCHSJz0
 FkDMAw9pBOv789UFaAv9vZ+KQ6OAPMpjCu8qClV49XZk0oU=
X-Google-Smtp-Source: AGHT+IFcvAP763vZcxA51x+nUPbGpgWhWxhk5NR4ocoN4faXG/dVgWn/qkau5Et+/HaPbAZ8Q69ekg==
X-Received: by 2002:a05:600c:4586:b0:40e:631f:e014 with SMTP id
 r6-20020a05600c458600b0040e631fe014mr2114974wmo.292.1705417949294; 
 Tue, 16 Jan 2024 07:12:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Tue, 16 Jan 2024 15:12:07 +0000
Message-Id: <20240116151228.2430754-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240116

for you to fetch changes up to 7ec39730a9cc443c752d4cad2bf1c00467551ef5:

  load_elf: fix iterator's type for elf file processing (2024-01-15 17:14:22 +0000)

----------------------------------------------------------------
target-arm queue:
 * docs/devel/docs: Document .hx file syntax
 * arm_pamax() no longer needs to do feature propagation
 * docs/system/arm/virt.rst: Improve 'highmem' option docs
 * STM32L4x5 Implement SYSCFG and EXTI devices
 * Nuvoton: Implement PCI Mailbox module
 * Nuvoton: Implement GMAC module
 * hw/timer: fix systick trace message
 * hw/arm/virt: Consolidate valid CPU types
 * load_elf: fix iterator's type for elf file processing

----------------------------------------------------------------
Anastasia Belova (1):
      load_elf: fix iterator's type for elf file processing

Gavin Shan (1):
      hw/arm/virt: Consolidate valid CPU types

Hao Wu (3):
      hw/misc: Add Nuvoton's PCI Mailbox Module
      hw/misc: Add qtest for NPCM7xx PCI Mailbox
      hw/arm: Add GMAC devices to NPCM7XX SoC

Inès Varhol (6):
      hw/misc: Implement STM32L4x5 EXTI
      hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
      tests/qtest: Add STM32L4x5 EXTI QTest testcase
      hw/misc: Implement STM32L4x5 SYSCFG
      hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
      tests/qtest: Add STM32L4x5 SYSCFG QTest testcase

Nabih Estefan Diaz (4):
      tests/qtest: Creating qtest for GMAC Module
      hw/net: GMAC Rx Implementation
      hw/net: GMAC Tx Implementation
      tests/qtest: Adding PCS Module test to GMAC Qtest

Peter Maydell (5):
      docs/devel/docs: Document .hx file syntax
      target/arm: arm_pamax() no longer needs to do feature propagation
      docs/system/arm/virt.rst: Improve 'highmem' option docs
      hw/arm: Add PCI mailbox module to Nuvoton SoC
      hw/net: Add NPCMXXX GMAC device

Samuel Tardieu (1):
      hw/timer: fix systick trace message

 MAINTAINERS                         |   1 +
 docs/devel/docs.rst                 |  60 +++
 docs/devel/index-build.rst          |   1 +
 docs/system/arm/b-l475e-iot01a.rst  |   7 +-
 docs/system/arm/nuvoton.rst         |   2 +
 docs/system/arm/virt.rst            |   8 +-
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/arm/stm32l4x5_soc.h      |   5 +
 include/hw/elf_ops.h                |   2 +-
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 ++++
 include/hw/misc/stm32l4x5_exti.h    |  51 ++
 include/hw/misc/stm32l4x5_syscfg.h  |  54 +++
 include/hw/net/npcm_gmac.h          | 340 +++++++++++++
 hw/arm/npcm7xx.c                    |  53 +-
 hw/arm/stm32l4x5_soc.c              |  73 ++-
 hw/arm/virt.c                       |   8 +-
 hw/misc/npcm7xx_pci_mbox.c          | 324 +++++++++++++
 hw/misc/stm32l4x5_exti.c            | 290 +++++++++++
 hw/misc/stm32l4x5_syscfg.c          | 266 ++++++++++
 hw/net/npcm_gmac.c                  | 939 ++++++++++++++++++++++++++++++++++++
 target/arm/ptw.c                    |  14 +-
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++++
 tests/qtest/npcm_gmac-test.c        | 341 +++++++++++++
 tests/qtest/stm32l4x5_exti-test.c   | 524 ++++++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 331 +++++++++++++
 hmp-commands-info.hx                |  10 +-
 hmp-commands.hx                     |  10 +-
 hw/arm/Kconfig                      |   2 +
 hw/misc/Kconfig                     |   6 +
 hw/misc/meson.build                 |   3 +
 hw/misc/trace-events                |  16 +
 hw/net/meson.build                  |   2 +-
 hw/net/trace-events                 |  19 +
 hw/timer/trace-events               |   2 +-
 qemu-img-cmds.hx                    |   2 +
 qemu-options.hx                     |   2 +
 tests/qtest/meson.build             |   8 +
 37 files changed, 4066 insertions(+), 33 deletions(-)
 create mode 100644 docs/devel/docs.rst
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 hw/misc/stm32l4x5_syscfg.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

