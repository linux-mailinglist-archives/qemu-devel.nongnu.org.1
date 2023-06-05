Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF272311B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcP-0001kh-Nk; Mon, 05 Jun 2023 16:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcN-0001jl-B8
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcK-0003gp-Us
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6563ccf5151so2578049b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996151; x=1688588151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UeZ/6aRQ8fjh/9iGZNyXm51zd6A56Oxs9IFzjqy4j7Y=;
 b=BJxuhMJtD/J8F+/zdxX2AcEdvFJRkHE28nbQSxALmuVTAP5/N65HC4LLGSphFMnkZf
 kyHagk5JsTaY591r9ZcWGj1/UphiujS9fS4MuN3ChTUG8W7bfA+hkoe1X5tjT2VWR/eu
 oXzLfgA2veFwnRWVt1KSXnZ1+Zt7KZaUmovG7g5zIGZSV0xAsGmVr4y8Nbg12wnPbNti
 FcYAnZlyTU4Q/E2t/TKqsQeF+2/SNblBzWCAyd9wa2RfItN0WXBDCBOdlTgExHQxS5QE
 F/8tYQTegP6jJDkWl2qsQBl89ELBIZip3p01LyAyRWcsdtpDdywdIyh1RmMzRLAn1kSh
 +wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996151; x=1688588151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UeZ/6aRQ8fjh/9iGZNyXm51zd6A56Oxs9IFzjqy4j7Y=;
 b=Ah5C5B/LZGIVNrlHKB3qWCMGrtqaJH7O3CM1r117mycuM97NhZ4QV2H2WBUxP3qy3l
 2u/zedVmMX/zNP/tzStYbdlFa6U3c5JE6SlrwFszNtM8900nh/6cgxpYonEKYqS/xK8J
 FRkX0+jbXOFoi+vE+upmZHyrK67UC0zJu9HFVRbPndXxOSKDmOv4tODnFRF2gtTtTyqf
 BKmpyHX+bUZsCB9TwbzzT2hZBK4CnskbWKD4U5pyVnQbdQbsktHYX0itlKmFgCAYGLGN
 oWhLozxHK9VCwiDILpGr/Qyp6fjM4VJIxMQl/k8NvebxLzFj8SE8YQOOglUEV988XRtC
 ENkg==
X-Gm-Message-State: AC+VfDxMEG7iC9jufFBOqu2s59GoPB30GHWrtR6U/xSvt3e3vsArW20R
 qp9+dDteTfWfkM+BWPJOwNAbUnQ0XA2I81z233I=
X-Google-Smtp-Source: ACHHUZ66YsK/iGdk0RHVEildc+3ZL8ILZ0eAb9KasFZe9RuOVB8o5V8jqZJqPhnfdib7MD5DJ2eyOQ==
X-Received: by 2002:a05:6a21:3384:b0:114:f824:655 with SMTP id
 yy4-20020a056a21338400b00114f8240655mr25284pzb.58.1685996151054; 
 Mon, 05 Jun 2023 13:15:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/52] tcg patch queue
Date: Mon,  5 Jun 2023 13:14:56 -0700
Message-Id: <20230605201548.1596865-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The following changes since commit b52daaf2c868f2bab102eb5acbf55b2917f46aea:

  Merge tag 'pull-block-2023-06-05' of https://gitlab.com/hreitz/qemu into staging (2023-06-05 10:27:31 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230605

for you to fetch changes up to a7f6911c127b1dd1b8764e03b0ebcf0a227a15e4:

  tcg/tcg-op-vec: Remove left over _link_error() definitions (2023-06-05 12:20:16 -0700)

----------------------------------------------------------------
Build tcg/ once for system and once for user.
Unmap perf_marker.
Remove left over _link_error() definitions.

----------------------------------------------------------------
Ilya Leoshkevich (1):
      accel/tcg: Unmap perf_marker

Philippe Mathieu-Daudé (2):
      target/ppc: Inline gen_icount_io_start()
      tcg/tcg-op-vec: Remove left over _link_error() definitions

