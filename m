Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C10EA798B38
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevx-00058L-5F; Fri, 08 Sep 2023 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevt-0004zx-Sz
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-000166-KQ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so2239191f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192761; x=1694797561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vby00EXfAHk9F4JxedYbYAGE+5A79TzrbmC+fpMGu8w=;
 b=P3GvSpjbuzDIbXeqVlPc/aqen3aKPUQdHBmvRhzAufPuVAUbSbbaEjAQLvgGuncz1a
 q+DvLHo4FVTip19MFp4t9qvnFmtTybROrprjoY582UDXMdJ40ItS3/lCxb07aUdJ5Ntu
 B9sPzvzJB/0Djm38dz6vmLJ4nvh5GVqgc1J7Deli5I0/873+j/PjFMxAANAbjYX4A/rm
 6H0MRAmr77fXV0zoT5Oz0gGOFizaMr9o4rBqEEu6T4zHc4oLlPnmCdlJqbvXGzh6wQg2
 0pq8KoQbZ4vK7uZUQfnXkuv7guXnYx85TY11m2pdu2GOvupjuz1UUbWFbu8fClWTZOZc
 ZIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192761; x=1694797561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vby00EXfAHk9F4JxedYbYAGE+5A79TzrbmC+fpMGu8w=;
 b=eQi3xkR1zsZaI2LDttSGbIhtdSBTO7lw1g6hGWmmU9g1V+myw/7pM+uXCthBnJeh21
 vLltVigdZkyU9nXhYE2hQKVLDDH5aAsTtygMvqjwbY5lFSRFJHnIzrzuzxXZyQcZNkAw
 dGg84lND2lkoqWLfXhkoiytONdplSGtcLT8TMtoByJyktnG8cdWTXWrBRUlgw/I5QWqm
 2D4pwPh2fcEaQiDE2PNVyja7MemSoNus9mvjcot0of0vHMg4j/BFZDGGgwXqgXnTUwug
 d/iAR36QtgfLciiGKnTjTjbyAbahJFIZpXH7webcMil6AIsvzBgNpFtogen/JUNKZ5qu
 Jwvw==
X-Gm-Message-State: AOJu0YyHchEc1vwLlxM3PG0AStMZcFt5SkkvQ+rLvmgYm254nF/CP9yP
 cclubj90kkfa6/WgWJyocHNZzcocHpXPMOM4ci8=
X-Google-Smtp-Source: AGHT+IEXBudcnBEIJ2yGep9hgP0nY4jb6xkFDhqOvVc3nQIuoAFIguTYn85XPxwul7J9sXXgnlpL/g==
X-Received: by 2002:a5d:44c2:0:b0:314:35e2:e28d with SMTP id
 z2-20020a5d44c2000000b0031435e2e28dmr2318406wrr.13.1694192760784; 
 Fri, 08 Sep 2023 10:06:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Fri,  8 Sep 2023 18:05:31 +0100
Message-Id: <20230908170557.773048-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Hi; here's the latest arm pullreq...

-- PMM

The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230908

for you to fetch changes up to c8f2eb5d414b788420b938f2ffdde891aa6c3ae8:

  arm/kvm: Enable support for KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE (2023-09-08 16:41:36 +0100)

----------------------------------------------------------------
target-arm queue:
 * New CPU type: cortex-a710
 * Implement new architectural features:
    - FEAT_PACQARMA3
    - FEAT_EPAC
    - FEAT_Pauth2
    - FEAT_FPAC
    - FEAT_FPACCOMBINE
    - FEAT_TIDCP1
 * Xilinx Versal: Model the CFU/CFI
 * Implement RMR_ELx registers
 * Implement handling of HCR_EL2.TIDCP trap bit
 * arm/kvm: Enable support for KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
 * hw/intc/arm_gicv3_its: Avoid maybe-uninitialized error in get_vte()
 * target/arm: Do not use gen_mte_checkN in trans_STGP
 * arm64: Restore trapless ptimer access

----------------------------------------------------------------
Aaron Lindsay (6):
      target/arm: Add ID_AA64ISAR2_EL1
      target/arm: Add feature detection for FEAT_Pauth2 and extensions
      target/arm: Implement FEAT_EPAC
      target/arm: Implement FEAT_Pauth2
      target/arm: Inform helpers whether a PAC instruction is 'combined'
      target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE

