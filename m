Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19425723E36
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIj-0007YJ-D4; Tue, 06 Jun 2023 05:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIc-0007Xe-4t
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIZ-0004ho-6Q
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4e01fso59582645e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044896; x=1688636896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qKZGuSyO+0F3wlYj65gxbxMX9gCyLCPb+tMClj9/o0Y=;
 b=opRInNZ7EPnYmoWHEGmPkHFUc/ZQc2LYtNh47EG71ruebLpRu0NJTPkvw51ko2LbkM
 NQDl1DdNAa9KGxgqumbRMioK374V7LgdM00Ixkq8xyKGoeQGrcUVh25xXlkk0WXVSnOk
 Dj1dROo/nUoOJSHlNk4pKcmi+wwqlXfB+IiebI/mDIGGpRMaNVjlEXYb4KkLq1q2IJde
 GlvMSbYvp1Oo9OLGLTS6hIOKkczzeCcx2kFXoT99z3Ln2N0LXGV1v8SilRFpukN9+D+X
 KyOh3bRHAW6ysvz4445OAPyPFm51NiUhpYSVb5CooQ0/5r+cPtbR+iJdck5tDzp3dkLu
 7Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044896; x=1688636896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKZGuSyO+0F3wlYj65gxbxMX9gCyLCPb+tMClj9/o0Y=;
 b=JqKTT9C1o5xYS6IKnbz+I5ZGiD6MHAfVbGrg5My3eSZCgY+e+LjjJJ60yRxm/9k4EI
 Z/xISOCGt/pv/3JIPiQFYHRcV557JHWrC7jQ9mNA05G+6agEDILPcfXM7f5DQ6xofXbL
 FkUOUA8Dh45CLmFN7+D6hwlEXDsRa9ont8zD68BF7kF6rp+LqbvGXPBI7PQ5dGUmZAJh
 x9eyGCDubDHgFWLL+Rm5mGMUWmwCaV8aE1t81DNu+VQf6X499TxzcYwaCN3YmoAePytu
 PYebGvFnaxyT+cLqL9C9emfGZUcPTacyc1EiKeIuYos8ZPxVAWZY+mo0Rh0i/ms7oWGj
 fbug==
X-Gm-Message-State: AC+VfDyngVJ/0l260sIU8MtGgEEkDjJVFw7n9BmLmdy9zYgUW7Yycxs+
 HGtGrqB5KJ5GPwpwmtXcAdHZJ6Ps4tS6qjywj5k=
X-Google-Smtp-Source: ACHHUZ4fX2bFJ23ZcRougmiuZEFlYe0Kz0rVyxhn/Y4VUuAz7SjajSrLRWR0JJ2bbfctQ1HD+oMbYA==
X-Received: by 2002:a05:600c:2947:b0:3f6:923:9ec with SMTP id
 n7-20020a05600c294700b003f6092309ecmr2027565wmd.25.1686044896228; 
 Tue, 06 Jun 2023 02:48:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/42] target-arm queue
Date: Tue,  6 Jun 2023 10:47:32 +0100
Message-Id: <20230606094814.3581397-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi; this pullreq includes FEAT_LSE2 support, the new
bpim2u board, and some other smaller patchsets.

thanks
-- PMM

The following changes since commit 369081c4558e7e940fa36ce59bf17b2e390f55d3:

  Merge tag 'pull-tcg-20230605' of https://gitlab.com/rth7680/qemu into staging (2023-06-05 13:16:56 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230606

for you to fetch changes up to f9ac778898cb28307e0f91421aba34d43c34b679:

  target/arm: trap DCC access in user mode emulation (2023-06-06 10:19:40 +0100)

----------------------------------------------------------------
target-arm queue:
 * Support gdbstub (guest debug) in HVF
 * xnlx-versal: Support CANFD controller
 * bpim2u: New board model: Banana Pi BPI-M2 Ultra
 * Emulate FEAT_LSE2
 * allow DC CVA[D]P in user mode emulation
 * trap DCC access in user mode emulation

