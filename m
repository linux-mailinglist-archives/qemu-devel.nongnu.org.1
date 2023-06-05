Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196F17230F2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcQ-0001ku-Ds; Mon, 05 Jun 2023 16:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcN-0001jk-6Z
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcL-0003hV-Di
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so1323077b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996152; x=1688588152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn9Tf0IYWBrZfMOrfRS/Ef1buY3fjYVKvOc76GeHvCA=;
 b=KCrV7zhJ+UOYsowtRaEFl85GmaY1xbIKl/A+DaW372OWXJHu9syEE5cws43Uv/EFf/
 pScFA+p4+Ns51B0GR98VMgXTDPTN0uPMdEhCncwBgWxJSDp/B+4dWueyPov7NRzLnfRo
 xi9694V4X1vArQl5/qXOpPXJlnB6SuQzBlHOniAsilNyhC+4xp8EW++1OB8xetLEAjTz
 Utu8y8QSKnWHG0HUnMwy413UlI/tGiBgfyGeaqYgu1N30IUnZeeI0ud2mBRuO+7f4uOG
 uqQIGDkyC3dMERDYoEIp3wCOXyZqZMF8SduAvdZUq2B9Z8z/QG5Agj3zVT007knHXmUo
 6OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996152; x=1688588152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn9Tf0IYWBrZfMOrfRS/Ef1buY3fjYVKvOc76GeHvCA=;
 b=dNAQh6OtUFltJS1Npk2q8m0y5mrPoEJyJ2pp00vGJ0dmoBV+kwb2QxDLyoSBy8IFuv
 ZgGjXO75UElpT+lO2hUqvN3WpHhV5kyzT5moeqQToqdKykMuvIEWwQYQonUM0as9YDXC
 faY80t6YnAet0m/8PvkukfdnhEQ+/fRUjBXLJDLfy9jYXbZrlym3hpRkhjwy7aw1A0Zx
 CUMgqAkE9mkVo3YPQlegsOtXgfRXFtZaaCw+zceQVr4itkaKedz9sIijNtElVu2q0/mD
 +AXJzotsSWJpEHa+ZC/yPgSwGkdosTWNzfQakt/YTrXC3LmrxB5vITiupF2NgGsW6W8D
 qQxQ==
X-Gm-Message-State: AC+VfDzQSdII1TWGRc+BRyodyC/2u/J/i2zogKQ+psr0OfIcZpZRAfc2
 KK/5msT7G8mN0bVoJsMcrSIpS9GSSAUN2CMX0Aw=
X-Google-Smtp-Source: ACHHUZ54srxioVCk+P5+Z1WR3TkxSOWPRhRDMR+nYrxf9B6TxXsSHHjQnogimjxpxbnvCMeX0qp39A==
X-Received: by 2002:a05:6a00:850:b0:653:b76d:4d62 with SMTP id
 q16-20020a056a00085000b00653b76d4d62mr1029119pfk.24.1685996151923; 
 Mon, 05 Jun 2023 13:15:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 01/52] tcg/ppc: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Mon,  5 Jun 2023 13:14:57 -0700
Message-Id: <20230605201548.1596865-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
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


