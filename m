Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116F705C27
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz5Yh-0000lE-68; Tue, 16 May 2023 21:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz5Yf-0000kn-EC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 21:02:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz5Yd-00037y-5u
 for qemu-devel@nongnu.org; Tue, 16 May 2023 21:02:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae454844edso2316835ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684285341; x=1686877341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJVM8aN7xab2/FRZw9M/mRCAs/Bnj4L16USnooVqaLs=;
 b=xFyiHuBAqR1fE/4vHLqC+Osf9z8kerIo2c6tX3HlD2y2zMcy0DPbLKSRxjSS/J/s5B
 D/Oa7bFn3o/rLgs15CgLtLfUGxObiholsTbNXTVxpONoXGZaX4u1oJKM6HJ1fr7kznpk
 2ztpZoJJFxSgbTGHqlN41nTyR6e64ziBaT8oPIQU4G+G41U5YRySwB6NwvrPytNXGGtN
 m0oGd6UxWf2xsrv8faWEM2vMd8ZtGuGCpZ/4jhhkLscBsXIhN+mH8B7jRmE5CQy/xk7A
 QCRAPGuBZwkWoEGWi7gX0+dtPueKieD5dwKWjCwclIHHK1HsD+WwlXevOC6TM0INCySU
 04jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684285341; x=1686877341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJVM8aN7xab2/FRZw9M/mRCAs/Bnj4L16USnooVqaLs=;
 b=k1R8VhjGzRdcND+mnAHYj2tR9HRAi+2MvtRnfT5ggx8dOJ5vJa1LvplP9tzMA1n3Yv
 6Q4I8XZiF71UQyiUQHXDl8ZRWvYwVo8zt1OrXdq2WJ1Lmv47I6kWJ/Rc3ISmBaloD9LH
 7cGhaFemtckFCUTy2Qhfb0HFTKmULE7D41qnrjl0rMbo13a92HSki/wpiZB9NShx46+r
 KvWyyn3Gje+5pEtxdqRfn7ZpPaYaaPc4cMbcWWJbUHKYJgULnDL0Z86XnCo8GT8NokrY
 We+kV854H4k/zsDJlaR8mI2UiysvZvYXvXLc7zFfprhryJbDUNTZJPpRvlnQUC7mlgV7
 qGXA==
X-Gm-Message-State: AC+VfDx998Vl55Smr9Dr14v5dLWiC2O6pChe+TmI3tzQjxecB7h3RkY4
 nzRKlgZaxgyERgGW2/7V+pn6gz1ItCvNidIkvys=
X-Google-Smtp-Source: ACHHUZ5UbaiS0Q6p+G04BLMgihIi4DJe1zjcpXJtZri8yUjUhQEsXeyAWMNH9sPYfKUmy0o98ypgMg==
X-Received: by 2002:a17:902:ea0b:b0:1ac:7d8a:365 with SMTP id
 s11-20020a170902ea0b00b001ac7d8a0365mr41863644plg.26.1684285341409; 
 Tue, 16 May 2023 18:02:21 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 jg6-20020a17090326c600b001ae4c498d29sm610961plb.265.2023.05.16.18.02.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 18:02:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/74] tcg patch queue
Date: Tue, 16 May 2023 18:02:20 -0700
Message-Id: <20230517010220.1990465-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

v2: Drop a few patches, which showed regressions in CI
for jobs that are not run for forks.  :-/


r~


The following changes since commit f9d58e0ca53b3f470b84725a7b5e47fcf446a2ea:

  Merge tag 'pull-9p-20230516' of https://github.com/cschoenebeck/qemu into staging (2023-05-16 10:21:44 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230516-2

for you to fetch changes up to 44fe8f47fce3bdc8dcf49e3f001519a375ecc88a:

  tcg: Split out exec/user/guest-base.h (2023-05-16 16:31:05 -0700)

----------------------------------------------------------------
tcg/i386: Fix tcg_out_addi_ptr for win64
tcg: Implement atomicity for TCGv_i128
tcg: First quarter of cleanups for building tcg once

