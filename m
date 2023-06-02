Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B987206A1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574r-000385-Fm; Fri, 02 Jun 2023 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574p-00036H-5P
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574n-0003R5-57
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af20f5f67so2189862f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721148; x=1688313148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJsYRyAUxIkV2ASeZSYE7316GaNRhskisUjyxHNbJ/0=;
 b=X48/ayCXX2rgr8zxCAUTn2mQGQv2Ks46zXRxQNvKT0jNuALaXUrrr4Exd18SPe+Xt/
 wftL/o8Og9X+nHEEPxhLrH9EMpwjsZ8yhZAITV/kj6CcxaFKrbpTge69n2W6gkhXw6El
 jZcsl/ItEA/lLaO9lsg52ho2Fvmk9kGvrCUa8N/ii3WQEAArvEvlFgCqL8L0IOfEOdv+
 zcsKQCaemBKpfQVtHoPt3lvRAejH5OWxsJp4m4pl6Y65swzTabbRF15yI8L4SWdgNxp7
 96+3FA8Si/nHwQ9xhEthMihY1ELoc1e1RF7G6KJVI95Oybx9C3vZGXWcR6WjUdbSYfHi
 LD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721148; x=1688313148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJsYRyAUxIkV2ASeZSYE7316GaNRhskisUjyxHNbJ/0=;
 b=MYJJ+oquqMWEpwusvkIL/xG7JiymMEsGffjUQa29l2FRclWoaPSKKhqw7ICK8dhiuH
 RklSD/v4l12pm/3WVdN0vR0skrhjGpvKcXywh0oro4IsUAjJYR1lKzmYPBgMDXiiiVOk
 +pp9RQlsmF3mktkmV8fyFbOwRke1J6g3PTBLzW6z7hLV3euUKOguJEwcDGXetiGVc6Bp
 OO0+IYucnsMQj0o6V8vsqnGiC/ZSkyrq/LPIHQ7w9qS3QUoPQwJJw6ybKl+YVTJ9Yj0J
 qRV3/dTTeHb2tVtnpzUo2Rnog//IB0f5jcyw/jqE+1wZDNQTAwyABme7JgrsNJXXhQHF
 ciLw==
X-Gm-Message-State: AC+VfDyJ57nG7GIoahVjRkF8dyqDp7OCDOXspX5jb6z1IHr8E7sMUfQW
 UkYDhRZi+KuyOd8YJD60WlKaIg==
X-Google-Smtp-Source: ACHHUZ4xX58YPeRvW3lIytRYDAm7IaiMKeCUi6hZGrcHqeyn6M1tA8UMCGnN1WpcXm5IMJhQJfo8Qg==
X-Received: by 2002:adf:dc01:0:b0:2f6:ca0d:ec1c with SMTP id
 t1-20020adfdc01000000b002f6ca0dec1cmr347284wri.10.1685721147779; 
 Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/20] target/arm: Convert barrier insns to decodetree
Date: Fri,  2 Jun 2023 16:52:06 +0100
Message-Id: <20230602155223.2040685-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
---
 target/arm/tcg/a64.decode      |  7 +++
 target/arm/tcg/translate-a64.c | 92 ++++++++++++++--------------------
 2 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1efd436e175..553f6904d9c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -181,3 +181,10 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
   # that isn't specifically allocated to an instruction must NOP
   NOP           1101 0101 0000 0011 0010 ---- --- 11111
 }
+
+# Barriers
+
+CLREX           1101 0101 0000 0011 0011 imm:4 010 11111
+DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
+ISB             1101 0101 0000 0011 0011 imm:4 110 11111
+SB              1101 0101 0000 0011 0011 0000 111 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecc4b9c1bd3..09258a9854f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1757,67 +1757,56 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
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
@@ -2280,9 +2269,6 @@ static void disas_system(DisasContext *s, uint32_t insn)
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


