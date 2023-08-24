Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A057877CE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:29:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZF4p-0003Im-3J; Thu, 24 Aug 2023 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZF4m-0003Ie-HS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:29:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZF4j-00056l-IX
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:29:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a40d85593so147052b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692901736; x=1693506536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Houo2/24LmK8XXmN8Coau53IWJcOVK7bPpDrB6gIVME=;
 b=QHazGsGQkzrgw1dSUvzmm20Aaz8B/nkkEeJTlKPBjgO/Q4Jxg61NNlN1ObcPilfhcl
 p0i6QkqO+ep8zrQFHH7th5Ldkr7UNzw9uXbLe0CRqnNFqt7nO2h4S+kNY2gsIqcTKsew
 OqQuhIX+OyjlrJOvP0+jnY7ucbsYRP4HI88pJfpIoK+msL8DPyvLHeAgjYuxwdAlXvu9
 lKw79XTOkGSiMg/tg55HCEOizohs2FITJBcPTG4FF5gWCIeL9BN+S7p6Bk7rFux1FEfc
 unvzUg4QA6hbZEPLIg0OkfRDQSi2O0Yy4G5im0jCB3mtSNTcDfgz29KDSYFYTHuykWvi
 D3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692901736; x=1693506536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Houo2/24LmK8XXmN8Coau53IWJcOVK7bPpDrB6gIVME=;
 b=hfuvTlc8bQ0Nszp7OOLEicHKHP6H3DQXFWO/lP4TC51/sHEiLp/hSs7QFMdyWbK+ln
 tSAhxt+/+4SopEjXm8K9lwHD1q/Da2L1XZ0NkQlhBI0JvPhi6x5EkCE+zV0uryFPePYu
 xh82PVV3yo++Yp9MCYH6IvraZC2H93RbtnsgSVxRCqOktFYrRt0f0roW2zXFZ6Pde42+
 QjPA2+YneJ58JABLz0mPAzi+KPZjc9Xi93tzPpH6n13smtxhg7p38CQZxXd+8P/gEbJe
 w1O4PU0VuK4FQa+dEekI/dGpd5ISA7n9Sez6IVlA/TDcdpUU6SWNh8/rihi4A1rAMzWO
 pq5A==
X-Gm-Message-State: AOJu0Yy5qEtLEkWjrThkueGxkCj81/p2fmhLTjgzWphToxQbQjXnjiM8
 eB13Ri/guSj9EbflSeI9MglRSOT25JXUMf/kLPE=
X-Google-Smtp-Source: AGHT+IEZlEsVTIUUNDvwGX6PzvMHU4lP1BCaVNin5aMWc04uSnV092tEUA+kupBHWXwFxZUdOapQFw==
X-Received: by 2002:a05:6a00:2496:b0:68b:a137:373e with SMTP id
 c22-20020a056a00249600b0068ba137373emr8084497pfv.32.1692901735959; 
 Thu, 24 Aug 2023 11:28:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa78004000000b0064f7c56d8b7sm47354pfi.219.2023.08.24.11.28.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:28:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/48] tcg patch queue
Date: Thu, 24 Aug 2023 11:28:54 -0700
Message-Id: <20230824182854.1572951-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823-2

for you to fetch changes up to 4daad8d9d6b9d426beb8ce505d2164ba36ea3168:

  tcg: spelling fixes (2023-08-24 11:22:42 -0700)

