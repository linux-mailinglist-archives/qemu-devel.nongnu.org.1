Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0187A32BA
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2k-00054x-UK; Sat, 16 Sep 2023 17:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2f-00053Z-W6
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:30 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2d-0000PX-Nb
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:29 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so2066790a34.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900485; x=1695505285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yNoUiGpS5wPameebRMI01jAFCMhH9xlOoUO6Bpwlapk=;
 b=opRvTA+rXE/djLYBRnv3TykMarQa+o/hsDpEM1Zq/Zrkvwi1NSUf1xKpKgkd2WgPRp
 Ll9sOHdAtcTcGWIdPyv8bpqevH6oQCQajE4p0muEwtruButkfRnSAVMYedlYcD9xrOfv
 rdjcLCnW9sBeM2LrJ7JbLro7OkLGXKm0NFBG1yQVRk3QrtxJGrc0kDos0jW6EOC1Gci6
 MNxmio20e4jnZrP0S8F7g5j9zgmqrdz46jhHhLbz0S0b0zTG3zYabqaWzxALh5NU5RNz
 Io3fukRt3vXZnlzYmCrEoHb3oRDZBb1pPt2Rn2idMey/X02x+o0JTx+XBBgGsnWg9gaf
 5J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900485; x=1695505285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNoUiGpS5wPameebRMI01jAFCMhH9xlOoUO6Bpwlapk=;
 b=h1i8MSyPGzXCea/qT9SPKx2ZHGhn6gZ4knCjwIaatLjsDfvaBcmG+Irx4eCO8Mq+uU
 y4tblmcCtV+H4AY/wd/dsnAKHcjhGfZ+L1x+G2g/pSp7QPJsvOPDy23HOsZVmBHCl72L
 ljYpcxLsZ1wqWk2Eh8+0SFZP2FvWRoFIt8JdGN3CY1IpTGUiv4nFLQX7O6tqZoYUt/RG
 uH1eo1+EzYMFKIAVqLdxjNXiTqI9zfWkUvqcwPjp5JjwUXovn3rDKoHGOaIQKy5Wp4RV
 FQ0+z/UV4mJVRaRNNIzlvAbnPeJIIlvqr3TsPxeGhmV3qDmV52wxKhGWFfh2rX/rwfHc
 vjQQ==
X-Gm-Message-State: AOJu0YywWhAmPOwzf2d2A+0RWn/gkPOxdp/TRT2DtTHWT08TJo4mnk0Z
 IG+9EkMi1+45xD7A73kn8p7WC09C3m9KMoYP6lw=
X-Google-Smtp-Source: AGHT+IEMKVBvLqHNNk+ScFCWQ7V+M2jMtN1MBE6C/QSM6UdPRKsMhE8OmpV21N2eQs3u/7EMNisBkQ==
X-Received: by 2002:a05:6358:991b:b0:135:73b0:cc6c with SMTP id
 w27-20020a056358991b00b0013573b0cc6cmr5831605rwa.28.1694900485053; 
 Sat, 16 Sep 2023 14:41:25 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 00/39] target agnostic cleanups
Date: Sat, 16 Sep 2023 14:40:44 -0700
Message-Id: <20230916214123.525796-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Omnibus cleanups for making more code target agnostic.


r~


Based-on: 20230916171223.521545-1-richard.henderson@linaro.org
("[PULL v2 00/39] tcg patch queue")

Supercedes: 20230914024435.1381329-1-richard.henderson@linaro.org
("[PATCH v2 00/24] Reduce usage of CPUArchState in cputlb.c")
Supercedes: 20230914185718.76241-1-philmd@linaro.org
("[PATCH 00/11] accel/tcg: Make more files target agnostic (& exec/ housekeeping)")
Supercedes: 20230915190009.68404-1-philmd@linaro.org
("[PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG")

Anton Johansson (9):
  target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
  accel/tcg: Modify tlb_*() to use CPUState
  accel/tcg: Modify probe_access_internal() to use CPUState
  accel/tcg: Modify memory access functions to use CPUState
  accel/tcg: Modify atomic_mmu_lookup() to use CPUState
  accel/tcg: Use CPUState in atomicity helpers
  accel/tcg: Remove env_tlb()
  accel/tcg: Unify user and softmmu do_[st|ld]*_mmu()
  accel/tcg: move ld/st helpers to ldst_common.c.inc

Philippe Mathieu-Daudé (16):
  exec: Make EXCP_FOO definitions target agnostic
  exec: Move cpu_loop_foo() target agnostic functions to 'cpu-common.h'
  accel/tcg: Restrict dump_exec_info() declaration
  accel: Make accel-blocker.o target agnostic
  accel: Rename accel-common.c -> accel-target.c
  exec: Rename cpu.c -> cpu-target.c
  exec: Rename target specific page-vary.c -> page-vary-target.c
  accel/tcg: Rename target-specific 'internal.h' -> 'internal-target.h'
  accel/tcg: Make monitor.c a target-agnostic unit
  accel/tcg: Make icount.o a target agnostic unit
  accel/tcg: Make cpu-exec-common.c a target agnostic unit
  accel: Rename accel_cpu_realizefn() -> accel_cpu_realize()
  accel: Introduce accel_cpu_unrealize() stub
  accel: Declare AccelClass::[un]realize_cpu() handlers
  accel/tcg: Have tcg_exec_realizefn() return a boolean
  accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG

