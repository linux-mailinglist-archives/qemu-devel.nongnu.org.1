Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657A705837
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0c6-0008Ox-PZ; Tue, 16 May 2023 15:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bu-0008Hy-K0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:26 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bs-0003eh-Ph
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:26 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-52079a12451so10506643a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266323; x=1686858323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qqlVmOWLkkD4N0TUKCkau5U1AXPhMOrCn0VUAaOFSs=;
 b=VMVhWe/JxWeftGcUftozwAjFobVowe+43QdO1ZTTHJ2HPAjNtEwuSw+kQhWhOiV6Lk
 7+xw86dRuXgtLwfuWtOlszi74mZjyl9uKeaB12jO18IXy7ysfyNqEAVhfPuSuPjus1qW
 rk/qoyQp1Xzoy3DfjR+lSdqzlDGHlTzZhg2Vnqcex68Y/oD5dl4ChYGQU/L+AmYnLzL6
 PSzn/qoIJ3wkkq85UkVxEwF28IV92xg6iDplbLP2iX7hw/pLEPGM6m8FWSxEHR6vt8yj
 FZ53Id4SHU2Sf1dyLkWXxkivh77CzJhe/+/dvMF6MR/HbabnA6toaVLBUSXFledZ5Rqg
 kQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266323; x=1686858323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qqlVmOWLkkD4N0TUKCkau5U1AXPhMOrCn0VUAaOFSs=;
 b=XF9V9U+W5GbkAyCZ6eAkipEY/QP+5z9QR7ylY2ESXNBbZPoZfl6G5kN5h/gO905Egk
 kcs4ojOm9VZ6U5etCioFxKYVy1cUOUcWn8MtPt9bFKQ4Z780fCM5tDavjhjbLPhlVmB1
 q/OfXtYD9IE8e/PLj6Pb9jNSMnU/CwZ9Gnk/ClT5Y+AcUyozzSQ7yJdcPQyCkqQncfi3
 EhVGKnRlv0Sh4UgW7oOShPM8BlMIxqXHySOKCefExhXNArcqhLdUAFirqp9au3fGLv0B
 twviXhSECAcMEVw+NnoAXyqNliVutKeFuu+j2zBosBVQ+8Xb31t6EUuKbXgvV6hq2+KK
 5oCw==
X-Gm-Message-State: AC+VfDzIW5uoXe1RLJzOV7hyxBLQvVlO/XNC3CvePFuqcPFlVUwBs9vk
 302gdZqky99zc6dnWuCDL+uh21nkJ/GJxVCcnaQ=
X-Google-Smtp-Source: ACHHUZ61hRTDqMjMaSFU83+DOYTQ1e+9AfykTgoYKgbhLAxHnQc6y2N/QwUYZ7oh/syJo+YD6mwSnA==
X-Received: by 2002:a17:90a:e68b:b0:250:8f09:75f2 with SMTP id
 s11-20020a17090ae68b00b002508f0975f2mr28857460pjy.22.1684266323347; 
 Tue, 16 May 2023 12:45:23 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 40/80] tcg/arm: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:05 -0700
Message-Id: <20230516194145.1749305-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

No change to the ultimate load/store routines yet, so some atomicity
conditions not yet honored, but plumbs the change to alignment through
the relevant functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index e5aed03247..add8cc1fd5 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1323,6 +1323,7 @@ typedef struct {
     TCGReg base;
     int index;
     bool index_scratch;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -1379,8 +1380,26 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    MemOp a_bits = get_alignment_bits(opc);
-    unsigned a_mask = (1 << a_bits) - 1;
+    unsigned a_mask;
+
+#ifdef CONFIG_SOFTMMU
+    *h = (HostAddress){
+        .cond = COND_AL,
+        .base = addrlo,
+        .index = TCG_REG_R1,
+        .index_scratch = true,
+    };
+#else
+    *h = (HostAddress){
+        .cond = COND_AL,
+        .base = addrlo,
+        .index = guest_base ? TCG_REG_GUEST_BASE : -1,
+        .index_scratch = false,
+    };
+#endif
+
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1 << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
     int mem_index = get_mmuidx(oi);
@@ -1469,13 +1488,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     if (TARGET_LONG_BITS == 64) {
         tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
     }
-
-    *h = (HostAddress){
-        .cond = COND_AL,
-        .base = addrlo,
-        .index = TCG_REG_R1,
-        .index_scratch = true,
-    };
 #else
     if (a_mask) {
         ldst = new_ldst_label(s);
@@ -1484,18 +1496,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        /* We are expecting a_bits to max out at 7 */
+        /* We are expecting alignment to max out at 7 */
         tcg_debug_assert(a_mask <= 0xff);
         /* tst addr, #mask */
         tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
     }
-
-    *h = (HostAddress){
-        .cond = COND_AL,
-        .base = addrlo,
-        .index = guest_base ? TCG_REG_GUEST_BASE : -1,
-        .index_scratch = false,
-    };
 #endif
 
     return ldst;
-- 
2.34.1