Colton Lewis (1):
      arm64: Restore trapless ptimer access

Francisco Iglesias (8):
      hw/misc: Introduce the Xilinx CFI interface
      hw/misc: Introduce a model of Xilinx Versal's CFU_APB
      hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal CFU_FDRO
      hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal's CFU_SFR
      hw/misc: Introduce a model of Xilinx Versal's CFRAME_REG
      hw/misc: Introduce a model of Xilinx Versal's CFRAME_BCAST_REG
      hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO and CFU_SFR
      hw/arm/versal: Connect the CFRAME_REG and CFRAME_BCAST_REG

Philippe Mathieu-Daudé (1):
      hw/intc/arm_gicv3_its: Avoid maybe-uninitialized error in get_vte()

Richard Henderson (9):
      tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
      target/arm: Don't change pauth features when changing algorithm
      target/arm: Implement FEAT_PACQARMA3
      target/arm: Do not use gen_mte_checkN in trans_STGP
      target/arm: Implement RMR_ELx
      target/arm: Implement cortex-a710
      target/arm: Implement HCR_EL2.TIDCP
      target/arm: Implement FEAT_TIDCP1
      target/arm: Enable SCTLR_EL1.TIDCP for user-only

Shameer Kolothum (1):
      arm/kvm: Enable support for KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE

 MAINTAINERS                              |  10 +
 docs/system/arm/cpu-features.rst         |  21 +-
 docs/system/arm/emulation.rst            |   8 +
 docs/system/arm/virt.rst                 |   1 +
 include/hw/arm/xlnx-versal.h             |  85 +++
 include/hw/misc/xlnx-cfi-if.h            |  59 +++
 include/hw/misc/xlnx-versal-cframe-reg.h | 303 +++++++++++
 include/hw/misc/xlnx-versal-cfu.h        | 258 ++++++++++
 include/sysemu/kvm_int.h                 |   1 +
 target/arm/cpu.h                         |  54 +-
 target/arm/helper.h                      |   2 +
 target/arm/syndrome.h                    |   7 +
 target/arm/tcg/helper-a64.h              |   4 +
 tests/tcg/aarch64/pauth.h                |  23 +
 accel/kvm/kvm-all.c                      |   1 +
 hw/arm/virt.c                            |   1 +
 hw/arm/xlnx-versal.c                     | 155 +++++-
 hw/intc/arm_gicv3_its.c                  |  15 +-
 hw/misc/xlnx-cfi-if.c                    |  34 ++
 hw/misc/xlnx-versal-cframe-reg.c         | 858 +++++++++++++++++++++++++++++++
 hw/misc/xlnx-versal-cfu.c                | 563 ++++++++++++++++++++
 target/arm/arm-qmp-cmds.c                |   2 +-
 target/arm/cpu.c                         |   4 +
 target/arm/cpu64.c                       |  86 +++-
 target/arm/helper.c                      |  68 ++-
 target/arm/hvf/hvf.c                     |   1 +
 target/arm/kvm.c                         |  61 +++
 target/arm/kvm64.c                       |   3 +
 target/arm/tcg/cpu64.c                   | 215 ++++++++
 target/arm/tcg/op_helper.c               |  33 ++
 target/arm/tcg/pauth_helper.c            | 180 +++++--
 target/arm/tcg/translate-a64.c           |  74 +--
 target/arm/tcg/translate.c               |  33 ++
 tests/qtest/arm-cpu-features.c           |  12 +-
 tests/tcg/aarch64/pauth-2.c              |  54 +-
 tests/tcg/aarch64/pauth-4.c              |  18 +-
 tests/tcg/aarch64/pauth-5.c              |  10 +
 hw/misc/meson.build                      |   3 +
 qemu-options.hx                          |  15 +
 tests/tcg/aarch64/Makefile.target        |   6 +-
 40 files changed, 3184 insertions(+), 157 deletions(-)
 create mode 100644 include/hw/misc/xlnx-cfi-if.h
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h
 create mode 100644 tests/tcg/aarch64/pauth.h
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 hw/misc/xlnx-versal-cfu.c

