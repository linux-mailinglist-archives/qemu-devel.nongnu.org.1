Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036571136A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQN-0008SG-Jl; Thu, 25 May 2023 14:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQL-0008RH-Me
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQJ-0005w2-Tv
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae74ab3089so12554945ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038249; x=1687630249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWc5YT/KR4CLh9CR8/cWdv0j+LXdzlJlSOOvnC6xd4U=;
 b=wJSU917tGWHxS0CbewUrqLXMGsvhmpURabiEwjUpGsjSjGT4+Ihh68yilDg+4Q8pkT
 wCcLRKqqMcduIy2kSCAV7fN60ogk56/5psPVAl1f7sp5tugUHKvif2LIex+Zh3TF9Rbx
 MCpaTs95Ez2ZTdHlazIRQUJUXxG0BFyEx4ohsM9UKvBg0mxFryELggLbigR0FrDuIphl
 3huu2RjC2T0r/AIcZCMDq1Bc9YL739YNRbwlWPVwewR9dV1Gg+0wgK22gV1ppMUdwP2l
 vjLGh56aoLyj5DdK5zmP9TwdpPy4rI9Fg26N8gjMZI7yFcYwKIkw4MWn5v/GVbDBQD/z
 qM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038249; x=1687630249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWc5YT/KR4CLh9CR8/cWdv0j+LXdzlJlSOOvnC6xd4U=;
 b=adBxaEx1QW+2tO7yK8ZntCBGWj6uLlK9VGSMS7GML4c+D/tX5lFLVvU0W1yL8+mFFJ
 Jy8RFXbfiXSpKJBymvWR/Zu3n2q14O00nuBGQ3mWtp5tDQnmFsNxCABcXJqKu/6Q7tSn
 jorrPMl6fhMeLBOM0unjU7suOzDqO8NT4rZISG6pDlrdLGTSTE/UQz4ZSWWb2Mwz38UY
 Za7z3QTqxI6gQhvFSj5nja5WlQoezZFTP2FVehsXt2iQPqYG5VSEK8GhhJs+CHfl9L9B
 qPXAzBJf76aiHTk1V2x1aZoOwI+PFGqiGLKF9dHJd2b6HJmgmAmztMJ259lKH8FR+GPU
 C08A==
X-Gm-Message-State: AC+VfDzyI1MVYRhuIU3Fcb3kkY8pwIFTY808CbcO+xs0Hc1PISybalhC
 Ah8y5YCpHHMJh2f1cZylbV+RRP8kJVocWJgU2II=
X-Google-Smtp-Source: ACHHUZ4o/iQRlqA+nGxxFi7rZK5XIlL+bHIjC7d1QWQdwgWwevn3X1S/wPHkS3h05G1fW10Ruj33Tg==
X-Received: by 2002:a17:902:d48a:b0:1ac:8db3:d4e5 with SMTP id
 c10-20020a170902d48a00b001ac8db3d4e5mr2645611plg.69.1685038249590; 
 Thu, 25 May 2023 11:10:49 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 14/23] tcg/riscv: Probe for Zba, Zbb, Zicond extensions
Date: Thu, 25 May 2023 11:10:27 -0700
Message-Id: <20230525181036.1559435-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Define a useful subset of the extensions.  Probe for them
via compiler pre-processor feature macros and SIGILL.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  6 +++
 tcg/riscv/tcg-target.c.inc | 96 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 494c986b49..863ac8ba2f 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -90,6 +90,12 @@ typedef enum {
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
+#if defined(__riscv_arch_test) && defined(__riscv_zbb)
+# define have_zbb true
+#else
+extern bool have_zbb;
+#endif
+
 /* optional instructions */
 #define TCG_TARGET_HAS_movcond_i32      0
 #define TCG_TARGET_HAS_div_i32          1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ff6334980f..eb3e2e9eb0 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -113,6 +113,20 @@ static const int tcg_target_call_iarg_regs[] = {
     TCG_REG_A7,
 };
 
+#ifndef have_zbb
+bool have_zbb;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zba)
+# define have_zba true
+#else
+static bool have_zba;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zicond)
+# define have_zicond true
+#else
+static bool have_zicond;
+#endif
+
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 {
     tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
@@ -234,6 +248,34 @@ typedef enum {
 
     OPC_FENCE = 0x0000000f,
     OPC_NOP   = OPC_ADDI,   /* nop = addi r0,r0,0 */
+
+    /* Zba: Bit manipulation extension, address generation */
+    OPC_ADD_UW = 0x0800003b,
+
+    /* Zbb: Bit manipulation extension, basic bit manipulaton */
+    OPC_ANDN   = 0x40007033,
+    OPC_CLZ    = 0x60001013,
+    OPC_CLZW   = 0x6000101b,
+    OPC_CPOP   = 0x60201013,
+    OPC_CPOPW  = 0x6020101b,
+    OPC_CTZ    = 0x60101013,
+    OPC_CTZW   = 0x6010101b,
+    OPC_ORN    = 0x40006033,
+    OPC_REV8   = 0x6b805013,
+    OPC_ROL    = 0x60001033,
+    OPC_ROLW   = 0x6000103b,
+    OPC_ROR    = 0x60005033,
+    OPC_RORW   = 0x6000503b,
+    OPC_RORI   = 0x60005013,
+    OPC_RORIW  = 0x6000501b,
+    OPC_SEXT_B = 0x60401013,
+    OPC_SEXT_H = 0x60501013,
+    OPC_XNOR   = 0x40004033,
+    OPC_ZEXT_H = 0x0800403b,
+
+    /* Zicond: integer conditional operations */
+    OPC_CZERO_EQZ = 0x0e005033,
+    OPC_CZERO_NEZ = 0x0e007033,
 } RISCVInsn;
 
 /*
@@ -1619,8 +1661,62 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
 }
 
+static volatile sig_atomic_t got_sigill;
+
+static void sigill_handler(int signo, siginfo_t *si, void *data)
+{
+    /* Skip the faulty instruction */
+    ucontext_t *uc = (ucontext_t *)data;
+    uc->uc_mcontext.__gregs[REG_PC] += 4;
+
+    got_sigill = 1;
+}
+
+static void tcg_target_detect_isa(void)
+{
+#if !defined(have_zba) || !defined(have_zbb) || !defined(have_zicond)
+    /*
+     * TODO: It is expected that this will be determinable via
+     * linux riscv_hwprobe syscall, not yet merged.
+     * In the meantime, test via sigill.
+     */
+
+    struct sigaction sa_old, sa_new;
+
+    memset(&sa_new, 0, sizeof(sa_new));
+    sa_new.sa_flags = SA_SIGINFO;
+    sa_new.sa_sigaction = sigill_handler;
+    sigaction(SIGILL, &sa_new, &sa_old);
+
+#ifndef have_zba
+    /* Probe for Zba: add.uw zero,zero,zero. */
+    got_sigill = 0;
+    asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero" : : : "memory");
+    have_zba = !got_sigill;
+#endif
+
+#ifndef have_zbb
+    /* Probe for Zba: andn zero,zero,zero. */
+    got_sigill = 0;
+    asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero" : : : "memory");
+    have_zbb = !got_sigill;
+#endif
+
+#ifndef have_zicond
+    /* Probe for Zicond: czero.eqz zero,zero,zero. */
+    got_sigill = 0;
+    asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero" : : : "memory");
+    have_zicond = !got_sigill;
+#endif
+
+    sigaction(SIGILL, &sa_old, NULL);
+#endif
+}
+
 static void tcg_target_init(TCGContext *s)
 {
+    tcg_target_detect_isa();
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
-- 
2.34.1


