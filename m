Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A779F86C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLT-0000Zw-PZ; Wed, 13 Sep 2023 22:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLR-0000Zn-QV
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:41 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLP-0000ei-CO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c39a4f14bcso4061555ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659477; x=1695264277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIeUsxkvHAkT54s9Ohf7CYbtElerUdSHWA8dCO10vEY=;
 b=lSqipiTEsdsmRWhkCRtkgId/uPHOwMbTu+wXgkyGYsgOM1stVAkbT+qUxBdcx+MyEz
 XdxdQThDcItcuMoNr98LXBeAaEg8pxOSDfiR52+gR1sZIktMVMfycnfUpV02CMWLm5yB
 VGQmtvnMIn/i6BeD7luo6jvo4zlwHZ6u6JC6G4pwn73qOt/C2k3PXYerGDb/k/a8wnsd
 XnqmlNwxwQOVwhupTCZ3UFTl3iQ1DZPTTIGqKwolBe0gckAIEv7lUgUFvRimqMmunfOY
 p0c1F3o64mIaMnucZs/apMFNS4v0j7cueEHNwA/zvtZ2oiU7P9EuDo7ZMiHGUeMQClaV
 qFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659477; x=1695264277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIeUsxkvHAkT54s9Ohf7CYbtElerUdSHWA8dCO10vEY=;
 b=fMl/Zzhvquku6fH2Gi/DVCa3pnFxwD+3lEanJGMmIGE+vdLOfYjzfJJFxQzEJalKhS
 OkfCVylnDgVantZaY/G3ciZAXfcCyRuMuaVdU3tqDO29z52d7B+bf3T5QwVxgFPfSrTq
 qrsGup4Z2CcCXlKyIuPoclwMHmSAI9C/j0wii1enU/WltZEbcfP72m0vODhwMaLGobA9
 U6KeGG5lPbmOXh9qHxparrPLRErCOtCqLTcw1SjiTnWhzhy/SAt/eVBwhlMDM7lRGCYR
 8KdTlHP0S2gYXfb+WJ4tmiPF64KrsipsK7L9dN24HYajO9yICfaCP1sRJ6Wf6jQbEH1m
 k0bQ==
X-Gm-Message-State: AOJu0YwbrbbKqPmMFgvZDPZeKKlxr3LIJ/0+70SfWKo7JAceVCoRLHcG
 7YmgzDCEArzLSpgvrQXjFEXyeLFYwB3Yj98Qz/E=
X-Google-Smtp-Source: AGHT+IHIAoG8d+oeSuidGRU5izO7Be3HyNfvMrY8czAUKyI7pyLb0g0vraJEFpBwGeMuWMe8FJXNVw==
X-Received: by 2002:a17:902:a40a:b0:1c3:4565:22f with SMTP id
 p10-20020a170902a40a00b001c34565022fmr3530902plq.21.1694659477275; 
 Wed, 13 Sep 2023 19:44:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 00/24] Reduce usage of CPUArchState in cputlb.c
Date: Wed, 13 Sep 2023 19:44:11 -0700
Message-Id: <20230914024435.1381329-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Now that CPUTLB has target-independent types, and a target-independent
number of mmu_idx, there's very little reason not to merge it into CPUState.
Once we've done that, all of the objections I had vs Anton's v1 go away.
Indeed even more cleanups are possible, like removing cpu->env_ptr,
because the placement of CPUState and CPUArchState are target-independent,
which we can double-check at build-time.

I'm not happy with the size of patch 12, but I also really want
the pair of functions env_cpu() and cpu_env() to match.


r~


Anton Johansson (9):
  target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
  accel/tcg: Modify tlb_*() to use CPUState
  accel/tcg: Modify probe_access_internal() to use CPUState
  accel/tcg: Modifies memory access functions to use CPUState
  accel/tcg: Modify atomic_mmu_lookup() to use CPUState
  accel/tcg: Use CPUState in atomicity helpers
  accel/tcg: Remove env_tlb()
  accel/tcg: Unify user and softmmu do_[st|ld]*_mmu()
  accel/tcg: move ld/st helpers to ldst_common.c.inc