----------------------------------------------------------------
accel/*: Widen pc/saved_insn for *_sw_breakpoint
accel/tcg: Replace remaining target_ulong in system-mode accel
tcg: spelling fixes
tcg: Document bswap, hswap, wswap byte patterns
tcg: Introduce negsetcond opcodes
tcg: Fold deposit with zero to and
tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
tcg/i386: Drop BYTEH deposits for 64-bit
tcg/i386: Allow immediate as input to deposit
target/*: Use tcg_gen_negsetcond_*

----------------------------------------------------------------
Anton Johansson (9):
      accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
      accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
      sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
      sysemu/hvf: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
      include/exec: Replace target_ulong with abi_ptr in cpu_[st|ld]*()
      include/exec: typedef abi_ptr to vaddr in softmmu
      include/exec: Widen tlb_hit/tlb_hit_page()
      accel/tcg: Widen address arg in tlb_compare_set()
      accel/tcg: Update run_on_cpu_data static assert

Mark Cave-Ayland (1):
      docs/devel/tcg-ops: fix missing newlines in "Host vector operations"

Michael Tokarev (1):
      tcg: spelling fixes

Philippe Mathieu-Daudé (9):
      docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
      tcg/tcg-op: Document bswap16_i32() byte pattern
      tcg/tcg-op: Document bswap16_i64() byte pattern
      tcg/tcg-op: Document bswap32_i32() byte pattern
      tcg/tcg-op: Document bswap32_i64() byte pattern
      tcg/tcg-op: Document bswap64_i64() byte pattern
      tcg/tcg-op: Document hswap_i32/64() byte pattern
      tcg/tcg-op: Document wswap_i64() byte pattern
      target/cris: Fix a typo in gen_swapr()

Richard Henderson (28):
      target/m68k: Use tcg_gen_deposit_i32 in gen_partset_reg
      tcg/i386: Drop BYTEH deposits for 64-bit
      tcg: Fold deposit with zero to and
      tcg/i386: Allow immediate as input to deposit_*
      tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
      tcg: Introduce negsetcond opcodes
      tcg: Use tcg_gen_negsetcond_*
      target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
      target/arm: Use tcg_gen_negsetcond_*
      target/m68k: Use tcg_gen_negsetcond_*
      target/openrisc: Use tcg_gen_negsetcond_*
      target/ppc: Use tcg_gen_negsetcond_*
      target/sparc: Use tcg_gen_movcond_i64 in gen_edge
      target/tricore: Replace gen_cond_w with tcg_gen_negsetcond_tl
      tcg/ppc: Implement negsetcond_*
      tcg/ppc: Use the Set Boolean Extension
      tcg/aarch64: Implement negsetcond_*
      tcg/arm: Implement negsetcond_i32
      tcg/riscv: Implement negsetcond_*
      tcg/s390x: Implement negsetcond_*
      tcg/sparc64: Implement negsetcond_*
      tcg/i386: Merge tcg_out_brcond{32,64}
      tcg/i386: Merge tcg_out_setcond{32,64}
      tcg/i386: Merge tcg_out_movcond{32,64}
      tcg/i386: Use CMP+SBB in tcg_out_setcond
      tcg/i386: Clear dest first in tcg_out_setcond if possible
      tcg/i386: Use shift in tcg_out_setcond
      tcg/i386: Implement negsetcond_*

 docs/devel/tcg-ops.rst                     |  15 +-
 accel/tcg/atomic_template.h                |  16 +-
 include/exec/cpu-all.h                     |   4 +-
 include/exec/cpu_ldst.h                    |  28 +--
 include/sysemu/hvf.h                       |  12 +-
 include/sysemu/kvm.h                       |  12 +-
 include/tcg/tcg-op-common.h                |   4 +
 include/tcg/tcg-op.h                       |   2 +
 include/tcg/tcg-opc.h                      |   6 +-
 include/tcg/tcg.h                          |   4 +-
 tcg/aarch64/tcg-target.h                   |   5 +-
 tcg/arm/tcg-target.h                       |   1 +
 tcg/i386/tcg-target-con-set.h              |   2 +-
 tcg/i386/tcg-target-con-str.h              |   1 -
 tcg/i386/tcg-target.h                      |   9 +-
 tcg/loongarch64/tcg-target.h               |   6 +-
 tcg/mips/tcg-target.h                      |   5 +-
 tcg/ppc/tcg-target.h                       |   5 +-
 tcg/riscv/tcg-target.h                     |   5 +-
 tcg/s390x/tcg-target.h                     |   5 +-
 tcg/sparc64/tcg-target.h                   |   5 +-
 tcg/tci/tcg-target.h                       |   5 +-
 accel/hvf/hvf-accel-ops.c                  |   4 +-
 accel/hvf/hvf-all.c                        |   2 +-
 accel/kvm/kvm-all.c                        |   3 +-
 accel/tcg/cputlb.c                         |  17 +-
 target/alpha/translate.c                   |   7 +-
 target/arm/hvf/hvf.c                       |   4 +-
 target/arm/kvm64.c                         |   6 +-
 target/arm/tcg/translate-a64.c             |  22 +--
 target/arm/tcg/translate.c                 |  12 +-
 target/cris/translate.c                    |  20 +-
 target/i386/hvf/hvf.c                      |   4 +-
 target/i386/kvm/kvm.c                      |   8 +-
 target/m68k/translate.c                    |  35 ++--
 target/openrisc/translate.c                |   6 +-
 target/ppc/kvm.c                           |  13 +-
 target/riscv/vector_helper.c               |   2 +-
 target/rx/op_helper.c                      |   6 +-
 target/s390x/kvm/kvm.c                     |   6 +-
 target/sparc/translate.c                   |  17 +-
 target/tricore/translate.c                 |  16 +-
 tcg/optimize.c                             |  78 +++++++-
 tcg/tcg-op-gvec.c                          |   6 +-
 tcg/tcg-op.c                               | 151 ++++++++++++---
 tcg/tcg.c                                  |   9 +-
 target/ppc/translate/fixedpoint-impl.c.inc |   6 +-
 target/ppc/translate/vmx-impl.c.inc        |   8 +-
 tcg/aarch64/tcg-target.c.inc               |  14 +-
 tcg/arm/tcg-target.c.inc                   |  19 +-
 tcg/i386/tcg-target.c.inc                  | 291 ++++++++++++++++++-----------
 tcg/ppc/tcg-target.c.inc                   | 149 ++++++++++-----
 tcg/riscv/tcg-target.c.inc                 |  49 ++++-
 tcg/s390x/tcg-target.c.inc                 |  78 +++++---
 tcg/sparc64/tcg-target.c.inc               |  40 +++-
 55 files changed, 832 insertions(+), 433 deletions(-)

