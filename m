Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90995720C25
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DjS-0002uB-LS; Fri, 02 Jun 2023 18:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DjQ-0002t6-LE
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DjA-00009l-QQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so25891455e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685746708; x=1688338708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Np7DZWKxOYrIs1zMhgxGpYXx8svkATDXZxC0/tY4f8c=;
 b=lRj+earxnRQAk0P6OVTMR1o1S2jl+zcjYt6QTbKXJ60ECdUtuL5IXDYVtTFYnirrBJ
 zYNYyqn1qGUUPnaA8RjVrzkccV0LO2lJ058Rw2x+KWVsu6OS6xmmC5X6DisKa8fF5cuC
 Qo9wzjVcTD6wc8wV7zQjdNmgjMtdJeD6dylZ8WBLl2yQzixvwyj2XxImBVoR3RkRZJxB
 aYQsAoMZQDeO9h0DgBOz4B7MI+3CnBe9cP1i5ApGMNWyKIjCCPrNVHqPGvaETe+R1xIc
 nyTrDnqiLSKMCuUtMuV/ASVJEf7e/G9BUZOoQWtjiDV3xHyw8JwMiaCvSOvHS8eRCWki
 feZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685746708; x=1688338708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Np7DZWKxOYrIs1zMhgxGpYXx8svkATDXZxC0/tY4f8c=;
 b=l68G9Z5VUOUz6D6NPQgKdJrFoYUJUvNq5yTDcc8fvoXzZ4vOUvHwHhF2GSg1oQmWGX
 lhSFNHr4sBET7fQMOG0QJ+0aFv5JxA99X0fvPRaYu2LbB5pgUK3P9By+3TTGSXOeDiQk
 WPkDK+XDfy7Dz3Opy13YRwEu6Jf10V681FepxKzgzG6KsD/DSwPqhRLLhrexlZyJ/jjm
 auodXpT01A5F1kIiU9S5metchnEczjDf+u2Ai7yUUtFJ1BmHo2u5o3bgcctO/zPuUGUs
 7vQ71ToEj7dTnfWI54gW0hz0o4CA9HAeEK/5Iwd6dE2Nm3X2Oyd3CN96pUuuRmps94Bx
 CX8Q==
X-Gm-Message-State: AC+VfDyfN743djUn32xOKZ2QC4Is1FWSE3wl8r3L5MRAyWwKwgV+rwNS
 Xn4ora9u36TOhNS/+AoHdyCVopKJdxiz/4xoL/A=
X-Google-Smtp-Source: ACHHUZ6Tmbt19hTOdeM66bt21li8nyoA3YBDKCUQ1qKn6EaU/xL1UkKUkyJh6GKxAbxCa25Wap8mdQ==
X-Received: by 2002:a1c:7512:0:b0:3f6:af2:8471 with SMTP id
 o18-20020a1c7512000000b003f60af28471mr2686589wmc.26.1685746707237; 
 Fri, 02 Jun 2023 15:58:27 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a1c6a0a000000b003f728d84323sm2075220wmc.28.2023.06.02.15.58.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:58:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] bulk: Replace !CONFIG_USER_ONLY -> CONFIG_SOFTMMU
Date: Sat,  3 Jun 2023 00:58:11 +0200
Message-Id: <20230602225811.60152-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230602225811.60152-1-philmd@linaro.org>
References: <20230602225811.60152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

CONFIG_SOFTMMU is the opposite of CONFIG_USER_ONLY.
Now that CONFIG_SOFTMMU isn't poisoined anymore,
replace !CONFIG_USER_ONLY negation by the positive
form which is clearer when reviewing code.

Change mostly done mechanically using:

  $ sed -i -e 's/ifndef CONFIG_USER_ONLY/ifdef CONFIG_SOFTMMU/' \
           -e 's/!defined(CONFIG_USER_ONLY)/defined(CONFIG_SOFTMMU)/' \
               $(git grep -l CONFIG_USER_ONLY)

and adapting comments manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/coccinelle/round.cocci                |   6 +
 include/exec/address-spaces.h                 |   2 +-
 include/exec/confidential-guest-support.h     |   4 +-
 include/exec/cpu-all.h                        |   4 +-
 include/exec/cpu-common.h                     |   4 +-
 include/exec/cpu-defs.h                       |  14 +-
 include/exec/cputlb.h                         |   2 +-
 include/exec/exec-all.h                       |   6 +-
 include/exec/ioport.h                         |   2 +-
 include/exec/memory-internal.h                |   2 +-
 include/exec/memory.h                         |   2 +-
 include/exec/ram_addr.h                       |   2 +-
 include/exec/ramblock.h                       |   2 +-
 include/hw/core/cpu.h                         |  12 +-
 include/hw/core/tcg-cpu-ops.h                 |   8 +-
 include/hw/intc/armv7m_nvic.h                 |   4 +-
 include/hw/s390x/css.h                        |   2 +-
 include/qemu/accel.h                          |   6 +-
 include/semihosting/semihost.h                |   4 +-
 include/sysemu/cpus.h                         |   2 +-
 include/sysemu/xen.h                          |   4 +-
 target/alpha/cpu.h                            |   6 +-
 target/arm/common-semi-target.h               |   2 +-
 target/arm/cpu.h                              |  14 +-
 target/arm/internals.h                        |   6 +-
 target/arm/tcg/arm_ldst.h                     |   2 +-
 target/arm/tcg/translate.h                    |   2 +-
 target/cris/cpu.h                             |   2 +-
 target/hppa/cpu.h                             |   2 +-
 target/hppa/helper.h                          |   2 +-
 target/i386/cpu-internal.h                    |   4 +-
 target/i386/cpu.h                             |  12 +-
 target/i386/helper.h                          |  12 +-
 target/i386/sev.h                             |   2 +-
 target/i386/tcg/helper-tcg.h                  |   4 +-
 target/loongarch/cpu.h                        |   4 +-
 target/loongarch/helper.h                     |   2 +-
 target/loongarch/internals.h                  |   4 +-
 target/m68k/cpu.h                             |   6 +-
 target/microblaze/cpu.h                       |  12 +-
 target/microblaze/helper.h                    |   2 +-
 target/mips/cpu.h                             |   6 +-
 target/mips/helper.h                          |   8 +-
 target/mips/internal.h                        |   4 +-
 target/mips/tcg/tcg-internal.h                |   4 +-
 target/nios2/cpu.h                            |  10 +-
 target/nios2/helper.h                         |   2 +-
 target/openrisc/cpu.h                         |   8 +-
 target/ppc/cpu-qom.h                          |   4 +-
 target/ppc/cpu.h                              |  32 ++---
 target/ppc/helper.h                           |   8 +-
 target/ppc/internal.h                         |   6 +-
 target/ppc/kvm_ppc.h                          |   8 +-
 target/ppc/mmu-book3s-v3.h                    |   2 +-
 target/ppc/mmu-hash32.h                       |   2 +-
 target/ppc/mmu-hash64.h                       |   2 +-
 target/ppc/mmu-radix64.h                      |   2 +-
 target/ppc/power8-pmu.h                       |   2 +-
 target/ppc/spr_common.h                       |   2 +-
 target/riscv/cpu.h                            |  10 +-
 target/riscv/helper.h                         |   4 +-
 target/riscv/internals.h                      |   2 +-
 target/rx/cpu.h                               |   4 +-
 target/s390x/cpu.h                            |   8 +-
 target/s390x/helper.h                         |   2 +-
 target/s390x/s390x-internal.h                 |   8 +-
 target/sh4/cpu.h                              |   2 +-
 target/sparc/cpu.h                            |  10 +-
 target/sparc/helper.h                         |   2 +-
 target/xtensa/cpu.h                           |   6 +-
 target/xtensa/helper.h                        |   4 +-
 target/s390x/tcg/insn-data.h.inc              |   2 +-
 accel/accel-common.c                          |   8 +-
 accel/tcg/cpu-exec.c                          |  20 +--
 accel/tcg/tcg-all.c                           |   4 +-
 accel/tcg/translate-all.c                     |   2 +-
 cpu.c                                         |   8 +-
 gdbstub/gdbstub.c                             |   8 +-
 plugins/api.c                                 |   4 +-
 plugins/loader.c                              |   4 +-
 semihosting/arm-compat-semi.c                 |  10 +-
 semihosting/guestfd.c                         |   2 +-
 semihosting/syscalls.c                        |   6 +-
 softmmu/memory.c                              |   2 +-
 target/alpha/cpu.c                            |  10 +-
 target/alpha/helper.c                         |   4 +-
 target/alpha/sys_helper.c                     |   4 +-
 target/alpha/translate.c                      |  22 ++--
 target/arm/cpu.c                              |  44 +++----
 target/arm/debug_helper.c                     |   4 +-
 target/arm/gdbstub.c                          |   6 +-
 target/arm/helper.c                           |  48 +++----
 target/arm/tcg/cpu32.c                        |  18 +--
 target/arm/tcg/helper-a64.c                   |   2 +-
 target/arm/tcg/m_helper.c                     |   6 +-
 target/arm/tcg/op_helper.c                    |   2 +-
 target/arm/tcg/sve_helper.c                   |   2 +-
 target/arm/tcg/tlb_helper.c                   |   4 +-
 target/arm/tcg/translate-a64.c                |   2 +-
 target/arm/tcg/translate.c                    |   6 +-
 target/cris/cpu.c                             |  18 +--
 target/cris/op_helper.c                       |   8 +-
 target/cris/translate.c                       |   2 +-
 target/hexagon/genptr.c                       |   2 +-
 target/hppa/cpu.c                             |  14 +-
 target/hppa/helper.c                          |   4 +-
 target/hppa/translate.c                       |  36 ++---
 target/i386/cpu-dump.c                        |   6 +-
 target/i386/cpu.c                             |  42 +++---
 target/i386/gdbstub.c                         |  14 +-
 target/i386/helper.c                          |   8 +-
 target/i386/tcg/bpt_helper.c                  |   2 +-
 target/i386/tcg/excp_helper.c                 |   2 +-
 target/i386/tcg/fpu_helper.c                  |   4 +-
 target/i386/tcg/seg_helper.c                  |   8 +-
 target/i386/tcg/tcg-cpu.c                     |   6 +-
 target/i386/tcg/translate.c                   |   4 +-
 target/loongarch/cpu.c                        |  14 +-
 target/loongarch/op_helper.c                  |   2 +-
 target/m68k/cpu.c                             |   6 +-
 target/m68k/helper.c                          |   4 +-
 target/m68k/op_helper.c                       |   4 +-
 target/microblaze/cpu.c                       |  12 +-
 target/microblaze/helper.c                    |   4 +-
 target/microblaze/op_helper.c                 |   2 +-
 target/microblaze/translate.c                 |  12 +-
 target/mips/cpu.c                             |  18 +--
 target/mips/gdbstub.c                         |   4 +-
 target/mips/tcg/ldst_helper.c                 |   4 +-
 target/mips/tcg/msa_helper.c                  |   2 +-
 target/mips/tcg/op_helper.c                   |   4 +-
 target/mips/tcg/translate.c                   |  26 ++--
 target/nios2/cpu.c                            |  18 +--
 target/nios2/op_helper.c                      |   4 +-
 target/nios2/translate.c                      |  10 +-
 target/openrisc/cpu.c                         |  14 +-
 target/openrisc/interrupt.c                   |   2 +-
 target/openrisc/sys_helper.c                  |  10 +-
 target/ppc/compat.c                           |   2 +-
 target/ppc/cpu.c                              |   2 +-
 target/ppc/cpu_init.c                         | 124 +++++++++---------
 target/ppc/excp_helper.c                      |  17 +--
 target/ppc/gdbstub.c                          |   8 +-
 target/ppc/helper_regs.c                      |  20 +--
 target/ppc/mem_helper.c                       |   2 +-
 target/ppc/misc_helper.c                      |   2 +-
 target/ppc/power8-pmu.c                       |   4 +-
 target/ppc/ppc-qmp-cmds.c                     |   2 +-
 target/ppc/timebase_helper.c                  |   4 +-
 target/ppc/translate.c                        |  62 ++++-----
 target/riscv/cpu.c                            |  66 +++++-----
 target/riscv/cpu_helper.c                     |  20 +--
 target/riscv/csr.c                            |  42 +++---
 target/riscv/gdbstub.c                        |   6 +-
 target/riscv/op_helper.c                      |   8 +-
 target/riscv/translate.c                      |  12 +-
 target/riscv/zce_helper.c                     |   2 +-
 target/rx/cpu.c                               |  10 +-
 target/rx/helper.c                            |   4 +-
 target/s390x/cpu-dump.c                       |   2 +-
 target/s390x/cpu.c                            |  26 ++--
 target/s390x/cpu_features.c                   |   4 +-
 target/s390x/cpu_models.c                     |   8 +-
 target/s390x/gdbstub.c                        |   4 +-
 target/s390x/interrupt.c                      |   6 +-
 target/s390x/tcg/cc_helper.c                  |   2 +-
 target/s390x/tcg/excp_helper.c                |  10 +-
 target/s390x/tcg/mem_helper.c                 |   8 +-
 target/s390x/tcg/misc_helper.c                |  12 +-
 target/s390x/tcg/translate.c                  |  48 +++----
 target/sh4/cpu.c                              |  12 +-
 target/sh4/helper.c                           |   6 +-
 target/sh4/op_helper.c                        |   2 +-
 target/sparc/cpu.c                            |  16 +--
 target/sparc/helper.c                         |   6 +-
 target/sparc/int32_helper.c                   |   4 +-
 target/sparc/int64_helper.c                   |   4 +-
 target/sparc/ldst_helper.c                    |  16 +--
 target/sparc/translate.c                      |  50 +++----
 target/sparc/win_helper.c                     |  10 +-
 target/xtensa/cpu.c                           |  22 ++--
 target/xtensa/exc_helper.c                    |   4 +-
 target/xtensa/helper.c                        |   4 +-
 target/xtensa/op_helper.c                     |   6 +-
 target/xtensa/translate.c                     |  62 ++++-----
 tcg/tcg.c                                     |   4 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   2 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   |   2 +-
 target/mips/cpu-defs.c.inc                    |   2 +-
 target/mips/tcg/micromips_translate.c.inc     |   4 +-
 target/mips/tcg/nanomips_translate.c.inc      |   6 +-
 target/ppc/power8-pmu-regs.c.inc              |   4 +-
 target/ppc/translate/branch-impl.c.inc        |   2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |   8 +-
 target/ppc/translate/storage-ctrl-impl.c.inc  |  16 +--
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   4 +-
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/insn_trans/trans_xthead.c.inc    |   8 +-
 tcg/sparc64/tcg-target.c.inc                  |   4 +-
 200 files changed, 923 insertions(+), 920 deletions(-)

diff --git a/scripts/coccinelle/round.cocci b/scripts/coccinelle/round.cocci
index ed06773289..0a27b6da4d 100644
--- a/scripts/coccinelle/round.cocci
+++ b/scripts/coccinelle/round.cocci
@@ -17,3 +17,9 @@ expression e2;
 @@
 -(DIV_ROUND_UP(e1,e2))
 +DIV_ROUND_UP(e1,e2)
+
+@@
+expression n, d;
+@@
+-   n & ~(d - 1)
++   ROUND_DOWN(n, d)
diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9a92..837e6a5560 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -21,7 +21,7 @@
 
 #include "exec/memory.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* Get the root memory region.  This interface should only be used temporarily
  * until a proper bus interface is available.
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index ba2dd4b5df..16a963654e 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -18,7 +18,7 @@
 #ifndef QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #include "qom/object.h"
 
@@ -57,6 +57,6 @@ typedef struct ConfidentialGuestSupportClass {
     ObjectClass parent;
 } ConfidentialGuestSupportClass;
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 09bf4c0cc6..4e5acfcaff 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -304,7 +304,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            0
 #define TLB_WATCHPOINT      0
 
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 
 /*
  * Flags stored in the low bits of the TLB virtual address.
@@ -367,7 +367,7 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
 void dump_exec_info(GString *buf);
 #endif /* CONFIG_TCG */
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e5a55ede5f..807b673f21 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -3,7 +3,7 @@
 
 /* CPU interfaces that are target independent.  */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "exec/hwaddr.h"
 #endif
 
