Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43877D3C1
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ap-00054D-4x; Tue, 15 Aug 2023 15:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0An-00052m-7F
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Aj-00012k-Tt
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68859ba3a93so602386b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129464; x=1692734264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Hu8xuNnDAHTDqTBUhJjYGuMUXSC+Qs+gzIxHF/zrlE=;
 b=AYYBe0lfD2Lt/zch4WP35v/tZhp5fIfxxeuHsd0sBQlMeHGKkDw2SMK9qaq2+yF2K+
 pKkhtcb0eaU05uAMNrBHpbBE2ZSzrrqQ4mX2e7VS+s8swV86cUkvvlFrh0ccva/JBXOD
 uwOwWx9Yvh4CZUk5pP9Uiyb5IBDxh+kqciuZTmiDh1wJC/Ck2jeUYZed8/ihX5IbPVl2
 qT2rZHZnoUNLUT0250meCGF0SsQqhNRW8zX4lp9oXkADLyTW6/3QHwcWR8yTXILRGzuF
 WNpv9YYa2ByMsCBxmOjCKWXJgQYbNQIIaimIZqKJugAobLuPB9/+nxQJuY2nAse9X7hP
 Jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129464; x=1692734264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Hu8xuNnDAHTDqTBUhJjYGuMUXSC+Qs+gzIxHF/zrlE=;
 b=OPMtZmHdMx/n3vJoaBb0YpuTB+L1sot7qo3yCSCdqqYpIpbX5YN3VJ3azwQke12SMl
 mEG3fxY6fSoI9kpFzjNg00RAriFkK/+2KmQpoo5CyIhcV+i0ePDpHwRwfEJaB3EFhJ0S
 ocbHn4XdRQRHfEx5Uy6AxUIPS9oj0AcSW0vq/EQjzU1Shy1sLQLg7XqLG9Ty/HP5pa30
 zVhUbaFXomhroT4XqzaUuoW2sQo/sofs13pf4utOAxjp43eAaVb7VRZJflRDgxSEoVV7
 2f04ziRJNybpvGjNiKoWQPHvIWhHikTk42Vwd8K8vQPuVjR7lwh9xsLJvHwv2XseJmxy
 z5Yw==
X-Gm-Message-State: AOJu0Yxp7YmFDYTLZpN7rrm5Vu1dBv/B9O0PdEIXLoZOiYt5jG7wggd0
 i0EMQby/a+kMY1D/75TpzJr5dyE5kT5Qm7sPcJw=
X-Google-Smtp-Source: AGHT+IFAjbW0smhHsPKx8ZFkmLZCrJ7kaWjwsplXYPKG8f8Q0sAHANvPg2VPJ84LKwLcJp6JYseFSA==
X-Received: by 2002:a05:6a20:6a10:b0:132:cd2d:16fd with SMTP id
 p16-20020a056a206a1000b00132cd2d16fdmr13416246pzk.38.1692129464547; 
 Tue, 15 Aug 2023 12:57:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 02/14] tcg: Add tcg_out_tb_start backend hook
Date: Tue, 15 Aug 2023 12:57:29 -0700
Message-Id: <20230815195741.8325-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This hook may emit code at the beginning of the TB.

Suggested-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 3 +++
 tcg/aarch64/tcg-target.c.inc     | 5 +++++
 tcg/arm/tcg-target.c.inc         | 5 +++++
 tcg/i386/tcg-target.c.inc        | 5 +++++
 tcg/loongarch64/tcg-target.c.inc | 5 +++++
 tcg/mips/tcg-target.c.inc        | 5 +++++
 tcg/ppc/tcg-target.c.inc         | 5 +++++
 tcg/riscv/tcg-target.c.inc       | 5 +++++
 tcg/s390x/tcg-target.c.inc       | 5 +++++
 tcg/sparc64/tcg-target.c.inc     | 5 +++++
 tcg/tci/tcg-target.c.inc         | 5 +++++
 11 files changed, 53 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddfe9a96cb..1e9b7433bb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -108,6 +108,7 @@ static void tcg_register_jit_int(const void *buf, size_t size,
     __attribute__((unused));
 
 /* Forward declarations for functions declared and used in tcg-target.c.inc. */
+static void tcg_out_tb_start(TCGContext *s);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -6009,6 +6010,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->gen_insn_data =
         tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
 
+    tcg_out_tb_start(s);
+
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..8d71ac68f6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3123,6 +3123,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_insn(s, 3207, RET, TCG_REG_LR);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..7473b23672 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2951,6 +2951,11 @@ static void tcg_out_epilogue(TCGContext *s)
                   (1 << TCG_REG_R10) | (1 << TCG_REG_R11) | (1 << TCG_REG_PC));
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a6b2eae995..05581dd89d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4114,6 +4114,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc(s, OPC_RET, 0, 0, 0);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     memset(p, 0x90, count);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index baf5fc3819..29281e954b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1698,6 +1698,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_jirl(s, TCG_REG_ZERO, TCG_REG_RA, 0);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9faa8bdf0b..b4da737dbb 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2628,6 +2628,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 642d0fd128..97b7697921 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2482,6 +2482,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCLR | BO_ALWAYS);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, arg);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..22834d087b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2054,6 +2054,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static volatile sig_atomic_t got_sigill;
 
 static void sigill_handler(int signo, siginfo_t *si, void *data)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a94f7908d6..379aaef1e5 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3457,6 +3457,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_R14);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     memset(p, 0x07, count * sizeof(tcg_insn_unit));
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ffcb879211..6458ca202d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -955,6 +955,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_movi_s13(s, TCG_REG_O0, 0);
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 253f27f174..95b3352f82 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -955,6 +955,11 @@ static inline void tcg_target_qemu_prologue(TCGContext *s)
 {
 }
 
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
 bool tcg_target_has_memory_bswap(MemOp memop)
 {
     return true;
-- 
2.34.1


