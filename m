Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A97A2DB6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0i-0005sg-7y; Fri, 15 Sep 2023 23:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0g-0005s9-E7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:18 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0d-0007yB-Ir
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:18 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1d5a8cb70d3so1650885fac.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835014; x=1695439814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ckO0HvZcC316DuuE2fSqN8dQ9Nhe6/0rSFOJ6JnGZPA=;
 b=OV6EuuONB3xY/93/AeysWDS0O45Ab2+SXezvnrScaNEFeavXVJorrAiaN3G450B+1K
 TgJWysp07NJCXdPsgI9ms2S84uT5DzlGoAQM1ohuK9Zjg6kbNEGfaskXjaWAzMQO5SPI
 IEhKTwadW2G0AHtAy7Pm1bVLlsqoV4Kgky4BSo1Bk0Or8Q0LXJ0JnChTgdzzAlxpTPmX
 DjNSJ2U3bVHHP2CExjSWiRdTAxReKUlJ0fc0/wW0yT2oTIxZi6JWY8OSWbg77Nahes1f
 EFmtPU3HxKcSI1KAAPNUAZSPmRjgyaCWWNotk6DAsz6ylHnBJxy3APsrEzdOCoRklK/m
 dl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835014; x=1695439814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ckO0HvZcC316DuuE2fSqN8dQ9Nhe6/0rSFOJ6JnGZPA=;
 b=Zr4oEMC4OjxPirLOz2OhbVnUkf7sVHfwlH3b/E9Lfd7Diz+HkgJtZ97WQTTts2loYr
 aUaBOuuY4QnBkxgJjrDUK5G7o+RqRFj2rm70UqrUVxqlyJhEw0r3Wb3keZkPZnj8J4bm
 8jactUUfKtzr/TMROJl7twJ2jhvNrmZG8zjJdrEO1qkADS8Q8vxVqelqukPDfKHzIdMI
 ealBoBvBxSjrZemZJboi/kBoJAGmjKtRjoj2ZuRZPj0sWPTGO8477m7hxF79Zzj/sdxo
 tBdS7fkeBNUH74OTqNkIk4W4on34gbZqmK1R+NRK/Z30TUwl8mOFioIyirf8qw1VCzRE
 DaTw==
X-Gm-Message-State: AOJu0Yza+XUhshIp7AhbP3ia0DbRaMe1MIxb1GzHKw93J/yqzKatMmtb
 KOUqU1ypqsXly3tjB+sl1liOoPGEBTciL1Xa0dY=
X-Google-Smtp-Source: AGHT+IHXBFKXWYkx4wnnjm2zGHpDYBTQJJVenyhadvImxaGLIyjtkc6PC9SrQUdbXyznsvo5uMvyiA==
X-Received: by 2002:a05:6870:c22b:b0:1d0:e0c9:f33d with SMTP id
 z43-20020a056870c22b00b001d0e0c9f33dmr3582386oae.46.1694835013538; 
 Fri, 15 Sep 2023 20:30:13 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] tcg patch queue
Date: Fri, 15 Sep 2023 20:29:32 -0700
Message-Id: <20230916033011.479144-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230915

for you to fetch changes up to e0d9f49c143359b4a34cb80737af57228c62a008:

  accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG (2023-09-15 19:06:29 -0700)

----------------------------------------------------------------
*: Delete checks for old host definitions
tcg/loongarch64: Generate LSX instructions
fpu: Add conversions between bfloat16 and [u]int8
fpu: Handle m68k extended precision denormals properly
accel/tcg: Improve cputlb i/o organization
accel/tcg: Simplify tlb_plugin_lookup
accel/tcg: Remove false-negative halted assertion
tcg: Add gvec compare with immediate and scalar operand
tcg/aarch64: Emit BTI insns at jump landing pads

----------------------------------------------------------------
Akihiko Odaki (3):
      util: Delete checks for old host definitions
      softmmu: Delete checks for old host definitions
      thunk: Delete checks for old host definitions

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

