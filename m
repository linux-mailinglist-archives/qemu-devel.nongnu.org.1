Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636207174AE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3j-0006p6-Hs; Wed, 31 May 2023 00:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3f-0006ny-Nj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:35 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3d-00068p-TC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:35 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-19f30256921so3671710fac.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505812; x=1688097812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9qMq1Kc96zeFRo1KsNqPrim3yydQz0TamMazqOZr8KI=;
 b=lG0ShfufD9vwx4YfPm5dDDIvYgr3lqXa0lYW8qP0s0baUOoqYkSSToUbWT/MQDJvKJ
 +t60tljYu78qE9QaFlRGZG2Mq3oyU//+TLimHVUGYaGOKvK7V3JfbWpxdNxSK9d3Vv6q
 klhFK2nJhDs2C8JJvKt4okv9SkwB6msCXeF4NosPEsAiU20wju30tCgfrVZGnFgMg8X+
 d+YJcQ+QOmm+NUFANONJedegQVS9O0gO054dQiFuwGbvATQbPX3Sa6hOvfLupTpXNzRm
 U/IPZC7fCNFRJrbjWqvZ46deUlgXWckTh3xnbPTWRA7vbOkA+PeahvD1rcKiV+BjCXLe
 3XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505812; x=1688097812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qMq1Kc96zeFRo1KsNqPrim3yydQz0TamMazqOZr8KI=;
 b=Lk4OQl2jhKtMdr+t3i5LoxhWw92SJFHrUc448RnMvo8T4CRL5jw7iccgvox3kLk2g7
 4jHlLRJF2xeMydnElhuoh6rdPr/q50agLTc0VRyb/Q6525CRdeMJ6rT9AX5CAYvMw5lI
 RWn7D5YXZk8dHI/QxHvUN6j8ogy8aqD/wqS4BU1EuJpq0JKzz7WEM9tI4d8b+ua9kR/D
 D3L/l64zWGnz3lJKJanZoqGsNCqa4bnOR9ua9KgAbuZV/ZVoj8AXIsJHAInw55kkeTT0
 TooR1gUGVjmtApvvurqGB6FGQwFzUmaQLs6N32odZzDfnAfZ0iOr9X93epLoxTnYNPl9
 QYng==
X-Gm-Message-State: AC+VfDw9b5Y+HW97NunVyVYUiItq5ZB0gx2S52dzdlxcZQ34KfEVRVr3
 3BvRYk6a0Jymok5Sme/P1XiTIjihw+ZKo+GnM9A=
X-Google-Smtp-Source: ACHHUZ5mg9ae2lYe4UEu7KdKG+fxV0SQVmgjN4Twdk19k36bugqINJXTRQ0pgDG0+ZuisYvfDH+qVg==
X-Received: by 2002:a05:6870:73c4:b0:19f:adb4:16a9 with SMTP id
 a4-20020a05687073c400b0019fadb416a9mr873963oan.35.1685505812193; 
 Tue, 30 May 2023 21:03:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/48] tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 30 May 2023 21:02:43 -0700
Message-Id: <20230531040330.8950-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index d47a9e3478..11955a6cc2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2046,6 +2046,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addrlo, TCGReg addrhi,
                                            MemOpIdx oi, bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp a_bits, s_bits;
@@ -2098,17 +2099,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
     /* Load the (low part) TLB comparator into TMP2.  */
-    if (cmp_off == 0 && TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
-        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || TARGET_LONG_BITS == 32
+    if (cmp_off == 0
+        && (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32)) {
+        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32
                         ? LWZUX : LDUX);
         tcg_out32(s, lxu | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
     } else {
         tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-        if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
             tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2,
                        TCG_REG_TMP1, cmp_off + 4 * HOST_BIG_ENDIAN);
         } else {
-            tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
+            tcg_out_ld(s, addr_type, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
         }
     }
 
@@ -2116,7 +2118,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * Load the TLB addend for use on the fast path.
      * Do this asap to minimize any load use delay.
      */
-    if (TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
                    offsetof(CPUTLBEntry, addend));
     }
@@ -2151,7 +2153,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         /* Mask the address for the requested alignment.  */
-        if (TARGET_LONG_BITS == 32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
                         (32 - a_bits) & 31, 31 - s->page_bits);
         } else if (a_bits == 0) {
@@ -2163,7 +2165,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
     }
 
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
         /* Low part comparison into cr7. */
         tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
                     0, 7, TCG_TYPE_I32);
@@ -2183,8 +2185,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
     } else {
         /* Full comparison into cr7. */
-        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                    0, 7, TCG_TYPE_TL);
+        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2, 0, 7, addr_type);
     }
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
@@ -2211,7 +2212,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->base = guest_base ? TCG_GUEST_BASE_REG : 0;
 #endif
 
-    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
         tcg_out_ext32u(s, TCG_REG_R0, addrlo);
         h->index = TCG_REG_R0;
-- 
2.34.1