----------------------------------------------------------------
Richard Henderson (74):
      tcg/i386: Set P_REXW in tcg_out_addi_ptr
      include/exec/memop: Add MO_ATOM_*
      accel/tcg: Honor atomicity of loads
      accel/tcg: Honor atomicity of stores
      tcg: Unify helper_{be,le}_{ld,st}*
      accel/tcg: Implement helper_{ld,st}*_mmu for user-only
      tcg/tci: Use helper_{ld,st}*_mmu for user-only
      tcg: Add 128-bit guest memory primitives
      meson: Detect atomic128 support with optimization
      tcg/i386: Add have_atomic16
      tcg/aarch64: Detect have_lse, have_lse2 for linux
      tcg/aarch64: Detect have_lse, have_lse2 for darwin
      tcg/i386: Use full load/store helpers in user-only mode
      tcg/aarch64: Use full load/store helpers in user-only mode
      tcg/ppc: Use full load/store helpers in user-only mode
      tcg/loongarch64: Use full load/store helpers in user-only mode
      tcg/riscv: Use full load/store helpers in user-only mode
      tcg/arm: Adjust constraints on qemu_ld/st
      tcg/arm: Use full load/store helpers in user-only mode
      tcg/mips: Use full load/store helpers in user-only mode
      tcg/s390x: Use full load/store helpers in user-only mode
      tcg/sparc64: Allocate %g2 as a third temporary
      tcg/sparc64: Rename tcg_out_movi_imm13 to tcg_out_movi_s13
      target/sparc64: Remove tcg_out_movi_s13 case from tcg_out_movi_imm32
      tcg/sparc64: Rename tcg_out_movi_imm32 to tcg_out_movi_u32
      tcg/sparc64: Split out tcg_out_movi_s32
      tcg/sparc64: Use standard slow path for softmmu
      accel/tcg: Remove helper_unaligned_{ld,st}
      tcg/loongarch64: Check the host supports unaligned accesses
      tcg/loongarch64: Support softmmu unaligned accesses
      tcg/riscv: Support softmmu unaligned accesses
      tcg: Introduce tcg_target_has_memory_bswap
      tcg: Add INDEX_op_qemu_{ld,st}_i128
      tcg: Introduce tcg_out_movext3
      tcg: Merge tcg_out_helper_load_regs into caller
      tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}
      tcg: Introduce atom_and_align_for_opc
      tcg/i386: Use atom_and_align_for_opc
      tcg/aarch64: Use atom_and_align_for_opc
      tcg/arm: Use atom_and_align_for_opc
      tcg/loongarch64: Use atom_and_align_for_opc
      tcg/mips: Use atom_and_align_for_opc
      tcg/ppc: Use atom_and_align_for_opc
      tcg/riscv: Use atom_and_align_for_opc
      tcg/s390x: Use atom_and_align_for_opc
      tcg/sparc64: Use atom_and_align_for_opc
      tcg: Split out memory ops to tcg-op-ldst.c
      tcg: Widen gen_insn_data to uint64_t
      accel/tcg: Widen tcg-ldst.h addresses to uint64_t
      tcg: Widen helper_{ld,st}_i128 addresses to uint64_t
      tcg: Widen helper_atomic_* addresses to uint64_t
      tcg: Widen tcg_gen_code pc_start argument to uint64_t
      accel/tcg: Merge gen_mem_wrapped with plugin_gen_empty_mem_callback
      accel/tcg: Merge do_gen_mem_cb into caller
      tcg: Reduce copies for plugin_gen_mem_callbacks
      accel/tcg: Widen plugin_gen_empty_mem_callback to i64
      tcg: Add addr_type to TCGContext
      tcg: Remove TCGv from tcg_gen_qemu_{ld,st}_*
      tcg: Remove TCGv from tcg_gen_atomic_*
      tcg: Split INDEX_op_qemu_{ld,st}* for guest address size
      tcg/tci: Elimnate TARGET_LONG_BITS, target_ulong
      tcg/i386: Always enable TCG_TARGET_HAS_extr[lh]_i64_i32
      tcg/i386: Conditionalize tcg_out_extu_i32_i64
      tcg/i386: Adjust type of tlb_mask
      tcg/i386: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/arm: Remove TARGET_LONG_BITS
      tcg/aarch64: Remove USE_GUEST_BASE
      tcg/aarch64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/loongarch64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/mips: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg: Add page_bits and page_mask to TCGContext
      tcg: Add tlb_dyn_max_bits to TCGContext
      tcg: Split out exec/user/guest-base.h

 docs/devel/loads-stores.rst      |   36 +-
 docs/devel/tcg-ops.rst           |   11 +-
 meson.build                      |   52 +-
 accel/tcg/tcg-runtime.h          |   49 +-
 include/exec/cpu-all.h           |    5 +-
 include/exec/memop.h             |   37 ++
 include/exec/plugin-gen.h        |    4 +-
 include/exec/user/guest-base.h   |   12 +
 include/qemu/cpuid.h             |   18 +
 include/tcg/tcg-ldst.h           |   72 +--
 include/tcg/tcg-op.h             |  273 ++++++---
 include/tcg/tcg-opc.h            |   41 +-
 include/tcg/tcg.h                |   39 +-
 tcg/aarch64/tcg-target.h         |    6 +-
 tcg/arm/tcg-target-con-set.h     |   16 +-
 tcg/arm/tcg-target-con-str.h     |    5 +-
 tcg/arm/tcg-target.h             |    3 +-
 tcg/i386/tcg-target.h            |   12 +-
 tcg/loongarch64/tcg-target.h     |    3 +-
 tcg/mips/tcg-target.h            |    4 +-
 tcg/ppc/tcg-target.h             |    3 +-
 tcg/riscv/tcg-target.h           |    4 +-
 tcg/s390x/tcg-target.h           |    4 +-
 tcg/sparc64/tcg-target-con-set.h |    2 -
 tcg/sparc64/tcg-target-con-str.h |    1 -
 tcg/sparc64/tcg-target.h         |    4 +-
 tcg/tcg-internal.h               |    2 +
 tcg/tci/tcg-target.h             |    4 +-
 accel/tcg/cputlb.c               |  839 ++++++++++++++++---------
 accel/tcg/plugin-gen.c           |   68 +-
 accel/tcg/translate-all.c        |   35 +-
 accel/tcg/user-exec.c            |  488 ++++++++++-----
 tcg/optimize.c                   |   19 +-
 tcg/tcg-op-ldst.c                | 1234 +++++++++++++++++++++++++++++++++++++
 tcg/tcg-op.c                     |  864 --------------------------
 tcg/tcg.c                        |  631 +++++++++++++++----
 tcg/tci.c                        |  243 +++-----
 accel/tcg/atomic_common.c.inc    |   14 +-
 accel/tcg/ldst_atomicity.c.inc   | 1262 ++++++++++++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc     |  207 +++----
 tcg/arm/tcg-target.c.inc         |  246 +++-----
 tcg/i386/tcg-target.c.inc        |  240 ++++----
 tcg/loongarch64/tcg-target.c.inc |  123 ++--
 tcg/mips/tcg-target.c.inc        |  216 +++----
 tcg/ppc/tcg-target.c.inc         |  189 +++---
 tcg/riscv/tcg-target.c.inc       |  161 ++---
 tcg/s390x/tcg-target.c.inc       |  104 +---
 tcg/sparc64/tcg-target.c.inc     |  731 ++++++++--------------
 tcg/tci/tcg-target.c.inc         |   58 +-
 tcg/meson.build                  |    1 +
 50 files changed, 5345 insertions(+), 3350 deletions(-)
 create mode 100644 include/exec/user/guest-base.h
 create mode 100644 tcg/tcg-op-ldst.c
 create mode 100644 accel/tcg/ldst_atomicity.c.inc

