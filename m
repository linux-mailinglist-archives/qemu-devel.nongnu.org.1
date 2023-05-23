Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D470DE05
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSB-0003rm-Kw; Tue, 23 May 2023 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS7-0003Ny-SF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS5-0002zf-Jb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso3750413b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850004; x=1687442004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IEzlE9S+3gmeN8TX8QJBonFN4H3qFYzTQcChdKbGh7Y=;
 b=j5bSO7/R423UWA2PmmLtyjt6DmvjME9qJSVk3yebeHhoByCvBR2m1VgbxfOUAn7e9r
 TveGDtKZNFvl7TPM0eyxb24hhexKgp0k0CmjXQMxBK0724CxogW/QG3Or2Yxr1pyL8+m
 7MZh9FjQokLIv9Dn2Ck71fzpg2154ipzsfWXvja1bD7D8Rvypxi1n5CbcWyUnvr8ThYn
 pYvym6rnw8y85QyCEBm7UtcMYIINqLGFa8ifX9P/nViwoyC5FRUAeTpaCCfbvYSJToHj
 DGlE/BU4AqAOJy5d0aTtohSlxZQorZ9GpJcS24TYuTg4h3jBpX6qZmCyf+Z9u/W5uPtM
 V6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850004; x=1687442004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEzlE9S+3gmeN8TX8QJBonFN4H3qFYzTQcChdKbGh7Y=;
 b=HVzo73xb0mxoJ/hi0JLraUbsW2brm/jhsmjQr3nj1Kk/LxErtcGSVmpw7qAlaCESny
 bunyQTH4Lud1QniaAf1iXEscVLaWEzdAYzwPbnF08/vJzU5iq2TmqAz5Arj0dO/jYtMC
 DypY3chkgxSicOtV30mriYg37KAjUfgpCfGqfm5uJklURY6Ums3xuzcldNXRzyvGmWRX
 sAGykCLRXFfao4kVklRpGNT7gkOK/E2NNDRxYBZ4B2jzQEIAUAhvrP1t0ywg+eL9zzsR
 nYYRWlQGV8EbqF/n/37c8C0HRKz3jeIAB8tx+iOLlkYY1xV0sN9vVoSZjA64qMJrgeqO
 hg7Q==
X-Gm-Message-State: AC+VfDx8D48ycEhm97GCv4f+MPYsIAbIBoRByL2pM9A1U10BevHgglQ8
 u0a2/UxR2YehimN4LviPHBrHtnjfrulwQK9JPa0=
X-Google-Smtp-Source: ACHHUZ5MkcileGUHYAVjzAmDYAXidU4pn+50MLf4RW1KkH9mkTgC6OmZotPEgPptTZ5jo2VLpOa64A==
X-Received: by 2002:a05:6a00:15c7:b0:626:2ce1:263c with SMTP id
 o7-20020a056a0015c700b006262ce1263cmr17847266pfu.5.1684850004044; 
 Tue, 23 May 2023 06:53:24 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/52] tcg: Build once for system, once for user
Date: Tue, 23 May 2023 06:52:30 -0700
Message-Id: <20230523135322.678948-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Changes for v2:
  * 30 patches merged.

r~

Based-on: 20230523134733.678646-1-richard.henderson@linaro.org
("[PATCH v2 00/27] accel/tcg: Improvements to atomic128.h")

