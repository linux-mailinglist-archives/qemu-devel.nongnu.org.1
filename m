Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A80786BDE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eR-00063h-Qh; Thu, 24 Aug 2023 05:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6dz-000449-SY
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6ds-0004xC-SS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso5874600f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869318; x=1693474118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HLTBR96lB46MelsXx951qbJmtNZPHpJaeVISQ3LF2xg=;
 b=XX/If3FUqeina459nAC/a1Sbg7GSpyYGDt6YBatEnFYmVtR8RTDmWOpyxOJOMeaGTy
 UoJW0jAKdnfJFHxsaBH/yrqd2+MuayHkxXfq6yYsyuGaziesetoPeQl0HP8XgQOZfBF6
 9e0OyByNDcXHj2NArfSDCIhU0ZVJ9lnbD/yzelO6wSNXmWZg5kdG/4rebgl/8ghgjTNy
 qY2Ly5d7LmLl0x9KVEFvOZ5xehXcJCGkHsXvbZd9X+E7cYsobTRd8vku4om0AFsWk+N1
 I3k8VWWTj8TVe/ar6rtX99kYrwtL09RLtIpRu1s1qYLZYnGzwdFVQQBgixtBdzo/u2Cj
 2q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869318; x=1693474118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLTBR96lB46MelsXx951qbJmtNZPHpJaeVISQ3LF2xg=;
 b=exU4EkYCohBGMbW5+kVwX/RYi/pNmJ2AuZ8fjp8cyZbg7KjXHPckDUDXdhgEO7qDNb
 T9eF6qCJoh8gguojMEoj7V4nMVn8KwpclijP/z2f7abxRe9cSkrx+ZJQhVbY3XxVQWE2
 f6LNttTIapEmuVY6qVIwqRNXvmLa/sLbrJ1XY3KOOlJo2bqswEInfxLn8qNWLKi1lnPF
 Pxh5V/86IWSwM0ddT4yRVW8QdPUsxDFBA0//1GFgVQ6NMHSPXE9Ieo6WYM70TJaps1og
 m06arY7LJ80Re0yPYkh5hdtlvPS5axCHPCLuqacJVbHPwy3MiCaOKy5/Pv6kG5BZBWBR
 NLLA==
X-Gm-Message-State: AOJu0YytJQK4RyX10HnSdA0seIthGb6ETr9YUzBExFtQNOT8GgYszpCt
 ZZfXdJzaWvCV991awn64ZUAhuoYQLIf+BIr7bGs=
X-Google-Smtp-Source: AGHT+IFqT9mdzPYlgM02HckeZ338D/AP5qwVBCthjQv0oj+yrszjCiabfxZgcjd+1pp7HH+mJyHbJw==
X-Received: by 2002:a5d:530a:0:b0:317:6edb:6138 with SMTP id
 e10-20020a5d530a000000b003176edb6138mr12219168wrv.62.1692869317740; 
 Thu, 24 Aug 2023 02:28:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] target-arm queue
Date: Thu, 24 Aug 2023 10:28:01 +0100
Message-Id: <20230824092836.2239644-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi; here's the first arm pullreq for the 8.2 cycle. These are
pretty much all bug fixes (mostly for the experimental FEAT_RME),
rather than any major features.

-- PMM

