Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED0831963
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:45:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRlz-0000js-Qv; Thu, 18 Jan 2024 07:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRlm-0000iD-Iw
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:45:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRlk-00045c-4q
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:45:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-337d5480a6aso361527f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705581914; x=1706186714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6zlOZm6q3Xn2PL3HqLTuAHiSg98bOffhE4PqCx7JNMA=;
 b=Gd8c98eo4mIlxIuVvzcEamshauU0BAnnJQuEgrzjbGxn38frZjUuxplqHPmwvWg2wL
 1FcJjgZ/8MOdmxtR5GdeFbAdVYpGyku0i8PoZEYF0Gi2PmFTadtiTUA9B/G2nVxRfjbY
 33sbjJ9wJouVoQscm6gmGFT2aAsunczVa38+htdIMPLBTCwLDCUELZotiJHJ2zlyFNil
 hXM6I5VIRFCK2Bkf2YUjJXzVDXKFYwMRxGI/bbTeWffTx7//xD9o3TbO8IHeBNWyal4W
 /kbKE2Bj1kmfOdqeB+GgblxyFQSz4UrGP6R/DiqM2vtBoJMGOG1js02zctsze2H+JdUK
 yGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705581914; x=1706186714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zlOZm6q3Xn2PL3HqLTuAHiSg98bOffhE4PqCx7JNMA=;
 b=MUD5X8bwOKTeQHKl2tV61XTHNaxln362lUKtD8y8nhF7LcDiPg9UBQveUQgDBio9Pt
 VXhN7bUQdFDTV7lvceSnwX3z/K+IHmbm/QuHQabepcm/+Srq6UMHw186AIJkbo/0EFtU
 Cc2PtkjDIyJPBIsJLNti1uYOZh1WcAMUOk67yP0iMIVlOMUROM+eK/834OdHvaXTUyQV
 5+hv/lm161LlIUGauusz0DxVViSsox8AnfJR+kSK+gX2VZYM4+hNnH1mIkz1pIA4DBUj
 sJ/gK72JmfEYZH0/Jr8qp0C3byy7C36miZkKzrQmdFsIBmqlJZGgrllmhyffuU4Eo4d0
 /FJw==
X-Gm-Message-State: AOJu0YwxKT0KoP/WBe/1ABq6tElGtZF8U6T35Rf2ZhxlrX9oYDi9NWsi
 aiR9czY55vVVxglug2vfYSCuAb2H+wF6C0ImkTe1BX9h+9PPoTJYF1klRDTFa8uC951yOZMbQuO
 A
X-Google-Smtp-Source: AGHT+IHKtiZUi0r+8+MCY1teyuoq9To0ZLi3MlB8AhQg+yO998ldcQX4WHqfPRqeQDDnx3L9elGvGA==
X-Received: by 2002:adf:fe09:0:b0:337:7086:b6c7 with SMTP id
 n9-20020adffe09000000b003377086b6c7mr549782wrr.19.1705581913581; 
 Thu, 18 Jan 2024 04:45:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d640c000000b00337bcef9193sm3981622wru.44.2024.01.18.04.45.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:45:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/12] target-arm queue
Date: Thu, 18 Jan 2024 12:45:12 +0000
Message-Id: <20240118124512.2704713-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

v2: dropped the nuvoton changes as the tests didn't pass
on big-endian hosts.

-- PMM

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240118

for you to fetch changes up to 410c2a4d75f52f6a2fe978eda5a9b6f854afe5ea:

  load_elf: fix iterator's type for elf file processing (2024-01-18 12:20:33 +0000)

----------------------------------------------------------------
target-arm queue:
 * docs/devel/docs: Document .hx file syntax
 * arm_pamax() no longer needs to do feature propagation
 * docs/system/arm/virt.rst: Improve 'highmem' option docs
 * STM32L4x5 Implement SYSCFG and EXTI devices
 * hw/timer: fix systick trace message
 * hw/arm/virt: Consolidate valid CPU types
 * load_elf: fix iterator's type for elf file processing

----------------------------------------------------------------
Anastasia Belova (1):
      load_elf: fix iterator's type for elf file processing

Gavin Shan (1):
      hw/arm/virt: Consolidate valid CPU types

Inès Varhol (6):
      hw/misc: Implement STM32L4x5 EXTI
      hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
      tests/qtest: Add STM32L4x5 EXTI QTest testcase
      hw/misc: Implement STM32L4x5 SYSCFG
      hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
      tests/qtest: Add STM32L4x5 SYSCFG QTest testcase

Peter Maydell (3):
      docs/devel/docs: Document .hx file syntax
      target/arm: arm_pamax() no longer needs to do feature propagation
      docs/system/arm/virt.rst: Improve 'highmem' option docs

Samuel Tardieu (1):
      hw/timer: fix systick trace message

 MAINTAINERS                         |   1 +
 docs/devel/docs.rst                 |  60 +++++
 docs/devel/index-build.rst          |   1 +
 docs/system/arm/b-l475e-iot01a.rst  |   7 +-
 docs/system/arm/virt.rst            |   8 +-
 include/hw/arm/stm32l4x5_soc.h      |   5 +
 include/hw/elf_ops.h                |   2 +-
 include/hw/misc/stm32l4x5_exti.h    |  51 ++++
 include/hw/misc/stm32l4x5_syscfg.h  |  54 ++++
 hw/arm/stm32l4x5_soc.c              |  73 ++++-
 hw/arm/virt.c                       |   8 +-
 hw/misc/stm32l4x5_exti.c            | 290 ++++++++++++++++++++
 hw/misc/stm32l4x5_syscfg.c          | 266 ++++++++++++++++++
 target/arm/ptw.c                    |  14 +-
 tests/qtest/stm32l4x5_exti-test.c   | 524 ++++++++++++++++++++++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 331 +++++++++++++++++++++++
 hmp-commands-info.hx                |  10 +-
 hmp-commands.hx                     |  10 +-
 hw/arm/Kconfig                      |   2 +
 hw/misc/Kconfig                     |   6 +
 hw/misc/meson.build                 |   2 +
 hw/misc/trace-events                |  11 +
 hw/timer/trace-events               |   2 +-
 qemu-img-cmds.hx                    |   2 +
 qemu-options.hx                     |   2 +
 tests/qtest/meson.build             |   6 +
 26 files changed, 1719 insertions(+), 29 deletions(-)
 create mode 100644 docs/devel/docs.rst
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 hw/misc/stm32l4x5_exti.c
 create mode 100644 hw/misc/stm32l4x5_syscfg.c
 create mode 100644 tests/qtest/stm32l4x5_exti-test.c
 create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