@@ -44,7 +44,7 @@ void tcg_flush_jmp_cache(CPUState *cs);
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 enum device_endian {
     DEVICE_NATIVE_ENDIAN,
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0d418a0384..402e74df6e 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,7 +25,7 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/thread.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "exec/hwaddr.h"
 #endif
 #include "exec/memattrs.h"
@@ -60,7 +60,7 @@
  */
 #define NB_MMU_MODES 16
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "exec/tlb-common.h"
 
 /* use a fully associative victim tlb of 8 entries */
@@ -89,9 +89,9 @@
 #  endif
 # endif
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /*
  * The full TLB entry, which is not accessed by generated TCG code,
  * so the layout is not as critical as that of CPUTLBEntry. This is
@@ -133,9 +133,9 @@ typedef struct CPUTLBEntryFull {
     TARGET_PAGE_ENTRY_EXTRA
 #endif
 } CPUTLBEntryFull;
-#endif  /* !CONFIG_USER_ONLY */
+#endif  /* CONFIG_SOFTMMU */
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
@@ -201,7 +201,7 @@ typedef struct CPUTLB {
 
 typedef struct CPUTLB { } CPUTLB;
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif  /* CONFIG_SOFTMMU && CONFIG_TCG */
 
 /*
  * This structure must be placed in ArchCPU immediately
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 19b16e58f8..fa932cbd41 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -22,7 +22,7 @@
 
 #include "exec/cpu-common.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 698943d58f..c90c685a44 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -74,7 +74,7 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
     return (int32_t)qatomic_read(&cpu_neg(cpu)->icount_decr.u32) < 0;
 }
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
  * tlb_init - initialize a CPU's TLB
@@ -452,7 +452,7 @@ int probe_access_flags(CPUArchState *env, target_ulong addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /**
  * probe_access_full:
  * Like probe_access_flags, except also return into @pfull.
@@ -553,7 +553,7 @@ extern __thread uintptr_t tci_tb_ptr;
    smaller than 4 bytes, so we don't worry about special-casing this.  */
 #define GETPC_ADJ   2
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 /**
  * iotlb_to_section:
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index e34f668998..2c17ca3eef 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -40,7 +40,7 @@ typedef struct MemoryRegionPortio {
 
 #define PORTIO_END_OF_LIST() { }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const MemoryRegionOps unassigned_io_ops;
 #endif
 
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac..5c07a4748b 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -22,7 +22,7 @@
 
 #include "cpu.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c3661b2276..8e55e50b84 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -14,7 +14,7 @@
 #ifndef MEMORY_H
 #define MEMORY_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90a8269290..df19f1d6b7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -19,7 +19,7 @@
 #ifndef RAM_ADDR_H
 #define RAM_ADDR_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "cpu.h"
 #include "sysemu/xen.h"
 #include "sysemu/tcg.h"
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 69c6a53902..ba66c13758 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -19,7 +19,7 @@
 #ifndef QEMU_EXEC_RAMBLOCK_H
 #define QEMU_EXEC_RAMBLOCK_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 39150cf8f8..780477aba3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -491,7 +491,7 @@ bool cpu_paging_enabled(const CPUState *cpu);
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 /**
  * cpu_write_elf64_note:
@@ -542,7 +542,7 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /**
  * CPUDumpFlags:
@@ -565,7 +565,7 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /**
  * cpu_get_phys_page_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
@@ -612,7 +612,7 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /**
  * cpu_list_add:
@@ -974,14 +974,14 @@ static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
 static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
 {
 }
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 /**
  * cpu_get_address_space:
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 0ae08df47e..38a684ed85 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -121,7 +121,7 @@ struct TCGCPUOps {
      */
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
-#else
+#else /* !CONFIG_SOFTMMU = CONFIG_USER_ONLY */
     /**
      * record_sigsegv:
      * @cpu: cpu context
@@ -170,7 +170,7 @@ struct TCGCPUOps {
      */
     void (*record_sigbus)(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra);
-#endif /* CONFIG_SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 #endif /* NEED_CPU_H */
 
 };
@@ -188,7 +188,7 @@ static inline int cpu_watchpoint_address_matches(CPUState *cpu,
     return 0;
 }
 
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 
 /**
  * cpu_check_watchpoint:
@@ -216,6 +216,6 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
  */
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #endif /* TCG_CPU_OPS_H */
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 1ca262fbf8..9eb0f7297a 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -189,7 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
  * @secure: the security state to test
  * This corresponds to the pseudocode IsReqExecPriNeg().
  */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
 #else
 static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
@@ -197,7 +197,7 @@ static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
     return false;
 }
 #endif
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 bool armv7m_nvic_can_take_pending_exception(NVICState *s);
 #else
 static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 75e5381613..acfc9c7c2e 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -238,7 +238,7 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index e84db2e3e5..d1102a9304 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -38,7 +38,7 @@ typedef struct AccelClass {
 
     const char *name;
     int (*init_machine)(MachineState *ms);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
@@ -76,12 +76,12 @@ const char *current_accel_name(void);
 
 void accel_init_interfaces(AccelClass *ac);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 int accel_init_machine(AccelState *accel, MachineState *ms);
 
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /**
  * accel_cpu_instance_init:
diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index efd2efa25a..4cc1fd90e6 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -51,7 +51,7 @@ static inline const char *semihosting_get_cmdline(void)
 {
     return NULL;
 }
-#else /* !CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 /**
  * semihosting_enabled:
  * @is_user: true if guest code is in usermode (i.e. not privileged)
@@ -69,7 +69,7 @@ void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
-#endif /* CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 void qemu_semihosting_guestfd_init(void);
 
 #endif /* SEMIHOST_H */
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 0535a4c68a..e2eced8caf 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -50,7 +50,7 @@ void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
 void cpu_synchronize_all_pre_loadvm(void);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* vl.c */
 /* *-user doesn't have configurable SMP topology */
 extern int smp_cores;
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 0ca25697e4..c1fdc64b9c 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -24,7 +24,7 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
@@ -33,7 +33,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 5e67304d81..1a2d0076aa 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -230,7 +230,7 @@ typedef struct CPUArchState {
     uint64_t trap_arg1;
     uint64_t trap_arg2;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* The internal data required by our emulation of the Unix PALcode.  */
     uint64_t exc_addr;
     uint64_t palbr;
@@ -271,13 +271,13 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 629d75ca5a..ea84e2f35d 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -10,7 +10,7 @@
 #ifndef TARGET_ARM_COMMON_SEMI_TARGET_H
 #define TARGET_ARM_COMMON_SEMI_TARGET_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/arm/boot.h"
 #endif
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d469a2637b..b5f2eff98e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -769,7 +769,7 @@ typedef struct CPUArchState {
         uint32_t ctrl;
     } sau;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     NVICState *nvic;
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
@@ -1101,7 +1101,7 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_arm_cpu;
 
 void arm_cpu_do_interrupt(CPUState *cpu);
@@ -1109,7 +1109,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
@@ -1588,7 +1588,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
     if (mask & XPSR_GE) {
         env->GE = (val & XPSR_GE) >> 16;
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (mask & XPSR_T) {
         env->thumb = ((val & XPSR_T) != 0);
     }
@@ -2383,7 +2383,7 @@ static inline int arm_feature(CPUARMState *env, int feature)
 
 void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /*
  * Return true if exception levels below EL3 are in secure state,
  * or would be following an exception return to that level.
@@ -2874,7 +2874,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
          * let linux-user ignore the fact that it conflicts with SCTLR_B.
          * This lets people run BE32 binaries with "-cpu any".
          */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         !arm_feature(env, ARM_FEATURE_V7) &&
 #endif
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
@@ -3132,7 +3132,7 @@ enum {
     QEMU_PSCI_CONDUIT_HVC = 2,
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c869d18c38..640e6c7a57 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -617,7 +617,7 @@ G_NORETURN void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                             MMUAccessType access_type,
                                             int mmu_idx, uintptr_t retaddr);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
  * exception
@@ -1127,7 +1127,7 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
     return sctlr != 0;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
 typedef struct V8M_SAttributes {
@@ -1214,7 +1214,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
 void arm_log_exception(CPUState *cs);
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /*
  * The log2 of the words in the tag block, for GMID_EL1.BS.
diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index cee0548a1c..f0b44bbd25 100644
--- a/target/arm/tcg/arm_ldst.h
+++ b/target/arm/tcg/arm_ldst.h
@@ -34,7 +34,7 @@ static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
 static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
                                      target_ulong addr, bool sctlr_b)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
        within each word.  Undo that now.  */
     if (sctlr_b) {
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 4d88197715..83a2f8eddd 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -59,7 +59,7 @@ typedef struct DisasContext {
     bool eci_handled;
     int sctlr_b;
     MemOp be_data;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     int user;
 #endif
     ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 71fa1f96e0..d354b13706 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,7 +183,7 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_cris_cpu;
 
 void cris_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index b595ef25a9..6c1e8d87c1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -325,7 +325,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index c7e35ce8c7..e214aeffe7 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -79,7 +79,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tr)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_1(halt, noreturn, env)
 DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(getshadowregs, void, env)
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9baac5c0b4..dbaddeb6fa 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -57,7 +57,7 @@ extern FeatureWordInfo feature_word_info[];
 
 void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs);
 void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                 const char *name, void *opaque, Error **errp);
@@ -65,6 +65,6 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd047e0410..55af087b53 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2029,7 +2029,7 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_x86_cpu;
 #endif
 
@@ -2055,7 +2055,7 @@ int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
@@ -2194,7 +2194,7 @@ void host_cpuid(uint32_t function, uint32_t count,
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
     return !!attrs.secure;
@@ -2271,7 +2271,7 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "exec/cpu-all.h"
 #include "svm.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/i386/apic.h"
 #endif
 
@@ -2416,7 +2416,7 @@ typedef int X86CPUVersion;
  */
 void x86_cpu_set_default_version(X86CPUVersion version);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 void do_cpu_sipi(X86CPU *cpu);
 
@@ -2426,7 +2426,7 @@ void do_cpu_sipi(X86CPU *cpu);
 /* cpu-dump.c */
 void x86_cpu_dump_local_apic_state(CPUState *cs, int flags);
 
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 /* cpu.c */
 bool cpu_is_bsp(X86CPU *cpu);
diff --git a/target/i386/helper.h b/target/i386/helper.h
index e627a93107..5d7b12ccd4 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -44,10 +44,10 @@ DEF_HELPER_3(iret_protected, void, env, int, int)
 DEF_HELPER_3(lret_protected, void, env, int, int)
 DEF_HELPER_1(clts, void, env)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_FLAGS_3(set_dr, TCG_CALL_NO_WG, void, env, int, tl)
 DEF_HELPER_FLAGS_2(get_dr, TCG_CALL_NO_WG, tl, env, int)
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 DEF_HELPER_1(sysenter, void, env)
 DEF_HELPER_2(sysexit, void, env, int)
@@ -61,9 +61,9 @@ DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_1(rsm, void, env)
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 DEF_HELPER_2(into, void, env, int)
 DEF_HELPER_FLAGS_1(single_step, TCG_CALL_NO_WG, noreturn, env)
@@ -73,7 +73,7 @@ DEF_HELPER_1(rdtsc, void, env)
 DEF_HELPER_1(rdtscp, void, env)
 DEF_HELPER_FLAGS_1(rdpmc, TCG_CALL_NO_WG, noreturn, env)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_3(outb, void, env, i32, i32)
 DEF_HELPER_2(inb, tl, env, i32)
 DEF_HELPER_3(outw, void, env, i32, i32)
@@ -98,7 +98,7 @@ DEF_HELPER_1(rdmsr, void, env)
 DEF_HELPER_1(wrmsr, void, env)
 DEF_HELPER_FLAGS_2(read_crN, TCG_CALL_NO_RWG, tl, env, int)
 DEF_HELPER_FLAGS_3(write_crN, TCG_CALL_NO_RWG, void, env, int, tl)
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* x86 FPU */
 
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 7b1528248a..f5bf822d59 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,7 +14,7 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
 
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index cd1723389a..5e08a020a8 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -38,7 +38,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  * @cpu: vCPU the interrupt is to be handled by.
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
 
@@ -93,7 +93,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 G_NORETURN void do_pause(CPUX86State *env);
 
 /* sysemu/svm_helper.c */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1f37e36b7c..5f6f4129ab 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -13,7 +13,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/registerfields.h"
 #include "qemu/timer.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "exec/memory.h"
 #endif
 #include "cpu-csr.h"
@@ -343,7 +343,7 @@ typedef struct CPUArchState {
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
 
     AddressSpace address_space_iocsr;
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b9de77d926..48f3b51dd2 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -95,7 +95,7 @@ DEF_HELPER_FLAGS_1(set_rounding_mode, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(rdtime_d, i64, env)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* CSRs helper */
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 7b0f29c942..68d1d726c3 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -56,7 +56,7 @@ const char *loongarch_exception_name(int32_t exception);
 int ieee_ex_to_loongarch(int xcpt);
 void restore_fp_status(CPULoongArchState *env);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
@@ -72,7 +72,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             bool probe, uintptr_t retaddr);
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 uint64_t read_fcc(CPULoongArchState *env);
 void write_fcc(CPULoongArchState *env, uint64_t val);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 048d5aae2b..ada0bbbf77 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -173,11 +173,11 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
@@ -581,7 +581,7 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 88324d0bc1..0ff502e1eb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -25,7 +25,7 @@
 #include "qemu/cpu-float.h"
 
 typedef struct CPUArchState CPUMBState;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "mmu.h"
 #endif
 
@@ -282,7 +282,7 @@ struct CPUArchState {
 
     uint32_t iflags;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Unified MMU.  */
     MicroBlazeMMU mmu;
 #endif
@@ -355,12 +355,12 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
                                            int mmu_idx, uintptr_t retaddr);
@@ -409,7 +409,7 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
     *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
@@ -435,7 +435,7 @@ static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_mb_cpu;
 #endif
 
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index f740835fcb..7e012ddfa7 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 142c55af47..73c8ee9343 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1151,7 +1151,7 @@ typedef struct CPUArchState {
 
     /* Fields from here on are preserved across CPU reset. */
     CPUMIPSMVPContext *mvp;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     CPUMIPSTLBContext *tlb;
     void *irq[8];
     struct MIPSITUState *itu;
@@ -1300,7 +1300,7 @@ uint64_t cpu_mips_phys_to_kseg0(void *opaque, uint64_t addr);
 uint64_t cpu_mips_kseg1_to_phys(void *opaque, uint64_t addr);
 uint64_t cpu_mips_phys_to_kseg1(void *opaque, uint64_t addr);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 /* mips_int.c */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
@@ -1308,7 +1308,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 /* mips_itu.c */
 void itc_reconfigure(struct MIPSITUState *tag);
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index de32d82e98..cb619f3447 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -9,12 +9,12 @@ DEF_HELPER_4(sdr, void, env, tl, tl, int)
 DEF_HELPER_4(swl, void, env, tl, tl, int)
 DEF_HELPER_4(swr, void, env, tl, tl, int)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_3(ll, tl, env, tl, int)
 #ifdef TARGET_MIPS64
 DEF_HELPER_3(lld, tl, env, tl, int)
 #endif
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #ifdef TARGET_MIPS64
@@ -589,9 +589,9 @@ DEF_HELPER_FLAGS_3(dmthlip, 0, void, tl, tl, env)
 DEF_HELPER_FLAGS_3(wrdsp, 0, void, tl, tl, env)
 DEF_HELPER_FLAGS_2(rddsp, 0, tl, tl, env)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "tcg/sysemu_helper.h.inc"
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 #include "tcg/msa_helper.h.inc"
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 4b0031d10d..649a0e80c7 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -99,7 +99,7 @@ int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 #define KSEG2_BASE      ((target_ulong)(int32_t)0xC0000000UL)
 #define KSEG3_BASE      ((target_ulong)(int32_t)0xE0000000UL)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 enum {
     TLBRET_XI = -6,
@@ -161,7 +161,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 {
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..f0672184a8 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -38,7 +38,7 @@ void do_raise_exception(CPUMIPSState *env,
     do_raise_exception_err(env, exception, 0, pc);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
@@ -67,6 +67,6 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 void mips_semihosting(CPUMIPSState *env);
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 #endif
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 20042c4332..3c67464e20 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -27,7 +27,7 @@
 #include "qom/object.h"
 
 typedef struct CPUArchState CPUNios2State;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "mmu.h"
 #endif
 
@@ -60,7 +60,7 @@ struct Nios2CPUClass {
 #define NUM_GP_REGS 32
 #define NUM_CR_REGS 32
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* 63 shadow register sets; index 0 is the primary register set. */
 #define NUM_REG_SETS 64
 #endif
@@ -196,7 +196,7 @@ struct CPUArchState {
     uint32_t ctrl[NUM_CR_REGS];
     uint32_t pc;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     Nios2MMU mmu;
 #endif
     int error_code;
@@ -252,7 +252,7 @@ static inline bool nios2_cr_reserved(const ControlRegState *s)
 
 static inline void nios2_update_crs(CPUNios2State *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
     env->regs = env->shadow_regs[crs];
 #endif
@@ -286,7 +286,7 @@ static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
diff --git a/target/nios2/helper.h b/target/nios2/helper.h
index 1648d76ade..073678dae5 100644
--- a/target/nios2/helper.h
+++ b/target/nios2/helper.h
@@ -22,7 +22,7 @@ DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, s32, env, s32, s32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 DEF_HELPER_3(eret, noreturn, env, i32, i32)
 DEF_HELPER_FLAGS_2(rdprs, TCG_CALL_NO_WG, i32, env, i32)
 DEF_HELPER_3(wrprs, void, env, i32, i32)
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f16e8b3274..ecdc94e48a 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -225,7 +225,7 @@ typedef struct OpenRISCTLBEntry {
     uint32_t tr;
 } OpenRISCTLBEntry;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 typedef struct CPUOpenRISCTLBContext {
     OpenRISCTLBEntry itlb[TLB_SIZE];
     OpenRISCTLBEntry dtlb[TLB_SIZE];
@@ -268,7 +268,7 @@ typedef struct CPUArchState {
 
     uint32_t dflag;           /* In delay slot (boolean) */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     CPUOpenRISCTLBContext tlb;
 #endif
 
@@ -284,7 +284,7 @@ typedef struct CPUArchState {
     uint32_t dmmucfgr;        /* DMMU configure register */
     uint32_t immucfgr;        /* IMMU configure register */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     QEMUTimer *timer;
     uint32_t ttmr;          /* Timer tick mode register */
     int is_counting;
@@ -319,7 +319,7 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #define cpu_list cpu_openrisc_list
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 9666f54f65..0d33645a64 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -179,7 +179,7 @@ struct PowerPCCPUClass {
     uint32_t flags;
     int bfd_mach;
     uint32_t l1_dcache_size, l1_icache_size;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned int gdb_num_sprs;
     const char *gdb_spr_xml;
 #endif
@@ -191,7 +191,7 @@ struct PowerPCCPUClass {
     int  (*check_pow)(CPUPPCState *env);
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 typedef struct PPCTimebase {
     uint64_t guest_timebase;
     int64_t time_of_the_day_ns;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 10c4ffa148..27f2562230 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -206,13 +206,13 @@ typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
 struct ppc_spr_t {
     const char *name;
     target_ulong default_value;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned int gdb_id;
 #endif
 #ifdef CONFIG_TCG
     void (*uea_read)(DisasContext *ctx, int gpr_num, int spr_num);
     void (*uea_write)(DisasContext *ctx, int spr_num, int gpr_num);
-# ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_SOFTMMU
     void (*oea_read)(DisasContext *ctx, int gpr_num, int spr_num);
     void (*oea_write)(DisasContext *ctx, int spr_num, int gpr_num);
     void (*hea_read)(DisasContext *ctx, int gpr_num, int spr_num);
@@ -253,7 +253,7 @@ typedef ppc_vsr_t ppc_avr_t;
 typedef ppc_vsr_t ppc_fprp_t;
 typedef ppc_vsr_t ppc_acc_t;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* Software TLB cache */
 typedef struct ppc6xx_tlb_t ppc6xx_tlb_t;
 struct ppc6xx_tlb_t {
@@ -1128,7 +1128,7 @@ struct CPUArchState {
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
@@ -1193,7 +1193,7 @@ struct CPUArchState {
 
     int error_code;
     uint32_t pending_interrupts;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /*
      * This is the IRQ controller, which is implementation dependent and only
      * relevant when emulating a complete machine. Note that this isn't used
@@ -1224,7 +1224,7 @@ struct CPUArchState {
     /* Power management */
     int (*check_pow)(CPUPPCState *env);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     void *load_info;  /* holds boot loading state */
 #endif
 
@@ -1328,7 +1328,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     bool (*cpu_in_nested)(PowerPCCPU *cpu);
@@ -1364,7 +1364,7 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
 const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
@@ -1373,7 +1373,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void ppc_maybe_interrupt(CPUPPCState *env);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
@@ -1385,10 +1385,10 @@ extern const VMStateDescription vmstate_ppc_cpu;
 /*****************************************************************************/
 void ppc_translate_init(void);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
 void ppc_cpu_list(void);
@@ -1412,7 +1412,7 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
 void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 target_ulong load_40x_pit(CPUPPCState *env);
 void store_40x_pit(CPUPPCState *env, target_ulong val);
 void store_40x_dbcr0(CPUPPCState *env, uint32_t val);
@@ -1486,7 +1486,7 @@ bool ppc_type_check_compat(const char *cputype, uint32_t compat_pvr,
 
 int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
@@ -2522,11 +2522,11 @@ G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
                                        uint32_t error_code, uintptr_t raddr);
 
 /* PERFM EBB helper*/
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 void raise_ebb_perfm_exception(CPUPPCState *env);
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static inline int booke206_tlbm_id(CPUPPCState *env, ppcmas_tlb_t *tlbm)
 {
     uintptr_t tlbml = (uintptr_t)tlbm;
@@ -2741,7 +2741,7 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
     return cpu->env.spr_cb[spr].name != NULL;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 38efbc351c..c58b3dfca0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -8,7 +8,7 @@ DEF_HELPER_4(HASHST, void, env, tl, tl, tl)
 DEF_HELPER_4(HASHCHK, void, env, tl, tl, tl)
 DEF_HELPER_4(HASHSTP, void, env, tl, tl, tl)
 DEF_HELPER_4(HASHCHKP, void, env, tl, tl, tl)
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 DEF_HELPER_2(store_msr, void, env, tl)
 DEF_HELPER_1(ppc_maybe_interrupt, void, env)
 DEF_HELPER_1(rfi, void, env)
@@ -648,7 +648,7 @@ DEF_HELPER_3(efdcmplt, i32, env, i64, i64)
 DEF_HELPER_3(efdcmpgt, i32, env, i64, i64)
 DEF_HELPER_3(efdcmpeq, i32, env, i64, i64)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 DEF_HELPER_2(4xx_tlbre_hi, tl, env, tl)
 DEF_HELPER_2(4xx_tlbre_lo, tl, env, tl)
 DEF_HELPER_3(4xx_tlbwe_hi, void, env, tl, tl)
@@ -695,7 +695,7 @@ DEF_HELPER_2(book3s_msgclr, void, env, tl)
 #endif
 
 DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 DEF_HELPER_2(rac, tl, env, tl)
 
 DEF_HELPER_2(load_dcr, tl, env, tl)
@@ -711,7 +711,7 @@ DEF_HELPER_FLAGS_1(load_tbu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 901bae6d39..45e7e71ee4 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -148,7 +148,7 @@ EXTRACT_HELPER(TO, 21, 5);
 
 EXTRACT_HELPER(CRM, 12, 8);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 EXTRACT_HELPER(SR, 16, 4);
 #endif
 
@@ -242,7 +242,7 @@ static inline int prot_for_access_type(MMUAccessType access_type)
     g_assert_not_reached();
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* PowerPC MMU emulation */
 
@@ -269,7 +269,7 @@ struct mmu_ctx_t {
     int nx;                        /* Non-execute area          */
 };
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* Common routines used by software and hardware TLBs emulation */
 static inline int pte_is_valid(target_ulong pte0)
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 611debc3ce..38d9888de9 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -43,7 +43,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
 void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
@@ -53,7 +53,7 @@ int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
 bool kvmppc_has_cap_spapr_vfio(void);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
 int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
@@ -236,7 +236,7 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 {
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline bool kvmppc_spapr_use_multitce(void)
 {
     return false;
@@ -296,7 +296,7 @@ static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
     abort();
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static inline bool kvmppc_has_cap_epr(void)
 {
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 674377a19e..89173498ce 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -23,7 +23,7 @@
 #include "mmu-hash64.h"
 #include "mmu-books.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /*
  * Partition table definitions
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 7119a63d97..35b6c54af8 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -1,7 +1,7 @@
 #ifndef MMU_HASH32_H
 #define MMU_HASH32_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash);
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 1496955d38..0875edd0dc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,7 +1,7 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #ifdef TARGET_PPC64
 void dump_slb(PowerPCCPU *cpu);
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 4c768aa5cc..5dcb01ee95 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -1,7 +1,7 @@
 #ifndef MMU_RADIX64_H
 #define MMU_RADIX64_H
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* Radix Quadrants */
 #define R_EADDR_MASK            0x3FFFFFFFFFFFFFFF
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index c0093e2219..13c94a540a 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -13,7 +13,7 @@
 #ifndef POWER8_PMU_H
 #define POWER8_PMU_H
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
 
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 4c0f2bed77..6d89e8e051 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -109,7 +109,7 @@ void spr_write_MMCR2_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC14_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC56_ureg(DisasContext *ctx, int sprn, int gprn);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void spr_write_clear(DisasContext *ctx, int sprn, int gprn);
 void spr_access_nop(DisasContext *ctx, int sprn, int gprn);
 void spr_read_decr(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..b663e3c4d6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -84,7 +84,7 @@ typedef enum {
 
 #define MAX_RISCV_PMPS (16)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "pmp.h"
 #include "debug.h"
 #endif
@@ -161,7 +161,7 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     target_ulong priv;
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
@@ -474,7 +474,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     RISCVSATPMap satp_mode;
 #endif
 };
@@ -550,7 +550,7 @@ void riscv_cpu_list(void);
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -629,7 +629,7 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
 static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 {
     RISCVMXL xl = env->misa_mxl;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /*
      * When emulating a 32-bit-only cpu, use RV32.
      * When emulating a 64-bit cpu, and MXL has been reduced to RV32,
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 98e97810fd..d536341e6f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -109,7 +109,7 @@ DEF_HELPER_4(csrrw, tl, env, int, tl, tl)
 DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(wfi, void, env)
@@ -120,7 +120,7 @@ DEF_HELPER_1(itrigger_match, void, env)
 #endif
 
 /* Hypervisor functions */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
 DEF_HELPER_FLAGS_2(hyp_hlv_bu, TCG_CALL_NO_WG, tl, env, tl)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b5f823c7ec..da76ca6389 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -70,7 +70,7 @@ target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
 target_ulong fclass_d(uint64_t frs1);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_riscv_cpu;
 #endif
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 555d230f24..ece11daf37 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -120,11 +120,11 @@ struct ArchCPU {
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 const char *rx_crname(uint8_t cr);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f130c29f83..d1db5ad2c3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -120,7 +120,7 @@ struct CPUArchState {
     uint16_t external_call_addr;
     DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     uint64_t tlb_fill_tec;   /* translation exception code during tlb_fill */
     int tlb_fill_exc;        /* exception number seen during tlb_fill */
 #endif
@@ -128,7 +128,7 @@ struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
     uint64_t cpuid;
 #endif
@@ -177,7 +177,7 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_s390_cpu;
 #endif
 
@@ -787,7 +787,7 @@ void s390_enable_css_support(S390CPU *cpu);
 void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
 #else
 static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7529e725f2..de74302fed 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -327,7 +327,7 @@ DEF_HELPER_4(gvec_vftci32, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vftci128, void, ptr, cptr, env, i32)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
 DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 825252d728..5122fc0da6 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -13,7 +13,7 @@
 #include "cpu.h"
 #include "fpu/softfloat.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 typedef struct LowCore {
     /* prefix area: defined by architecture */
     uint32_t        ccw1[2];                  /* 0x000 */
@@ -201,7 +201,7 @@ enum cc_op {
     CC_OP_MAX
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
                                        uint8_t *ar)
@@ -237,7 +237,7 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
                  uint64_t vr);
 
 /* cpu.c */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 unsigned int s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
 void s390_cpu_init_sysemu(Object *obj);
@@ -324,7 +324,7 @@ void s390_cpu_gdb_init(CPUState *cs);
 /* helper.c */
 void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void do_restart_interrupt(CPUS390XState *env);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 02bfd612ea..9bb87d3c36 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -223,7 +223,7 @@ G_NORETURN void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 void sh4_translate_init(void);
 void sh4_cpu_list(void);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3d090e8278..b5bcc20bb6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -566,7 +566,7 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 extern const VMStateDescription vmstate_sparc_cpu;
 
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
@@ -591,7 +591,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(CPUSPARCState *env);
 
-#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_SPARC64) && defined(CONFIG_SOFTMMU)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                               uint8_t *buf, int len, bool is_write);
 #endif
@@ -639,7 +639,7 @@ static inline int tlb_compare_context(const SparcTLBEntry *tlb,
 #endif
 
 /* cpu-exec.c */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void sparc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -769,13 +769,13 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = env->npc;
     flags = cpu_mmu_index(env, false);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu_supervisor_mode(env)) {
         flags |= TB_FLAG_SUPER;
     }
 #endif
 #ifdef TARGET_SPARC64
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu_hypervisor_mode(env)) {
         flags |= TB_FLAG_HYPER;
     }
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8f1e78c75..db35a40e0b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -38,7 +38,7 @@ DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
 DEF_HELPER_FLAGS_3(sdivx, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_3(udivx, TCG_CALL_NO_WG, i64, env, i64, i64)
 #endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b7a54711a6..d3d0b0737e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -524,7 +524,7 @@ struct CPUArchState {
     uint32_t exclusive_addr;
     uint32_t exclusive_val;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
     xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
@@ -566,7 +566,7 @@ struct ArchCPU {
 };
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
@@ -676,7 +676,7 @@ static inline int xtensa_get_cring(const CPUXtensaState *env)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index ae938ceedb..ec1818240b 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -11,11 +11,11 @@ DEF_HELPER_2(retw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
 DEF_HELPER_1(restore_owb, void, env)
 DEF_HELPER_2(movsp, void, env, i32)
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_1(simcall, void, env)
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 DEF_HELPER_3(waiti, void, env, i32, i32)
 DEF_HELPER_1(update_ccount, void, env)
 DEF_HELPER_2(wsr_ccount, void, env, i32)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index bcc70d99ba..a9a1cd6a67 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1326,7 +1326,7 @@
 /* VECTOR FP TEST DATA CLASS IMMEDIATE */
     F(0xe74a, VFTCI,   VRI_e, V,   0, 0, 0, 0, vftci, 0, IF_VEC)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL, IF_PRIV)
     E(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_TEUQ, IF_PRIV)
diff --git a/accel/accel-common.c b/accel/accel-common.c
index df72cc989a..061769284b 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -29,9 +29,9 @@
 #include "cpu.h"
 #include "hw/core/accel-cpu.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "accel-softmmu.h"
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
@@ -103,9 +103,9 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
 
 void accel_init_interfaces(AccelClass *ac)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     accel_init_ops_interfaces(ac);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
     accel_init_cpu_interfaces(ac);
 }
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d5695a7083..1bcec1460e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -30,7 +30,7 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_I386) && defined(CONFIG_SOFTMMU)
 #include "hw/i386/apic.h"
 #endif
 #include "sysemu/cpus.h"
@@ -52,7 +52,7 @@ typedef struct SyncClocks {
     int64_t realtime_clock;
 } SyncClocks;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* Allow the guest to have a max 3ms advance.
  * The difference between the 2 clocks could therefore
  * oscillate around 0.
@@ -646,7 +646,7 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 
 static inline bool cpu_handle_halt(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->halted) {
 #if defined(TARGET_I386)
         if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
@@ -687,7 +687,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
 static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 {
     if (cpu->exception_index < 0) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         if (replay_has_exception()
             && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
@@ -746,7 +746,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
  * "real" interrupt event later. It does not need to be recorded for
@@ -795,7 +795,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             qemu_mutex_unlock_iothread();
             return true;
         }
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
@@ -909,7 +909,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 
     /* Instruction counter expired.  */
     assert(icount_enabled());
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
@@ -992,7 +992,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 }
             }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             /*
              * We don't take care of direct jumps when address mapping
              * changes in system emulation.  So it's not safe to make a
@@ -1084,7 +1084,7 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_iommu_init_notifier_list(cpu);
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
@@ -1093,7 +1093,7 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
 /* undo the initializations in reverse order */
 void tcg_exec_unrealizefn(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_iommu_free_notifier_list(cpu);
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 02af6a2891..8fd2c7179f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,7 +35,7 @@
 #include "qemu/atomic.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/boards.h"
 #endif
 #include "internal.h"
@@ -104,7 +104,7 @@ static void tcg_accel_instance_init(Object *obj)
     s->mttcg_enabled = default_mttcg_enabled();
 
     /* If debugging enabled, default "auto on", otherwise off. */
-#if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_DEBUG_TCG) && defined(CONFIG_SOFTMMU)
     s->splitwx_enabled = -1;
 #else
     s->splitwx_enabled = 0;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index dd19b3ca78..d715393a12 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -595,7 +595,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * In deterministic execution mode, instructions doing device I/Os
  * must be at the end of the TB.
diff --git a/cpu.c b/cpu.c
index 65ebaf8159..4a91ecd630 100644
--- a/cpu.c
+++ b/cpu.c
@@ -47,7 +47,7 @@
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static int cpu_common_post_load(void *opaque, int version_id)
 {
     CPUState *cpu = opaque;
@@ -168,7 +168,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->sysemu_ops->legacy_vmsd != NULL) {
@@ -250,7 +250,7 @@ void cpu_exec_initfn(CPUState *cpu)
     cpu->as = NULL;
     cpu->num_ases = 0;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cpu->thread_id = qemu_get_thread_id();
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
@@ -328,7 +328,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
     if (cpu->singlestep_enabled != enabled) {
         cpu->singlestep_enabled = enabled;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
             ops->update_guest_debug(cpu);
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index be18568d0a..14d8edbbae 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1549,7 +1549,7 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
 static void handle_query_qemu_supported(GArray *params, void *user_ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "sstepbits;sstep");
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     g_string_append(gdbserver_state.str_buf, ";PhyMemMode");
 #endif
     gdb_put_strbuf();
@@ -1643,7 +1643,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_supported,
         .cmd = "qemu.Supported",
     },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     {
         .handler = gdb_handle_query_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode",
@@ -1659,7 +1659,7 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     {
         .handler = gdb_handle_set_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode:",
@@ -1995,7 +1995,7 @@ void gdb_read_byte(uint8_t ch)
     uint8_t reply;
 
     gdbserver_state.allow_stop_reply = false;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (gdbserver_state.last_packet->len) {
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..5397d03f9e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,7 +42,7 @@
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
@@ -362,7 +362,7 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
  * will be. This helps the plugin dimension per-vcpu arrays.
  */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static MachineState * get_ms(void)
 {
     return MACHINE(qdev_get_machine());
diff --git a/plugins/loader.c b/plugins/loader.c
index 809f3f9b13..02dd7f705d 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -30,7 +30,7 @@
 #include "qemu/memalign.h"
 #include "hw/core/cpu.h"
 #include "exec/tb-flush.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/boards.h"
 #endif
 #include "qemu/compiler.h"
@@ -295,7 +295,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     info->target_name = TARGET_NAME;
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     MachineState *ms = MACHINE(qdev_get_machine());
     info->system_emulation = true;
     info->system.smp_vcpus = ms->smp.cpus;
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 564fe17f75..32508931dc 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -100,7 +100,7 @@ static int gdb_open_modeflags[12] = {
     GDB_O_RDWR | GDB_O_CREAT | GDB_O_APPEND,
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /**
  * common_semi_find_bases: find information about ram and heap base
@@ -205,7 +205,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
  * errno be per-thread in linux-user mode; in softmmu it is a simple
  * global, and we assume that the guest takes care of avoiding any races.
  */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static target_ulong syscall_err;
 
 #include "semihosting/softmmu-uaccess.h"
@@ -584,7 +584,7 @@ void do_common_semihosting(CPUState *cs)
             size_t input_size;
             size_t output_size;
             int status = 0;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
             const char *cmdline;
 #else
             TaskState *ts = cs->opaque;
@@ -593,7 +593,7 @@ void do_common_semihosting(CPUState *cs)
             GET_ARG(1);
             input_size = arg1;
             /* Compute the size of the output string.  */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
             cmdline = semihosting_get_cmdline();
             if (cmdline == NULL) {
                 cmdline = ""; /* Default to an empty line. */
@@ -631,7 +631,7 @@ void do_common_semihosting(CPUState *cs)
             }
 
             /* Copy the command-line arguments.  */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
             pstrcpy(output_buffer, output_size, cmdline);
 #else
             if (output_size == 1) {
diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index acb86b50dd..859e733008 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -45,7 +45,7 @@ void qemu_semihosting_guestfd_init(void)
 #else
     /* Otherwise, the stdio file descriptors apply. */
     guestfd_array = g_array_set_size(guestfd_array, 3);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!use_gdb_syscalls()) {
         GuestFD *gf = &g_array_index(guestfd_array, GuestFD, 0);
         gf[0].type = GuestFDConsole;
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 68899ebb1c..65782ae2f9 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -525,7 +525,7 @@ static void host_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
     unlock_user(p, tv_addr, sizeof(struct gdb_timeval));
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                           GuestFD *gf, GIOCondition cond, int timeout)
 {
@@ -648,7 +648,7 @@ static void console_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
     complete(cs, ret ? -1 : 0, ret ? -ret : 0);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void console_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                              GuestFD *gf, GIOCondition cond, int timeout)
 {
@@ -955,7 +955,7 @@ void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                            int fd, GIOCondition cond, int timeout)
 {
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..2f21336288 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3400,7 +3400,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         range++;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (fvi->dispatch_tree && view->root) {
         mtree_print_dispatch(view->dispatch, view->root);
     }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 270ae787b1..04c47edfdf 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -222,13 +222,13 @@ static void alpha_cpu_initfn(Object *obj)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
     .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -239,13 +239,13 @@ static const struct TCGCPUOps alpha_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
     .record_sigbus = alpha_cpu_record_sigbus,
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
     .tlb_fill = alpha_cpu_tlb_fill,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void alpha_cpu_class_init(ObjectClass *oc, void *data)
@@ -264,7 +264,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = alpha_cpu_get_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_alpha_cpu;
     cc->sysemu_ops = &alpha_sysemu_ops;
 #endif
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 970c869771..09ddbbce11 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -97,7 +97,7 @@ void helper_store_fpcr(CPUAlphaState *env, uint64_t val)
 
 static uint64_t *cpu_alpha_addr_gr(CPUAlphaState *env, unsigned reg)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (env->flags & ENV_FLAG_PAL_MODE) {
         if (reg >= 8 && reg <= 14) {
             return &env->shadow[reg - 8];
@@ -477,7 +477,7 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index c83c92dd4c..6bb5aec5d4 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -29,7 +29,7 @@
 
 uint64_t helper_load_pcc(CPUAlphaState *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* In system mode we have access to a decent high-resolution clock.
        In order to make OS-level time accounting work with the RPCC,
        present it with a well-timed clock fixed at 250MHz.  */
@@ -43,7 +43,7 @@ uint64_t helper_load_pcc(CPUAlphaState *env)
 }
 
 /* PALcode support special instructions */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void helper_tbia(CPUAlphaState *env)
 {
     tlb_flush(env_cpu(env));
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 1f7dd078d8..995af81c06 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -92,7 +92,7 @@ static TCGv cpu_pc;
 static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static TCGv cpu_pal_ir[31];
 #endif
 
@@ -122,7 +122,7 @@ void alpha_translate_init(void)
         "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
         "f24", "f25", "f26", "f27", "f28", "f29", "f30"
     };
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     static const char shadow_names[8][8] = {
         "pal_t7", "pal_s0", "pal_s1", "pal_s2",
         "pal_s3", "pal_s4", "pal_s5", "pal_t11"
@@ -143,7 +143,7 @@ void alpha_translate_init(void)
                                             freg_names[i]);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     memcpy(cpu_pal_ir, cpu_std_ir, sizeof(cpu_pal_ir));
     for (i = 0; i < 8; i++) {
         int r = (i == 7 ? 25 : i + 8);
@@ -643,7 +643,7 @@ static TCGv gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
                 gen_helper_ieee_input(cpu_env, val);
             }
         } else {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             /* In system mode, raise exceptions for denormals like real
                hardware.  In user mode, proceed as if the OS completion
                handler is handling the denormal as per spec.  */
@@ -1076,7 +1076,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
         return DISAS_NEXT;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* Privileged PAL code */
     if (palcode < 0x40 && (ctx->tbflags & ENV_FLAG_PS_USER) == 0) {
         switch (palcode) {
@@ -1188,7 +1188,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #define PR_LONG         0x200000
 
@@ -2362,7 +2362,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x19:
         /* HW_MFPR (PALcode) */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         va = dest_gpr(ctx, ra);
         ret = gen_mfpr(ctx, va, insn & 0xffff);
@@ -2384,7 +2384,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x1B:
         /* HW_LD (PALcode) */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             TCGv addr = tcg_temp_new();
@@ -2612,7 +2612,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x1D:
         /* HW_MTPR (PALcode) */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         vb = load_gpr(ctx, rb);
         ret = gen_mtpr(ctx, vb, insn & 0xffff);
@@ -2623,7 +2623,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x1E:
         /* HW_RET (PALcode) */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         if (rb == 31) {
             /* Pre-EV6 CPUs interpreted this as HW_REI, loading the return
@@ -2649,7 +2649,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x1F:
         /* HW_ST (PALcode) */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             switch ((insn >> 12) & 0xF) {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5182ed0c91..0bcfd042ff 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -33,13 +33,13 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/loader.h"
 #include "hw/boards.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
 #endif /* CONFIG_TCG */
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
 #include "sysemu/hw_accel.h"
@@ -353,7 +353,7 @@ static void arm_cpu_reset_hold(Object *obj)
 #endif
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
@@ -413,7 +413,7 @@ static void arm_cpu_reset_hold(Object *obj)
                 R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK;
         }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
 
@@ -533,7 +533,7 @@ static void arm_cpu_reset_hold(Object *obj)
                               &env->vfp.fp_status_f16);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status_f16);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
     }
@@ -547,7 +547,7 @@ static void arm_cpu_reset_hold(Object *obj)
     }
 }
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_TCG) && defined(CONFIG_SOFTMMU)
 
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int target_el,
@@ -745,7 +745,7 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return true;
 }
 
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG && CONFIG_SOFTMMU */
 
 void arm_cpu_update_virq(ARMCPU *cpu)
 {
@@ -808,7 +808,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void arm_cpu_set_irq(void *opaque, int irq, int level)
 {
     ARMCPU *cpu = opaque;
@@ -939,7 +939,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
     }
     info->flags &= ~INSN_ARM_BE32;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (sctlr_b) {
         info->flags |= INSN_ARM_BE32;
     }
@@ -1261,7 +1261,7 @@ static Property arm_cpu_reset_cbar_property =
 static Property arm_cpu_reset_hivecs_property =
             DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
@@ -1368,7 +1368,7 @@ void arm_cpu_post_init(Object *obj)
                                        OBJ_PROP_FLAG_READWRITE);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  This will
          * prevent "has_el3" from existing on CPUs which cannot support EL3.
@@ -1464,7 +1464,7 @@ void arm_cpu_post_init(Object *obj)
         kvm_arm_add_vcpu_properties(obj);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
         cpu_isar_feature(aa64_mte, cpu)) {
         object_property_add_link(obj, "tag-memory",
@@ -1499,7 +1499,7 @@ static void arm_cpu_finalizefn(Object *obj)
         QLIST_REMOVE(hook, node);
         g_free(hook);
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->pmu_timer) {
         timer_free(cpu->pmu_timer);
     }
@@ -1558,7 +1558,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     bool no_aa32 = false;
 
     /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
@@ -1575,7 +1575,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
      * error and will result in segfaults if not caught here.
@@ -1972,7 +1972,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, arm_pmu_timer_cb,
                 cpu);
 #endif
@@ -1995,7 +1995,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                        ID_PFR1, VIRTUALIZATION, 0);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->tag_memory == NULL && cpu_isar_feature(aa64_mte, cpu)) {
         /*
          * Disable the MTE feature bits if we do not have tag-memory
@@ -2088,7 +2088,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     init_cpreg_list(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
@@ -2206,7 +2206,7 @@ static gchar *arm_gdb_arch_name(CPUState *cs)
     return g_strdup("arm");
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
@@ -2217,7 +2217,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #ifdef CONFIG_TCG
 static const struct TCGCPUOps arm_tcg_ops = {
@@ -2238,7 +2238,7 @@ static const struct TCGCPUOps arm_tcg_ops = {
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
     .debug_check_watchpoint = arm_debug_check_watchpoint,
     .debug_check_breakpoint = arm_debug_check_breakpoint,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 #endif /* CONFIG_TCG */
 
@@ -2264,7 +2264,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = arm_cpu_get_pc;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_num_core_regs = 26;
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index d41cc643b1..3d992a4253 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -746,7 +746,7 @@ void hw_breakpoint_update_all(ARMCPU *cpu)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
 {
@@ -771,7 +771,7 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
     return addr;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 #endif /* CONFIG_TCG */
 
 /*
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 03b17c814f..a3d23c5aaf 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -439,7 +439,7 @@ static int arm_gen_dynamic_m_systemreg_xml(CPUState *cs, int orig_base_reg)
     return cpu->dyn_m_systemreg_xml.num;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * For user-only, we see the non-secure registers via m_systemreg above.
  * For secext, encode the non-secure view as even and secure view as odd.
@@ -492,7 +492,7 @@ const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
         return cpu->dyn_svereg_xml.desc;
     } else if (strcmp(xmlname, "arm-m-system.xml") == 0) {
         return cpu->dyn_m_systemreg_xml.desc;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     } else if (strcmp(xmlname, "arm-m-secext.xml") == 0) {
         return cpu->dyn_m_secextreg_xml.desc;
 #endif
@@ -566,7 +566,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
             arm_gen_dynamic_m_systemreg_xml(cs, cs->gdb_num_regs),
             "arm-m-system.xml", 0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             gdb_register_coprocessor(cs,
                 arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..eccafa3d59 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -917,7 +917,7 @@ static int64_t swinc_ns_per(uint64_t ignored)
  */
 static uint64_t cycles_get_count(CPUARMState *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                    ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
 #else
@@ -925,7 +925,7 @@ static uint64_t cycles_get_count(CPUARMState *env)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static int64_t cycles_ns_per(uint64_t cycles)
 {
     return (ARM_CPU_FREQ / NANOSECONDS_PER_SECOND) * cycles;
@@ -977,7 +977,7 @@ static const pm_event pm_events[] = {
       .get_count = swinc_get_count,
       .ns_per_count = swinc_ns_per,
     },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     { .number = 0x008, /* INST_RETIRED, Instruction architecturally executed */
       .supported = instructions_supported,
       .get_count = instructions_get_count,
@@ -1328,7 +1328,7 @@ static void pmccntr_op_start(CPUARMState *env)
 static void pmccntr_op_finish(CPUARMState *env)
 {
     if (pmu_counter_enabled(env, 31)) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         /* Calculate when the counter will next overflow */
         uint64_t remaining_cycles = -env->cp15.c15_ccnt;
         if (!(env->cp15.c9_pmcr & PMCRLC)) {
@@ -1382,7 +1382,7 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
 static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
 {
     if (pmu_counter_enabled(env, counter)) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         uint16_t event = env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_EVTCOUNT;
         uint16_t event_idx = supported_event_map[event];
         uint64_t delta = -(env->cp15.c14_pmevcntr[counter] + 1);
@@ -2406,7 +2406,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .resetvalue = 0 },
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -3309,7 +3309,7 @@ static void par_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* get_phys_addr() isn't present for user-mode-only targets */
 
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3664,7 +3664,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
                              offsetoflow32(CPUARMState, cp15.par_ns) },
       .writefn = par_write },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
       .access = PL1_W, .accessfn = ats_access,
@@ -5258,7 +5258,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DC_ZVA", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_DC_ZVA,
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
       /* Avoid overhead of an access check that always passes in user-mode */
       .accessfn = aa64_zva_access,
       .fgt = FGT_DCZVA,
@@ -5408,7 +5408,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_alle1is_write },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* 64 bit address translation operations */
     { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
@@ -6054,7 +6054,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2is_write },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /*
      * Unlike the other EL2-related AT operations, these must
      * UNDEF from EL3 if EL2 is not implemented, which is why we
@@ -6287,7 +6287,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* Test if system register redirection is to occur in the current state.  */
 static bool redirect_for_e2h(CPUARMState *env)
 {
@@ -6579,7 +6579,7 @@ static const ARMCPRegInfo minimal_ras_reginfo[] = {
  */
 int sve_exception_el(CPUARMState *env, int el)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (el <= 1 && !el_is_in_host(env, el)) {
         switch (FIELD_EX64(env->cp15.cpacr_el1, CPACR_EL1, ZEN)) {
         case 1:
@@ -6628,7 +6628,7 @@ int sve_exception_el(CPUARMState *env, int el)
  */
 int sme_exception_el(CPUARMState *env, int el)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (el <= 1 && !el_is_in_host(env, el)) {
         switch (FIELD_EX64(env->cp15.cpacr_el1, CPACR_EL1, SMEN)) {
         case 1:
@@ -7000,7 +7000,7 @@ static void define_pmu_regs(ARMCPU *cpu)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * We don't know until after realize whether there's a GICv3
  * attached, and that is what registers the gicv3 sysregs.
@@ -7405,7 +7405,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -7608,7 +7608,7 @@ static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
     { .name = "DC_GVA", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 3,
       .access = PL0_W, .type = ARM_CP_DC_GVA,
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
       /* Avoid overhead of an access check that always passes in user-mode */
       .accessfn = aa64_zva_access,
       .fgt = FGT_DCZVA,
@@ -7617,7 +7617,7 @@ static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
     { .name = "DC_GZVA", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 4,
       .access = PL0_W, .type = ARM_CP_DC_GZVA,
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
       /* Avoid overhead of an access check that always passes in user-mode */
       .accessfn = aa64_zva_access,
       .fgt = FGT_DCZVA,
@@ -7842,7 +7842,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
       .fieldoffset =
@@ -7897,7 +7897,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
 #endif
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static const ARMCPRegInfo ats1e1_reginfo[] = {
     { .name = "AT_S1E1RP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
@@ -9038,7 +9038,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pan, cpu)) {
         define_one_arm_cp_reg(cpu, &pan_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu_isar_feature(aa64_ats1e1, cpu)) {
         define_arm_cp_regs(cpu, ats1e1_reginfo);
     }
@@ -9092,7 +9092,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9133,7 +9133,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ccsidr2_reginfo);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /*
      * Register redirections and aliases must be done last,
      * after the registers from the other extensions have been defined.
@@ -11623,7 +11623,7 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
  */
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint64_t hcr_el2;
 
     /*
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 47d2e8e781..2dd61b87a5 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -13,11 +13,11 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "internals.h"
 #include "target/arm/idau.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/boards.h"
 #endif
 #include "cpregs.h"
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "hw/intc/armv7m_nvic.h"
 #endif
 
@@ -92,9 +92,9 @@ void aa32_max_features(ARMCPU *cpu)
 }
 
 /* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+#if defined(CONFIG_SOFTMMU) || !defined(TARGET_AARCH64)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
@@ -448,7 +448,7 @@ static void cortex_a9_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexa9_cp_reginfo);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -462,7 +462,7 @@ static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 #endif
 
 static const ARMCPRegInfo cortexa15_cp_reginfo[] = {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     { .name = "L2CTLR", .cp = 15, .crn = 9, .crm = 0, .opc1 = 1, .opc2 = 2,
       .access = PL1_RW, .resetvalue = 0, .readfn = a15_l2ctlr_read,
       .writefn = arm_cp_write_ignore, },
@@ -1021,7 +1021,7 @@ static const struct TCGCPUOps arm_v7m_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
@@ -1030,7 +1030,7 @@ static const struct TCGCPUOps arm_v7m_tcg_ops = {
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
     .debug_check_watchpoint = arm_debug_check_watchpoint,
     .debug_check_breakpoint = arm_debug_check_breakpoint,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
@@ -1182,4 +1182,4 @@ static void arm_tcg_cpu_register_types(void)
 
 type_init(arm_tcg_cpu_register_types)
 
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
+#endif /* CONFIG_SOFTMMU || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index c3edf163be..c28f7a93fb 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -925,7 +925,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      */
     mem = tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (unlikely(!mem)) {
         uintptr_t ra = GETPC();
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9cef70e5c9..e8c8f223c3 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -19,7 +19,7 @@
 #include "exec/cpu_ldst.h"
 #include "semihosting/common-semi.h"
 #endif
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/intc/armv7m_nvic.h"
 #endif
 
@@ -159,7 +159,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
     return ARMMMUIdx_MUser;
 }
 
-#else /* !CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 
 static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
                                      bool secstate, bool priv, bool negpri)
@@ -2862,7 +2862,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     return tt_resp;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
                              bool spsel)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 3baf8004f6..98ec566273 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -256,7 +256,7 @@ void HELPER(check_bxj_trap)(CPUARMState *env, uint32_t rm)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
  * The function returns the target EL (1-3) if the instruction is to be trapped;
  * otherwise it returns 0 indicating it is not trapped.
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0097522470..8ab4b877e4 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5535,7 +5535,7 @@ bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
     return have_work;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void sve_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
                                uint64_t *vg, target_ulong addr,
                                int esize, int msize, int wp_access,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8df36c2cbf..57105fc304 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -180,7 +180,7 @@ void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
     raise_exception(env, EXCP_PREFETCH_ABORT, syn_pcalignment(), target_el);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
@@ -281,4 +281,4 @@ void arm_cpu_record_sigbus(CPUState *cs, vaddr addr,
 {
     arm_cpu_do_unaligned_access(cs, addr, access_type, MMU_USER_IDX, ra);
 }
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9800337cf..60f5035c1a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14064,7 +14064,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->tbid = EX_TBFLAG_A64(tb_flags, TBID);
     dc->tcma = EX_TBFLAG_A64(tb_flags, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     dc->user = (dc->current_el == 0);
 #endif
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a68d3c7f6d..2b3ac587e8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -327,7 +327,7 @@ void store_reg(DisasContext *s, int reg, TCGv_i32 var)
  */
 static void store_sp_checked(DisasContext *s, TCGv_i32 var)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (s->v8m_stackcheck) {
         gen_helper_v8m_stackcheck(cpu_env, var);
     }
@@ -789,7 +789,7 @@ static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
      * s->base.is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (arm_dc_feature(s, ARM_FEATURE_M_SECURITY) ||
         (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M))) {
         s->base.is_jmp = DISAS_BX_EXCRET;
@@ -9134,7 +9134,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     core_mmu_idx = EX_TBFLAG_ANY(tb_flags, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     dc->user = (dc->current_el == 0);
 #endif
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a6a93c2359..34abc3ee85 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -158,7 +158,7 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
     ccc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void cris_cpu_set_irq(void *opaque, int irq, int level)
 {
     CRISCPU *cpu = opaque;
@@ -179,7 +179,7 @@ static void cris_cpu_set_irq(void *opaque, int irq, int level)
         cpu_reset_interrupt(cs, type);
     }
 }
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 static void cris_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
@@ -205,13 +205,13 @@ static void cris_cpu_initfn(Object *obj)
 
     env->pregs[PR_VR] = ccc->vr;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* IRQ and NMI lines.  */
     qdev_init_gpio_in(DEVICE(cpu), cris_cpu_set_irq, 2);
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps cris_sysemu_ops = {
@@ -225,22 +225,22 @@ static const struct TCGCPUOps crisv10_tcg_ops = {
     .initialize = cris_initialize_crisv10_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
     .do_interrupt = crisv10_cpu_do_interrupt,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static const struct TCGCPUOps crisv32_tcg_ops = {
     .initialize = cris_initialize_tcg,
     .restore_state_to_opc = cris_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
     .do_interrupt = cris_cpu_do_interrupt,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
@@ -322,7 +322,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = cris_cpu_get_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
     cc->gdb_write_register = cris_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_cris_cpu;
     cc->sysemu_ops = &cris_sysemu_ops;
 #endif
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index d55a18a213..09aaf77b5f 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -47,7 +47,7 @@ void helper_raise_exception(CPUCRISState *env, uint32_t index)
 
 void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     pid &= 0xff;
     if (pid != (env->pregs[PR_PID] & 0xff)) {
         cris_mmu_flush_pid(env, env->pregs[PR_PID]);
@@ -57,7 +57,7 @@ void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
 
 void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     CPUState *cs = env_cpu(env);
 
     tlb_flush_page(cs, env->pregs[PR_SPC]);
@@ -76,7 +76,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
     srs &= 3;
     env->sregs[srs][sreg] = env->regs[reg];
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (srs == 1 || srs == 2) {
         if (sreg == 6) {
             /* Writes to tlb-hi write to mm_cause as a side effect.  */
@@ -121,7 +121,7 @@ void helper_movl_reg_sreg(CPUCRISState *env, uint32_t reg, uint32_t sreg)
     env->pregs[PR_SRS] &= 3;
     srs = env->pregs[PR_SRS];
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (srs == 1 || srs == 2) {
         uint32_t set;
         uint32_t idx;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 1445cd8bb5..f090c98c56 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2890,7 +2890,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
         }
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Single-stepping ?  */
     if (dc->tb_flags & S_FLAG) {
         TCGLabel *l1 = gen_new_label();
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 217bc7bb5a..233469a4db 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -772,7 +772,7 @@ static void gen_framecheck(TCGv EA, int framesize)
 {
     /* Not modelled in linux-user mode */
     /* Placeholder for system mode */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     g_assert_not_reached();
 #endif
 }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 11022f9c99..3541efaa10 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -99,7 +99,7 @@ static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
     info->print_insn = print_insn_hppa;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static G_NORETURN
 void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                   MMUAccessType access_type, int mmu_idx,
@@ -117,7 +117,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
     cpu_loop_exit_restore(cs, retaddr);
 }
-#endif /* CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
@@ -134,7 +134,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_init_vcpu(cs);
     acc->parent_realize(dev, errp);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     {
         HPPACPU *cpu = HPPA_CPU(cs);
         cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
@@ -160,7 +160,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
     return object_class_by_name(TYPE_HPPA_CPU);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
@@ -175,12 +175,12 @@ static const struct TCGCPUOps hppa_tcg_ops = {
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = hppa_cpu_tlb_fill,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void hppa_cpu_class_init(ObjectClass *oc, void *data)
@@ -199,7 +199,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = hppa_cpu_get_pc;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_hppa_cpu;
     cc->sysemu_ops = &hppa_sysemu_ops;
 #endif
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 74b8747083..308d97e484 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -70,7 +70,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 
     /* If PSW_P changes, it affects how we translate addresses.  */
     if ((psw ^ old_psw) & PSW_P) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         tlb_flush_by_mmuidx(env_cpu(env), 0xf);
 #endif
     }
@@ -119,7 +119,7 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "GR%02d " TREG_FMT_lx "%c", i, env->gr[i],
                      (i & 3) == 3 ? '\n' : ' ');
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     for (i = 0; i < 8; i++) {
         qemu_fprintf(f, "SR%02d %08x%c", i, (uint32_t)(env->sr[i] >> 32),
                      (i & 3) == 3 ? '\n' : ' ');
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d33813d173..1189eca265 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -500,7 +500,7 @@ static TCGv_reg get_temp(DisasContext *ctx)
     return ctx->tempr[i] = tcg_temp_new();
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static TCGv_tl get_temp_tl(DisasContext *ctx)
 {
     unsigned i = ctx->ntempl++;
@@ -1368,7 +1368,7 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* The "normal" usage is SP >= 0, wherein SP == 0 selects the space
    from the top 2 bits of the base register.  There are a few system
    instructions that have a 3-bit space specifier, for which SR0 is
@@ -2158,7 +2158,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     /* All other control registers are privileged or read-only.  */
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     nullify_over(ctx);
     reg = load_gpr(ctx, a->r);
 
@@ -2191,7 +2191,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     case CR_PID3:
     case CR_PID4:
         tcg_gen_st_reg(reg, cpu_env, offsetof(CPUHPPAState, cr[ctl]));
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         gen_helper_change_prot_id(cpu_env);
 #endif
         break;
@@ -2239,7 +2239,7 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_reg tmp;
 
     nullify_over(ctx);
@@ -2259,7 +2259,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_reg tmp;
 
     nullify_over(ctx);
@@ -2279,7 +2279,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
 static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_reg tmp, reg;
     nullify_over(ctx);
 
@@ -2296,7 +2296,7 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 static bool do_rfi(DisasContext *ctx, bool rfi_r)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     nullify_over(ctx);
 
     if (rfi_r) {
@@ -2325,7 +2325,7 @@ static bool trans_rfi_r(DisasContext *ctx, arg_rfi_r *a)
 static bool trans_halt(DisasContext *ctx, arg_halt *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     nullify_over(ctx);
     gen_helper_halt(cpu_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2336,7 +2336,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 static bool trans_reset(DisasContext *ctx, arg_reset *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     nullify_over(ctx);
     gen_helper_reset(cpu_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2347,7 +2347,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     nullify_over(ctx);
     gen_helper_getshadowregs(cpu_env);
     return nullify_end(ctx);
@@ -2398,7 +2398,7 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
 static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_tl addr;
     TCGv_reg ofs, reg;
 
@@ -2423,7 +2423,7 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
 static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_tl addr;
     TCGv_reg ofs;
 
@@ -2456,7 +2456,7 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
 static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_tl addr, atl, stl;
     TCGv_reg reg;
 
@@ -2501,7 +2501,7 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_tl vaddr;
     TCGv_reg ofs, paddr;
 
@@ -2623,7 +2623,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
             cond_free(&ctx->null_cond);
             return true;
         }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         /* These are QEMU extensions and are nops in the real architecture:
          *
          * or %r10,%r10,%r10 -- idle loop; wait for interrupt
@@ -3449,7 +3449,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         return gen_illegal(ctx);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (ctx->tb_flags & PSW_C) {
         CPUHPPAState *env = ctx->cs->env_ptr;
         int type = hppa_artype_for_page(env, ctx->base.pc_next);
@@ -4191,7 +4191,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->iaoq_f == -1) {
             tcg_gen_mov_reg(cpu_iaoq_f, cpu_iaoq_b);
             copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
 #endif
             nullify_save(ctx);
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 40697064d9..2e28e6ca45 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/qemu-print.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/i386/apic_internal.h"
 #endif
 
@@ -152,7 +152,7 @@ done:
     qemu_fprintf(f, "\n");
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* ARRAY_SIZE check is not required because
  * DeliveryMode(dm) has a size of 3 bit.
@@ -336,7 +336,7 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
     qemu_printf(" PPR 0x%02x\n", apic_get_ppr(s));
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a..cdc0e7dd2f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -35,7 +35,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
@@ -5342,7 +5342,7 @@ void x86_cpu_list(void)
     g_list_free(names);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
@@ -5418,7 +5418,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                             bool migratable_only)
@@ -6071,7 +6071,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     }
     case 0x12:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         if (!kvm_enabled() ||
             !(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX)) {
             *eax = *ebx = *ecx = *edx = 0;
@@ -6402,7 +6402,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
 static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* Those default values are defined in Skylake HW */
     env->msr_ia32_sgxlepubkeyhash[0] = 0xa6053e051270b7acULL;
     env->msr_ia32_sgxlepubkeyhash[1] = 0x6cfbe8ba8b3b413dULL;
@@ -6553,7 +6553,7 @@ static void x86_cpu_reset_hold(Object *obj)
     env->exception_payload = 0;
     env->nmi_injected = false;
     env->triple_fault_pending = false;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* We hard-wire the BSP to the first CPU. */
     apic_designate_bsp(cpu->apic_state, s->cpu_index == 0);
 
@@ -6572,7 +6572,7 @@ static void x86_cpu_reset_hold(Object *obj)
 
 void x86_cpu_after_reset(X86CPU *cpu)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (kvm_enabled()) {
         kvm_arch_after_reset_vcpu(cpu);
     }
@@ -6943,7 +6943,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     unsigned requested_lbr_fmt;
 
     /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
@@ -7135,7 +7135,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         env->cache_info_amd.l3_cache = &legacy_l3_cache;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     MachineState *ms = MACHINE(qdev_get_machine());
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
@@ -7171,12 +7171,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             ht_warned = true;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     x86_cpu_apic_realize(cpu, &local_err);
     if (local_err != NULL) {
         goto out;
     }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
     cpu_reset(cs);
 
     xcc->parent_realize(dev, &local_err);
@@ -7193,7 +7193,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev)
     X86CPU *cpu = X86_CPU(dev);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cpu_remove_sync(CPU(dev));
     qemu_unregister_reset(x86_cpu_machine_reset_cb, dev);
 #endif
@@ -7369,14 +7369,14 @@ static int64_t x86_cpu_get_arch_id(CPUState *cs)
     return cpu->apic_id;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static bool x86_cpu_get_paging_enabled(const CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     return cpu->env.cr[0] & CR0_PG_MASK;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static void x86_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -7398,7 +7398,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
     }
@@ -7423,7 +7423,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
                      (env->eflags & IF_MASK &&
                       !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
             return CPU_INTERRUPT_HARD;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         } else if (env->hflags2 & HF2_VGIF_MASK) {
             if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
                    (env->eflags & IF_MASK) &&
@@ -7638,7 +7638,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -7653,7 +7653,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .legacy_vmsd = &vmstate_x86_cpu,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 {
@@ -7683,9 +7683,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = x86_cpu_gdb_write_register;
     cc->get_arch_id = x86_cpu_get_arch_id;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &i386_sysemu_ops;
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
@@ -7727,7 +7727,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     object_class_property_add(oc, "crash-information", "GuestPanicInformation",
                               x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
 #endif
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index ebb000df6a..c9cbdaceda 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -204,7 +204,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         case IDX_CTL_CR4_REG:
             return gdb_read_reg_cs64(env->hflags, mem_buf, env->cr[4]);
         case IDX_CTL_CR8_REG:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             tpr = cpu_get_apic_tpr(cpu->apic_state);
 #else
             tpr = 0;
@@ -353,42 +353,42 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
         case IDX_CTL_CR0_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             cpu_x86_update_cr0(env, tmp);
 #endif
             return len;
 
         case IDX_CTL_CR2_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             env->cr[2] = tmp;
 #endif
             return len;
 
         case IDX_CTL_CR3_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             cpu_x86_update_cr3(env, tmp);
 #endif
             return len;
 
         case IDX_CTL_CR4_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             cpu_x86_update_cr4(env, tmp);
 #endif
             return len;
 
         case IDX_CTL_CR8_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             cpu_set_apic_tpr(cpu->apic_state, tmp);
 #endif
             return len;
 
         case IDX_CTL_EFER_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             cpu_load_efer(env, tmp);
 #endif
             return len;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c9755b3aba..4c62fadc4f 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "sysemu/runstate.h"
 #include "kvm/kvm_i386.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
 #endif
@@ -226,7 +226,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
     cpu_sync_avx_hflag(env);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
@@ -548,7 +548,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
         apic_handle_tpr_access_report(cpu->apic_state, eip, access);
     }
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
                             target_ulong *base, unsigned int *limit,
@@ -712,4 +712,4 @@ void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val)
 
     address_space_stq(as, addr, val, attrs, NULL);
 }
-#endif
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/i386/tcg/bpt_helper.c b/target/i386/tcg/bpt_helper.c
index bc34ac27fe..af0d9f0f60 100644
--- a/target/i386/tcg/bpt_helper.c
+++ b/target/i386/tcg/bpt_helper.c
@@ -24,7 +24,7 @@
 
 G_NORETURN void helper_single_step(CPUX86State *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     check_hw_breakpoints(env, true);
     env->dr[6] |= DR6_BS;
 #endif
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 7c3c8dc7fe..36fa395e51 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -53,7 +53,7 @@ static int check_exception(CPUX86State *env, int intno, int *error_code,
     qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x new 0x%x\n",
                 env->old_exception, intno);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->old_exception == EXCP08_DBLE) {
         if (env->hflags & HF_GUEST_MASK) {
             cpu_vmexit(env, SVM_EXIT_SHUTDOWN, 0, retaddr); /* does not return */
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 6f3741b635..2441bbe21a 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -166,7 +166,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
     if (env->cr[0] & CR0_NE_MASK) {
         raise_exception_ra(env, EXCP10_COPR, retaddr);
     }
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     else {
         fpu_check_raise_ferr_irq(env);
     }
@@ -2420,7 +2420,7 @@ static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
     env->fpstt = (fpus >> 11) & 7;
     env->fpus = fpus & ~0x3800 & ~FPUS_B;
     env->fpus |= env->fpus & FPUS_SE ? FPUS_B : 0;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (!(env->fpus & FPUS_SE)) {
         /*
          * Here the processor deasserts FERR#; in response, the chipset deasserts
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 03b58e94a2..1c80d8036c 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -493,7 +493,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
         raise_exception_err_ra(env, EXCP0D_GPF, 0, retaddr);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* reset local breakpoints */
     if (env->dr[7] & DR7_LOCAL_BP_MASK) {
         cpu_x86_update_dr7(env, env->dr[7] & ~DR7_LOCAL_BP_MASK);
@@ -1116,7 +1116,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
         }
     }
     if (env->cr[0] & CR0_PE_MASK) {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         if (env->hflags & HF_GUEST_MASK) {
             handle_even_inj(env, intno, is_int, error_code, is_hw, 0);
         }
@@ -1131,7 +1131,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                                    is_hw);
         }
     } else {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         if (env->hflags & HF_GUEST_MASK) {
             handle_even_inj(env, intno, is_int, error_code, is_hw, 1);
         }
@@ -1139,7 +1139,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
         do_interrupt_real(env, intno, is_int, error_code, next_eip);
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->hflags & HF_GUEST_MASK) {
         CPUState *cs = CPU(cpu);
         uint32_t event_inj = x86_ldl_phys(cs, env->vm_vmcb +
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b942c306d6..de018b4c38 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -74,7 +74,7 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -104,7 +104,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
@@ -162,7 +162,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     acc->cpu_realizefn = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a6..dd6ba436bc 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -94,7 +94,7 @@ typedef struct DisasContext {
     bool has_modrm;
     uint8_t modrm;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint8_t cpl;   /* code priv level */
     uint8_t iopl;  /* i/o priv level */
 #endif
@@ -6892,7 +6892,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cs_base = dc->base.tb->cs_base;
     dc->pc_save = dc->base.pc_next;
     dc->flags = flags;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->cpl = cpl;
     dc->iopl = iopl;
 #endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..a65f881768 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -92,7 +92,7 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/loongarch/virt.h"
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
@@ -506,7 +506,7 @@ static void loongarch_cpu_reset_hold(Object *obj)
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV3, 0);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     env->pc = 0x1c000000;
     memset(env->tlb, 0, sizeof(env->tlb));
 #endif
@@ -540,7 +540,7 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     lacc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void loongarch_qemu_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
@@ -585,7 +585,7 @@ static void loongarch_cpu_init(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     CPULoongArchState *env = &cpu->env;
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
@@ -675,7 +675,7 @@ static struct TCGCPUOps loongarch_tcg_ops = {
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .do_interrupt = loongarch_cpu_do_interrupt,
@@ -684,7 +684,7 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
@@ -714,7 +714,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
 #endif
diff --git a/target/loongarch/op_helper.c b/target/loongarch/op_helper.c
index 60335a05e2..deb0a77991 100644
--- a/target/loongarch/op_helper.c
+++ b/target/loongarch/op_helper.c
@@ -103,7 +103,7 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void helper_ertn(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 99af1ab541..525560a1b9 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -527,7 +527,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 };
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
@@ -541,12 +541,12 @@ static const struct TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void m68k_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 3b3a6ea8bd..82df60ed4a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -480,7 +480,7 @@ void m68k_switch_sp(CPUM68KState *env)
     env->current_sp = new_sp;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* MMU: 68040 only */
 
 static void print_address_zone(uint32_t logical, uint32_t physical,
@@ -1053,7 +1053,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     env->mmu.ar = address;
     cpu_loop_exit_restore(cs, retaddr);
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 uint32_t HELPER(bitrev)(uint32_t x)
 {
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..75282eb6bd 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -24,7 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "semihosting/semihost.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 static void cf_rte(CPUM68KState *env)
 {
@@ -529,7 +529,7 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 G_NORETURN static void
 raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 03c2c4db1f..001c4e8078 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -118,7 +118,7 @@ static bool mb_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void mb_cpu_ns_axi_dp(void *opaque, int irq, int level)
 {
     MicroBlazeCPU *cpu = opaque;
@@ -303,7 +303,7 @@ static void mb_cpu_initfn(Object *obj)
 
     set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
     qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
@@ -378,7 +378,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
     return object_class_by_name(TYPE_MICROBLAZE_CPU);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
@@ -393,13 +393,13 @@ static const struct TCGCPUOps mb_tcg_ops = {
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
     .do_unaligned_access = mb_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void mb_cpu_class_init(ObjectClass *oc, void *data)
@@ -423,7 +423,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_mb_cpu;
     cc->sysemu_ops = &mb_sysemu_ops;
 #endif
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 98bdb82de8..8077c5cf28 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -24,7 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
                                     MMUAccessType access_type)
 {
@@ -267,7 +267,7 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                 MMUAccessType access_type,
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f6378030b7..3ecac4f727 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -382,7 +382,7 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* Writes/reads to the MMU's special regs end up here.  */
 uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7e7f837c63..7b1ecc5a53 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -668,7 +668,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
     return ret;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
     int addr_size = dc->cfg->addr_size;
@@ -696,7 +696,7 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
 {
@@ -736,7 +736,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
      * requires it.  For user-mode, the Linux kernel will have fixed up
      * any unaligned access, so emulate that by *not* setting MO_ALIGN.
      */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cfg->unaligned_exceptions) {
@@ -886,7 +886,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
      * requires it.  For user-mode, the Linux kernel will have fixed up
      * any unaligned access, so emulate that by *not* setting MO_ALIGN.
      */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cfg->unaligned_exceptions) {
@@ -1427,7 +1427,7 @@ static bool trans_mfs(DisasContext *dc, arg_mfs *arg)
                 tcg_gen_extrh_i64_i32(dest, t64);
             }
             return true;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         case 0x1003: /* TLBLO */
             /* Handled below. */
             break;
@@ -1476,7 +1476,7 @@ static bool trans_mfs(DisasContext *dc, arg_mfs *arg)
         tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, shr));
         break;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     case 0x1000: /* PID */
     case 0x1001: /* ZPR */
     case 0x1002: /* TLBX */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 01e0fbe10d..6aa57a88d3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -278,7 +278,7 @@ static void mips_cpu_reset_hold(Object *obj)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 # endif
-#else /* !CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
     if (env->hflags & MIPS_HFLAG_BMASK) {
         /*
          * If the exception was raised from a delay slot,
@@ -375,7 +375,7 @@ static void mips_cpu_reset_hold(Object *obj)
                          (1 << CP0SC_EU) | (2 << CP0SC_C)) << 16;
     /* XKPhys (note, SegCtl2.XR = 0, so XAM won't be used) */
     env->CP0_SegCtl1 |= (CP0SC_AM_UK << CP0SC1_XAM);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
     if ((env->insn_flags & ISA_MIPS_R6) &&
         (env->active_fpu.fcr0 & (1 << FCR0_F64))) {
         /* Status.FR = 0 mode in 64-bit FPU not allowed in R6 */
@@ -417,7 +417,7 @@ static void mips_cpu_reset_hold(Object *obj)
         env->active_tc.gpr[4] = -1;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (kvm_enabled()) {
         kvm_mips_reset_vcpu(cpu);
     }
@@ -463,7 +463,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cpu->clock)) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         if (!qtest_enabled()) {
             g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
 
@@ -484,7 +484,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 
     env->exception_base = (int32_t)0xBFC00000;
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_TCG) && defined(CONFIG_SOFTMMU)
     mmu_init(env, env->cpu_model);
 #endif
     fpu_init(env, env->cpu_model);
@@ -523,7 +523,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
@@ -543,14 +543,14 @@ static const struct TCGCPUOps mips_tcg_ops = {
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
     .io_recompile_replay_branch = mips_io_recompile_replay_branch,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 #endif /* CONFIG_TCG */
 
@@ -573,7 +573,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->get_pc = mips_cpu_get_pc;
     cc->gdb_read_register = mips_cpu_gdb_read_register;
     cc->gdb_write_register = mips_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &mips_sysemu_ops;
 #endif
     cc->disas_set_info = mips_cpu_disas_set_info;
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 62d7b72407..7ea4d57cb3 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -110,7 +110,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
     switch (n) {
     case 32:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         cpu_mips_store_status(env, tmp);
 #endif
         break;
@@ -124,7 +124,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->CP0_BadVAddr = tmp;
         break;
     case 36:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         cpu_mips_store_cause(env, tmp);
 #endif
         break;
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index c1a8380e34..e67fac3133 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -27,7 +27,7 @@
 #include "exec/memop.h"
 #include "internal.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
@@ -50,7 +50,7 @@ HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 #endif
 #undef HELPER_LD_ATOMIC
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static inline bool cpu_is_bigendian(CPUMIPSState *env)
 {
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 29b31d70fe..42fd09e3e6 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8210,7 +8210,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #define MEMOP_IDX(DF)                                                   \
     MemOpIdx oi = make_memop_idx(MO_TE | DF | MO_UNALN,                 \
                                  cpu_mmu_index(env, false));
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ef3dafcbb3..d9ed6d123c 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -257,7 +257,7 @@ void helper_pmon(CPUMIPSState *env, int function)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                   MMUAccessType access_type,
@@ -300,4 +300,4 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
         do_raise_exception(env, EXCP_DBE, retaddr);
     }
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 74af91e4f5..f0d13a44e6 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1630,7 +1630,7 @@ static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t flags)
  */
 static inline void check_insn_opc_user_only(DisasContext *ctx, uint64_t flags)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     check_insn_opc_removed(ctx, flags);
 #endif
 }
@@ -1658,7 +1658,7 @@ void check_mips_64(DisasContext *ctx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline void check_mvh(DisasContext *ctx)
 {
     if (unlikely(!ctx->mvh)) {
@@ -1678,7 +1678,7 @@ static inline void check_xnp(DisasContext *ctx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * This code generates a "reserved instruction" exception if the
  * Config3 PW bit is NOT set.
@@ -1702,7 +1702,7 @@ static inline void check_mt(DisasContext *ctx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * This code generates a "coprocessor unusable" exception if CP0 is not
  * available, and, if that is not the case, generates a "reserved instruction"
@@ -5045,7 +5045,7 @@ static void gen_bitswap(DisasContext *ctx, int opc, int rd, int rt)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* CP0 (MMU and control) */
 static inline void gen_mthc0_entrylo(TCGv arg, target_ulong off)
 {
@@ -11116,7 +11116,7 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
 {
     TCGv t0;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /*
      * The Linux kernel will emulate rdhwr if it's not supported natively.
      * Therefore only check the ISA in system mode.
@@ -13808,7 +13808,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             }
         }
         break;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     case OPC_GINV:
         if (unlikely(ctx->gi <= 1)) {
             gen_reserved_instruction(ctx);
@@ -14756,9 +14756,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         case OPC_DMFC0:
         case OPC_DMTC0:
 #endif
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             gen_cp0(env, ctx, op1, rt, rd);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
             break;
         case OPC_C0:
         case OPC_C0_1:
@@ -14776,12 +14776,12 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         case OPC_C0_D:
         case OPC_C0_E:
         case OPC_C0_F:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             gen_cp0(env, ctx, MASK_C0(ctx->opcode), rt, rd);
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
             break;
         case OPC_MFMC0:
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             {
                 uint32_t op2;
                 TCGv t0 = tcg_temp_new();
@@ -14851,7 +14851,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
                     break;
                 }
             }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
             break;
         case OPC_RDPGPR:
             check_insn(ctx, ISA_MIPS_R2);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index bc5cbf81c2..c36073ecc0 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -82,7 +82,7 @@ static void nios2_cpu_reset_hold(Object *obj)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void eic_set_irq(void *opaque, int irq, int level)
 {
     Nios2CPU *cpu = opaque;
@@ -117,7 +117,7 @@ static void nios2_cpu_initfn(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     mmu_init(&cpu->env);
 #endif
 }
@@ -201,7 +201,7 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->eic_present) {
         qdev_init_gpio_in_named(DEVICE(cpu), eic_set_irq, "EIC", 1);
     } else {
@@ -225,7 +225,7 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     ncc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool eic_take_interrupt(Nios2CPU *cpu)
 {
     CPUNios2State *env = &cpu->env;
@@ -271,7 +271,7 @@ static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
@@ -346,7 +346,7 @@ static Property nios2_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps nios2_sysemu_ops = {
@@ -360,12 +360,12 @@ static const struct TCGCPUOps nios2_tcg_ops = {
     .initialize = nios2_tcg_init,
     .restore_state_to_opc = nios2_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = nios2_cpu_tlb_fill,
     .cpu_exec_interrupt = nios2_cpu_exec_interrupt,
     .do_interrupt = nios2_cpu_do_interrupt,
     .do_unaligned_access = nios2_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void nios2_cpu_class_init(ObjectClass *oc, void *data)
@@ -387,7 +387,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = nios2_cpu_set_pc;
     cc->get_pc = nios2_cpu_get_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &nios2_sysemu_ops;
 #endif
     cc->gdb_read_register = nios2_cpu_gdb_read_register;
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index 0aaf33ffc2..efea888caa 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -74,7 +74,7 @@ uint32_t helper_divu(CPUNios2State *env, uint32_t num, uint32_t den)
     return num / den;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void helper_eret(CPUNios2State *env, uint32_t new_status, uint32_t new_pc)
 {
     Nios2CPU *cpu = env_archcpu(env);
@@ -117,4 +117,4 @@ void helper_wrprs(CPUNios2State *env, uint32_t regno, uint32_t val)
     unsigned prs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, PRS);
     env->shadow_regs[prs][regno] = val;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index a365ad8293..bf8d90e9be 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -139,7 +139,7 @@ typedef struct DisasContext {
 
 static TCGv cpu_R[NUM_GP_REGS];
 static TCGv cpu_pc;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static TCGv cpu_crs_R[NUM_GP_REGS];
 #endif
 
@@ -818,7 +818,7 @@ static void trap(DisasContext *dc, uint32_t code, uint32_t flags)
 
 static void gen_break(DisasContext *dc, uint32_t code, uint32_t flags)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /* The semihosting instruction is "break 1".  */
     bool is_user = FIELD_EX32(dc->tb_flags, TBFLAGS, U);
     R_TYPE(instr, code);
@@ -928,7 +928,7 @@ static const char * const gr_regnames[NUM_GP_REGS] = {
     "fp",         "ea",         "ba",         "ra",
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static const char * const cr_regnames[NUM_CR_REGS] = {
     "status",     "estatus",    "bstatus",    "ienable",
     "ipending",   "cpuid",      "res6",       "exception",
@@ -1058,7 +1058,7 @@ void nios2_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     int j;
 
     for (i = j = 0; i < NUM_CR_REGS; i++) {
@@ -1084,7 +1084,7 @@ void nios2_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 void nios2_tcg_init(void)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_ptr crs = tcg_global_mem_new_ptr(cpu_env,
                                           offsetof(CPUNios2State, regs), "crs");
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 61d748cfdc..b870248cd5 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -94,7 +94,7 @@ static void openrisc_cpu_reset_hold(Object *obj)
     set_float_detect_tininess(float_tininess_before_rounding,
                               &cpu->env.fp_status);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cpu->env.picmr = 0x00000000;
     cpu->env.picsr = 0x00000000;
 
@@ -102,7 +102,7 @@ static void openrisc_cpu_reset_hold(Object *obj)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void openrisc_cpu_set_irq(void *opaque, int irq, int level)
 {
     OpenRISCCPU *cpu = (OpenRISCCPU *)opaque;
@@ -153,7 +153,7 @@ static void openrisc_cpu_initfn(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     qdev_init_gpio_in_named(DEVICE(cpu), openrisc_cpu_set_irq, "IRQ", NR_IRQS);
 #endif
 }
@@ -210,7 +210,7 @@ static void openrisc_any_initfn(Object *obj)
                       | (IMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
@@ -225,11 +225,11 @@ static const struct TCGCPUOps openrisc_tcg_ops = {
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .do_interrupt = openrisc_cpu_do_interrupt,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
@@ -251,7 +251,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = openrisc_cpu_get_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->vmsd = &vmstate_openrisc_cpu;
     cc->sysemu_ops = &openrisc_sysemu_ops;
 #endif
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 3887812810..c20f684aba 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/loader.h"
 #endif
 
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 782a5751b7..dab9aa0496 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/boards.h"
 #endif
 #include "tcg/insn-start-words.h"
@@ -42,7 +42,7 @@ static inline bool is_user(CPUOpenRISCState *env)
 void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     CPUState *cs = env_cpu(env);
     target_ulong mr;
     int idx;
@@ -59,7 +59,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         raise_exception(cpu, EXCP_ILLEGAL);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     switch (spr) {
     case TO_SPR(0, 11): /* EVBAR */
         env->evbar = rb;
@@ -216,7 +216,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
                            target_ulong spr)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint64_t data[TARGET_INSN_START_WORDS];
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs = env_cpu(env);
@@ -233,7 +233,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         raise_exception(cpu, EXCP_ILLEGAL);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     switch (spr) {
     case TO_SPR(0, 0): /* VR */
         return env->vr;
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7949a24f5a..985118f890 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -144,7 +144,7 @@ bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     g_assert(cpu->vhyp);
 #endif
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 424f2e1741..023eca90b8 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -90,7 +90,7 @@ void ppc_store_msr(CPUPPCState *env, target_ulong value)
     hreg_store_msr(env, value, 0);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 05bf73296b..5bea2d5af5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -46,7 +46,7 @@
 #include "spr_common.h"
 #include "power8-pmu.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/boards.h"
 #endif
 
@@ -220,7 +220,7 @@ static void register_7xx_sprs(CPUPPCState *env)
 #ifdef TARGET_PPC64
 static void register_amr_sprs(CPUPPCState *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     /*
      * Virtual Page Class Key protection
      *
@@ -252,7 +252,7 @@ static void register_amr_sprs(CPUPPCState *env)
 
 static void register_iamr_sprs(CPUPPCState *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_iamr,
@@ -824,7 +824,7 @@ static void register_BookE_sprs(CPUPPCState *env, uint64_t ivor_mask)
                  0x00000000);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static inline uint32_t register_tlbncfg(uint32_t assoc, uint32_t minsize,
                                    uint32_t maxsize, uint32_t flags,
                                    uint32_t nentries)
@@ -834,13 +834,13 @@ static inline uint32_t register_tlbncfg(uint32_t assoc, uint32_t minsize,
            (maxsize << TLBnCFG_MAXSIZE_SHIFT) |
            flags | nentries;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* BookE 2.06 storage control registers */
 static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
                              uint32_t *tlbncfg, uint32_t mmucfg)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     const char *mas_names[8] = {
         "MAS0", "MAS1", "MAS2", "MAS3", "MAS4", "MAS5", "MAS6", "MAS7",
     };
@@ -1642,7 +1642,7 @@ static void register_8xx_sprs(CPUPPCState *env)
 /* Exception vectors models                                                  */
 static void init_excp_4xx_softmmu(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1666,7 +1666,7 @@ static void init_excp_4xx_softmmu(CPUPPCState *env)
 
 static void init_excp_MPC5xx(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x00000500;
@@ -1691,7 +1691,7 @@ static void init_excp_MPC5xx(CPUPPCState *env)
 
 static void init_excp_MPC8xx(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1722,7 +1722,7 @@ static void init_excp_MPC8xx(CPUPPCState *env)
 
 static void init_excp_G2(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1747,7 +1747,7 @@ static void init_excp_G2(CPUPPCState *env)
 
 static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000FFC;
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000000;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000000;
@@ -1783,7 +1783,7 @@ static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
 
 static void init_excp_BookE(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000000;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000000;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000000;
@@ -1809,7 +1809,7 @@ static void init_excp_BookE(CPUPPCState *env)
 
 static void init_excp_603(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1833,7 +1833,7 @@ static void init_excp_603(CPUPPCState *env)
 
 static void init_excp_604(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1855,7 +1855,7 @@ static void init_excp_604(CPUPPCState *env)
 
 static void init_excp_7x0(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1878,7 +1878,7 @@ static void init_excp_7x0(CPUPPCState *env)
 
 static void init_excp_750cl(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1900,7 +1900,7 @@ static void init_excp_750cl(CPUPPCState *env)
 
 static void init_excp_750cx(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1923,7 +1923,7 @@ static void init_excp_750cx(CPUPPCState *env)
 /* XXX: Check if this is correct */
 static void init_excp_7x5(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1949,7 +1949,7 @@ static void init_excp_7x5(CPUPPCState *env)
 
 static void init_excp_7400(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1974,7 +1974,7 @@ static void init_excp_7400(CPUPPCState *env)
 
 static void init_excp_7450(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -1999,7 +1999,7 @@ static void init_excp_7450(CPUPPCState *env)
 #if defined(TARGET_PPC64)
 static void init_excp_970(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -2027,7 +2027,7 @@ static void init_excp_970(CPUPPCState *env)
 
 static void init_excp_POWER7(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
     env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
     env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
@@ -2058,7 +2058,7 @@ static void init_excp_POWER8(CPUPPCState *env)
 {
     init_excp_POWER7(env);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_SDOOR]    = 0x00000A00;
     env->excp_vectors[POWERPC_EXCP_FU]       = 0x00000F60;
     env->excp_vectors[POWERPC_EXCP_HV_FU]    = 0x00000F80;
@@ -2074,7 +2074,7 @@ static void init_excp_POWER9(CPUPPCState *env)
 {
     init_excp_POWER8(env);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->excp_vectors[POWERPC_EXCP_HVIRT]    = 0x00000EA0;
     env->excp_vectors[POWERPC_EXCP_SYSCALL_VECTORED] = 0x00017000;
 #endif
@@ -2112,7 +2112,7 @@ static void init_proc_405(CPUPPCState *env)
     register_usprgh_sprs(env);
 
     /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 64;
     env->nb_ways = 1;
     env->id_tlbs = 0;
@@ -2185,7 +2185,7 @@ static void init_proc_440EP(CPUPPCState *env)
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
     /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 64;
     env->nb_ways = 1;
     env->id_tlbs = 0;
@@ -2283,7 +2283,7 @@ static void init_proc_440GP(CPUPPCState *env)
     register_usprgh_sprs(env);
 
     /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 64;
     env->nb_ways = 1;
     env->id_tlbs = 0;
@@ -2357,7 +2357,7 @@ static void init_proc_440x5(CPUPPCState *env)
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
     /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 64;
     env->nb_ways = 1;
     env->id_tlbs = 0;
@@ -2719,7 +2719,7 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 64;
     env->nb_ways = 1;
     env->id_tlbs = 0;
@@ -2797,7 +2797,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
     uint32_t l1cfg1 = 0x3800  /* 8 ways */
                     | 0x0020; /* 32 kb */
     uint32_t mmucfg = 0;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     int i;
 #endif
 
@@ -2837,7 +2837,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  &spr_read_spefscr, &spr_write_spefscr,
                  &spr_read_spefscr, &spr_write_spefscr,
                  0x00000000);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Memory management */
     env->nb_pids = 3;
     env->nb_ways = 2;
@@ -3001,7 +3001,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
                      0x7FFFFFFC);
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = 0;
     env->tlb_type = TLB_MAS;
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
@@ -5327,7 +5327,7 @@ static void register_power5p_tb_sprs(CPUPPCState *env)
 
 static void register_970_lpar_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /*
      * PPC970: HID4 covers things later controlled by the LPCR and
      * RMOR in later CPUs, but with a different encoding.  We only
@@ -5344,7 +5344,7 @@ static void register_970_lpar_sprs(CPUPPCState *env)
 
 static void register_power5p_lpar_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Logical partitionning */
     spr_register_kvm_hv(env, SPR_LPCR, "LPCR",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -5470,7 +5470,7 @@ static void register_power8_ids_sprs(CPUPPCState *env)
 
 static void register_book3s_purr_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* PURR & SPURR: Hack - treat these as aliases for the TB for now */
     spr_register_kvm_hv(env, SPR_PURR,   "PURR",
                         &spr_read_purr, SPR_NOACCESS,
@@ -5487,7 +5487,7 @@ static void register_book3s_purr_sprs(CPUPPCState *env)
 
 static void register_power6_dbg_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register(env, SPR_CFAR, "SPR_CFAR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_cfar, &spr_write_cfar,
@@ -5505,7 +5505,7 @@ static void register_power5p_common_sprs(CPUPPCState *env)
 
 static void register_power6_common_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register_kvm(env, SPR_DSCR, "SPR_DSCR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
@@ -5615,7 +5615,7 @@ static void register_power8_pspb_sprs(CPUPPCState *env)
 
 static void register_power8_dpdes_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Directed Privileged Door-bell Exception State, used for IPI */
     spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -5627,7 +5627,7 @@ static void register_power8_dpdes_sprs(CPUPPCState *env)
 
 static void register_power8_ic_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register_hv(env, SPR_IC, "IC",
                     SPR_NOACCESS, SPR_NOACCESS,
                     &spr_read_generic, SPR_NOACCESS,
@@ -5639,7 +5639,7 @@ static void register_power8_ic_sprs(CPUPPCState *env)
 static void register_power8_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P8 book4 registers */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
@@ -5658,7 +5658,7 @@ static void register_power8_book4_sprs(CPUPPCState *env)
 static void register_power7_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P7 book4 registers */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
@@ -5672,7 +5672,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
 
 static void register_power8_rpr_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register_hv(env, SPR_RPR, "RPR",
                     SPR_NOACCESS, SPR_NOACCESS,
                     SPR_NOACCESS, SPR_NOACCESS,
@@ -5683,7 +5683,7 @@ static void register_power8_rpr_sprs(CPUPPCState *env)
 
 static void register_power9_mmu_sprs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Partition Table Control */
     spr_register_kvm_hv(env, SPR_PTCR, "PTCR",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -6563,7 +6563,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
     CPUPPCState *env = &cpu->env;
@@ -6577,7 +6577,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     env->msr_mask &= ~MSR_HVB;
 }
 
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
 
 #endif /* defined(TARGET_PPC64) */
 
@@ -6587,7 +6587,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     int i;
 
     /* Set all exception vectors to an invalid address */
@@ -6608,7 +6608,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     /* PowerPC implementation specific initialisations (SPRs, timers, ...) */
     (*pcc->init_proc)(env);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     ppc_gdb_gen_spr_xml(cpu);
 #endif
 
@@ -6699,7 +6699,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         exit(1);
     }
     /* Allocate TLBs buffer when needed */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->nb_tlb != 0) {
         int nb_tlb = env->nb_tlb;
         if (env->id_tlbs != 0) {
@@ -6882,7 +6882,7 @@ ObjectClass *ppc_cpu_class_by_name(const char *name)
      * Return the default CPU type for the machine because that has greater
      * chance of being useful as the "max" CPU.
      */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (strcmp(name, "max") == 0) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (mc) {
@@ -7076,7 +7076,7 @@ static void ppc_cpu_reset_hold(Object *obj)
 
     hreg_store_msr(env, msr, 1);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nip = env->hreset_vector | env->excp_prefix;
 
     if (tcg_enabled()) {
@@ -7111,7 +7111,7 @@ static void ppc_cpu_reset_hold(Object *obj)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
@@ -7147,7 +7147,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
 }
 #endif /* CONFIG_TCG */
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static void ppc_cpu_instance_init(Object *obj)
 {
@@ -7177,7 +7177,7 @@ static void ppc_cpu_instance_init(Object *obj)
      * 970. If we ever want to support 970 HV mode, we'll have to add
      * a processor attribute of some sort.
      */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->has_hv_mode = !!(env->msr_mask & MSR_HVB);
 #endif
 
@@ -7228,7 +7228,7 @@ static Property ppc_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
@@ -7238,7 +7238,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .virtio_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -7256,7 +7256,7 @@ static const struct TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 #endif /* CONFIG_TCG */
 
@@ -7284,12 +7284,12 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = ppc_cpu_get_pc;
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &ppc_sysemu_ops;
 #endif
 
     cc->gdb_num_core_regs = 71;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->gdb_get_dynamic_xml = ppc_gdb_get_dynamic_xml;
 #endif
 #ifdef USE_APPLE_GDB
@@ -7325,7 +7325,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .class_init = ppc_cpu_class_init,
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static const TypeInfo ppc_vhyp_type_info = {
     .name = TYPE_PPC_VIRTUAL_HYPERVISOR,
     .parent = TYPE_INTERFACE,
@@ -7336,7 +7336,7 @@ static const TypeInfo ppc_vhyp_type_info = {
 static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     type_register_static(&ppc_vhyp_type_info);
 #endif
 }
@@ -7358,7 +7358,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "%08x iidx %d didx %d\n",
                  env->msr, env->spr[SPR_HID0], env->hflags,
                  cpu_mmu_index(env, true), cpu_mmu_index(env, false));
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->tb_env) {
         qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
                      " DECR " TARGET_FMT_lu "\n", cpu_ppc_load_tbu(env),
@@ -7408,7 +7408,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     qemu_fprintf(f, " SRR0 " TARGET_FMT_lx "  SRR1 " TARGET_FMT_lx
                  "    PVR " TARGET_FMT_lx " VRSAVE " TARGET_FMT_lx "\n",
                  env->spr[SPR_SRR0], env->spr[SPR_SRR1],
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fea9221501..6e0876213f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -34,7 +34,7 @@
 
 /*****************************************************************************/
 /* Exception processing */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 static const char *powerpc_excp_name(int excp)
 {
@@ -2552,7 +2552,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return true;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /*****************************************************************************/
 /* Exceptions processing helpers */
@@ -2597,7 +2597,7 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 }
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #ifdef CONFIG_TCG
 void helper_store_msr(CPUPPCState *env, target_ulong val)
 {
@@ -2703,7 +2703,7 @@ void helper_hrfid(CPUPPCState *env)
 }
 #endif
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2804,7 +2804,7 @@ void helper_rfmci(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
 #endif /* CONFIG_TCG */
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
 
 #ifdef CONFIG_TCG
 void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
@@ -2949,9 +2949,7 @@ HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
 #endif /* CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
-
-#ifdef CONFIG_TCG
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 
 /* Embedded.Processor Control */
 static int dbell2irq(target_ulong rb)
@@ -3119,5 +3117,4 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     env->error_code = insn & 0x03FF0000;
     cpu_loop_exit(cs);
 }
-#endif /* CONFIG_TCG */
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 63c9abe4f1..124d7b221f 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -95,7 +95,7 @@ static int ppc_gdb_register_len(int n)
  */
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!FIELD_EX64(env->msr, MSR, LE)) {
         /* do nothing */
     } else if (len == 4) {
@@ -317,7 +317,7 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
     return r;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
@@ -378,7 +378,7 @@ const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
 }
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static int gdb_find_spr_idx(CPUPPCState *env, int n)
 {
     int i;
@@ -608,7 +608,7 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
                              pcc->gdb_num_sprs, "power-spr.xml", 0);
 #endif
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index fb351c303f..fbbbb554c8 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -114,7 +114,7 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
         hflags |= 1 << HFLAGS_PMCJCE;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
         hflags |= 1 << HFLAGS_HV;
     }
@@ -215,13 +215,13 @@ void cpu_interrupt_exittb(CPUState *cs)
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 {
     int excp;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     CPUState *cs = env_cpu(env);
 #endif
 
     excp = 0;
     value &= env->msr_mask;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Neither mtmsr nor guest state can alter HV */
     if (!alter_hv || !(env->msr & MSR_HVB)) {
         value &= ~MSR_HVB;
@@ -259,7 +259,7 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 #endif
     env->msr = value;
     hreg_compute_hflags(env);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     ppc_maybe_interrupt(env);
 
     if (unlikely(FIELD_EX64(env->msr, MSR, POW))) {
@@ -285,7 +285,7 @@ void store_40x_sler(CPUPPCState *env, uint32_t val)
 }
 #endif /* CONFIG_SOFTMMU */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs = env_cpu(env);
@@ -339,7 +339,7 @@ void _spr_register(CPUPPCState *env, int num, const char *name,
 #ifdef CONFIG_TCG
     spr->uea_read = uea_read;
     spr->uea_write = uea_write;
-# ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_SOFTMMU
     spr->oea_read = oea_read;
     spr->oea_write = oea_write;
     spr->hea_read = hea_read;
@@ -464,7 +464,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
 /* Storage Description Register 1 */
 void register_sdr1_sprs(CPUPPCState *env)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (env->has_hv_mode) {
         /*
          * SDR1 is a hypervisor resource on CPUs which have a
@@ -487,7 +487,7 @@ void register_sdr1_sprs(CPUPPCState *env)
 /* BATs 0-3 */
 void register_low_BATs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register(env, SPR_IBAT0U, "IBAT0U",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_ibat, &spr_write_ibatu,
@@ -559,7 +559,7 @@ void register_low_BATs(CPUPPCState *env)
 /* BATs 4-7 */
 void register_high_BATs(CPUPPCState *env)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     spr_register(env, SPR_IBAT4U, "IBAT4U",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_ibat_h, &spr_write_ibatu_h,
@@ -631,7 +631,7 @@ void register_high_BATs(CPUPPCState *env)
 /* Softare table search registers */
 void register_6xx_7xx_soft_tlb(CPUPPCState *env, int nb_tlbs, int nb_ways)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->nb_tlb = nb_tlbs;
     env->nb_ways = nb_ways;
     env->id_tlbs = 1;
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 46eae65819..6d6c6c4c27 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -332,7 +332,7 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
 
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
     cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 40ddc5c08c..d2c8973790 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -105,7 +105,7 @@ void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
 #endif
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 {
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 64a64865d7..6b8455d8c3 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -20,7 +20,7 @@
 #include "hw/ppc/ppc.h"
 #include "power8-pmu.h"
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 
 static bool pmc_has_overflow_enabled(CPUPPCState *env, int sprn)
 {
@@ -350,4 +350,4 @@ void cpu_ppc_pmu_init(CPUPPCState *env)
                                                        cpu);
     }
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU) */
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index f9acc21056..733fa6a574 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -161,7 +161,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
     }
 
     /* Segment registers */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if ((strncasecmp(name, "sr", 2) == 0) &&
         ppc_cpu_get_reg_num(name + 2, ARRAY_SIZE(env->sr), &regnum)) {
         *pval = env->sr[regnum];
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index b80f56af7e..79d9576f05 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -51,7 +51,7 @@ target_ulong helper_load_vtb(CPUPPCState *env)
     return cpu_ppc_load_vtb(env);
 }
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 target_ulong helper_load_purr(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_purr(env);
@@ -63,7 +63,7 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
 }
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
     cpu_ppc_store_tbl(env, val);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 37fd431870..dfeb9a6be0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -296,7 +296,7 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static void gen_ppc_maybe_interrupt(DisasContext *ctx)
 {
     translator_io_start(&ctx->base);
@@ -423,7 +423,7 @@ void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_clear(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
@@ -490,7 +490,7 @@ void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
 }
 
 /* CFAR */
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
@@ -500,7 +500,7 @@ void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
 {
     tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU) */
 
 /* CTR */
 void spr_read_ctr(DisasContext *ctx, int gprn, int sprn)
@@ -524,7 +524,7 @@ void spr_read_ureg(DisasContext *ctx, int gprn, int sprn)
     gen_load_spr(cpu_gpr[gprn], sprn + 0x10);
 }
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 {
     gen_store_spr(sprn + 0x10, cpu_gpr[gprn]);
@@ -533,7 +533,7 @@ void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 
 /* SPR common to all non-embedded PowerPC */
 /* DECR */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
     translator_io_start(&ctx->base);
@@ -571,7 +571,7 @@ void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
     gen_helper_load_atbu(cpu_gpr[gprn], cpu_env);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
@@ -641,7 +641,7 @@ void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 #endif
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* IBAT0U...IBAT0U */
 /* IBAT0L...IBAT7L */
 void spr_read_ibat(DisasContext *ctx, int gprn, int sprn)
@@ -776,7 +776,7 @@ void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 #endif
 
 /* PowerPC 40x specific registers */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn)
 {
     translator_io_start(&ctx->base);
@@ -837,7 +837,7 @@ void spr_write_booke_tsr(DisasContext *ctx, int sprn, int gprn)
 #endif
 
 /* PIR */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_pir(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
@@ -861,7 +861,7 @@ void spr_write_spefscr(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_st_i32(t0, cpu_env, offsetof(CPUPPCState, spe_fscr));
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* Callback used to write the exception vector base */
 void spr_write_excp_prefix(DisasContext *ctx, int sprn, int gprn)
 {
@@ -898,7 +898,7 @@ void spr_write_excp_vector(DisasContext *ctx, int sprn, int gprn)
 #endif
 
 #ifdef TARGET_PPC64
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void spr_write_amr(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
@@ -986,7 +986,7 @@ void spr_write_iamr(DisasContext *ctx, int sprn, int gprn)
 #endif
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void spr_read_thrm(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_fixup_thrm(cpu_env);
@@ -995,7 +995,7 @@ void spr_read_thrm(DisasContext *ctx, int gprn, int sprn)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_e500_l1csr0(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
@@ -1044,7 +1044,7 @@ void spr_write_epsc(DisasContext *ctx, int sprn, int gprn)
 
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_mas73(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv val = tcg_temp_new();
@@ -1106,7 +1106,7 @@ void spr_write_prev_upper32(DisasContext *ctx, int sprn, int gprn)
     gen_store_spr(sprn - 1, spr);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv hmer = tcg_temp_new();
@@ -1121,7 +1121,7 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
 }
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
 
 void spr_read_tar(DisasContext *ctx, int gprn, int sprn)
 {
@@ -2201,7 +2201,7 @@ GEN_LOGICAL2(nand, tcg_gen_nand_tl, 0x0E, PPC_INTEGER);
 /* nor & nor. */
 GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_constant_i32(0);
@@ -2250,7 +2250,7 @@ static void gen_or(DisasContext *ctx)
             /* Set process priority to normal */
             prio = 4;
             break;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         case 31:
             if (!ctx->pr) {
                 /* Set process priority to very low */
@@ -2286,7 +2286,7 @@ static void gen_or(DisasContext *ctx)
             tcg_gen_ori_tl(t0, t0, ((uint64_t)prio) << 50);
             gen_store_spr(SPR_PPR, t0);
         }
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         /*
          * Pause out of TCG otherwise spin loops with smt_low eat too
          * much CPU and the kernel hangs.  This applies to all
@@ -3101,7 +3101,7 @@ static void glue(gen_qemu_, stop)(DisasContext *ctx,                    \
     tcg_gen_qemu_st_tl(val, addr, ctx->mem_idx, op);                    \
 }
 
-#if defined(TARGET_PPC64) || !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) || defined(CONFIG_SOFTMMU)
 GEN_QEMU_STORE_TL(st8,  DEF_MEMOP(MO_UB))
 #endif
 GEN_QEMU_STORE_TL(st16, DEF_MEMOP(MO_UW))
@@ -3420,7 +3420,7 @@ static void gen_eieio(DisasContext *ctx)
     tcg_gen_mb(bar | TCG_BAR_SC);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 {
     TCGv_i32 t;
@@ -4041,7 +4041,7 @@ static void pmu_count_insns(DisasContext *ctx)
         return;
     }
 
- #if !defined(CONFIG_USER_ONLY)
+ #if defined(CONFIG_SOFTMMU)
     TCGLabel *l;
     TCGv t0;
 
@@ -4082,7 +4082,7 @@ static void pmu_count_insns(DisasContext *ctx)
     gen_load_spr(t0, SPR_POWER_PMC5);
     tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
     gen_store_spr(SPR_POWER_PMC5, t0);
-  #endif /* #if !defined(CONFIG_USER_ONLY) */
+  #endif /* #if defined(CONFIG_SOFTMMU) */
 }
 #else
 static void pmu_count_insns(DisasContext *ctx)
@@ -4386,7 +4386,7 @@ static void gen_rfid(DisasContext *ctx)
 #endif
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static void gen_rfscv(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -4431,7 +4431,7 @@ static void gen_sc(DisasContext *ctx)
 }
 
 #if defined(TARGET_PPC64)
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static void gen_scv(DisasContext *ctx)
 {
     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
@@ -4712,7 +4712,7 @@ static void gen_mtmsrd(DisasContext *ctx)
 
     CHK_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     TCGv t0, t1;
     target_ulong mask;
 
@@ -4744,7 +4744,7 @@ static void gen_mtmsrd(DisasContext *ctx)
 
     /* Must stop the translation as machine state (may have) changed */
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* defined(CONFIG_SOFTMMU) */
 }
 #endif /* defined(TARGET_PPC64) */
 
@@ -4752,7 +4752,7 @@ static void gen_mtmsr(DisasContext *ctx)
 {
     CHK_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     TCGv t0, t1;
     target_ulong mask = 0xFFFFFFFF;
 
@@ -6208,7 +6208,7 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
         }                                               \
     } while (0)
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #define REQUIRE_SV(CTX)             \
     do {                            \
         if (unlikely((CTX)->pr)) {  \
@@ -6466,7 +6466,7 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
 GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..29c2ea477f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -257,7 +257,7 @@ static void set_vext_version(CPURISCVState *env, int vext_ver)
     env->vext_ver = vext_ver;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
     if (!strncmp(satp_mode_str, "mbare", 5)) {
@@ -349,7 +349,7 @@ static void riscv_any_cpu_init(Object *obj)
     set_misa(env, MXL_RV64, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj),
         riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
         VM_1_10_SV32 : VM_1_10_SV57);
@@ -367,7 +367,7 @@ static void rv64_base_cpu_init(Object *obj)
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     set_priv_version(env, PRIV_VERSION_1_12_0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
@@ -377,7 +377,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, MXL_RV64, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
 #endif
 }
@@ -390,7 +390,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
     set_misa(env, MXL_RV64, RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     cpu->cfg.mmu = false;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
 }
@@ -417,7 +417,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.ext_xtheadsync = true;
 
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
 #endif
 }
@@ -454,7 +454,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.marchid = VEYRON_V1_MARCHID;
     cpu->cfg.mimpid = VEYRON_V1_MIMPID;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_SV48);
 #endif
 }
@@ -473,7 +473,7 @@ static void rv128_base_cpu_init(Object *obj)
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     set_priv_version(env, PRIV_VERSION_1_12_0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
@@ -486,7 +486,7 @@ static void rv32_base_cpu_init(Object *obj)
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     set_priv_version(env, PRIV_VERSION_1_12_0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #endif
 }
@@ -496,7 +496,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #endif
 }
@@ -509,7 +509,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     cpu->cfg.mmu = false;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
 }
@@ -522,7 +522,7 @@ static void rv32_ibex_cpu_init(Object *obj)
     set_misa(env, MXL_RV32, RVI | RVM | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_11_0);
     cpu->cfg.mmu = false;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
     cpu->cfg.epmp = true;
@@ -536,7 +536,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     cpu->cfg.mmu = false;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
 }
@@ -579,13 +579,13 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     CPURISCVState *env = &cpu->env;
     int i;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
     }
 #endif
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     {
         static const int dump_csrs[] = {
             CSR_MHARTID,
@@ -705,7 +705,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
 
 static bool riscv_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     /*
@@ -736,7 +736,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 
 static void riscv_cpu_reset_hold(Object *obj)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint8_t iprio;
     int i, irq, rdzero;
 #endif
@@ -748,7 +748,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj);
     }
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     env->misa_mxl = env->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
@@ -804,7 +804,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->cfg.debug) {
         riscv_trigger_init(env);
     }
@@ -1087,7 +1087,7 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
@@ -1158,7 +1158,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 
 static void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     Error *local_err = NULL;
 
     riscv_cpu_satp_mode_finalize(cpu, &local_err);
@@ -1223,7 +1223,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (isa_ext_is_enabled(cpu, &isa_edata_arr[i]) &&
             (env->priv_ver < isa_edata_arr[i].min_version)) {
             isa_ext_update_enabled(cpu, &isa_edata_arr[i], false);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
                         isa_edata_arr[i].name, env->mhartid);
@@ -1245,7 +1245,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
     }
@@ -1273,7 +1273,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (cpu->cfg.pmu_num) {
         if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
             cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
@@ -1296,7 +1296,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -1417,7 +1417,7 @@ static void riscv_cpu_init(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     qdev_init_gpio_in(DEVICE(cpu), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
@@ -1624,7 +1624,7 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     riscv_add_satp_mode_properties(obj);
 #endif
 }
@@ -1636,7 +1636,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_UINT64("marchid", RISCVCPU, cfg.marchid, RISCV_CPU_MARCHID),
     DEFINE_PROP_UINT64("mimpid", RISCVCPU, cfg.mimpid, RISCV_CPU_MIMPID),
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
 
@@ -1682,7 +1682,7 @@ static const char *riscv_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
     return NULL;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static int64_t riscv_get_arch_id(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -1698,7 +1698,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .legacy_vmsd = &vmstate_riscv_cpu,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -1707,7 +1707,7 @@ static const struct TCGCPUOps riscv_tcg_ops = {
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .do_interrupt = riscv_cpu_do_interrupt,
@@ -1716,7 +1716,7 @@ static const struct TCGCPUOps riscv_tcg_ops = {
     .debug_excp_handler = riscv_cpu_debug_excp_handler,
     .debug_check_breakpoint = riscv_cpu_debug_check_breakpoint,
     .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
@@ -1742,7 +1742,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_num_core_regs = 33;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &riscv_sysemu_ops;
     cc->get_arch_id = riscv_get_arch_id;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 56381aaf26..4daf98f792 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,7 +37,7 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
-#else
+#else /* CONFIG_SOFTMMU */
     bool virt = env->virt_enabled;
     int mode = env->priv;
 
@@ -58,7 +58,7 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
     }
 
     return mode | (virt ? MMU_2STAGE_BIT : 0);
-#endif
+#endif /* CONFIG_SOFTMMU */
 }
 
 void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
@@ -103,7 +103,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
-#else
+#else /* CONFIG_SOFTMMU */
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= cpu_mmu_index(env, 0);
@@ -123,7 +123,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     if (cpu->cfg.debug && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
-#endif
+#endif /* CONFIG_SOFTMMU */
 
     flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
@@ -145,7 +145,7 @@ void riscv_cpu_update_mask(CPURISCVState *env)
      * TODO: Current RVJ spec does not specify
      * how the extension interacts with XLEN.
      */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (riscv_has_ext(env, RVJ)) {
         switch (env->priv) {
         case PRV_M:
@@ -170,7 +170,7 @@ void riscv_cpu_update_mask(CPURISCVState *env)
             g_assert_not_reached();
         }
     }
-#endif
+#endif /* CONFIG_SOFTMMU */
     if (env->xl == MXL_RV32) {
         env->cur_pmmask = mask & UINT32_MAX;
         env->cur_pmbase = base & UINT32_MAX;
@@ -180,7 +180,7 @@ void riscv_cpu_update_mask(CPURISCVState *env)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 /*
  * The HS-mode is allowed to configure priority only for the
@@ -1574,7 +1574,7 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
 
     return xinsn;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /*
  * Handle Traps
@@ -1584,7 +1584,7 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1778,6 +1778,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
-#endif
+#endif /* CONFIG_SOFTMMU */
     cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..28faf88b4e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -42,7 +42,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 }
 
 /* Predicates */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
 {
     bool virt = env->virt_enabled;
@@ -77,7 +77,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
 
 static RISCVException fs(CPURISCVState *env, int csrno)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (!env->debugger && !riscv_cpu_fp_enabled(env) &&
         !riscv_cpu_cfg(env)->ext_zfinx) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -89,7 +89,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
 static RISCVException vs(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->ext_zve32f) {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
             return RISCV_EXCP_ILLEGAL_INST;
         }
@@ -101,7 +101,7 @@ static RISCVException vs(CPURISCVState *env, int csrno)
 
 static RISCVException ctr(CPURISCVState *env, int csrno)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     RISCVCPU *cpu = env_archcpu(env);
     int ctr_index;
     target_ulong ctr_mask;
@@ -166,7 +166,7 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_JVT);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
@@ -176,7 +176,7 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
     int pmu_num = riscv_cpu_cfg(env)->pmu_num;
@@ -544,7 +544,7 @@ static RISCVException seed(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->debugger) {
         return RISCV_EXCP_NONE;
     }
@@ -591,7 +591,7 @@ static RISCVException read_fflags(CPURISCVState *env, int csrno,
 static RISCVException write_fflags(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (riscv_has_ext(env, RVF)) {
         env->mstatus |= MSTATUS_FS;
     }
@@ -610,7 +610,7 @@ static RISCVException read_frm(CPURISCVState *env, int csrno,
 static RISCVException write_frm(CPURISCVState *env, int csrno,
                                 target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (riscv_has_ext(env, RVF)) {
         env->mstatus |= MSTATUS_FS;
     }
@@ -630,7 +630,7 @@ static RISCVException read_fcsr(CPURISCVState *env, int csrno,
 static RISCVException write_fcsr(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (riscv_has_ext(env, RVF)) {
         env->mstatus |= MSTATUS_FS;
     }
@@ -681,7 +681,7 @@ static RISCVException read_vxrm(CPURISCVState *env, int csrno,
 static RISCVException write_vxrm(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->mstatus |= MSTATUS_VS;
 #endif
     env->vxrm = val;
@@ -698,7 +698,7 @@ static RISCVException read_vxsat(CPURISCVState *env, int csrno,
 static RISCVException write_vxsat(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->mstatus |= MSTATUS_VS;
 #endif
     env->vxsat = val;
@@ -715,7 +715,7 @@ static RISCVException read_vstart(CPURISCVState *env, int csrno,
 static RISCVException write_vstart(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->mstatus |= MSTATUS_VS;
 #endif
     /*
@@ -734,7 +734,7 @@ static int read_vcsr(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->mstatus |= MSTATUS_VS;
 #endif
     env->vxrm = (val & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
@@ -748,7 +748,7 @@ static target_ulong get_ticks(bool shift)
     int64_t val;
     target_ulong result;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (icount_enabled()) {
         val = icount_get();
     } else {
@@ -794,7 +794,7 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }
 
-#else /* CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 
 static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -3853,7 +3853,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
         return ret;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     int csr_priv, effective_priv = env->priv;
 
     if (riscv_has_ext(env, RVH) && env->priv == PRV_S &&
@@ -4012,11 +4012,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
                                  target_ulong write_mask)
 {
     RISCVException ret;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->debugger = true;
 #endif
     ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->debugger = false;
 #endif
     return ret;
@@ -4072,7 +4072,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
                         write_mhpmcounter                    },
@@ -4718,5 +4718,5 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
                              .min_priv_ver = PRIV_VERSION_1_12_0 },
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 524bede865..75ed0adc24 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -201,7 +201,7 @@ static int riscv_gdb_get_virtual(CPURISCVState *cs, GByteArray *buf, int n)
 static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
 {
     if (n == 0) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         cs->priv = ldtul_p(mem_buf) & 0x3;
         if (cs->priv == PRV_RESERVED) {
             cs->priv = PRV_S;
@@ -221,7 +221,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
     int bitsize = 16 << env->misa_mxl_max;
     int i;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->debugger = true;
 #endif
 
@@ -254,7 +254,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
 
     cpu->dyn_csr_xml = g_string_free(s, false);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     env->debugger = false;
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f563dc3981..8eeaf113eb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -136,7 +136,7 @@ target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
 static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
                                 uintptr_t ra)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if ((env->priv < PRV_M) && !get_field(env->menvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
@@ -150,7 +150,7 @@ static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
     if ((env->priv < PRV_S) && !get_field(env->senvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
-#endif
+#endif /* CONFIG_SOFTMMU */
 }
 
 void helper_cbo_zero(CPURISCVState *env, target_ulong address)
@@ -259,7 +259,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 target_ulong helper_sret(CPURISCVState *env)
 {
@@ -541,4 +541,4 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 933b11c50d..a51a887917 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -267,7 +267,7 @@ static void gen_exception_inst_addr_mis(DisasContext *ctx)
 
 static void lookup_and_goto_ptr(DisasContext *ctx)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (ctx->itrigger) {
         gen_helper_itrigger_match(cpu_env);
     }
@@ -277,7 +277,7 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
 
 static void exit_tb(DisasContext *ctx)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (ctx->itrigger) {
         gen_helper_itrigger_match(cpu_env);
     }
@@ -599,7 +599,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     return addr;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * We will have already diagnosed disabled state,
  * and need to turn initial/clean into dirty.
@@ -632,7 +632,7 @@ static void mark_fs_dirty(DisasContext *ctx)
 static inline void mark_fs_dirty(DisasContext *ctx) { }
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * We will have already diagnosed disabled state,
  * and need to turn initial/clean into dirty.
@@ -1241,13 +1241,13 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 static void riscv_tr_disas_log(const DisasContextBase *dcbase,
                                CPUState *cpu, FILE *logfile)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     RISCVCPU *rvcpu = RISCV_CPU(cpu);
     CPURISCVState *env = &rvcpu->env;
 #endif
 
     fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     fprintf(logfile, "Priv: "TARGET_FMT_ld"; Virt: %d\n",
             env->priv, env->virt_enabled);
 #endif
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index b433bda16d..8ac62e8342 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -25,7 +25,7 @@
 target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 {
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_JVT);
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, 0);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 157e57da0f..582456dbb1 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,13 +192,13 @@ static void rx_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -208,10 +208,10 @@ static const struct TCGCPUOps rx_tcg_ops = {
     .restore_state_to_opc = rx_restore_state_to_opc,
     .tlb_fill = rx_cpu_tlb_fill,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .do_interrupt = rx_cpu_do_interrupt,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, void *data)
@@ -232,7 +232,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &rx_sysemu_ops;
 #endif
     cc->gdb_read_register = rx_cpu_gdb_read_register;
diff --git a/target/rx/helper.c b/target/rx/helper.c
index dad5fb4976..8950b22c47 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -40,7 +40,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 #define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
@@ -149,4 +149,4 @@ hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return addr;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index ffa9e94d84..44694ac776 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -66,7 +66,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     for (i = 0; i < 16; i++) {
         qemu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
         if ((i % 4) == 3) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index df167493c3..ec9b955b50 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -34,14 +34,14 @@
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
 #include "sysemu/tcg.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "sysemu/reset.h"
 #endif
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
     if (mask & PSW_MASK_RESERVED) {
@@ -63,7 +63,7 @@ static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint64_t old_mask = env->psw.mask;
 #endif
 
@@ -76,7 +76,7 @@ void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
     }
     env->cc_op = (mask >> 44) & 3;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (is_early_exception_psw(mask, addr)) {
         env->int_pgm_ilen = 0;
         trigger_pgm_exception(env, PGM_SPECIFICATION);
@@ -237,7 +237,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (!s390_cpu_realize_sysemu(dev, &err)) {
         goto out;
     }
@@ -248,7 +248,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     qemu_register_reset(s390_cpu_machine_reset_cb, S390_CPU(dev));
 #endif
     s390_cpu_gdb_init(cs);
@@ -279,7 +279,7 @@ static void s390_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
     cs->exception_index = EXCP_HLT;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     s390_cpu_init_sysemu(obj);
 #endif
 }
@@ -290,7 +290,7 @@ static gchar *s390_gdb_arch_name(CPUState *cs)
 }
 
 static Property s390x_cpu_properties[] = {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
 #endif
     DEFINE_PROP_END_OF_LIST()
@@ -312,13 +312,13 @@ static const struct TCGCPUOps s390_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
     .record_sigbus = s390_cpu_record_sigbus,
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
     .tlb_fill = s390_cpu_tlb_fill,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 #endif /* CONFIG_TCG */
 
@@ -344,7 +344,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = s390_cpu_get_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     s390_cpu_class_init_sysemu(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
@@ -366,9 +366,9 @@ static const TypeInfo s390_cpu_type_info = {
     .instance_align = __alignof__(S390CPU),
     .instance_init = s390_cpu_initfn,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .instance_finalize = s390_cpu_finalize,
-#endif /* !CONFIG_USER_ONLY */
+#endif
 
     .abstract = true,
     .class_size = sizeof(S390CPUClass),
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 2e4e11d264..ec24137b1a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/s390x/pv.h"
 #endif
 
@@ -109,7 +109,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!s390_is_pv()) {
         return;
     }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 457b5cb10c..d3707ebefb 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "qemu/hw-version.h"
 #include "qemu/qemu-print.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "sysemu/sysemu.h"
 #include "hw/s390x/pv.h"
 #endif
@@ -237,7 +237,7 @@ bool s390_has_feat(S390Feat feat)
         return 0;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (s390_is_pv()) {
         switch (feat) {
         case S390_FEAT_DIAG_318:
@@ -519,7 +519,7 @@ static void check_compatibility(const S390CPUModel *max_model,
         return;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
         error_setg(errp, "The unpack facility is not compatible with "
                    "the --only-migratable option. You must remove either "
@@ -604,7 +604,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 
     apply_cpu_model(cpu->model, errp);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
         /* basic mode, write the cpu address into the first 4 bit of the ID */
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 6fbfd41bc8..4dd641c676 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -175,7 +175,7 @@ static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-cr.xml */
 #define S390_NUM_C_REGS 16
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
@@ -336,7 +336,7 @@ void s390_cpu_gdb_init(CPUState *cs)
                              cpu_write_gs_reg,
                              S390_NUM_GS_REGS, "s390-gs.xml", 0);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gdb_register_coprocessor(cs, cpu_read_c_reg,
                              cpu_write_c_reg,
                              S390_NUM_C_REGS, "s390-cr.xml", 0);
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 5195f060ec..5ab796e261 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -16,7 +16,7 @@
 #include "sysemu/tcg.h"
 #include "hw/s390x/ioinst.h"
 #include "tcg/tcg_s390x.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/s390x/s390_flic.h"
 #endif
 
@@ -41,7 +41,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void cpu_inject_clock_comparator(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
@@ -229,7 +229,7 @@ bool s390_cpu_has_stop_int(S390CPU *cpu)
 
 bool s390_cpu_has_int(S390CPU *cpu)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!tcg_enabled()) {
         return false;
     }
diff --git a/target/s390x/tcg/cc_helper.c b/target/s390x/tcg/cc_helper.c
index b36f8cdc8b..62640ac5a9 100644
--- a/target/s390x/tcg/cc_helper.c
+++ b/target/s390x/tcg/cc_helper.c
@@ -476,7 +476,7 @@ uint32_t HELPER(calc_cc)(CPUS390XState *env, uint32_t cc_op, uint64_t src,
     return do_calc_cc(env, cc_op, src, dst, vr);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void HELPER(load_psw)(CPUS390XState *env, uint64_t mask, uint64_t addr)
 {
     s390_cpu_set_psw(env, mask, addr);
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 228aa9f237..f68b47d58d 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -26,7 +26,7 @@
 #include "exec/cpu_ldst.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
 #include "hw/s390x/ioinst.h"
@@ -50,7 +50,7 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
                                         uintptr_t ra)
 {
     g_assert(dxc <= 0xff);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Store the DXC into the lowcore */
     stl_phys(env_cpu(env)->as,
              env->psa + offsetof(LowCore, data_exc_code), dxc);
@@ -67,7 +67,7 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
                                           uintptr_t ra)
 {
     g_assert(vxc <= 0xff);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
     stl_phys(env_cpu(env)->as,
              env->psa + offsetof(LowCore, data_exc_code), vxc);
@@ -127,7 +127,7 @@ void s390_cpu_record_sigbus(CPUState *cs, vaddr address,
     do_unaligned_access(cs, retaddr);
 }
 
-#else /* !CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY  = CONFIG_SOFTMMU*/
 
 static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
 {
@@ -646,4 +646,4 @@ void HELPER(monitor_call)(CPUS390XState *env, uint64_t monitor_code,
     }
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index d02ec861d8..8dc4ea7e5f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -31,7 +31,7 @@
 #include "qemu/atomic128.h"
 #include "trace.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/s390x/storage-keys.h"
 #include "hw/boards.h"
 #endif
@@ -160,7 +160,7 @@ static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
 #endif
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (unlikely(flags & TLB_WATCHPOINT)) {
         /* S390 does not presently use transaction attributes. */
         cpu_check_watchpoint(env_cpu(env), addr, size,
@@ -924,7 +924,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
     access_memmove(env, &desta, &srca, ra);
     return 0; /* data moved */
 inject_exc:
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (exc != PGM_ADDRESSING) {
         stq_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, trans_exc_code),
                  env->tlb_fill_tec);
@@ -1904,7 +1904,7 @@ uint32_t HELPER(csst_parallel)(CPUS390XState *env, uint32_t r3, uint64_t a1,
     return do_csst(env, r3, a1, a2, true);
 }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 576157b1f3..8e27bdb621 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -32,7 +32,7 @@
 #include "tcg_s390x.h"
 #include "s390-tod.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
@@ -98,7 +98,7 @@ uint64_t HELPER(stck)(CPUS390XState *env)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /* SCLP service call */
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
@@ -430,7 +430,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = env_archcpu(env);
@@ -592,7 +592,7 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void HELPER(per_check_exception)(CPUS390XState *env)
 {
     if (env->per_perc_atmid) {
@@ -676,7 +676,7 @@ static void prepare_stfl(void)
     initialized = true;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void HELPER(stfl)(CPUS390XState *env)
 {
     LowCore *lowcore;
@@ -715,7 +715,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     return count_bytes >= max_bytes ? 0 : 3;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 /*
  * Note: we ignore any return code of the functions called for the pci
  * instructions, as the only time they return !0 is when the stub is
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 7c549cd8d0..bfd4b7d528 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -346,7 +346,7 @@ static void update_psw_addr(DisasContext *s)
 
 static void per_branch(DisasContext *s, bool to_next)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_gen_movi_i64(gbea, s->base.pc_next);
 
     if (s->base.tb->flags & FLAG_MASK_PER) {
@@ -359,7 +359,7 @@ static void per_branch(DisasContext *s, bool to_next)
 static void per_branch_cond(DisasContext *s, TCGCond cond,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGLabel *lab = gen_new_label();
         tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
@@ -2178,7 +2178,7 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 {
     MemOp mop = s->insn->data;
@@ -2296,7 +2296,7 @@ static DisasJumpType op_cuXX(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_constant_i32(get_field(s, r1));
@@ -2555,7 +2555,7 @@ static DisasJumpType op_ipm(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_idte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
@@ -2903,7 +2903,7 @@ static DisasJumpType op_loc(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_lctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_constant_i32(get_field(s, r1));
@@ -3134,7 +3134,7 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_tl(o->out, o->in2, MMU_REAL_IDX, s->insn->data);
@@ -3174,7 +3174,7 @@ static DisasJumpType op_mc(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     gen_helper_monitor_call(cpu_env, o->addr1,
                             tcg_constant_i32(monitor_class));
 #endif
@@ -3316,7 +3316,7 @@ static DisasJumpType op_mvcos(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, l1);
@@ -3621,7 +3621,7 @@ static DisasJumpType op_popcnt(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_ptlb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ptlb(cpu_env);
@@ -3809,7 +3809,7 @@ static DisasJumpType op_rll64(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 {
     gen_helper_rrbe(cc_op, cpu_env, o->in2);
@@ -3902,7 +3902,7 @@ static DisasJumpType op_sqxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_servc(DisasContext *s, DisasOps *o)
 {
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
@@ -4083,7 +4083,7 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 {
     tcg_gen_shri_i64(o->in2, o->in2, 4);
@@ -4158,7 +4158,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
     gen_helper_sck(cc_op, cpu_env, o->in2);
@@ -4661,7 +4661,7 @@ static DisasJumpType op_tcxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 static DisasJumpType op_testblock(DisasContext *s, DisasOps *o)
 {
@@ -4911,7 +4911,7 @@ static DisasJumpType op_zero2(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r2 = tcg_constant_i32(get_field(s, r2));
@@ -5340,7 +5340,7 @@ static void wout_m1_16(DisasContext *s, DisasOps *o)
 }
 #define SPEC_wout_m1_16 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void wout_m1_16a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
@@ -5354,7 +5354,7 @@ static void wout_m1_32(DisasContext *s, DisasOps *o)
 }
 #define SPEC_wout_m1_32 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void wout_m1_32a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
@@ -5368,7 +5368,7 @@ static void wout_m1_64(DisasContext *s, DisasOps *o)
 }
 #define SPEC_wout_m1_64 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void wout_m1_64a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEUQ | MO_ALIGN);
@@ -5857,7 +5857,7 @@ static void in2_m2_32u(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_m2_32u 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
@@ -5881,7 +5881,7 @@ static void in2_m2_64w(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_m2_64w 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void in2_m2_64a(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
@@ -5966,7 +5966,7 @@ static void in2_i2_32u_shl(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_i2_32u_shl 0
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void in2_insn(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_constant_i64(s->fields.raw_insn);
@@ -6297,7 +6297,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
         goto out;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGv_i64 addr = tcg_constant_i64(s->base.pc_next);
         gen_helper_per_ifetch(cpu_env, addr);
@@ -6397,7 +6397,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
         ret = DISAS_TOO_MANY;
     }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (s->base.tb->flags & FLAG_MASK_PER) {
         /* An exception might be triggered, save PSW if not already done.  */
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 61769ffdfa..393df9f1d6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -67,7 +67,7 @@ static void superh_restore_state_to_opc(CPUState *cs,
      */
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool superh_io_recompile_replay_branch(CPUState *cs,
                                               const TranslationBlock *tb)
 {
@@ -244,7 +244,7 @@ static void superh_cpu_initfn(Object *obj)
     env->movcal_backup_tail = &(env->movcal_backup);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static const VMStateDescription vmstate_sh_cpu = {
     .name = "cpu",
     .unmigratable = 1,
@@ -255,7 +255,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 static const struct SysemuCPUOps sh4_sysemu_ops = {
     .get_phys_page_debug = superh_cpu_get_phys_page_debug,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -264,13 +264,13 @@ static const struct TCGCPUOps superh_tcg_ops = {
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 
 static void superh_cpu_class_init(ObjectClass *oc, void *data)
@@ -293,7 +293,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_pc = superh_cpu_get_pc;
     cc->gdb_read_register = superh_cpu_gdb_read_register;
     cc->gdb_write_register = superh_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &sh4_sysemu_ops;
     dc->vmsd = &vmstate_sh_cpu;
 #endif
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index e02e7af607..9691344e26 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/log.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 #include "hw/sh4/sh_intc.h"
 #include "sysemu/runstate.h"
 #endif
@@ -51,7 +51,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
     return !(addr & 0x80000000);
 }
 
-#else /* !CONFIG_USER_ONLY */
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 
 void superh_cpu_do_interrupt(CPUState *cs)
 {
@@ -860,4 +860,4 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
     cpu_loop_exit_restore(cs, retaddr);
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index a663335c39..272b5304dc 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -23,7 +23,7 @@
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e329a7aece..8f8924a0ec 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -80,7 +80,7 @@ static void sparc_cpu_reset_hold(Object *obj)
     env->cache_control = 0;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -100,7 +100,7 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
@@ -861,14 +861,14 @@ static Property sparc_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -878,13 +878,13 @@ static const struct TCGCPUOps sparc_tcg_ops = {
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 };
 #endif /* CONFIG_TCG */
 
@@ -906,14 +906,14 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->parse_features = sparc_cpu_parse_features;
     cc->has_work = sparc_cpu_has_work;
     cc->dump_state = sparc_cpu_dump_state;
-#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_SPARC64) && defined(CONFIG_SOFTMMU)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
 #endif
     cc->set_pc = sparc_cpu_set_pc;
     cc->get_pc = sparc_cpu_get_pc;
     cc->gdb_read_register = sparc_cpu_gdb_read_register;
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &sparc_sysemu_ops;
 #endif
     cc->disas_set_info = cpu_sparc_disas_set_info;
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index c4358bba84..e4328535ef 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -51,14 +51,14 @@ void helper_debug(CPUSPARCState *env)
 #ifdef TARGET_SPARC64
 void helper_tick_set_count(void *opaque, uint64_t count)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     cpu_tick_set_count(opaque, count);
 #endif
 }
 
 uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     CPUTimer *timer = opaque;
 
     if (timer->npt && mem_idx < MMU_KERNEL_IDX) {
@@ -75,7 +75,7 @@ uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
 
 void helper_tick_set_limit(void *opaque, uint64_t limit)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     cpu_tick_set_limit(opaque, limit);
 #endif
 }
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 82e8418e46..2dbf843a99 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -137,7 +137,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #endif
         count++;
     }
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->psret == 0) {
         if (cs->exception_index == 0x80 &&
             env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
@@ -162,7 +162,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     env->npc = env->pc + 4;
     cs->exception_index = -1;
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* IRQ acknowledgment */
     if ((intno & ~15) == TT_EXTINT && env->qemu_irq_ack != NULL) {
         env->qemu_irq_ack(env, env->irq_manager, intno);
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 793e57c536..b9dd16cc6c 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -180,7 +180,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         count++;
     }
 #endif
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (env->tl >= env->maxtl) {
         cpu_abort(cs, "Trap 0x%04x while trap level (%d) >= MAXTL (%d),"
                   " Error state", cs->exception_index, env->tl, env->maxtl);
@@ -270,7 +270,7 @@ static bool do_modify_softint(CPUSPARCState *env, uint32_t value)
 {
     if (env->softint != value) {
         env->softint = value;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
         if (cpu_interrupts_enabled(env)) {
             qemu_mutex_lock_iothread();
             cpu_check_irqs(env);
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 981a47d8bb..487f4bafeb 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -69,7 +69,7 @@
 #define QT0 (env->qt0)
 #define QT1 (env->qt1)
 
-#if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_SPARC64) && defined(CONFIG_SOFTMMU)
 /* Calculates TSB pointer value for fault page size
  * UltraSPARC IIi has fixed sizes (8k or 64k) for the page pointers
  * UA2005 holds the page size configuration in mmu_ctx registers */
@@ -343,7 +343,7 @@ static inline target_ulong asi_address_mask(CPUSPARCState *env,
     return addr;
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
 {
     /* ASIs >= 0x80 are user mode.
@@ -357,7 +357,7 @@ static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
         cpu_raise_exception_ra(env, TT_PRIV_ACT, ra);
     }
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 #endif
 
 static void do_check_align(CPUSPARCState *env, target_ulong addr,
@@ -373,7 +373,7 @@ void helper_check_align(CPUSPARCState *env, target_ulong addr, uint32_t align)
     do_check_align(env, addr, align, GETPC());
 }
 
-#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY) &&   \
+#if !defined(TARGET_SPARC64) && defined(CONFIG_SOFTMMU) &&   \
     defined(DEBUG_MXCC)
 static void dump_mxcc(CPUSPARCState *env)
 {
@@ -392,7 +392,7 @@ static void dump_mxcc(CPUSPARCState *env)
 }
 #endif
 
-#if (defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY))     \
+#if (defined(TARGET_SPARC64) || defined(CONFIG_SOFTMMU))     \
     && defined(DEBUG_ASI)
 static void dump_asi(const char *txt, target_ulong addr, int asi, int size,
                      uint64_t r1)
@@ -418,7 +418,7 @@ static void dump_asi(const char *txt, target_ulong addr, int asi, int size,
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #ifndef TARGET_SPARC64
 static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
@@ -512,7 +512,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
 #endif
 
 #ifndef TARGET_SPARC64
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 
 /* Leon3 cache control */
@@ -1928,7 +1928,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 #endif /* CONFIG_USER_ONLY */
 #endif /* TARGET_SPARC64 */
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 
 void sparc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bad2ec90a0..52b745eb54 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -51,7 +51,7 @@ static TCGv_i32 cpu_psr;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static TCGv cpu_tbr;
 #endif
 static TCGv cpu_cond;
@@ -74,7 +74,7 @@ typedef struct DisasContext {
     int mem_idx;
     bool fpu_enabled;
     bool address_mask_32bit;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     bool supervisor;
 #ifdef TARGET_SPARC64
     bool hypervisor;
@@ -1564,7 +1564,7 @@ static void gen_op_fpexception_im(DisasContext *dc, int fsr_flags)
 
 static int gen_trap_ifnofpu(DisasContext *dc)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (!dc->fpu_enabled) {
         gen_exception(dc, TT_NFPU_INSN);
         return 1;
@@ -1909,7 +1909,7 @@ static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
 }
 
 /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
 typedef enum {
     GET_ASI_HELPER,
     GET_ASI_EXCP,
@@ -2202,7 +2202,7 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
         gen_address_mask(dc, addr);
         tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop | MO_ALIGN);
         break;
-#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_SPARC64) && defined(CONFIG_SOFTMMU)
     case GET_ASI_BCOPY:
         /* Copy 32 bytes from the address in SRC to ADDR.  */
         /* ??? The original qemu code suggests 4-byte alignment, dropping
@@ -2662,7 +2662,7 @@ static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-#elif !defined(CONFIG_USER_ONLY)
+#elif defined(CONFIG_SOFTMMU)
 static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 {
     /* ??? Work around an apparent bug in Ubuntu gcc 4.8.2-10ubuntu2+12,
@@ -2812,7 +2812,7 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
     gen_update_fprs_dirty(dc, qd);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env cpu_env)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
@@ -3294,7 +3294,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 default:
                     goto illegal_insn;
                 }
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
             } else if (xop == 0x29) { /* rdpsr / UA2005 rdhpr */
 #ifndef TARGET_SPARC64
                 if (!supervisor(dc)) {
@@ -3458,7 +3458,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
 #endif
-#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_SPARC64) || defined(CONFIG_SOFTMMU)
             } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(cpu_env);
@@ -4155,7 +4155,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0xf: /* V9 sir, nop if user */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
                                 if (supervisor(dc)) {
                                     ; // XXX
                                 }
@@ -4186,7 +4186,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 gen_helper_write_softint(cpu_env, cpu_tmp0);
                                 break;
                             case 0x17: /* Tick compare */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
                                 if (!supervisor(dc))
                                     goto illegal_insn;
 #endif
@@ -4206,7 +4206,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 }
                                 break;
                             case 0x18: /* System tick */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
                                 if (!supervisor(dc))
                                     goto illegal_insn;
 #endif
@@ -4226,7 +4226,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 }
                                 break;
                             case 0x19: /* System tick compare */
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
                                 if (!supervisor(dc))
                                     goto illegal_insn;
 #endif
@@ -4256,7 +4256,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             }
                         }
                         break;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
                     case 0x31: /* wrpsr, V9 saved, restored */
                         {
                             if (!supervisor(dc))
@@ -5053,7 +5053,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         dc->npc = DYNAMIC_PC;
                     }
                     goto jmp_insn;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) && !defined(TARGET_SPARC64)
                 case 0x39:      /* rett, V9 return */
                     {
                         if (!supervisor(dc))
@@ -5079,7 +5079,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     gen_helper_restore(cpu_env);
                     gen_store_gpr(dc, rd, cpu_tmp0);
                     break;
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_SPARC64)
                 case 0x3e:      /* V9 done/retry */
                     {
                         switch (rd) {
@@ -5191,7 +5191,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     gen_swap(dc, cpu_val, cpu_src1, cpu_addr,
                              dc->mem_idx, MO_TEUL);
                     break;
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
                 case 0x10:      /* lda, V9 lduwa, load word alternate */
                     gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
                     break;
@@ -5278,7 +5278,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     goto illegal_insn;
                 }
                 gen_store_gpr(dc, rd, cpu_val);
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
             skip_move: ;
 #endif
             } else if (xop >= 0x20 && xop < 0x24) {
@@ -5365,7 +5365,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                             dc->mem_idx, MO_TEUQ | MO_ALIGN);
                     }
                     break;
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
                 case 0x14: /* sta, V9 stwa, store word alternate */
                     gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
                     break;
@@ -5496,7 +5496,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 case 0x37: /* stdc */
                     goto ncp_insn;
 #endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) || defined(TARGET_SPARC64)
                 case 0x3c: /* V9 or LEON3 casa */
 #ifndef TARGET_SPARC64
                     CHECK_IU_FEATURE(dc, CASA);
@@ -5535,7 +5535,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
  unimp_flush:
     gen_exception(dc, TT_UNIMP_FLUSH);
     return;
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
  priv_insn:
     gen_exception(dc, TT_PRIV_INSN);
     return;
@@ -5543,7 +5543,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
  nfpu_insn:
     gen_op_fpexception_im(dc, FSR_FTT_UNIMPFPOP);
     return;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+#if defined(CONFIG_SOFTMMU) && !defined(TARGET_SPARC64)
  nfq_insn:
     gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
     return;
@@ -5568,13 +5568,13 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->def = &env->def;
     dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->supervisor = (dc->base.tb->flags & TB_FLAG_SUPER) != 0;
 #endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
     dc->asi = (dc->base.tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
 #endif
 #endif
@@ -5725,7 +5725,7 @@ void sparc_tcg_init(void)
         { &cpu_pc, offsetof(CPUSPARCState, pc), "pc" },
         { &cpu_npc, offsetof(CPUSPARCState, npc), "npc" },
         { &cpu_y, offsetof(CPUSPARCState, y), "y" },
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         { &cpu_tbr, offsetof(CPUSPARCState, tbr), "tbr" },
 #endif
     };
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 3a7c0ff943..0e497da708 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -87,7 +87,7 @@ void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
 void cpu_put_psr(CPUSPARCState *env, target_ulong val)
 {
     cpu_put_psr_raw(env, val);
-#if ((!defined(TARGET_SPARC64)) && !defined(CONFIG_USER_ONLY))
+#if ((!defined(TARGET_SPARC64)) && defined(CONFIG_SOFTMMU))
     cpu_check_irqs(env);
 #endif
 }
@@ -371,7 +371,7 @@ void helper_wrpstate(CPUSPARCState *env, target_ulong new_state)
 {
     cpu_change_pstate(env, new_state & 0xf3f);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (cpu_interrupts_enabled(env)) {
         qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
@@ -382,7 +382,7 @@ void helper_wrpstate(CPUSPARCState *env, target_ulong new_state)
 
 void helper_wrpil(CPUSPARCState *env, target_ulong new_pil)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     trace_win_helper_wrpil(env->psrpil, (uint32_t)new_pil);
 
     env->psrpil = new_pil;
@@ -415,7 +415,7 @@ void helper_done(CPUSPARCState *env)
 
     trace_win_helper_done(env->tl);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (cpu_interrupts_enabled(env)) {
         qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
@@ -444,7 +444,7 @@ void helper_retry(CPUSPARCState *env)
 
     trace_win_helper_retry(env->tl);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (cpu_interrupts_enabled(env)) {
         qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index acaf8c905f..2db561a29b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -35,7 +35,7 @@
 #include "qemu/module.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-clock.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #include "exec/memory.h"
 #endif
 
@@ -65,7 +65,7 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
 
 static bool xtensa_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
     return !cpu->env.runstall && cpu->env.pending_irq_level;
@@ -103,7 +103,7 @@ static void xtensa_cpu_reset_hold(Object *obj)
 
     env->pc = env->config->exception_vector[EXC_RESET0 + env->static_vectors];
     env->sregs[LITBASE] &= ~1;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     env->sregs[PS] = xtensa_option_enabled(env->config,
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
     env->pending_irq_level = 0;
@@ -125,7 +125,7 @@ static void xtensa_cpu_reset_hold(Object *obj)
     env->sregs[CONFIGID1] = env->config->configid[1];
     env->exclusive_addr = -1;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     reset_mmu(env);
     s->halted = env->runstall;
 #endif
@@ -162,7 +162,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
@@ -188,7 +188,7 @@ static void xtensa_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
     env->config = xcc->config;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     env->address_space_er = g_malloc(sizeof(*env->address_space_er));
     env->system_er = g_malloc(sizeof(*env->system_er));
     memory_region_init_io(env->system_er, obj, NULL, env, "er",
@@ -211,7 +211,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
     return XTENSA_CPU(cpu);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static const VMStateDescription vmstate_xtensa_cpu = {
     .name = "cpu",
     .unmigratable = 1,
@@ -222,7 +222,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
     .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
 };
-#endif
+#endif /* CONFIG_SOFTMMU */
 
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -231,13 +231,13 @@ static const struct TCGCPUOps xtensa_tcg_ops = {
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
+#endif
 };
 
 static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
@@ -261,7 +261,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
     cc->gdb_write_register = xtensa_cpu_gdb_write_register;
     cc->gdb_stop_before_watchpoint = true;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     cc->sysemu_ops = &xtensa_sysemu_ops;
     dc->vmsd = &vmstate_xtensa_cpu;
 #endif
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index d4823a65cd..9e4e6d3fcf 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -94,7 +94,7 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
     HELPER(exception)(env, EXC_DEBUG);
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
 {
@@ -267,4 +267,4 @@ bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index dbeb97a953..fa1df80617 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -243,7 +243,7 @@ void xtensa_cpu_list(void)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                     vaddr addr, MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr)
@@ -317,4 +317,4 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
         qemu_cpu_kick(cpu);
     }
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 1af7becc54..1a7e4e1290 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -34,7 +34,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/timer.h"
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 void HELPER(update_ccount)(CPUXtensaState *env)
 {
@@ -200,7 +200,7 @@ void HELPER(wsr_memctl)(CPUXtensaState *env, uint32_t v)
 
 uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     return address_space_ldl(env->address_space_er, addr,
                              MEMTXATTRS_UNSPECIFIED, NULL);
 #else
@@ -210,7 +210,7 @@ uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
 
 void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     address_space_stl(env->address_space_er, addr, data,
                       MEMTXATTRS_UNSPECIFIED, NULL);
 #endif
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index b7386ff0f0..dbdd550727 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -335,7 +335,7 @@ static void gen_debug_exception(DisasContext *dc, uint32_t cause)
 
 static bool gen_check_privilege(DisasContext *dc)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (!dc->cring) {
         return true;
     }
@@ -573,7 +573,7 @@ static int gen_postprocess(DisasContext *dc, int slot)
 {
     uint32_t op_flags = dc->op_flags;
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
         translator_io_start(&dc->base);
         gen_helper_check_interrupts(cpu_env);
@@ -1615,7 +1615,7 @@ static void translate_getex(DisasContext *dc, const OpcodeArg arg[],
 static void translate_icache(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 addr = tcg_temp_new_i32();
 
     tcg_gen_movi_i32(cpu_pc, dc->pc);
@@ -1627,7 +1627,7 @@ static void translate_icache(DisasContext *dc, const OpcodeArg arg[],
 static void translate_itlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 dtlb = tcg_constant_i32(par[0]);
 
     gen_helper_itlb(cpu_env, arg[0].in, dtlb);
@@ -1955,7 +1955,7 @@ static void translate_or(DisasContext *dc, const OpcodeArg arg[],
 static void translate_ptlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 dtlb = tcg_constant_i32(par[0]);
 
     tcg_gen_movi_i32(cpu_pc, dc->pc);
@@ -1966,7 +1966,7 @@ static void translate_ptlb(DisasContext *dc, const OpcodeArg arg[],
 static void translate_pptlb(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_gen_movi_i32(cpu_pc, dc->pc);
     gen_helper_pptlb(arg[0].out, cpu_env, arg[1].in);
 #endif
@@ -2124,7 +2124,7 @@ static void translate_rsr(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     translator_io_start(&dc->base);
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
@@ -2134,7 +2134,7 @@ static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rsr_ptevaddr(DisasContext *dc, const OpcodeArg arg[],
                                    const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_shri_i32(tmp, cpu_SR[EXCVADDR], 10);
@@ -2146,7 +2146,7 @@ static void translate_rsr_ptevaddr(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     static void (* const helper[])(TCGv_i32 r, TCGv_env env, TCGv_i32 a1,
                                    TCGv_i32 a2) = {
         gen_helper_rtlb0,
@@ -2161,7 +2161,7 @@ static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rptlb0(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_rptlb0(arg[0].out, cpu_env, arg[1].in);
 #endif
 }
@@ -2169,7 +2169,7 @@ static void translate_rptlb0(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rptlb1(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_rptlb1(arg[0].out, cpu_env, arg[1].in);
 #endif
 }
@@ -2295,7 +2295,7 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
 static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (semihosting_enabled(dc->cring != 0)) {
         gen_helper_simcall(cpu_env);
     }
@@ -2438,7 +2438,7 @@ static void translate_subx(DisasContext *dc, const OpcodeArg arg[],
 static void translate_waiti(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 pc = tcg_constant_i32(dc->base.pc_next);
 
     translator_io_start(&dc->base);
@@ -2449,7 +2449,7 @@ static void translate_waiti(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wtlb(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 dtlb = tcg_constant_i32(par[0]);
 
     gen_helper_wtlb(cpu_env, arg[0].in, arg[1].in, dtlb);
@@ -2459,7 +2459,7 @@ static void translate_wtlb(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wptlb(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_wptlb(cpu_env, arg[0].in, arg[1].in);
 #endif
 }
@@ -2502,7 +2502,7 @@ static void translate_wsr_acchi(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
                                    const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint32_t id = par[0] - CCOMPARE;
 
     assert(id < dc->config->nccompare);
@@ -2515,7 +2515,7 @@ static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     translator_io_start(&dc->base);
     gen_helper_wsr_ccount(cpu_env, arg[0].in);
 #endif
@@ -2524,7 +2524,7 @@ static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_dbreaka(DisasContext *dc, const OpcodeArg arg[],
                                   const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned id = par[0] - DBREAKA;
 
     assert(id < dc->config->ndbreak);
@@ -2535,7 +2535,7 @@ static void translate_wsr_dbreaka(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_dbreakc(DisasContext *dc, const OpcodeArg arg[],
                                   const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned id = par[0] - DBREAKC;
 
     assert(id < dc->config->ndbreak);
@@ -2546,7 +2546,7 @@ static void translate_wsr_dbreakc(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_ibreaka(DisasContext *dc, const OpcodeArg arg[],
                                   const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     unsigned id = par[0] - IBREAKA;
 
     assert(id < dc->config->nibreak);
@@ -2557,7 +2557,7 @@ static void translate_wsr_ibreaka(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_ibreakenable(DisasContext *dc, const OpcodeArg arg[],
                                        const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_wsr_ibreakenable(cpu_env, arg[0].in);
 #endif
 }
@@ -2565,7 +2565,7 @@ static void translate_wsr_ibreakenable(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_icount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (dc->icount) {
         tcg_gen_mov_i32(dc->next_icount, arg[0].in);
     } else {
@@ -2577,7 +2577,7 @@ static void translate_wsr_icount(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_intclear(DisasContext *dc, const OpcodeArg arg[],
                                    const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_intclear(cpu_env, arg[0].in);
 #endif
 }
@@ -2585,7 +2585,7 @@ static void translate_wsr_intclear(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_intset(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_intset(cpu_env, arg[0].in);
 #endif
 }
@@ -2593,7 +2593,7 @@ static void translate_wsr_intset(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_memctl(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_wsr_memctl(cpu_env, arg[0].in);
 #endif
 }
@@ -2601,7 +2601,7 @@ static void translate_wsr_memctl(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_mpuenb(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_wsr_mpuenb(cpu_env, arg[0].in);
 #endif
 }
@@ -2609,7 +2609,7 @@ static void translate_wsr_mpuenb(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_ps(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
         PS_UM | PS_EXCM | PS_INTLEVEL;
 
@@ -2624,7 +2624,7 @@ static void translate_wsr_ps(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_rasid(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     gen_helper_wsr_rasid(cpu_env, arg[0].in);
 #endif
 }
@@ -2643,7 +2643,7 @@ static void translate_wsr_sar(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_windowbase(DisasContext *dc, const OpcodeArg arg[],
                                      const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_gen_mov_i32(cpu_windowbase_next, arg[0].in);
 #endif
 }
@@ -2651,7 +2651,7 @@ static void translate_wsr_windowbase(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr_windowstart(DisasContext *dc, const OpcodeArg arg[],
                                       const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in,
                      (1 << dc->config->nareg / 4) - 1);
 #endif
@@ -2700,7 +2700,7 @@ static void translate_xsr_mask(DisasContext *dc, const OpcodeArg arg[],
 static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     translator_io_start(&dc->base);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3fcd0d9f32..ab11c29154 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -757,7 +757,7 @@ void tcg_register_thread(void)
 {
     tcg_ctx = &tcg_init_ctx;
 }
-#else
+#else /* !CONFIG_USER_ONLY = CONFIG_SOFTMMU */
 void tcg_register_thread(void)
 {
     TCGContext *s = g_malloc(sizeof(*s));
@@ -786,7 +786,7 @@ void tcg_register_thread(void)
 
     tcg_ctx = s;
 }
-#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
 /* pool based memory allocation */
 void *tcg_malloc_internal(TCGContext *s, int size)
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index 21ea47308b..c7b70a6e90 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #define CHECK_FPE do { \
     if ((ctx->base.tb->flags & HW_FLAGS_EUEN_FPE) == 0) { \
         generate_exception(ctx, EXCCODE_FPD); \
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..f5ff9348be 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4,7 +4,7 @@
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 #define CHECK_SXE do { \
     if ((ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0) { \
         generate_exception(ctx, EXCCODE_SXD); \
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a67..8c3d230238 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1001,7 +1001,7 @@ static void mvp_init(CPUMIPSState *env)
 //                             (0x04 << CP0MVPC0_PTC);
                              (1 << CP0MVPC0_TCA) | (0x0 << CP0MVPC0_PVPE) |
                              (0x00 << CP0MVPC0_PTC);
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     /* Usermode has no TLB support */
     env->mvp->CP0_MVPConf0 |= (env->tlb->nb_tlb << CP0MVPC0_PTLBE);
 #endif
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 211d102cf6..ff3183959f 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1052,7 +1052,7 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
     do_trap:
         gen_trap(ctx, mips32_op, rs, rt, -1, extract32(ctx->opcode, 12, 4));
         break;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     case MFC0:
     case MFC0 + 32:
         check_cp0_enabled(ctx);
@@ -1227,7 +1227,7 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
             goto pool32axf_invalid;
         }
         break;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     case 0x0d:
         switch (minor) {
         case TLBP:
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index a98dde0d2e..df6cf9d77d 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1329,7 +1329,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     case NM_P_SLTU:
         if (rd == 0) {
             /* P_DVP */
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
             TCGv t0 = tcg_temp_new();
             switch (extract32(ctx->opcode, 10, 1)) {
             case NM_DVP:
@@ -1395,7 +1395,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     case NM_MODU:
         gen_r6_muldiv(ctx, R6_OPC_MODU, rd, rs, rt);
         break;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     case NM_MFC0:
         check_cp0_enabled(ctx);
         if (rt == 0) {
@@ -2218,7 +2218,7 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_POOL32AXF_5:
         switch (extract32(ctx->opcode, 9, 7)) {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
         case NM_TLBP:
             gen_cp0(env, ctx, OPC_TLBP, 0, 0);
             break;
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index c82feedaff..72954e84c7 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 
 /*
  * Checks whether the Group A SPR (MMCR0, MMCR2, MMCRA, and the
@@ -306,4 +306,4 @@ void spr_write_PMC(DisasContext *ctx, int sprn, int gprn)
 {
     spr_write_generic(ctx, sprn, gprn);
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU) */
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index f9931b9d73..1072ce0bef 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64) && defined(CONFIG_SOFTMMU)
 
 static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
 {
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index cc7a50d579..ebbe991e24 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -33,7 +33,7 @@ static bool trans_MSGCLR(DisasContext *ctx, arg_X_rb *a)
 
     REQUIRE_HV(ctx);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (is_book3s_arch2x(ctx)) {
         gen_helper_book3s_msgclr(cpu_env, cpu_gpr[a->rb]);
     } else {
@@ -57,7 +57,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 
     REQUIRE_HV(ctx);
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     if (is_book3s_arch2x(ctx)) {
         gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
     } else {
@@ -74,7 +74,7 @@ static bool trans_MSGCLRP(DisasContext *ctx, arg_X_rb *a)
     REQUIRE_64BIT(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
     REQUIRE_SV(ctx);
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
@@ -87,7 +87,7 @@ static bool trans_MSGSNDP(DisasContext *ctx, arg_X_rb *a)
     REQUIRE_64BIT(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
     REQUIRE_SV(ctx);
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_book3s_msgsndp(cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index faa7b04bbc..166ac0cb58 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -29,7 +29,7 @@ static bool trans_SLBIE(DisasContext *ctx, arg_SLBIE *a)
     REQUIRE_INSNS_FLAGS(ctx, SLBI);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBIE(cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
@@ -43,7 +43,7 @@ static bool trans_SLBIEG(DisasContext *ctx, arg_SLBIEG *a)
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBIEG(cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
@@ -57,7 +57,7 @@ static bool trans_SLBIA(DisasContext *ctx, arg_SLBIA *a)
     REQUIRE_INSNS_FLAGS(ctx, SLBI);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBIA(cpu_env, tcg_constant_i32(a->ih));
 #else
     qemu_build_not_reached();
@@ -71,7 +71,7 @@ static bool trans_SLBIAG(DisasContext *ctx, arg_SLBIAG *a)
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBIAG(cpu_env, cpu_gpr[a->rs], tcg_constant_i32(a->l));
 #else
     qemu_build_not_reached();
@@ -85,7 +85,7 @@ static bool trans_SLBMTE(DisasContext *ctx, arg_SLBMTE *a)
     REQUIRE_INSNS_FLAGS(ctx, SEGMENT_64B);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBMTE(cpu_env, cpu_gpr[a->rb], cpu_gpr[a->rt]);
 #else
     qemu_build_not_reached();
@@ -99,7 +99,7 @@ static bool trans_SLBMFEV(DisasContext *ctx, arg_SLBMFEV *a)
     REQUIRE_INSNS_FLAGS(ctx, SEGMENT_64B);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBMFEV(cpu_gpr[a->rt], cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
@@ -113,7 +113,7 @@ static bool trans_SLBMFEE(DisasContext *ctx, arg_SLBMFEE *a)
     REQUIRE_INSNS_FLAGS(ctx, SEGMENT_64B);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_helper_SLBMFEE(cpu_gpr[a->rt], cpu_env, cpu_gpr[a->rb]);
 #else
     qemu_build_not_reached();
@@ -161,7 +161,7 @@ static bool trans_SLBSYNC(DisasContext *ctx, arg_SLBSYNC *a)
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_SV(ctx);
 
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
+#if defined(CONFIG_SOFTMMU) && defined(TARGET_PPC64)
     gen_check_tlb_flush(ctx, true);
 #else
     qemu_build_not_reached();
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 528baa1652..10910b507a 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -74,7 +74,7 @@ static bool trans_uret(DisasContext *ctx, arg_uret *a)
 
 static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     if (has_ext(ctx, RVS)) {
         decode_save_opc(ctx);
         translator_io_start(&ctx->base);
@@ -92,7 +92,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     translator_io_start(&ctx->base);
     gen_helper_mret(cpu_pc, cpu_env);
@@ -106,7 +106,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_set_pc_imm(ctx, ctx->pc_succ_insn);
     gen_helper_wfi(cpu_env);
@@ -118,7 +118,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 
 static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_tlb_flush(cpu_env);
     return true;
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 3e9322130f..3ea3936c89 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -146,7 +146,7 @@ static bool trans_hlvx_wu(DisasContext *ctx, arg_hlvx_wu *a)
 static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_hyp_gvma_tlb_flush(cpu_env);
     return true;
@@ -157,7 +157,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 static bool trans_hfence_vvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_hyp_tlb_flush(cpu_env);
     return true;
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index f3cd7d5c0b..20a88810f5 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -27,7 +27,7 @@ static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_tlb_flush(cpu_env);
     return true;
@@ -56,7 +56,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.vvma currently */
     REQUIRE_EXT(ctx, RVH);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_hyp_tlb_flush(cpu_env);
     return true;
@@ -69,7 +69,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.gvma currently */
     REQUIRE_EXT(ctx, RVH);
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     decode_save_opc(ctx);
     gen_helper_hyp_gvma_tlb_flush(cpu_env);
     return true;
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 3e13b1d74d..6b085c7a97 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -983,7 +983,7 @@ static bool trans_th_sfence_vmas(DisasContext *ctx, arg_th_sfence_vmas *a)
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     REQUIRE_PRIV_MS(ctx);
     gen_helper_tlb_flush_all(cpu_env);
     return true;
@@ -992,7 +992,7 @@ static bool trans_th_sfence_vmas(DisasContext *ctx, arg_th_sfence_vmas *a)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static void gen_th_sync_local(DisasContext *ctx)
 {
     /*
@@ -1010,7 +1010,7 @@ static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     REQUIRE_PRIV_MSU(ctx);
 
     /*
@@ -1029,7 +1029,7 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
     REQUIRE_PRIV_MSU(ctx);
 
     /*
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 29e67758ef..0305f446d2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1092,7 +1092,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* bne,pn %[xi]cc, label0 */
     cc = addr_type == TCG_TYPE_I32 ? BPCC_ICC : BPCC_XCC;
     tcg_out_bpcc0(s, COND_NE, BPCC_PN | cc, 0);
-#else
+#else /* !CONFIG_SOFTMMU = CONFIG_USER_ONLY */
     /*
      * If the size equals the required alignment, we can skip the test
      * and allow host SIGBUS to deliver SIGBUS to the guest.
@@ -1113,7 +1113,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_bpcc0(s, COND_NE, BPCC_PN | BPCC_ICC, 0);
     }
     h->base = guest_base ? TCG_GUEST_BASE_REG : TCG_REG_G0;
-#endif
+#endif /* CONFIG_USER_ONLY */
 
     /* If the guest address must be zero-extended, do in the delay slot.  */
     if (addr_type == TCG_TYPE_I32) {
-- 
2.38.1