Jiajie Chen (16):
      tcg/loongarch64: Import LSX instructions
      tcg/loongarch64: Lower basic tcg vec ops to LSX
      tcg: pass vece to tcg_target_const_match()
      tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
      tcg/loongarch64: Lower add/sub_vec to vadd/vsub
      tcg/loongarch64: Lower vector bitwise operations
      tcg/loongarch64: Lower neg_vec to vneg
      tcg/loongarch64: Lower mul_vec to vmul
      tcg/loongarch64: Lower vector min max ops
      tcg/loongarch64: Lower vector saturated ops
      tcg/loongarch64: Lower vector shift vector ops
      tcg/loongarch64: Lower bitsel_vec to vbitsel
      tcg/loongarch64: Lower vector shift integer ops
      tcg/loongarch64: Lower rotv_vec ops to LSX
      tcg/loongarch64: Lower rotli_vec to vrotri
      tcg/loongarch64: Implement 128-bit load & store

LIU Zhiwei (2):
      accel/tcg: Fix the comment for CPUTLBEntryFull
      fpu: Add conversions between bfloat16 and [u]int8

Nicholas Piggin (1):
      accel/tcg: mttcg remove false-negative halted assertion

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

Richard Henderson (31):
      tcg: Add gvec compare with immediate and scalar operand
      target/arm: Use tcg_gen_gvec_cmpi for compare vs 0
      accel/tcg: Simplify tlb_plugin_lookup
      accel/tcg: Split out io_prepare and io_failed
      accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
      plugin: Simplify struct qemu_plugin_hwaddr
      accel/tcg: Merge cpu_transaction_failed into io_failed
      accel/tcg: Replace direct use of io_readx/io_writex in do_{ld,st}_1
      accel/tcg: Merge io_readx into do_ld_mmio_beN
      accel/tcg: Merge io_writex into do_st_mmio_leN
      accel/tcg: Introduce do_ld16_mmio_beN
      accel/tcg: Introduce do_st16_mmio_leN
      fpu: Handle m68k extended precision denormals properly
      tcg: Add tcg_out_tb_start backend hook
      util/cpuinfo-aarch64: Add CPUINFO_BTI
      tcg/aarch64: Emit BTI insns at jump landing pads
      tcg: Map code_gen_buffer with PROT_BTI
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

 MAINTAINERS                                        |    7 +-
 meson.build                                        |    6 +-
 accel/tcg/atomic_template.h                        |   20 +-
 accel/tcg/internal-common.h                        |   28 +
 accel/tcg/{internal.h => internal-target.h}        |   21 +-
 accel/tcg/tcg-runtime.h                            |   25 +
 host/include/aarch64/host/cpuinfo.h                |    1 +
 include/exec/cpu-all.h                             |   67 +-
 include/exec/cpu-common.h                          |   39 +
 include/exec/cpu-defs.h                            |  138 -
 include/exec/cpu_ldst.h                            |    8 +-
 include/exec/exec-all.h                            |   32 +-
 include/exec/user/thunk.h                          |    3 +-
 include/fpu/softfloat.h                            |   12 +
 include/hw/core/cpu.h                              |  180 +-
 include/qemu/accel.h                               |   12 +-
 include/qemu/plugin-memory.h                       |   11 +-
 include/qemu/typedefs.h                            |    1 -
 include/tcg/tcg-op-gvec-common.h                   |    6 +
 include/tcg/tcg.h                                  |    3 +-
 target/alpha/cpu.h                                 |    1 -
 target/arm/common-semi-target.h                    |    2 +-
 target/arm/cpu-param.h                             |   12 -
 target/arm/cpu.h                                   |    1 -
 target/arm/tcg/translate-a32.h                     |    2 +-
 target/arm/tcg/translate-a64.h                     |    4 +-
 target/arm/tcg/translate.h                         |   16 +-
 target/avr/cpu.h                                   |    1 -
 target/cris/cpu.h                                  |    1 -
 target/hexagon/cpu.h                               |    2 +-
 target/hexagon/gen_tcg.h                           |  120 +-
 target/hexagon/gen_tcg_hvx.h                       |   20 +-
 target/hexagon/macros.h                            |    8 +-
 target/hppa/cpu.h                                  |    1 -
 target/i386/cpu.h                                  |    1 -
 target/loongarch/cpu.h                             |    1 -
 target/m68k/cpu.h                                  |    1 -
 target/microblaze/cpu.h                            |    6 +-
 target/mips/cpu.h                                  |    4 +-
 target/mips/tcg/translate.h                        |    6 +-
 target/nios2/cpu.h                                 |    1 -
 target/openrisc/cpu.h                              |    1 -
 target/ppc/cpu.h                                   |    1 -
 target/riscv/cpu.h                                 |    2 +-
 target/rx/cpu.h                                    |    1 -
 target/s390x/cpu.h                                 |    1 -
 target/sh4/cpu.h                                   |    1 -
 target/sparc/cpu.h                                 |    1 -
 target/tricore/cpu.h                               |    1 -
 target/xtensa/cpu.h                                |    3 +-
 tcg/loongarch64/tcg-target-con-set.h               |    9 +
 tcg/loongarch64/tcg-target-con-str.h               |    3 +
 tcg/loongarch64/tcg-target.h                       |   40 +-
 tcg/loongarch64/tcg-target.opc.h                   |   12 +
 accel/{accel-common.c => accel-target.c}           |   27 +-
 accel/dummy-cpus.c                                 |    2 +-
 accel/kvm/kvm-accel-ops.c                          |    2 +-
 accel/tcg/cpu-exec-common.c                        |    5 +-
 accel/tcg/cpu-exec.c                               |   31 +-
 accel/tcg/cputlb.c                                 | 1156 ++--
 softmmu/icount.c => accel/tcg/icount-common.c      |    7 +-
 accel/tcg/monitor.c                                |    2 +-
 accel/tcg/plugin-gen.c                             |   10 +-
 accel/tcg/tb-maint.c                               |    3 +-
 accel/tcg/tcg-accel-ops-icount.c                   |    8 +-
 accel/tcg/tcg-accel-ops-mttcg.c                    |   11 +-
 accel/tcg/tcg-accel-ops-rr.c                       |    4 +-
 accel/tcg/tcg-accel-ops.c                          |    2 +-
 accel/tcg/tcg-all.c                                |    4 +-
 accel/tcg/tcg-runtime-gvec.c                       |   26 +
 accel/tcg/translate-all.c                          |   15 +-
 accel/tcg/translator.c                             |   22 +-
 accel/tcg/user-exec.c                              |  279 +-
 bsd-user/main.c                                    |    2 +-
 bsd-user/signal.c                                  |   10 +-
 cpus-common.c => cpu-common.c                      |    0
 cpu.c => cpu-target.c                              |   13 +-
 fpu/softfloat.c                                    |   67 +-
 gdbstub/gdbstub.c                                  |    4 +-
 gdbstub/user-target.c                              |    2 +-
 hw/core/cpu-common.c                               |    6 +-
 hw/i386/kvm/clock.c                                |    2 +-
 hw/intc/mips_gic.c                                 |    2 +-
 hw/intc/riscv_aclint.c                             |   12 +-
 hw/intc/riscv_imsic.c                              |    2 +-
 hw/ppc/e500.c                                      |    4 +-
 hw/ppc/spapr.c                                     |    2 +-
 linux-user/elfload.c                               |    4 +-
 linux-user/i386/cpu_loop.c                         |    2 +-
 linux-user/main.c                                  |    4 +-
 linux-user/signal.c                                |   15 +-
 monitor/hmp-cmds-target.c                          |    2 +-
 page-vary.c => page-vary-target.c                  |    0
 plugins/api.c                                      |   27 +-
 qom/object.c                                       |   14 +
 semihosting/arm-compat-semi.c                      |    6 +-
 semihosting/syscalls.c                             |   28 +-
 softmmu/async-teardown.c                           |    3 -
 softmmu/watchpoint.c                               |    2 +-
 target/alpha/cpu.c                                 |    3 +-
 target/alpha/translate.c                           |  146 +-
 target/arm/cpu.c                                   |   12 +-
 target/arm/cpu64.c                                 |    4 -
 target/arm/helper.c                                |    2 +-
 target/arm/ptw.c                                   |    4 +-
 target/arm/tcg/mte_helper.c                        |    2 +-
 target/arm/tcg/sve_helper.c                        |    2 +-
 target/arm/tcg/tlb_helper.c                        |    4 +-
 target/arm/tcg/translate-a64.c                     |  380 +-
 target/arm/tcg/translate-m-nocp.c                  |   24 +-
 target/arm/tcg/translate-mve.c                     |   52 +-
 target/arm/tcg/translate-neon.c                    |   78 +-
 target/arm/tcg/translate-sme.c                     |    8 +-
 target/arm/tcg/translate-sve.c                     |  172 +-
 target/arm/tcg/translate-vfp.c                     |   56 +-
 target/arm/tcg/translate.c                         |  290 +-
 target/avr/cpu.c                                   |    3 +-
 target/avr/translate.c                             |   66 +-
 target/cris/cpu.c                                  |    3 +-
 target/cris/translate.c                            |   72 +-
 target/hexagon/cpu.c                               |    4 +-
 target/hexagon/genptr.c                            |   36 +-
 target/hexagon/idef-parser/parser-helpers.c        |    2 +-
 target/hexagon/translate.c                         |   52 +-
 target/hppa/cpu.c                                  |    2 +-
 target/hppa/mem_helper.c                           |    2 +-
 target/hppa/translate.c                            |  148 +-
 target/i386/cpu.c                                  |    2 +-
 target/i386/kvm/kvm-cpu.c                          |    2 +-
 target/i386/nvmm/nvmm-all.c                        |   14 +-
 target/i386/tcg/sysemu/excp_helper.c               |    2 +-
 target/i386/tcg/tcg-cpu.c                          |    2 +-
 target/i386/tcg/translate.c                        |  584 +-
 target/i386/whpx/whpx-all.c                        |   26 +-
 target/loongarch/cpu.c                             |    9 +-
 target/loongarch/translate.c                       |   22 +-
 target/m68k/cpu.c                                  |    9 +-
 target/m68k/translate.c                            |  306 +-
 target/microblaze/cpu.c                            |    2 +-
 target/microblaze/translate.c                      |   52 +-
 target/mips/cpu.c                                  |    2 +-
 target/mips/tcg/lcsr_translate.c                   |    6 +-
 target/mips/tcg/msa_translate.c                    |   34 +-
 target/mips/tcg/mxu_translate.c                    |    4 +-
 target/mips/tcg/sysemu/mips-semi.c                 |    4 +-
 target/mips/tcg/translate.c                        | 1288 ++---
 target/mips/tcg/vr54xx_translate.c                 |    2 +-
 target/nios2/cpu.c                                 |    5 +-
 target/nios2/translate.c                           |   52 +-
 target/openrisc/cpu.c                              |    7 +-
 target/openrisc/translate.c                        |   86 +-
 target/ppc/cpu_init.c                              |    1 -
 target/ppc/excp_helper.c                           |   10 +-
 target/ppc/translate.c                             |  366 +-
 target/riscv/cpu.c                                 |    8 +-
 target/riscv/translate.c                           |   56 +-
 target/rx/cpu.c                                    |    5 +-
 target/rx/translate.c                              |   58 +-
 target/s390x/cpu.c                                 |    2 -
 target/s390x/tcg/translate.c                       |  426 +-
 target/sh4/cpu.c                                   |    3 +-
 target/sh4/op_helper.c                             |    2 +-
 target/sh4/translate.c                             |  128 +-
 target/sparc/cpu.c                                 |    3 +-
 target/sparc/translate.c                           |  332 +-
 target/tricore/cpu.c                               |   10 +-
 target/tricore/translate.c                         |  224 +-
 target/xtensa/cpu.c                                |    2 +-
 target/xtensa/translate.c                          |  192 +-
 tcg/region.c                                       |   41 +-
 tcg/tcg-op-gvec.c                                  |  437 +-
 tcg/tcg-op-ldst.c                                  |   22 +-
 tcg/tcg-op.c                                       |    2 +-
 tcg/tcg.c                                          |   26 +-
 tests/tcg/m68k/denormal.c                          |   53 +
 util/cpuinfo-aarch64.c                             |    7 +
 util/oslib-posix.c                                 |   15 +-
 accel/tcg/ldst_atomicity.c.inc                     |   88 +-
 accel/tcg/ldst_common.c.inc                        |  225 +
 fpu/softfloat-parts.c.inc                          |    7 +-
 target/cris/translate_v10.c.inc                    |   28 +-
 target/i386/tcg/decode-new.c.inc                   |    4 +-
 target/i386/tcg/emit.c.inc                         |  262 +-
 target/loongarch/insn_trans/trans_atomic.c.inc     |    4 +-
 target/loongarch/insn_trans/trans_branch.c.inc     |    2 +-
 target/loongarch/insn_trans/trans_extra.c.inc      |   10 +-
 target/loongarch/insn_trans/trans_farith.c.inc     |    6 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc       |    8 +-
 target/loongarch/insn_trans/trans_fmemory.c.inc    |    8 +-
 target/loongarch/insn_trans/trans_fmov.c.inc       |   20 +-
 target/loongarch/insn_trans/trans_lsx.c.inc        |   44 +-
 target/loongarch/insn_trans/trans_memory.c.inc     |    8 +-
 target/loongarch/insn_trans/trans_privileged.c.inc |   52 +-
 target/mips/tcg/micromips_translate.c.inc          |   12 +-
 target/mips/tcg/nanomips_translate.c.inc           |  200 +-
 target/ppc/power8-pmu-regs.c.inc                   |    8 +-
 target/ppc/translate/branch-impl.c.inc             |    2 +-
 target/ppc/translate/dfp-impl.c.inc                |   22 +-
 target/ppc/translate/fixedpoint-impl.c.inc         |    2 +-
 target/ppc/translate/fp-impl.c.inc                 |   50 +-
 target/ppc/translate/processor-ctrl-impl.c.inc     |    8 +-
 target/ppc/translate/spe-impl.c.inc                |   30 +-
 target/ppc/translate/storage-ctrl-impl.c.inc       |   26 +-
 target/ppc/translate/vmx-impl.c.inc                |   34 +-
 target/ppc/translate/vsx-impl.c.inc                |   54 +-
 target/riscv/insn_trans/trans_privileged.c.inc     |    8 +-
 target/riscv/insn_trans/trans_rvbf16.c.inc         |   10 +-
 target/riscv/insn_trans/trans_rvd.c.inc            |   48 +-
 target/riscv/insn_trans/trans_rvf.c.inc            |   46 +-
 target/riscv/insn_trans/trans_rvh.c.inc            |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc            |   16 +-
 target/riscv/insn_trans/trans_rvm.c.inc            |   16 +-
 target/riscv/insn_trans/trans_rvv.c.inc            |  130 +-
 target/riscv/insn_trans/trans_rvvk.c.inc           |   30 +-
 target/riscv/insn_trans/trans_rvzce.c.inc          |    2 +-
 target/riscv/insn_trans/trans_rvzfa.c.inc          |   38 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc          |   54 +-
 target/riscv/insn_trans/trans_rvzicbo.c.inc        |    8 +-
 target/riscv/insn_trans/trans_svinval.c.inc        |    6 +-
 target/riscv/insn_trans/trans_xthead.c.inc         |    2 +-
 target/s390x/tcg/translate_vx.c.inc                |  104 +-
 tcg/aarch64/tcg-target.c.inc                       |   61 +-
 tcg/arm/tcg-target.c.inc                           |    9 +-
 tcg/i386/tcg-target.c.inc                          |    7 +-
 tcg/loongarch64/tcg-insn-defs.c.inc                | 6019 +++++++++++++++++++-
 tcg/loongarch64/tcg-target.c.inc                   |  628 +-
 tcg/mips/tcg-target.c.inc                          |    7 +-
 tcg/ppc/tcg-target.c.inc                           |    7 +-
 tcg/riscv/tcg-target.c.inc                         |    7 +-
 tcg/s390x/tcg-target.c.inc                         |    7 +-
 tcg/sparc64/tcg-target.c.inc                       |    7 +-
 tcg/tci/tcg-target.c.inc                           |    7 +-
 accel/meson.build                                  |    4 +-
 accel/tcg/meson.build                              |    8 +-
 softmmu/meson.build                                |    4 -
 target/hexagon/README                              |   10 +-
 target/hexagon/gen_tcg_funcs.py                    |   16 +-
 tests/tcg/m68k/Makefile.target                     |    2 +-
 238 files changed, 12363 insertions(+), 5537 deletions(-)
 create mode 100644 accel/tcg/internal-common.h
 rename accel/tcg/{internal.h => internal-target.h} (89%)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h
 rename accel/{accel-common.c => accel-target.c} (87%)
 rename softmmu/icount.c => accel/tcg/icount-common.c (99%)
 rename cpus-common.c => cpu-common.c (100%)
 rename cpu.c => cpu-target.c (97%)
 rename page-vary.c => page-vary-target.c (100%)
 create mode 100644 tests/tcg/m68k/denormal.c

