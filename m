Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 540177174B1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3p-0006pu-MD; Wed, 31 May 2023 00:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3g-0006oF-3v
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3d-00068g-TL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso5919907b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505811; x=1688097811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lJtP9bM0lCv4tmu240Of9URePLVmQSsBQgKsJry5xTY=;
 b=AZ0fUqzvvt6GrjgLlkLfZoNX29B1bRnuGtoqbPwtLd1xLeBXoyXt/4zgFFaVUxK3R+
 Hzdm62jocBtbAAgEiSSIfDbJsLV1z1O9Gymqb7vp0WBlWMFg5uHr24GAeXGxbcAlqwyg
 BdnjdBBStr4bEYDQDCTv1W/wWAAiOeWDduu0Qq4p5+UeIPLBESbJ6ts8N6LefEqIqs6A
 3hgwIxWgNzcQ+Hs98jVqJjiDSdKqSFn2vfbw72CoTxa+pv26P8pcpiXXvPdmwrfwG5M6
 e5RR/WzFPnp8tLx5ZPMrVAkzxj7huIjR4HB8h+Tq9IpbU5dH0Og/QBFW6qCz978DuLKJ
 WA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505811; x=1688097811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJtP9bM0lCv4tmu240Of9URePLVmQSsBQgKsJry5xTY=;
 b=hwKAzgqKV7GjiANhsGfaDRGhuSC+qmPtWWrfsxIksvQ4tZ/tQYoR6kVVEl7FO8c06W
 pPdw4F/+bJ8KEo3Opg+gppU4Ht3NMLwN2qu5yrqda2rkVhf66HKSMIK/ZplVFmlIcDuh
 0uaHb6s2zVUHzo7LpIMjtjk5hYyuzGhDyXomKLm5W43M+QBfwz1LEWWUDANvqZUSFOXp
 Vtju6VQcyXDjF/MHPr3DlKR1l40msLKVs8gm4z7AR6rStYQHnPKYHgVZSfAa3+bnutcn
 VKI8IoyIYBzycrz/GlOyRZfwFwwRmM0TUEQII7TcYBmZLMaNz2USRBi4LgP7G1A72tPg
 S4zA==
X-Gm-Message-State: AC+VfDwmDCbVNIOQbfUxCxV8PVfGAFqW1T8noUOQK5hHCuV29Ui0AGzG
 4wjwzoQW4MPs+GHFTnqIuOUuljXqhRaZ+dYomH8=
X-Google-Smtp-Source: ACHHUZ44u9rzoEH0c627kkVmgxvuQgw29vCOyGgFwxsqQtccpyWS+4u2aPYyydPSm3CQ8zRWDFwqWg==
X-Received: by 2002:a05:6a20:841a:b0:106:11fa:192c with SMTP id
 c26-20020a056a20841a00b0010611fa192cmr5181130pzd.61.1685505811448; 
 Tue, 30 May 2023 21:03:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/48] tcg: Build once for system, once for user
Date: Tue, 30 May 2023 21:02:42 -0700
Message-Id: <20230531040330.8950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The goal here is only tcg/, leaving accel/tcg/ for future work.

Changes for v3:
  * Prerequisites and 3 patches merged.

r~