Richard Henderson (14):
  accel/tcg: Move CPUTLB definitions from cpu-defs.h
  qom: Propagate alignment through type system
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

 MAINTAINERS                                   |    7 +-
 meson.build                                   |    6 +-
 accel/tcg/atomic_template.h                   |   20 +-
 accel/tcg/internal-common.h                   |   28 +
 accel/tcg/{internal.h => internal-target.h}   |   21 +-
 include/exec/cpu-all.h                        |   67 +-
 include/exec/cpu-common.h                     |   39 +
 include/exec/cpu-defs.h                       |  138 --
 include/exec/cpu_ldst.h                       |    8 +-
 include/exec/exec-all.h                       |   32 +-
 include/hw/core/cpu.h                         |  167 ++-
 include/qemu/accel.h                          |   12 +-
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
 accel/{accel-common.c => accel-target.c}      |   27 +-
 accel/dummy-cpus.c                            |    2 +-
 accel/kvm/kvm-accel-ops.c                     |    2 +-
 accel/tcg/cpu-exec-common.c                   |    5 +-
 accel/tcg/cpu-exec.c                          |   31 +-
 accel/tcg/cputlb.c                            |  787 ++++------
 softmmu/icount.c => accel/tcg/icount-common.c |    7 +-
 accel/tcg/monitor.c                           |    2 +-
 accel/tcg/plugin-gen.c                        |   10 +-
 accel/tcg/tb-maint.c                          |    3 +-
 accel/tcg/tcg-accel-ops-icount.c              |    8 +-
 accel/tcg/tcg-accel-ops-mttcg.c               |    2 +-
 accel/tcg/tcg-accel-ops-rr.c                  |    4 +-
 accel/tcg/tcg-accel-ops.c                     |    2 +-
 accel/tcg/tcg-all.c                           |    4 +-
 accel/tcg/translate-all.c                     |   15 +-
 accel/tcg/translator.c                        |   22 +-
 accel/tcg/user-exec.c                         |  279 +---
 bsd-user/main.c                               |    2 +-
 bsd-user/signal.c                             |   10 +-
 cpus-common.c => cpu-common.c                 |    0
 cpu.c => cpu-target.c                         |   13 +-
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
 page-vary.c => page-vary-target.c             |    0
 qom/object.c                                  |   14 +
 semihosting/arm-compat-semi.c                 |    6 +-
 semihosting/syscalls.c                        |   28 +-
 softmmu/watchpoint.c                          |    2 +-
 target/alpha/cpu.c                            |    3 +-
 target/alpha/translate.c                      |  146 +-
 target/arm/cpu.c                              |   12 +-
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
 target/i386/kvm/kvm-cpu.c                     |    2 +-
 target/i386/nvmm/nvmm-all.c                   |   14 +-
 target/i386/tcg/sysemu/excp_helper.c          |    2 +-
 target/i386/tcg/tcg-cpu.c                     |    2 +-
 target/i386/tcg/translate.c                   |  584 ++++----
 target/i386/whpx/whpx-all.c                   |   26 +-
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
 target/ppc/cpu_init.c                         |    1 -
 target/ppc/excp_helper.c                      |   10 +-
 target/ppc/translate.c                        |  366 ++---
 target/riscv/cpu.c                            |    8 +-
 target/riscv/translate.c                      |   56 +-
 target/rx/cpu.c                               |    5 +-
 target/rx/translate.c                         |   58 +-
 target/s390x/cpu.c                            |    2 -
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
 tcg/tcg-op-gvec.c                             |  300 ++--
 tcg/tcg-op-ldst.c                             |   22 +-
 tcg/tcg-op.c                                  |    2 +-
 tcg/tcg.c                                     |   19 +-
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
 accel/meson.build                             |    4 +-
 accel/tcg/meson.build                         |    8 +-
 softmmu/meson.build                           |    4 -
 target/hexagon/README                         |   10 +-
 target/hexagon/gen_tcg_funcs.py               |   16 +-
 208 files changed, 4986 insertions(+), 5190 deletions(-)
 create mode 100644 accel/tcg/internal-common.h
 rename accel/tcg/{internal.h => internal-target.h} (89%)
 rename accel/{accel-common.c => accel-target.c} (87%)
 rename softmmu/icount.c => accel/tcg/icount-common.c (99%)
 rename cpus-common.c => cpu-common.c (100%)
 rename cpu.c => cpu-target.c (97%)
 rename page-vary.c => page-vary-target.c (100%)

-- 
2.34.1