Richard Henderson (49):
      tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg/sparc64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
      tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
      tcg: Widen CPUTLBEntry comparators to 64-bits
      tcg: Add tlb_fast_offset to TCGContext
      target/avr: Add missing includes of qemu/error-report.h
      target/*: Add missing includes of tcg/debug-assert.h
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
      target/sh4: Emit insn_start for each insn in gUSA region
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
      target/*: Add missing includes of exec/translation-block.h
      target/arm: Add missing include of exec/exec-all.h
      accel/tcg: Tidy includes for translator.[ch]
      tcg: Fix PAGE/PROT confusion
      tcg: Move env defines out of NEED_CPU_H in helper-head.h
      tcg: Remove target-specific headers from tcg.[ch]
      plugins: Move plugin_insn_append to translator.c
      plugins: Drop unused headers from exec/plugin-gen.h
      exec/poison: Do not poison CONFIG_SOFTMMU
      tcg: Build once for system and once for user-only

 MAINTAINERS                                        |    3 +-
 include/exec/cpu-all.h                             |    3 +
 include/exec/cpu-defs.h                            |   50 +-
 include/exec/cpu_ldst.h                            |   22 +-
 include/exec/exec-all.h                            |  142 +--
 include/exec/gen-icount.h                          |   83 --
 include/exec/helper-gen-common.h                   |   18 +
 include/exec/helper-gen.h                          |   97 +-
 include/exec/helper-head.h                         |   24 +-
 include/exec/helper-proto-common.h                 |   18 +
 include/exec/helper-proto.h                        |   73 +-
 include/exec/helper-tcg.h                          |   75 --
 include/exec/plugin-gen.h                          |   24 -
 include/exec/poison.h                              |    1 -
 include/exec/tlb-common.h                          |   56 ++
 include/exec/translation-block.h                   |  149 +++
 include/exec/translator.h                          |   24 +-
 include/qemu/typedefs.h                            |    1 +
 include/tcg/helper-info.h                          |   64 ++
 include/tcg/insn-start-words.h                     |   17 +
 include/tcg/oversized-guest.h                      |   23 +
 include/tcg/tcg-op-common.h                        |  996 +++++++++++++++++++
 include/tcg/tcg-op-gvec-common.h                   |  426 ++++++++
 include/tcg/tcg-op-gvec.h                          |  444 +--------
 include/tcg/tcg-op.h                               | 1033 +-------------------
 include/tcg/tcg-opc.h                              |    6 +-
 include/tcg/tcg.h                                  |  107 +-
 target/arm/cpregs.h                                |    4 +-
 target/arm/tcg/translate.h                         |    5 +
 target/mips/tcg/translate.h                        |    5 +-
 target/ppc/cpu.h                                   |    2 -
 target/sparc/cpu.h                                 |    2 -
 tcg/aarch64/tcg-target-reg-bits.h                  |   12 +
 tcg/arm/tcg-target-reg-bits.h                      |   12 +
 tcg/i386/tcg-target-reg-bits.h                     |   16 +
 tcg/i386/tcg-target.h                              |    2 -
 tcg/loongarch64/tcg-target-reg-bits.h              |   21 +
 tcg/loongarch64/tcg-target.h                       |   11 -
 tcg/mips/tcg-target-reg-bits.h                     |   18 +
 tcg/mips/tcg-target.h                              |    8 -
 tcg/ppc/tcg-target-reg-bits.h                      |   16 +
 tcg/ppc/tcg-target.h                               |    5 -
 tcg/riscv/tcg-target-reg-bits.h                    |   19 +
 tcg/riscv/tcg-target.h                             |    9 -
 tcg/s390x/tcg-target-reg-bits.h                    |   17 +
 tcg/sparc64/tcg-target-reg-bits.h                  |   12 +
 tcg/tcg-internal.h                                 |   47 +-
 tcg/tci/tcg-target-reg-bits.h                      |   18 +
 tcg/tci/tcg-target.h                               |    8 -
 include/exec/helper-gen.h.inc                      |  102 ++
 include/exec/helper-proto.h.inc                    |   68 ++
 accel/tcg/cpu-exec.c                               |    2 +-
 accel/tcg/cputlb.c                                 |   12 +-
 accel/tcg/monitor.c                                |    1 +
 accel/tcg/perf.c                                   |   19 +-
 accel/tcg/plugin-gen.c                             |    6 +
 accel/tcg/tcg-accel-ops-mttcg.c                    |    2 +-
 accel/tcg/tcg-accel-ops-rr.c                       |    2 +-
 accel/tcg/tcg-all.c                                |    1 +
 accel/tcg/tcg-runtime-gvec.c                       |    2 +-
 accel/tcg/tcg-runtime.c                            |    6 +-
 accel/tcg/translate-all.c                          |   30 +-
 accel/tcg/translator.c                             |  140 ++-
 target/alpha/translate.c                           |   18 +-
 target/arm/ptw.c                                   |    8 +-
 target/arm/tcg/translate-a64.c                     |   42 +-
 target/arm/tcg/translate-m-nocp.c                  |    2 -
 target/arm/tcg/translate-mve.c                     |    4 -
 target/arm/tcg/translate-neon.c                    |    4 -
 target/arm/tcg/translate-sme.c                     |    7 -
 target/arm/tcg/translate-sve.c                     |   11 -
 target/arm/tcg/translate-vfp.c                     |    7 +-
 target/arm/tcg/translate.c                         |   41 +-
 target/avr/cpu.c                                   |    1 +
 target/avr/helper.c                                |    1 +
 target/avr/translate.c                             |    6 +-
 target/cris/translate.c                            |    8 +-
 target/hexagon/genptr.c                            |    1 +
 target/hexagon/translate.c                         |    7 +
 target/hppa/translate.c                            |   10 +-
 target/i386/helper.c                               |    3 +
 target/i386/tcg/translate.c                        |   57 +-
 target/loongarch/translate.c                       |    7 +-
 target/m68k/translate.c                            |    5 +-
 target/microblaze/translate.c                      |    6 +-
 target/mips/tcg/msa_translate.c                    |    3 -
 target/mips/tcg/mxu_translate.c                    |    2 -
 target/mips/tcg/octeon_translate.c                 |    4 +-
 target/mips/tcg/rel6_translate.c                   |    2 -
 target/mips/tcg/translate.c                        |   53 +-
 target/mips/tcg/translate_addr_const.c             |    1 -
 target/mips/tcg/tx79_translate.c                   |    4 +-
 target/mips/tcg/vr54xx_translate.c                 |    3 -
 target/nios2/translate.c                           |    6 +-
 target/openrisc/sys_helper.c                       |    1 +
 target/openrisc/translate.c                        |   14 +-
 target/ppc/translate.c                             |   78 +-
 target/riscv/cpu_helper.c                          |    1 +
 target/riscv/translate.c                           |    6 +-
 target/rx/cpu.c                                    |    1 +
 target/rx/op_helper.c                              |    1 +
 target/rx/translate.c                              |    7 +-
 target/s390x/tcg/translate.c                       |   10 +-
 target/sh4/translate.c                             |   21 +-
 target/sparc/translate.c                           |   78 +-
 target/tricore/cpu.c                               |    1 +
 target/tricore/translate.c                         |    7 +-
 target/xtensa/translate.c                          |   31 +-
 tcg/optimize.c                                     |    2 +-
 tcg/region.c                                       |   20 +-
 tcg/tcg-op-gvec.c                                  |    4 +-
 tcg/tcg-op-ldst.c                                  |   26 +-
 tcg/tcg-op-vec.c                                   |   13 +-
 tcg/tcg-op.c                                       |    4 +-
 tcg/tcg.c                                          |  218 +++--
 tcg/tci.c                                          |    3 +-
 include/exec/helper-info.c.inc                     |   96 ++
 target/loongarch/insn_trans/trans_extra.c.inc      |    4 +-
 target/loongarch/insn_trans/trans_privileged.c.inc |    4 +-
 target/ppc/power8-pmu-regs.c.inc                   |   10 +-
 target/ppc/translate/branch-impl.c.inc             |    2 +-
 target/riscv/insn_trans/trans_privileged.c.inc     |    8 +-
 target/riscv/insn_trans/trans_rvi.c.inc            |   24 +-
 tcg/aarch64/tcg-target.c.inc                       |    8 +-
 tcg/arm/tcg-target.c.inc                           |    8 +-
 tcg/i386/tcg-target.c.inc                          |    9 +-
 tcg/loongarch64/tcg-target.c.inc                   |    8 +-
 tcg/mips/tcg-target.c.inc                          |   20 +-
 tcg/ppc/tcg-target.c.inc                           |   46 +-
 tcg/riscv/tcg-target.c.inc                         |   21 +-
 tcg/s390x/tcg-target.c.inc                         |   22 +-
 tcg/sparc64/tcg-target.c.inc                       |   20 +-
 scripts/make-config-poison.sh                      |    5 +-
 target/hexagon/idef-parser/idef-parser.y           |    3 +-
 tcg/meson.build                                    |   30 +-
 135 files changed, 3088 insertions(+), 2782 deletions(-)
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

