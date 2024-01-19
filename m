Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B37832B7C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:43:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2z-0005tB-GZ; Fri, 19 Jan 2024 09:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0005mx-29
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:26 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003HW-C3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XInRH6k1NBqTHuqJ4vJb3SCtary7tmu+6a7idnszLRU=; b=Phwx/sng1BCUW7NVEqe/lXaP/K
 y0pvQ0dP/dsoHUIBJn+m+KB/N3inK8tJf+ksehs562vLOxiGVhT9GcPBMQjI4Ao0hq8L/W9ddiN1X
 f5h9P/SpVUp/NT5UKF9Z6v8O5ESbzKBMO2Sr683zaj9iRK6+GNWjI3okcEtcnBH4VHVQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 00/34] Compile accel/tcg once (partially)
Date: Fri, 19 Jan 2024 15:39:50 +0100
Message-ID: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Based on an older version of rth/tcg-next and some patches by me, Philippe,
and Richard (most of which have since been merged), base branch here

  https://gitlab.com/AntonJohansson/qemu/-/tree/feature/accel-tcg-once-base

Rebase is in the works, but should not affect the larger parts of this
patchset that I'm looking for feedback on.

This patchset moves forward with the single binary/compile once work and
tries to compile translation units in accel/tcg/ once for system mode.
The following files are compiled once in this patchset

  cputlb.c
  tcg-all.c
  tcg-runtime.c
  tcg-runtime-gvec.c
  tb-maint.c
  plugin-gen.c
  translate-all.c

and debuginfo.c is also moved to common_ss as it doesn't contain any
target specifics.  Work still remains for 

  cpu-exec.c     (TARGET_I386 ifdefs)
  translator.c   (tswap(), ldl_p() and friends)

Brackets [...] in patch names are temporary and indicate patches that
"belong" together and can be split out easier.

Major changes which I'm looking for feedback on:

    - [PAGE_VARY] patches:

        Switches to variable page sizes as a default for all system
        mode targets, meaning TARGET_PAGE_* and TLB_* become target
        independent.

    - "Uninline cpu_mmu_index()"/"Uninline cpu_get_tb_cpu_state()":

        Uninlines cpu_mmu_index() (used by cputlb.c) and
        cpu_get_tb_cpu_state() (used by translate-all.c) so they can be
        called from accel/tcg without pulling in target specifics.

    - "Wrap target macros in functions":

        Introduces wrapper functions in cpu-target.c around target
        macros that I'm not sure how to deal with.

