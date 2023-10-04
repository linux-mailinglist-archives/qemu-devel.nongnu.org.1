Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338A7B830A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3KB-0005lo-JI; Wed, 04 Oct 2023 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo3K9-0005l4-Hw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:05 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo3K6-0005GV-Ss
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:05 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bab8676f9so1257626eaf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696431481; x=1697036281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kga6giDOcYfSfFX0tO5Ly9G/VVaxy0KbMynThKosTpM=;
 b=mD7xB9N6f+yNbWPCYkkpcH84gEFIfcS+hpnR7AoxZXsVTAM0/rSlkJrZV3bXwMJLxt
 94sH8RT0U38tYjx3BLgOo+eXwQYnIXFnDxR0PK2rQ2P/oTU7skUiuDrFCwfm6IPRiCQu
 5X9Feo9vMSZGLHHdCkJBnjhhr6Ujg2Y3Jtck5URIsAt6glJAf9Ev4Nz+sEk+3KohEVxX
 8CIRG42fmkVJuna8+bjGdlldo3h3Mc9AicUIVmXNe5pH0gQgjw4UvGEIQ9Kh0dEHNCmf
 D4FLpsiCFoDFuptkH3cXVnB0dNq3238z84guFoUUeTljkGAljAcjc77g+2wins8qyz/j
 Leuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431481; x=1697036281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kga6giDOcYfSfFX0tO5Ly9G/VVaxy0KbMynThKosTpM=;
 b=WKCS/FL7cEW5Ii8iQxmLmgN2Nt5uPPzuhdcsK3Jy/pFHu1KUQAoNhtoHgKHVAVZ8Z0
 MeedI5EqB1X3Wiy2A9GgeL9flqi06j5itXeN5zVxVHMJpgGBN1wYfvVQ7csZR251Q11j
 w7jp8oUMS4gVFtAlhKlk8AS9oV2oTAjCebvCupCYC38Z/V8sCj24fY5xkmzLIGZ+S+JM
 E56lHP1ekWoSaWtWFG/V/GPWdU9J/Sg7VdJB1sJ8TLXIYwzzjB58Zm0nqICAWuD3oIPL
 vUoEKp0ApzHxMQyuJAO16Xfzcfjni3/Y3WkFKnSexE0f7hyNuoP4XC9cF0khv5ovk/M5
 E5xQ==
X-Gm-Message-State: AOJu0YyN0gNuh6DKtqZ+xNhZSpNKnjWRyydsJo7G4NEYKUjaRkHQoyh1
 ENr11L6ih99yLBqP/4y0ddWUxaxKe141c201+Qk=
X-Google-Smtp-Source: AGHT+IHhhgG6kuq3K7TSzMpaNLl/hQ4mcVcRdkLGjtKAJS29D7gbE/+ZlD8MCenhYU2NYJd1mVDguqhz1nWYLr/qDU8=
X-Received: by 2002:a4a:cb89:0:b0:57b:cbc2:79ff with SMTP id
 y9-20020a4acb89000000b0057bcbc279ffmr1778506ooq.4.1696431479209; Wed, 04 Oct
 2023 07:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Oct 2023 10:57:46 -0400