Richard Henderson (48):
  tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
  tcg: Widen CPUTLBEntry comparators to 64-bits
  tcg: Add tlb_fast_offset to TCGContext
  *: Add missing includes of qemu/error-report.h
  *: Add missing includes of tcg/debug-assert.h
  *: Add missing includes of tcg/tcg.h
  tcg: Split out tcg-target-reg-bits.h
  target/arm: Fix test of TCG_OVERSIZED_GUEST
  tcg: Split out tcg/oversized-guest.h
  tcg: Move TCGv, dup_const_tl definitions to tcg-op.h
  tcg: Split tcg/tcg-op-common.h from tcg/tcg-op.h
  target/arm: Include helper-gen.h in translator.h
  target/hexagon: Include helper-gen.h where needed
  tcg: Remove outdated comments in helper-head.h
  tcg: Move TCGHelperInfo and dependencies to tcg/helper-info.h
  tcg: Pass TCGHelperInfo to tcg_gen_callN
  tcg: Move temp_idx and tcgv_i32_temp debug out of line
  tcg: Split tcg_gen_callN
  tcg: Split helper-gen.h
  tcg: Split helper-proto.h
  tcg: Add insn_start_words to TCGContext
  tcg: Add guest_mo to TCGContext
  tcg: Move TLB_FLAGS_MASK check out of get_alignment_bits
  tcg: Split tcg/tcg-op-gvec.h
  tcg: Remove NO_CPU_IO_DEFS
  exec-all: Widen tb_page_addr_t for user-only
  exec-all: Widen TranslationBlock pc and cs_base to 64-bits
  tcg: Spit out exec/translation-block.h
  include/exec: Remove CODE_GEN_AVG_BLOCK_SIZE
  accel/tcg: Move most of gen-icount.h into translator.c
  accel/tcg: Introduce translator_io_start
  accel/tcg: Move translator_fake_ldb out of line
  target/arm: Tidy helpers for translation
  target/mips: Tidy helpers for translation
  *: Add missing includes of exec/translation-block.h
  *: Add missing includes of exec/exec-all.h
  accel/tcg: Tidy includes for translator.[ch]
  tcg: Fix PAGE/PROT confusion
  tcg: Move env defines out of NEED_CPU_H in helper-head.h
  tcg: Remove target-specific headers from tcg.[ch]
  plugins: Move plugin_insn_append to translator.c
  plugins: Drop unused headers from exec/plugin-gen.h
  exec/poison: Do not poison CONFIG_SOFTMMU
  tcg: Build once for system and once for user-only

 MAINTAINERS                                   |    1 -
 include/exec/cpu-all.h                        |    3 +
 include/exec/cpu-defs.h                       |   50 +-
 include/exec/cpu_ldst.h                       |   22 +-
 include/exec/exec-all.h                       |  145 +--
 include/exec/gen-icount.h                     |   83 --
 include/exec/helper-gen-common.h              |   17 +
 include/exec/helper-gen.h                     |   96 +-
 include/exec/helper-head.h                    |   24 +-
 include/exec/helper-proto-common.h            |   17 +
 include/exec/helper-proto.h                   |   72 +-
 include/exec/helper-tcg.h                     |   75 --
 include/exec/plugin-gen.h                     |   24 -
 include/exec/poison.h                         |    1 -
 include/exec/tlb-common.h                     |   56 +
 include/exec/translation-block.h              |  152 +++
 include/exec/translator.h                     |   24 +-
 include/qemu/typedefs.h                       |    1 +
 include/tcg/helper-info.h                     |   64 +
 include/tcg/insn-start-words.h                |   17 +
 include/tcg/oversized-guest.h                 |   23 +
 include/tcg/tcg-op-common.h                   |  996 ++++++++++++++++
 include/tcg/tcg-op-gvec-common.h              |  426 +++++++
 include/tcg/tcg-op-gvec.h                     |  444 +------
 include/tcg/tcg-op.h                          | 1033 +----------------
 include/tcg/tcg-opc.h                         |    6 +-
 include/tcg/tcg.h                             |  107 +-
 target/arm/cpregs.h                           |    4 +-
 target/arm/tcg/translate.h                    |    5 +
 target/mips/tcg/translate.h                   |    5 +-
 target/ppc/cpu.h                              |    2 -
 target/sparc/cpu.h                            |    2 -
 tcg/aarch64/tcg-target-reg-bits.h             |   12 +
 tcg/arm/tcg-target-reg-bits.h                 |   12 +
 tcg/i386/tcg-target-reg-bits.h                |   16 +
 tcg/i386/tcg-target.h                         |    2 -
 tcg/loongarch64/tcg-target-reg-bits.h         |   21 +
 tcg/loongarch64/tcg-target.h                  |   11 -
 tcg/mips/tcg-target-reg-bits.h                |   18 +
 tcg/mips/tcg-target.h                         |    8 -
 tcg/ppc/tcg-target-reg-bits.h                 |   16 +
 tcg/ppc/tcg-target.h                          |    5 -
 tcg/riscv/tcg-target-reg-bits.h               |   19 +
 tcg/riscv/tcg-target.h                        |    9 -
 tcg/s390x/tcg-target-reg-bits.h               |   17 +
 tcg/sparc64/tcg-target-reg-bits.h             |   12 +
 tcg/tcg-internal.h                            |   47 +-
 tcg/tci/tcg-target-reg-bits.h                 |   18 +
 tcg/tci/tcg-target.h                          |    8 -
 include/exec/helper-gen.h.inc                 |  101 ++
 include/exec/helper-proto.h.inc               |   67 ++
 accel/tcg/cpu-exec.c                          |    2 +-
 accel/tcg/cputlb.c                            |   12 +-
 accel/tcg/monitor.c                           |    1 +
 accel/tcg/perf.c                              |    8 +-
 accel/tcg/plugin-gen.c                        |    6 +
 accel/tcg/tcg-accel-ops-mttcg.c               |    2 +-
 accel/tcg/tcg-accel-ops-rr.c                  |    2 +-
 accel/tcg/tcg-all.c                           |    1 +
 accel/tcg/tcg-runtime-gvec.c                  |    2 +-
 accel/tcg/tcg-runtime.c                       |    6 +-
 accel/tcg/translate-all.c                     |   23 +-
 accel/tcg/translator.c                        |  140 ++-
 target/alpha/translate.c                      |   18 +-
 target/arm/ptw.c                              |    8 +-
 target/arm/tcg/translate-a64.c                |   42 +-
 target/arm/tcg/translate-m-nocp.c             |    2 -
 target/arm/tcg/translate-mve.c                |    4 -
 target/arm/tcg/translate-neon.c               |    4 -
 target/arm/tcg/translate-sme.c                |    7 -
 target/arm/tcg/translate-sve.c                |   11 -
 target/arm/tcg/translate-vfp.c                |    7 +-
 target/arm/tcg/translate.c                    |   41 +-
 target/avr/cpu.c                              |    1 +
 target/avr/helper.c                           |    1 +
 target/avr/translate.c                        |    6 +-
 target/cris/translate.c                       |    8 +-
 target/hexagon/genptr.c                       |    1 +
 target/hexagon/translate.c                    |    7 +
 target/hppa/translate.c                       |   10 +-
 target/i386/helper.c                          |    3 +
 target/i386/tcg/translate.c                   |   57 +-
 target/loongarch/translate.c                  |    7 +-
 target/m68k/translate.c                       |    5 +-
 target/microblaze/translate.c                 |    6 +-
 target/mips/tcg/msa_translate.c               |    3 -
 target/mips/tcg/mxu_translate.c               |    2 -
 target/mips/tcg/octeon_translate.c            |    4 +-
 target/mips/tcg/rel6_translate.c              |    2 -
 target/mips/tcg/translate.c                   |   53 +-
 target/mips/tcg/translate_addr_const.c        |    1 -
 target/mips/tcg/tx79_translate.c              |    4 +-
 target/mips/tcg/vr54xx_translate.c            |    3 -
 target/nios2/translate.c                      |    6 +-
 target/openrisc/sys_helper.c                  |    1 +
 target/openrisc/translate.c                   |   14 +-
 target/ppc/translate.c                        |   17 +-
 target/riscv/cpu_helper.c                     |    1 +
 target/riscv/translate.c                      |    6 +-
 target/rx/cpu.c                               |    1 +
 target/rx/op_helper.c                         |    1 +
 target/rx/translate.c                         |    7 +-
 target/s390x/tcg/translate.c                  |   10 +-
 target/sh4/translate.c                        |    6 +-
 target/sparc/translate.c                      |   78 +-
 target/tricore/cpu.c                          |    1 +
 target/tricore/translate.c                    |    7 +-
 target/xtensa/translate.c                     |   31 +-
 tcg/optimize.c                                |    2 +-
 tcg/region.c                                  |   20 +-
 tcg/tcg-op-gvec.c                             |    4 +-
 tcg/tcg-op-ldst.c                             |   26 +-
 tcg/tcg-op-vec.c                              |    2 +-
 tcg/tcg-op.c                                  |    4 +-
 tcg/tcg.c                                     |  218 ++--
 tcg/tci.c                                     |    3 +-
 include/exec/helper-info.c.inc                |   95 ++
 target/loongarch/insn_trans/trans_extra.c.inc |    4 +-
 .../insn_trans/trans_privileged.c.inc         |    4 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |   24 +-
 tcg/aarch64/tcg-target.c.inc                  |    8 +-
 tcg/arm/tcg-target.c.inc                      |    8 +-
 tcg/i386/tcg-target.c.inc                     |    9 +-
 tcg/loongarch64/tcg-target.c.inc              |    8 +-
 tcg/mips/tcg-target.c.inc                     |   20 +-
 tcg/ppc/tcg-target.c.inc                      |   46 +-
 tcg/riscv/tcg-target.c.inc                    |   21 +-
 tcg/s390x/tcg-target.c.inc                    |   22 +-
 tcg/sparc64/tcg-target.c.inc                  |   20 +-
 scripts/make-config-poison.sh                 |    5 +-
 target/hexagon/idef-parser/idef-parser.y      |    3 +-
 tcg/meson.build                               |   30 +-
 133 files changed, 3022 insertions(+), 2728 deletions(-)
 delete mode 100644 include/exec/gen-icount.h
 create mode 100644 include/exec/helper-gen-common.h
 create mode 100644 include/exec/helper-proto-common.h
 delete mode 100644 include/exec/helper-tcg.h
 create mode 100644 include/exec/tlb-common.h
 create mode 100644 include/exec/translation-block.h
 create mode 100644 include/tcg/helper-info.h
 create mode 100644 include/tcg/insn-start-words.h
 create mode 100644 include/tcg/oversized-guest.h
 create mode 100644 include/tcg/tcg-op-common.h
 create mode 100644 include/tcg/tcg-op-gvec-common.h
 create mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 create mode 100644 tcg/arm/tcg-target-reg-bits.h
 create mode 100644 tcg/i386/tcg-target-reg-bits.h
 create mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 create mode 100644 tcg/mips/tcg-target-reg-bits.h
 create mode 100644 tcg/ppc/tcg-target-reg-bits.h
 create mode 100644 tcg/riscv/tcg-target-reg-bits.h
 create mode 100644 tcg/s390x/tcg-target-reg-bits.h
 create mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 create mode 100644 tcg/tci/tcg-target-reg-bits.h
 create mode 100644 include/exec/helper-gen.h.inc
 create mode 100644 include/exec/helper-proto.h.inc
 create mode 100644 include/exec/helper-info.c.inc

-- 
2.34.1