Richard Henderson (52):
  tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
  tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
  tcg: Widen CPUTLBEntry comparators to 64-bits
  tcg: Add tlb_fast_offset to TCGContext
  tcg: Remove TCG_TARGET_TLB_DISPLACEMENT_BITS
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
  tcg: Remove DEBUG_DISAS
  tcg: Remove USE_TCG_OPTIMIZATIONS
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
  tcg: Define IN_TCG
  tcg: Fix PAGE/PROT confusion
  tcg: Move env defines out of NEED_CPU_H in helper-head.h
  tcg: Remove target-specific headers from tcg.[ch]
  plugins: Move plugin_insn_append to translator.c
  plugins: Drop unused headers from exec/plugin-gen.h
  exec/poison: Do not poison CONFIG_SOFTMMU
  tcg: Build once for system and once for user-only

 include/exec/cpu-all.h                        |    3 +
 include/exec/cpu-defs.h                       |   50 +-
 include/exec/cpu_ldst.h                       |   22 +-
 include/exec/exec-all.h                       |  148 +--
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
 tcg/aarch64/tcg-target.h                      |    1 -
 tcg/arm/tcg-target-reg-bits.h                 |   12 +
 tcg/arm/tcg-target.h                          |    1 -
 tcg/i386/tcg-target-reg-bits.h                |   16 +
 tcg/i386/tcg-target.h                         |    3 -
 tcg/loongarch64/tcg-target-reg-bits.h         |   21 +
 tcg/loongarch64/tcg-target.h                  |   11 -
 tcg/mips/tcg-target-reg-bits.h                |   18 +
 tcg/mips/tcg-target.h                         |    9 -
 tcg/ppc/tcg-target-reg-bits.h                 |   16 +
 tcg/ppc/tcg-target.h                          |    6 -
 tcg/riscv/tcg-target-reg-bits.h               |   19 +
 tcg/riscv/tcg-target.h                        |   10 -
 tcg/s390x/tcg-target-reg-bits.h               |   17 +
 tcg/s390x/tcg-target.h                        |    1 -
 tcg/sparc64/tcg-target-reg-bits.h             |   12 +
 tcg/sparc64/tcg-target.h                      |    1 -
 tcg/tcg-internal.h                            |   47 +-
 tcg/tci/tcg-target-reg-bits.h                 |   18 +
 tcg/tci/tcg-target.h                          |    9 -
 accel/tcg/cpu-exec.c                          |    4 +-
 accel/tcg/cputlb.c                            |   12 +-
 accel/tcg/monitor.c                           |    1 +
 accel/tcg/perf.c                              |    8 +-
 accel/tcg/plugin-gen.c                        |    6 +
 accel/tcg/tcg-accel-ops-mttcg.c               |    2 +-
 accel/tcg/tcg-accel-ops-rr.c                  |    2 +-
 accel/tcg/tcg-all.c                           |    1 +
 accel/tcg/tcg-runtime-gvec.c                  |    2 +-
 accel/tcg/tcg-runtime.c                       |    6 +-
 accel/tcg/translate-all.c                     |   25 +-
 accel/tcg/translator.c                        |  142 ++-
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
 target/sh4/translate.c                        |    8 +-
 target/sparc/translate.c                      |   80 +-
 target/tricore/cpu.c                          |    1 +
 target/tricore/translate.c                    |    7 +-
 target/xtensa/translate.c                     |   31 +-
 tcg/optimize.c                                |    2 +-
 tcg/region.c                                  |   22 +-
 tcg/tcg-common.c                              |    2 +
 tcg/tcg-op-gvec.c                             |    6 +-
 tcg/tcg-op-ldst.c                             |   28 +-
 tcg/tcg-op-vec.c                              |    4 +-
 tcg/tcg-op.c                                  |    6 +-
 tcg/tcg.c                                     |  232 ++--
 tcg/tci.c                                     |    3 +-
 MAINTAINERS                                   |    1 -
 include/exec/helper-gen.h.inc                 |  101 ++
 include/exec/helper-info.c.inc                |   95 ++
 include/exec/helper-proto.h.inc               |   67 ++
 scripts/make-config-poison.sh                 |    5 +-
 target/hexagon/idef-parser/idef-parser.y      |    3 +-
 target/loongarch/insn_trans/trans_extra.c.inc |    4 +-
 .../insn_trans/trans_privileged.c.inc         |    4 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |   24 +-
 tcg/aarch64/tcg-target.c.inc                  |    8 +-
 tcg/arm/tcg-target.c.inc                      |    8 +-
 tcg/i386/tcg-target.c.inc                     |    9 +-
 tcg/loongarch64/tcg-target.c.inc              |    8 +-
 tcg/meson.build                               |   30 +-
 tcg/mips/tcg-target.c.inc                     |   20 +-
 tcg/ppc/tcg-target.c.inc                      |   46 +-
 tcg/riscv/tcg-target.c.inc                    |   19 +-
 tcg/s390x/tcg-target.c.inc                    |   22 +-
 tcg/sparc64/tcg-target.c.inc                  |   20 +-
 138 files changed, 3035 insertions(+), 2761 deletions(-)
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
 create mode 100644 include/exec/helper-info.c.inc
 create mode 100644 include/exec/helper-proto.h.inc

-- 
2.34.1