Anton Johansson (34):
  target: [PAGE_VARY] Use PAGE_VARY for all softmmu targets
  target: [PAGE_VARY] Move TARGET_PAGE_BITS_MIN to TargetPageBits
  exec: [PAGE_VARY] Move TARGET_PAGE_BITS_VARY to common header
  exec: [PAGE_VARY] Unpoison TARGET_PAGE_* macros for system mode
  target/tricore: [VADDR] Use target_ulong for EA
  exec: [VADDR] Move vaddr defines to separate file
  hw/core: [VADDR] Include vaddr.h from cpu.h
  target: [VADDR] Use vaddr in gen_intermediate_code
  exec: [VADDR] Use vaddr in DisasContextBase for virtual addresses
  exec: [VADDR] typedef abi_ptr to vaddr
  [IGNORE] Squash of header code shuffling
  target: Uninline cpu_mmu_index()
  target: Uninline cpu_get_tb_cpu_state()
  exec: [CPUTLB] Move PAGE_* macros to common header
  exec: [CPUTLB] Move TLB_*/tlb_*() to common header
  exec: [CPUTLB] Move cpu_*()/cpu_env() to common header
  hw/core: [CPUTLB] Move target specifics to end of TCGCPUOps
  accel/stubs: [CPUTLB] Move xen.h stubs to xen-stub.c
  accel/tcg: [CPUTLB] Use TCGContext.addr_type instead of
    TARGET_LONG_BITS
  accel/tcg: [CPUTLB] Use TCGContext.guest_mo for memory ordering
  accel/tcg: [CPUTLB] Use tcg_ctx->tlb_dyn_max_bits
  accel/tcg: [CPUTLB] Move CPU_TLB_DYN_[DEFAULT|MIN]* to cputlb.c
  tcg: [CPUTLB] Add `mo_te` field to TCGContext
  accel/tcg: [CPUTLB] Set mo_te in TCGContext
  accel/tcg: [CPUTLB] Use tcg_ctx->mo_te instead of MO_TE
  Wrap target macros in functions
  accel/tcg: Make translate-all.c target independent
  accel/tcg: Make plugin-gen.c target independent
  accel/tcg: Make tb-maint.c target indpendent
  accel/tcg: Make tcg-all.c target indpendent
  accel/tcg: Make tcg-runtime-gvec.c target independent
  accel/tcg: Make tcg-runtime.c target independent
  accel/tcg: Make translator.c (partially) target independent
  accel/tcg: Compile (a few files) once for system-mode

 accel/tcg/internal-target.h    |  11 +-
 accel/tcg/tb-hash.h            |   4 +-
 hw/s390x/s390-virtio-hcall.h   |   2 +
 include/exec/cpu-all.h         | 156 +-------------
 include/exec/cpu-common.h      | 185 ++++++++++++++++-
 include/exec/cpu-defs.h        |   7 +-
 include/exec/cpu_ldst-target.h |  52 +++++
 include/exec/cpu_ldst.h        |  95 +++------
 include/exec/exec-all.h        | 347 +------------------------------
 include/exec/exec-common.h     | 367 +++++++++++++++++++++++++++++++++
 include/exec/memory-internal.h |   2 +-
 include/exec/page-vary.h       |   1 +
 include/exec/poison.h          |   2 +
 include/exec/ram_addr.h        |   3 +-
 include/exec/translator.h      |   8 +-
 include/exec/vaddr.h           |  18 ++
 include/hw/core/cpu.h          |  11 +-
 include/hw/core/tcg-cpu-ops.h  |  32 +--
 include/qemu/plugin-memory.h   |   1 -
 include/sysemu/xen.h           |  27 ---
 include/tcg/tcg.h              |   1 +
 target/alpha/cpu-param.h       |   6 +
 target/alpha/cpu.h             |  20 --
 target/arm/cpu-param.h         |   2 +-
 target/arm/cpu.h               |  16 --
 target/avr/cpu-param.h         |   6 +
 target/avr/cpu.h               |  24 ---
 target/cris/cpu-param.h        |   7 +
 target/cris/cpu.h              |  14 --
 target/hexagon/cpu.h           |  21 --
 target/hppa/cpu-param.h        |   6 +
 target/hppa/cpu.h              |  55 -----
 target/i386/cpu-param.h        |   6 +
 target/i386/cpu.h              |  16 --
 target/loongarch/cpu-param.h   |   5 +
 target/loongarch/cpu.h         |  23 ---
 target/m68k/cpu-param.h        |   6 +
 target/m68k/cpu.h              |  20 --
 target/microblaze/cpu-param.h  |   6 +-
 target/microblaze/cpu.h        |  23 ---
 target/mips/cpu-param.h        |   2 +-
 target/mips/cpu.h              |  23 +--
 target/mips/tcg/translate.h    |   3 +-
 target/nios2/cpu-param.h       |   5 +-
 target/nios2/cpu.h             |  18 --
 target/openrisc/cpu-param.h    |   8 +-
 target/openrisc/cpu.h          |  22 --
 target/ppc/cpu-param.h         |   6 +
 target/ppc/cpu.h               |  21 --
 target/riscv/cpu-param.h       |   7 +
 target/riscv/cpu.h             |   5 -
 target/rx/cpu-param.h          |   8 +-
 target/rx/cpu.h                |  14 --
 target/s390x/cpu-param.h       |   8 +-
 target/s390x/cpu.h             |  53 -----
 target/sh4/cpu-param.h         |   4 +-
 target/sh4/cpu.h               |  25 ---
 target/sparc/cpu-param.h       |  17 +-
 target/sparc/cpu.h             |  63 ------
 target/tricore/cpu-param.h     |   8 +-
 target/tricore/cpu.h           |  17 --
 target/xtensa/cpu-param.h      |   8 +-
 target/xtensa/cpu.h            |  73 -------
 accel/stubs/xen-stub.c         |  12 ++
 accel/tcg/cpu-exec.c           |   1 +
 accel/tcg/cputlb.c             |  51 +++--
 accel/tcg/plugin-gen.c         |  15 +-
 accel/tcg/tb-maint.c           |  47 +++--
 accel/tcg/tcg-all.c            |  25 +--
 accel/tcg/tcg-runtime-gvec.c   |   2 +-
 accel/tcg/tcg-runtime.c        |   2 +-
 accel/tcg/translate-all.c      |  40 ++--
 accel/tcg/translator.c         |  16 +-
 cpu-target.c                   |  62 ++++++
 page-vary-common.c             |   1 +
 page-vary-target.c             |   4 +-
 plugins/core.c                 |   1 +
 target/alpha/cpu.c             |  19 ++
 target/alpha/translate.c       |   2 +-
 target/arm/cpu.c               |   6 +
 target/arm/tcg/translate.c     |   6 +-
 target/avr/cpu.c               |  23 +++
 target/avr/translate.c         |   2 +-
 target/cris/cpu.c              |  14 ++
 target/cris/translate.c        |   2 +-
 target/hexagon/cpu.c           |  21 ++
 target/hexagon/translate.c     |   5 +-
 target/hppa/cpu.c              |  59 ++++++
 target/hppa/translate.c        |   2 +-
 target/i386/cpu.c              |  16 ++
 target/i386/tcg/translate.c    |   2 +-
 target/loongarch/cpu.c         |  23 +++
 target/loongarch/translate.c   |   2 +-
 target/m68k/cpu.c              |  21 ++
 target/m68k/translate.c        |   4 +-
 target/microblaze/cpu.c        |  23 +++
 target/microblaze/translate.c  |   2 +-
 target/mips/cpu.c              |  23 +++
 target/mips/tcg/translate.c    |  14 +-
 target/nios2/cpu.c             |  18 ++
 target/nios2/translate.c       |   2 +-
 target/openrisc/cpu.c          |  22 ++
 target/openrisc/translate.c    |   2 +-
 target/ppc/cpu.c               |  20 ++
 target/ppc/translate.c         |   2 +-
 target/riscv/cpu_helper.c      |   2 +-
 target/riscv/translate.c       |   2 +-
 target/rx/cpu.c                |  14 ++
 target/rx/translate.c          |   2 +-
 target/s390x/cpu.c             |  55 +++++
 target/s390x/tcg/translate.c   |   2 +-
 target/sh4/cpu.c               |  28 +++
 target/sh4/translate.c         |   2 +-
 target/sparc/cpu.c             |  63 ++++++
 target/sparc/gdbstub.c         |   3 +
 target/sparc/translate.c       |   2 +-
 target/tricore/cpu.c           |  17 ++
 target/tricore/op_helper.c     |   8 +-
 target/tricore/translate.c     |   2 +-
 target/xtensa/cpu.c            |  72 +++++++
 target/xtensa/translate.c      |   2 +-
 accel/tcg/meson.build          |  57 +++--
 122 files changed, 1656 insertions(+), 1345 deletions(-)
 create mode 100644 include/exec/cpu_ldst-target.h
 create mode 100644 include/exec/exec-common.h
 create mode 100644 include/exec/vaddr.h

-- 
2.43.0


