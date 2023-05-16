Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2A705807
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0YV-0006Ys-VE; Tue, 16 May 2023 15:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YT-0006YH-Ks
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YO-0002j1-PJ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6439e6f5a33so9192870b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266107; x=1686858107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XdxKQu7ICL1DLg0mXJ/EdtR25GKu8Iokp1OLTkJJbtE=;
 b=Zlg+OO4NAmV/rLB+FCaOycft28D1TFvPt6WWpg7wtVSUCOrkFovdWQK2MTbo1DVxio
 brWHnch1TpaDzUFsJr4D8pqp0Y5kNzFgNqF7mDYlFqE7tX8qsGSIl3xWp8fErVsdQkEH
 naez7B9shRFO0J8YjRFz1ZM4Hq7FSVx+VaQyxzQxmLmauw6cZERqJVZhJujsVNoWqwg8
 t/i2WEAmI9YF2/JjwPx9QyKC/kulFjpiSGcQbnOep0ekFeZM0f/ZY/A0aiVZqcN6XNGz
 daN4yEQxqQ3fV4GxwQUUsGiU5McDpxxDyTn5dQFQgxCjESnpzVudpYm9My5ihxQOaiSz
 43ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266107; x=1686858107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XdxKQu7ICL1DLg0mXJ/EdtR25GKu8Iokp1OLTkJJbtE=;
 b=BXmdqd3h4AuhSPjBbwU9rBHk5Im3FBfbx97GO1L0FUapzMN/RF7vlgJ6UpbeDaom3N
 QUzz0v0gieLEUtnNQdXqoyROye2VNOcXex7y3pBxoUCpTdlgZFkjDzbuD2ndmuqp+8U3
 b880KP5CsiM2dzwGR1B06gjTvr+P5yk04cKr4ZA61t2/1wPXOksxldJXjFKwAdq7ePQx
 xpCFO6rabHe8EvDQ3DxX5w1bZaugQ1e1bYI3MfdzxQMKaOTzHXBuz3qwsgSWHLYBV72w
 NYExabi23vT8PMPm/WYOfZvAvqGpAr3q1qa2SHCpbx4c2QR1UtZeEsAqZ7ZCBMcS6/yE
 YNPQ==
X-Gm-Message-State: AC+VfDw4sFpQfuB291I9vCcs0PtnQoCX6PjnItRJsrkAVI9/vAcSPua8
 a6suULsviuJQ7yNCm71HM7f2kJZoDFmh4f6QUWI=
X-Google-Smtp-Source: ACHHUZ66rMyCexUUySFc2zMOGdSRltEWno0acVRKkmGOg5DTj7quG9jjCQKNc4Ivs8vzf1vwf05gQw==
X-Received: by 2002:a05:6a00:1587:b0:649:76a8:df49 with SMTP id
 u7-20020a056a00158700b0064976a8df49mr24143128pfk.26.1684266107044; 
 Tue, 16 May 2023 12:41:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/80] tcg patch queue
Date: Tue, 16 May 2023 12:40:25 -0700
Message-Id: <20230516194145.1749305-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:

  Merge tag 'or1k-pull-request-20230513' of https://github.com/stffrdhrn/qemu into staging (2023-05-13 11:23:14 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230516

for you to fetch changes up to ee95d036bf4bfa10be65325a287bf3d0e8b2a0e6:

  tcg: Split out exec/user/guest-base.h (2023-05-16 08:11:53 -0700)

----------------------------------------------------------------
tcg/i386: Fix tcg_out_addi_ptr for win64
tcg: Implement atomicity for TCGv_i128
tcg: First quarter of cleanups for building tcg once

----------------------------------------------------------------
Richard Henderson (80):
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
      tcg/i386: Honor 64-bit atomicity in 32-bit mode
      tcg/i386: Support 128-bit load/store with have_atomic16
      tcg/aarch64: Rename temporaries
      tcg/aarch64: Support 128-bit load/store
      tcg/ppc: Support 128-bit load/store
      tcg/s390x: Support 128-bit load/store
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
 tcg/aarch64/tcg-target-con-set.h |    2 +
 tcg/aarch64/tcg-target.h         |   15 +-
 tcg/arm/tcg-target-con-set.h     |   16 +-
 tcg/arm/tcg-target-con-str.h     |    5 +-
 tcg/arm/tcg-target.h             |    3 +-
 tcg/i386/tcg-target.h            |   13 +-
 tcg/loongarch64/tcg-target.h     |    3 +-
 tcg/mips/tcg-target.h            |    4 +-
 tcg/ppc/tcg-target-con-set.h     |    2 +
 tcg/ppc/tcg-target-con-str.h     |    1 +
 tcg/ppc/tcg-target.h             |    4 +-
 tcg/riscv/tcg-target.h           |    4 +-
 tcg/s390x/tcg-target-con-set.h   |    2 +
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
 tcg/tcg.c                        |  627 +++++++++++++++----
 tcg/tci.c                        |  243 +++-----
 accel/tcg/atomic_common.c.inc    |   14 +-
 accel/tcg/ldst_atomicity.c.inc   | 1262 ++++++++++++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc     |  438 ++++++++-----
 tcg/arm/tcg-target.c.inc         |  246 +++-----
 tcg/i386/tcg-target.c.inc        |  467 ++++++++++----
 tcg/loongarch64/tcg-target.c.inc |  123 ++--
 tcg/mips/tcg-target.c.inc        |  216 +++----
 tcg/ppc/tcg-target.c.inc         |  300 +++++----
 tcg/riscv/tcg-target.c.inc       |  161 ++---
 tcg/s390x/tcg-target.c.inc       |  207 ++++---
 tcg/sparc64/tcg-target.c.inc     |  731 ++++++++--------------
 tcg/tci/tcg-target.c.inc         |   58 +-
 tcg/meson.build                  |    1 +
 54 files changed, 5988 insertions(+), 3393 deletions(-)
 create mode 100644 include/exec/user/guest-base.h
 create mode 100644 tcg/tcg-op-ldst.c
 create mode 100644 accel/tcg/ldst_atomicity.c.inc

