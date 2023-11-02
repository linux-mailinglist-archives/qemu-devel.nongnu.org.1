Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DB7DEA43
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:41:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeP-0006K6-Om; Wed, 01 Nov 2023 21:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeG-0005xd-JV
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeE-0004IH-Vm
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so493501b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889045; x=1699493845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7+4SBqNUCdb83UyaUX4TiYteHeHosFCPYbW+VU+89Y=;
 b=sBOWiJ2GnrUePOmASQ6Xa3iFuugnWMczNPDwjwyqQWEgjE2Uveu1sKrGzbDFUDh2O9
 xIWLI0m+HUONXIIlFDQKW89k9r2O8w0FX6TLkP5R+Xgw0z9U5jHkHRwSjmSMjOq5gbtU
 jwEWAYhR1WOZMbSUvfuPmF1lLglH3rzK6VJSSnL4uwimIOgSU7QZEKcu1Skiiny5QeSe
 rvPXXxpZN5ViRyOqFywkWb6oWOgvzJopqT6pnFIvg68uHvG53T0fDXgdZ0JJU32vydi8
 J2epGxPuHu2MXjjRI7d6KIlHruY4KWNKT+0dYwRGJ7OkCftbN4051zDWSdDIX/Zixnr3
 rYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889045; x=1699493845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7+4SBqNUCdb83UyaUX4TiYteHeHosFCPYbW+VU+89Y=;
 b=OSaIsyZlACIDpIiiF3VYDCSSNvWMVVq9pBboWDQhhz3H8dDp+rvDTnYWKudJFZbI9f
 pkDiVSYxWeFMKiR51Bwo4/iBr/mcr4vZhqjqIN5JVsVYgBLWY8V3eN+NIDqvHRSR2uy1
 XzI/ZAz6CyqY/87jmTQkTuQOB05+KVxOyfwVxYI8pqdwzbEb0R6VhkLE3AvpB75AXl7z
 e60hI/cAPHH9zrml8vfedHrDQeh9rHKt4s15EHymP8038DCtZltLpqL1w2Jn8zxewJ25
 OJvqs9xqaWW7ImLb5AaGhBz28Rm0/yQk/lyzIHuelbyulJm2QeI/1/B5R/Of7CD/BKI2
 bTvA==
X-Gm-Message-State: AOJu0Yzrsmyvo6PTZsEoZcxeV5q4WGLPUBHBWjqHLUsQ8AY7vtOMJoIx
 SCQTiItqdDByOXlHzs03IFde6i7I8Zb3kLWnxZY=
X-Google-Smtp-Source: AGHT+IEuDoHy4nQ6MDU5KNuT2lAxSS/eAir0t5Ft/8bRwUq+vfx9gN8EzQdwlWk0eOFDNV3DAjomTw==
X-Received: by 2002:a05:6a21:27a4:b0:170:3e5b:bccd with SMTP id
 rn36-20020a056a2127a400b001703e5bbccdmr14877986pzb.30.1698889045602; 
 Wed, 01 Nov 2023 18:37:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 80/88] target/hppa: Add unwind_breg to CPUHPPAState
Date: Wed,  1 Nov 2023 18:30:08 -0700
Message-Id: <20231102013016.369010-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Fill in the insn_start value during form_gva, and copy
it out to the env field in hppa_restore_state_to_opc.
The value is not yet consumed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  8 +++++++-
 target/hppa/cpu.c       |  1 +
 target/hppa/translate.c | 13 ++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ea8e7e99a4..144794d089 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -45,7 +45,7 @@
 #define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
 #define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 /* No need to flush MMU_PHYS_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
@@ -208,6 +208,12 @@ typedef struct CPUArchState {
     target_ulong cr_back[2]; /* back of cr17/cr18 */
     target_ulong shadow[7];  /* shadow registers */
 
+    /*
+     * During unwind of a memory insn, the base register of the address.
+     * This is used to construct CR_IOR for pa2.0.
+     */
+    uint32_t unwind_breg;
+
     /*
      * ??? The number of entries isn't specified by the architecture.
      * BTLBs are not supported in 64-bit machines.
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e1597ba8a5..04de1689d7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -80,6 +80,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     if (data[1] != (target_ulong)-1) {
         cpu->env.iaoq_b = data[1];
     }
+    cpu->env.unwind_breg = data[2];
     /*
      * Since we were executing the instruction at IAOQ_F, and took some
      * sort of action that provoked the cpu_restore_state, we can infer
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f7621590e4..27846f5ad8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,6 +44,7 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
+    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -234,6 +235,13 @@ void hppa_translate_init(void)
                                         "iasq_b");
 }
 
+static void set_insn_breg(DisasContext *ctx, int breg)
+{
+    assert(ctx->insn_start != NULL);
+    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
+    ctx->insn_start = NULL;
+}
+
 static DisasCond cond_make_f(void)
 {
     return (DisasCond){
@@ -1324,6 +1332,8 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     TCGv_i64 ofs;
     TCGv_i64 addr;
 
+    set_insn_breg(ctx, rb);
+
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
         ofs = tcg_temp_new_i64();
@@ -4455,7 +4465,8 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b);
+    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
+    ctx->insn_start = tcg_last_op();
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