The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:

  Open 8.2 development tree (2023-08-22 07:14:07 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230824

for you to fetch changes up to cd1e4db73646006039f25879af3bff55b2295ff3:

  target/arm: Fix 64-bit SSRA (2023-08-22 17:31:14 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/gpio/nrf51: implement DETECT signal
 * accel/kvm: Specify default IPA size for arm64
 * ptw: refactor, fix some FEAT_RME bugs
 * target/arm: Adjust PAR_EL1.SH for Device and Normal-NC memory types
 * target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK
 * Fix SME ST1Q
 * Fix 64-bit SSRA

----------------------------------------------------------------
Akihiko Odaki (6):
      kvm: Introduce kvm_arch_get_default_type hook
      accel/kvm: Specify default IPA size for arm64
      mips: Report an error when KVM_VM_MIPS_VZ is unavailable
      accel/kvm: Use negative KVM type for error propagation
      accel/kvm: Free as when an error occurred
      accel/kvm: Make kvm_dirty_ring_reaper_init() void

Chris Laplante (6):
      hw/gpio/nrf51: implement DETECT signal
      qtest: factor out qtest_install_gpio_out_intercept
      qtest: implement named interception of out-GPIO
      qtest: bail from irq_intercept_in if name is specified
      qtest: irq_intercept_[out/in]: return FAIL if no intercepts are installed
      qtest: microbit-test: add tests for nRF51 DETECT

Jean-Philippe Brucker (6):
      target/arm/ptw: Load stage-2 tables from realm physical space
      target/arm/helper: Fix tlbmask and tlbbits for TLBI VAE2*
      target/arm: Skip granule protection checks for AT instructions
      target/arm: Pass security space rather than flag for AT instructions
      target/arm/helper: Check SCR_EL3.{NSE, NS} encoding for AT instructions
      target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK

Peter Maydell (15):
      target/arm/ptw: Don't set fi->s1ptw for UnsuppAtomicUpdate fault
      target/arm/ptw: Don't report GPC faults on stage 1 ptw as stage2 faults
      target/arm/ptw: Set s1ns bit in fault info more consistently
      target/arm/ptw: Pass ptw into get_phys_addr_pmsa*() and get_phys_addr_disabled()
      target/arm/ptw: Pass ARMSecurityState to regime_translation_disabled()
      target/arm/ptw: Pass an ARMSecuritySpace to arm_hcr_el2_eff_secstate()
      target/arm: Pass an ARMSecuritySpace to arm_is_el2_enabled_secstate()
      target/arm/ptw: Only fold in NSTable bit effects in Secure state
      target/arm/ptw: Remove last uses of ptw->in_secure
      target/arm/ptw: Remove S1Translate::in_secure
      target/arm/ptw: Drop S1Translate::out_secure
      target/arm/ptw: Set attributes correctly for MMU disabled data accesses
      target/arm/ptw: Check for block descriptors at invalid levels
      target/arm/ptw: Report stage 2 fault level for stage 2 faults on stage 1 ptw
      target/arm: Adjust PAR_EL1.SH for Device and Normal-NC memory types

Richard Henderson (2):
      target/arm: Fix SME ST1Q
      target/arm: Fix 64-bit SSRA

 include/hw/gpio/nrf51_gpio.h |   1 +
 include/sysemu/kvm.h         |   2 +
 target/arm/cpu.h             |  19 ++--
 target/arm/internals.h       |  25 ++---
 target/mips/kvm_mips.h       |   9 --
 tests/qtest/libqtest.h       |  11 +++
 accel/kvm/kvm-all.c          |  19 ++--
 hw/arm/virt.c                |   2 +-
 hw/gpio/nrf51_gpio.c         |  14 ++-
 hw/mips/loongson3_virt.c     |   2 -
 hw/ppc/spapr.c               |   2 +-
 softmmu/qtest.c              |  52 +++++++---
 target/arm/cpu.c             |   6 ++
 target/arm/helper.c          | 207 ++++++++++++++++++++++++++++----------
 target/arm/kvm.c             |   7 ++
 target/arm/ptw.c             | 231 ++++++++++++++++++++++++++-----------------
 target/arm/tcg/sme_helper.c  |   2 +-
 target/arm/tcg/translate.c   |   2 +-
 target/i386/kvm/kvm.c        |   5 +
 target/mips/kvm.c            |   3 +-
 target/ppc/kvm.c             |   5 +
 target/riscv/kvm.c           |   5 +
 target/s390x/kvm/kvm.c       |   5 +
 tests/qtest/libqtest.c       |   6 ++
 tests/qtest/microbit-test.c  |  44 +++++++++
 target/arm/trace-events      |   7 +-
 26 files changed, 494 insertions(+), 199 deletions(-)