----------------------------------------------------------------
Francesco Cagnin (4):
      arm: move KVM breakpoints helpers
      hvf: handle access for more registers
      hvf: add breakpoint handlers
      hvf: add guest debugging handlers for Apple Silicon hosts

Richard Henderson (20):
      target/arm: Add commentary for CPUARMState.exclusive_high
      target/arm: Add feature test for FEAT_LSE2
      target/arm: Introduce finalize_memop_{atom,pair}
      target/arm: Use tcg_gen_qemu_ld_i128 for LDXP
      target/arm: Use tcg_gen_qemu_{st, ld}_i128 for do_fp_{st, ld}
      target/arm: Use tcg_gen_qemu_st_i128 for STZG, STZ2G
      target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r
      target/arm: Sink gen_mte_check1 into load/store_exclusive
      target/arm: Load/store integer pair with one tcg operation
      target/arm: Hoist finalize_memop out of do_gpr_{ld, st}
      target/arm: Hoist finalize_memop out of do_fp_{ld, st}
      target/arm: Pass memop to gen_mte_check1*
      target/arm: Pass single_memop to gen_mte_checkN
      target/arm: Check alignment in helper_mte_check
      target/arm: Add SCTLR.nAA to TBFLAG_A64
      target/arm: Relax ordered/atomic alignment checks for LSE2
      target/arm: Move mte check for store-exclusive
      tests/tcg/aarch64: Use stz2g in mte-7.c
      tests/tcg/multiarch: Adjust sigbus.c
      target/arm: Enable FEAT_LSE2 for -cpu max

Vikram Garhwal (4):
      hw/net/can: Introduce Xilinx Versal CANFD controller
      xlnx-versal: Connect Xilinx VERSAL CANFD controllers
      MAINTAINERS: Include canfd tests under Xilinx CAN
      tests/qtest: Introduce tests for Xilinx VERSAL CANFD controller

Zhuojia Shen (3):
      target/arm: allow DC CVA[D]P in user mode emulation
      tests/tcg/aarch64: add DC CVA[D]P tests
      target/arm: trap DCC access in user mode emulation

