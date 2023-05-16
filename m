Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272A705832
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eP-0002n5-SF; Tue, 16 May 2023 15:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cR-0000c3-34
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cM-0003ow-OC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae3fe67980so563475ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266353; x=1686858353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv7aBG6T/iJWBmCYMVKJpJUKFqeiGo5/e+UXaZWl6U0=;
 b=tKK0GAoYr52eB7yUdHDrZ31V21SVwutf1PdSBBz/6ITg9FgCuN754YODfhKj0yl6vv
 Sf1/lu7ZmrfHM7vc19zcPDgopWHnt0zQL1dgXzMAUt82ARQxF57m3ntjqi50X5rmLe83
 RYIC9K2oYLkcVJFssmKKccbWXLF1jqgCHuv0NiaaLgWBCLQDsHSeZfEEq5j1haTXzGmz
 JM2DSIsXV9p7vtDIyh4GkHOPhA23fqiAy9Ep0NtwDJGCIDpBEO7Yg/yfg9/rD+zkhpOS
 hMW3ZXcn2kvjZXY+8Yj5r3X7dI5U83wE/dk31h1hX7HLrHGAtGoKxAYBUIami9Dia4Cr
 Pbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266353; x=1686858353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv7aBG6T/iJWBmCYMVKJpJUKFqeiGo5/e+UXaZWl6U0=;
 b=dJVX5oa+BIeRwnndG7u+mDiFHR1pGmGi9qxToaOD1bCrjRBrv0HeubOwCaik4eC8eB
 U9TlS7kD4sC83O2QNdzo4reaRdkFBUi+9YNzCo5Gl8vISqX0SM94iBLr/b6ta9/AuXwj
 WitltBJqN8BY/W1ysBBbYqrlkMS4iURiowpV6FLVIdrcBS0JfsbYHZBbEochwuBXuQL5
 Rn3Tyn+74tPHZ1nrpES4zwQrTADI7sLnw329862D4k9hAo/ZTbCZlGlvzVlRwZrf03iG
 7DAY/jD2JdNkfFeTJN23poiZMYSzfyXT5tq7s6sR52LoK+P+jmC5yUMD56cXSqZtBE/Q
 W5oA==
X-Gm-Message-State: AC+VfDyP+Kscjitiq0msDglumOps/PPAMgPWeQaoRkLzDZEAN/uQotda
 kdCePjDLnoUgynXQKGebxR8fg1Gs3+AxYC6wBKI=
X-Google-Smtp-Source: ACHHUZ7nKVeKk7XlTEtKYjmRYxYiNMpHMUDzqoNO7LYrDf7WwL1wb901HmjnkOYNWWXSvlHuBYQakA==
X-Received: by 2002:a17:902:ce91:b0:1ad:c1c2:7d1a with SMTP id
 f17-20020a170902ce9100b001adc1c27d1amr27070824plg.63.1684266353337; 
 Tue, 16 May 2023 12:45:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 76/80] tcg/mips: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 16 May 2023 12:41:41 -0700
Message-Id: <20230516194145.1749305-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

All uses replaced with TCGContext.addr_type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 7ff4e2ff71..209d95992e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -354,10 +354,6 @@ typedef enum {
     /* Aliases for convenience.  */
     ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
     ALIAS_PADDI    = sizeof(void *) == 4 ? OPC_ADDIU : OPC_DADDIU,
-    ALIAS_TSRL     = TARGET_LONG_BITS == 32 || TCG_TARGET_REG_BITS == 32
-                     ? OPC_SRL : OPC_DSRL,
-    ALIAS_TADDI    = TARGET_LONG_BITS == 32 || TCG_TARGET_REG_BITS == 32
-                     ? OPC_ADDIU : OPC_DADDIU,
 } MIPSInsn;
 
 /*
@@ -1156,6 +1152,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addrlo, TCGReg addrhi,
                                            MemOpIdx oi, bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp a_bits;
@@ -1190,23 +1187,26 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
 
     /* Extract the TLB index from the address into TMP3.  */
-    tcg_out_opc_sa(s, ALIAS_TSRL, TCG_TMP3, addrlo,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+    if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+        tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addrlo,
+                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+    } else {
+        tcg_out_dsrl(s, TCG_TMP3, addrlo,
+                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+    }
     tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
     /* Add the tlb_table pointer, creating the CPUTLBEntry address in TMP3.  */
     tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
-    /* Load the (low-half) tlb comparator.  */
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + LO_OFF);
-    } else {
-        tcg_out_ld(s, TCG_TYPE_TL, TCG_TMP0, TCG_TMP3, cmp_off);
-    }
-
-    if (TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
+        /* Load the tlb comparator.  */
+        tcg_out_ld(s, addr_type, TCG_TMP0, TCG_TMP3, cmp_off);
         /* Load the tlb addend for the fast path.  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
+    } else {
+        /* Load the low half of the tlb comparator.  */
+        tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + LO_OFF);
     }
 
     /*
@@ -1214,16 +1214,20 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * For unaligned accesses, compare against the end of the access to
      * verify that it does not cross a page boundary.
      */
-    tcg_out_movi(s, TCG_TYPE_TL, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
+    tcg_out_movi(s, addr_type, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
     if (a_mask < s_mask) {
-        tcg_out_opc_imm(s, ALIAS_TADDI, TCG_TMP2, addrlo, s_mask - a_mask);
+        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+            tcg_out_opc_imm(s, OPC_ADDIU, TCG_TMP2, addrlo, s_mask - a_mask);
+        } else {
+            tcg_out_opc_imm(s, OPC_DADDIU, TCG_TMP2, addrlo, s_mask - a_mask);
+        }
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
     } else {
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrlo);
     }
 
     /* Zero extend a 32-bit guest address for a 64-bit host. */
-    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_TMP2, addrlo);
         addrlo = TCG_TMP2;
     }
@@ -1232,7 +1236,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_opc_br(s, OPC_BNE, TCG_TMP1, TCG_TMP0);
 
     /* Load and test the high half tlb comparator.  */
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
         /* delay slot */
         tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + HI_OFF);
 
@@ -1269,7 +1273,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     }
 
     base = addrlo;
-    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_REG_A0, base);
         base = TCG_REG_A0;
     }
-- 
2.34.1


