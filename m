Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E97A2DAC
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1H-0006CE-Qi; Fri, 15 Sep 2023 23:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1A-00069S-L0
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:48 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM18-00086T-Ss
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:48 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-773b8a3ba70so46844485a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835046; x=1695439846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8+dnEYFnfz1946eqjp+/FLvGCV4Srz3rXe/D2r8kAY=;
 b=XZhk92XwGD4+qsHl2JMysdQT3MDw9VdPhBRhMTZUAyJqP8gg9J3girDoeGxQMSgnnX
 dIFkV8EY1C/tCSLKDHYlJruLNqC8pST8oPSHo1FEPQr//Dn/JNcDM+U2HHOZONLj5EYu
 //vVssjY9CkV9asMQmQ/10ZVxwOYjgS1Pt4D/b8uHLUh5iyDXuz+Sk1XCcMJOmekT2tu
 p2o2w63cVbu+4PH3wx30jmWu3WEL6Tf0162GAHrToT+RfOTfL+trLihmSsqnYY1ltDoM
 VjOndI6LhncCdhYFNN96ebAqZdVDHkJMSM6O8ninpM44NRFQUaYJPEhFnha1dSehBvNS
 DVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835046; x=1695439846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8+dnEYFnfz1946eqjp+/FLvGCV4Srz3rXe/D2r8kAY=;
 b=PvLQIvexdmtBynObKYI5a4knYuCoeujs9dj7n7rmyj+n2r+mPCxXXN2Ur8GmmwYT+L
 yHMe3waW5TF9CvaSHr8TcCRR1WhyNeD3WOMfr/qTUwoVa1YbJv313uF8agrAlabrOCSF
 fHNh3mWN/kgNWQ9yokNdBn9jmmsKfzFgGD8+fhuJWPpSOLC23agmsaDElfh9k5O2kWyA
 MYB7cAmFaNwiPqwEXJvjWAVxfgUM5UEWlFp6u9XWR6aBLhyF14104fYjuOkoIJKwTys/
 y4oU+SlCGnTgsmQTrCx6PbAHI5VrnCZCoJJa0P/XwqiOs7TofDVMYXCOhW4fAvkwn/W2
 lCaQ==
X-Gm-Message-State: AOJu0YwzBvcQVw4b3QjuliMLCIqiqyrVgnbpc2X1a2vGeEr0A/D8HqF6
 4E2CA4reocEsBUt98s3tmJRnFICsjNfAIqVln68=
X-Google-Smtp-Source: AGHT+IGfSGZTObYneg+fmfGyF9CzkhiLxLnMonsdg7nA9tVZ49SRFd35gYb/IFNcWkmGlWdafBjE7A==
X-Received: by 2002:a05:620a:24ca:b0:76e:f0af:348c with SMTP id
 m10-20020a05620a24ca00b0076ef0af348cmr3896772qkn.65.1694835046050; 
 Fri, 15 Sep 2023 20:30:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/39] tcg: Add tcg_out_tb_start backend hook
Date: Fri, 15 Sep 2023 20:30:08 -0700
Message-Id: <20230916033011.479144-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

This hook may emit code at the beginning of the TB.

Suggested-by: Jordan Niethe <jniethe5@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index e81e8936d6..604fa9bf3e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -108,6 +108,7 @@ static void tcg_register_jit_int(const void *buf, size_t size,
     __attribute__((unused));
 
 /* Forward declarations for functions declared and used in tcg-target.c.inc. */
+static void tcg_out_tb_start(TCGContext *s);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -6014,6 +6015,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->gen_insn_data =
         tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
 
+    tcg_out_tb_start(s);
+
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a1e2b6be16..a0b65029d4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3135,6 +3135,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index 76f1345002..b1d56362a7 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2962,6 +2962,11 @@ static void tcg_out_epilogue(TCGContext *s)
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
index aed91e515e..4e47151241 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4191,6 +4191,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index 44682101fc..e08927889f 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2300,6 +2300,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index c6662889f0..f52bda4828 100644
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
index ccf245191d..90d76c2c2c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2527,6 +2527,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index 3bd7959e7e..c2bcdea33f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2099,6 +2099,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index f4d3abcb71..7552f63a05 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3483,6 +3483,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index 6b9be4c520..01ac26c192 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -962,6 +962,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
index 1dbb4b087e..461f4b47ff 100644
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


