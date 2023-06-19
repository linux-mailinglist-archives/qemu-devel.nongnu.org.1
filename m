Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54787735987
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsi-0000Ze-Bj; Mon, 19 Jun 2023 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsg-0000Yy-MR
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFse-0002Ax-M5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9002a1a9bso33459135e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184959; x=1689776959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bu9xu6sgDL960caTpLR2VLDgZoGVO/M9+l0fW87QI0Y=;
 b=vJzuyE/j6PvhSdUc4dxjwMoZqQg5Ug7OBFChZhp8wBbCL61cH5DAtrp2cz3J7qHk3s
 02mmatn2fNmoo1da4u87cVH4aV1pinu/4SqR+ayQuANnPifrfx4ikBlZo5nYUH+l+Pqk
 7L88kbpoSj5M6Lh00rO7Ap+S4FxucdAUe4lQDtD4ZpHunw0FvfzpnaLmoCdHhpQZmbTi
 8IQtTQjPQ92IKy0EqCKpI3ab8yDrAADzqcZWsXx+axlsRNy5n4ovdGdnKov6aPamQWZO
 QtNBU9aAOaTgJGOcVBvy/ZKACXiUO16z54LXE0iAkigpexQrJgsCWoSY53Iym/eKxkBM
 EMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184959; x=1689776959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bu9xu6sgDL960caTpLR2VLDgZoGVO/M9+l0fW87QI0Y=;
 b=UhvbzQQJYJ1IpZazhgJbCA8f/HTB4uzcq1SbsRXpqgeHyJeNHoFZiiXkGLSH/8TqiG
 MUD9aiiRo3Z9CooQEYOsZAR3CmiXezXT+sBOt0+syw/2iXehV1nIj4UGpA/+2PR8FELR
 /ficPRzwm6P9XwYxgeL/0LGKBNHJmCdjrrOyLmBoBtgzFwB9Oei0dfekSU7m3LlTXLfO
 HDngFtYqWOQqKs0Qowcke6MYLpAl+EfhuzZfgDyOmA8tsUtayzenX+HTicChbcUZoaxL
 jbvG1HbWympwBUmGrcB4gVfhk+77TdSN4KhFPJb7k7VbFo9OIc44Sfvr3KfOIzV07wKL
 ornA==
X-Gm-Message-State: AC+VfDwk9Qa2t/uufQ/Vu38omhXPC2Zdtlk7c3jhkMQeeL+2+C4416QS
 JEBqNEA+Rj4cQ97iOtF3BVMNqtN3ZusHjb3TC78=
X-Google-Smtp-Source: ACHHUZ6N93mCXCndo1ax5X/sWZur8bmB77Am9LbnVrq1DjrJ8yzw31kX1/Y/YHcy4AljpYjlHY323Q==
X-Received: by 2002:a1c:770a:0:b0:3f9:c04:e76c with SMTP id
 t10-20020a1c770a000000b003f90c04e76cmr3541339wmi.28.1687184958987; 
 Mon, 19 Jun 2023 07:29:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] target/arm: Convert barrier insns to decodetree
Date: Mon, 19 Jun 2023 15:28:47 +0100
Message-Id: <20230619142914.963184-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Convert the insns in the "Barriers" instruction class to
decodetree: CLREX, DSB, DMB, ISB and SB.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-4-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 +++
 target/arm/tcg/translate-a64.c | 92 ++++++++++++++--------------------
 2 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1efd436e175..b3608d38dc9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -181,3 +181,10 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
   # that isn't specifically allocated to an instruction must NOP
   NOP           1101 0101 0000 0011 0010 ---- --- 11111
 }
+
+# Barriers
+
+CLREX           1101 0101 0000 0011 0011 ---- 010 11111
+DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
+ISB             1101 0101 0000 0011 0011 ---- 110 11111
+SB              1101 0101 0000 0011 0011 0000 111 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index eb8addac1b3..088dfd8b1fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1812,67 +1812,56 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
-static void gen_clrex(DisasContext *s, uint32_t insn)
+static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
+    return true;
 }
 
-/* CLREX, DSB, DMB, ISB */
-static void handle_sync(DisasContext *s, uint32_t insn,
-                        unsigned int op1, unsigned int op2, unsigned int crm)
+static bool trans_DSB_DMB(DisasContext *s, arg_DSB_DMB *a)
 {
+    /* We handle DSB and DMB the same way */
     TCGBar bar;
 
-    if (op1 != 3) {
-        unallocated_encoding(s);
-        return;
+    switch (a->types) {
+    case 1: /* MBReqTypes_Reads */
+        bar = TCG_BAR_SC | TCG_MO_LD_LD | TCG_MO_LD_ST;
+        break;
+    case 2: /* MBReqTypes_Writes */
+        bar = TCG_BAR_SC | TCG_MO_ST_ST;
+        break;
+    default: /* MBReqTypes_All */
+        bar = TCG_BAR_SC | TCG_MO_ALL;
+        break;
     }
+    tcg_gen_mb(bar);
+    return true;
+}
 
-    switch (op2) {
-    case 2: /* CLREX */
-        gen_clrex(s, insn);
-        return;
-    case 4: /* DSB */
-    case 5: /* DMB */
-        switch (crm & 3) {
-        case 1: /* MBReqTypes_Reads */
-            bar = TCG_BAR_SC | TCG_MO_LD_LD | TCG_MO_LD_ST;
-            break;
-        case 2: /* MBReqTypes_Writes */
-            bar = TCG_BAR_SC | TCG_MO_ST_ST;
-            break;
-        default: /* MBReqTypes_All */
-            bar = TCG_BAR_SC | TCG_MO_ALL;
-            break;
-        }
-        tcg_gen_mb(bar);
-        return;
-    case 6: /* ISB */
-        /* We need to break the TB after this insn to execute
-         * a self-modified code correctly and also to take
-         * any pending interrupts immediately.
-         */
-        reset_btype(s);
-        gen_goto_tb(s, 0, 4);
-        return;
+static bool trans_ISB(DisasContext *s, arg_ISB *a)
+{
+    /*
+     * We need to break the TB after this insn to execute
+     * self-modifying code correctly and also to take
+     * any pending interrupts immediately.
+     */
+    reset_btype(s);
+    gen_goto_tb(s, 0, 4);
+    return true;
+}
 
-    case 7: /* SB */
-        if (crm != 0 || !dc_isar_feature(aa64_sb, s)) {
-            goto do_unallocated;
-        }
-        /*
-         * TODO: There is no speculation barrier opcode for TCG;
-         * MB and end the TB instead.
-         */
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-        gen_goto_tb(s, 0, 4);
-        return;
-
-    default:
-    do_unallocated:
-        unallocated_encoding(s);
-        return;
+static bool trans_SB(DisasContext *s, arg_SB *a)
+{
+    if (!dc_isar_feature(aa64_sb, s)) {
+        return false;
     }
+    /*
+     * TODO: There is no speculation barrier opcode for TCG;
+     * MB and end the TB instead.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    gen_goto_tb(s, 0, 4);
+    return true;
 }
 
 static void gen_xaflag(void)
@@ -2336,9 +2325,6 @@ static void disas_system(DisasContext *s, uint32_t insn)
             return;
         }
         switch (crn) {
-        case 3: /* CLREX, DSB, DMB, ISB */
-            handle_sync(s, insn, op1, op2, crm);
-            break;
         case 4: /* MSR (immediate) */
             handle_msr_i(s, insn, op1, op2, crm);
             break;
-- 
2.34.1