qianfan Zhao (11):
      hw: arm: Add bananapi M2-Ultra and allwinner-r40 support
      hw/arm/allwinner-r40: add Clock Control Unit
      hw: allwinner-r40: Complete uart devices
      hw: arm: allwinner-r40: Add i2c0 device
      hw/misc: Rename axp209 to axp22x and add support AXP221 PMU
      hw/arm/allwinner-r40: add SDRAM controller device
      hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support
      hw: arm: allwinner-r40: Add emac and gmac support
      hw: arm: allwinner-sramc: Add SRAM Controller support for R40
      tests: avocado: boot_linux_console: Add test case for bpim2u
      docs: system: arm: Introduce bananapi_m2u

 MAINTAINERS                           |    2 +-
 docs/system/arm/bananapi_m2u.rst      |  139 +++
 docs/system/arm/emulation.rst         |    1 +
 docs/system/arm/xlnx-versal-virt.rst  |   31 +
 docs/system/target-arm.rst            |    1 +
 include/hw/arm/allwinner-r40.h        |  143 +++
 include/hw/arm/xlnx-versal.h          |   12 +
 include/hw/misc/allwinner-r40-ccu.h   |   65 +
 include/hw/misc/allwinner-r40-dramc.h |  108 ++
 include/hw/misc/allwinner-sramc.h     |   69 ++
 include/hw/net/xlnx-versal-canfd.h    |   87 ++
 include/hw/sd/allwinner-sdhost.h      |    9 +
 include/sysemu/hvf.h                  |   37 +
 include/sysemu/hvf_int.h              |    2 +
 target/arm/cpu.h                      |   16 +-
 target/arm/hvf_arm.h                  |    7 +
 target/arm/internals.h                |   53 +-
 target/arm/tcg/helper-a64.h           |    3 +
 target/arm/tcg/translate-a64.h        |    4 +-
 target/arm/tcg/translate.h            |   65 +-
 accel/hvf/hvf-accel-ops.c             |  119 ++
 accel/hvf/hvf-all.c                   |   23 +
 hw/arm/allwinner-r40.c                |  526 ++++++++
 hw/arm/bananapi_m2u.c                 |  145 +++
 hw/arm/xlnx-versal-virt.c             |   53 +
 hw/arm/xlnx-versal.c                  |   37 +
 hw/misc/allwinner-r40-ccu.c           |  209 ++++
 hw/misc/allwinner-r40-dramc.c         |  513 ++++++++
 hw/misc/allwinner-sramc.c             |  184 +++
 hw/misc/axp209.c                      |  238 ----
 hw/misc/axp2xx.c                      |  283 +++++
 hw/net/can/xlnx-versal-canfd.c        | 2107 +++++++++++++++++++++++++++++++++
 hw/sd/allwinner-sdhost.c              |   72 +-
 target/arm/cpu.c                      |    2 +
 target/arm/debug_helper.c             |    5 +
 target/arm/helper.c                   |    6 +-
 target/arm/hvf/hvf.c                  |  750 +++++++++++-
 target/arm/hyp_gdbstub.c              |  253 ++++
 target/arm/kvm64.c                    |  276 -----
 target/arm/tcg/cpu64.c                |    1 +
 target/arm/tcg/helper-a64.c           |    7 +
 target/arm/tcg/hflags.c               |    6 +
 target/arm/tcg/mte_helper.c           |   18 +
 target/arm/tcg/translate-a64.c        |  477 +++++---
 target/arm/tcg/translate-sve.c        |  106 +-
 target/arm/tcg/translate.c            |    1 +
 target/i386/hvf/hvf.c                 |   33 +
 tests/qtest/xlnx-canfd-test.c         |  423 +++++++
 tests/tcg/aarch64/dcpodp.c            |   63 +
 tests/tcg/aarch64/dcpop.c             |   63 +
 tests/tcg/aarch64/mte-7.c             |    3 +-
 tests/tcg/multiarch/sigbus.c          |   13 +-
 hw/arm/Kconfig                        |   14 +-
 hw/arm/meson.build                    |    1 +
 hw/misc/Kconfig                       |    5 +-
 hw/misc/meson.build                   |    5 +-
 hw/misc/trace-events                  |   26 +-
 hw/net/can/meson.build                |    1 +
 hw/net/can/trace-events               |    7 +
 target/arm/meson.build                |    3 +-
 tests/avocado/boot_linux_console.py   |  176 +++
 tests/qtest/meson.build               |    1 +
 tests/tcg/aarch64/Makefile.target     |   11 +
 63 files changed, 7386 insertions(+), 733 deletions(-)
 create mode 100644 docs/system/arm/bananapi_m2u.rst
 create mode 100644 include/hw/arm/allwinner-r40.h
 create mode 100644 include/hw/misc/allwinner-r40-ccu.h
 create mode 100644 include/hw/misc/allwinner-r40-dramc.h
 create mode 100644 include/hw/misc/allwinner-sramc.h
 create mode 100644 include/hw/net/xlnx-versal-canfd.h
 create mode 100644 hw/arm/allwinner-r40.c
 create mode 100644 hw/arm/bananapi_m2u.c
 create mode 100644 hw/misc/allwinner-r40-ccu.c
 create mode 100644 hw/misc/allwinner-r40-dramc.c
 create mode 100644 hw/misc/allwinner-sramc.c
 delete mode 100644 hw/misc/axp209.c
 create mode 100644 hw/misc/axp2xx.c
 create mode 100644 hw/net/can/xlnx-versal-canfd.c
 create mode 100644 target/arm/hyp_gdbstub.c
 create mode 100644 tests/qtest/xlnx-canfd-test.c
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