Message-ID: <CAJSP0QXw80o=S-f3ey1ujF7nY0JwYQ-BPrmxm6nRJPt2wrjxOg@mail.gmail.com>
Subject: Re: [PULL 00/47] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 3 Oct 2023 at 13:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7=
e0:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2023-10-03 07:43:44 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231003
>
> for you to fetch changes up to 971537eca2e6c7aaf185bbf10d4cbd84cf9d8a38:
>
>   tcg/loongarch64: Fix buid error (2023-10-03 08:53:17 -0700)
>
> ----------------------------------------------------------------
> accel: Introduce AccelClass::cpu_common_[un]realize
> accel: Target agnostic code movement
> accel/tcg: Cleanups to use CPUState instead of CPUArchState
> accel/tcg: Move CPUNegativeOffsetState into CPUState
> tcg: Split out tcg init functions to tcg/startup.h
> linux-user/hppa: Fix struct target_sigcontext layout
> build: Remove --enable-gprof
>
> ----------------------------------------------------------------
> Anton Johansson (9):
>       target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
>       accel/tcg: Modify tlb_*() to use CPUState
>       accel/tcg: Modify probe_access_internal() to use CPUState
>       accel/tcg: Modify memory access functions to use CPUState
>       accel/tcg: Modify atomic_mmu_lookup() to use CPUState
>       accel/tcg: Use CPUState in atomicity helpers
>       accel/tcg: Remove env_tlb()
>       accel/tcg: Unify user and softmmu do_[st|ld]*_mmu()
>       accel/tcg: move ld/st helpers to ldst_common.c.inc
>
> Philippe Mathieu-Daud=C3=A9 (19):
>       accel: Rename accel_cpu_realizefn() -> accel_cpu_realize()
>       accel: Rename AccelCPUClass::cpu_realizefn() -> cpu_target_realize(=
)
>       accel: Rename accel_cpu_realize() -> accel_cpu_common_realize()
>       accel: Introduce accel_cpu_common_unrealize() stub
>       accel: Declare AccelClass::cpu_common_[un]realize() handlers
>       accel/tcg: Have tcg_exec_realizefn() return a boolean
>       accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
>       exec: Make EXCP_FOO definitions target agnostic
>       exec: Move cpu_loop_foo() target agnostic functions to 'cpu-common.=
h'
>       accel/tcg: Restrict dump_exec_info() declaration
>       accel: Make accel-blocker.o target agnostic
>       accel: Rename accel-common.c -> accel-target.c
>       exec: Rename cpu.c -> cpu-target.c
>       exec: Rename target specific page-vary.c -> page-vary-target.c
>       accel/tcg: Rename target-specific 'internal.h' -> 'internal-target.=
h'
>       accel/tcg: Make monitor.c a target-agnostic unit
>       accel/tcg: Make icount.o a target agnostic unit
>       accel/tcg: Make cpu-exec-common.c a target agnostic unit
>       tests/avocado: Re-enable MIPS Malta tests (GitLab issue #1884 fixed=
)
>
> Richard Henderson (18):
>       accel/tcg: Move CPUTLB definitions from cpu-defs.h
>       qom: Propagate alignment through type system
>       target/arm: Remove size and alignment for cpu subclasses
>       target/*: Add instance_align to all cpu base classes
>       accel/tcg: Validate placement of CPUNegativeOffsetState
>       accel/tcg: Move CPUNegativeOffsetState into CPUState
>       accel/tcg: Remove CPUState.icount_decr_ptr
>       accel/tcg: Move can_do_io to CPUNegativeOffsetState
>       accel/tcg: Remove cpu_neg()
>       tcg: Rename cpu_env to tcg_env
>       accel/tcg: Replace CPUState.env_ptr with cpu_env()

This commit breaks the build:

../bsd-user/signal.c:479:19: error: unused variable 'env'
[-Werror,-Wunused-variable]
CPUArchState *env =3D cpu_env(cpu);
^

https://gitlab.com/qemu-project/qemu/-/jobs/5222693462

Please resend the pull request with a fix.

Thanks,
Stefan

>       accel/tcg: Remove cpu_set_cpustate_pointers
>       accel/tcg: Remove env_neg()
>       tcg: Remove TCGContext.tlb_fast_offset
>       tcg: Remove argument to tcg_prologue_init
>       tcg: Split out tcg init functions to tcg/startup.h
>       linux-user/hppa: Fix struct target_sigcontext layout
>       build: Remove --enable-gprof
>
> gaosong (1):
>       tcg/loongarch64: Fix buid error
>
>  MAINTAINERS                                        |    7 +-
>  docs/about/deprecated.rst                          |   14 -
>  meson.build                                        |   18 +-
>  accel/tcg/atomic_template.h                        |   20 +-
>  accel/tcg/internal-common.h                        |   28 +
>  accel/tcg/{internal.h =3D> internal-target.h}        |   21 +-
>  bsd-user/bsd-proc.h                                |    3 -
>  include/exec/cpu-all.h                             |   67 +-
>  include/exec/cpu-common.h                          |   39 +
>  include/exec/cpu-defs.h                            |  138 ---
>  include/exec/cpu_ldst.h                            |    8 +-
>  include/exec/exec-all.h                            |   32 +-
>  include/hw/core/accel-cpu.h                        |    2 +-
>  include/hw/core/cpu.h                              |  171 ++-
>  include/qemu/accel.h                               |   12 +-
>  include/tcg/startup.h                              |   58 +
>  include/tcg/tcg.h                                  |    6 +-
>  target/alpha/cpu.h                                 |    1 -
>  target/arm/common-semi-target.h                    |    2 +-
>  target/arm/cpu-param.h                             |   12 -
>  target/arm/cpu.h                                   |    1 -
>  target/arm/tcg/translate-a32.h                     |    2 +-
>  target/arm/tcg/translate-a64.h                     |    4 +-
>  target/arm/tcg/translate.h                         |   16 +-
>  target/avr/cpu.h                                   |    1 -
>  target/cris/cpu.h                                  |    1 -
>  target/hexagon/cpu.h                               |    2 +-
>  target/hexagon/gen_tcg.h                           |  120 +-
>  target/hexagon/gen_tcg_hvx.h                       |   20 +-
>  target/hexagon/macros.h                            |    8 +-
>  target/hppa/cpu.h                                  |    1 -
>  target/i386/cpu.h                                  |    1 -
>  target/loongarch/cpu.h                             |    1 -
>  target/m68k/cpu.h                                  |    1 -
>  target/microblaze/cpu.h                            |    6 +-
>  target/mips/cpu.h                                  |    4 +-
>  target/mips/tcg/translate.h                        |    6 +-
>  target/nios2/cpu.h                                 |    1 -
>  target/openrisc/cpu.h                              |    1 -
>  target/ppc/cpu.h                                   |    1 -
>  target/riscv/cpu.h                                 |    2 +-
>  target/rx/cpu.h                                    |    1 -
>  target/s390x/cpu.h                                 |    1 -
>  target/sh4/cpu.h                                   |    1 -
>  target/sparc/cpu.h                                 |    1 -
>  target/tricore/cpu.h                               |    1 -
>  target/xtensa/cpu.h                                |    3 +-
>  accel/{accel-common.c =3D> accel-target.c}           |   27 +-
>  accel/dummy-cpus.c                                 |    2 +-
>  accel/hvf/hvf-accel-ops.c                          |    2 +-
>  accel/kvm/kvm-accel-ops.c                          |    2 +-
>  accel/tcg/cpu-exec-common.c                        |    5 +-
>  accel/tcg/cpu-exec.c                               |   31 +-
>  accel/tcg/cputlb.c                                 |  787 +++++-------
>  softmmu/icount.c =3D> accel/tcg/icount-common.c      |    7 +-
>  accel/tcg/monitor.c                                |    2 +-
>  accel/tcg/plugin-gen.c                             |   10 +-
>  accel/tcg/tb-maint.c                               |    3 +-
>  accel/tcg/tcg-accel-ops-icount.c                   |    8 +-
>  accel/tcg/tcg-accel-ops-mttcg.c                    |    4 +-
>  accel/tcg/tcg-accel-ops-rr.c                       |    6 +-
>  accel/tcg/tcg-accel-ops.c                          |    2 +-
>  accel/tcg/tcg-all.c                                |    8 +-
>  accel/tcg/translate-all.c                          |   15 +-
>  accel/tcg/translator.c                             |   24 +-
>  accel/tcg/user-exec.c                              |  279 +----
>  bsd-user/main.c                                    |    6 +-
>  bsd-user/signal.c                                  |   15 +-
>  cpus-common.c =3D> cpu-common.c                      |    0
>  cpu.c =3D> cpu-target.c                              |   13 +-
>  gdbstub/gdbstub.c                                  |    4 +-
>  gdbstub/user-target.c                              |    2 +-
>  hw/core/cpu-common.c                               |    6 +-
>  hw/i386/kvm/clock.c                                |    2 +-
>  hw/intc/mips_gic.c                                 |    2 +-
>  hw/intc/riscv_aclint.c                             |   12 +-
>  hw/intc/riscv_imsic.c                              |    2 +-
>  hw/ppc/e500.c                                      |    4 +-
>  hw/ppc/spapr.c                                     |    2 +-
>  linux-user/elfload.c                               |    4 +-
>  linux-user/exit.c                                  |    6 -
>  linux-user/hppa/signal.c                           |    2 +-
>  linux-user/i386/cpu_loop.c                         |    2 +-
>  linux-user/main.c                                  |    8 +-
>  linux-user/signal.c                                |   20 +-
>  linux-user/syscall.c                               |    2 +-
>  monitor/hmp-cmds-target.c                          |    2 +-
>  page-vary.c =3D> page-vary-target.c                  |    0
>  qom/object.c                                       |   14 +
>  semihosting/arm-compat-semi.c                      |    6 +-
>  semihosting/syscalls.c                             |   28 +-
>  softmmu/watchpoint.c                               |    2 +-
>  target/alpha/cpu.c                                 |    3 +-
>  target/alpha/translate.c                           |  146 +--
>  target/arm/cpu.c                                   |   12 +-
>  target/arm/cpu64.c                                 |    4 -
>  target/arm/helper.c                                |    2 +-
>  target/arm/ptw.c                                   |    4 +-
>  target/arm/tcg/mte_helper.c                        |    2 +-
>  target/arm/tcg/sve_helper.c                        |    2 +-
>  target/arm/tcg/tlb_helper.c                        |    4 +-
>  target/arm/tcg/translate-a64.c                     |  384 +++---
>  target/arm/tcg/translate-m-nocp.c                  |   24 +-
>  target/arm/tcg/translate-mve.c                     |   52 +-
>  target/arm/tcg/translate-neon.c                    |   78 +-
>  target/arm/tcg/translate-sme.c                     |    8 +-
>  target/arm/tcg/translate-sve.c                     |  172 +--
>  target/arm/tcg/translate-vfp.c                     |   56 +-
>  target/arm/tcg/translate.c                         |  234 ++--
>  target/avr/cpu.c                                   |    3 +-
>  target/avr/translate.c                             |   66 +-
>  target/cris/cpu.c                                  |    3 +-
>  target/cris/translate.c                            |   72 +-
>  target/hexagon/cpu.c                               |    4 +-
>  target/hexagon/genptr.c                            |   36 +-
>  target/hexagon/idef-parser/parser-helpers.c        |    2 +-
>  target/hexagon/translate.c                         |   52 +-
>  target/hppa/cpu.c                                  |    2 +-
>  target/hppa/mem_helper.c                           |    2 +-
>  target/hppa/translate.c                            |  161 ++-
>  target/i386/cpu.c                                  |    2 +-
>  target/i386/hvf/hvf-cpu.c                          |    2 +-
>  target/i386/kvm/kvm-cpu.c                          |    4 +-
>  target/i386/nvmm/nvmm-all.c                        |   14 +-
>  target/i386/tcg/sysemu/excp_helper.c               |    2 +-
>  target/i386/tcg/tcg-cpu.c                          |    4 +-
>  target/i386/tcg/translate.c                        |  584 ++++-----
>  target/i386/whpx/whpx-all.c                        |   26 +-
>  target/loongarch/cpu.c                             |    9 +-
>  target/loongarch/translate.c                       |   22 +-
>  target/m68k/cpu.c                                  |    9 +-
>  target/m68k/translate.c                            |  306 ++---
>  target/microblaze/cpu.c                            |    2 +-
>  target/microblaze/translate.c                      |   52 +-
>  target/mips/cpu.c                                  |    2 +-
>  target/mips/tcg/lcsr_translate.c                   |    6 +-
>  target/mips/tcg/msa_translate.c                    |   34 +-
>  target/mips/tcg/mxu_translate.c                    |    4 +-
>  target/mips/tcg/sysemu/mips-semi.c                 |    4 +-
>  target/mips/tcg/translate.c                        | 1288 ++++++++++----=
------
>  target/mips/tcg/vr54xx_translate.c                 |    2 +-
>  target/nios2/cpu.c                                 |    5 +-
>  target/nios2/translate.c                           |   52 +-
>  target/openrisc/cpu.c                              |    7 +-
>  target/openrisc/translate.c                        |   86 +-
>  target/ppc/cpu_init.c                              |    1 -
>  target/ppc/excp_helper.c                           |   10 +-
>  target/ppc/translate.c                             |  366 +++---
>  target/riscv/cpu.c                                 |    8 +-
>  target/riscv/translate.c                           |   56 +-
>  target/rx/cpu.c                                    |    5 +-
>  target/rx/translate.c                              |   58 +-
>  target/s390x/cpu.c                                 |    2 -
>  target/s390x/tcg/translate.c                       |  426 +++----
>  target/sh4/cpu.c                                   |    3 +-
>  target/sh4/op_helper.c                             |    2 +-
>  target/sh4/translate.c                             |  128 +-
>  target/sparc/cpu.c                                 |    3 +-
>  target/sparc/translate.c                           |  332 ++---
>  target/tricore/cpu.c                               |   10 +-
>  target/tricore/translate.c                         |  230 ++--
>  target/xtensa/cpu.c                                |    2 +-
>  target/xtensa/translate.c                          |  192 +--
>  tcg/tcg-op-gvec.c                                  |  300 ++---
>  tcg/tcg-op-ldst.c                                  |   22 +-
>  tcg/tcg-op.c                                       |    2 +-
>  tcg/tcg.c                                          |   23 +-
>  accel/tcg/ldst_atomicity.c.inc                     |   88 +-
>  accel/tcg/ldst_common.c.inc                        |  225 ++++
>  target/cris/translate_v10.c.inc                    |   28 +-
>  target/i386/tcg/decode-new.c.inc                   |    4 +-
>  target/i386/tcg/emit.c.inc                         |  262 ++--
>  target/loongarch/insn_trans/trans_atomic.c.inc     |    4 +-
>  target/loongarch/insn_trans/trans_branch.c.inc     |    2 +-
>  target/loongarch/insn_trans/trans_extra.c.inc      |   10 +-
>  target/loongarch/insn_trans/trans_farith.c.inc     |    6 +-
>  target/loongarch/insn_trans/trans_fcmp.c.inc       |    8 +-
>  target/loongarch/insn_trans/trans_fmemory.c.inc    |    8 +-
>  target/loongarch/insn_trans/trans_fmov.c.inc       |   20 +-
>  target/loongarch/insn_trans/trans_memory.c.inc     |    8 +-
>  target/loongarch/insn_trans/trans_privileged.c.inc |   52 +-
>  target/loongarch/insn_trans/trans_vec.c.inc        |   24 +-
>  target/mips/tcg/micromips_translate.c.inc          |   12 +-
>  target/mips/tcg/nanomips_translate.c.inc           |  200 +--
>  target/ppc/power8-pmu-regs.c.inc                   |    8 +-
>  target/ppc/translate/branch-impl.c.inc             |    2 +-
>  target/ppc/translate/dfp-impl.c.inc                |   22 +-
>  target/ppc/translate/fixedpoint-impl.c.inc         |    2 +-
>  target/ppc/translate/fp-impl.c.inc                 |   50 +-
>  target/ppc/translate/processor-ctrl-impl.c.inc     |    8 +-
>  target/ppc/translate/spe-impl.c.inc                |   30 +-
>  target/ppc/translate/storage-ctrl-impl.c.inc       |   26 +-
>  target/ppc/translate/vmx-impl.c.inc                |   34 +-
>  target/ppc/translate/vsx-impl.c.inc                |   54 +-
>  target/riscv/insn_trans/trans_privileged.c.inc     |    8 +-
>  target/riscv/insn_trans/trans_rvbf16.c.inc         |   10 +-
>  target/riscv/insn_trans/trans_rvd.c.inc            |   48 +-
>  target/riscv/insn_trans/trans_rvf.c.inc            |   46 +-
>  target/riscv/insn_trans/trans_rvh.c.inc            |    8 +-
>  target/riscv/insn_trans/trans_rvi.c.inc            |   16 +-
>  target/riscv/insn_trans/trans_rvm.c.inc            |   16 +-
>  target/riscv/insn_trans/trans_rvv.c.inc            |  130 +-
>  target/riscv/insn_trans/trans_rvvk.c.inc           |   30 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc          |    2 +-
>  target/riscv/insn_trans/trans_rvzfa.c.inc          |   38 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc          |   54 +-
>  target/riscv/insn_trans/trans_rvzicbo.c.inc        |    8 +-
>  target/riscv/insn_trans/trans_svinval.c.inc        |    6 +-
>  target/riscv/insn_trans/trans_xthead.c.inc         |    2 +-
>  target/s390x/tcg/translate_vx.c.inc                |  104 +-
>  tcg/aarch64/tcg-target.c.inc                       |    2 +-
>  tcg/arm/tcg-target.c.inc                           |    2 +-
>  tcg/loongarch64/tcg-target.c.inc                   |   68 +-
>  accel/meson.build                                  |    4 +-
>  accel/tcg/meson.build                              |    8 +-
>  meson_options.txt                                  |    3 -
>  scripts/meson-buildoptions.sh                      |    3 -
>  softmmu/meson.build                                |    4 -
>  target/hexagon/README                              |   10 +-
>  target/hexagon/gen_tcg_funcs.py                    |   16 +-
>  tests/avocado/boot_linux_console.py                |    7 -
>  tests/avocado/machine_mips_malta.py                |    6 -
>  tests/avocado/replay_kernel.py                     |    7 -
>  tests/avocado/tuxrun_baselines.py                  |    4 -
>  tests/qemu-iotests/meson.build                     |    2 +-
>  225 files changed, 5102 insertions(+), 5323 deletions(-)
>  create mode 100644 accel/tcg/internal-common.h
>  rename accel/tcg/{internal.h =3D> internal-target.h} (89%)
>  create mode 100644 include/tcg/startup.h
>  rename accel/{accel-common.c =3D> accel-target.c} (86%)
>  rename softmmu/icount.c =3D> accel/tcg/icount-common.c (99%)
>  rename cpus-common.c =3D> cpu-common.c (100%)
>  rename cpu.c =3D> cpu-target.c (97%)
>  rename page-vary.c =3D> page-vary-target.c (100%)
>