Richard Henderson (15):
  accel/tcg: Move CPUTLB definitions from cpu-defs.h
  qom: Propagate alignment through type system
  target/*: Use __alignof not __alignof__
  target/arm: Remove size and alignment for cpu subclasses
  target/*: Add instance_align to all cpu base classes
  accel/tcg: Validate placement of CPUNegativeOffsetState
  accel/tcg: Move CPUNegativeOffsetState into CPUState
  accel/tcg: Remove CPUState.icount_decr_ptr
  accel/tcg: Move can_do_io to CPUNegativeOffsetState
  accel/tcg: Remove cpu_neg()
  tcg: Rename cpu_env to tcg_env
  accel/tcg: Replace CPUState.env_ptr with cpu_env()
  accel/tcg: Remove cpu_set_cpustate_pointers
  accel/tcg: Remove env_neg()
  tcg: Remove TCGContext.tlb_fast_offset

 accel/tcg/atomic_template.h                   |   20 +-
 include/exec/cpu-all.h                        |   53 +-
 include/exec/cpu-defs.h                       |  138 --
 include/exec/cpu_ldst.h                       |    8 +-
 include/exec/exec-all.h                       |    2 +-
 include/hw/core/cpu.h                         |  164 ++-
 include/tcg/tcg.h                             |    3 +-
 target/alpha/cpu.h                            |    1 -
 target/arm/common-semi-target.h               |    2 +-
 target/arm/cpu-param.h                        |   12 -
 target/arm/cpu.h                              |    1 -
 target/arm/tcg/translate-a32.h                |    2 +-
 target/arm/tcg/translate-a64.h                |    4 +-
 target/arm/tcg/translate.h                    |   16 +-
 target/avr/cpu.h                              |    1 -
 target/cris/cpu.h                             |    1 -
 target/hexagon/cpu.h                          |    2 +-
 target/hexagon/gen_tcg.h                      |  120 +-
 target/hexagon/gen_tcg_hvx.h                  |   20 +-
 target/hexagon/macros.h                       |    8 +-
 target/hppa/cpu.h                             |    1 -
 target/i386/cpu.h                             |    1 -
 target/loongarch/cpu.h                        |    1 -
 target/m68k/cpu.h                             |    1 -
 target/microblaze/cpu.h                       |    6 +-
 target/mips/cpu.h                             |    4 +-
 target/mips/tcg/translate.h                   |    6 +-
 target/nios2/cpu.h                            |    1 -
 target/openrisc/cpu.h                         |    1 -
 target/ppc/cpu.h                              |    1 -
 target/riscv/cpu.h                            |    2 +-
 target/rx/cpu.h                               |    1 -
 target/s390x/cpu.h                            |    1 -
 target/sh4/cpu.h                              |    1 -
 target/sparc/cpu.h                            |    1 -
 target/tricore/cpu.h                          |    1 -
 target/xtensa/cpu.h                           |    3 +-
 accel/dummy-cpus.c                            |    2 +-
 accel/kvm/kvm-accel-ops.c                     |    2 +-
 accel/tcg/cpu-exec-common.c                   |    2 +-
 accel/tcg/cpu-exec.c                          |   24 +-
 accel/tcg/cputlb.c                            |  762 ++++------
 accel/tcg/tcg-accel-ops-icount.c              |    8 +-
 accel/tcg/tcg-accel-ops-mttcg.c               |    2 +-
 accel/tcg/tcg-accel-ops-rr.c                  |    4 +-
 accel/tcg/tcg-accel-ops.c                     |    2 +-
 accel/tcg/translate-all.c                     |   12 +-
 accel/tcg/translator.c                        |   20 +-
 accel/tcg/user-exec.c                         |  276 +---
 gdbstub/gdbstub.c                             |    4 +-
 gdbstub/user-target.c                         |    2 +-
 hw/core/cpu-common.c                          |    6 +-
 hw/i386/kvm/clock.c                           |    2 +-
 hw/intc/mips_gic.c                            |    2 +-
 hw/intc/riscv_aclint.c                        |   12 +-
 hw/intc/riscv_imsic.c                         |    2 +-
 hw/ppc/e500.c                                 |    4 +-
 hw/ppc/spapr.c                                |    2 +-
 linux-user/elfload.c                          |    4 +-
 linux-user/i386/cpu_loop.c                    |    2 +-
 linux-user/main.c                             |    4 +-
 linux-user/signal.c                           |   15 +-
 monitor/hmp-cmds-target.c                     |    2 +-
 qom/object.c                                  |   14 +
 semihosting/arm-compat-semi.c                 |    6 +-
 semihosting/syscalls.c                        |   28 +-
 softmmu/icount.c                              |    4 +-
 softmmu/watchpoint.c                          |    2 +-
 target/alpha/cpu.c                            |    3 +-
 target/alpha/translate.c                      |  146 +-
 target/arm/cpu.c                              |   14 +-
 target/arm/cpu64.c                            |    4 -
 target/arm/helper.c                           |    2 +-
 target/arm/ptw.c                              |    4 +-
 target/arm/tcg/mte_helper.c                   |    2 +-
 target/arm/tcg/sve_helper.c                   |    2 +-
 target/arm/tcg/tlb_helper.c                   |    4 +-
 target/arm/tcg/translate-a64.c                |  380 ++---
 target/arm/tcg/translate-m-nocp.c             |   24 +-
 target/arm/tcg/translate-mve.c                |   52 +-
 target/arm/tcg/translate-neon.c               |   78 +-
 target/arm/tcg/translate-sme.c                |    8 +-
 target/arm/tcg/translate-sve.c                |  172 +--
 target/arm/tcg/translate-vfp.c                |   56 +-
 target/arm/tcg/translate.c                    |  234 +--
 target/avr/cpu.c                              |    3 +-
 target/avr/translate.c                        |   66 +-
 target/cris/cpu.c                             |    3 +-
 target/cris/translate.c                       |   72 +-
 target/hexagon/cpu.c                          |    4 +-
 target/hexagon/genptr.c                       |   36 +-
 target/hexagon/idef-parser/parser-helpers.c   |    2 +-
 target/hexagon/translate.c                    |   52 +-
 target/hppa/cpu.c                             |    2 +-
 target/hppa/mem_helper.c                      |    2 +-
 target/hppa/translate.c                       |  148 +-
 target/i386/cpu.c                             |    2 +-
 target/i386/tcg/sysemu/excp_helper.c          |    2 +-
 target/i386/tcg/tcg-cpu.c                     |    2 +-
 target/i386/tcg/translate.c                   |  584 ++++----
 target/loongarch/cpu.c                        |    9 +-
 target/loongarch/translate.c                  |   22 +-
 target/m68k/cpu.c                             |    9 +-
 target/m68k/translate.c                       |  306 ++--
 target/microblaze/cpu.c                       |    2 +-
 target/microblaze/translate.c                 |   52 +-
 target/mips/cpu.c                             |    2 +-
 target/mips/tcg/lcsr_translate.c              |    6 +-
 target/mips/tcg/msa_translate.c               |   34 +-
 target/mips/tcg/mxu_translate.c               |    4 +-
 target/mips/tcg/sysemu/mips-semi.c            |    4 +-
 target/mips/tcg/translate.c                   | 1288 ++++++++---------
 target/mips/tcg/vr54xx_translate.c            |    2 +-
 target/nios2/cpu.c                            |    5 +-
 target/nios2/translate.c                      |   52 +-
 target/openrisc/cpu.c                         |    7 +-
 target/openrisc/translate.c                   |   86 +-
 target/ppc/cpu_init.c                         |    3 +-
 target/ppc/excp_helper.c                      |   10 +-
 target/ppc/translate.c                        |  366 ++---
 target/riscv/cpu.c                            |    8 +-
 target/riscv/translate.c                      |   56 +-
 target/rx/cpu.c                               |    5 +-
 target/rx/translate.c                         |   58 +-
 target/s390x/cpu.c                            |    4 +-
 target/s390x/tcg/translate.c                  |  426 +++---
 target/sh4/cpu.c                              |    3 +-
 target/sh4/op_helper.c                        |    2 +-
 target/sh4/translate.c                        |  128 +-
 target/sparc/cpu.c                            |    3 +-
 target/sparc/translate.c                      |  332 ++---
 target/tricore/cpu.c                          |   10 +-
 target/tricore/translate.c                    |  224 +--
 target/xtensa/cpu.c                           |    2 +-
 target/xtensa/translate.c                     |  192 +--
 tcg/tcg-op-gvec.c                             |  288 ++--
 tcg/tcg-op-ldst.c                             |   22 +-
 tcg/tcg-op.c                                  |    2 +-
 tcg/tcg.c                                     |   17 +-
 accel/tcg/ldst_atomicity.c.inc                |   88 +-
 accel/tcg/ldst_common.c.inc                   |  225 +++
 target/cris/translate_v10.c.inc               |   28 +-
 target/i386/tcg/decode-new.c.inc              |    4 +-
 target/i386/tcg/emit.c.inc                    |  262 ++--
 .../loongarch/insn_trans/trans_atomic.c.inc   |    4 +-
 .../loongarch/insn_trans/trans_branch.c.inc   |    2 +-
 target/loongarch/insn_trans/trans_extra.c.inc |   10 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |    6 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  |    8 +-
 target/loongarch/insn_trans/trans_fmov.c.inc  |   20 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   |   44 +-
 .../loongarch/insn_trans/trans_memory.c.inc   |    8 +-
 .../insn_trans/trans_privileged.c.inc         |   52 +-
 target/mips/tcg/micromips_translate.c.inc     |   12 +-
 target/mips/tcg/nanomips_translate.c.inc      |  200 +--
 target/ppc/power8-pmu-regs.c.inc              |    8 +-
 target/ppc/translate/branch-impl.c.inc        |    2 +-
 target/ppc/translate/dfp-impl.c.inc           |   22 +-
 target/ppc/translate/fixedpoint-impl.c.inc    |    2 +-
 target/ppc/translate/fp-impl.c.inc            |   50 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |    8 +-
 target/ppc/translate/spe-impl.c.inc           |   30 +-
 target/ppc/translate/storage-ctrl-impl.c.inc  |   26 +-
 target/ppc/translate/vmx-impl.c.inc           |   34 +-
 target/ppc/translate/vsx-impl.c.inc           |   54 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |    8 +-
 target/riscv/insn_trans/trans_rvbf16.c.inc    |   10 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |   48 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   46 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |   16 +-
 target/riscv/insn_trans/trans_rvm.c.inc       |   16 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |  130 +-
 target/riscv/insn_trans/trans_rvvk.c.inc      |   30 +-
 target/riscv/insn_trans/trans_rvzce.c.inc     |    2 +-
 target/riscv/insn_trans/trans_rvzfa.c.inc     |   38 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   54 +-
 target/riscv/insn_trans/trans_rvzicbo.c.inc   |    8 +-
 target/riscv/insn_trans/trans_svinval.c.inc   |    6 +-
 target/riscv/insn_trans/trans_xthead.c.inc    |    2 +-
 target/s390x/tcg/translate_vx.c.inc           |  104 +-
 tcg/aarch64/tcg-target.c.inc                  |    2 +-
 tcg/arm/tcg-target.c.inc                      |    2 +-
 target/hexagon/README                         |   10 +-
 target/hexagon/gen_tcg_funcs.py               |   16 +-
 186 files changed, 4792 insertions(+), 5041 deletions(-)

-- 
2.34.1


